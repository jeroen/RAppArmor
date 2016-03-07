context("affinity")
test_that("Affinity behavior", {

	#before
	all <- getaffinity();
	count <- getaffinity_count();
	expect_that(ncores(), equals(count))

	#set
	setaffinity(1);
	expect_that(getaffinity(), equals(1))
	expect_that(getaffinity_count(), equals(1))

	#reset
	setaffinity();
	expect_that(getaffinity(), equals(all))
	expect_that(getaffinity_count(), equals(count))
});


#We assume at least two cores to test this
test_that("Affinity works", {

	testfun <- function(){
		x <- matrix(rnorm(5e5), 1e3);
		parallel::mcparallel(svd(x))
		parallel::mcparallel(svd(x))
		parallel::mcparallel(svd(x))
		parallel::mcparallel(svd(x))
		return(parallel::mccollect())
	}

	#We should see approx 2x speed gain, but lets be conservative and require at least 1.2.
	setaffinity();
	if(getaffinity_count() > 1){
		expect_that(out1 <- system.time(eval.secure(testfun(), affinity=1)), is_a("proc_time"));
		expect_that(out2 <- system.time(eval.secure(testfun())), is_a("proc_time"));
		expect_that(unname(out1["elapsed"] > out2["elapsed"]*1.5), is_true());
	}
});

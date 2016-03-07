context("cpu limits")

testfun <- function(){
	Sys.sleep(1);
	repeat{
		svd(matrix(rnorm(1e6,1e3)));
	}
};

#timeout also counts idle time
test_that("Timeout terminates process timely.", {
	out <- system.time(try(eval.secure(testfun(), timeout=2), silent=TRUE));
	expect_that(unname(out["elapsed"]) < 2.5, is_true())
	rm(out)
});

test_that("Timeout throws error", {
	expect_that(eval.secure(testfun(), timeout=1), throws_error("Terminating process"))
});

#rlimit_cpu does not count idle time, but after 5 sec it should be done usually
test_that("RLIMIT_CPU terminates process timely.", {
	out <- system.time(try(eval.secure(testfun(), RLIMIT_CPU=2), silent=TRUE));
	expect_that(unname(out["elapsed"]) < 5, is_true())
	rm(out)
});

test_that("combine limit and cpu.", {
	out <- system.time(try(eval.secure(testfun(), timeout=2, RLIMIT_CPU=2), silent=TRUE));
	expect_that(unname(out["elapsed"]) < 2.5, is_true())
	rm(out)
});

test_that("Raising the limit should not be possible for non-root users", {
			
	#force non-root
	me <- ifelse(getuid() == 0, 1000, getuid());
	
	#test
	for(mylim in c(2, 2e1, 2e2, 2e3)){
		output <- list(hardlim = mylim/2, softlim = mylim/2);
		expect_that(eval.secure(rlimit_cpu(mylim*2), RLIMIT_CPU = mylim, uid=me), throws_error("privilege"));
		expect_that(eval.secure(rlimit_cpu(mylim/2), RLIMIT_CPU = mylim, uid=me), equals(output));	
		rm(output)
	}
});
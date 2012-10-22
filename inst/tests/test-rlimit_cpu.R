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
	expect_that(unname(abs(out["elapsed"] - 2) < 0.2), is_true())
	rm(out)
});

test_that("Timeout throws error", {
	expect_that(eval.secure(testfun(), timeout=1), throws_error("Terminating process"))
});

#rlimit_cpu does not count idle time
test_that("RLIMIT_CPU terminates process timely.", {
	out <- system.time(eval.secure(testfun(), RLIMIT_CPU=2));
	expect_that(unname(abs(out["elapsed"] - 3) < 0.2), is_true())
	rm(out)
});

test_that("combine limit and cpu.", {
	out <- system.time(try(eval.secure(testfun(), timeout=2, RLIMIT_CPU=2), silent=TRUE));
	expect_that(unname(abs(out["elapsed"] - 2) < 0.2), is_true())
	rm(out)
});

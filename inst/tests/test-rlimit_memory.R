context("memory limits")
test_that("Memory limits apply and do not have side effects", {
	expect_that(eval.secure(matrix(rnorm(1e6), 1e4)), is_a("matrix"))
	expect_that(eval.secure(matrix(rnorm(1e6), 1e4), RLIMIT_AS = 10*1024*1024), throws_error("cannot allocate"));
	expect_that(eval.secure(matrix(rnorm(1e6), 1e4)), is_a("matrix"))
	expect_that(eval.secure(matrix(rnorm(1e6), 1e4), RLIMIT_AS = 10*1024*1024), throws_error("cannot allocate"));
	expect_that(eval.secure(matrix(rnorm(1e6), 1e4)), is_a("matrix"))
	expect_that(eval.secure(matrix(rnorm(1e6), 1e4), RLIMIT_AS = 10*1024*1024), throws_error("cannot allocate"));
	expect_that(eval.secure(matrix(rnorm(1e6), 1e4)), is_a("matrix"))
	expect_that(eval.secure(matrix(rnorm(1e6), 1e4), RLIMIT_AS = 10*1024*1024), throws_error("cannot allocate"));
	expect_that(eval.secure(matrix(rnorm(1e6), 1e4)), is_a("matrix"))
	expect_that(eval.secure(matrix(rnorm(1e6), 1e4), RLIMIT_AS = 10*1024*1024), throws_error("cannot allocate"));
});
# Note: keep in mind that RLIMIT_AS is not effective when set to less than what
# has already been allocated in the current process. These tests will fail if
#
context("memory limits")
test_that("Memory limits apply and do not have side effects", {
	expect_that(eval.secure(class(rep(pi, 25*1024*1024))), equals("numeric"))
	expect_that(eval.secure(class(rep(pi, 25*1024*1024)), RLIMIT_AS = 200*1024*1024), throws_error("cannot allocate"));
	expect_that(eval.secure(class(rep(pi, 25*1024*1024))), equals("numeric"))
	expect_that(eval.secure(class(rep(pi, 25*1024*1024)), RLIMIT_AS = 200*1024*1024), throws_error("cannot allocate"));
	expect_that(eval.secure(class(rep(pi, 25*1024*1024))), equals("numeric"))
	expect_that(eval.secure(class(rep(pi, 25*1024*1024)), RLIMIT_AS = 200*1024*1024), throws_error("cannot allocate"));
	expect_that(eval.secure(class(rep(pi, 25*1024*1024))), equals("numeric"))
	expect_that(eval.secure(class(rep(pi, 25*1024*1024)), RLIMIT_AS = 200*1024*1024), throws_error("cannot allocate"));
	expect_that(eval.secure(class(rep(pi, 25*1024*1024))), equals("numeric"))
	expect_that(eval.secure(class(rep(pi, 25*1024*1024)), RLIMIT_AS = 200*1024*1024), throws_error("cannot allocate"));
});

test_that("Raising memory limit by non-root users", {

	#force non-root
	me <- ifelse(getuid() == 0, 1000, getuid());

	#test with different limits.
	#Make sure to not test a value lower than current un-use memory
	gc();
	for(mylim in c(5e7, 1e8, 5e8, 1e9)){
		output <- list(hardlim = mylim/2, softlim = mylim/2);
		expect_that(eval.secure(rlimit_as(mylim*2), RLIMIT_AS = mylim, uid=me), throws_error("privilege"));
		expect_that(eval.secure(rlimit_as(mylim/2), RLIMIT_AS = mylim, uid=me), equals(output));
		rm(output);
	}
});

test_that("warnings", {
	expect_that(rlimit_as(1e10), gives_warning());
	#expect_that(eval.secure(123, RLIMIT_AS=1e10), gives_warning())
});

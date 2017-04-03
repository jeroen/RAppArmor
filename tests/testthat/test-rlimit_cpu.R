context("cpu limits")

testfun <- function(){
	Sys.sleep(1);
	repeat{
		svd(matrix(rnorm(1e6,1e3)));
	}
};

#timeout also counts idle time
test_that("Timeout terminates process timely.", {
	out <- system.time(try(eval_safe(testfun(), timeout=2), silent=TRUE));
	expect_that(unname(out["elapsed"]) < 2.5, is_true())
	rm(out)
});

test_that("Timeout throws error", {
	expect_that(eval_safe(testfun(), timeout=1), throws_error("timeout"))
});

#rlimit_cpu does not count idle time, but after 5 sec it should be done usually
test_that("RLIMIT_CPU terminates process timely.", {
	out <- system.time(try(eval_safe(testfun(), rlimits = list(cpu = 2)), silent=TRUE));
	expect_that(unname(out["elapsed"]) < 5, is_true())
	rm(out)
});

test_that("combine limit and cpu.", {
	out <- system.time(try(eval_safe(testfun(), timeout=2, rlimits = list(cpu = 2)), silent=TRUE));
	expect_that(unname(out["elapsed"]) < 2.5, is_true())
	rm(out)
});

test_that("Raising the limit should not be possible for non-root users", {
			
	#force non-root
	me <- ifelse(getuid() == 0, 1000, getuid());
	
	#test
	for(mylim in c(2, 2e1, 2e2, 2e3)){
		output <- list(cur = mylim/2, max = mylim);
		expect_that(eval_safe(rlimit_cpu(mylim*2), rlimits = list(cpu = mylim), uid = me), throws_error("permi"))
		expect_that(eval_safe(rlimit_cpu(mylim/2), rlimits = list(cpu = mylim), uid = me), equals(output))
		rm(output)
	}
});
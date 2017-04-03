context("priority settings")
test_that("setting priority", {

	#force non-root
	me <- ifelse(getuid() == 0, 1000, getuid());

	prio <- getpriority();
	
	# For root the error is 'not permitted' and for users the error is 'Permission denied'

	expect_that(eval_safe(getpriority(), priority=prio+1), equals(prio+1))
	expect_that(eval_safe({setuid(me); setgid(me); setpriority(prio-1)}), throws_error("ermi"));

	expect_that(eval_safe(getpriority(), priority=prio+1), equals(prio+1))
	expect_that(eval_safe({setuid(me); setgid(me); setpriority(prio-1)}), throws_error("ermi"));

	expect_that(eval_safe(getpriority(), priority=prio+1), equals(prio+1))
	expect_that(eval_safe({setuid(me); setgid(me); setpriority(prio-1)}), throws_error("ermi"));

	expect_that(eval_safe(getpriority(), priority=prio+1), equals(prio+1))
	expect_that(eval_safe({setuid(me); setgid(me); setpriority(prio-1)}), throws_error("ermi"));

});

context("priority settings")
test_that("setting priority", {

	#force non-root
	me <- ifelse(getuid() == 0, 1000, getuid());

	prio <- getpriority();

	expect_that(eval.secure(getpriority(), priority=prio+1), equals(prio+1))
	expect_that(eval.secure({setuid(me); setgid(me); setpriority(prio-1)}), throws_error("privilege"));

	expect_that(eval.secure(getpriority(), priority=prio+1), equals(prio+1))
	expect_that(eval.secure({setuid(me); setgid(me); setpriority(prio-1)}), throws_error("privilege"));

	expect_that(eval.secure(getpriority(), priority=prio+1), equals(prio+1))
	expect_that(eval.secure({setuid(me); setgid(me); setpriority(prio-1)}), throws_error("privilege"));

	expect_that(eval.secure(getpriority(), priority=prio+1), equals(prio+1))
	expect_that(eval.secure({setuid(me); setgid(me); setpriority(prio-1)}), throws_error("privilege"));

});

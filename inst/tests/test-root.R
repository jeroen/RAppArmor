#these tests are only for root

if(getuid() == 0){
	context("root user tests")
	test_that("setuid, setgid", {
		#test getuid
		expect_that(eval.secure(getuid(), uid=1000), equals(1000));
		expect_that(eval.secure(getuid(), gid=1000, uid=1000), equals(1000));
		
		#test getgid
		expect_that(eval.secure(getgid(), gid=1000), equals(1000));
		expect_that(eval.secure(getgid(), gid=1000, uid=1000), equals(1000));
		
		
	});
} else {
	cat("Skipping root user tests.")
}
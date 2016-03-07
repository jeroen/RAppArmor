#these tests are only for root
context("root user tests")
if(getuid() == 0){
	test_that("setuid, setgid", {
		#test getuid
		expect_that(eval.secure(getuid(), uid=1000), equals(1000));
		expect_that(eval.secure(getuid(), gid=1000, uid=1000), equals(1000));
		
		#test getgid
		expect_that(eval.secure(getgid(), gid=1000), equals(1000));
		expect_that(eval.secure(getgid(), gid=1000, uid=1000), equals(1000));
		
		
	});
} else {
	cat("skip.")
}
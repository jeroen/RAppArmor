context("apparmor")

test_that("profiles available", {
  skip_if_no_apparmor()
	expect_that(eval.secure(aa_getcon(verbose=FALSE)$con, profile="r-base"), equals("r-base"))
	expect_that(eval.secure(aa_getcon(verbose=FALSE)$con, profile="r-user"), equals("r-user"))
	expect_that(eval.secure(aa_getcon(verbose=FALSE)$con, profile="r-compile"), equals("r-compile"))
	expect_that(eval.secure(aa_getcon(verbose=FALSE)$con, profile="testprofile"), equals("testprofile"))
});

test_that("changing hats", {
  skip_if_no_apparmor()
	expect_that(eval.secure({
		aa_change_profile("testprofile", verbose=FALSE);
		aa_change_hat("testhat", 1234, verbose=FALSE);
		read.table("/etc/group")
	}), throws_error("connection"));

	expect_that(eval.secure({
		aa_change_profile("testprofile", verbose=FALSE);
		aa_change_hat("testhat", 1234, verbose=FALSE);
		aa_revert_hat(1234, verbose=FALSE)
		read.table("/etc/group")
	}), is_a("data.frame"));
});

test_that("basic profiles permissions", {
	#list /
  skip_if_no_apparmor()
	if(length(list.files("/")) > 0){
		expect_that(length(eval.secure(list.files("/"))) > 0, is_true());
		expect_that(length(eval.secure(list.files("/"), profile="r-base")) > 0, is_false());
		expect_that(length(eval.secure(list.files("/"), profile="r-user")) > 0, is_false());
	}

	#list /tmp
	if(length(list.files("/tmp")) > 0){
		expect_that(length(eval.secure(list.files("/tmp"))) > 0, is_true());
		expect_that(length(eval.secure(list.files("/tmp"), profile="r-base")) > 0, is_false());
		expect_that(length(eval.secure(list.files("/tmp"), profile="r-user")) > 0, is_false());
	}

	#list /home/user/
	if(length(list.files("~")) > 0){
		expect_that(length(eval.secure(list.files("~"))) > 0, is_true());
		expect_that(length(eval.secure(list.files("~"), profile="r-base")) > 0, is_false());
		expect_that(length(eval.secure(list.files("~"), profile="r-user")) > 0, is_true());
	}
});


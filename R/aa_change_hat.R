aa_change_hat <- function(subprofile, magic_token){
	ret <- integer(1);
	output <- .C('aa_change_hat_wrapper', ret, subprofile, magic_token, PACKAGE="rApparmor")
	if(output[[1]] != 0) stop("Failed to change hats to: ", subprofile, ".\nError: ", output[[1]]);
}

aa_change_profile <- function(profile){
	ret <- integer(1);
	output <- .C('aa_change_profile_wrapper', ret, profile, PACKAGE="rApparmor")
	if(output[[1]] != 0) stop("Failed to change profile to: ", profile, ".\nError: ", output[[1]]);	
}

.onLoad <-function (lib, pkg)   {
	library.dynam("rApparmor", pkg, lib)
}


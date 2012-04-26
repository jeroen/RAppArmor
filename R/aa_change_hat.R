aa_change_hat <- function(subprofile, magic_token){
	if(!is.character(subprofile) || length(subprofile) == 0){
		stop("subprofile must be a valid profile. E.g. /usr/bin/R or /usr/bin/R//localprofile")
	}
	ret <- integer(1);
	output <- .C('aa_change_hat_wrapper', ret, subprofile, magic_token, PACKAGE="rApparmor")
	if(output[[1]] != 0) stop("Failed to change hats to: ", subprofile, ".\nError: ", output[[1]]);
}

aa_revert_hat <- function(magic_token){
	ret <- integer(1);
	output <- .C('aa_revert_hat_wrapper', ret, magic_token, PACKAGE="rApparmor")
	if(output[[1]] != 0) stop("Failed to revert hat.\nError: ", output[[1]]);
}

aa_change_profile <- function(profile){
	ret <- integer(1);
	output <- .C('aa_change_profile_wrapper', ret, profile, PACKAGE="rApparmor")
	if(output[[1]] != 0) stop("Failed to change profile to: ", profile, ".\nError: ", output[[1]]);	
}

.onLoad <-function (lib, pkg)   {
	library.dynam("rApparmor", pkg, lib)
}


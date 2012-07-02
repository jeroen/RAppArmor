#' Change hats
#' 
#' A hat is a subprofile which name starts with a '^'.
#' The difference between hats and profiles is that one can escape (revert) from the hat using the token.
#' Hence this provides more limited security than a profile.
#' 
#' @param subprofile character string identifying the subprofile (hat) name (without the "^")
#' @param magic_token a number that will be the key to revert out of the hat.
#' @aliases aa_revert_hat
#' @export aa_change_hat aa_revert_hat
#' @examples \dontrun{aa_change_profile("myprofile");
#' read.table("/etc/group");
#' aa_change_hat("testhat", 13337);
#' read.table("/etc/group");
#' aa_revert_hat(13337);
#' read.table("/etc/group");
#' }
aa_change_hat <- function(subprofile, magic_token){
	if(!is.character(subprofile) || length(subprofile) == 0){
		stop("subprofile must be a valid profile. E.g. /usr/bin/R or /usr/bin/R//localprofile")
	}
	magic_token <- as.integer(magic_token);
	ret <- integer(1);
	output <- .C('aa_change_hat_wrapper', ret, subprofile, magic_token, PACKAGE="RAppArmor")
	if(output[[1]] != 0) stop("Failed to change hats to: ", subprofile, ".\nError: ", output[[1]]);
	invisible();
}

aa_revert_hat <- function(magic_token){
	magic_token <- as.integer(magic_token);
	ret <- integer(1);
	output <- .C('aa_revert_hat_wrapper', ret, magic_token, PACKAGE="RAppArmor")
	if(output[[1]] != 0) stop("Failed to revert hat.\nError: ", output[[1]]);
	invisible();	
}

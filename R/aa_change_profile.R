#' Change profiles
#' 
#' This function changes the current R process to an AppArmor profile. 
#' Note that this generally is a one way process: most profiles explicitly prevent switching into another profile, otherwise it would defeat the purpose.
#' 
#' @param profile character string with the name of the profile.
#' @export
#' @examples  \dontrun{read.table("/etc/passwd");
#' aa_change_profile("myprofile");
#' read.table("/etc/passwd");
#' }
aa_change_profile <- function(profile){
	ret <- integer(1);
	output <- .C('aa_change_profile_wrapper', ret, profile, PACKAGE="rApparmor")
	if(output[[1]] != 0) stop("Failed to change profile to: ", profile, ".\nError: ", output[[1]]);	
	invisible();	
}
#' Change profiles
#' 
#' This function changes the current R process to an AppArmor profile. 
#' Note that this generally is a one way process: most profiles explicitly prevent switching into another profile, otherwise it would defeat the purpose.
#' 
#' @param profile character string with the name of the profile.
#' @param verbose print some C output (TRUE/FALSE)
#' @export
#' @references http://manpages.ubuntu.com/manpages/precise/man2/aa_change_profile.2.html
#' @examples  \dontrun{
#' test <- read.table("/etc/passwd");
#' aa_change_profile("testprofile");
#' aa_getcon();
#' test <- read.table("/etc/passwd");
#' }
aa_change_profile <- function(profile, verbose=TRUE){
	verbose <- as.integer(verbose)
	ret <- integer(1);
	output <- .C('aa_change_profile_wrapper', ret, profile, verbose, PACKAGE="RAppArmor")
	if(output[[1]] == 0){
		return(invisible())
	} else{
		#special warning when changing from one profile into another
		if(output[[1]] == 13){
			out <- try(aa_getcon());	
			if(class(out) != "try-error" && out$con != "unconfined"){
				if(out$con == "/usr/bin/R") warning("The standard profile in usr.bin.r is already being enforced!\n  Run sudo aa-disable usr.bin.r to disable this.");
				stop("Failed to change profile from: ", out$con, " to: ", profile, ".\n  Note that this is only allowed if the current profile has a 'change_profile -> ",profile,"' directive.");	
			}
		}		
		ermsg <- errno(output[[1]]);
		ermsg <- switch(ermsg,
			"ENOENT" = "Profile not found. Make sure the profile is available in /etc/apparmor.d/ and loaded.\n  Try running: sudo aa-status.",
			"EINVAL" = "The apparmor kernel module is not loaded or the communication via the /proc/*/attr/current file did not conform to protocol.",
			"ENOMEM" = "Insufficient kernel memory was available.",
			"EPERM" = "The calling application is not confined by apparmor.",
			"EACCES" = "Permission denied.\n  Maybe there already is a profile loaded? You cannot switch out of a profile.\n  Have a look at: aa_getcon().",
			ermsg
		);
		stop("Failed to change profile\n", ermsg);	
	}
}
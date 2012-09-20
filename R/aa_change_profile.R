#' Change profiles
#' 
#' This function changes the current R process to an AppArmor profile. 
#' Note that this generally is a one way process: most profiles explicitly prevent switching into another profile, otherwise it would defeat the purpose.
#' 
#' @param profile character string with the name of the profile.
#' @param verbose print some C output (TRUE/FALSE)
#' @export
#' @examples  \dontrun{read.table("/etc/passwd");
#' aa_change_profile("myprofile");
#' read.table("/etc/passwd");
#' }
aa_change_profile <- function(profile, verbose=TRUE){
	verbose <- as.integer(verbose)
	ret <- integer(1);
	output <- .C('aa_change_profile_wrapper', ret, profile, verbose, PACKAGE="RAppArmor")
	if(output[[1]] == 0){
		return(invisible())
	} else{
		if(output[[1]] == 13){
			out <- try(aa_getcon());	
			if(class(out) != "try-error" && out$con != "unconfined"){
				if(out$con == "/usr/bin/R") warning("The standard profile in usr.bin.r is already being enforced!\n  Run sudo aa-disable usr.bin.r to disable this.");
				stop("Failed to change profile from: ", out$con, " to: ", profile, ".\n  Note that this is only allowed if the current profile has a 'change_profile -> ",profile,"' directive.");	
			}
		}		
		switch(as.character(output[[1]]),
			"2" = stop("Failed to change profile to: ", profile, ": Error 2: profile not found.\n  Make sure the profile is available in /etc/apparmor.d/ and loaded.\n  Try running: sudo aa-status."),
			"13" = stop("Failed to change profile to: ", profile, ": Error 13: permission denied.\n  Maybe there already is a profile loaded? You cannot switch out of a profile.\n  Try the function: aa_getcon()."),
			stop("Failed to change profile to: ", profile, "\nError:",output[[1]])
		);
	}
}
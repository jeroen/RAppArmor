#' Check if AppArmor is Enabled
#' 
#' This function tries to lookup the status of AppArmor in the kernel. However,
#' some confined profiles might not have enough privileges to lookup this status. 
#' Also see aa_getcon().
#' 
#' @param verbose print some C output (TRUE/FALSE)
#' @return TRUE or FALSE 
#' @references http://manpages.ubuntu.com/manpages/precise/man2/aa_find_mountpoint.2.html
#' 
#' @export
aa_is_enabled <- function(verbose=TRUE){
	verbose <- as.integer(verbose);
	ret <- integer(1);
	ermsg <- "";
	output <- .C('aa_is_enabled_wrapper', ret, verbose, ermsg, PACKAGE="RAppArmor")
	if(output[[1]] == -999){
		return(TRUE);
	} else{
		if(verbose==TRUE){
			message(" AppArmor status lookup failed. Error code: ", output[[3]]);
			switch(output[[3]],
				"ENOSYS" = message("AppArmor extensions to the system are not available."),
				"ECANCELED" = message("AppArmor is available on the system but has been disabled at boot."),
				"ENOENT" = message("AppArmor is available (and maybe even enforcing policy) but the interface is not available."),
				"ENOMEM" = message(" Insufficient memory was available."),
				"EPERM" = message("Did not have sufficient permissions to determine if AppArmor is enabled."),
				"EACCES" = message(" Did not have sufficient permissions to determine if AppArmor is enabled.")		
			);
		}
		return(FALSE);
	}
}
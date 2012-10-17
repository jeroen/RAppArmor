#' Get AppArmor confinement context for the current task
#' 
#' We can use this function to see if there is an AppArmor 
#' profile associated with the current process, and in which 
#' mode it current is set (enforce, complain, disable).
#' 
#' Note that in order for this function to do its work, it needs
#' read access to the attributes of the current process. Hence 
#' if a profile is being enforced that is overly strict, this 
#' confinement lookup will fail as well :-)
#' 
#' @param verbose print some C output (TRUE/FALSE)
#' @return list with con and mode.
#' @references http://manpages.ubuntu.com/manpages/precise/man2/aa_getcon.2.html
#' 
#' @export
aa_getcon <- function(verbose=TRUE){
	verbose <- as.integer(verbose)
	ret <- integer(1);
	con <- character(1);
	mod <- character(1);
	output <- .C('aa_getcon_wrapper', ret, con, mod, verbose, ermsg = "", PACKAGE="RAppArmor")
	if(output[[1]] == 0){
		return(list(con=output[[2]], mode=output[[3]]));
	} else {
		switch(output[[4]],
			"EINVAL" = stop("The apparmor kernel module is not loaded or the communication via the /proc/*/attr/file did not conform to protocol."),
			"ENOMEM" = stop("Insufficient kernel memory was available."),
			"EACCES" = stop("Access to the specified file/task was denied."),
			"ENOENT" = stop("The specified file/task does not exist or is not visible."),
			"ERANGE" = stop("The confinement data is to large to fit in the supplied buffer."),
			stop("Unknown error: ", output[[4]])
		);		
	}
}
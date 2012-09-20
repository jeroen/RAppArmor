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
#' 
#' @export
aa_getcon <- function(verbose=TRUE){
	verbose <- as.integer(verbose)
	ret <- integer(1);
	con <- character(1);
	mod <- character(1);
	output <- .C('aa_getcon_wrapper', ret, con, mod, verbose, PACKAGE="RAppArmor")
	if(output[[1]] == 0){
		return(list(con=output[[2]], mode=output[[3]]));
	} else {
		switch(as.character(output[[1]]),
			"13" = stop("Permission denied to lookup confinement information. Most likely a profile is already being enforced which does not grant access to the current process attributes."),
			stop("Failed to get confinement information. Error:", output[[1]])
		);
	}
}
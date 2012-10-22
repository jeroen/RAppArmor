#' Get/Set GID
#' 
#' Wrappers for getgid and setgid in Linux.
#' 
#' @param gid group ID. Must be integer.
#' @param verbose print some C output (TRUE/FALSE)
#' @references http://manpages.ubuntu.com/manpages/precise/man2/setgid.2.html
#' @aliases getgid
#' @export setgid getgid

setgid <- function(gid, verbose=FALSE){
	stopifnot(is.numeric(gid));	
	verbose <- as.integer(verbose);
	gid <- as.integer(gid);
	ret <- integer(1);
	output <- .C('setgid_wrapper', ret, gid, verbose, PACKAGE="RAppArmor")
	
	if(output[[1]] != 0) {
		ermsg <- errno(output[[1]]);
		ermsg <- switch(ermsg,
			EINVAL = "The value of the gid argument is invalid.",
			EPERM = "The calling process does not have appropriate privileges.",
			ermsg
		);
		stop("Failed to set gid. ", ermsg);
	}	
	invisible();	
}

getgid <- function(){
	ret <- integer(1);
	output <- .C('getgid_wrapper', ret, PACKAGE="RAppArmor")
	return(output[[1]]);
}


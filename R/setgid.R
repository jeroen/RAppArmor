#' Get/Set GID
#' 
#' Wrappers for getgid and setgid in Linux.
#' 
#' @param gid group ID
#' @param verbose print some C output (TRUE/FALSE)
#' @aliases getgid
#' @export setgid getgid

setgid <- function(gid, verbose=TRUE){
	verbose <- as.integer(verbose);
	gid <- as.integer(gid);
	ret <- integer(1);
	output <- .C('setgid_wrapper', ret, gid, verbose, PACKAGE="RAppArmor")
	if(output[[1]] != 0) stop("Failed to setgid to: ", gid, ".\nError: ", output[[1]]);	
	invisible();	
}

getgid <- function(){
	ret <- integer(1);
	output <- .C('getgid_wrapper', ret, PACKAGE="RAppArmor")
	return(output[[1]]);
}


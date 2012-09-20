#' Get/Set UID
#' 
#' Wrappers for getuid and setuid in Linux.
#' 
#' @param uid user ID
#' @param verbose print some C output (TRUE/FALSE)
#' @aliases getuid
#' @export setuid getuid
setuid <- function(uid, verbose=TRUE){
	verbose <- as.integer(verbose);
	uid <- as.integer(uid);
	ret <- integer(1);
	output <- .C('setuid_wrapper', ret, uid, verbose, PACKAGE="RAppArmor")
	if(output[[1]] != 0) stop("Failed to setuid to: ", uid, ".\nError: ", output[[1]]);	
	invisible();	
}

getuid <- function(){
	ret <- integer(1);
	output <- .C('getuid_wrapper', ret, PACKAGE="RAppArmor")
	return(output[[1]]);
}

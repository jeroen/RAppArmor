#' Get/Set UID
#' 
#' Wrappers for getuid and setuid in Linux.
#' 
#' @param uid user ID
#' @aliases getuid
#' @export setuid getuid
setuid <- function(uid){
	uid <- as.integer(uid);
	ret <- integer(1);
	output <- .C('setuid_wrapper', ret, uid, PACKAGE="RAppArmor")
	if(output[[1]] != 0) stop("Failed to setuid to: ", uid, ".\nError: ", output[[1]]);	
	invisible();	
}

getuid <- function(){
	ret <- integer(1);
	output <- .C('getuid_wrapper', ret, PACKAGE="RAppArmor")
	return(output[[1]]);
}

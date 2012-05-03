#' Set User / Group Identity
#' 
#' Wrappers for setuid and setgid calls in Linux
#' 
#' @param uid user ID
#' @param gid grou ID
#' @aliases setgid
#' @export setuid setgid
setuid <- function(uid){
	uid <- as.integer(uid);
	ret <- integer(1);
	output <- .C('setuid_wrapper', ret, uid, PACKAGE="rApparmor")
	if(output[[1]] != 0) stop("Failed to setuid to: ", uid, ".\nError: ", output[[1]]);	
	invisible();	
}


setgid <- function(gid){
	uid <- as.integer(gid);
	ret <- integer(1);
	output <- .C('setuid_wrapper', ret, gid, PACKAGE="rApparmor")
	if(output[[1]] != 0) stop("Failed to setgid to: ", gid, ".\nError: ", output[[1]]);	
	invisible();	
}

#' Get/Set pgid
#' 
#' Wrappers for getpgid and setpgid in Linux. The setpgid function sets
#' the current process group id to equal the pid value.
#' 
#' @param verbose print some C output (TRUE/FALSE)
#' @aliases getpgid
#' @export setpgid getpgid

setpgid <- function(verbose=TRUE){
	verbose <- as.integer(verbose);
	pgid <- as.integer(Sys.getpid());
	ret <- integer(1);
	output <- .C('setpgid_wrapper', ret, pgid, verbose, PACKAGE="RAppArmor")
	if(output[[1]] != 0) stop("Failed to setpgid to: ", pgid, ".\nError: ", output[[1]]);	
	invisible();	
}

getpgid <- function(){
	ret <- integer(1);
	output <- .C('getpgid_wrapper', ret, PACKAGE="RAppArmor")
	return(output[[1]]);
}


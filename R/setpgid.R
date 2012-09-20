### These are used internally to set the process group id.

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


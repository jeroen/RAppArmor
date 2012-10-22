### These are used internally to set the process group id.

setpgid <- function(verbose=FALSE){
	verbose <- as.integer(verbose);
	pgid <- as.integer(Sys.getpid());
	ret <- integer(1);
	output <- .C('setpgid_wrapper', ret, pgid, verbose, PACKAGE="RAppArmor")
	if(output[[1]] != 0) {
		ermsg <- errno(output[[1]]);
		ermsg <- switch(ermsg,
			EACCES = "Value of the pid argument matches the process ID of a child process.",
			EINVAL = "Value of the pgid argument is less than 0 or invalid.",
			EPERM = "EPERM / Permission denied.",
			ESRCH = "The value of the pid argument does not match the process ID ofthe calling process.",
			ermsg
		);
		stop("Failed to set pgid. ", ermsg);
	}		
	invisible();	
}

getpgid <- function(){
	ret <- integer(1);
	output <- .C('getpgid_wrapper', ret, PACKAGE="RAppArmor")
	return(output[[1]]);
}


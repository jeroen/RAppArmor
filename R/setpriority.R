#' Get/set process priority
#' 
#' Get/set the priority of the current process. High value is low priority. Only superusers can lower the value.
#' 
#' @param prio priority value between -20 and 20 
#' @param verbose print some C output (TRUE/FALSE)
#' @aliases getpriority
#' @references http://manpages.ubuntu.com/manpages/precise/man2/getpriority.2.html
#' @export setpriority getpriority

setpriority <- function(prio, verbose=FALSE){
	stopifnot(is.numeric(prio))
	stopifnot(-21 < prio && prio < 21)
	verbose <- as.integer(verbose);
	prio <- as.integer(prio);
	ret <- integer(1);
	output <- .C('setpriority_wrapper', ret, prio, verbose, PACKAGE="RAppArmor");
	if(output[[1]] != 0) {
		ermsg <- errno(output[[1]]);
		ermsg <- switch(ermsg,
			ESRCH = "No process was located using the which and who values specified.",
			EACCES = "The caller attempted to lower a process priority, but did not have the required privilege.",
			ermsg
		);
		stop("Failed to set priority. ", ermsg);
	}	
	return(getpriority());
}

getpriority <- function(){
	ret <- integer(1);
	output <- .C('getpriority_wrapper', ret, PACKAGE="RAppArmor");
	if(output[[1]] < 9000) {
		#success
		return(output[[1]]);
	} else {
		#failure
		output[[1]] <- output[[1]] - 10000;
		ermsg <- errno(output[[1]]);
		ermsg <- switch(ermsg,
			ESRCH = "No process was located using the which and who values specified.",
			ermsg
		);
		stop("Failed to get priority. ", ermsg);
	}
}
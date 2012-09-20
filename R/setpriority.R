#' Get/set process priority
#' 
#' Get/set the priority of the current process. High value is low priority. Only superusers can lower the value.
#' 
#' @param prio priority value between -20 and 20 
#' @param verbose print some C output (TRUE/FALSE)
#' @aliases getpriority
#' @export

setpriority <- function(prio, verbose=TRUE){
	verbose <- as.integer(verbose);
	prio <- as.integer(prio);
	ret <- integer(1);
	output <- .C('setpriority_wrapper', ret, prio, verbose, PACKAGE="RAppArmor");
	if(output[[1]] != 0) stop("Failed to set priority to: ", prio, ".\nError: ", output[[1]]);	
	return(getpriority());
}

getpriority <- function(){
	ret <- integer(1);
	output <- .C('getpriority_wrapper', ret, PACKAGE="RAppArmor");
	val <- output[[1]];
	if(val > 1000) stop("Failed to get priority.\nError: ", val-10000);	
	return(val);
}
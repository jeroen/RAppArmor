#' Get process priority
#' 
#' Read the priority value of the current process. Should be between -20 and 20.
#' 
#' @export
getpriority <- function(){
	ret <- integer(1);
	output <- .C('getpriority_wrapper', ret, PACKAGE="RAppArmor");
	val <- output[[1]];
	if(val > 1000) stop("Failed to get priority.\nError: ", val-10000);	
	return(val);
}

#' Set process priority
#' 
#' Set the priority of the current process. High value is low priority. Only superusers can lower the value.
#' 
#' @param prio priority value between -20 and 20 
#' @export
setpriority <- function(prio){
	prio <- as.integer(prio);
	ret <- integer(1);
	output <- .C('setpriority_wrapper', ret, prio, PACKAGE="RAppArmor");
	if(output[[1]] != 0) stop("Failed to set priority to: ", prio, ".\nError: ", output[[1]]);	
	return(getpriority());
}
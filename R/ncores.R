#' Get number of cores
#' 
#' Get the number of cores available in the machine.
#' 
#' @references http://manpages.ubuntu.com/manpages/precise/man3/sysconf.3.html
#' @export 
ncores <- function(){
	ret <- integer(1);
	output <- .C('ncores', ret, PACKAGE="RAppArmor");
	val <- output[[1]];
	if(val <= 0 ) stop("Failed to get number of cores. Try parallel:detectCores() instead");	
	return(val);
}
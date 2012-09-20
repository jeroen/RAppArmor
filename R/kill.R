#' Kill a process
#' 
#' Kill a process. Negative values kill a process group.
#' 
#' @param pid process id.
#' @param signal kill signal
#' @param verbose print some C output (TRUE/FALSE)
#' @export kill

kill <- function(pid, signal=SIGTERM, verbose=TRUE){
	verbose <- as.integer(verbose)
	pid <- as.integer(pid);
	ret <- integer(1);
	output <- .C('kill_wrapper', ret, pid, signal, verbose, PACKAGE="RAppArmor")
	if(output[[1]] != 0) warning("Failed to kill proc: ", pid, ".\nError: ", output[[1]]);	
	invisible();	
}


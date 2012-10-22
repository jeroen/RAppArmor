#' Kill a process
#' 
#' Kill a process. Negative values kill a process group.
#' 
#' @param pid process id.
#' @param signal kill signal
#' @param verbose print some C output (TRUE/FALSE)
#' @export kill
#' @references http://manpages.ubuntu.com/manpages/precise/man2/kill.2.html

kill <- function(pid, signal=SIGTERM, verbose=TRUE){
	verbose <- as.integer(verbose)
	pid <- as.integer(pid);
	ret <- integer(1);
	output <- .C('kill_wrapper', ret, pid, signal, verbose, PACKAGE="RAppArmor")
	if(output[[1]] != 0) {
		ermsg <- errno(output[[1]]);
		ermsg <- switch(ermsg,
			EINVAL = "Failed to kill process. An invalid signal was specified.",
			EPERM = "Failed to kill process. The process does not have permission to send the signal to the target process.",
			ESRCH = "Failed to kill process. The pid or process group does not exist.",
			ermsg
		);
		#we throw a warning, not an error
		warning(ermsg);
	}
	invisible();	
}


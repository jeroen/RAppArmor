#' Process affinity manipulation
#' 
#' Function to get/set the process's CPU affinity mask. Affinity mask allows binding a process to a specific
#' core(s) within the machine. 
#'
#' Setting a process afinity allows for restricting the process to only use certain cores in the machine. The 
#' cores are indexed by the operating system as 1 to ncores. One can lookup ncores using ncores().
#' Calling setaffinity with no arguments resets the process to use any of the available cores.
#' 
#' Note that setaffinity is different from setting r_limit values in the sense that it is not a one-way process.
#' An unprivileged user can change the process affinity to any value. In order to 'lock' an affinity value,
#' one would have to manipulate Linux capability value for CAP_SYS_NICE.
#' 
#' @param cpus Which cpu cores to restrict to. Must be vector of integers between 1 and ncores.
#' @param verbose print some C output (TRUE/FALSE)
#' @aliases getaffinity getaffinity_count
#' @export setaffinity getaffinity getaffinity_count
#' @references http://manpages.ubuntu.com/manpages/precise/man2/sched_setaffinity.2.html
#' @examples \dontrun{
#' getaffinity();
#' getaffinity_count();
#' setaffinity(1); #restricts the process to core number 1.
#' getaffinity();
#' setaffinity(); #reset
#' getaffinity();
#' }


setaffinity <- function(cpus, verbose=FALSE){
	verbose <- as.integer(verbose);
	
	#validate
	if(!missing(cpus)){
		stopifnot(is.numeric(cpus));
	}
	
	#default is all cores
	if(missing(cpus)){
		cpus <- as.integer(1:ncores())
	}
	
	#cpu must be a single value
	cpus <- as.integer(cpus);	
	length <- as.integer(length(cpus));
	
	#it also must be in the range of the cores (count from zero)
	cores <- 1:ncores();
	if(!all(cpus %in% cores)){
	  stop("value for 'cpu' is out of range. Valid values index available cpu's: ", paste(as.character(cores), collapse=", "));
	}

	ret <- integer(1);
	output <- .C('setaffinity_wrapper', ret, cpus, length, verbose, PACKAGE="RAppArmor");
	
	if(output[[1]] != 0) {
		ermsg <- errno(output[[1]]);
		ermsg <- switch(ermsg,
			EFAULT = "Failed to set affinity. A supplied memory address was invalid.",
			EINVAL = "Failed to set affinity. The affinity bit mask mask contains no processors that are currently physically on the system and permitted to the process according to any restrictions that may be imposed by the cpuset mechanism described in cpuset(7).",
			EPERM = "Failed to set affinity. The calling process does not have appropriate privileges.",
			ermsg
		);
		#we throw a warning, not an error
		stop(ermsg);
	}
	invisible()
}


getaffinity_count <- function(verbose=FALSE){
	
	verbose <- as.integer(verbose);
	ret <- integer(1);
	cpus <- integer(1);
	
	output <- .C('getaffinity_count', ret, cpus, verbose, PACKAGE="RAppArmor");
	if(output[[1]] != 0) {
		ermsg <- errno(output[[1]]);
		ermsg <- switch(ermsg,
			EFAULT = "A supplied memory address was invalid.",
			EINVAL = "cpusetsize is smaller than the size of the affinity mask used by the kernel.",
			EPERM = "The calling process does not have appropriate privileges.",
			ermsg
		);
		#we throw a warning, not an error
		stop("Failed to lookup affinity. ", ermsg);
	}
	return(output[[2]]);
}

getaffinity <- function(verbose=FALSE){
	verbose <- as.integer(verbose);
	
	#we allocate twice as long as a vector just in case ncores() is wrong. 
	cpus <- as.integer(rep(999, ncores()*2))	
	length <- as.integer(length(cpus));
	ret <- integer(1);
	
	output <- .C('getaffinity_wrapper', ret, cpus, length, verbose, PACKAGE="RAppArmor");
	if(output[[1]] != 0) {
		ermsg <- errno(output[[1]]);
		ermsg <- switch(ermsg,
			EFAULT = "A supplied memory address was invalid.",
			EINVAL = "cpusetsize is smaller than the size of the affinity mask used by the kernel.",
			EPERM = "The calling process does not have appropriate privileges.",
			ermsg
		);
		#we throw a warning, not an error
		stop("Failed to lookup affinity. ", ermsg);
	}
	return(which(as.logical(output[[2]])));
}



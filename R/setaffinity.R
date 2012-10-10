#' Process affinity manipulation
#' 
#' Function to get/set the process's CPU affinity mask. Affinity mask allows binding a process to a specific
#' core(s) within the machine. 
#'
#' Setting a process afinity allows for restricting the process to only use certain cores in the machine. The 
#' cores are indexed by the operating system as 1 to ncores. One can lookup ncores using ncores().
#'
#' The function affinity_bind restricts the current process to a certain cores in the machine. 
#' The function affinity_count gives the number of cores that the current process has available.
#' 
#' @param cpus Which cpu cores to restrict to. Values must be integers between 1 and ncores.
#' @param verbose print some C output (TRUE/FALSE)
#' @aliases getaffinity getaffinity_count
#' @export setaffinity getaffinity getaffinity_count
#' @examples getaffinity();
#' getaffinity_count();
#' setaffinity(1); #restricts the process to core number 1.
#' getaffinity();
#' setaffinity(); #reset
#' getaffinity();


setaffinity <- function(cpus, verbose=TRUE){
	verbose <- as.integer(verbose);
	
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
	if(output[[1]] != 0) stop("Failed to bind process to cpu: ", cpus, ".\nError: ", output[[1]]);	
	invisible()
}


getaffinity_count <- function(verbose=TRUE){
	
	verbose <- as.integer(verbose);
	ret <- integer(1);
	cpus <- integer(1);
	
	output <- .C('getaffinity_count', ret, cpus, verbose, PACKAGE="RAppArmor");
	if(output[[1]] != 0) stop("Failed to lookup affinity count");	
	return(output[[2]]);
}

getaffinity <- function(verbose=TRUE){
	verbose <- as.integer(verbose);
	
	#we allocate twice as long as a vector just in case ncores() is wrong. 
	cpus <- as.integer(rep(999, ncores()*2))	
	length <- as.integer(length(cpus));
	ret <- integer(1);
	
	output <- .C('getaffinity_wrapper', ret, cpus, length, verbose, PACKAGE="RAppArmor");
	if(output[[1]] != 0) stop("Failed to bind process to cpu: ", cpus, ".\nError: ", output[[1]]);	
	return(which(as.logical(output[[2]])));
}



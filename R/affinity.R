#' Process affinity manipulation
#' 
#' Function to get/set the process's CPU affinity mask. Affinity mask allows binding a process to a specific
#' core(s) within the machine. 
#'
#' Setting a process afinity allows for restricting the process to only use certain cores in the machine. The 
#' cores are indexed by the operating system as 0 to detectCores()-1.
#'
#' The function affinity_bind restricts the current process to a certain cpu in the machine. 
#' The function affinity_count gives the number of cores that the current process has available.
#' 
#' @param cpu Which cpu core to restrict to. Value must be number between 0 and detectCores()-1
#' @param verbose print some C output (TRUE/FALSE)
#' @aliases affinity_count
#' @export affinity_bind affinity_count
#' @examples affinity_count();
#' affinity_bind(1); #restricts the process to core number 1.
#' affinity_count();

affinity_bind <- function(cpu, verbose=TRUE){
	verbose <- as.integer(verbose);
	
	#cpu must be a single value
	cpu <- as.integer(cpu);	
	stopifnot(length(cpu) == 1);
	
	#it also must be in the range of the cores (count from zero)
	ncores <- detectCores()-1;
	if(!(cpu %in% 0:ncores)){
	   stop("value for 'cpu' is out of range of number of available cpus.");
	}

	ret <- integer(1);
	output <- .C('affinity_bind', ret, cpu, verbose, PACKAGE="RAppArmor");
	if(output[[1]] != 0) stop("Failed to bind process to cpu: ", cpu, ".\nError: ", output[[1]]);	
	return(cpu);
}


affinity_count <- function(verbose=TRUE){
	
	verbose <- as.integer(verbose);
	ret <- integer(1);
	cpus <- integer(1);
	
	output <- .C('affinity_count', ret, cpus, verbose, PACKAGE="RAppArmor");
	if(output[[1]] != 0) stop("Failed to lookup affinity count");	
	return(output[[2]]);
}


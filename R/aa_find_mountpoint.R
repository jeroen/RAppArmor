#' Find the apparmor mountpoint
#' 
#' @param verbose print some C output (TRUE/FALSE)
#' @return location of mountpoint 
#' @references http://manpages.ubuntu.com/manpages/precise/man2/aa_find_mountpoint.2.html
#' 
#' @export
aa_find_mountpoint <- function(verbose=TRUE){
	verbose <- as.integer(verbose);
	ret <- integer(1);
	mnt <- character(1);
	output <- .C('aa_find_mountpoint_wrapper', ret, mnt, verbose, PACKAGE="RAppArmor")
	if(output[[1]] == 0){
		return(output[[2]]);
	} else{
		ermsg <- errno(output[[1]]);
		ermsg <- switch(ermsg,
			ENOMEM = "Insufficient kernel memory was available.",
			EACCES = "Access to the required paths was denied.",
			ENOENT = "The apparmor filesystem mount could not be found.",
			ermsg
		);
		stop("Failed to find mountpoint\n", ermsg);
	}
}
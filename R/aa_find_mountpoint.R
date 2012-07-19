#' Find the apparmor mountpoint
#' 
#' @return location of mountpoint 
#' 
#' @export
aa_find_mountpoint <- function(){
	ret <- integer(1);
	mnt <- character(1);
	output <- .C('aa_find_mountpoint_wrapper', ret, mnt, PACKAGE="RAppArmor")
	if(output[[1]] == 0){
		return(output[[2]]);
	} else{
		stop("Failed to get mountpoint. Error:", output[[1]])
	}
}
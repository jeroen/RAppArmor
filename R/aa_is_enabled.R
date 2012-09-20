#' Check if AppArmor is Enabled
#' 
#' @param verbose print some C output (TRUE/FALSE)
#' @return TRUE or FALSE 
#' 
#' @export
aa_is_enabled <- function(verbose=TRUE){
	verbose <- as.integer(verbose);
	ret <- integer(1);
	output <- .C('aa_is_enabled_wrapper', ret, verbose, PACKAGE="RAppArmor")
	if(output[[1]] == -999){
		return(TRUE);
	} else{
		message("AppArmor not enabled. Error code:", output[[1]]);
		return(FALSE);
	}
}
#' Check if AppArmor is Enabled
#' @return TRUE or FALSE 
#' 
#' @export
aa_is_enabled <- function(){
	ret <- integer(1);
	output <- .C('aa_is_enabled_wrapper', ret, PACKAGE="RAppArmor")
	if(output[[1]] == -999){
		return(TRUE);
	} else{
		message("AppArmor not enabled. Error code:", output[[1]]);
		return(FALSE);
	}
}
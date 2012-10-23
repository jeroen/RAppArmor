#' Toggle interactive mode in R.
#' 
#' Toggle R interactive mode by setting C level global variable R_Interactive. 
#' See ?interactive for details
#' 
#' @param interactivity interactivity flag. TRUE or FALSE.
#' @export
setinteractive <- function(interactivity){
  .Call('interactivity', interactivity, PACKAGE="RAppArmor")
}


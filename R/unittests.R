#' RAppArmor unit tests
#'
#' This function loads the 'testthat' package and runs a number of
#' unit tests for RAppArmor. Note that the tests assume that the main
#' process is unconfined. Try running it both as root and as a regular
#' user to cover both cases.
#'
#' Occasionaly, one or two tests might fail due to random
#' fluctuations in available memory, cpu, etc. If this happens, try
#' running the tests again, possibly with less other pograms running
#' in the background.
#'
#' @export
unittests <- function(){
	testthat::test_package("RAppArmor");
}

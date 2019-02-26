#' Sandboxing
#' 
#' This function has been superseded by the [unix::eval_safe] function.
#' 
#' @export
#' @name sandboxing
#' @param ... arguments passed to [unix::eval_safe]
#' @importFrom unix eval_safe
eval.secure <- function(...){
  unix::eval_safe(...)
}

#' eval.secure
#' 
#' The `eval.secure` function has moved into the unix package and is now
#' an alias for [unix::eval_safe][unix::eval_safe]. Please switch over
#' to this new function.
#' 
#' @name eval.secure
#' @aliases eval.secure
NULL


#' @importFrom unix eval_safe
#' @export
eval.secure <- eval_safe

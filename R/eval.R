#' @importFrom unix eval_safe
eval_secure <- function(...){
  unix::eval_safe(...)
}

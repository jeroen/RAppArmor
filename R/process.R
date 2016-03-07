#' Unix Process Utilities
#'
#' Read or set process properties.
#'
#' @rdname process
#' @param pid process ID
#' @param uid user ID
#' @param verbose emit some debugging output in C
#' @param gid group ID
#' @param prio priority value
#' @param signal kill signal
#' @references Ubuntu Manpage: \code{kill} - \emph{send signal to a process}. \url{http://manpages.ubuntu.com/manpages/precise/man2/kill.2.html}.
#' @useDynLib RAppArmor R_kill
#' @rdname process
#' @export
kill <- function(pid, signal = SIGTERM, verbose = FALSE){
	.Call(R_kill, pid, signal, verbose)
}

#' @useDynLib RAppArmor R_setuid
#' @rdname process
#' @export
setuid <- function(uid, verbose = FALSE){
  .Call(R_setuid, as.integer(uid), verbose)
}

#' @useDynLib RAppArmor R_getuid
#' @rdname process
#' @export
getuid <- function(){
  .Call(R_getuid)
}

#' @useDynLib RAppArmor R_setgid
#' @rdname process
#' @export
setgid <- function(gid, verbose = FALSE){
  .Call(R_setgid, as.integer(gid), verbose)
}

#' @useDynLib RAppArmor R_getgid
#' @rdname process
#' @export
getgid <- function(){
  .Call(R_getgid)
}

#' @useDynLib RAppArmor R_setpgid
#' @rdname process
#' @export
setpgid <- function(verbose = FALSE){
  pid <- Sys.getpid()
  .Call(R_setpgid, pid, verbose)
}

#' @useDynLib RAppArmor R_getpgid
#' @rdname process
#' @export
getpgid <- function(){
  .Call(R_getpgid)
}

#' @useDynLib RAppArmor R_setpriority
#' @rdname process
#' @export
setpriority <- function(prio, verbose = FALSE){
  .Call(R_setpriority, as.integer(prio), verbose)
}

#' @useDynLib RAppArmor R_getpriority
#' @rdname process
#' @export
getpriority <- function(){
  .Call(R_getpriority)
}

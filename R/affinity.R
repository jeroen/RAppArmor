#' Process Affinity
#'
#' Get/set the process's CPU affinity mask. The affinity mask binds the process to
#' specific core(s) within the machine. Not supported on all systems, [has_affinity()]
#' shows if this is available.
#'
#' Setting a process affinity allows for restricting the process to only use certain
#' cores in the machine. The cores are indexed by the operating system as 1 to [ncores()].
#' Calling [setaffinity()] with no arguments resets the process to use any of the 
#' available cores.
#'
#' Note that setaffinity is different from setting r_limit values in the sense that
#' it is not a one-way process. An unprivileged user can change the process affinity
#' to any value. In order to 'lock' an affinity value, one would have to manipulate
#' Linux capability value for CAP_SYS_NICE.
#'
#' @name affinity
#' @rdname affinity
#' @param cpus Which cpu cores to bind to: vector of integers between 1 and [ncores()]
#' @references [SCHED_SETAFFINITY(2)](https://man7.org/linux/man-pages/man2/sched_setaffinity.2.html)
#' @examples \dontrun{
#' # Current affinity
#' ncores()
#' getaffinity()
#' getaffinity_count()
#' 
#' # Restrict process to core number 1.
#' setaffinity(1)
#' getaffinity()
#' 
#' # Reset
#' setaffinity()
#' getaffinity()
#' }
#' @useDynLib RAppArmor R_setaffinity
#' @export
setaffinity <- function(cpus = 1:ncores()){
  cpus <- as.integer(cpus)
  if(any(cpus > ncores()))
    stop("CPU number out of range. Available cpus: ", paste(1:ncores(), collapse=","));
  .Call(R_setaffinity, cpus);
  getaffinity()
}

#' @useDynLib RAppArmor R_getaffinity_count
#' @rdname affinity
#' @export
getaffinity_count <- function(){
  .Call(R_getaffinity_count)
}

#' @useDynLib RAppArmor R_getaffinity
#' @rdname affinity
#' @export
getaffinity <- function(){
  which(.Call(R_getaffinity))
}

#' @useDynLib RAppArmor R_has_affinity
#' @rdname affinity
#' @export
has_affinity <- function(){
  .Call(R_has_affinity)
}

#' @useDynLib RAppArmor R_ncores
#' @rdname affinity
#' @export
ncores <- function(){
  .Call(R_ncores)
}

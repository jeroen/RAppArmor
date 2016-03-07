#' Resource Limits
#'
#' Get and set \href{http://linux.die.net/man/2/setrlimit}{RLIMIT}
#' values of the current process.
#'
#' @param softlim soft limit in bytes.
#' @param hardlim hard limit in bytes
#' @param pid id of the target process.
#' @param verbose print some C output (TRUE/FALSE)
#' @references Jeroen Ooms (2013). The RAppArmor Package: Enforcing Security Policies in {R} Using Dynamic Sandboxing on Linux. \emph{Journal of Statistical Software}, 55(7), 1-34. \url{http://www.jstatsoft.org/v55/i07/}.
#' @references Ubuntu Manpage: \code{getrlimit, setrlimit} - \emph{get/set resource limits}. \url{http://manpages.ubuntu.com/manpages/precise/man2/getrlimit.2.html}.
#' @example examples/limits.R
#' @rdname rlimit
#' @useDynLib RAppArmor R_rlimit_as
#' @export
rlimit_as <- function(hardlim = NULL, softlim = hardlim, pid = 0, verbose = FALSE){
	if(!is.null(hardlim) && hardlim >= 2*1024*1024*1024)
		warning("RLIMIT_AS can never be set higher than 2GB. See ?rlimit_as.")
	.Call(R_rlimit_as, hardlim, softlim, pid, verbose);
}

#' @rdname rlimit
#' @useDynLib RAppArmor R_rlimit_core
#' @export
rlimit_core <- function(hardlim = NULL, softlim = hardlim, pid = 0, verbose = FALSE){
  .Call(R_rlimit_core, hardlim, softlim, pid, verbose);
}

#' @rdname rlimit
#' @useDynLib RAppArmor R_rlimit_cpu
#' @export
#' @examples \dontrun{testfun <- function(){
#'   Sys.sleep(3);
#'   repeat{
#'     svd(matrix(rnorm(1e6,1e3)));
#'   }
#' };
#' #will be killed after 8 seconds (3s idle, 5s CPU):
#' system.time(eval.secure(testfun(), RLIMIT_CPU=5));
#'
#' #will be killed after 5 seconds
#' system.time(eval.secure(testfun(), timeout=5));}
rlimit_cpu <- function(hardlim = NULL, softlim = hardlim, pid = 0, verbose = FALSE){
	.Call(R_rlimit_cpu, hardlim, softlim, pid, verbose);
}

#' @rdname rlimit
#' @useDynLib RAppArmor R_rlimit_data
#' @export
rlimit_data <- function(hardlim = NULL, softlim = hardlim, pid = 0, verbose = FALSE){
	.Call(R_rlimit_data, hardlim, softlim, pid, verbose);
}


#' @rdname rlimit
#' @useDynLib RAppArmor R_rlimit_fsize
#' @export
rlimit_fsize <- function(hardlim = NULL, softlim = hardlim, pid = 0, verbose = FALSE){
	.Call(R_rlimit_fsize, hardlim, softlim, pid, verbose);
}

#' @rdname rlimit
#' @useDynLib RAppArmor R_rlimit_memlock
#' @export
rlimit_memlock <- function(hardlim = NULL, softlim = hardlim, pid = 0, verbose = FALSE){
	.Call(R_rlimit_memlock, hardlim, softlim, pid, verbose);
}

#' @rdname rlimit
#' @useDynLib RAppArmor R_rlimit_msgqueue
#' @export
rlimit_msgqueue <- function(hardlim = NULL, softlim = hardlim, pid = 0, verbose = FALSE){
	.Call(R_rlimit_msgqueue, hardlim, softlim, pid, verbose);
}

#' @rdname rlimit
#' @useDynLib RAppArmor R_rlimit_nice
#' @export
rlimit_nice <- function(hardlim = NULL, softlim = hardlim, pid = 0, verbose = FALSE){
	.Call(R_rlimit_nice, hardlim, softlim, pid, verbose);
}

#' @rdname rlimit
#' @useDynLib RAppArmor R_rlimit_nofile
#' @export
rlimit_nofile <- function(hardlim = NULL, softlim = hardlim, pid = 0, verbose = FALSE){
	.Call(R_rlimit_nofile, hardlim, softlim, pid, verbose);
}


#' @rdname rlimit
#' @useDynLib RAppArmor R_rlimit_nproc
#' @export
rlimit_nproc <- function(hardlim = NULL, softlim = hardlim, pid = 0, verbose = FALSE){
	.Call(R_rlimit_nproc, hardlim, softlim, pid, verbose);
}

#' @rdname rlimit
#' @useDynLib RAppArmor R_rlimit_rtprio
#' @export
rlimit_rtprio <- function(hardlim = NULL, softlim = hardlim, pid = 0, verbose = FALSE){
	.Call(R_rlimit_rtprio, hardlim, softlim, pid, verbose);
}

#' @rdname rlimit
#' @useDynLib RAppArmor R_rlimit_rttime
#' @export
rlimit_rttime <- function(hardlim = NULL, softlim = hardlim, pid = 0, verbose = FALSE){
	.Call(R_rlimit_rttime, hardlim, softlim, pid, verbose);
}

#' @rdname rlimit
#' @useDynLib RAppArmor R_rlimit_sigpending
#' @export
rlimit_sigpending <- function(hardlim = NULL, softlim = hardlim, pid = 0, verbose = FALSE){
	.Call(R_rlimit_sigpending, hardlim, softlim, pid, verbose);
}

#' @rdname rlimit
#' @useDynLib RAppArmor R_rlimit_stack
#' @export
rlimit_stack <- function(hardlim = NULL, softlim = hardlim, pid = 0, verbose = FALSE){
  .Call(R_rlimit_stack, hardlim, softlim, pid, verbose);
}

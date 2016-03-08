#' Secure evaluation
#'
#' Evaluate in a sandboxed environment.
#'
#' This function creates a fork, then sets rlimits, uid, gid, priority,
#' apparmor profile where specified, and then evaluates the expression
#' inside the fork. The return object of the evaluation is copied to
#' the parent process and returned by \code{\link{eval.secure}}. After
#' evaluation is done, the fork is immediately killed. If the timeout is
#' reached the fork is also killed and an error is raised.
#'
#' Evaluation of an expression using \code{\link{eval.secure}} has no
#' side effects on the current R session. Any assignments to the global
#' environment, changes in options, or library loadings done by the
#' evaluation will get lost, as we explicitly want to prevent this.
#' Only the return value of the expression will be copied to the
#' main process. Files saved to disk by the sandboxed evaluation (where
#' allowed by apparmor profile, etc) will also persist.
#'
#' Note that if the initial process does not have superuser rights,
#' rlimits can only be decreased and setuid/setgid might not work. In
#' this case, specifying an RLIMIT higher than the current value will
#' result in an error. Some of the rlimits can also be specified inside
#' of the apparmor profile. When a rlimit is set both in the profile and
#' through R, the more restrictive one will be effective.
#'
#' @param ... arguments passed on to \code{\link{eval}}.
#' @param uid integer or name of linux user. See \code{\link{setuid}}.
#' @param gid integer or name of linux group. See \code{\link{setgid}}.
#' @param priority priority. Value between -20 and 20. See \code{\link{setpriority}}.
#' @param profile AppArmor security profile. Has to be preloaded by Linux.
#' See \code{\link{aa_change_profile}}.
#' @param timeout timeout in seconds.
#' @param silent suppress output on stdout. See \code{\link{mcparallel}}.
#' @param verbose print some C output (TRUE/FALSE)
#' @param affinity which cpu(s) to use. See \code{\link{setaffinity}}.
#' @param closeAllConnections closes (and destroys) all user connections.
#' See \code{\link{closeAllConnections}}.
#' @param RLIMIT_AS hard limit passed on to \code{\link{rlimit_as}}.
#' @param RLIMIT_CORE hard limit passed on to \code{\link{rlimit_core}}.
#' @param RLIMIT_CPU hard limit passed on to \code{\link{rlimit_cpu}}.
#' @param RLIMIT_DATA hard limit passed on to \code{\link{rlimit_data}}.
#' @param RLIMIT_FSIZE hard limit passed on to \code{\link{rlimit_fsize}}.
#' @param RLIMIT_MEMLOCK hard limit passed on to \code{\link{rlimit_memlock}}.
#' @param RLIMIT_MSGQUEUE hard limit passed on to \code{\link{rlimit_msgqueue}}.
#' @param RLIMIT_NICE hard limit passed on to \code{\link{rlimit_nice}}.
#' @param RLIMIT_NOFILE hard limit passed on to \code{\link{rlimit_nofile}}.
#' @param RLIMIT_NPROC hard limit passed on to \code{\link{rlimit_nproc}}.
#' @param RLIMIT_RTPRIO hard limit passed on to \code{\link{rlimit_rtprio}}.
#' @param RLIMIT_RTTIME hard limit passed on to \code{\link{rlimit_rttime}}.
#' @param RLIMIT_SIGPENDING hard limit passed on to \code{\link{rlimit_sigpending}}.
#' @param RLIMIT_STACK hard limit passed on to \code{\link{rlimit_stack}}.
#' @importFrom parallel mcparallel mccollect
#' @importFrom tools SIGTERM SIGKILL
#' @export
#' @useDynLib RAppArmor
#' @references Jeroen Ooms (2013). The RAppArmor Package: Enforcing Security
#' Policies in {R} Using Dynamic Sandboxing on Linux. \emph{Journal of Statistical Software},
#' 55(7), 1-34. \url{http://www.jstatsoft.org/v55/i07/}.
#' @examples \dontrun{
#'## Restricting file access ##
#'eval.secure(list.files("/"))
#'eval.secure(list.files("/"), profile="r-base")
#'
#'eval.secure(system("ls /", intern=TRUE))
#'eval.secure(system("ls /", intern=TRUE), profile="r-base")
#'
#'## Limiting CPU time ##
#'cputest <- function(){
#'	A <- matrix(rnorm(1e7), 1e3);
#'	B <- svd(A);
#'}
#'
#'## setTimeLimit doesn't always work:
#'setTimeLimit(5);
#'cputest();
#'setTimeLimit();
#'
#'#timeout does work:
#'eval.secure(cputest(), timeout=5)
#'
#'## Limiting memory ##
#'A <- matrix(rnorm(1e8), 1e4);
#'B <- eval.secure(matrix(rnorm(1e8), 1e4), RLIMIT_AS = 100*1024*1024)
#'
#'## Limiting procs ##
#'forkbomb <- function(){
#'	repeat{
#'		parallel::mcparallel(forkbomb());
#'	}
#'}
#'
#'## Forkbomb is mitigated ##
#'eval.secure(forkbomb(), RLIMIT_NPROC=10)
#'}

eval.secure <- function(..., uid, gid, priority, profile, timeout=60,
	silent=FALSE, verbose=FALSE, affinity, closeAllConnections=FALSE,
	RLIMIT_AS, RLIMIT_CORE, RLIMIT_CPU, RLIMIT_DATA, RLIMIT_FSIZE, RLIMIT_MEMLOCK,
	RLIMIT_MSGQUEUE, RLIMIT_NICE, RLIMIT_NOFILE, RLIMIT_NPROC, RLIMIT_RTPRIO,
	RLIMIT_RTTIME, RLIMIT_SIGPENDING, RLIMIT_STACK){

	#convert linux username to gid
	if(!missing(gid) && is.character(gid)){
		gid <- userinfo(gid)$gid;
	}

	#convert linux username to uid
	if(!missing(uid) && is.character(uid)){
		uid <- userinfo(uid)$uid;
	}

  #This prevents some weird errors
  Sys.sleep(0.01)

	#Do everything in a fork
	myfork <- mcparallel({

		#set the process group
		#to do: somehow prevent forks from modifying process group.
		setpgid();

		#close connections
		if(isTRUE(closeAllConnections)) closeAllConnections();

		#linux stuff
		if(!missing(RLIMIT_AS)) rlimit_as(RLIMIT_AS, verbose=verbose);
		if(!missing(RLIMIT_CORE)) rlimit_core(RLIMIT_CORE, verbose=verbose);
		if(!missing(RLIMIT_CPU)) rlimit_cpu(RLIMIT_CPU, verbose=verbose);
		if(!missing(RLIMIT_DATA)) rlimit_data(RLIMIT_DATA, verbose=verbose);
		if(!missing(RLIMIT_FSIZE)) rlimit_fsize(RLIMIT_FSIZE, verbose=verbose);
		if(!missing(RLIMIT_MEMLOCK)) rlimit_memlock(RLIMIT_MEMLOCK, verbose=verbose);
		if(!missing(RLIMIT_MSGQUEUE)) rlimit_msgqueue(RLIMIT_MSGQUEUE, verbose=verbose);
		if(!missing(RLIMIT_NICE)) rlimit_nice(RLIMIT_NICE, verbose=verbose);
		if(!missing(RLIMIT_NOFILE)) rlimit_nofile(RLIMIT_NOFILE, verbose=verbose);
		if(!missing(RLIMIT_NPROC)) rlimit_nproc(RLIMIT_NPROC, verbose=verbose);
		if(!missing(RLIMIT_RTPRIO)) rlimit_rtprio(RLIMIT_RTPRIO, verbose=verbose);
		if(!missing(RLIMIT_RTTIME)) rlimit_rttime(RLIMIT_RTTIME, verbose=verbose);
		if(!missing(RLIMIT_SIGPENDING)) rlimit_sigpending(RLIMIT_SIGPENDING, verbose=verbose);
		if(!missing(RLIMIT_STACK)) rlimit_stack(RLIMIT_STACK, verbose=verbose);
		if(!missing(affinity)) setaffinity(affinity, verbose=verbose);
		if(!missing(priority)) setpriority(priority, verbose=verbose);
		if(!missing(gid)) setgid(gid, verbose=verbose);
		if(!missing(uid)) setuid(uid, verbose=verbose);
		if(!missing(profile)) aa_change_profile(profile, verbose=verbose);

		#Set the child proc in batch mode to avoid problems when it gets killed:
		options(device = grDevices::pdf);
		options(menu.graphics=FALSE);

		#evaluate expression
		eval(...);
	}, silent=silent);

	#collect result
  starttime <- Sys.time();
	myresult <- mccollect(myfork, wait=FALSE, timeout=timeout);
	enddtime <- Sys.time();
  totaltime <- as.numeric(enddtime - starttime, units="secs")

	#try to avoid bug/race condition where mccollect returns null without waiting full timeout.
	#see https://github.com/jeroenooms/opencpu/issues/131
	#waits for max another 2 seconds if proc looks dead
	while(is.null(myresult) && totaltime < timeout && totaltime < 2) {
	  Sys.sleep(.1)
	  enddtime <- Sys.time();
	  totaltime <- as.numeric(enddtime - starttime, units="secs")
	  myresult <- mccollect(myfork, wait = FALSE, timeout = timeout);
	}

	#kill fork
	kill(myfork$pid, SIGKILL, verbose = verbose);

	#kill process group, in case of forks, etc.
	kill(-1* myfork$pid, SIGKILL, verbose = FALSE);

	#clean up
	mccollect(wait = FALSE);

	#timeout?
	if(is.null(myresult)){
    if(isTRUE(timeout > 0 && totaltime > timeout)){
		  stop("R call did not return within ", timeout, " seconds. Terminating process.", call.=FALSE);
    } else {
      stop("R call failed: process died.", call.=FALSE);
    }
	}

	output <- myresult[[1]]
	#forks don't throw errors themselves
	if(inherits(output, "try-error")){
		#stop(myresult, call.=FALSE);
		stop(attr(output, "condition"));
	}

	#return
	return(output);
}

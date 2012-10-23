#' Secure evaluation
#' 
#' Evaluate in a sandboxed environment.
#' 
#' This function creates a fork, and then sets any rlimits, uid, gid,
#' priority, apparmor profile where specified, and then evaluates the
#' expression inside the fork. After evaluation returns, the fork is 
#' killed. If the timeout is reached the fork is also killed and an
#' error is thrown.   
#' 
#' Evaluation of an expression through secure.eval should never have
#' any side effects on the current R session. This also means that if 
#' the code does e.g. assignments to the global environment, sets options(),
#' these will get lost, as we explicitly want to prevent this. However, if 
#' the expression saves any files (where allowed by apparmor), these will
#' still be available after the evaluation finishes.  
#' 
#' Note that if the initial process does not have superuser rights, 
#' rlimits can only be decreased and setuid/setgid might not work. In 
#' this case, specifying an RLIMIT higher than the current value will
#' result in an error. Some of the rlimits can also be specified inside
#' of the apparmor profile. When a rlimit is set both in the profile and
#' through R, the more restrictive one will be effective. 
#' 
#' @param ... arguments passed on to eval(...)
#' @param uid integer or name of linux user.
#' @param gid integer or name of linux group.
#' @param priority priority. Value between -20 and 20. 
#' @param profile AppArmor security profile. Has to be preloaded by Linux.
#' @param timeout timeout in seconds.
#' @param silent suppress output on stdout. See mcparallel().
#' @param verbose print some C output (TRUE/FALSE)
#' @param interactive TRUE/FALSE to enable/disable R interactive mode.
#' @param affinity which cpu(s) to use. See setaffinity.
#' @param RLIMIT_AS hard limit passed on to rlimit_as()
#' @param RLIMIT_CORE hard limit passed on to rlimit_core()
#' @param RLIMIT_CPU hard limit passed on to rlimit_cpu()
#' @param RLIMIT_DATA hard limit passed on to rlimit_data()
#' @param RLIMIT_FSIZE hard limit passed on to rlimit_fsize()
#' @param RLIMIT_MEMLOCK hard limit passed on to rlimit_memlock()
#' @param RLIMIT_MSGQUEUE hard limit passed on to rlimit_msgqueue()
#' @param RLIMIT_NICE hard limit passed on to rlimit_nice()
#' @param RLIMIT_NOFILE hard limit passed on to rlimit_nofile()
#' @param RLIMIT_NPROC hard limit passed on to rlimit_nproc()
#' @param RLIMIT_RTPRIO hard limit passed on to rlimit_rtprio()
#' @param RLIMIT_RTTIME hard limit passed on to rlimit_rttime()
#' @param RLIMIT_SIGPENDING hard limit passed on to rlimit_sigpending()
#' @param RLIMIT_STACK hard limit passed on to rlimit_stack()
#' @import parallel tools methods
#' @export
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
	silent=FALSE, verbose=FALSE, interactive=FALSE, affinity,
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
	
	#Do everything in a fork
	myfork <- mcparallel({
		
		#set the process group
		#to do: somehow prevent forks from modifying process group.
		setpgid(verbose=FALSE);
		
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
		if(interactive == FALSE){
			setinteractive(FALSE);
			options(device=pdf);
			options(menu.graphics=FALSE);
		}
		
		#evaluate expression
		eval(...);
	}, silent=silent);	

	#collect result
	myresult <- mccollect(myfork, wait=FALSE, timeout=timeout);
	
	#kill fork
	kill(myfork$pid, SIGKILL, verbose=verbose);
	
	#kill process group, in case of forks, etc.
	kill(-1* myfork$pid, SIGKILL, verbose=verbose);
	
	#clean up
	mccollect(wait=FALSE);
	
	#timeout?
	if(is.null(myresult)){
		stop("R call did not return within ", timeout, " seconds. Terminating process.", call.=FALSE);		
	}
	
	output <- myresult[[1]]
	#forks don't throw errors themselves
	if(is(output, "try-error")){
		#stop(myresult, call.=FALSE);
		stop(attr(output, "condition"));
	}	
	
	#return
	return(output);
}
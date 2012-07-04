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
#' @import parallel tools
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

eval.secure <- function(..., uid, gid, priority, profile, timeout=60, silent=FALSE,
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
		if(!missing(RLIMIT_AS)) rlimit_as(RLIMIT_AS);
		if(!missing(RLIMIT_CORE)) rlimit_core(RLIMIT_CORE);
		if(!missing(RLIMIT_CPU)) rlimit_cpu(RLIMIT_CPU);
		if(!missing(RLIMIT_DATA)) rlimit_data(RLIMIT_DATA);
		if(!missing(RLIMIT_FSIZE)) rlimit_fsize(RLIMIT_FSIZE);
		if(!missing(RLIMIT_MEMLOCK)) rlimit_memlock(RLIMIT_MEMLOCK);
		if(!missing(RLIMIT_MSGQUEUE)) rlimit_msgqueue(RLIMIT_MSGQUEUE);
		if(!missing(RLIMIT_NICE)) rlimit_nice(RLIMIT_NICE);
		if(!missing(RLIMIT_NOFILE)) rlimit_nofile(RLIMIT_NOFILE);
		if(!missing(RLIMIT_NPROC)) rlimit_nproc(RLIMIT_NPROC);
		if(!missing(RLIMIT_RTPRIO)) rlimit_rtprio(RLIMIT_RTPRIO);
		if(!missing(RLIMIT_RTTIME)) rlimit_rttime(RLIMIT_RTTIME);
		if(!missing(RLIMIT_SIGPENDING)) rlimit_sigpending(RLIMIT_SIGPENDING);
		if(!missing(RLIMIT_STACK)) rlimit_stack(RLIMIT_STACK);
		if(!missing(priority)) setpriority(priority);
		if(!missing(gid)) setgid(gid);
		if(!missing(uid)) setuid(uid);		
		if(!missing(profile)) aa_change_profile(profile);
		eval(...);
	}, silent=silent);	

	#collect result
	myresult <- mccollect(myfork, wait=FALSE, timeout=timeout);
	
	#kill fork
	pskill(myfork$pid, SIGKILL);
	mccollect();
	
	#timeout?
	if(is.null(myresult)){
		stop("R call did not return within ", timeout, " seconds. Terminating process.", call.=FALSE);		
	}
	
	output <- myresult[[1]]
	#forks don't throw errors themselves
	if(class(output) == "try-error"){
		#stop(myresult, call.=FALSE);
		stop(attr(output, "condition"));
	}	
	
	#return
	return(output);
}
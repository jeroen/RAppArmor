#' Secure evaluation
#' 
#' Evaluate in a sandboxed environment.
#' 
#' @param ... stuff to pass to eval(...)
#' @param uid integer or name of linux user.
#' @param gid integer or name of linux group.
#' @param priority priority. Value between -20 and 20. 
#' @param profile AppArmor security profile. Has to be preloaded.
#' @param timeout timeout in seconds.
#' @param silent passed on to mcparallel()
#' @import parallel tools
#' @export
eval.secure <- function(..., uid, gid, priority, profile, timeout=60, silent=TRUE){	

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
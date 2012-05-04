#' Lookup user info
#' 
#' Function looks up uid, gid, and userinfo for a given username.
#' 
#' @param username character name identifying the loginname of the user. 
#' @param uid integer specifying the uid of the user to lookup.
#' @param gid integer specifying the gid to lookup.
#' @return a parsed row from /etc/passwd
#' @export
userinfo <- function(username, uid, gid){
	allusers <- read.table("/etc/passwd", sep=":");
	names(allusers) <- c("username", "pw",  "uid", "gid", "userinfo", "home", "shell");	
	if(!missing(username)){
		username <- as.character(username);
		user <- allusers[allusers$username == username,];		
		if(nrow(user) == 0) stop("user ", username, " not found.");		
	} else if(!missing(uid)){
		uid <- as.character(uid);
		user <- allusers[allusers$uid == uid,];
		if(nrow(user) == 0) stop("user ", uid, " not found.");
	} else if(!missing(gid)){
		gid <- as.character(gid);
		user <- allusers[allusers$gid == gid,];
		if(nrow(user) == 0) stop("group ", gid, " not found.");
	} else{
		stop("Either username or uid or gid has to be specified.")
	}
	return(user)
}

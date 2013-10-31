#' Change hats
#' 
#' A hat is a subprofile which name starts with a '^'.
#' The difference between hats and profiles is that one can escape (revert) from the hat using the token.
#' Hence this provides more limited security than a profile.
#' 
#' @param subprofile character string identifying the subprofile (hat) name (without the "^")
#' @param magic_token a number that will be the key to revert out of the hat.
#' @param verbose print some C output (TRUE/FALSE)
#' @aliases aa_revert_hat
#' @export aa_change_hat aa_revert_hat
#' @references Jeroen Ooms (2013). The RAppArmor Package: Enforcing Security Policies in {R} Using Dynamic Sandboxing on Linux. \emph{Journal of Statistical Software}, 55(7), 1-34. \url{http://www.jstatsoft.org/v55/i07/}.
#' @references Ubuntu Manpage: \code{aa_change_hat} - \emph{change to or from a "hat" within a AppArmor profile}. \url{http://manpages.ubuntu.com/manpages/precise/man2/aa_change_hat.2.html}.
#' @examples \dontrun{
#' aa_change_profile("testprofile");
#' aa_getcon();
#' test <- read.table("/etc/group");
#' aa_change_hat("testhat", 13337);
#' aa_getcon();
#' test <- read.table("/etc/group");
#' aa_revert_hat(13337);
#' test <- read.table("/etc/group");
#' }
aa_change_hat <- function(subprofile, magic_token, verbose=TRUE){
	if(!is.character(subprofile) || length(subprofile) == 0){
		stop("subprofile must be a valid profile. E.g. /usr/bin/R or /usr/bin/R//localprofile")
	}
	verbose <- as.integer(verbose)
	magic_token <- as.integer(magic_token);
	ret <- integer(1);
	output <- .C('aa_change_hat_wrapper', ret, subprofile, magic_token, verbose, PACKAGE="RAppArmor")
	if(output[[1]] != 0) {
		ermsg <- errno(output[[1]]);
		ermsg <- switch(ermsg,
			EINVAL = "The apparmor kernel module is not loaded or the communication via the /proc/*/attr/current file did not conform to protocol",
			ENOMEM = "Insufficient kernel memory was available.",
			EPERM = "The calling application is not confined by apparmor. The hat you are trying to change to is not a subprofile of the current profile.",
			ECHILD = "The application's profile has no hats defined for it.",
			EACCES = "The specified subprofile does not exist in this profile or the process tried to change another process's domain.",
			ENOENT = paste("Subprofile not found. Make sure your current profile contains a subprofile named: ^", subprofile, sep=""),
			ermsg
		);
		stop("Failed to change hat\n", ermsg);
	}
	invisible();
}

aa_revert_hat <- function(magic_token, verbose=TRUE){
	verbose <- as.integer(verbose)
	magic_token <- as.integer(magic_token);
	ret <- integer(1);
	output <- .C('aa_revert_hat_wrapper', ret, magic_token, verbose, PACKAGE="RAppArmor")
	if(output[[1]] != 0) {
		ermsg <- errno(output[[1]]);
		ermsg <- switch(ermsg,
			EINVAL = "The apparmor kernel module is not loaded or the communication via the /proc/*/attr/current file did not conform to protocol",
			ENOMEM = "Insufficient kernel memory was available.",
			EPERM = "The calling application is not confined by apparmor.",
			ECHILD = "The application's profile has no hats defined for it.",
			EACCES = "The specified subprofile does not exist in this profile or the process tried to change another process's domain.",
			ermsg
		);
		stop("Failed to revert hat\n", ermsg);
	}
	invisible();	
}

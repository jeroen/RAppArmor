#' Change hats
#'
#' A hat is a subprofile which name starts with a '^'.
#' The difference between hats and profiles is that one can escape (revert) from the hat using the token.
#' Hence this provides more limited security than a profile.
#'
#' @param subprofile character string identifying the subprofile (hat) name (without the "^")
#' @param magic_token a number that will be the key to revert out of the hat.
#' @rdname apparmor
#' @name apparmor
#' @useDynLib RAppArmor R_aa_change_hat
#' @export
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
aa_change_hat <- function(subprofile, magic_token){
	if(!is.character(subprofile) || length(subprofile) == 0){
		stop("subprofile must be a valid profile. E.g. /usr/bin/R or /usr/bin/R//localprofile")
	}
  stopifnot(is.numeric(magic_token))
  .Call(R_aa_change_hat, subprofile, magic_token)
  invisible(TRUE)
}

#' @rdname apparmor
#' @useDynLib RAppArmor R_aa_revert_hat
#' @export
aa_revert_hat <- function(magic_token){
  stopifnot(is.numeric(magic_token))
	.Call(R_aa_revert_hat, magic_token)
	invisible(TRUE)
}

#' This function changes the current R process to an AppArmor profile.
#' Note that this generally is a one way process: most profiles explicitly prevent switching into another profile, otherwise it would defeat the purpose.
#'
#' @param profile character string with the name of the profile.
#' @rdname apparmor
#' @export
#' @useDynLib RAppArmor R_aa_change_profile
#' @examples  \dontrun{
#' test <- read.table("/etc/passwd");
#' aa_change_profile("testprofile");
#' aa_getcon();
#' test <- read.table("/etc/passwd");
#' }
aa_change_profile <- function(profile){
  tryCatch(.Call(R_aa_change_profile, profile), error = function(errmsg){
    if(grepl("permission", errmsg, ignore.case = TRUE)){
      out <- try(aa_getcon());
      if(class(out) != "try-error" && out$con != "unconfined"){
        if(out$con == "/usr/bin/R")
          warning("The standard profile in usr.bin.r is already being enforced!\n  Run sudo aa-disable usr.bin.r to disable this.", call. = FALSE);
        stop("Failed to change profile from: ", out$con, " to: ", profile, ".\n  Note that this is only allowed if the current profile has a 'change_profile -> ",profile,"' directive.", call. = FALSE);
      }
    }
    stop(errmsg, call. = FALSE)
  });
}

#' Find the apparmor mountpoint
#'
#' @rdname apparmor
#' @useDynLib RAppArmor R_aa_find_mountpoint
#' @export
aa_find_mountpoint <- function(){
  .Call(R_aa_find_mountpoint)
}

#' We can use this function to see if there is an AppArmor
#' profile associated with the current process, and in which
#' mode it current is set (enforce, complain, disable).
#'
#' Note that in order for this function to do its work, it needs
#' read access to the attributes of the current process. If aa_getcon
#' fails with a permission denied error, it might actually mean
#' that the current process is being confined with a very restrictive
#' profile.
#' 
#' @rdname apparmor
#' @useDynLib RAppArmor R_aa_getcon
#' @export
aa_getcon <- function(){
  output <- .Call(R_aa_getcon)
  list(con=output[1], mode=output[2])
}

#' This function tries to lookup the status of AppArmor in the kernel. However,
#' some confined profiles might not have enough privileges to lookup this status.
#' Also see aa_getcon().
#'
#' @rdname apparmor
#' @useDynLib RAppArmor R_aa_is_enabled
#' @export
aa_is_enabled <- function(){
  .Call(R_aa_is_enabled)
}

#' @rdname apparmor
#' @useDynLib RAppArmor R_aa_is_compiled
#' @export
aa_is_compiled <- function(){
  .Call(R_aa_is_compiled)
}

.onAttach <- function(libname, pkgname){
	#note: aa_is_enabled requires more privileges than aa_getcon.
	#so it is safer to rely on aa_getcon to lookup the current situation
	confinement <- try(aa_getcon(verbose=FALSE), silent=TRUE);
	if(inherits(confinement, "try-error")){
		#aa_getcon failed. Probably LSM is disabled.
		errormessage <- attr(confinement, "condition")$message;
		packageStartupMessage("Failed to lookup process confinement:\n", errormessage);
		packageStartupMessage("Have a look at: sudo aa-status")
	} else if(confinement$con == "unconfined"){
		#process seems unconfined. Lets see if apparmor is enabled...
		enabled <- try(aa_is_enabled(verbose=FALSE));
		if(inherits(enabled, "try-error")){
			#should never happen
			packageStartupMessage("aa_is_enabled() failed.")
		} else if(enabled == TRUE){
			packageStartupMessage("AppArmor LSM is enabled.")
			packageStartupMessage("Current profile: none (unconfined).")
			packageStartupMessage("See ?aa_change_profile on how switch profiles.")
		} else {
			#print some debugging stuff
			#note that enabled == FALSE might also occus becuase of permission denied at aa_is_enabled
			aa_is_enabled(verbose=TRUE);
		}
	} else {
		packageStartupMessage("AppArmor LSM is enabled.")
		packageStartupMessage("Current profile: ", confinement$con, " (", confinement$mode, " mode)");
	}
}

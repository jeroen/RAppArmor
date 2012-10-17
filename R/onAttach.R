.onAttach <- function(libname, pkgname){
	#note: aa_is_enabled will return an error when a profile is in enforce mode.
	confinement <- try(aa_getcon(verbose=FALSE));		
	if(confinement$con == "unconfined"){
		#process seems unconfined. Lets see if apparmor is enabled at all.
		enabled <- try(aa_is_enabled(verbose=FALSE));
		if(is(enabled, "try-error")){
			#should never happen
			packageStartupMessage("aa_is_enabled failed.")
		} else if(enabled == TRUE){
			packageStartupMessage("AppArmor is enabled.")
			packageStartupMessage("Current profile: none (unconfined).")
			packageStartupMessage("See ?aa_change_profile on how switch profiles.")
		} else {
			#print some debugging stuff
			#note that enabled == FALSE might also occus becuase of permission denied at aa_is_enabled
			aa_is_enabled(verbose=TRUE);
		}
	} else {
		packageStartupMessage("AppArmor is enabled.")
		packageStartupMessage("Current profile: ", confinement$con, " (", confinement$mode, " mode)");
	}		
}
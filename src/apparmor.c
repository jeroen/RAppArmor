#include <Rinternals.h>
#include <string.h>
#include <errno.h>

#ifndef NO_APPARMOR
#include <sys/apparmor.h>
#endif

void rapparmor_error(){
  switch(errno){
    case EINVAL: 
      Rf_error("The apparmor kernel module is not loaded"); 
      break;
    case ENOMEM: 
      Rf_error("Insufficient kernel memory was available"); 
      break;
    case EPERM: 
      Rf_error("The calling application is not confined by apparmor or the specified subprofile is not a hat profile");
      break;
    case ECHILD: 
      Rf_error("The application's profile has no hats defined for it");
      break;
    case ENOENT: 
      Rf_error("The specified profile or hat does not exist");
      break;
    case EACCES: 
      Rf_error("Permissions to change to the specified profile has been denied");
      break;
    case ERANGE: 
      Rf_error("The confinement data is to large to fit in the supplied buffer");
      break;
    default: Rf_error(strerror(errno));
  };
}

void rapparmor_warning(){
  switch(errno){
    case ENOSYS: 
      Rf_warning("AppArmor extensions to the system are not available.");
      break;
    case ECANCELED: 
      Rf_warning("AppArmor is available on the system but has been disabled at boot.");
      break;
    case ENOENT: 
      Rf_warning("AppArmor is available but the interface is not available.");
      break;
    case EACCES: 
      Rf_warning("Did not have sufficient permissions to determine if AppArmor is enabled.");
      break;
    case EPERM: 
      Rf_warning("Did not have sufficient permissions to determine if AppArmor is enabled.");
      break;
    default:
      Rf_warning(strerror(errno));
  };
}

SEXP R_aa_change_hat(SEXP subprofile, SEXP magic_token, SEXP verbose) {
#ifdef NO_APPARMOR
  Rf_error("AppArmor not supported on this system");
#else
  if(asLogical(verbose))
    Rprintf("Setting AppArmor Hat...\n");
  int token = (unsigned long) asReal(magic_token);
  if(aa_change_hat(CHAR(STRING_ELT(subprofile, 0)), token))
    rapparmor_error();
  return ScalarLogical(TRUE);
#endif //NO_APPARMOR
}

SEXP R_aa_revert_hat(SEXP magic_token, SEXP verbose) {
#ifdef NO_APPARMOR
  Rf_error("AppArmor not supported on this system");
#else
  if(asLogical(verbose))
    Rprintf("Reverting AppArmor Hat...\n");
  int token = (unsigned long) asReal(magic_token);
  if(aa_change_hat(NULL,  token))
    rapparmor_error();
  return ScalarLogical(TRUE);
#endif //NO_APPARMOR
}

SEXP R_aa_change_profile(SEXP profile, SEXP verbose) {
#ifdef NO_APPARMOR
  Rf_error("AppArmor not supported on this system");
#else
  if(asLogical(verbose))
    Rprintf("Switching profiles...\n");
  if(aa_change_profile (CHAR(STRING_ELT(profile, 0))))
    rapparmor_error();
  return ScalarLogical(TRUE);
#endif //NO_APPARMOR
}

SEXP R_aa_find_mountpoint(SEXP verbose) {
#ifdef NO_APPARMOR
  Rf_error("AppArmor not supported on this system");
#else
  if(asLogical(verbose))
    Rprintf("Finding mountpoint...\n");
  char *mnt;
  if(aa_find_mountpoint (&mnt))
    rapparmor_error();
  return mkString(mnt);
#endif //NO_APPARMOR
}

SEXP R_aa_getcon(SEXP verbose){
#ifdef NO_APPARMOR
  Rf_error("AppArmor not supported on this system");
#else
  if(asLogical(verbose))
    Rprintf("Getting task confinement information...\n");

  char *newcon = NULL;
  char *newmode = NULL;
  if(aa_getcon (&newcon, &newmode) < 0)
    rapparmor_error();
  SEXP out = PROTECT(allocVector(STRSXP, 2));
  if(newcon)
    SET_STRING_ELT(out, 0, mkChar(newcon));
  if(newmode)
    SET_STRING_ELT(out, 1, mkChar(newmode));
  UNPROTECT(1);
  return out;
#endif //NO_APPARMOR
}

SEXP R_aa_is_enabled(SEXP verbose){
#ifdef NO_APPARMOR
  return ScalarLogical(FALSE);
#else
  if(asLogical(verbose))
    Rprintf("Checking Apparmor Status...\n");
  int enabled = aa_is_enabled();
  if(!enabled)
    rapparmor_warning();
  return ScalarLogical(enabled);
#endif //NO_APPARMOR
}

SEXP R_aa_is_compiled(){
#ifdef NO_APPARMOR
  return ScalarLogical(FALSE);
#else
  return ScalarLogical(TRUE);
#endif
}

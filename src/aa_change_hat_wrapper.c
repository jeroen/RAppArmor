#include <R.h>
#include <Rinternals.h>
#include <Rinterface.h>
#include <R_ext/Rdynload.h>
#include <sys/apparmor.h>
#include <errno.h>
#include <stdbool.h>

void aa_change_hat_wrapper (int *ret, char **subprofile, unsigned long* magic_token, bool *verbose) {
  if(*verbose){
	  Rprintf("Setting AppArmor Hat...\n");
  }
  *ret = aa_change_hat (*subprofile,  *magic_token);
  if(*ret != 0){
    *ret = errno;
  }  
}

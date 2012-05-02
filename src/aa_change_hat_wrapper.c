#include <R.h>
#include <Rinternals.h>
#include <Rinterface.h>
#include <R_ext/Rdynload.h>
#include <sys/apparmor.h>
#include <errno.h>

void aa_change_hat_wrapper (int *ret, char **subprofile, unsigned long* magic_token) {
  Rprintf("Setting Apparmor Hat...\n");  
  *ret = aa_change_hat (*subprofile,  *magic_token);
  if(*ret != 0){
    *ret = errno;
  }  
}

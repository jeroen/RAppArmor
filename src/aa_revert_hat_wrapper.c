#include <R.h>
#include <Rinternals.h>
#include <Rinterface.h>
#include <R_ext/Rdynload.h>
#include <sys/apparmor.h>
#include <errno.h>

void aa_revert_hat_wrapper (int *ret, unsigned long* magic_token) {
  Rprintf("Reverting AppArmor Hat...\n");
  char *nothing = NULL;
  *ret = aa_change_hat (nothing, *magic_token);
  if(*ret != 0){
    *ret = errno;
  }  
}



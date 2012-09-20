#include <R.h>
#include <Rinternals.h>
#include <Rinterface.h>
#include <R_ext/Rdynload.h>
#include <sys/apparmor.h>
#include <errno.h>
#include <stdbool.h>

void aa_is_enabled_wrapper (int *ret, bool *verbose) {
  if(*verbose){
	  Rprintf("Checking Apparmor Status...\n");
  }
  *ret = aa_is_enabled();
  if(*ret == 1){
    *ret = -999;
  } else {
    *ret = errno;
  }
}

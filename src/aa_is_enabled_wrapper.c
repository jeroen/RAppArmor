#include <R.h>
#include <Rinternals.h>
#include <Rinterface.h>
#include <R_ext/Rdynload.h>
#include <sys/apparmor.h>
#include <errno.h>

void aa_is_enabled_wrapper (int *ret) {
  Rprintf("Checking Apparmor Status...\n");  
  *ret = aa_is_enabled();
  if(*ret == 1){
    *ret = -999;
  } else {
    *ret = errno;
  }
}
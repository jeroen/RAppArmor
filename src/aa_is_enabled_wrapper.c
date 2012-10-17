#include <R.h>
#include <Rinternals.h>
#include <Rinterface.h>
#include <R_ext/Rdynload.h>
#include <sys/apparmor.h>
#include <errno.h>
#include <stdbool.h>

void aa_is_enabled_wrapper (int *ret, bool *verbose, char **ermsg) {
  
  if(*verbose){
	  Rprintf("Checking Apparmor Status...\n");
  }
  *ret = aa_is_enabled();
  if(*ret == 1){
    *ret = -999;
  } else {
    *ret = errno;
    switch ( errno ) {
      case ENOSYS: ermsg[0] = "ENOSYS"; break;
      case ECANCELED: ermsg[0] = "ECANCELED"; break;
      case ENOENT: ermsg[0] = "ENOENT"; break;
      case ENOMEM: ermsg[0] = "ENOMEM"; break;
      case EPERM: ermsg[0] = "EPERM"; break;
      case EACCES: ermsg[0] = "EACCES"; break;
    }    
  }
}

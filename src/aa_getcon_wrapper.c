#include <R.h>
#include <Rinternals.h>
#include <Rinterface.h>
#include <R_ext/Rdynload.h>
#include <sys/apparmor.h>
#include <errno.h>
#include <string.h>
#include <stdbool.h>

void aa_getcon_wrapper (int *ret, char **con, char **mode, bool *verbose, char **ermsg) {
  if(*verbose){
	  Rprintf("Getting task confinement information...\n");
  }
  
  // just to test if assignment works
  *mode = "";
  *con = "";  
  
  //for getcon output
  char *newcon;
  char *newmode;
  int out;
  
  //actual call
  out = aa_getcon (&newcon, &newmode);
  if(out == -1){
    *ret = errno;
    
    switch ( errno ) {
      case EINVAL: ermsg[0] = "EINVAL"; break;
      case ENOMEM: ermsg[0] = "ENOMEM"; break;
      case EACCES: ermsg[0] = "EACCES"; break;
      case ENOENT: ermsg[0] = "ENOENT"; break;
      case ERANGE: ermsg[0] = "ERANGE"; break;
    }       
    
  } else {
    *ret = 0;
    *con = newcon;
    if (newmode != NULL){
 	  *mode = newmode;         
    }
  }
}



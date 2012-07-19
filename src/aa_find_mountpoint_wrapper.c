#include <R.h>
#include <Rinternals.h>
#include <Rinterface.h>
#include <R_ext/Rdynload.h>
#include <sys/apparmor.h>
#include <errno.h>

void aa_find_mountpoint_wrapper (int *ret, char **mnt) {
  Rprintf("Finding mountpoint...\n");  
  *ret = aa_find_mountpoint (mnt);
  if(*ret != 0){
    *ret = errno;
  } 
}

#include <R.h>
#include <Rinternals.h>
#include <Rinterface.h>
#include <R_ext/Rdynload.h>
#include <sys/types.h>
#include <unistd.h>
#include <errno.h>
#include <stdbool.h>

void setgid_wrapper (int *ret, int *gid, bool *verbose) {
  if(*verbose){
	  Rprintf("Setting gid...\n");
  }
  *ret = setgid (*gid);
  if(*ret != 0){
    *ret = errno;
  }
}

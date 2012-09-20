#include <R.h>
#include <Rinternals.h>
#include <Rinterface.h>
#include <R_ext/Rdynload.h>
#include <sys/types.h>
#include <unistd.h>
#include <errno.h>
#include <stdbool.h>

void setpgid_wrapper (int *ret, int *pgid, bool *verbose) {
  if(*verbose){
	  Rprintf("Setting pgid...\n");
  }
  *ret = setpgid (0, *pgid);
  if(*ret != 0){
    *ret = errno;
  }
}

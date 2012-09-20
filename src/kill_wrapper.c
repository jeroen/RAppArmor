#include <R.h>
#include <Rinternals.h>
#include <Rinterface.h>
#include <R_ext/Rdynload.h>
#include <sys/types.h>
#include <unistd.h>
#include <errno.h>
#include <sys/types.h>
#include <signal.h>
#include <stdbool.h>

void kill_wrapper (int *ret, int *pid, int *sig, bool *verbose) {
  if(*verbose){
	  Rprintf("Killing process...\n");
  }
  *ret = kill (*pid, *sig);
  if(*ret != 0){
    *ret = errno;
  }
}

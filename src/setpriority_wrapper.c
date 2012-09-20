#include <R.h>
#include <Rinternals.h>
#include <Rinterface.h>
#include <R_ext/Rdynload.h>
#include <sys/time.h>
#include <sys/resource.h>
#include <errno.h>
#include <stdbool.h>

void setpriority_wrapper (int *ret, int *prio, bool *verbose) {
  if(*verbose){
	  Rprintf("Setting priority...\n");
  }
  *ret = setpriority(PRIO_PROCESS, 0, *prio);
  if(*ret != 0){
    *ret = errno;
  }
}

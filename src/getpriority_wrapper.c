#include <R.h>
#include <Rinternals.h>
#include <Rinterface.h>
#include <R_ext/Rdynload.h>
#include <sys/time.h>
#include <sys/resource.h>
#include <errno.h>

void getpriority_wrapper (int *ret) {
  errno = 10000;
  *ret = getpriority(PRIO_PROCESS, 0);
  if(errno != 10000){
    *ret = 10000 + errno;
  }
}
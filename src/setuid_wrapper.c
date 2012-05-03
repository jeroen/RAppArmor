#include <R.h>
#include <Rinternals.h>
#include <Rinterface.h>
#include <R_ext/Rdynload.h>
#include <sys/types.h>
#include <unistd.h>
#include <errno.h>

void setuid_wrapper (int *ret, int *uid) {
  Rprintf("Setting uid...\n");  
  *ret = setuid (*uid);
  if(*ret != 0){
    *ret = errno;
  }
}
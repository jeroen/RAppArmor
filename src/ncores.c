#include <R.h>
#include <Rinternals.h>
#include <Rinterface.h>
#include <R_ext/Rdynload.h>
#include <sys/time.h>
#include <sys/resource.h>
#include <unistd.h>

void ncores (int *ret) {
  *ret = sysconf( _SC_NPROCESSORS_ONLN );
}



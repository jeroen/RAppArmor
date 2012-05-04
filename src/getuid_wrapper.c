#include <R.h>
#include <Rinternals.h>
#include <Rinterface.h>
#include <R_ext/Rdynload.h>
#include <sys/types.h>
#include <unistd.h>
#include <errno.h>

void getuid_wrapper (int *ret) {
  *ret = getuid ();
}

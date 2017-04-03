#define _GNU_SOURCE
#include <sched.h>
#include <unistd.h>
#include <Rinternals.h>

// TODO: better feature test?
#if defined(__FreeBSD__) || defined(__linux__)
#define HAS_AFFINITY
#endif

void bail_if(int err, const char * what);

SEXP R_has_affinity(){
#ifdef HAS_AFFINITY
  return ScalarLogical(TRUE);
#else
  return ScalarLogical(FALSE);
#endif
}

SEXP R_getaffinity_count() {
#ifdef HAS_AFFINITY
  //init the cpu mask
  cpu_set_t mask;
  CPU_ZERO(&mask);
  bail_if(sched_getaffinity(0, sizeof mask, &mask) < 0, "sched_getaffinity()");
  
  //count number of enabled cores
  return ScalarInteger(CPU_COUNT(&mask));
#else 
  Rf_error("affinity not supported on this system");
#endif //HAS_AFFINITY
}

SEXP R_getaffinity() {
#ifdef HAS_AFFINITY
  //init the cpu mask
  cpu_set_t mask;
  CPU_ZERO(&mask);
  bail_if(sched_getaffinity(0, sizeof mask, &mask) < 0, "sched_getaffinity()");
  
  //read values
  int len = sysconf(_SC_NPROCESSORS_ONLN);
  SEXP out = PROTECT(allocVector(LGLSXP, len));
  for(int i = 0; i < len; i++)
    LOGICAL(out)[i] = CPU_ISSET(i, &mask);
  UNPROTECT(1);
  return(out);
#else 
  Rf_error("affinity not supported on this system");
#endif //HAS_AFFINITY  
}

SEXP R_setaffinity(SEXP cpus) {
#ifdef HAS_AFFINITY
  //init the cpu mask
  cpu_set_t mask;
  CPU_ZERO(&mask);
  
  //NOTE: cpu[i]-1 is because R indexes from 1 instead of 0.
  for (int i = 0; i < LENGTH(cpus); i++)
    CPU_SET(INTEGER(cpus)[i]-1, &mask);;
  bail_if(sched_setaffinity(0, sizeof mask, &mask) < 0, "sched_setaffinity()");
  return R_getaffinity();
#else 
  Rf_error("affinity not supported on this system");
#endif //HAS_AFFINITY  
}

SEXP R_ncores() {
  return ScalarInteger(sysconf( _SC_NPROCESSORS_ONLN ));
}

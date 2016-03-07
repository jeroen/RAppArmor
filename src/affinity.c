#define _GNU_SOURCE
#include <sched.h>
#include <unistd.h>
#include <Rinternals.h>

SEXP R_getaffinity_count(SEXP verbose) {
  if(asLogical(verbose))
	  Rprintf("Getting process affinity mask...\n");

  //init the cpu mask
  cpu_set_t mask;
  CPU_ZERO(&mask);
  if(sched_getaffinity(0, sizeof mask, &mask))
    Rf_error("failed to get affinity");

  //count number of enabled cores
  return ScalarInteger(CPU_COUNT(&mask));
}

SEXP R_getaffinity(SEXP verbose) {
  if(asLogical(verbose))
    Rprintf("Getting process affinity mask...\n");

  //init the cpu mask
  cpu_set_t mask;
  CPU_ZERO(&mask);
  if(sched_getaffinity(0, sizeof mask, &mask))
    Rf_error("failed to get affinity");

  //read values
  int len = sysconf(_SC_NPROCESSORS_ONLN);
  SEXP out = PROTECT(allocVector(LGLSXP, len));
  for(int i = 0; i < len; i++){
    LOGICAL(out)[i] = CPU_ISSET(i, &mask);
  }
  UNPROTECT(1);
  return(out);
}

SEXP R_setaffinity(SEXP cpus, SEXP verbose) {
  if(asLogical(verbose))
    Rprintf("Getting process affinity mask...\n");

  //init the cpu mask
  cpu_set_t mask;
  CPU_ZERO(&mask);

  //NOTE: cpu[i]-1 is because R indexes from 1 instead of 0.
  for (int i = 0; i < LENGTH(cpus); i++){
    CPU_SET(INTEGER(cpus)[i]-1, &mask);;
  }
  if(sched_setaffinity(0, sizeof mask, &mask))
    Rf_error("Failed to set affinity");
  return ScalarLogical(TRUE);
}

SEXP R_ncores() {
  return ScalarInteger(sysconf( _SC_NPROCESSORS_ONLN ));
}

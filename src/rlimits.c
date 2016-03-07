#define _GNU_SOURCE
#define _FILE_OFFSET_BITS 64
#include <Rinternals.h>
#include <sys/resource.h>
#include <errno.h>

SEXP R_rlimit(int resource, SEXP hardlim, SEXP softlim, SEXP pid, SEXP verbose);
SEXP R_rlimit_as(SEXP a, SEXP b, SEXP c, SEXP d) {return R_rlimit(RLIMIT_AS, a, b, c, d);}
SEXP R_rlimit_core(SEXP a, SEXP b, SEXP c, SEXP d) {return R_rlimit(RLIMIT_CORE, a, b, c, d);}
SEXP R_rlimit_cpu(SEXP a, SEXP b, SEXP c, SEXP d) {return R_rlimit(RLIMIT_CPU, a, b, c, d);}
SEXP R_rlimit_data(SEXP a, SEXP b, SEXP c, SEXP d) {return R_rlimit(RLIMIT_DATA, a, b, c, d);}
SEXP R_rlimit_fsize(SEXP a, SEXP b, SEXP c, SEXP d) {return R_rlimit(RLIMIT_FSIZE, a, b, c, d);}
SEXP R_rlimit_memlock(SEXP a, SEXP b, SEXP c, SEXP d) {return R_rlimit(RLIMIT_MEMLOCK, a, b, c, d);}
SEXP R_rlimit_msgqueue(SEXP a, SEXP b, SEXP c, SEXP d) {return R_rlimit(RLIMIT_MSGQUEUE, a, b, c, d);}
SEXP R_rlimit_nice(SEXP a, SEXP b, SEXP c, SEXP d) {return R_rlimit(RLIMIT_NICE, a, b, c, d);}
SEXP R_rlimit_nofile(SEXP a, SEXP b, SEXP c, SEXP d) {return R_rlimit(RLIMIT_NOFILE, a, b, c, d);}
SEXP R_rlimit_nproc(SEXP a, SEXP b, SEXP c, SEXP d) {return R_rlimit(RLIMIT_NPROC, a, b, c, d);}
SEXP R_rlimit_rtprio(SEXP a, SEXP b, SEXP c, SEXP d) {return R_rlimit(RLIMIT_RTPRIO, a, b, c, d);}
SEXP R_rlimit_rttime(SEXP a, SEXP b, SEXP c, SEXP d) {return R_rlimit(RLIMIT_RTTIME, a, b, c, d);}
SEXP R_rlimit_sigpending(SEXP a, SEXP b, SEXP c, SEXP d) {return R_rlimit(RLIMIT_SIGPENDING, a, b, c, d);}
SEXP R_rlimit_stack(SEXP a, SEXP b, SEXP c, SEXP d) {return R_rlimit(RLIMIT_STACK, a, b, c, d);}

SEXP R_rlimit(int resource, SEXP hardlim, SEXP softlim, SEXP pid, SEXP verbose){
  // to store new limit
  int update = (softlim != R_NilValue);
  struct rlimit new_limits;
  struct rlimit *ptr = &new_limits;
  if(update){
    new_limits.rlim_max = asReal(hardlim);
    new_limits.rlim_cur = asReal(softlim);
  } else {
    ptr = NULL;
  }

  // to store old limits
  struct rlimit old_limits;
  if(prlimit(asInteger(pid), resource, ptr, &old_limits)){
    if(asLogical(verbose)) Rprintf("Failed to set limit...\n");
    switch(errno){
      case EFAULT: Rf_error("A pointer argument points to a location outside the accessible address space.");
      case EINVAL: Rf_error("The value specified in resource is not valid; or, for setrlimit() or prlimit(): rlim->rlim_cur was greater than rlim->rlim_max.");
      case EPERM: Rf_error("An unprivileged process tried to raise the hard limit");
      case ESRCH: Rf_error("Could not find a process with the ID specified in pid");
      default: Rf_error("prlimit() failed with unknown reason");
    }
  }

  //print old limit
  if(asLogical(verbose)){
    Rprintf("Previous limits: soft=%lld; hard=%lld\n", (long long) old_limits.rlim_cur, (long long) old_limits.rlim_max);
    Rprintf("New limits: soft=%lld; hard=%lld\n", (long long) new_limits.rlim_cur, (long long) new_limits.rlim_max);
  }

  SEXP out = PROTECT(allocVector(VECSXP, 2));
  SET_VECTOR_ELT(out, 0, ScalarReal((double) update ? new_limits.rlim_max : old_limits.rlim_max));
  SET_VECTOR_ELT(out, 1, ScalarReal((double) update ? new_limits.rlim_cur : old_limits.rlim_cur));
  SEXP names = PROTECT(allocVector(STRSXP, 2));
  SET_STRING_ELT(names, 0, mkChar("hardlim"));
  SET_STRING_ELT(names, 1, mkChar("softlim"));
  setAttrib(out, R_NamesSymbol, names);
  UNPROTECT(2);
  return out;
}

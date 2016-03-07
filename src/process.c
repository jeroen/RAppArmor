#include <Rinternals.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/resource.h>
#include <errno.h>
#include <sys/prctl.h> //PR_SET_PDEATHSIG
#include <signal.h> //SIGKILL

SEXP R_kill(SEXP pid, SEXP sig, SEXP verbose){
  if(asLogical(verbose))
    Rprintf("Killing process %d with signal %d...\n", asInteger(pid), asInteger(sig));
  int err = kill(asInteger(pid), asInteger(sig));
  if(err){
    switch(errno){ //if proc already killed, only show warning
      case EINVAL: Rf_error("Invalid signal was specified.");
      case EPERM: Rf_error("Insufficient permission to signal target process.");
      case ESRCH: if(asLogical(verbose)) Rf_warning("The pid or process group does not exist."); break;
      default: Rf_error("kill() failed for unknown reason");
    }
  }
  return ScalarLogical(!err);
}

SEXP R_getuid(){
  return ScalarInteger(getuid());
}

SEXP R_setuid(SEXP id, SEXP verbose){
  if(asLogical(verbose))
    Rprintf("Setting process uid to %d", asInteger(id));
  if(setuid(asInteger(id))){
    switch(errno){
      case EAGAIN: Rf_error("Temporary failure in setuid()");
      case EINVAL: Rf_error("Invalid UID specified");
      case EPERM: Rf_error("Cannot move process into a different session");
      default: Rf_error("setuid() failed for unknown readon");
    }
  }
  return R_getuid();
}

SEXP R_getgid () {
  return ScalarInteger(getgid());
}

SEXP R_setgid(SEXP id, SEXP verbose){
  if(asLogical(verbose))
    Rprintf("Setting process gid to %d", asInteger(id));
  if(setgid(asInteger(id))){
    switch(errno){
      case EINVAL: Rf_error("Invalid group ID specified");
      case EPERM: Rf_error("Insufficient privileges for setgid()");
      default: Rf_error("setgid() failed for unknown readon");
    }
  }
  return R_getgid();
}

SEXP R_getpgid () {
  return ScalarInteger(getpgid(0));
}

SEXP R_setpgid(SEXP pid, SEXP verbose){
  if(asLogical(verbose))
    Rprintf("Setting process pgid to %d", asInteger(pid));
  if(setpgid(0, asInteger(pid))){
    switch(errno){
      case EACCES: Rf_error("Cannot change pgid after child has called execve()");
      case EINVAL: Rf_error("Invalid group ID specified");
      case EPERM: Rf_error("Cannot move process into a different session");
      case ESRCH: Rf_error("pid does not match any process.");
      default: Rf_error("setpgid() failed for unknown readon");
    }
  }
  //make sure proc doesn't orphan:
  prctl(PR_SET_PDEATHSIG, SIGKILL);
  return R_getpgid();
}

SEXP R_getpriority () {
  return ScalarInteger(getpriority(PRIO_PROCESS, 0));
}

SEXP R_setpriority(SEXP prio, SEXP verbose){
  if(asLogical(verbose))
    Rprintf("Setting process priority to %d", asInteger(prio));
  if(setpriority(PRIO_PROCESS, 0, asInteger(prio))){
    switch(errno){
      case ESRCH: Rf_error("Invalid process");
      case EACCES: Rf_error("Insufficient privileges to lower periority.");
      case EPERM: Rf_error("User does not have permission on this process");
      default: Rf_error("Unknown error in setpriority().");
    }
  }
  return R_getpriority();
}

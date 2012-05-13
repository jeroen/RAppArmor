#define _GNU_SOURCE
#define _FILE_OFFSET_BITS 64
#include <R.h>
#include <Rinternals.h>
#include <Rinterface.h>
#include <R_ext/Rdynload.h>
#include <sys/time.h>
#include <sys/resource.h>
#include <errno.h>

//declare main function
void rlimit_wrapper(int, int*, int*, int*, int*);

//declare wrappers for R functions
void rlimit_as(int*, int*, int*, int*);
void rlimit_core(int*, int*, int*, int*);
void rlimit_cpu(int*, int*, int*, int*);
void rlimit_data(int*, int*, int*, int*);
void rlimit_fsize(int*, int*, int*, int*);
void rlimit_memlock(int*, int*, int*, int*);
void rlimit_msgqueue(int*, int*, int*, int*);
void rlimit_nice(int*, int*, int*, int*);
void rlimit_nofile(int*, int*, int*, int*);
void rlimit_nproc(int*, int*, int*, int*);
void rlimit_rtprio(int*, int*, int*, int*);
void rlimit_rttime(int*, int*, int*, int*);
void rlimit_sigpending(int*, int*, int*, int*);
void rlimit_stack(int*, int*, int*, int*);


//wrappers for R functions:
void rlimit_as (int *ret, int *hardlim, int *softlim, int *pid) {
    Rprintf("RLIMIT_AS:\n");
	rlimit_wrapper(RLIMIT_AS, ret, hardlim, softlim, pid);
}

void rlimit_core (int *ret, int *hardlim, int *softlim, int *pid) {
    Rprintf("RLIMIT_CORE:\n");
	rlimit_wrapper(RLIMIT_CORE, ret, hardlim, softlim, pid);
}

void rlimit_cpu (int *ret, int *hardlim, int *softlim, int *pid) {
    Rprintf("RLIMIT_CPU:\n");
	rlimit_wrapper(RLIMIT_CPU, ret, hardlim, softlim, pid);
}

void rlimit_data (int *ret, int *hardlim, int *softlim, int *pid) {
    Rprintf("RLIMIT_DATA:\n");
	rlimit_wrapper(RLIMIT_DATA, ret, hardlim, softlim, pid);
}

void rlimit_fsize (int *ret, int *hardlim, int *softlim, int *pid) {
    Rprintf("RLIMIT_FSIZE:\n");
	rlimit_wrapper(RLIMIT_FSIZE, ret, hardlim, softlim, pid);
}

void rlimit_memlock (int *ret, int *hardlim, int *softlim, int *pid) {
    Rprintf("RLIMIT_MEMLOCK:\n");
	rlimit_wrapper(RLIMIT_MEMLOCK, ret, hardlim, softlim, pid);
}

void rlimit_msgqueue (int *ret, int *hardlim, int *softlim, int *pid) {
    Rprintf("RLIMIT_MSGQUEUE:\n");
	rlimit_wrapper(RLIMIT_MSGQUEUE, ret, hardlim, softlim, pid);
}

void rlimit_nice (int *ret, int *hardlim, int *softlim, int *pid) {
    Rprintf("RLIMIT_NICE:\n");
	rlimit_wrapper(RLIMIT_NICE, ret, hardlim, softlim, pid);
}

void rlimit_nofile (int *ret, int *hardlim, int *softlim, int *pid) {
    Rprintf("RLIMIT_NOFILE:\n");
	rlimit_wrapper(RLIMIT_NOFILE, ret, hardlim, softlim, pid);
}

void rlimit_nproc (int *ret, int *hardlim, int *softlim, int *pid) {
    Rprintf("RLIMIT_NPROC:\n");
	rlimit_wrapper(RLIMIT_NPROC, ret, hardlim, softlim, pid);
}

void rlimit_rtprio (int *ret, int *hardlim, int *softlim, int *pid) {
    Rprintf("RLIMIT_RTPRIO:\n");
	rlimit_wrapper(RLIMIT_RTPRIO, ret, hardlim, softlim, pid);
}

void rlimit_rttime (int *ret, int *hardlim, int *softlim, int *pid) {
    Rprintf("RLIMIT_RTTIME:\n");
	rlimit_wrapper(RLIMIT_RTTIME, ret, hardlim, softlim, pid);
}

void rlimit_sigpending (int *ret, int *hardlim, int *softlim, int *pid) {
    Rprintf("RLIMIT_SIGPENDING:\n");
	rlimit_wrapper(RLIMIT_SIGPENDING, ret, hardlim, softlim, pid);
}

void rlimit_stack (int *ret, int *hardlim, int *softlim, int *pid) {
    Rprintf("RLIMIT_STACK:\n");
	rlimit_wrapper(RLIMIT_STACK, ret, hardlim, softlim, pid);
}

//main function that calls out to Linux Kernel.
void rlimit_wrapper(int resource, int *ret, int *hardlim, int *softlim, int *pid){

  // target process
  pid_t mypid;
  mypid = *pid;
  
  // to store new limit
  struct rlimit new;
  new.rlim_max = *hardlim;
  new.rlim_cur = *softlim;
  
  // create a pointer
  struct rlimit *newp;
  newp = &new;
  
  // to store old limits
  struct rlimit old;

  if(*hardlim != -999){
	  // set the new limit
	  // if no soft limit was set, we set it equal to the hard limit.
	  if(*softlim == -999){
		  *softlim = *hardlim;
	  }
	  // call out to linux
	  *ret = prlimit(mypid, resource, newp, &old);
	  if(*ret != 0){
		Rprintf("Failed to set limit...\n");
		*ret = errno;
		return;
	  }

	  //print old limit
	  Rprintf("Previous limits: soft=%lld; hard=%lld\n", (long long) old.rlim_cur, (long long) old.rlim_max);
  } else if(*softlim != -999) {
	  //this is the case where only a soft limit was set
	  //we need to actually lookup the current hard limit.
	  getrlimit(resource, &old);
	  new.rlim_max = old.rlim_max;

	  // call out to linux
	  *ret = prlimit(mypid, resource, newp, &old);
	  if(*ret != 0){
		Rprintf("Failed to set limit...\n");
		*ret = errno;
		return;
	  }

	  //print old limit
	  Rprintf("Previous limits: soft=%lld; hard=%lld\n", (long long) old.rlim_cur, (long long) old.rlim_max);
  }
  // get the new values
  *ret = prlimit(mypid, resource, NULL, &old); 
  if(*ret != 0){
    Rprintf("Limit couldn't be read?\n");
    *ret = errno;
    return;
  }  
  
  //print new limits
  Rprintf("Current limits: soft=%lld; hard=%lld\n", (long long) old.rlim_cur, (long long) old.rlim_max);
  
}

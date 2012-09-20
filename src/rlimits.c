#define _GNU_SOURCE
#define _FILE_OFFSET_BITS 64
#include <R.h>
#include <Rinternals.h>
#include <Rinterface.h>
#include <R_ext/Rdynload.h>
#include <sys/time.h>
#include <sys/resource.h>
#include <errno.h>
#include <stdbool.h>

//declare main function
void rlimit_wrapper(int, int*, double*, double*, int*, bool*);

//declare wrappers for R functions
void rlimit_as(int*, double*, double*, int*, bool*);
void rlimit_core(int*, double*, double*, int*, bool*);
void rlimit_cpu(int*, double*, double*, int*, bool*);
void rlimit_data(int*, double*, double*, int*, bool*);
void rlimit_fsize(int*, double*, double*, int*, bool*);
void rlimit_memlock(int*, double*, double*, int*, bool*);
void rlimit_msgqueue(int*, double*, double*, int*, bool*);
void rlimit_nice(int*, double*, double*, int*, bool*);
void rlimit_nofile(int*, double*, double*, int*, bool*);
void rlimit_nproc(int*, double*, double*, int*, bool*);
void rlimit_rtprio(int*, double*, double*, int*, bool*);
void rlimit_rttime(int*, double*, double*, int*, bool*);
void rlimit_sigpending(int*, double*, double*, int*, bool*);
void rlimit_stack(int*, double*, double*, int*, bool*);


//wrappers for R functions:
void rlimit_as (int *ret, double *hardlim, double *softlim, int *pid, bool *verbose) {
    if(*verbose) {
    	Rprintf("RLIMIT_AS:\n");
    }
	rlimit_wrapper(RLIMIT_AS, ret, hardlim, softlim, pid, verbose);
}

void rlimit_core (int *ret, double *hardlim, double *softlim, int *pid, bool *verbose) {
    if(*verbose){
    	Rprintf("RLIMIT_CORE:\n");
    }
	rlimit_wrapper(RLIMIT_CORE, ret, hardlim, softlim, pid, verbose);
}

void rlimit_cpu (int *ret, double *hardlim, double *softlim, int *pid, bool *verbose) {
	if(*verbose){
		Rprintf("RLIMIT_CPU:\n");
	}
	rlimit_wrapper(RLIMIT_CPU, ret, hardlim, softlim, pid, verbose);
}

void rlimit_data (int *ret, double *hardlim, double *softlim, int *pid, bool *verbose) {
	if(*verbose){
		Rprintf("RLIMIT_DATA:\n");
	}
	rlimit_wrapper(RLIMIT_DATA, ret, hardlim, softlim, pid, verbose);
}

void rlimit_fsize (int *ret, double *hardlim, double *softlim, int *pid, bool *verbose) {
	if(*verbose){
		Rprintf("RLIMIT_FSIZE:\n");
	}
	rlimit_wrapper(RLIMIT_FSIZE, ret, hardlim, softlim, pid, verbose);
}

void rlimit_memlock (int *ret, double *hardlim, double *softlim, int *pid, bool *verbose) {
	if(*verbose){
		Rprintf("RLIMIT_MEMLOCK:\n");
	}
	rlimit_wrapper(RLIMIT_MEMLOCK, ret, hardlim, softlim, pid, verbose);
}

void rlimit_msgqueue (int *ret, double *hardlim, double *softlim, int *pid, bool *verbose) {
	if(*verbose){
		Rprintf("RLIMIT_MSGQUEUE:\n");
	}
	rlimit_wrapper(RLIMIT_MSGQUEUE, ret, hardlim, softlim, pid, verbose);
}

void rlimit_nice (int *ret, double *hardlim, double *softlim, int *pid, bool *verbose) {
	if(*verbose){
		Rprintf("RLIMIT_NICE:\n");
	}
	rlimit_wrapper(RLIMIT_NICE, ret, hardlim, softlim, pid, verbose);
}

void rlimit_nofile (int *ret, double *hardlim, double *softlim, int *pid, bool *verbose) {
	if(*verbose){
		Rprintf("RLIMIT_NOFILE:\n");
	}
	rlimit_wrapper(RLIMIT_NOFILE, ret, hardlim, softlim, pid, verbose);
}

void rlimit_nproc (int *ret, double *hardlim, double *softlim, int *pid, bool *verbose) {
	if(*verbose){
		Rprintf("RLIMIT_NPROC:\n");
	}
	rlimit_wrapper(RLIMIT_NPROC, ret, hardlim, softlim, pid, verbose);
}

void rlimit_rtprio (int *ret, double *hardlim, double *softlim, int *pid, bool *verbose) {
	if(*verbose){
		Rprintf("RLIMIT_RTPRIO:\n");
	}
	rlimit_wrapper(RLIMIT_RTPRIO, ret, hardlim, softlim, pid, verbose);
}

void rlimit_rttime (int *ret, double *hardlim, double *softlim, int *pid, bool *verbose) {
	if(*verbose){
		Rprintf("RLIMIT_RTTIME:\n");
	}
	rlimit_wrapper(RLIMIT_RTTIME, ret, hardlim, softlim, pid, verbose);
}

void rlimit_sigpending (int *ret, double *hardlim, double *softlim, int *pid, bool *verbose) {
	if(*verbose){
		Rprintf("RLIMIT_SIGPENDING:\n");
	}
	rlimit_wrapper(RLIMIT_SIGPENDING, ret, hardlim, softlim, pid, verbose);
}

void rlimit_stack (int *ret, double *hardlim, double *softlim, int *pid, bool *verbose) {
	if(*verbose){
		Rprintf("RLIMIT_STACK:\n");
	}
	rlimit_wrapper(RLIMIT_STACK, ret, hardlim, softlim, pid, verbose);
}

//main function that calls out to Linux Kernel.
void rlimit_wrapper(int resource, int *ret, double *hardlim_double, double *softlim_double, int *pid, bool *verbose){

  //create (long) integer pointers
  long hardlim_int = (long) *hardlim_double;
  long *hardlim = &hardlim_int;

  long softlim_int = (long) *softlim_double;
  long *softlim = &softlim_int;

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
		if(*verbose){
			Rprintf("Failed to set limit...\n");
		}
		*ret = errno;
		return;
	  }

	  //print old limit
	  if(*verbose){
		  Rprintf("Previous limits: soft=%lld; hard=%lld\n", (long long) old.rlim_cur, (long long) old.rlim_max);
	  }
  } else if(*softlim != -999) {
	  //this is the case where only a soft limit was set
	  //we need to actually lookup the current hard limit.
	  getrlimit(resource, &old);
	  new.rlim_max = old.rlim_max;

	  // call out to linux
	  *ret = prlimit(mypid, resource, newp, &old);
	  if(*ret != 0){
		if(*verbose){
			Rprintf("Failed to set limit...\n");
		}
		*ret = errno;
		return;
	  }

	  //print old limit
	  if(*verbose){
		  Rprintf("Previous limits: soft=%lld; hard=%lld\n", (long long) old.rlim_cur, (long long) old.rlim_max);
	  }
  }
  // get the new values
  *ret = prlimit(mypid, resource, NULL, &old); 
  if(*ret != 0){
    if(*verbose){
    	Rprintf("Limit couldn't be read?\n");
    }
    *ret = errno;
    return;
  }  
  
  //print new limits
  if(*verbose){
    Rprintf("Current limits: soft=%lld; hard=%lld\n", (long long) old.rlim_cur, (long long) old.rlim_max);
  }
}

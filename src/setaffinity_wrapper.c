#define _GNU_SOURCE 
#include <sched.h>
#include <R.h>
#include <Rinternals.h>
#include <Rinterface.h>
#include <R_ext/Rdynload.h>
#include <errno.h>
#include <stdbool.h>

void setaffinity_wrapper (int *ret, int *cpu, int *length, bool *verbose) {
  //some debugging
  if(*verbose){
	  Rprintf("Setting process affinity...\n");
  } 
   
  //init the cpu mask
  cpu_set_t mask; 
  
  //set the mask to hold no cpus
  CPU_ZERO(&mask); 
  
  //NOTE: cpu[i]-1 is because R indexes from 1 instead of 0.
  for (int i = 0; i < *length; i++){
    CPU_SET(cpu[i]-1, &mask);;
  }
   
  *ret = sched_setaffinity(0, sizeof mask, &mask);
  if(*ret != 0){
    *ret = errno;
  }
}

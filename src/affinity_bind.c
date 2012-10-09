#define _GNU_SOURCE 
#include <sched.h>
#include <R.h>
#include <Rinternals.h>
#include <Rinterface.h>
#include <R_ext/Rdynload.h>
#include <errno.h>
#include <stdbool.h>

void affinity_bind (int *ret, int *cpu, bool *verbose) {
  if(*verbose){
	  Rprintf("Binding process affinity to cpu...\n");
  }

  //init the cpu mask
  cpu_set_t mask; 
  
  //set the mask to hold no cpus
  CPU_ZERO(&mask); 
  
  //add the requested cpu to the mask
  CPU_SET(*cpu, &mask);
   
  *ret = sched_setaffinity(0, sizeof mask, &mask);
  if(*ret != 0){
    *ret = errno;
  }
}
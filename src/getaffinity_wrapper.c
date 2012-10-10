#define _GNU_SOURCE 
#include <sched.h>
#include <R.h>
#include <Rinternals.h>
#include <Rinterface.h>
#include <R_ext/Rdynload.h>
#include <errno.h>
#include <stdbool.h>

void getaffinity_wrapper(int *ret, int *cpus, int *length, bool *verbose) {
  if(*verbose){
	 Rprintf("Getting process affinity mask...\n");
  }

  //init the cpu mask
  cpu_set_t mask; 
  
  //set the mask to hold no cpus
  CPU_ZERO(&mask); 
  
  //read affinity 
  *ret = sched_getaffinity(0, sizeof mask, &mask);
  
  //read values
  for (int i = 0; i < *length; i++){
    cpus[i] = CPU_ISSET(i, &mask);
  }  

  //return
  if(*ret != 0){
    *ret = errno;
  }
}

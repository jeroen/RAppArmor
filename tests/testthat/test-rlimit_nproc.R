context("nproc limit")
test_that("Fork bombs get mitgated and are properly cleaned up afterwards", {
			
	forkbomb <- function(){
		repeat{
			parallel::mcparallel(forkbomb());
		}
	}
	
	regular <- function(){
		parallel::mcparallel(matrix(rnorm(1e4), 1e2));
		return(parallel::mccollect()[[1]])
	}
	
	#force non-root
	me <- ifelse(getuid() == 0, 1000, getuid());
			
	#forkbomb, assuming no more than 300 current procs :-)
	for(i in 1:5){
	  Sys.sleep(0.5)
		expect_that(eval.secure(forkbomb(), RLIMIT_NPROC=300, uid=me), throws_error("unable to fork"))
		Sys.sleep(0.5)
		expect_that(eval.secure(regular(), RLIMIT_NPROC=300, uid=me), is_a("matrix"))
		gc();
	}
});


test_that("Raising the limit should not be possible for non-root users", {
			
	#force non-root
	me <- ifelse(getuid() == 0, 1000, getuid());
	
	#run test with several numbers
	for(mylim in c(400, 200, 300)){
		output <- list(hardlim = mylim-1, softlim = mylim-1);
		expect_that(eval.secure(rlimit_nproc(mylim+1), RLIMIT_NPROC = mylim, uid=me), throws_error("privilege"));
		expect_that(eval.secure(rlimit_nproc(mylim-1), RLIMIT_NPROC = mylim, uid=me), equals(output));
		rm(output)		
	}
});
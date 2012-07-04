## Restricting file access ##
eval.secure(list.files("/"))
eval.secure(list.files("/"), profile="r-base")

eval.secure(system("ls /", intern=TRUE))
eval.secure(system("ls /", intern=TRUE), profile="r-base")

## Limiting CPU time ##
cputest <- function(){
  A <- matrix(rnorm(1e7), 1e3);
  B <- svd(A);
}

## setTimeLimit doesn't always work:
setTimeLimit(5);
cputest();
setTimeLimit();

#timeout does work:
eval.secure(cputest(), timeout=5)

## Limiting memory ##
A <- matrix(rnorm(1e8), 1e4);
B <- eval.secure(matrix(rnorm(1e8), 1e4), RLIMIT_AS = 100*1024*1024)

## Limiting procs ##
forkbomb <- function(){
  repeat{
    parallel::mcparallel(forkbomb());
  }
}

## Forkbomb is mitigated ##
eval.secure(forkbomb(), RLIMIT_NPROC=10)


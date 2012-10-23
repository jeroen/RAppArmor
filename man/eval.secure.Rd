\name{eval.secure}
\alias{eval.secure}
\title{Secure evaluation}
\usage{
  eval.secure(..., uid, gid, priority, profile,
    timeout = 60, silent = FALSE, verbose = FALSE,
    interactive = FALSE, affinity, RLIMIT_AS, RLIMIT_CORE,
    RLIMIT_CPU, RLIMIT_DATA, RLIMIT_FSIZE, RLIMIT_MEMLOCK,
    RLIMIT_MSGQUEUE, RLIMIT_NICE, RLIMIT_NOFILE,
    RLIMIT_NPROC, RLIMIT_RTPRIO, RLIMIT_RTTIME,
    RLIMIT_SIGPENDING, RLIMIT_STACK)
}
\arguments{
  \item{...}{arguments passed on to eval(...)}

  \item{uid}{integer or name of linux user.}

  \item{gid}{integer or name of linux group.}

  \item{priority}{priority. Value between -20 and 20.}

  \item{profile}{AppArmor security profile. Has to be
  preloaded by Linux.}

  \item{timeout}{timeout in seconds.}

  \item{silent}{suppress output on stdout. See
  mcparallel().}

  \item{verbose}{print some C output (TRUE/FALSE)}

  \item{interactive}{TRUE/FALSE to enable/disable R
  interactive mode.}

  \item{affinity}{which cpu(s) to use. See setaffinity.}

  \item{RLIMIT_AS}{hard limit passed on to rlimit_as()}

  \item{RLIMIT_CORE}{hard limit passed on to rlimit_core()}

  \item{RLIMIT_CPU}{hard limit passed on to rlimit_cpu()}

  \item{RLIMIT_DATA}{hard limit passed on to rlimit_data()}

  \item{RLIMIT_FSIZE}{hard limit passed on to
  rlimit_fsize()}

  \item{RLIMIT_MEMLOCK}{hard limit passed on to
  rlimit_memlock()}

  \item{RLIMIT_MSGQUEUE}{hard limit passed on to
  rlimit_msgqueue()}

  \item{RLIMIT_NICE}{hard limit passed on to rlimit_nice()}

  \item{RLIMIT_NOFILE}{hard limit passed on to
  rlimit_nofile()}

  \item{RLIMIT_NPROC}{hard limit passed on to
  rlimit_nproc()}

  \item{RLIMIT_RTPRIO}{hard limit passed on to
  rlimit_rtprio()}

  \item{RLIMIT_RTTIME}{hard limit passed on to
  rlimit_rttime()}

  \item{RLIMIT_SIGPENDING}{hard limit passed on to
  rlimit_sigpending()}

  \item{RLIMIT_STACK}{hard limit passed on to
  rlimit_stack()}
}
\description{
  Evaluate in a sandboxed environment.
}
\details{
  This function creates a fork, and then sets any rlimits,
  uid, gid, priority, apparmor profile where specified, and
  then evaluates the expression inside the fork. After
  evaluation returns, the fork is killed. If the timeout is
  reached the fork is also killed and an error is thrown.

  Evaluation of an expression through secure.eval should
  never have any side effects on the current R session.
  This also means that if the code does e.g. assignments to
  the global environment, sets options(), these will get
  lost, as we explicitly want to prevent this. However, if
  the expression saves any files (where allowed by
  apparmor), these will still be available after the
  evaluation finishes.

  Note that if the initial process does not have superuser
  rights, rlimits can only be decreased and setuid/setgid
  might not work. In this case, specifying an RLIMIT higher
  than the current value will result in an error. Some of
  the rlimits can also be specified inside of the apparmor
  profile. When a rlimit is set both in the profile and
  through R, the more restrictive one will be effective.
}
\examples{
\dontrun{
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
}
}


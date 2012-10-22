\name{rlimit_cpu}
\alias{rlimit_cpu}
\title{Limit CPU time}
\usage{
  rlimit_cpu(hardlim, softlim = hardlim, pid = 0,
    verbose = FALSE)
}
\arguments{
  \item{hardlim}{cpu time in seconds}

  \item{softlim}{cpu time in seconds}

  \item{pid}{id of the target process}

  \item{verbose}{print some C output (TRUE/FALSE)}
}
\description{
  CPU time limit in seconds. When the process reaches the
  soft limit, it is sent a SIGXCPU signal.
}
\details{
  Note that CPU time is not the same as elapsed time. If a
  process is waiting/idle, it will not count towards the
  CPU time limit. See the example for ?rlimit_cpu. Use the
  'timeout' parameter in ?eval.secure to limit the total
  elapsed time for a function call.

  Use rlimit_cpu only as a last-resort if-all-else-fails
  method. When the cpu limit is hit, the kernel kills the
  process without any warning. It is pretty much a ticking
  timebomb that cannot be undone. When using eval.secure,
  best practice is to make sure that the value for
  rlimit_cpu is higher than timeout.

  CPU time limit in seconds. When the process reaches the
  soft limit, it is sent a SIGXCPU signal. The default
  action for this signal is to terminate the process.
  However, the signal can be caught, and the handler can
  return control to the main program. If the process
  continues to consume CPU time, it will be sent SIGXCPU
  once per second until the hard limit is reached, at which
  time it is sent SIGKILL. (This latter point describes
  Linux behavior. Implementations vary in how they treat
  rocesses which continue to consume CPU time after
  reaching the soft limit. Portable applications that need
  to catch this signal should perform an orderly
  termination upon first receipt of SIGXCPU.)
}
\examples{
\dontrun{testfun <- function(){
  Sys.sleep(3);
  repeat{
    svd(matrix(rnorm(1e6,1e3)));
  }
};
#will be killed after 8 seconds (3s idle, 5s CPU):
system.time(eval.secure(testfun(), RLIMIT_CPU=5));

#will be killed after 5 seconds
system.time(eval.secure(testfun(), timeout=5));}
}
\references{
  http://manpages.ubuntu.com/manpages/precise/man2/getrlimit.2.html
}
\seealso{
  Other rlimit: \code{\link{rlimit_as}},
  \code{\link{rlimit_core}}, \code{\link{rlimit_data}},
  \code{\link{rlimit_fsize}}, \code{\link{rlimit_memlock}},
  \code{\link{rlimit_msgqueue}}, \code{\link{rlimit_nice}},
  \code{\link{rlimit_nofile}}, \code{\link{rlimit_nproc}},
  \code{\link{rlimit_rtprio}}, \code{\link{rlimit_rttime}},
  \code{\link{rlimit_sigpending}},
  \code{\link{rlimit_stack}}
}


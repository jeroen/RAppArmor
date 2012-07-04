\name{rlimit_cpu}
\alias{rlimit_cpu}
\title{Limit CPU time}
\usage{
  rlimit_cpu(hardlim, softlim = hardlim, pid = 0)
}
\arguments{
  \item{hardlim}{cpu time in seconds}

  \item{softlim}{cpu time in seconds}

  \item{pid}{id of the target process}
}
\description{
  CPU time limit in seconds. When the process reaches the
  soft limit, it is sent a SIGXCPU signal.
}
\details{
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
#load lib
library(RAppArmor)

#current limit
rlimit_as();

#set hard limit
rlimit_as(1e9);

#set separate hard and soft limit. 
rlimit_as(1e9, 1e8);

#soft limits can be elevated
rlimit_as(soft = 1e7);
rlimit_as(soft = 1e9);

#set other limits
rlimit_core(1e9);
rlimit_data(1e9);
rlimit_fsize(1e9);
rlimit_memlock(10000);
rlimit_msgqueue(1e5);
rlimit_nofile(10);
rlimit_nproc(100);
rlimit_rttime(1e9);
rlimit_sigpending(1e4);
rlimit_stack(1000);
rlimit_cpu(10);
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


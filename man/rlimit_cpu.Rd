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


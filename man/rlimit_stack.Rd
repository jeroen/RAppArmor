\name{rlimit_stack}
\alias{rlimit_stack}
\title{Limit stack size.}
\usage{
  rlimit_stack(hardlim, softlim = hardlim, pid = 0)
}
\arguments{
  \item{hardlim}{size of stack}

  \item{softlim}{size of stack}

  \item{pid}{id of the target process}
}
\description{
  Limits the maximum size of the process stack, in bytes.
}
\details{
  The maximum size of the process stack, in bytes. Upon
  reaching this limit, a SIGSEGV signal is generated. To
  handle this signal, a process must employ an alternate
  signal stack (sigaltstack(2)). Since Linux 2.6.23, this
  limit also determines the amount of space used for the
  process's command-line arguments and environment
  variables; for details, see execve(2).
}
\seealso{
  Other rlimit: \code{\link{rlimit_as}},
  \code{\link{rlimit_core}}, \code{\link{rlimit_cpu}},
  \code{\link{rlimit_data}}, \code{\link{rlimit_fsize}},
  \code{\link{rlimit_memlock}},
  \code{\link{rlimit_msgqueue}}, \code{\link{rlimit_nice}},
  \code{\link{rlimit_nofile}}, \code{\link{rlimit_nproc}},
  \code{\link{rlimit_rtprio}}, \code{\link{rlimit_rttime}},
  \code{\link{rlimit_sigpending}}
}


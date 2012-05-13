\name{rlimit_fsize}
\alias{rlimit_fsize}
\title{Limit size of files}
\usage{
  rlimit_fsize(hardlim, softlim = hardlim, pid = 0)
}
\arguments{
  \item{hardlim}{size}

  \item{softlim}{size}

  \item{pid}{id of the target process}
}
\description{
  The maximum size of files that the process may create.
}
\details{
  The maximum size of files that the process may create.
  Attempts to extend a file beyond this limit result in
  delivery of a SIGXFSZ signal. By default, this signal
  terminates a process, but a process can catch this signal
  instead, in which case the relevant system call (e.g.,
  write(2), truncate(2)) fails with the error EFBIG.
}
\seealso{
  Other rlimit: \code{\link{rlimit_as}},
  \code{\link{rlimit_core}}, \code{\link{rlimit_cpu}},
  \code{\link{rlimit_data}}, \code{\link{rlimit_memlock}},
  \code{\link{rlimit_msgqueue}}, \code{\link{rlimit_nice}},
  \code{\link{rlimit_nofile}}, \code{\link{rlimit_nproc}},
  \code{\link{rlimit_rtprio}}, \code{\link{rlimit_rttime}},
  \code{\link{rlimit_sigpending}},
  \code{\link{rlimit_stack}}
}


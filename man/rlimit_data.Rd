\name{rlimit_data}
\alias{rlimit_data}
\title{Limit data segment}
\usage{
  rlimit_data(hardlim, softlim = hardlim, pid = 0)
}
\arguments{
  \item{hardlim}{size}

  \item{softlim}{size}

  \item{pid}{id of the target process}
}
\description{
  The maximum size of the process's data segment
  (initialized data, uninitialized data, and heap).
}
\details{
  The maximum size of the process's data segment
  (initialized data, uninitialized data, and heap). This
  limit affects calls to brk(2) and sbrk(2), which fail
  with the error ENOMEM upon encountering the soft limit of
  this resource.
}
\seealso{
  Other rlimit: \code{\link{rlimit_as}},
  \code{\link{rlimit_core}}, \code{\link{rlimit_cpu}},
  \code{\link{rlimit_fsize}}, \code{\link{rlimit_memlock}},
  \code{\link{rlimit_msgqueue}}, \code{\link{rlimit_nice}},
  \code{\link{rlimit_nofile}}, \code{\link{rlimit_nproc}},
  \code{\link{rlimit_rtprio}}, \code{\link{rlimit_rttime}},
  \code{\link{rlimit_sigpending}},
  \code{\link{rlimit_stack}}
}


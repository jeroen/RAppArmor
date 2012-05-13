\name{rlimit_nproc}
\alias{rlimit_nproc}
\title{Limit number of processes}
\usage{
  rlimit_nproc(hardlim, softlim = hardlim, pid = 0)
}
\arguments{
  \item{hardlim}{number greater than 1}

  \item{softlim}{number greater than 1}

  \item{pid}{id of the target process}
}
\description{
  The maximum number of processes (or, more precisely on
  Linux, threads) that can be created for the real user ID.
}
\details{
  The maximum number of processes (or, more precisely on
  Linux, threads) that can be created for the real user ID
  of the calling process. Upon encountering this limit,
  fork(2) fails with the error EAGAIN.
}
\seealso{
  Other rlimit: \code{\link{rlimit_as}},
  \code{\link{rlimit_core}}, \code{\link{rlimit_cpu}},
  \code{\link{rlimit_data}}, \code{\link{rlimit_fsize}},
  \code{\link{rlimit_memlock}},
  \code{\link{rlimit_msgqueue}}, \code{\link{rlimit_nice}},
  \code{\link{rlimit_nofile}}, \code{\link{rlimit_rtprio}},
  \code{\link{rlimit_rttime}},
  \code{\link{rlimit_sigpending}},
  \code{\link{rlimit_stack}}
}


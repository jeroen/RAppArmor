\name{rlimit_core}
\alias{rlimit_core}
\title{Limit core size.}
\usage{
  rlimit_core(hardlim, softlim = hardlim, pid = 0)
}
\arguments{
  \item{hardlim}{size}

  \item{softlim}{size}

  \item{pid}{id of the target process}
}
\description{
  Maximum size of core file. When 0 no core dump files are
  created. When nonzero, larger dumps are truncated to this
  size.
}
\seealso{
  Other rlimit: \code{\link{rlimit_as}},
  \code{\link{rlimit_cpu}}, \code{\link{rlimit_data}},
  \code{\link{rlimit_fsize}}, \code{\link{rlimit_memlock}},
  \code{\link{rlimit_msgqueue}}, \code{\link{rlimit_nice}},
  \code{\link{rlimit_nofile}}, \code{\link{rlimit_nproc}},
  \code{\link{rlimit_rtprio}}, \code{\link{rlimit_rttime}},
  \code{\link{rlimit_sigpending}},
  \code{\link{rlimit_stack}}
}


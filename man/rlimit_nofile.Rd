\name{rlimit_nofile}
\alias{rlimit_nofile}
\title{Limit file descriptors}
\usage{
  rlimit_nofile(hardlim, softlim = hardlim, pid = 0)
}
\arguments{
  \item{hardlim}{number greater than 1}

  \item{softlim}{number greater than 1}

  \item{pid}{id of the target process}
}
\description{
  Specifies a value one greater than the maximum file
  descriptor number that can be opened by this process.
}
\details{
  Specifies a value one greater than the maximum file
  descriptor number that can be opened by this process.
  Attempts (open(2), pipe(2), dup(2), etc.) to exceed this
  limit yield the error EMFILE. (Historically, this limit
  was named RLIMIT_OFILE on BSD.)
}
\seealso{
  Other rlimit: \code{\link{rlimit_as}},
  \code{\link{rlimit_core}}, \code{\link{rlimit_cpu}},
  \code{\link{rlimit_data}}, \code{\link{rlimit_fsize}},
  \code{\link{rlimit_memlock}},
  \code{\link{rlimit_msgqueue}}, \code{\link{rlimit_nice}},
  \code{\link{rlimit_nproc}}, \code{\link{rlimit_rtprio}},
  \code{\link{rlimit_rttime}},
  \code{\link{rlimit_sigpending}},
  \code{\link{rlimit_stack}}
}


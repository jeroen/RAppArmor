\name{rlimit_nice}
\alias{rlimit_nice}
\title{Limit nice value.}
\usage{
  rlimit_nice(hardlim, softlim = hardlim, pid = 0)
}
\arguments{
  \item{hardlim}{priority value between -20 and 20}

  \item{softlim}{priority value between -20 and 20}

  \item{pid}{id of the target process}
}
\description{
  Specifies a ceiling to which the process's nice value can
  be raised using setpriority(2) or nice(2).
}
\details{
  Specifies a ceiling to which the process's nice value can
  be raised using setpriority(2) or nice(2). The actual
  ceiling for the nice value is calculated as 20 -
  rlim_cur. (This strangeness occurs because negative
  numbers cannot be specified as resource limit values,
  since they typically have special meanings. For example,
  RLIM_INFINITY typically is the same as -1.)
}
\seealso{
  Other rlimit: \code{\link{rlimit_as}},
  \code{\link{rlimit_core}}, \code{\link{rlimit_cpu}},
  \code{\link{rlimit_data}}, \code{\link{rlimit_fsize}},
  \code{\link{rlimit_memlock}},
  \code{\link{rlimit_msgqueue}},
  \code{\link{rlimit_nofile}}, \code{\link{rlimit_nproc}},
  \code{\link{rlimit_rtprio}}, \code{\link{rlimit_rttime}},
  \code{\link{rlimit_sigpending}},
  \code{\link{rlimit_stack}}
}


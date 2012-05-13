\name{rlimit_rtprio}
\alias{rlimit_rtprio}
\title{Limit real-time priority}
\usage{
  rlimit_rtprio(hardlim, softlim = hardlim, pid = 0)
}
\arguments{
  \item{hardlim}{real time priority value}

  \item{softlim}{real time priority value}

  \item{pid}{id of the target process}
}
\description{
  Specifies a ceiling on the real-time priority
}
\details{
  Specifies a ceiling on the real-time priority that may be
  set for this process using sched_setscheduler(2) and
  sched_setparam(2).
}
\seealso{
  Other rlimit: \code{\link{rlimit_as}},
  \code{\link{rlimit_core}}, \code{\link{rlimit_cpu}},
  \code{\link{rlimit_data}}, \code{\link{rlimit_fsize}},
  \code{\link{rlimit_memlock}},
  \code{\link{rlimit_msgqueue}}, \code{\link{rlimit_nice}},
  \code{\link{rlimit_nofile}}, \code{\link{rlimit_nproc}},
  \code{\link{rlimit_rttime}},
  \code{\link{rlimit_sigpending}},
  \code{\link{rlimit_stack}}
}


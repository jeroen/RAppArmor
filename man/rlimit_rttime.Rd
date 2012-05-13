\name{rlimit_rttime}
\alias{rlimit_rttime}
\title{Limit real-time cpu}
\usage{
  rlimit_rttime(hardlim, softlim = hardlim, pid = 0)
}
\arguments{
  \item{hardlim}{time in microsec}

  \item{softlim}{time in microsec}

  \item{pid}{id of the target process}
}
\description{
  Specifies a limit (in microseconds) on the amount of CPU
  time that a process scheduled under a real-time
  scheduling policy may consume without making a blocking
  system call.
}
\details{
  Specifies a limit (in microseconds) on the amount of CPU
  time that a process scheduled under a real-time
  scheduling policy may consume without making a blocking
  system call. For the purpose of this limit, each time a
  process makes a blocking system call, the count of its
  consumed CPU time is reset to zero. The CPU time count is
  not reset if the process continues trying to use the CPU
  but is preempted, its time slice expires, or it calls
  sched_yield(2). Upon reaching the soft limit, the process
  is sent a SIGXCPU signal. If the process catches or
  ignores this signal and continues consuming CPU time,
  then SIGXCPU will be generated once each second until the
  hard limit is reached, at which point the process is sent
  a SIGKILL signal. The intended use of this limit is to
  stop a runaway real-time process from locking up the
  system.
}
\seealso{
  Other rlimit: \code{\link{rlimit_as}},
  \code{\link{rlimit_core}}, \code{\link{rlimit_cpu}},
  \code{\link{rlimit_data}}, \code{\link{rlimit_fsize}},
  \code{\link{rlimit_memlock}},
  \code{\link{rlimit_msgqueue}}, \code{\link{rlimit_nice}},
  \code{\link{rlimit_nofile}}, \code{\link{rlimit_nproc}},
  \code{\link{rlimit_rtprio}},
  \code{\link{rlimit_sigpending}},
  \code{\link{rlimit_stack}}
}


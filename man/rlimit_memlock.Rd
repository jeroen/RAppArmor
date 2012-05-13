\name{rlimit_memlock}
\alias{rlimit_memlock}
\title{Limit locked memory}
\usage{
  rlimit_memlock(hardlim, softlim = hardlim, pid = 0)
}
\arguments{
  \item{hardlim}{number of bytes}

  \item{softlim}{number of bytes}

  \item{pid}{id of the target process}
}
\description{
  The maximum number of bytes of memory that may be locked
  into RAM.
}
\details{
  The maximum number of bytes of memory that may be locked
  into RAM. In effect this limit is rounded down to the
  nearest multiple of the system page size. This limit
  affects mlock(2) and mlockall(2) and the mmap(2)
  MAP_LOCKED operation. Since Linux 2.6.9 it also affects
  the shmctl(2) SHM_LOCK operation, where it sets a maximum
  on the total bytes in shared memory segments (see
  shmget(2)) that may be locked by the real user ID of the
  calling process. The shmctl(2) SHM_LOCK locks are
  accounted for separately from the per-process memory
  locks established by mlock(2), mlockall(2), and mmap(2)
  MAP_LOCKED; a process can lock bytes up to this limit in
  each of these two categories. In Linux kernels before
  2.6.9, this limit controlled the amount of memory that
  could be locked by a privileged process. Since Linux
  2.6.9, no limits are placed on the amount of memory that
  a privileged process may lock, and this limit instead
  governs the amount of memory that an unprivileged process
  may lock.
}
\seealso{
  Other rlimit: \code{\link{rlimit_as}},
  \code{\link{rlimit_core}}, \code{\link{rlimit_cpu}},
  \code{\link{rlimit_data}}, \code{\link{rlimit_fsize}},
  \code{\link{rlimit_msgqueue}}, \code{\link{rlimit_nice}},
  \code{\link{rlimit_nofile}}, \code{\link{rlimit_nproc}},
  \code{\link{rlimit_rtprio}}, \code{\link{rlimit_rttime}},
  \code{\link{rlimit_sigpending}},
  \code{\link{rlimit_stack}}
}


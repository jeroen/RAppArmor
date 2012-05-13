\name{rlimit_msgqueue}
\alias{rlimit_msgqueue}
\title{Limit user message queue}
\usage{
  rlimit_msgqueue(hardlim, softlim = hardlim, pid = 0)
}
\arguments{
  \item{hardlim}{number of bytes}

  \item{softlim}{number of bytes}

  \item{pid}{id of the target process}
}
\description{
  Specifies the limit on the number of bytes that can be
  allocated for POSIX message queues for the real user ID
  of the calling process.
}
\details{
  Specifies the limit on the number of bytes that can be
  allocated for POSIX message queues for the real user ID
  of the calling process. This limit is enforced for
  mq_open(3). Each message queue that the user creates
  counts (until it is removed) against this limit according
  to the formula:

  bytes = attr.mq_maxmsg * sizeof(struct msg_msg *) +
  attr.mq_maxmsg * attr.mq_msgsize

  where attr is the mq_attr structure specified as the
  fourth argument to mq_open(3).

  The first addend in the formula, which includes
  sizeof(struct msg_msg *) (4 bytes on Linux/i386), ensures
  that the user cannot create an unlimited number of
  zero-length messages (such messages nevertheless each
  consume some system memory for bookkeeping overhead).
}
\seealso{
  Other rlimit: \code{\link{rlimit_as}},
  \code{\link{rlimit_core}}, \code{\link{rlimit_cpu}},
  \code{\link{rlimit_data}}, \code{\link{rlimit_fsize}},
  \code{\link{rlimit_memlock}}, \code{\link{rlimit_nice}},
  \code{\link{rlimit_nofile}}, \code{\link{rlimit_nproc}},
  \code{\link{rlimit_rtprio}}, \code{\link{rlimit_rttime}},
  \code{\link{rlimit_sigpending}},
  \code{\link{rlimit_stack}}
}


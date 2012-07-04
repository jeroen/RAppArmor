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
\examples{
#load lib
library(RAppArmor)

#current limit
rlimit_as();

#set hard limit
rlimit_as(1e9);

#set separate hard and soft limit. 
rlimit_as(1e9, 1e8);

#soft limits can be elevated
rlimit_as(soft = 1e7);
rlimit_as(soft = 1e9);

#set other limits
rlimit_core(1e9);
rlimit_data(1e9);
rlimit_fsize(1e9);
rlimit_memlock(10000);
rlimit_msgqueue(1e5);
rlimit_nofile(10);
rlimit_nproc(100);
rlimit_rttime(1e9);
rlimit_sigpending(1e4);
rlimit_stack(1000);
rlimit_cpu(10);
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


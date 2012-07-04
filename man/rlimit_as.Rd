\name{rlimit_as}
\alias{rlimit_as}
\title{Limit virtual memory}
\usage{
  rlimit_as(hardlim, softlim = hardlim, pid = 0)
}
\arguments{
  \item{softlim}{soft limit in bytes.}

  \item{hardlim}{hard limit in bytes}

  \item{pid}{id of the target process.}
}
\description{
  Limits the maximum size of the process's virtual memory
  (address space) in bytes.
}
\details{
  The maximum size of the process's virtual memory (address
  space) in bytes. This limit affects calls to brk(2),
  mmap(2) and mremap(2), which fail with the error ENOMEM
  upon exceeding this limit. Also automatic stack expansion
  will fail (and generate a SIGSEGV that kills the process
  if no alternate stack has been made available via
  sigaltstack(2)). Since the value is a long, on machines
  with a 32-bit long either this limit is at most 2 GiB, or
  this resource is unlimited.
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
  Other rlimit: \code{\link{rlimit_core}},
  \code{\link{rlimit_cpu}}, \code{\link{rlimit_data}},
  \code{\link{rlimit_fsize}}, \code{\link{rlimit_memlock}},
  \code{\link{rlimit_msgqueue}}, \code{\link{rlimit_nice}},
  \code{\link{rlimit_nofile}}, \code{\link{rlimit_nproc}},
  \code{\link{rlimit_rtprio}}, \code{\link{rlimit_rttime}},
  \code{\link{rlimit_sigpending}},
  \code{\link{rlimit_stack}}
}


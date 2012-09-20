\name{rlimit_core}
\alias{rlimit_core}
\title{Limit core size.}
\usage{
  rlimit_core(hardlim, softlim = hardlim, pid = 0,
    verbose = TRUE)
}
\arguments{
  \item{hardlim}{size}

  \item{softlim}{size}

  \item{pid}{id of the target process}

  \item{verbose}{print some C output (TRUE/FALSE)}
}
\description{
  Maximum size of core file. When 0 no core dump files are
  created. When nonzero, larger dumps are truncated to this
  size.
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
  \code{\link{rlimit_cpu}}, \code{\link{rlimit_data}},
  \code{\link{rlimit_fsize}}, \code{\link{rlimit_memlock}},
  \code{\link{rlimit_msgqueue}}, \code{\link{rlimit_nice}},
  \code{\link{rlimit_nofile}}, \code{\link{rlimit_nproc}},
  \code{\link{rlimit_rtprio}}, \code{\link{rlimit_rttime}},
  \code{\link{rlimit_sigpending}},
  \code{\link{rlimit_stack}}
}


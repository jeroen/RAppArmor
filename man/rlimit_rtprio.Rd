\name{rlimit_rtprio}
\alias{rlimit_rtprio}
\title{Limit real-time priority}
\usage{
  rlimit_rtprio(hardlim, softlim = hardlim, pid = 0,
    verbose = FALSE)
}
\arguments{
  \item{hardlim}{real time priority value}

  \item{softlim}{real time priority value}

  \item{pid}{id of the target process}

  \item{verbose}{print some C output (TRUE/FALSE)}
}
\description{
  Specifies a ceiling on the real-time priority
}
\details{
  Specifies a ceiling on the real-time priority that may be
  set for this process using sched_setscheduler(2) and
  sched_setparam(2).
}
\examples{
\dontrun{
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
rlimit_cpu(60);
}
}
\references{
  http://manpages.ubuntu.com/manpages/precise/man2/getrlimit.2.html
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


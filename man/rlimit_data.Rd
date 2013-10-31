\name{rlimit_data}
\alias{rlimit_data}
\title{Limit data segment}
\usage{
  rlimit_data(hardlim, softlim = hardlim, pid = 0,
    verbose = FALSE)
}
\arguments{
  \item{hardlim}{size}

  \item{softlim}{size}

  \item{pid}{id of the target process}

  \item{verbose}{print some C output (TRUE/FALSE)}
}
\description{
  The maximum size of the process's data segment
  (initialized data, uninitialized data, and heap).
}
\details{
  The maximum size of the process's data segment
  (initialized data, uninitialized data, and heap). This
  limit affects calls to brk(2) and sbrk(2), which fail
  with the error ENOMEM upon encountering the soft limit of
  this resource.
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
  Jeroen Ooms (2013). The RAppArmor Package: Enforcing
  Security Policies in {R} Using Dynamic Sandboxing on
  Linux. \emph{Journal of Statistical Software}, 55(7),
  1-34. \url{http://www.jstatsoft.org/v55/i07/}.

  Ubuntu Manpage: \code{getrlimit, setrlimit} -
  \emph{get/set resource limits}.
  \url{http://manpages.ubuntu.com/manpages/precise/man2/getrlimit.2.html}.
}
\seealso{
  Other rlimit: \code{\link{rlimit_as}},
  \code{\link{rlimit_core}}, \code{\link{rlimit_cpu}},
  \code{\link{rlimit_fsize}}, \code{\link{rlimit_memlock}},
  \code{\link{rlimit_msgqueue}}, \code{\link{rlimit_nice}},
  \code{\link{rlimit_nofile}}, \code{\link{rlimit_nproc}},
  \code{\link{rlimit_rtprio}}, \code{\link{rlimit_rttime}},
  \code{\link{rlimit_sigpending}},
  \code{\link{rlimit_stack}}
}


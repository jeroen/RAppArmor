\name{rlimit_stack}
\alias{rlimit_stack}
\title{Limit stack size.}
\usage{
  rlimit_stack(hardlim, softlim = hardlim, pid = 0,
    verbose = FALSE)
}
\arguments{
  \item{hardlim}{size of stack}

  \item{softlim}{size of stack}

  \item{pid}{id of the target process}

  \item{verbose}{print some C output (TRUE/FALSE)}
}
\description{
  Limits the maximum size of the process stack, in bytes.
}
\details{
  The maximum size of the process stack, in bytes. Upon
  reaching this limit, a SIGSEGV signal is generated. To
  handle this signal, a process must employ an alternate
  signal stack (sigaltstack(2)). Since Linux 2.6.23, this
  limit also determines the amount of space used for the
  process's command-line arguments and environment
  variables; for details, see execve(2).
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
  \code{\link{rlimit_data}}, \code{\link{rlimit_fsize}},
  \code{\link{rlimit_memlock}},
  \code{\link{rlimit_msgqueue}}, \code{\link{rlimit_nice}},
  \code{\link{rlimit_nofile}}, \code{\link{rlimit_nproc}},
  \code{\link{rlimit_rtprio}}, \code{\link{rlimit_rttime}},
  \code{\link{rlimit_sigpending}}
}


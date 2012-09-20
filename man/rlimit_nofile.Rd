\name{rlimit_nofile}
\alias{rlimit_nofile}
\title{Limit file descriptors}
\usage{
  rlimit_nofile(hardlim, softlim = hardlim, pid = 0,
    verbose = TRUE)
}
\arguments{
  \item{hardlim}{number greater than 1}

  \item{softlim}{number greater than 1}

  \item{pid}{id of the target process}

  \item{verbose}{print some C output (TRUE/FALSE)}
}
\description{
  Specifies a value one greater than the maximum file
  descriptor number that can be opened by this process.
}
\details{
  Specifies a value one greater than the maximum file
  descriptor number that can be opened by this process.
  Attempts (open(2), pipe(2), dup(2), etc.) to exceed this
  limit yield the error EMFILE. (Historically, this limit
  was named RLIMIT_OFILE on BSD.)
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
  \code{\link{rlimit_memlock}},
  \code{\link{rlimit_msgqueue}}, \code{\link{rlimit_nice}},
  \code{\link{rlimit_nproc}}, \code{\link{rlimit_rtprio}},
  \code{\link{rlimit_rttime}},
  \code{\link{rlimit_sigpending}},
  \code{\link{rlimit_stack}}
}


\name{setaffinity}
\alias{getaffinity}
\alias{getaffinity_count}
\alias{setaffinity}
\title{Process affinity manipulation}
\usage{
  setaffinity(cpus, verbose = FALSE)
}
\arguments{
  \item{cpus}{Which cpu cores to restrict to. Must be
  vector of integers between 1 and ncores.}

  \item{verbose}{print some C output (TRUE/FALSE)}
}
\description{
  Function to get/set the process's CPU affinity mask.
  Affinity mask allows binding a process to a specific
  core(s) within the machine.
}
\details{
  Setting a process afinity allows for restricting the
  process to only use certain cores in the machine. The
  cores are indexed by the operating system as 1 to ncores.
  One can lookup ncores using ncores(). Calling setaffinity
  with no arguments resets the process to use any of the
  available cores.

  Note that setaffinity is different from setting r_limit
  values in the sense that it is not a one-way process. An
  unprivileged user can change the process affinity to any
  value. In order to 'lock' an affinity value, one would
  have to manipulate Linux capability value for
  CAP_SYS_NICE.
}
\examples{
\dontrun{
getaffinity();
getaffinity_count();
setaffinity(1); #restricts the process to core number 1.
getaffinity();
setaffinity(); #reset
getaffinity();
}
}
\references{
  Jeroen Ooms (2013). The RAppArmor Package: Enforcing
  Security Policies in {R} Using Dynamic Sandboxing on
  Linux. \emph{Journal of Statistical Software}, 55(7),
  1-34. \url{http://www.jstatsoft.org/v55/i07/}.

  Ubuntu Manpage: \code{sched_setaffinity} - \emph{set and
  get a process's CPU affinity mask}.
  \url{http://manpages.ubuntu.com/manpages/precise/man2/sched_setaffinity.2.html}.
}


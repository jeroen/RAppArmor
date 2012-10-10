\name{setaffinity}
\alias{getaffinity}
\alias{getaffinity_count}
\alias{setaffinity}
\title{Process affinity manipulation}
\usage{
  setaffinity(cpus, verbose = TRUE)
}
\arguments{
  \item{cpus}{Which cpu cores to restrict to. Values must
  be integers between 1 and ncores.}

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
  One can lookup ncores using ncores().

  The function affinity_bind restricts the current process
  to a certain cores in the machine. The function
  affinity_count gives the number of cores that the current
  process has available.
}
\examples{
getaffinity();
getaffinity_count();
setaffinity(1); #restricts the process to core number 1.
getaffinity();
setaffinity(); #reset
getaffinity();
}


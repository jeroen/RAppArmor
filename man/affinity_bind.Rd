\name{affinity_bind}
\alias{affinity_bind}
\alias{affinity_count}
\title{Process affinity manipulation}
\usage{
  affinity_bind(cpu, verbose = TRUE)
}
\arguments{
  \item{cpu}{Which cpu core to restrict to. Value must be
  number between 0 and detectCores()-1}

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
  cores are indexed by the operating system as 0 to
  detectCores()-1.

  The function affinity_bind restricts the current process
  to a certain cpu in the machine. The function
  affinity_count gives the number of cores that the current
  process has available.
}
\examples{
affinity_count();
affinity_bind(1); #restricts the process to core number 1.
affinity_count();
}


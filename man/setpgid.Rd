\name{setpgid}
\alias{getpgid}
\alias{setpgid}
\title{Get/Set pgid}
\usage{
  setpgid(verbose = TRUE)
}
\arguments{
  \item{verbose}{print some C output (TRUE/FALSE)}
}
\description{
  Wrappers for getpgid and setpgid in Linux. The setpgid
  function sets the current process group id to equal the
  pid value.
}


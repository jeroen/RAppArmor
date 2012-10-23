\name{setuid}
\alias{getuid}
\alias{setuid}
\title{Get/Set UID}
\usage{
  setuid(uid, verbose = FALSE)
}
\arguments{
  \item{uid}{UID or username as specified in /etc/passwd}

  \item{verbose}{print some C output (TRUE/FALSE)}
}
\description{
  Wrappers for getuid and setuid in Linux.
}
\references{
  http://manpages.ubuntu.com/manpages/precise/man2/setuid.2.html
}


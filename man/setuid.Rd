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
  Jeroen Ooms (2013). The RAppArmor Package: Enforcing
  Security Policies in {R} Using Dynamic Sandboxing on
  Linux. \emph{Journal of Statistical Software}, 55(7),
  1-34. \url{http://www.jstatsoft.org/v55/i07/}.

  Ubuntu Manpage: \code{setuid} - \emph{setuid - set user
  identity}.
  \url{http://manpages.ubuntu.com/manpages/precise/man2/setuid.2.html}.
}


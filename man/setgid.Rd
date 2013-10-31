\name{setgid}
\alias{getgid}
\alias{setgid}
\title{Get/Set GID}
\usage{
  setgid(gid, verbose = FALSE)
}
\arguments{
  \item{gid}{group ID. Must be integer.}

  \item{verbose}{print some C output (TRUE/FALSE)}
}
\description{
  Wrappers for getgid and setgid in Linux.
}
\references{
  Jeroen Ooms (2013). The RAppArmor Package: Enforcing
  Security Policies in {R} Using Dynamic Sandboxing on
  Linux. \emph{Journal of Statistical Software}, 55(7),
  1-34. \url{http://www.jstatsoft.org/v55/i07/}.

  Ubuntu Manpage: \code{setgid} - \emph{set group
  identity}.
  \url{http://manpages.ubuntu.com/manpages/precise/man2/setgid.2.html}.
}


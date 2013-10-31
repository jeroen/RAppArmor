\name{aa_find_mountpoint}
\alias{aa_find_mountpoint}
\title{Find the apparmor mountpoint}
\usage{
  aa_find_mountpoint(verbose = TRUE)
}
\arguments{
  \item{verbose}{print some C output (TRUE/FALSE)}
}
\value{
  location of mountpoint
}
\description{
  Find the apparmor mountpoint
}
\references{
  Jeroen Ooms (2013). The RAppArmor Package: Enforcing
  Security Policies in {R} Using Dynamic Sandboxing on
  Linux. \emph{Journal of Statistical Software}, 55(7),
  1-34. \url{http://www.jstatsoft.org/v55/i07/}.

  Ubuntu Manpage: \code{aa_find_mountpoint} - \emph{find
  where the apparmor interface filesystem is mounted}.
  \url{http://manpages.ubuntu.com/manpages/precise/man2/aa_find_mountpoint.2.html}.
}


\name{aa_is_enabled}
\alias{aa_is_enabled}
\title{Check if AppArmor is Enabled}
\usage{
  aa_is_enabled(verbose = TRUE)
}
\arguments{
  \item{verbose}{print some C output (TRUE/FALSE)}
}
\value{
  TRUE or FALSE
}
\description{
  This function tries to lookup the status of AppArmor in
  the kernel. However, some confined profiles might not
  have enough privileges to lookup this status. Also see
  aa_getcon().
}
\references{
  Jeroen Ooms (2013). The RAppArmor Package: Enforcing
  Security Policies in {R} Using Dynamic Sandboxing on
  Linux. \emph{Journal of Statistical Software}, 55(7),
  1-34. \url{http://www.jstatsoft.org/v55/i07/}.

  Ubuntu Manpage: \code{aa_is_enabled} - \emph{determine if
  apparmor is available}.
  \url{http://manpages.ubuntu.com/manpages/precise/man2/aa_find_mountpoint.2.html}.
}


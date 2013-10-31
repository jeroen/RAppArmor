\name{setpriority}
\alias{getpriority}
\alias{setpriority}
\title{Get/set process priority}
\usage{
  setpriority(prio, verbose = FALSE)
}
\arguments{
  \item{prio}{priority value between -20 and 20}

  \item{verbose}{print some C output (TRUE/FALSE)}
}
\description{
  Get/set the priority of the current process. High value
  is low priority. Only superusers can lower the value.
}
\references{
  Jeroen Ooms (2013). The RAppArmor Package: Enforcing
  Security Policies in {R} Using Dynamic Sandboxing on
  Linux. \emph{Journal of Statistical Software}, 55(7),
  1-34. \url{http://www.jstatsoft.org/v55/i07/}.

  Ubuntu Manpage: \code{getpriority, setpriority} -
  \emph{get/set program scheduling priority}.
  \url{http://manpages.ubuntu.com/manpages/precise/man2/getpriority.2.html}.
}


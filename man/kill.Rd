\name{kill}
\alias{kill}
\title{Kill a process}
\usage{
  kill(pid, signal = SIGTERM, verbose = TRUE)
}
\arguments{
  \item{pid}{process id.}

  \item{signal}{kill signal}

  \item{verbose}{print some C output (TRUE/FALSE)}
}
\description{
  Kill a process. Negative values kill a process group.
}
\references{
  Jeroen Ooms (2013). The RAppArmor Package: Enforcing
  Security Policies in {R} Using Dynamic Sandboxing on
  Linux. \emph{Journal of Statistical Software}, 55(7),
  1-34. \url{http://www.jstatsoft.org/v55/i07/}.

  Ubuntu Manpage: \code{kill} - \emph{send signal to a
  process}.
  \url{http://manpages.ubuntu.com/manpages/precise/man2/kill.2.html}.
}


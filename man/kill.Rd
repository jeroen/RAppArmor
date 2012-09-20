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


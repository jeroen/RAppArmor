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
  http://manpages.ubuntu.com/manpages/precise/man2/getpriority.2.html
}


\name{aa_getcon}
\alias{aa_getcon}
\title{Get AppArmor confinement context for the current task}
\usage{
  aa_getcon(verbose = TRUE)
}
\arguments{
  \item{verbose}{print some C output (TRUE/FALSE)}
}
\value{
  list with con and mode.
}
\description{
  We can use this function to see if there is an AppArmor
  profile associated with the current process, and in which
  mode it current is set (enforce, complain, disable).
}
\details{
  Note that in order for this function to do its work, it
  needs read access to the attributes of the current
  process. If aa_getcon fails with a permission denied
  error, it might actually mean that the current process is
  being confined with a very restrictive profile.
}
\references{
  http://manpages.ubuntu.com/manpages/precise/man2/aa_getcon.2.html
}


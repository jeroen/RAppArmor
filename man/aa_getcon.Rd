\name{aa_getcon}
\alias{aa_getcon}
\title{Get AppArmor confinement context for the current task}
\usage{
  aa_getcon()
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
  process. Hence if a profile is being enforced that is
  overly strict, this confinement lookup will fail as well
  :-)
}


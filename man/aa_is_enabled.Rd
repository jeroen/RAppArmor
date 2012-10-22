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
  http://manpages.ubuntu.com/manpages/precise/man2/aa_find_mountpoint.2.html
}


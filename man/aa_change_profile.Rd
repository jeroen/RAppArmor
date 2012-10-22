\name{aa_change_profile}
\alias{aa_change_profile}
\title{Change profiles}
\usage{
  aa_change_profile(profile, verbose = TRUE)
}
\arguments{
  \item{profile}{character string with the name of the
  profile.}

  \item{verbose}{print some C output (TRUE/FALSE)}
}
\description{
  This function changes the current R process to an
  AppArmor profile. Note that this generally is a one way
  process: most profiles explicitly prevent switching into
  another profile, otherwise it would defeat the purpose.
}
\examples{
\dontrun{
test <- read.table("/etc/passwd");
aa_change_profile("testprofile");
aa_getcon();
test <- read.table("/etc/passwd");
}
}
\references{
  http://manpages.ubuntu.com/manpages/precise/man2/aa_change_profile.2.html
}


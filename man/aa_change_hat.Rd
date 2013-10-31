\name{aa_change_hat}
\alias{aa_change_hat}
\alias{aa_revert_hat}
\title{Change hats}
\usage{
  aa_change_hat(subprofile, magic_token, verbose = TRUE)
}
\arguments{
  \item{subprofile}{character string identifying the
  subprofile (hat) name (without the "^")}

  \item{magic_token}{a number that will be the key to
  revert out of the hat.}

  \item{verbose}{print some C output (TRUE/FALSE)}
}
\description{
  A hat is a subprofile which name starts with a '^'. The
  difference between hats and profiles is that one can
  escape (revert) from the hat using the token. Hence this
  provides more limited security than a profile.
}
\examples{
\dontrun{
aa_change_profile("testprofile");
aa_getcon();
test <- read.table("/etc/group");
aa_change_hat("testhat", 13337);
aa_getcon();
test <- read.table("/etc/group");
aa_revert_hat(13337);
test <- read.table("/etc/group");
}
}
\references{
  Jeroen Ooms (2013). The RAppArmor Package: Enforcing
  Security Policies in {R} Using Dynamic Sandboxing on
  Linux. \emph{Journal of Statistical Software}, 55(7),
  1-34. \url{http://www.jstatsoft.org/v55/i07/}.

  Ubuntu Manpage: \code{aa_change_hat} - \emph{change to or
  from a "hat" within a AppArmor profile}.
  \url{http://manpages.ubuntu.com/manpages/precise/man2/aa_change_hat.2.html}.
}


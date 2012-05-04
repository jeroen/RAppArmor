\name{eval.secure}
\alias{eval.secure}
\title{Secure evaluation}
\usage{
  eval.secure(..., uid, gid, priority, profile,
    timeout = 60, silent = TRUE)
}
\arguments{
  \item{...}{stuff to pass to eval(...)}

  \item{uid}{integer or name of linux user.}

  \item{gid}{integer or name of linux group.}

  \item{priority}{priority. Value between -20 and 20.}

  \item{profile}{AppArmor security profile. Has to be
  preloaded.}

  \item{timeout}{timeout in seconds.}

  \item{silent}{passed on to mcparallel()}
}
\description{
  Evaluate in a sandboxed environment.
}


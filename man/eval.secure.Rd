\name{eval.secure}
\alias{eval.secure}
\title{Secure evaluation}
\usage{
  eval.secure(..., uid, gid, priority, profile,
    timeout = 60, silent = TRUE, RLIMIT_AS, RLIMIT_CORE,
    RLIMIT_CPU, RLIMIT_DATA, RLIMIT_FSIZE, RLIMIT_MEMLOCK,
    RLIMIT_MSGQUEUE, RLIMIT_NICE, RLIMIT_NOFILE,
    RLIMIT_NPROC, RLIMIT_RTPRIO, RLIMIT_RTTIME,
    RLIMIT_SIGPENDING, RLIMIT_STACK)
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

  \item{RLIMIT_AS}{hard limit passed on to rlimit_as()}

  \item{RLIMIT_CORE}{hard limit passed on to rlimit_core()}

  \item{RLIMIT_CPU}{hard limit passed on to rlimit_cpu()}

  \item{RLIMIT_DATA}{hard limit passed on to rlimit_data()}

  \item{RLIMIT_FSIZE}{hard limit passed on to
  rlimit_fsize()}

  \item{RLIMIT_MEMLOCK}{hard limit passed on to
  rlimit_memlock()}

  \item{RLIMIT_MSGQUEUE}{hard limit passed on to
  rlimit_msgqueue()}

  \item{RLIMIT_NICE}{hard limit passed on to rlimit_nice()}

  \item{RLIMIT_NOFILE}{hard limit passed on to
  rlimit_nofile()}

  \item{RLIMIT_NPROC}{hard limit passed on to
  rlimit_nproc()}

  \item{RLIMIT_RTPRIO}{hard limit passed on to
  rlimit_rtprio()}

  \item{RLIMIT_RTTIME}{hard limit passed on to
  rlimit_rttime()}

  \item{RLIMIT_SIGPENDING}{hard limit passed on to
  rlimit_sigpending()}

  \item{RLIMIT_STACK}{hard limit passed on to
  rlimit_stack()}
}
\description{
  Evaluate in a sandboxed environment.
}
\details{
  This function creates a fork, and then sets rlimits, uid,
  gid, priority and apparmor profile, and then evaluates
  the expression inside this fork. After evaluation
  returns, the fork is killed. If the timeout is reached
  the fork is also killed and an error is thrown.

  Note that if the initial process does not have superuser
  rights, rlimits can only be decreased and setuid/setgid
  might not work.

  Some of the rlimits can also be specified inside of the
  apparmor profile.
}


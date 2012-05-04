\name{userinfo}
\alias{userinfo}
\title{Lookup user info}
\usage{
  userinfo(username, uid, gid)
}
\arguments{
  \item{username}{character name identifying the loginname
  of the user.}

  \item{uid}{integer specifying the uid of the user to
  lookup.}

  \item{gid}{integer specifying the gid to lookup.}
}
\value{
  a parsed row from /etc/passwd
}
\description{
  Function looks up uid, gid, and userinfo for a given
  username.
}


\name{setpriority}
\alias{setpriority}
\title{Set process priority}
\usage{
  setpriority(prio)
}
\arguments{
  \item{prio}{priority value between -20 and 20}
}
\description{
  Set the priority of the current process. High value is
  low priority. Only superusers can lower the value.
}


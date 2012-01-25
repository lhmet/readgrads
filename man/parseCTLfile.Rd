\name{parseCTLfile}
\alias{parseCTLfile}
\title{Parses a grads...}
\usage{parseCTLfile(ctlfname)}
\description{Parses a grads .ctl file into an R list}
\details{Parses the information in a .ctl file into an R list for
other readGrads functions to use.}
\value{R list containing the parsed parameters.}
\author{Paul Hiemstra, \email{p.h.hiemstra@gmail.com}}
\arguments{\item{ctlfname}{path where the .ctl file is located}}
\examples{\dontrun{
# In pseudo code
ctlparams = parseCTLfile("/where/is/your/somefile.ctl")
# Read a pre parsed example
data(ctlparams)
ctlparams
}}

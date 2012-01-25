\name{readListGradsFiles2dataframe}
\alias{readListGradsFiles2dataframe}
\title{Reads a list of grads files into a data...}
\usage{readListGradsFiles2dataframe(filelist, ts, lev, var, verbose)}
\description{Reads a list of grads files into a data.frame}
\details{Reads a list of grads files into an array and then
uses melt to transform the array to a data.frame}
\value{a data.frame with the requested data.}
\author{Paul Hiemstra, \email{p.h.hiemstra@gmail.com}}
\arguments{\item{filelist}{character vector providing the locations of the grads files
are to be read.}
\item{ts}{numeric vector expressing which timesteps should be read, e.g. ts = 1:10.}
\item{lev}{numeric vector expressing which levels should be read, e.g. lev = c(200, 500).}
\item{var}{character vector expressing which variable(s) should be read, e.g. var = "psi".}
\item{verbose}{logical, if TRUE, the function provides feedback on what it is doing.}}

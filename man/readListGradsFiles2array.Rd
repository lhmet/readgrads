\name{readListGradsFiles2array}
\alias{readListGradsFiles2array}
\title{Reads a list of grads files into a multidimensional array...}
\usage{readListGradsFiles2array(filelist, ts, lev, var, verbose)}
\description{Reads a list of grads files into a multidimensional array}
\details{This function takes a list of grads files. The function results in 
a multidimensional array which contains dimensions for x coordinate 
(xcoor), y-coordinate (ycoor), level (lev), time (tstep) and modelnumber (modnum).}
\value{A multidimensional array.}
\author{Paul Hiemstra, \email{p.h.hiemstra@gmail.com}}
\arguments{\item{filelist}{character vector providing the locations of the grads files
are to be read.}
\item{ts}{numeric vector expressing which timesteps should be read, e.g. ts = 1:10.}
\item{lev}{numeric vector expressing which levels should be read, e.g. lev = c(200, 500).}
\item{var}{character vector expressing which variable(s) should be read, e.g. var = "psi".}
\item{verbose}{logical, if TRUE, the function provides feedback on what it is doing.}}

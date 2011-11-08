\name{readGradsFile}
\alias{readGradsFile}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
readGradsFile(gradsfile, ctlparams, tstepRange, convert2dataframe = FALSE, padding.bytes = TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{gradsfile}{
%%     ~~Describe \code{gradsfile} here~~
}
  \item{ctlparams}{
%%     ~~Describe \code{ctlparams} here~~
}
  \item{tstepRange}{
%%     ~~Describe \code{tstepRange} here~~
}
  \item{convert2dataframe}{
%%     ~~Describe \code{convert2dataframe} here~~
}
  \item{padding.bytes}{
%%     ~~Describe \code{padding.bytes} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function(gradsfile, ctlparams, tstepRange, convert2dataframe = FALSE, padding.bytes = TRUE) {
  if(missing(ctlparams)) ctlparams = parseCTLfile(sub(".grads", ".ctl", gradsfile))
  if(missing(tstepRange)) tstepRange = 1:ctlparams$tdef
  gridsize = ctlparams$xdef$noLevels * ctlparams$ydef$noLevels

  zz = file(gradsfile, "rb")

  # Skipping if necessary
  if(tstepRange[1] != 1) {
    numberOfMapsToSkip = length(1:(min(tstepRange) - 1)) * ctlparams$vars * ctlparams$zdef$noLevels
    if(padding.bytes) {
      numberOfBytesToSkip = (4 + (gridsize * 4) + 4) * numberOfMapsToSkip
    } else {
      numberOfBytesToSkip = (gridsize * 4) * numberOfMapsToSkip
    }
    seek(zz, where = numberOfBytesToSkip)
  } else {
    numberOfMapsToSkip = 0  # 
  }

  # Reading data
  remainingMapsToRead = length(tstepRange) * ctlparams$vars * ctlparams$zdef$noLevels
  gradsData = lapply(1:remainingMapsToRead, function(x) {
    if(padding.bytes) null = readBin(zz, numeric(), 1, size = 4) # Skip fortran delimiters
    bla = data.frame(value = readBin(zz, numeric(), gridsize, size = 4))
    if(padding.bytes) null = readBin(zz, numeric(), 1, size = 4) # Skip fortran delimiters
    return(bla)
  })

  close(zz)

  names(gradsData) = (numberOfMapsToSkip + 1):((numberOfMapsToSkip + 1) + (remainingMapsToRead - 1))
  if(convert2dataframe) gradsData = subsetGradsData(tstepRange, ctlparams$zdef$levelValues, 
                                                    names(ctlparams$variables), gradsData, ctlparams)
  return(gradsData)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

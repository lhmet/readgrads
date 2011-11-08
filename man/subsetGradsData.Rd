\name{subsetGradsData}
\alias{subsetGradsData}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
subsetGradsData(ts, lev, var, gradsData, ctlparams, correctionFactor = 1)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{ts}{
%%     ~~Describe \code{ts} here~~
}
  \item{lev}{
%%     ~~Describe \code{lev} here~~
}
  \item{var}{
%%     ~~Describe \code{var} here~~
}
  \item{gradsData}{
%%     ~~Describe \code{gradsData} here~~
}
  \item{ctlparams}{
%%     ~~Describe \code{ctlparams} here~~
}
  \item{correctionFactor}{
%%     ~~Describe \code{correctionFactor} here~~
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
function(ts, lev, var, gradsData, ctlparams, correctionFactor = 1) {
  gridsize = ctlparams$xdef$noLevels * ctlparams$ydef$noLevels
  whichDataIsNeeded = .mapGradsDataIndexToMetadata(ts, lev, var, ctlparams)
  indexes = format(whichDataIsNeeded$indicies, scientific = FALSE, trim = TRUE)

  dat = gradsData[indexes]
  names(dat) = indexes
  out = melt(lapply(dat, function(x) {
    return(data.frame(.getXYcoordinates(ctlparams), x))
#     return(subset(dum, level \%in\% lev & variable \%in\% var))
  }), measure.vars = NULL)
  names(out)[4] <- "index"
  out$value = correctionFactor * out$value
  if(length(var) == 1) {
    names(out)[names(out) == "value"] <- var
  }
  out$index = as.numeric(out$index)
  out = data.frame(out, whichDataIsNeeded$metadata[as.character(out$index),])
  return(out)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

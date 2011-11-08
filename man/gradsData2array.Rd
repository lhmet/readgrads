\name{gradsData2array}
\alias{gradsData2array}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
gradsData2array(ts, lev, var, gradsData, ctlparams)
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
function(ts, lev, var, gradsData, ctlparams) {
  whichDataIsNeeded = .mapGradsDataIndexToMetadata(ts, lev, var, ctlparams)
  out = array(dim = c(ctlparams$xdef$noLevels, ctlparams$ydef$noLevels, length(lev), length(ts)))
  dimnames(out) = list(xcoor = ctlparams$xdef$levelValues, ycoor = ctlparams$ydef$levelValues, level = lev, tstep = ts)
  for(i in seq_len(nrow(whichDataIsNeeded$metadata))) {
    x = whichDataIsNeeded$metadata[i,]
    idx = as.numeric(rownames(x))
    out[,,as.character(x$level),as.character(x$tstep)] <- matrix(as.matrix(gradsData[[as.character(idx)]]), ctlparams$xdef$noLevels,ctlparams$ydef$noLevels)
  }
  return(out)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

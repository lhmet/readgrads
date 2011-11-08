\name{readListGradsFiles2array}
\alias{readListGradsFiles2array}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
readListGradsFiles2array(filelist, ts, lev, var, verbose)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{filelist}{
%%     ~~Describe \code{filelist} here~~
}
  \item{ts}{
%%     ~~Describe \code{ts} here~~
}
  \item{lev}{
%%     ~~Describe \code{lev} here~~
}
  \item{var}{
%%     ~~Describe \code{var} here~~
}
  \item{verbose}{
%%     ~~Describe \code{verbose} here~~
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
function(filelist, ts, lev, var, verbose) {
  ctlparams = parseCTLfile(sub("grads", "ctl", filelist[1]))
  if(missing(ts)) ts = 1:ctlparams$tdef
  if(verbose) cat("Reading grads files...\n")
  gradsData = lapply(filelist, readGradsFile, ctlparams = ctlparams, tstepRange = ts)
  if(verbose) cat("Creating and filling donor array...\n")
  comb = array(dim = list(ctlparams$xdef$noLevels, ctlparams$ydef$noLevels, length(lev), length(ts), length(gradsData)), 
               dimnames = list(xcoor = ctlparams$xdef$levelValues,
                               ycoor = ctlparams$ydef$levelValues,
                               level = lev,
                               tstep = ts,
                               modnum = seq_len(length(gradsData))))
  ## Kan hoogstwaarschijnlijk ook met laply uit plyr, zie ook 'readQGModelOutput_sph'
  for(i in seq_len(length(gradsData))) {
    comb[,,,,i] = gradsData2array(ts, lev, var, gradsData[[i]], ctlparams)
  }
  return(comb)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

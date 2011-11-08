\name{parseCTLfile}
\alias{parseCTLfile}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
parseCTLfile(ctlfname)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{ctlfname}{
%%     ~~Describe \code{ctlfname} here~~
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
function(ctlfname) {
  content = readLines(ctlfname)
  content = .stripLeadingWhiteSpaces(content)
  content = .convertToLower(content)

  ctlparams = list()
  
  # Get all the parameters one by one
  ctlparams = append(ctlparams, .readSimpleParam(content, "dset"))
  ctlparams = append(ctlparams, .readSimpleParam(content, "undef", toNumeric = TRUE))
  ctlparams = append(ctlparams, .readSimpleParam(content, "options"))
  ctlparams = append(ctlparams, .readSimpleParam(content, "title"))
  ctlparams = append(ctlparams, .readCoordinateParam(content, "xdef"))
  ctlparams = append(ctlparams, .readCoordinateParam(content, "ydef"))
  ctlparams = append(ctlparams, .readCoordinateParam(content, "zdef"))
  ctlparams = append(ctlparams, .readSimpleParam(content, "tdef", skipFinal = 3, toNumeric = TRUE))
  ctlparams = append(ctlparams, .readSimpleParam(content, "vars", toNumeric = TRUE))
  ctlparams = append(ctlparams, .readVariablesParam(content, ctlparams$vars))  

  return(ctlparams)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

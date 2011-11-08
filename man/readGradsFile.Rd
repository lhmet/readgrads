\name{readGradsFile}
\alias{readGradsFile}
\title{Read a grads file into a list of maps}
\usage{
  readGradsFile(gradsfile, ctlparams, tstepRange,
  convert2dataframe = FALSE, padding.bytes = TRUE)
}
\arguments{
  \item{gradsfile}{path to grads file.}

  \item{ctlparams}{object containing the parsed .ctl file.
  If not present, the .ctl file is parsed by guessing the
  name from the \code{gradsfile}. In this case,
  \code{.grads} is replaced by \code{.ctl}.}

  \item{tstepRange}{numeric vector giving the timesteps
  which are to be read, e.g. 1:100.}

  \item{convert2dataframe}{logical, when TRUE the list of
  maps is put into a flat table. Note that for a
  non-trivial amount of timesteps, this can take a lot of
  memory. Use \code{\link{subsetGradsData}} or
  \code{\link{gradsData2array}} in these cases. The default
  is FALSE.}

  \item{padding.bytes}{logical, whether or not in the
  binary file additional bytes are used between the maps.
  Default is TRUE.}
}
\value{
  A list with maps containing floats for each map, or if
  \code{convert2dataframe} equals TRUE, a data.frame.
}
\description{
  This function reads the grads file into a list of floats.
  Each entry in the list is a map with nx times ny floats.
  The output of this function is meant to be used for
  \code{\link{subsetGradsData}} if you want the data in a
  flat table, or for \code{\link{gradsData2array}} if you
  want the data in a multidimensional array.
}
\examples{
\dontrun{
# In pseudocode:
dat = readGradsFile("/where/is/your/gradsfile.grads")
# Load an example file
data(gradsExampleData)
gradsExampleData
}
}
\author{
  Paul Hiemstra, \email{p.h.hiemstra@gmail.com}
}
\seealso{
  \code{\link{subsetGradsData}},
  \code{\link{gradsData2array}}
}


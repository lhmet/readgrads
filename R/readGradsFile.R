#' Read a grads file into a list of maps
#'
#' This function reads the grads file into a list of floats. Each
#' entry in the list is a map with nx times ny floats. The output of this
#' function is meant to be used for \code{\link{subsetGradsData}} if you want the
#' data in a flat table, or for \code{\link{gradsData2array}} if you want the data
#' in a multidimensional array.
#'
#' @param gradsfile path to grads file.
#' @param ctlparams object containing the parsed .ctl file. If not present,
#'                  the .ctl file is parsed by guessing the name from the \code{gradsfile}.
#'                  In this case, \code{.grads} is replaced by \code{.ctl}.
#' @param tstepRange numeric vector giving the timesteps which are to be read, e.g. 1:100.
#' @param convert2dataframe logical, when TRUE the list of maps is put into a flat table.
#'                   Note that for a non-trivial amount of timesteps, this can take a lot of memory.
#'                   Use \code{\link{subsetGradsData}} or \code{\link{gradsData2array}} in these cases.
#'                   The default is FALSE.
#' @param padding.bytes logical, whether or not in the binary file additional bytes are used between the
#'                   maps. Default is TRUE.
#' @param file.ext charater, default is .grads
#' @param varname character, optional, the variable name (e.g. 'prec' or 'precipitation').
#' @param ... additional parameters which are passed on to \code{\link{readBin}}. See the documentation of \code{\link{readBin}}
#'                   for which parameters can be passed.
#' @return A list with maps containing floats for each map, or if \code{convert2dataframe} equals TRUE, a data.frame.
#' @seealso \code{\link{subsetGradsData}}, \code{\link{gradsData2array}}
#' @author Paul Hiemstra, \email{p.h.hiemstra@@gmail.com}
#' @export
#' @examples
#' \dontrun{
#' # In pseudocode:
#' dat <- readGradsFile("/where/is/your/gradsfile.grads")
#' # Load an example file
#' data(gradsExampleData)
#' gradsExampleData
#'
#' data_tmp <- tempfile(fileext = '.bin')
#' download.file(
#' "http://ftp.cptec.inpe.br/modelos/io/produtos/MERGE/2020/prec_20200101.bin",
#'  data_tmp
#'  )
#'  ctl_tmp <- file.path(dirname(data_tmp), gsub('.bin', '.ctl', basename(data_tmp)))
#' download.file(
#' "http://ftp.cptec.inpe.br/modelos/io/produtos/MERGE/2020/prec_20200101.ctl",
#'  ctl_tmp
#'  )
#'  x <- readGradsFile(
#'    data_tmp, 
#'    file.ext = ".bin" ,
#'    convert2dataframe = TRUE,
#'    varname = "prec"
#'  )
#'} 
readGradsFile <-
  function(gradsfile, ctlparams, tstepRange, convert2dataframe = FALSE, padding.bytes = TRUE,
           file.ext = ".gra", varname = names(ctlparams$variables), ...) {
    if (missing(ctlparams)) ctlparams <- parseCTLfile(sub(file.ext, ".ctl", gradsfile))
    if (missing(tstepRange)) tstepRange <- 1:ctlparams$tdef
    gridsize <- ctlparams$xdef$noLevels * ctlparams$ydef$noLevels

    zz <- file(gradsfile, "rb")

    # Skipping if necessary
    if (tstepRange[1] != 1) {
      numberOfMapsToSkip <- length(1:(min(tstepRange) - 1)) * ctlparams$vars * ctlparams$zdef$noLevels
      if (padding.bytes) {
        numberOfBytesToSkip <- (4 + (gridsize * 4) + 4) * numberOfMapsToSkip
      } else {
        numberOfBytesToSkip <- (gridsize * 4) * numberOfMapsToSkip
      }
      seek(zz, where = numberOfBytesToSkip)
    } else {
      numberOfMapsToSkip <- 0 #
    }

    # Reading data
    remainingMapsToRead <- length(tstepRange) * ctlparams$vars * ctlparams$zdef$noLevels
    gradsData <- lapply(1:remainingMapsToRead, function(x) {
      if (padding.bytes) null <- readBin(zz, numeric(), 1, size = 4, ...) # Skip fortran delimiters
      bla <- data.frame(value = readBin(zz, numeric(), gridsize, size = 4, ...))
      if (padding.bytes) null <- readBin(zz, numeric(), 1, size = 4, ...) # Skip fortran delimiters
      return(bla)
    })

    close(zz)

    names(gradsData) <- (numberOfMapsToSkip + 1):((numberOfMapsToSkip + 1) + (remainingMapsToRead - 1))
    if (convert2dataframe) {
      gradsData <- subsetGradsData(
        ts = tstepRange, 
        lev = ctlparams$zdef$levelValues,
        #var = names(ctlparams$variables),
        var = varname, 
        gradsData, 
        ctlparams
      )
    }
    return(gradsData)
  }

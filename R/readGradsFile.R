#' Plots a list of SpatialGrid/PixelDataFrames using ggplot
#' 
#' Test 1
#' 
#' @param a b
#' @return something
#' @author Paul Hiemstra, \email{p.h.hiemstra@@gmail.com}
#' @export
#' @examples
#' 
#' print("Hello World")
#' 
#' 
readGradsFile <-
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


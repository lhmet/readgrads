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
gradsData2array <-
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


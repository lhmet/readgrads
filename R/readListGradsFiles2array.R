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
readListGradsFiles2array <-
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


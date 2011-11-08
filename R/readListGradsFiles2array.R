#' Reads a list of grads files into a multidimensional array
#' 
#' This function takes a list of grads files. The function results in 
#' a multidimensional array which contains dimensions for x coordinate 
#' (xcoor), y-coordinate (ycoor), level (lev), time (tstep) and modelnumber (modnum).
#' 
#' @param filelist character vector providing the locations of the grads files
#'        are to be read.
#' @param ts numeric vector expressing which timesteps should be read, e.g. ts = 1:10.
#' @param lev numeric vector expressing which levels should be read, e.g. lev = c(200, 500).
#' @param var character vector expressing which variable(s) should be read, e.g. var = "psi".
#' @param verbose logical, if TRUE, the function provides feedback on what it is doing.
#' @return A multidimensional array.
#' @author Paul Hiemstra, \email{p.h.hiemstra@@gmail.com}
#' @export
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


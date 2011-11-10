#' Reads a list of grads files into a data.frame
#' 
#' Reads a list of grads files into an array and then
#' uses melt to transform the array to a data.frame
#' 
#' @param filelist character vector providing the locations of the grads files
#'        are to be read.
#' @param ts numeric vector expressing which timesteps should be read, e.g. ts = 1:10.
#' @param lev numeric vector expressing which levels should be read, e.g. lev = c(200, 500).
#' @param var character vector expressing which variable(s) should be read, e.g. var = "psi".
#' @param verbose logical, if TRUE, the function provides feedback on what it is doing.
#' @return a data.frame with the requested data.
#' @author Paul Hiemstra, \email{p.h.hiemstra@@gmail.com}
#' @export
readListGradsFiles2dataframe <-
function(filelist, ts, lev, var, verbose) {
  dum = readListGradsFiles2array(filelist = filelist, ts = ts, lev = lev, var = var, verbose = verbose)
  return(melt(dum))
}


subsetGradsData <-
function(ts, lev, var, gradsData, ctlparams, correctionFactor = 1) {
  gridsize = ctlparams$xdef$noLevels * ctlparams$ydef$noLevels
  whichDataIsNeeded = .mapGradsDataIndexToMetadata(ts, lev, var, ctlparams)
  indexes = format(whichDataIsNeeded$indicies, scientific = FALSE, trim = TRUE)

  dat = gradsData[indexes]
  names(dat) = indexes
  out = melt(lapply(dat, function(x) {
    return(data.frame(.getXYcoordinates(ctlparams), x))
#     return(subset(dum, level %in% lev & variable %in% var))
  }), measure.vars = NULL)
  names(out)[4] <- "index"
  out$value = correctionFactor * out$value
  if(length(var) == 1) {
    names(out)[names(out) == "value"] <- var
  }
  out$index = as.numeric(out$index)
  out = data.frame(out, whichDataIsNeeded$metadata[as.character(out$index),])
  return(out)
}


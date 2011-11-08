parseCTLfile <-
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


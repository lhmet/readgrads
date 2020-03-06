#' Parses a grads .ctl file into an R list
#' 
#' Parses the information in a .ctl file into an R list for
#' other readGrads functions to use.  
#' 
#' @param ctlfname path where the .ctl file is located
#' @return R list containing the parsed parameters.
#' @author Paul Hiemstra, \email{p.h.hiemstra@@gmail.com}
#' @export
#' @examples
#' 
#' \dontrun{
#' # In pseudo code
#' ctlparams = parseCTLfile("/where/is/your/somefile.ctl")
#' # Read a pre parsed example
#' data(ctlparams)
#' ctlparams
#' }
parseCTLfile <-
function(ctlfname) {
  # ctlfname = ctl_tmp
  content = readLines(ctlfname)
  content = .stripLeadingWhiteSpaces(content)
  content = .convertToLower(content)

  ctlparams = list()
  
  # Get all the parameters one by one
  ctlparams = append(ctlparams, .readSimpleParam(content, "dset"))
  ctlparams = append(ctlparams, .readSimpleParam(content, "undef", toNumeric = TRUE))
#   ctlparams = append(ctlparams, .readSimpleParam(content, "options"))
  ctlparams = append(ctlparams, .readSimpleParam(content, "title"))
  ctlparams = append(ctlparams, .readCoordinateParam(content, "xdef"))
  ctlparams = append(ctlparams, .readCoordinateParam(content, "ydef"))
  ctlparams = append(ctlparams, .readCoordinateParam(content, "zdef"))
  ctlparams = append(ctlparams, .readSimpleParam(content, "tdef", skipFinal = 3, toNumeric = TRUE))
  ctlparams = append(ctlparams, .readSimpleParam(content, "vars", toNumeric = TRUE))
  ctlparams = append(ctlparams, .readVariablesParam(content, ctlparams$vars))  
  ctlparams = append(ctlparams, .readSimpleParamDateTime(content))

  return(ctlparams)
}





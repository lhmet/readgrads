
#' Extract date and time information from content of ctl file
#'
#' @param ntimes numeric 
#' @param time0 character 
#' @param dtime character
#' @param century numeric, default is 2000
#'
#' @return
#' @export
#' @author Marcos Longo
#'
#' @examples
gridt <- function(ntimes, time0, dtime, century = 2000) {
  #----- Finding position of each part ------------------------------------------------------#
  time0 <- tolower(time0)
  colon <- regexpr(":", time0)[1]
  mmms <- c("jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec")
  utc <- regexpr("z", time0)[1]
  size <- nchar(time0)

  mloc <- max(apply(as.matrix(mmms), 1, "regexpr", text = time0))
  if (colon > 0) {
    nn <- as.numeric(substr(time0, colon + 1, colon + 2))
  } else {
    nn <- 0
  }
  hh <- as.numeric(substr(time0, 1, 2))
  dd <- as.numeric(substr(time0, utc + 1, mloc - 1))
  mm <- match(substr(time0, mloc, mloc + 2), mmms)
  yy <- as.numeric(substr(time0, mloc + 3, size))
  if (yy < 100) {
    yyyy <- yy + century
  } else {
    yyyy <- yy
  }
  #t0 <- chron(paste(mm, dd, yyyy, sep = "/"), paste(hh, nn, 0, sep = ":"))
  t0 <- as.POSIXct(paste0(yyyy, "-", mm, "-", dd, " ", hh, ":", nn, "00"), tz = "UTC")

  dtime <- tolower(dtime)
  size <- nchar(dtime)
  units <- substr(dtime, size - 1, size)
  amount <- as.numeric(substr(dtime, 1, size - 2))
  if (units == "mn") dtime <- as.double(amount) / as.double(1440)
  if (units == "hr") dtime <- as.double(amount) / as.double(24)
  if (units == "dy") dtime <- as.double(amount)
  gridt <- t0 + (1:ntimes - 1) * dtime
  return(gridt)
}

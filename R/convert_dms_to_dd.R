#' Convert coordinates from degrees minutes seconds to decimal degrees
#'
#' @param x Coordinate in format dms. May be numeric or character
#' @param deg Degrees. Default is NULL
#' @param min Minutes. Default is NULL
#' @param sec Seconds. Default is NULL
#' @examples
#' convert_dms_to_dd(x=454532.4)
#' convert_dms_to_dd(x="454532.4")
#' convert_dms_to_dd(x="45° 45’ 32.4")
#' convert_dms_to_dd(deg=45, min=45, sec=32.4)
#' @export
convert_dms_to_dd <- function(x=NULL, deg=NULL, min=NULL, sec=NULL) {

  if(is.null(x)){x<-paste0(deg,min,sec)}

  #if(!is.null(x)){x<-gsub("[^0-9.-]", "", x)}

  x<-gsub("[^0-9.-]", "", x)

  deg <-as.numeric(substr(x, start = 1, stop = 2))
  min <-as.numeric(substr(x, start = 3, stop = 4))
  sec <-as.numeric(substr(x, start = 5, stop = 20))
  dd <- deg  + min/60 + sec/3600
  return(dd)
}

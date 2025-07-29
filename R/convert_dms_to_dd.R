#' Convert coordinates from degrees minutes seconds to decimal degrees
#'
#' @param x Coordinate in format dms. May be numeric or character
#' @param deg Degrees. Default is NULL
#' @param min Minutes. Default is NULL
#' @param sec Seconds. Default is NULL
#' @importFrom stringr str_extract_all
#' @examples
#' convert_dms_to_dd(x="64° 10.8’")
#' convert_dms_to_dd(x="64° 10.8’ 00.00")
#' convert_dms_to_dd("64°10.8’")
#' convert_dms_to_dd(deg="64°", min="10.8’", sec="45.6")
#' convert_dms_to_dd(deg="64°", min="10.8’")
#' convert_dms_to_dd(deg=64, min=10.8)
#' convert_dms_to_dd("641045.6")
#' convert_dms_to_dd(641045.6)
#' convert_dms_to_dd(deg="64°", min="10’", sec="45.6")
#' @export
convert_dms_to_dd <- function(x=NULL, deg=NULL, min=NULL, sec=NULL) {

  if(!is.null(x)){
    x<-unlist(stringr::str_extract_all(x, "\\d+\\.*\\d*"))

    if(length(x)>1){
      deg <-as.numeric(x[1])
      min <-as.numeric(x[2])
      sec <-as.numeric(x[3])
      if(!is.na(sec)){dd <- deg  + min/60 + sec/3600}else{dd <- deg  + min/60}
    }

    if(length(x)==1){
      deg <-as.numeric(substr(x, start = 1, stop = 2))
      min <-as.numeric(substr(x, start = 3, stop = 4))
      sec <-as.numeric(substr(x, start = 5, stop = 20))
      dd <- deg  + min/60 + sec/3600
    }

    return(dd)
  }


  if(is.null(x)){
    deg <-as.numeric(stringr::str_extract_all(deg, "\\d+\\.*\\d*"))
    min <-as.numeric(stringr::str_extract_all(min, "\\d+\\.*\\d*"))
    if(!is.null(sec)){sec <-as.numeric(stringr::str_extract_all(sec, "\\d+\\.*\\d*"))}
    if(!is.null(sec)){dd <- deg  + min/60 + sec/3600}else{dd <- deg  + min/60}
    return(dd)
  }

}


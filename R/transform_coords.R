#' Transform (project/change) spatial coordinates from one coordinate reference system to another
#'
#' @param lon Longitude
#' @param lat Latitude
#' @param from Original coordinate reference system
#' @param to Desired coordinate reference system
#' @importFrom terra project
#' @return matrix, array
#' @examples
#' lon=c(-55,-57)
#' lat=c(62,63)
#' transform_coords(lon,lat,from='epsg:4269',to='ESRI:102001')
#' @export
transform_coords<-function(lon,lat,from,to){
  coords<-cbind(lon,lat)
  terra::project(coords,from=from,to=to)
  }

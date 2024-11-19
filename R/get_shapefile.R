#' Retrieve a stored shapefile
#'
#' Imports a stored shapefile as a SpatVector (terra).
#' @param x Either "nafo", "nafo.clipped", "coast", "rv.sgsl", "rv.ngsl", "rv.winter", "closures","hex". The "nafo" shapefile is not clipped to land. The "nafo.clipped" shapefile is clipped to land. The 'hex' shapefile is a hexagonal grid used in the fisheriescape project.
#' @importFrom terra vect
#' @importFrom terra project
#' @importFrom terra plot
#' @return Returns a SpatVector
#' @examples
#' naf<-get_shapefile('nafo.clipped')
#' naf
#' @export
get_shapefile<-function(x='nafo.clipped'){

  if(x == 'nafo.clipped'){
    x<-terra::vect(system.file('extdata','nafo/NAFO_Divisions_2021_poly_clipped.shp',package='gslSpatial'))
    x<-x[which(x$Division%in%c("4T","4V","4R","4S","3P")),]
    x<-x[-which(x$SubDiv%in%c("4Vs","3Ps")),]
    x<-terra::project(x,'epsg:4269')
    writeLines("Source: https://www.nafo.int")
  }
}

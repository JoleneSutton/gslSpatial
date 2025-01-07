#' Get depths associated with longitude and latitude
#'
#' Returns depths in meters.
#' The bathymetry reference used is GEBCO_2024, www.gebco.net.
#' @param lon Longitude in decimal degrees
#' @param lat Latitude in decimal degrees
#' @param crs Coordinate reference system for lon and lat. Default is NAD83, EPSG:4269
#' @importFrom terra project rast extract
#' @import raster
#' @examples
#' get_depth(-62,44)
#'
#' @export
get_depth<-function(lon,lat,crs='epsg:4269'){
  writeLines("The default argument assumes your points have crs NAD83 - EPSG:4269.\nAssigning depths based on GEBCO_2024, www.gebco.net.\n")

  # stored internal gebco layer as RasterLayer b/c terra would not read back in properly
  sr<-get0("gebco.large", envir = asNamespace("gslSpatial"))
  names(sr)<-'depth'

  sr<-terra::rast(sr)
  sr<-terra::project(sr,crs)

  xy <- cbind(lon, lat)

  out<-terra::extract(sr, xy)
  out<-unlist(out)
  #names(out)<-'depth'

  return(out)
}

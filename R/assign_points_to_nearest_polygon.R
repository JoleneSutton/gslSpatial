#' For points that are not within polygons, find the nearest polygon edge
#'
#' @param x X-coordinates (must have same crs as polygon)
#' @param y Y-coordinates (must have same crs as polygon)
#' @param polygon A spatvector with geometry polygons
#' @returns A data frame
#' @importFrom terra vect nearest
#' @examples
#' v <- terra::vect(system.file("ex/lux.shp", package="terra"))
#' pts <- matrix(c(5.812,6.577,5.864,50.126,49.774,49.488), ncol=2)
#' assign_points_to_nearest_polygon(pts[,1],pts[,2],v)
#' @export
assign_points_to_nearest_polygon<-function(x,y,polygon){

  # check if polygon is spatvector
  if(class(polygon)[1]!="SpatVector"){stop("polygon must be class SpatVector")}

  id<-unlist(as.data.frame(polygon[,1]))
  pts<-cbind.data.frame(x,y)
  v.pts<-terra::vect(pts, geom=c('x','y'), crs=terra::crs(polygon))

  terra_dist <- as.data.frame(terra::distance(v.pts, polygon, unit = "km"))
  names(terra_dist)<-id
  closest.polygon<-apply(terra_dist, 1, function(row) {colnames(terra_dist)[which.min(row)]} )
  closest.distance.km <- apply(terra_dist, 1, min)

  out<-cbind.data.frame(x,y,closest.polygon,closest.distance.km)

  return(out)
}

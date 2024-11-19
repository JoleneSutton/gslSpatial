#' For points that are not within polygons, find the nearest polygon edge
#'
#' @param x X-coordinates (must have same crs as polygon)
#' @param y Y-coordinates (must have same crs as polygon)
#' @param polygon A spatvector with geometry polygons
#' @param layer The name of the polygon layer containing the polygon identities
#' @returns A data frame
#' @importFrom terra vect as.points nearest
#' @source https://stackoverflow.com/questions/72561812/return-polygon-nearest-to-a-point-using-terra-in-r
#' @author Robert Hijmans (package `terra`)
#' @examples
#' v <- terra::vect(system.file("ex/lux.shp", package="terra"))
#' pts <- matrix(c(5.812,6.577,5.864,50.126,49.774,49.488), ncol=2)
#' assign_points_to_nearest_polygon(pts[,1],pts[,2],v,'NAME_2')
#' @export
assign_points_to_nearest_polygon<-function(x,y,polygon,layer){

  # check if polygon is spatvector
  if(class(polygon)[1]!="SpatVector"){stop("polygon must be class SpatVector")}

  pts<-cbind.data.frame(x,y)
  v.pts<-terra::vect(pts, geom=c('x','y'), crs=terra::crs(polygon))

  pv = terra::as.points(polygon)
  n = terra::nearest(v.pts, pv,centroids=FALSE)
  i = pv[,which(names(pv)%in%layer)][n$to_id]

  out<-cbind.data.frame(pts,i,n$distance)
  #names(out)[4]<-'distance'

  return(out)
}

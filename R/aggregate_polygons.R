#' Compute summary statistics of a variable over polygons in a shapefile
#'
#' Note that data points that don't overlap with any polygons will be ignored.
#'
#' @param x X-coordinates of point data. CRS should match that of polygons
#' @param y Y-coordinates of point data. CRS should match that of polygons
#' @param var Variable to summarise
#' @param polygons SpatVector with geometry polygons
#' @param polygons.var Attribute (column) in polygons used to identify each polygon
#' @param fun A function to compute the summary statistics
#' @importFrom tidyterra left_join
#' @examples
#' \dontrun{
#' library(gslSpatial)
#' library(terra)
#' library(ggplot2)
#' library(tidyterra)
#' f <- system.file("ex/lux.shp", package="terra")
#' polygons <- vect(f)
#' set.seed(3241)
#' points <- spatSample(polygons, 10)
#' values(points) <- sample(1:10,length(points),replace=TRUE)
#' points<-as.data.frame(points,geom='xy')#because I normally have data in data frames
#' head(points)
#' ggplot()+
#' tidyterra::geom_spatvector(data=polygons)+
#' tidyterra::geom_spatvector_text(data=polygons,aes(label=NAME_2))+
#' geom_text(data=points,aes(x,y,label=value),nudge_y = -.015)
#' names(polygons)
#' test1<-aggregate_polygons(points$x,points$y,points$val,polygons,polygons.var='NAME_2',sum)
#' test2<-aggregate_polygons(points$x,points$y,points$val,polygons,polygons.var='NAME_2',max)
#' test3<-aggregate_polygons(points$x,points$y,points$val,polygons,polygons.var='NAME_2',length)
#' test1
#' test2
#' test3
#' ggplot()+
#' geom_spatvector(data=test1,aes(fill=fun))+
#' geom_spatvector_text(data=test1,aes(label=fun))+
#' geom_spatvector_text(data=test1,aes(label=NAME_2),nudge_y = .015)
#' ggplot()+
#' geom_spatvector(data=test2,aes(fill=fun))+
#' geom_spatvector_text(data=test2,aes(label=fun))+
#' geom_spatvector_text(data=test2,aes(label=NAME_2),nudge_y = .015)
#' ggplot()+
#' geom_spatvector(data=test3,aes(fill=fun))+
#' geom_spatvector_text(data=test3,aes(label=fun))+
#' geom_spatvector_text(data=test3,aes(label=NAME_2),nudge_y = .015)
#' }
#' @export
aggregate_polygons<-function(x,y,var,polygons,polygons.var,fun){

  index.polygons<-which(names(polygons)%in%polygons.var)

  # Assign points to polygons
  df<-gslSpatial::assign_points_terra(x,y,polygons[,index.polygons])
  df<-cbind(var,df)
  names(df)[ncol(df)]<-names(polygons)[index.polygons]

  # Polygons to data frame
  df.poly<-terra::as.data.frame(polygons[,index.polygons],geom='WKT')

  # Join data frames
  df2 <- tidyterra::left_join(df,df.poly)
  grps<-which(names(df2)%in%c('geometry',polygons.var))

  #df.ag<-eclectic::summarise_by_group(df2,grp.cols=c(grps),summarise.cols='var',fun)# trouble with count
  df.ag<-aggregate(df2[,'var'],by=list(df2$geometry),fun)#function(x) length(unique(x)))
  df.ag[,ncol(df.ag)]

  names(df.ag)<-c('geometry','fun')
  df2<-tidyterra::left_join(as.data.frame(polygons,geom='WKT'),df.ag)

  # Make shapefile
  #out<-vect(df.ag,geom='geometry')
  out<-vect(df2,geom='geometry')

  return(out)
}

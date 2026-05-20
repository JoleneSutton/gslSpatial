#' Assign polygons in one spatvector to polygons in another spatvector, based on greatest overlap
#'
#' Rather than identifying all intersecting polygons, this function identifies the polygon in 'y' that is associated with the greatest overlap of each polygon in 'x'.
#'
#' @param x A spatvector with one column. Want to assign polygons in x to polygons in y.
#' @param y A spatvector with one column.
#' @import sf
#' @importFrom dplyr group_by slice_max left_join
#' @importFrom terra intersect expanse
#' @importFrom utils globalVariables
#' @examples
#' #fa.poly<-vect('C:/Users/SUTTONJO/Documents/GCCODE/fisheries-landscape/analysis/lobster/data/fleet_polygons_formatted.shp')
#' #naf<-get_shapefile('nafo.clipped')
#' #naf<-project(naf,fa.poly)
#' #x<-crop(fa.poly,naf)
#' #x<-x[,13]
#' #y=naf[,1]
#' #test<-assign_polygons(x,y)
#' #test
#' #ggplot()+
#' #geom_spatvector(data=test[which(test$Label%in%c('4T','4S')),],aes(fill=Label))+#,col=NA
#' #geom_spatvector(data=naf,aes(col=Label),fill=NA)
#' @export
assign_polygons<-function(x,y){

  #deal with global variables
  polygon.id = NULL
  area = NULL

  z<-terra::intersect(x,y)
  z$polygon.id<-as.data.frame(z[,1])
  z$area<-terra::expanse(z,unit='km')

  z2<-z|>
    dplyr::group_by(polygon.id)|>
    dplyr::slice_max(order_by = area, n = 1, with_ties = TRUE)

  x2<-dplyr::left_join(x,as.data.frame(z2[,1:2]))
  return(x2)
}

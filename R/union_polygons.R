#' Union specified polygons within a shapefile.
#'
#' @param x A shapefile of class SpatVector or a class that can be converted to a SpatVector
#' @param lyr Name of layer identifying the polygons to union.
#' @param to.union Names of polygons to union.
#' @param new.name Which name to assign the unioned polygons. Default is the first item in "to.union".
#' @importFrom terra vect
#' @importFrom sf st_union
#' @importFrom sf st_as_sf
#' @examples
#' \dontrun{
#' library(gslSpatial)
#' library(terra)
#' library(tidyterra)
#' library(ggplot2)
#' v <- vect(system.file("ex/lux.shp", package="terra"))
#' ggplot()+geom_spatvector(data=v)+geom_spatvector_text(data=v,aes(label=NAME_2))
#' v2<-union_polygons(v,'NAME_2',c('Remich','Luxembourg'),'Remich-Luxembourg')
#' ggplot()+geom_spatvector(data=v2)+geom_spatvector_text(data=v2,aes(label=NAME_2))
#' }
#' @export
union_polygons<-function(x,lyr,to.union,new.name=NULL){

  try(
    if(isFALSE(inherits(x, "SpatVector"))){x<-vect(x)},
    stop("x must be class SpatVector or convertible to class SpatVector")   )

  COL<-which(names(x)==lyr)
  ids<-as.data.frame(x[,COL])
  rows<-which(ids[,1]%in%c(to.union))

  y<-terra::vect(sf::st_union(sf::st_as_sf(x[rows,]))) #prefer st_union to terra's option

  if(is.null(new.name)){new.name<-to.union[1]}

  y$new.name<-new.name
  names(y)<-lyr

  x<-x[-rows,]
  x<-rbind(x,y)

  return(x)
  }

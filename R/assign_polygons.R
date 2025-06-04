#' Assign polygons in one spatvector to polygons in another spatvector, based on greatest overlap
#'
#' @param x A spatvector with one column. Want to assign polygons in x to polygons in y.
#' @param y A spatvector with one column.
#' @import sf
#' @importFrom dplyr mutate
#' @importFrom terra vect merge
#' @importFrom utils globalVariables
#' @source https://gis.stackexchange.com/questions/140504/extracting-intersection-areas-in-r
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
  ID = NULL
  area.in.poly = NULL
  #. = NULL
  #utils::globalVariables(c("ID", "area.in.poly","."))

  polygon_id<-as.data.frame(x[,1])
  polygon_id<-unlist(polygon_id)
  x$polygon_id<-polygon_id

  x<-sf::st_as_sf(x)
  y<-sf::st_as_sf(y)
  pi <- suppressWarnings(sf::st_intersection(y, x) )

  # add in areas in m2
  #attArea <- pi |> dplyr::mutate(area = sf::st_area(.) |> as.numeric())
  attArea <- pi |> dplyr::mutate(area = sf::st_area(pi) |> as.numeric())

  # get area per polygon_id
  attArea<-as.data.frame(attArea)
  #head(attArea)
  #names(attArea)
  attArea<-attArea[,-which(names(attArea)=='geometry')]
  attArea$ID<-attArea[,1]

  attArea<-attArea |>
    dplyr::as_tibble() |>
    dplyr::group_by(ID, polygon_id) |>
    dplyr::summarize(area.in.poly = sum(area)) #x polygons that overlap with multiple y polygons are repeated, with area in each shown

  attArea2<-attArea |> # which y polygon contains most of each x polygon?
    dplyr::group_by(polygon_id) |>
    dplyr::filter(area.in.poly == max(area.in.poly))

  # attArea2$polygon_id
  # attArea2$ID

  out<-as.data.frame(attArea2[,1:2])
  names(out)<-c(names(y)[1],names(x)[1])

  x2<-terra::merge(terra::vect(x[,1]),out)

  return(x2)
}

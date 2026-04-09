#' Summarize parts of polygons that overlap one another
#'
#' Identifies parts of polygons that overlap, counts the number of overlapping portions, and
#' optionally sums a user-specified numeric variable in the overlapping portions. Returns a Spatvector in
#' which new polygons are created from the overlapping portions, and no overlaps remain.
#'
#' @param polys Spatvector of polygons
#' @param id Column that contains polygon names
#' @param var Optional numeric variable to sum
#' @importFrom sf st_as_sf st_intersection st_geometry_type
#' @importFrom terra vect
#' @examples
#' poly1 <- sf::st_polygon(list(rbind(c(0,-1), c(2,-1), c(2,2), c(0,2), c(0,-1))))
#' poly2 <- sf::st_polygon(list(rbind(c(1,1), c(3,1), c(3,3), c(1,3), c(1,1))))
#' poly3 <- sf::st_polygon(list(rbind(c(1.5,0), c(4,0), c(4,2), c(1.5,2), c(1.5,0))))
#' poly4 <- sf::st_polygon(list(rbind(c(5.5,0), c(8,0), c(8,2), c(5.5,2), c(5.5,0))))
#' sf_polys <- sf::st_sf(
#'   id = c('A','B','C','D'),
#'   value = c(10, 10, 50,8),
#'   geometry = sf::st_sfc(poly1, poly2, poly3,poly4),
#'   crs = 4326)
#' test<-terra::vect(sf_polys)
#' testit<-sum_overlaps(test,'id')
#' testit
#' testit<-sum_overlaps(test,'id','value')
#' testit
#' @export
sum_overlaps<-function(polys,id,var=NULL){

  check.dups<-as.data.frame(polys[,which(names(polys)==id)])
  if(TRUE%in%duplicated(check.dups)){
    stop("Error: There are duplicate polygon ids.")
  }

  sf_polys<-sf::st_as_sf(polys)
  parts<-sf::st_intersection(sf_polys)
  parts<-parts[sf::st_geometry_type(parts) %in% c("POLYGON", "MULTIPOLYGON"), ]

  col<-names(polys)[which(names(polys)==id)]
  ids<-as.character(unlist(as.data.frame(polys[,col])))

  for(i in 1:nrow(parts)){
    x<-as.numeric(unlist(parts$origins[i]))

    if (!is.null(var)){
      summed<-sum(vect(sf_polys[which(sf_polys[[col]]%in%ids[x]), which(names(parts)==var)]))
      col2<-paste0('sum.',var)
      parts[i,col2]<-summed
      }
    parts[i,'ids']<-paste(ids[x],collapse = ", ")
    }

  if (!is.null(var)){new.parts<-vect(parts[,c('ids','n.overlaps',col2)])}else{new.parts<-vect(parts[,c('ids','n.overlaps')])}
  return(new.parts)
}

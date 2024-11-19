#' Assign points to polygon using package terra
#'
#' Before applying function, make sure that the CRS of the polygon matches the CRS of the data points.
#' Each point must belong to only one polygon, otherwise see assign_points_secr.
#' Returns the original data frame with a new column of the assigned polygon.
#' IF THERE ARE OVERLAPPING POLYGONS, USE `assign_points_secr` INSTEAD.
#' @returns Data frame
#' @param x X coordinate (e.g., longitude) with same CRS as polygon
#' @param y Y coordinate (e.g., latitude) with same CRS as polygon
#' @param polygon Spatvector with geometry polygons

#' @examples
#' #poly<-get_shapefile('nafo.clipped')
#' #df2<-assign_points_terra(dat.ziff[1:50,'longitude'],dat.ziff[1:50,'latitude'],poly)
#' #head(df2)
#' @seealso assign_points_secr, dat.ziff, get_shapefile
#' @export
assign_points_terra<-function(x,y,polygon){

  df<-cbind.data.frame(x,y)
  names(df)<-c('x','y')

  n<-nrow(df)
  chunk_size <- 1000L
  actual_chunk_sizes <- rep(1000, n %/% chunk_size)
  if(n %% chunk_size != 0){actual_chunk_sizes <- c(actual_chunk_sizes, n %% chunk_size)}

  my_list<-list()
  for(j in seq_along(actual_chunk_sizes)){

    ROWS<-seq_len(actual_chunk_sizes[j]) + (j-1)*chunk_size
    writeLines(paste0("Assigning points ",min(ROWS)," to ",max(ROWS)," to NAFO. ",format(Sys.time(), "%X")  ))

    pts.vect<-vect(as.data.frame(df[ROWS,]),
                   geom=c('x', 'y'),
                   crs=terra::crs(polygon))

    OUT<-terra::extract(polygon, pts.vect)

    if(length(ROWS)!=nrow(OUT)){stop("ERROR: Some points may belong to multiple polygons. Try `assign_points_secr` instead")}
    my_list[[j]]<-cbind.data.frame(  df[ROWS,] , OUT[,2])# will not work if points assigned to multiple polygons
  }
  df2<-do.call("rbind", my_list)
  names(df2)[ncol(df2)]<-'assigned.polygon'

  return(df2)
}

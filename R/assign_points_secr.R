#' Assign points to polygon using package secr
#'
#' Before applying function, make sure that the CRS of the polygon matches the CRS of the data points.
#' Returns a dataframe. There is a column for each polygon with 1 or 0 indicating
#' whether each point falls within the polygon. There is also a column to indicate which polygon(s) each
#' point has been assigned to. USE THIS INSTEAD OF `assign_points_terra` WHEN THERE ARE OVERLAPPING POLYGONS.
#' @returns Returns a dataframe with nrow = df. There is a column for each polygon with 1 or 0 indicating
#' whether each point falls within the polygon. There is also a column to indicate which polygon(s) each
#' point has been assigned to.
#' @param x X coordinate (e.g., longitude) with same CRS as polygon
#' @param y Y coordinate (e.g., latitude) with same CRS as polygon
#' @param polygon Spatvector with geometry polygons
#' @param polygon.label The layer containing the name of each polygon in the Spatvector
#' @returns Data frame
#' @examples
#' #poly<-get_shapefile('nafo.clipped')
#' #df2<-assign_points_secr(dat.ziff[1:50,'longitude'],dat.ziff[1:50,'latitude'],poly,"Label")
#' #head(df2)
#' @seealso assign_points_terra, dat.ziff, get_shapefile
#' @export
assign_points_secr<-function(x,y,polygon,polygon.label){

  df<-cbind.data.frame(x,y)
  names(df)<-c('x','y')

  n<-nrow(df)
  chunk_size <- 1000L
  actual_chunk_sizes <- rep(1000, n %/% chunk_size)
  if(n %% chunk_size != 0){actual_chunk_sizes <- c(actual_chunk_sizes, n %% chunk_size)}

  my.list<-list()
  for(j in seq_along(actual_chunk_sizes)){

    ROWS<-seq_len(actual_chunk_sizes[j]) + (j-1)*chunk_size
    #COLS<-1:length(unlist(terra::values(polygon[,which(names(polygon) %in% polygon.label)])))
    COLS<-1:length(unlist(terra::values(polygon[,which(names(polygon) %in% polygon.label)])))
    out <- matrix(nrow = length(ROWS),ncol = length(COLS))


    writeLines(paste0("Processing points ",min(ROWS)," to ",max(ROWS),". ",format(Sys.time(), "%X")  ))

    for (i in 1:ncol(out)) {
      TMP <- as.data.frame(terra::geom(polygon[i, ]))
      TMP <- TMP[which(TMP$hole %in% 0), c("x", "y")]

      index <- which(secr::pointsInPolygon(df[ROWS, c('x','y')],TMP, logical = TRUE) %in% TRUE)

      if (length(index > 0)) {
        out[index, i] <- 1
        out[-index, i] <- 0
      }
      if (length(index) == 0) {
        out[, i] <- 0
      }
      out <- as.data.frame(out)
      names(out) <- unlist(terra::values(polygon[, which(names(polygon) %in% polygon.label)]))
    }
    out$assigned.polygon <- apply(out == "1", 1, FUN = function(x) toString(names(x)[x]))
    out[which(out$assigned.polygon == ""), "assigned.polygon"] <- NA
    #my.list[[j]]<-cbind.data.frame(  DATA[ROWS,] , out$assigned.polygon)
    my.list[[j]]<-out
  }
  OUT<-as.data.frame(do.call("rbind", my.list))
  return(OUT)
}

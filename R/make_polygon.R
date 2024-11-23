#' Make polygons from a data frame of spatial coordinates
#'
#' @param df A data frame spatial coordinates
#' @param x Name of column with x coordinates (e.g., longitude). Must be in order.
#' @param y Name of column with y coordinates (e.g., latitude). Must be in order.
#' @param grp.cols Index columns for dplyr::group_by. Must index at least one variable, which will be used to identify polygons.
#' @param crs The coordinate reference system to assign
#' @return Returns a SpatVector
#' @importFrom dplyr group_by summarise
#' @importFrom sf st_as_sf st_cast st_crs st_combine
#' @importFrom terra vect
#' @importFrom sp geometry
#' @examples
#' x<-c(-65,-60,-55, -61,-60,-59)
#' y<-c( 47, 50, 47,  48, 49, 48)
#' grp<-c(rep('big triangle',3),rep('small triangle',3))
#' source<-c(1,1,1,3,3,3)
#' d<-cbind.data.frame(x,y,grp,source)
#' d
#' pol<-make_polygon(d,'x','y',c('grp','source'),4326)
#' terra::plot(pol)
#' @export
make_polygon<-function(df,x,y,grp.cols,crs){

  X<-df[,x]
  Y<-df[,y]

  df2<-cbind(X,Y,df)
  index<-which(names(df2)%in%grp.cols)

    POLYGON <- df2 |>
    st_as_sf(coords = c('X','Y')) |>
    dplyr::group_by(df2[,index])|>
    dplyr::summarise(geometry = sf::st_combine(geometry)) |>
    sf::st_cast("POLYGON")
    sf::st_crs(POLYGON) <- crs
    POLYGON<-terra::vect(POLYGON)

  return(POLYGON)
}


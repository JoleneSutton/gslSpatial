#' Compute summary statistics of variables in a data frame for each raster grid cell
#'
#' Note that data points outside of the grid area will be ignored.
#'
#' @param df Data frame with columns X and Y for UTM coordinates. Coordinate reference system of df should match the coordinate reference system of grid
#' @param var Variable(s) in df to summarize
#' @param fun A function to compute the summary statistics
#' @param grid Either a data frame of raster grid cells with columns of X and Y for UTM coordinates, or a RasterLayer (package raster). Coordinate reference system of df should match the coordinate reference system of grid
#' @param out Option to return a SpatRaster (default) or a data frame. For a data.frame, use out='df'.
#' @returns SpatRaster or data frame
#' @importFrom raster rasterFromXYZ
#' @importFrom terra rasterize rast crs values
#' @importFrom sp SpatialPointsDataFrame
#' @examples
#' x<-aggregate_raster(dat.rv,c("whake.kg.tow",'redfish.kg.tow'),sum,pgrid4,out='df')
#' head(x)
#' x2<-aggregate_raster(dat.rv,c("whake.kg.tow",'redfish.kg.tow'),sum,pgrid4)
#' x2
#' @export
aggregate_raster<-function(df,var,fun,grid,out=NULL){

  if(inherits(grid, "data.frame")){
    raster.grid=raster::rasterFromXYZ(grid[,c('X','Y')])
  }else{raster.grid=grid}

  coords <- df[ , c("X", "Y")]
  data   <- as.data.frame(df[ , var])

  r.df<- sp::SpatialPointsDataFrame(coords      = coords,
                                    data        = data)

  r.df <- terra::rasterize(r.df, raster.grid,fun=fun, na.rm=TRUE)
  r.df<-terra::rast(r.df)

  if(!is.null(out)){
    if(out=='df'){
    r.df<-as.data.frame(r.df, xy=T)
    r.df<-r.df[,-3]
    names(r.df)[1:2]<-c("X","Y")
    }}

  return(r.df)
}

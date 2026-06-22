#' Make a prediction grid
#'
#' Make a spatial grid over a defined area. Returned coordinates are the centroids of the grid cells.
#' The size of square or rectangular grid cells is defined by a user-specified resolution.
#' The size of hexagonal grid cells is defined by a user-specified area.
#' Returns a SpatVector  with columns of coordinates to simplify conversion to a data frame.
#' Note that specifying small grid cells will take longer to generate than large grid cells.
#'
#' @param crs Coordinate reference system.
#' @param shape Optional polygon file (SpatVector) to define the area over which a grid should be made. If shape=NULL, defaults to NAFO divisions 3Pn4RSTVn. Note that adjacent polygons will be aggregated and holes will be filled, so that grid cells are only cropped to outer boundaries.
#' @param res User defined grid resolution e.g., res=4 will produce 4x4 unit grids, whereas res=c(2,4) will produce 2x4 unit grids. Units will depend on the specified CRS. Required for non-hexagonal grid cells. If hex=TRUE, res is ignored.
#' @param hex Option to generate hexagonal grid cells. Default is FALSE.
#' @param hex.area Area of hexagonal grid cells. Only required if hex=TRUE.
#' @returns Returns a SpatVector with columns of coordinates and cell area. Use as.data.frame(SpatVector) to convert to a data frame.
#' @importFrom terra fillHoles aggregate project is.lonlat rast crds as.polygons centroids relate crop expanse vect
#' @importFrom raster raster rasterize
#' @importFrom sf as_Spatial st_as_sf st_make_grid st_bbox sf_use_s2
#' @seealso get_shapefile()
#' @examples
#' \dontrun{
#' crs<-'epsg:4326'
#' res=c(0.5)
#' t1=make_grid(crs=crs,res=res)
#' t1
#'
#' crs<-'epsg:32620' #units are meters
#' res=20*1000 #km
#' t2=make_grid(crs=crs,res=res)
#' t2
#'
#' crs<-'epsg:32620' #units are meters
#' t3=make_grid(crs=crs,hex=TRUE,hex.area=400)
#' t3
#'
#' crs<-'ESRI:102001'
#' t4=make_grid(crs=crs,hex=TRUE,hex.area=400)
#' t4
#'
#' crs<-'ESRI:102001'
#' poly=get_shapefile('rv.sgsl')
#' t5=make_grid(crs=crs,shape=poly,hex=TRUE,hex.area=100)
#' t5
#'
#' head(as.data.frame(t1))
#' head(as.data.frame(t2))
#' head(as.data.frame(t3))
#' head(as.data.frame(t4))
#' head(as.data.frame(t5))
#'
#' ggplot2::ggplot()+tidyterra::geom_spatvector(data=t1,aes(fill=area_km))
#'
#' ggplot2::ggplot()+tidyterra::geom_spatvector(data=t2,aes(fill=area_km))
#'
#' ggplot2::ggplot()+tidyterra::geom_spatvector(data=t3,aes(fill=area_km))
#'
#' ggplot2::ggplot()+tidyterra::geom_spatvector(data=t4,aes(fill=area_km))
#'
#' ggplot2::ggplot()+tidyterra::geom_spatvector(data=t5,aes(fill=area_km))
#' }
#' @export

make_grid<-function(crs,shape=NULL,res=NULL,hex=FALSE,hex.area=NULL){

  if(is.null(shape)){
    shape<-suppressMessages(gslSpatial::get_shapefile('nafo.clipped'))
  }

  current_state <- sf_use_s2()
  if(isTRUE(current_state)){sf::sf_use_s2(FALSE)}
  shape<-terra::makeValid(shape)
  shape<-terra::aggregate(shape)
  shape<-fillHoles(shape)
  if(isFALSE(current_state)){sf::sf_use_s2(current_state)}
  shape<-terra::project(shape,crs)

  #////////////////////////////////////////////////////////////
  # If hex=FALSE----
  if(isFALSE(hex)){

    if(isTRUE(terra::is.lonlat(crs))){
      message('CRS is lonlat format. Resolution respresents units of longitude and latitude.')
    }else(message("CRS is planar. Resolution represents units of planar distance."))

    r <- raster::raster(sf::as_Spatial(sf::st_as_sf(shape)), resolution = res)
    rr <- raster::rasterize(sf::as_Spatial(sf::st_as_sf(shape)), r, getCover = T)

    test<-terra::rast(rr)
    test$x<-terra::crds(test)[,1]
    test$y<-terra::crds(test)[,2]

    test2<-terra::as.polygons(test,aggregate=FALSE)

    #if centroids outside of shape, remove polygon
    pts<-terra::centroids(test2)
    inout<-terra::relate(shape, pts, "contains")
    index<-which(inout==TRUE)
    test3<-test2[index,]
    test4<-terra::crop(test3,shape)
    test4$area_km<-terra::expanse(test4,unit='km')
    test4<-test4[,-1]

    return(test4)
  }

  #////////////////////////////////////////////////////////////
  # If hex=TRUE----

  if(isTRUE(hex)){

    if(isTRUE(terra::is.lonlat(crs))){
      stop("The specified CRS is lonlat format. For hexagonal grid cells, please specify a planar projection instead.",
           call. = FALSE)
    }

    if(is.null(hex.area)){
      stop("For hexagonal grid cells, area must be specified",call. = FALSE)
    }


    ## helper function to get diameter of (spherical) hexagon with area A:
    area2diam <- \(A) 2*sqrt(.5*A/(sqrt(3)))
    AREA=hex.area #km
    AREA=AREA*1000000
    hexgrid <- terra::vect(sf::st_make_grid(sf::st_bbox(shape),
                                            cellsize = area2diam(AREA),
                                            square = FALSE))

    hexgrid$x<-terra::geom(terra::centroids(hexgrid))[,3]
    hexgrid$y<-terra::geom(terra::centroids(hexgrid))[,4]

    #if centroids outside of shape, remove polygon
    pts<-terra::centroids(hexgrid)
    inout<-terra::relate(shape, pts, "contains")
    index<-which(inout==TRUE)
    hexgrid2<-hexgrid[index,]

    hexgrid3<-terra::crop(hexgrid2,shape)
    hexgrid3$area_km<-terra::expanse(hexgrid3,unit='km')

    return(hexgrid3)
  }

}

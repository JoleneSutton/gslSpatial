#' Make a prediction grid for the Gulf Region
#'
#' Returns a data frame with coordinates that are equidistant from one another (raster grid cells), along
#' with their associated NAFO divisions for 3Pn4RSTVn.
#' The coordinates are the centers of the grid cells.
#' Longitude and latitude coordinates are NAD83, EPSG:4269, in decimal degrees. X and Y coordinates are NAD83, UTM zone 20N, in km.
#' @param res User defined grid resolution e.g., specifying 4 will produce 4x4km grid sizes
#' @importFrom terra project vect aggregate extract
#' @importFrom raster raster rasterize
#' @importFrom sf st_as_sf st_coordinates st_transform as_Spatial
#' @importFrom sp SpatialPoints spTransform coordinates
#' @importFrom ggplot2 ggplot geom_raster
#' @seealso get_shapefile()
#' @examples
#' #pgrid<-make_grid(20)
#' #ggplot()+geom_raster(data=pgrid,aes(X,Y,fill=nafo.assigned))
#' @export
make_grid<-function(res){

  shape<-get_shapefile('nafo.clipped')#SHAPEFILE

  ## Make raster grids
  pa0 <- terra::aggregate(shape)
  shape2<-sf::st_as_sf(pa0)
  shapeutm<-sf::st_transform (shape2, crs='+proj=utm +zone=20 +datum=NAD83 +units=km +no_defs')#crs="+proj=utm +zone=20 +datum=WGS84 +units=km")

  r <- raster::raster(sf::as_Spatial(shapeutm), resolution = res)
  rr <- raster::rasterize(sf::as_Spatial(shapeutm), r, getCover = T)

  pagrid <- base::as.data.frame(raster::rasterToPoints(rr))
  pagrid$'area'<-pagrid[,3] * res * res
  pagrid<-pagrid[which(pagrid[,'area']>0),-3]

  sputm <- sp::SpatialPoints(pagrid, proj4string=sp::CRS("+proj=utm +zone=20 +datum=NAD83 +units=km +no_defs"))
  spgeo <- sp::spTransform(sputm, sp::CRS("+proj=longlat +datum=NAD83 +no_defs"))

  lnlt <- sp::coordinates(spgeo)
  pagrid2<-cbind.data.frame(pagrid,lnlt[,1:2])
  names(pagrid2)<-c('X',"Y","area","longitude","latitude")

  # Assign nafo
  writeLines(paste0("Assigning NAFO divisions to ",nrow(pagrid2) ," grid cells."))
  pagrid2$nafo.assigned<-assign_points_secr(pagrid2$longitude,pagrid2$latitude,shape,'Label')$assigned.polygon
  pagrid2[pagrid2==""]<-NA
  return(pagrid2)
  }

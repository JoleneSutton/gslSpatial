#' Retrieve a stored shapefile
#'
#' Imports a stored shapefile as a SpatVector (terra).
#' @param x Either "nafo", "nafo.clipped", "mpa", "oecm","hex". The "nafo" shapefile is not clipped to land. The "nafo.clipped" shapefile is clipped to land. The 'hex' shapefile is a hexagonal grid used in the fisheriescape project.
#' @importFrom terra vect
#' @importFrom terra project
#' @importFrom terra plot
#' @return Returns a SpatVector
#' @examples
#' naf<-get_shapefile('nafo.clipped')
#' naf
#' @export
get_shapefile<-function(x){

  if(x == 'nafo.clipped'){
    POLY<-terra::vect(system.file('extdata','nafo_clipped/nafo_clipped.shp',package='gslSpatial'))
    writeLines("Source: https://www.nafo.int")
  }

  if(x == 'nafo'){
    POLY<-terra::vect(system.file('extdata','nafo_unclipped/nafo_unclipped.shp',package='gslSpatial'))
    writeLines("Source: https://www.nafo.int")
  }

  if(x == 'mpa'){
    writeLines("Oceans Act Marine Protected Areas, source:https://open.canada.ca")
    POLY<-terra::vect(system.file('extdata','mpa_clipped/mpa_clipped.shp',package='gslSpatial'))
  }

  if(x == 'oecm'){
    writeLines("Other Effective Area-Based Conservation Measures, source:https://open.canada.ca")
    POLY<-terra::vect(system.file('extdata','oeabcm_clipped/oeabcm_clipped.shp',package='gslSpatial'))
  }

  if(x == 'hex'){
    writeLines("10 x 10 km hex grid")
    POLY<-terra::vect(system.file('extdata','hex_clipped/hex_clipped.shp',package='gslSpatial'))
  }



  return(POLY)
}

#' Example data set: Research Vessel (RV) Survey
#'
#' An example data set containing spatial information and fish species catch densities (kg/tow). Not useful for formal analysis!
#'
#' @format A data frame with 1371 rows and 11 variables:
#' \describe{
#'   \item{X}{Easting, UTM NAD83, Zone:20N, Units:km}
#'   \item{Y}{Northing, UTM NAD83, Zone:20N, Units:km}
#'   \item{longitude}{decimal degrees, NAD83, EPSG:4269}
#'   \item{latitude}{decimal degrees, NAD83, EPSG:4269}
#'   \item{year}{survey year}
#'   \item{depth}{depth of the tow in meters}
#'   \item{whake.kg.tow}{catch density of White Hake}
#'   \item{redfish.kg.tow}{catch density of Redfish}
#'   \item{ahalibut.kg.tow}{catch density of Atlantic Halibut}
#'   \item{ghalibut.kg.tow}{catch density of Greenland Halibut}
#'   \item{witch.kg.tow}{catch density of Witch Flounder}
#' }
"dat.rv"

#' Example data set: Commercial Landings
#'
#' An example data set containing spatial information and species catch weights. Not useful for formal analysis!
#'
#' @format A data frame with 4559 rows and 16 variables:
#' \describe{
#'   \item{X}{Easting, UTM NAD83, Zone:20N, Units:km}
#'   \item{Y}{Northing, UTM NAD83, Zone:20N, Units:km}
#'   \item{ancfvn}{Anonymised cfvn}
#'   \item{date.landed}{date.landed}
#'   \item{species.code}{species.code}
#'   \item{round.weight}{round.weight}
#'   \item{main.species.caught}{main.species.caught}
#'   \item{main.species.sought}{main.species.sought}
#'   \item{date.caught}{date.caught}
#'   \item{latitude}{decimal degrees, NAD83, EPSG:4269}
#'   \item{longitude}{decimal degrees, NAD83, EPSG:4269}
#'   \item{gear.class}{gear.class}
#'   \item{year}{year}
#'   \item{year.landed}{year.landed}
#'   \item{month.landed}{month.landed}
#'   \item{day.landed}{day.landed}
#' }
"dat.ziff"

#' Data frame of visreg fits
#'
#' Example data frame
#'
#' @format A data frame with 101 rows and 2 variables.
"dat.visreg.fits"

#' An example prediction grid for the Gulf of St. Lawrence
#'
#' A grid covering 4Pn4RSTVn with 4x4km grid cells.
#'
#' @format A data frame with 18885 rows and 7 variables:
#' \describe{
#'   \item{X}{Easting, UTM NAD83, Zone:20N, Units:km}
#'   \item{Y}{Northing, UTM NAD83, Zone:20N, Units:km}
#'   \item{area}{Area of each grid cell}
#'   \item{longitude}{decimal degrees, NAD83, EPSG:4269}
#'   \item{latitude}{decimal degrees, NAD83, EPSG:4269}
#'   \item{nafo.assigned}{NAFO division or subdivision}
#'   \item{depth}{Depth in meters, based on bathymetry reference GEBCO 2024}
#' }
"pgrid4"

#' Oceans Act Marine Protected Areas shapefile
#'
#' A shapefile sourced from https://open.canada.ca, restricted to 3Pn4RSTVn. Accessed with get_shapefile('mpa')
#'
#' @format Retrieved as class SpatVector with get_shapefile('mpa')
"mpa"

#' Northwest Atlantic Fisheries Organization (NAFO) shapefile, clipped to land
#'
#' A shapefile sourced from https://www.nafo.int, restricted to 3Pn4RSTVn. Accessed with get_shapefile('nafo.clipped')
#'
#' @format Retrieved as class SpatVector with get_shapefile('nafo.clipped')
"nafo.clipped"

#' Northwest Atlantic Fisheries Organization (NAFO) shapefile, not clipped to land
#'
#' A shapefile sourced from https://www.nafo.int, restricted to 3Pn4RSTVn. Accessed with get_shapefile('nafo')
#'
#' @format Retrieved as class SpatVector with get_shapefile('nafo')
"nafo.unclipped"

#' Other Effective Area-Based Conservation Measures shapefile
#'
#' A shapefile sourced from https://open.canada.ca, restricted to 3Pn4RSTVn. Accessed with get_shapefile('oecm')
#'
#' @format Retrieved as class SpatVector with get_shapefile('oecm')
"oecm"

#' Hexagonal grid, 10x10km
#'
#' A shapefile used in the fisheriescape project. CRS = ESRI:102001. Accessed with get_shapefile('hex')
#'
#' @format Retrieved as class SpatVector with get_shapefile('hex')
"hex"

#' Gulf of St. Lawrence Winter Research Vessel Survey
#'
#' A shapefile of the boundaries of the Gulf of St. Lawrence Winter Research Vessel Survey. Accessed with get_shapefile('rv.winter')
#'
#' @format Retrieved as class SpatVector with get_shapefile('rv.winter')
"rv.winter"

#' Southern Gulf of St. Lawrence September Research Vessel Survey
#'
#' A shapefile of the boundaries of the Southern Gulf of St. Lawrence September Research Vessel Survey. Accessed with get_shapefile('rv.sgsl')
#'
#' @format Retrieved as class SpatVector with get_shapefile('rv.sgsl')
"rv.sgsl"

#' Coastline shapefile
#'
#' A shapefile of the coastline. Accessed with get_shapefile('coastline')
#'
#' @format Retrieved as class SpatVector with get_shapefile('coastline')
"coastline"

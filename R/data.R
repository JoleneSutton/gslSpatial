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
#'   \item{redfish.kg.tow}{catch density of White Hake}
#'   \item{ahalibut.kg.tow}{catch density of Atlantic Halibut}
#'   \item{ghalibut.kg.tow}{catch density of Greenland Halibut}
#'   \item{witch.kg.tow}{catch density of Witch Flounder}
#' }
"dat.rv"

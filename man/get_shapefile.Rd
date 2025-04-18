% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_shapefile.R
\name{get_shapefile}
\alias{get_shapefile}
\title{Retrieve a stored shapefile}
\usage{
get_shapefile(x)
}
\arguments{
\item{x}{Either "nafo", "nafo.clipped", "mpa", "oecm","hex",'rv.winter', 'rv.sgsl', 'coastline'. The "nafo" shapefile is not clipped to land. The "nafo.clipped" shapefile is clipped to land. The 'hex' shapefile is a hexagonal grid used in the fisheriescape project.}
}
\value{
Returns a SpatVector
}
\description{
Imports a stored shapefile as a SpatVector (terra).
}
\examples{
naf<-get_shapefile('nafo.clipped')
naf
}

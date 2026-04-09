# Get depths associated with longitude and latitude

Returns depths in meters. The bathymetry reference used is GEBCO_2024,
www.gebco.net.

## Usage

``` r
get_depth(lon, lat, crs = "epsg:4269")
```

## Arguments

- lon:

  Longitude in decimal degrees

- lat:

  Latitude in decimal degrees

- crs:

  Coordinate reference system for lon and lat. Default is NAD83,
  EPSG:4269

## Examples

``` r
#get_depth(-62,44)
```

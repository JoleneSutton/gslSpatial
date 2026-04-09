# Transform (project/change) spatial coordinates from one coordinate reference system to another

Transform (project/change) spatial coordinates from one coordinate
reference system to another

## Usage

``` r
transform_coords(lon, lat, from, to)
```

## Arguments

- lon:

  Longitude

- lat:

  Latitude

- from:

  Original coordinate reference system

- to:

  Desired coordinate reference system

## Value

matrix, array

## Examples

``` r
lon=c(-55,-57)
lat=c(62,63)
transform_coords(lon,lat,from='epsg:4269',to='ESRI:102001')
#>         [,1]    [,2]
#> [1,] 1986869 3071381
#> [2,] 1839361 3108108
```

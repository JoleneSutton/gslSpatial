# Retrieve a stored shapefile

Imports a stored shapefile as a SpatVector (terra).

## Usage

``` r
get_shapefile(x)
```

## Arguments

- x:

  Either "nafo", "nafo.clipped", "mpa", "oecm","hex",'rv.winter',
  'rv.sgsl', 'coastline'. The "nafo" shapefile is not clipped to land.
  The "nafo.clipped" shapefile is clipped to land. The 'hex' shapefile
  is a hexagonal grid used in the fisheriescape project.

## Value

Returns a SpatVector

## Examples

``` r
naf<-get_shapefile('nafo.clipped')
#> Source: https://www.nafo.int
naf
#>  class       : SpatVector 
#>  geometry    : polygons 
#>  dimensions  : 5, 6  (geometries, attributes)
#>  extent      : -71.21003, -55.42664, 45.60208, 52.25  (xmin, xmax, ymin, ymax)
#>  coord. ref. : lon/lat NAD83 (EPSG:4269) 
#>  names       : Label SubArea Division SubDiv SubSubDiv Shape_Area
#>  type        : <chr>   <chr>    <chr>  <chr>     <chr>      <num>
#>  values      :   3Pn       3       3P    3Pn        NA      0.852
#>                   4R       4       4R     NA        NA      5.072
#>                   4S       4       4S     NA        NA      10.24
```

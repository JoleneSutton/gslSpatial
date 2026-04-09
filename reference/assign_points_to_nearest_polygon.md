# For points that are not within polygons, find the nearest polygon edge

For points that are not within polygons, find the nearest polygon edge

## Usage

``` r
assign_points_to_nearest_polygon(x, y, polygon, layer)
```

## Source

https://stackoverflow.com/questions/72561812/return-polygon-nearest-to-a-point-using-terra-in-r

## Arguments

- x:

  X-coordinates (must have same crs as polygon)

- y:

  Y-coordinates (must have same crs as polygon)

- polygon:

  A spatvector with geometry polygons

- layer:

  The name of the polygon layer containing the polygon identities

## Value

A data frame

## Author

Robert Hijmans (package `terra`)

## Examples

``` r
v <- terra::vect(system.file("ex/lux.shp", package="terra"))
pts <- matrix(c(5.812,6.577,5.864,50.126,49.774,49.488), ncol=2)
assign_points_to_nearest_polygon(pts[,1],pts[,2],v,'NAME_2')
#>       x      y           NAME_2 n$distance
#> 1 5.812 50.126         Clervaux   6691.933
#> 2 6.577 49.774       Echternach   4290.021
#> 3 5.864 49.488 Esch-sur-Alzette   1473.792
```

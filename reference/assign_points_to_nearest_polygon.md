# For points that are not within polygons, find the nearest polygon edge

For points that are not within polygons, find the nearest polygon edge

## Usage

``` r
assign_points_to_nearest_polygon(x, y, polygon)
```

## Arguments

- x:

  X-coordinates (must have same crs as polygon)

- y:

  Y-coordinates (must have same crs as polygon)

- polygon:

  A spatvector with geometry polygons

## Value

A data frame

## Examples

``` r
v <- terra::vect(system.file("ex/lux.shp", package="terra"))
pts <- matrix(c(5.812,6.577,5.864,50.126,49.774,49.488), ncol=2)
assign_points_to_nearest_polygon(pts[,1],pts[,2],v)
#>       x      y closest.polygon closest.distance.km
#> 1 5.812 50.126               1            6.680351
#> 2 6.577 49.774               2            4.281900
#> 3 5.864 49.488               3            1.438763
```

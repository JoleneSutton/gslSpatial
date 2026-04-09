# Summarize parts of polygons that overlap one another

Identifies parts of polygons that overlap, counts the number of
overlapping portions, and optionally sums a user-specified numeric
variable in the overlapping portions. Returns a Spatvector in which new
polygons are created from the overlapping portions, and no overlaps
remain.

## Usage

``` r
sum_overlaps(polys, id, var = NULL)
```

## Arguments

- polys:

  Spatvector of polygons

- id:

  Column that contains polygon names

- var:

  Optional numeric variable to sum

## Examples

``` r
poly1 <- sf::st_polygon(list(rbind(c(0,-1), c(2,-1), c(2,2), c(0,2), c(0,-1))))
poly2 <- sf::st_polygon(list(rbind(c(1,1), c(3,1), c(3,3), c(1,3), c(1,1))))
poly3 <- sf::st_polygon(list(rbind(c(1.5,0), c(4,0), c(4,2), c(1.5,2), c(1.5,0))))
poly4 <- sf::st_polygon(list(rbind(c(5.5,0), c(8,0), c(8,2), c(5.5,2), c(5.5,0))))
sf_polys <- sf::st_sf(
  id = c('A','B','C','D'),
  value = c(10, 10, 50,8),
  geometry = sf::st_sfc(poly1, poly2, poly3,poly4),
  crs = 4326)
test<-terra::vect(sf_polys)
testit<-sum_overlaps(test,'id')
#> although coordinates are longitude/latitude, st_intersection assumes that they
#> are planar
testit
#>  class       : SpatVector 
#>  geometry    : polygons 
#>  dimensions  : 8, 2  (geometries, attributes)
#>  extent      : 0, 8, -1, 3  (xmin, xmax, ymin, ymax)
#>  coord. ref. : lon/lat WGS 84 (EPSG:4326) 
#>  names       :   ids n.overlaps
#>  type        : <chr>      <int>
#>  values      :     A          1
#>                 A, B          2
#>                    B          1
testit<-sum_overlaps(test,'id','value')
#> although coordinates are longitude/latitude, st_intersection assumes that they
#> are planar
testit
#>  class       : SpatVector 
#>  geometry    : polygons 
#>  dimensions  : 8, 3  (geometries, attributes)
#>  extent      : 0, 8, -1, 3  (xmin, xmax, ymin, ymax)
#>  coord. ref. : lon/lat WGS 84 (EPSG:4326) 
#>  names       :   ids n.overlaps sum.value
#>  type        : <chr>      <int>     <num>
#>  values      :     A          1        10
#>                 A, B          2        20
#>                    B          1        10
```

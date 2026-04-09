# Make polygons from a data frame of spatial coordinates

Make polygons from a data frame of spatial coordinates

## Usage

``` r
make_polygon(df, x, y, grp.cols, crs)
```

## Arguments

- df:

  A data frame spatial coordinates

- x:

  Name of column with x coordinates (e.g., longitude). Must be in order.

- y:

  Name of column with y coordinates (e.g., latitude). Must be in order.

- grp.cols:

  Index columns for dplyr::group_by. Must index at least one variable,
  which will be used to identify polygons.

- crs:

  The coordinate reference system to assign

## Value

Returns a SpatVector

## Examples

``` r
x<-c(-65,-60,-55, -61,-60,-59)
y<-c( 47, 50, 47,  48, 49, 48)
grp<-c(rep('big triangle',3),rep('small triangle',3))
source<-c(1,1,1,3,3,3)
d<-cbind.data.frame(x,y,grp,source)
d
#>     x  y            grp source
#> 1 -65 47   big triangle      1
#> 2 -60 50   big triangle      1
#> 3 -55 47   big triangle      1
#> 4 -61 48 small triangle      3
#> 5 -60 49 small triangle      3
#> 6 -59 48 small triangle      3
pol<-make_polygon(d,'x','y',c('grp','source'),4326)
terra::plot(pol)
```

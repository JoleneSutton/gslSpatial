# Compute summary statistics of variables in a data frame for each raster grid cell

Note that data points outside of the grid area will be ignored.

## Usage

``` r
aggregate_raster(df, var, fun, grid, out = NULL)
```

## Arguments

- df:

  Data frame with columns X and Y for UTM coordinates. Coordinate
  reference system of df should match the coordinate reference system of
  grid

- var:

  Variable(s) in df to summarize

- fun:

  A function to compute the summary statistics

- grid:

  Either a data frame of raster grid cells with columns of X and Y for
  UTM coordinates, or a RasterLayer (package raster). Coordinate
  reference system of df should match the coordinate reference system of
  grid

- out:

  Option to return a SpatRaster (default) or a data frame. For a
  data.frame, use out='df'.

## Value

SpatRaster or data frame

## Examples

``` r
x<-aggregate_raster(dat.rv,c("whake.kg.tow",'redfish.kg.tow'),sum,pgrid4,out='df')
head(x)
#>              X        Y whake.kg.tow redfish.kg.tow
#> 26830 427.9978 5441.911     6.549223       571.4963
#> 27116 423.9978 5437.911     1.833807       398.4498
#> 27118 431.9978 5437.911     2.419121      1777.5936
#> 27404 427.9978 5433.911    12.073557       573.3970
#> 27408 443.9978 5433.911     5.551337       931.4065
#> 27690 423.9978 5429.911    12.071751       352.3210
x2<-aggregate_raster(dat.rv,c("whake.kg.tow",'redfish.kg.tow'),sum,pgrid4)
x2
#> class       : SpatRaster 
#> size        : 191, 287, 3  (nrow, ncol, nlyr)
#> resolution  : 4, 4  (x, y)
#> extent      : -126.0022, 1021.998, 5051.911, 5815.911  (xmin, xmax, ymin, ymax)
#> coord. ref. :  
#> source(s)   : memory
#> names       :   ID, whake.kg.tow, redfish.kg.tow 
#> min values  :    1,       0.0000,          0.000 
#> max values  : 4350,     200.8836,       6811.538 
```

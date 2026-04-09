# Assign points to polygon using package terra

Before applying function, make sure that the CRS of the polygon matches
the CRS of the data points. Each point must belong to only one polygon,
otherwise see assign_points_secr. Returns the original data frame with a
new column of the assigned polygon. IF THERE ARE OVERLAPPING POLYGONS,
USE `assign_points_secr` INSTEAD.

## Usage

``` r
assign_points_terra(x, y, polygon)
```

## Arguments

- x:

  X coordinate (e.g., longitude) with same CRS as polygon

- y:

  Y coordinate (e.g., latitude) with same CRS as polygon

- polygon:

  Spatvector with geometry polygons

## Value

Data frame

## See also

assign_points_secr, dat.ziff, get_shapefile

## Examples

``` r
#poly<-get_shapefile('nafo.clipped')
#df2<-assign_points_terra(dat.ziff[1:50,'longitude'],dat.ziff[1:50,'latitude'],poly)
#head(df2)
```

# Assign points to polygon using package secr

Before applying function, make sure that the CRS of the polygon matches
the CRS of the data points. Returns a dataframe. There is a column for
each polygon with 1 or 0 indicating whether each point falls within the
polygon. There is also a column to indicate which polygon(s) each point
has been assigned to. USE THIS INSTEAD OF `assign_points_terra` WHEN
THERE ARE OVERLAPPING POLYGONS.

## Usage

``` r
assign_points_secr(x, y, polygon, polygon.label)
```

## Arguments

- x:

  X coordinate (e.g., longitude) with same CRS as polygon

- y:

  Y coordinate (e.g., latitude) with same CRS as polygon

- polygon:

  Spatvector with geometry polygons

- polygon.label:

  The layer containing the name of each polygon in the Spatvector

## Value

Returns a dataframe with nrow = df. There is a column for each polygon
with 1 or 0 indicating whether each point falls within the polygon.
There is also a column to indicate which polygon(s) each point has been
assigned to.

Data frame

## See also

assign_points_terra, dat.ziff, get_shapefile

## Examples

``` r
#poly<-get_shapefile('nafo.clipped')
#df2<-assign_points_secr(dat.ziff[1:50,'longitude'],dat.ziff[1:50,'latitude'],poly,"Label")
#head(df2)
```

# Compute summary statistics of a variable over polygons in a shapefile

Note that data points that don't overlap with any polygons will be
ignored.

## Usage

``` r
aggregate_polygons(x, y, var, polygons, polygons.var, fun)
```

## Arguments

- x:

  X-coordinates of point data. CRS should match that of polygons

- y:

  Y-coordinates of point data. CRS should match that of polygons

- var:

  Variable to summarise

- polygons:

  SpatVector with geometry polygons

- polygons.var:

  Attribute (column) in polygons used to identify each polygon

- fun:

  A function to compute the summary statistics

## Examples

``` r
if (FALSE) { # \dontrun{
library(gslSpatial)
library(terra)
library(ggplot2)
library(tidyterra)
f <- system.file("ex/lux.shp", package="terra")
polygons <- vect(f)
set.seed(3241)
points <- spatSample(polygons, 10)
values(points) <- sample(1:10,length(points),replace=TRUE)
points<-as.data.frame(points,geom='xy')#because I normally have data in data frames
head(points)
ggplot()+
tidyterra::geom_spatvector(data=polygons)+
tidyterra::geom_spatvector_text(data=polygons,aes(label=NAME_2))+
geom_text(data=points,aes(x,y,label=value),nudge_y = -.015)
names(polygons)
test1<-aggregate_polygons(points$x,points$y,points$val,polygons,polygons.var='NAME_2',sum)
test2<-aggregate_polygons(points$x,points$y,points$val,polygons,polygons.var='NAME_2',max)
test3<-aggregate_polygons(points$x,points$y,points$val,polygons,polygons.var='NAME_2',length)
test1
test2
test3
ggplot()+
geom_spatvector(data=test1,aes(fill=fun))+
geom_spatvector_text(data=test1,aes(label=fun))+
geom_spatvector_text(data=test1,aes(label=NAME_2),nudge_y = .015)
ggplot()+
geom_spatvector(data=test2,aes(fill=fun))+
geom_spatvector_text(data=test2,aes(label=fun))+
geom_spatvector_text(data=test2,aes(label=NAME_2),nudge_y = .015)
ggplot()+
geom_spatvector(data=test3,aes(fill=fun))+
geom_spatvector_text(data=test3,aes(label=fun))+
geom_spatvector_text(data=test3,aes(label=NAME_2),nudge_y = .015)
} # }
```

# Union specified polygons within a shapefile.

Union specified polygons within a shapefile.

## Usage

``` r
union_polygons(x, lyr, to.union, new.name = NULL)
```

## Arguments

- x:

  A shapefile of class SpatVector or a class that can be converted to a
  SpatVector

- lyr:

  Name of layer identifying the polygons to union.

- to.union:

  Names of polygons to union.

- new.name:

  Which name to assign the unioned polygons. Default is the first item
  in "to.union".

## Examples

``` r
if (FALSE) { # \dontrun{
library(gslSpatial)
library(terra)
library(tidyterra)
library(ggplot2)
v <- vect(system.file("ex/lux.shp", package="terra"))
ggplot()+geom_spatvector(data=v)+geom_spatvector_text(data=v,aes(label=NAME_2))
v2<-union_polygons(v,'NAME_2',c('Remich','Luxembourg'),'Remich-Luxembourg')
ggplot()+geom_spatvector(data=v2)+geom_spatvector_text(data=v2,aes(label=NAME_2))
} # }
```

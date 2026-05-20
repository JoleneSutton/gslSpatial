# Assign polygons in one spatvector to polygons in another spatvector, based on greatest overlap

Rather than identifying all intersecting polygons, this function
identifies the polygon in 'y' that is associated with the greatest
overlap of each polygon in 'x'.

## Usage

``` r
assign_polygons(x, y)
```

## Arguments

- x:

  A spatvector with one column. Want to assign polygons in x to polygons
  in y.

- y:

  A spatvector with one column.

## Examples

``` r
#fa.poly<-vect('C:/Users/SUTTONJO/Documents/GCCODE/fisheries-landscape/analysis/lobster/data/fleet_polygons_formatted.shp')
#naf<-get_shapefile('nafo.clipped')
#naf<-project(naf,fa.poly)
#x<-crop(fa.poly,naf)
#x<-x[,13]
#y=naf[,1]
#test<-assign_polygons(x,y)
#test
#ggplot()+
#geom_spatvector(data=test[which(test$Label%in%c('4T','4S')),],aes(fill=Label))+#,col=NA
#geom_spatvector(data=naf,aes(col=Label),fill=NA)
```

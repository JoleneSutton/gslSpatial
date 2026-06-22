# Make a prediction grid

Make a spatial grid over a defined area. Returned coordinates are the
centroids of the grid cells. The size of square or rectangular grid
cells is defined by a user-specified resolution. The size of hexagonal
grid cells is defined by a user-specified area. Returns a SpatVector
with columns of coordinates to simplify conversion to a data frame. Note
that specifying small grid cells will take longer to generate than large
grid cells.

## Usage

``` r
make_grid(crs, shape = NULL, res = NULL, hex = FALSE, hex.area = NULL)
```

## Arguments

- crs:

  Coordinate reference system.

- shape:

  Optional polygon file (SpatVector) to define the area over which a
  grid should be made. If shape=NULL, defaults to NAFO divisions
  3Pn4RSTVn. Note that adjacent polygons will be aggregated and holes
  will be filled, so that grid cells are only cropped to outer
  boundaries.

- res:

  User defined grid resolution e.g., res=4 will produce 4x4 unit grids,
  whereas res=c(2,4) will produce 2x4 unit grids. Units will depend on
  the specified CRS. Required for non-hexagonal grid cells. If hex=TRUE,
  res is ignored.

- hex:

  Option to generate hexagonal grid cells. Default is FALSE.

- hex.area:

  Area of hexagonal grid cells. Only required if hex=TRUE.

## Value

Returns a SpatVector with columns of coordinates and cell area. Use
as.data.frame(SpatVector) to convert to a data frame.

## See also

get_shapefile()

## Examples

``` r
if (FALSE) { # \dontrun{
crs<-'epsg:4326'
res=c(0.5)
t1=make_grid(crs=crs,res=res)
t1

crs<-'epsg:32620' #units are meters
res=20*1000 #km
t2=make_grid(crs=crs,res=res)
t2

crs<-'epsg:32620' #units are meters
t3=make_grid(crs=crs,hex=TRUE,hex.area=400)
t3

crs<-'ESRI:102001'
t4=make_grid(crs=crs,hex=TRUE,hex.area=400)
t4

crs<-'ESRI:102001'
poly=get_shapefile('rv.sgsl')
t5=make_grid(crs=crs,shape=poly,hex=TRUE,hex.area=100)
t5

head(as.data.frame(t1))
head(as.data.frame(t2))
head(as.data.frame(t3))
head(as.data.frame(t4))
head(as.data.frame(t5))

ggplot2::ggplot()+tidyterra::geom_spatvector(data=t1,aes(fill=area_km))

ggplot2::ggplot()+tidyterra::geom_spatvector(data=t2,aes(fill=area_km))

ggplot2::ggplot()+tidyterra::geom_spatvector(data=t3,aes(fill=area_km))

ggplot2::ggplot()+tidyterra::geom_spatvector(data=t4,aes(fill=area_km))

ggplot2::ggplot()+tidyterra::geom_spatvector(data=t5,aes(fill=area_km))
} # }
```

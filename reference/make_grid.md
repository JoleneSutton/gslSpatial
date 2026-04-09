# Make a prediction grid for the Gulf Region

Returns a data frame with coordinates that are equidistant from one
another (raster grid cells), along with their associated NAFO divisions
for 3Pn4RSTVn. The coordinates are the centers of the grid cells.
Longitude and latitude coordinates are NAD83, EPSG:4269, in decimal
degrees. X and Y coordinates are NAD83, UTM zone 20N, in km.

## Usage

``` r
make_grid(res)
```

## Arguments

- res:

  User defined grid resolution e.g., specifying 4 will produce 4x4km
  grid sizes

## See also

get_shapefile()

## Examples

``` r
#pgrid<-make_grid(20)
#ggplot()+geom_raster(data=pgrid,aes(X,Y,fill=nafo.assigned))
```

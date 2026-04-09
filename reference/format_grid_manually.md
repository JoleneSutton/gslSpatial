# Manually format a prediction grid

Returns a data frame

## Usage

``` r
format_grid_manually(grid, rep.var = NULL, depth.var = NULL, median.var = NULL)
```

## Arguments

- grid:

  A prediction grid in which each row is unique

- rep.var:

  A variable by which to repeat the rows of the grid, e.g., year

- depth.var:

  If the grid needs a column for 'depth_scaled', depth.var is the depths
  used in the original scaling, e.g., from a data set fitted with a
  model

- median.var:

  If the grid needs a column with the most common level of a predictor,
  median.var comes from the original data that the model was fitted to

## See also

format_grid()

## Examples

``` r
tmp<-pgrid4[1:3,]
set.seed(678)
mv<-sample(c('a','b'),3,replace=TRUE)
names(sort(table(mv),decreasing=TRUE)[1])
#> [1] "b"
dv<-sample(100:500,50)
format_grid_manually(tmp,rep.var=c(2002,2003),median.var=mv,depth.var=dv)
#>               X        Y  area longitude latitude nafo.assigned     depth
#> 281    995.9978 5813.911  1.12 -55.72939 52.25112          <NA> -1.008069
#> 282    999.9978 5813.911  7.52 -55.67128 52.24751            4R -1.996786
#> 283   1003.9978 5813.911 10.72 -55.61317 52.24387            4R -3.000000
#> 281.1  995.9978 5813.911  1.12 -55.72939 52.25112          <NA> -1.008069
#> 282.1  999.9978 5813.911  7.52 -55.67128 52.24751            4R -1.996786
#> 283.1 1003.9978 5813.911 10.72 -55.61317 52.24387            4R -3.000000
#>       rep.var median.var depth_scaled
#> 281      2002          b    -2.705102
#> 282      2002          b    -2.713919
#> 283      2002          b    -2.722865
#> 281.1    2003          b    -2.705102
#> 282.1    2003          b    -2.713919
#> 283.1    2003          b    -2.722865
```

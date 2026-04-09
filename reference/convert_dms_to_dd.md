# Convert coordinates from degrees minutes seconds to decimal degrees

Convert coordinates from degrees minutes seconds to decimal degrees

## Usage

``` r
convert_dms_to_dd(x = NULL, deg = NULL, min = NULL, sec = NULL)
```

## Arguments

- x:

  Coordinate in format dms. May be numeric or character

- deg:

  Degrees. Default is NULL

- min:

  Minutes. Default is NULL

- sec:

  Seconds. Default is NULL

## Examples

``` r
convert_dms_to_dd(x="64° 10.8’")
#> [1] 64.18
convert_dms_to_dd(x="64° 10.8’ 00.00")
#> [1] 64.18
convert_dms_to_dd("64°10.8’")
#> [1] 64.18
convert_dms_to_dd(deg="64°", min="10.8’", sec="45.6")
#> [1] 64.19267
convert_dms_to_dd(deg="64°", min="10.8’")
#> [1] 64.18
convert_dms_to_dd(deg=64, min=10.8)
#> [1] 64.18
convert_dms_to_dd("641045.6")
#> [1] 64.17933
convert_dms_to_dd(641045.6)
#> [1] 64.17933
convert_dms_to_dd(deg="64°", min="10’", sec="45.6")
#> [1] 64.17933
```

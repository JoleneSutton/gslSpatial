# An example prediction grid for the Gulf of St. Lawrence

A grid covering 4Pn4RSTVn with 4x4km grid cells.

## Usage

``` r
pgrid4
```

## Format

A data frame with 18885 rows and 7 variables:

- X:

  Easting, UTM NAD83, Zone:20N, Units:km

- Y:

  Northing, UTM NAD83, Zone:20N, Units:km

- area:

  Area of each grid cell

- longitude:

  decimal degrees, NAD83, EPSG:4269

- latitude:

  decimal degrees, NAD83, EPSG:4269

- nafo.assigned:

  NAFO division or subdivision

- depth:

  Depth in meters, based on bathymetry reference GEBCO 2024

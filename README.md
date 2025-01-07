
<!-- README.md is generated from README.Rmd. Please edit that file -->

# gslSpatial <a href="https://jolenesutton.github.io/gslSpatial/"><img src="man/figures/logo.png" align="right" height="138" alt="gslSpatial website" /></a>

<!-- badges: start -->

[![R-CMD-check](https://github.com/JoleneSutton/gslSpatial/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/JoleneSutton/gslSpatial/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

**gslSpatial** provides tools to assist with spatial analysis in the
Gulf of St. Lawrence Region. Many of the functions rely on packages
[**terra**](https://rspatial.github.io/terra/) and
[**sf**](https://r-spatial.github.io/sf/).

Descriptions of available functions, data, and stored shapefiles are
[here](https://jolenesutton.github.io/gslSpatial/reference/index.html).
Vignettes can be found
[here](https://jolenesutton.github.io/gslSpatial/articles/).

## Installation

When you install **gslSpatial**, the
[**eclectic**](https://jolenesutton.github.io/eclectic/index.html)
package will also be installed.

To install **gslSpatial**, use:

``` r
# install.packages("devtools")
devtools::install_github("JoleneSutton/gslSpatial")
```

Due to the size of **gslSpatial 0.0.0.9002**, the installation might
fail due to timeout issues. In that case, try:

``` r
options(timeout=400)
devtools::install_github("JoleneSutton/gslSpatial")
```

If you have trouble installing with `devtools::install_github`, try:

``` r
# install.packages("remotes")
Sys.setenv("R_REMOTES_NO_ERRORS_FROM_WARNINGS" = "true")
remotes::install_github("JoleneSutton/gslSpatial")
```

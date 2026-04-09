# Clean ziff dates

Retains original data columns, and adds columns of updated dates.
Step 1) In cases where date.landed was "000000" or was missing, the
date.caught is inferred to be the true date landed Step 2) In remaining
cases, if date.landed came earlier than date.caught, the date.caught is
inferred to be the true date landed Step 3) In cases where date.caught
was "000000" or missing, the date.landed.updated is inferred to be the
true date caught

## Usage

``` r
clean_ziff_dates(x)
```

## Arguments

- x:

  A data frame with columns 'date.landed' and 'date.caught'

## Value

Data frame

## Examples

``` r
clean_ziff_dates(dat.ziff[1:5,])
#> 
#> 0 missing 'date.landed' were updated to match 'date.caught'
#> 
#> 0 'date.landed' that came before 'date.caught' were 
#> updated to match date.caught
#> 
#> 0 missing 'date.caught' were updated to match 'date.landed.updated'
#>                X        Y                           ancfvn date.landed
#> 6546100 693.6942 5235.246 de5f2296360a32a07b1868e68be0b8a8    20200427
#> 6547100 692.4206 5233.647 de5f2296360a32a07b1868e68be0b8a8    20200427
#> 6548100 692.4206 5233.647 de5f2296360a32a07b1868e68be0b8a8    20200427
#> 6549100 700.2428 5243.853 de5f2296360a32a07b1868e68be0b8a8    20200413
#> 6550100 700.2428 5243.853 de5f2296360a32a07b1868e68be0b8a8    20200413
#>         species.code round.weight main.species.caught main.species.sought
#> 6546100          130          141                 130                 130
#> 6547100          170            1                 130                 130
#> 6548100          130           70                 130                 130
#> 6549100          100           52                 100                 100
#> 6550100          130           43                 100                 100
#>         date.caught latitude longitude gear.class year year.landed month.landed
#> 6546100    20200427  47.2421  -60.4406        LLS 2020        2020            4
#> 6547100    20200427  47.2281  -60.4581        LLS 2020        2020            4
#> 6548100    20200427  47.2281  -60.4581        LLS 2020        2020            4
#> 6549100    20200413  47.3175  -60.3503        LLS 2020        2020            4
#> 6550100    20200413  47.3175  -60.3503        LLS 2020        2020            4
#>         day.landed date.landed.updated date.caught.updated year.caught.updated
#> 6546100         27            20200427            20200427                2020
#> 6547100         27            20200427            20200427                2020
#> 6548100         27            20200427            20200427                2020
#> 6549100         13            20200413            20200413                2020
#> 6550100         13            20200413            20200413                2020
#>         month.caught.updated day.caught.updated year.landed.updated
#> 6546100                   04                 27                2020
#> 6547100                   04                 27                2020
#> 6548100                   04                 27                2020
#> 6549100                   04                 13                2020
#> 6550100                   04                 13                2020
#>         month.landed.updated day.landed.updated
#> 6546100                   04                 27
#> 6547100                   04                 27
#> 6548100                   04                 27
#> 6549100                   04                 13
#> 6550100                   04                 13
```


<!-- README.md is generated from README.Rmd. Please edit that file -->

# readgrads

<!-- badges: start -->

<!-- badges: end -->

The goal of readgrads is to provide functions to read and manipulate
binay data files from the Grid Analysis and Display System
([GrADS](http://cola.gmu.edu/grads/)).

This repo is a fork of
<https://bitbucket.org/paulhiemstra/readgrads/src/default/> from Paul
Hiemstra.

The main changes made were to:

  - obtain data in a `data.frame` including dates. This improvement was
    made using the gridt.r script by Marcos Longo (@mpaiao)

  - allow importing binary files with specified extension (‘.gra’,
    ‘.bin’) (parameter `file.ext` in the `readGradsFile()` function)

  - specify the variables of interest in a new argument (varname in the
    `readGradsFile()` function)

## Installation

You can install the development version of readgrads from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("lhmet/readgrads")
```

## Example

This is a basic example which shows you how to use readgrads.

``` r
library(readgrads)
#> Loading required package: reshape
## basic example code
data_tmp <- tempfile(fileext = ".bin")
download.file(
  "http://ftp.cptec.inpe.br/modelos/io/produtos/MERGE/2019/prec_20191201.bin",
  data_tmp
)
ctl_tmp <- file.path(dirname(data_tmp), gsub(".bin", ".ctl", basename(data_tmp)))
download.file(
  "http://ftp.cptec.inpe.br/modelos/io/produtos/MERGE/2019/prec_20191201.ctl",
  ctl_tmp
)
x <- readGradsFile(
  data_tmp,
  file.ext = ".bin",
  convert2dataframe = TRUE,
  varname = "prec"
)
head(x)
#>         x     y    prec index tstep variable level                date
#> 1   -82.8 -50.2 14.6460     1     1     prec     1 2019-12-01 12:00:00
#> 1.1 -82.6 -50.2 14.2860     1     1     prec     1 2019-12-01 12:00:00
#> 1.2 -82.4 -50.2 14.1066     1     1     prec     1 2019-12-01 12:00:00
#> 1.3 -82.2 -50.2 14.1030     1     1     prec     1 2019-12-01 12:00:00
#> 1.4 -82.0 -50.2 14.5611     1     1     prec     1 2019-12-01 12:00:00
#> 1.5 -81.8 -50.2 15.4341     1     1     prec     1 2019-12-01 12:00:00
```

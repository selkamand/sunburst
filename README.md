
<!-- README.md is generated from README.Rmd. Please edit that file -->

# sunburst R package

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)

<!-- badges: end -->

The goal of microbialsunburst is to allow interactive sunburst plots to
be generated from microbial counts

## Installation

You can install the development version of sunburst like so:

``` r
# install.packages("remotes")
remotes::install_github("selkamand/sunburst")
```

## Usage

### Build Microbial Sunbursts

Want to visualise microbial composition? See [microbial sunbursts
vignette](./doc/microbial_sunbursts.html)

### General usage

#### Load library

``` r
library(sunburst)
```

#### Load data

Input data is a character vector of ‘lineages’. The segment size of
sunburst is related to the frequency of each lineage in the input
vector.

``` r
lineages <- c(
  "Cancer Cohort>HM>BALL",
  "Cancer Cohort>HM>BALL",
  "Cancer Cohort>HM>BALL",
  "Cancer Cohort>HM>TALL",
  "Cancer Cohort>HM>TALL",
  "Cancer Cohort>HM>AML",
  "Cancer Cohort>HM>AML>CBF",
  "Cancer Cohort>HM>AML>CBF",
  "Cancer Cohort>HM>AML>M7-AML",
  "Cancer Cohort>ST>NBL",
  "Cancer Cohort>ST>NBL",
  "Cancer Cohort>ST>NBL",
  "Cancer Cohort>ST>NBL",
  "Cancer Cohort>ST>NBL",
  "Cancer Cohort>ST>NBL",
  "Cancer Cohort>ST>NBL",
  "Cancer Cohort>ST>NBL",
  "Cancer Cohort>ST>WLM",
  "Cancer Cohort>ST>WLM",
  "Cancer Cohort>ST>WLM",
  "Cancer Cohort>ST>WLM",
  "Cancer Cohort>ST>OS",
  "Cancer Cohort>ST>OS",
  "Cancer Cohort>ST>EWS",
  "Cancer Cohort>ST>EWS",
  "Cancer Cohort>BT>MB",
  "Cancer Cohort>BT>MB",
  "Cancer Cohort>BT>MB",
  "Cancer Cohort>BT>MB",
  "Cancer Cohort>BT>MB>G4",
  "Cancer Cohort>BT>MB>G3",
  "Cancer Cohort>BT>MB>HGG"
)
```

#### Build sunburst plot

``` r
lineage2sunburst(lineages)
```

<img src="man/figures/README-unnamed-chunk-4-1.png" width="100%" />

### Sunburst from network style dataframe

#### Data Input

Instead of building your sunburst from lineage strings, you might want
something more congruent with you’re network-analysis compatible
dataframes.

You can build a sunburst from a dataframe you explicitly list every
label-parent pair and the value associate (dictates sunburst segment
size). For example the same sunburst as above can be produced using the
following table

``` r
data=data.frame(
  Label = c(
      "BT", "MB", "G3", "G4", "HGG", "HM", "AML",
      "CBF", "M7-AML", "BALL", "TALL", "ST", "EWS", 
      "NBL", "OS", "WLM"
    ),
  Parent = c(
    "Cancer Cohort", "BT", "MB", "MB", 
    "MB", "Cancer Cohort", "HM", "AML", 
    "AML", "HM", "HM", "Cancer Cohort", 
    "ST", "ST", "ST", "ST"
  ),
  Value = c(0, 4, 1, 1, 1, 0, 1, 2, 1, 3, 2, 0, 2, 8, 2, 4)
)
```

#### Build Sunburst

``` r
sunburst(data = data)
```

<img src="man/figures/README-unnamed-chunk-6-1.png" width="100%" />

## Acknowledgements

The engine driving the functionality of this package is `plotly`
packages. A big thanks to all involved in the creation and maintenance
of these packages.

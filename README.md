
-   [sunburst R package](#sunburst-r-package)
    -   [Installation](#installation)
    -   [Usage](#usage)
        -   [Build Microbial Sunbursts](#build-microbial-sunbursts)
        -   [General usage](#general-usage)
            -   [Load library](#load-library)
            -   [Load data](#load-data)
            -   [Build sunburst plot](#build-sunburst-plot)
        -   [Sunburst from network style
            dataframe](#sunburst-from-network-style-dataframe)
            -   [Data Input](#data-input)
            -   [Build Sunburst](#build-sunburst)
    -   [Acknowledgements](#acknowledgements)

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
#> PhantomJS not found. You can install it with webshot::install_phantomjs(). If it is installed, please make sure the phantomjs executable can be found via the PATH variable.
```

<div id="htmlwidget-69193987f324940ca4c8" style="width:100%;height:576px;" class="plotly html-widget"></div>
<script type="application/json" data-for="htmlwidget-69193987f324940ca4c8">{"x":{"visdat":{"203429b5dddc":["function () ","plotlyVisDat"]},"cur_data":"203429b5dddc","attrs":{"203429b5dddc":{"labels":["BT","MB","G3","G4","HGG","HM","AML","CBF","M7-AML","BALL","TALL","ST","EWS","NBL","OS","WLM"],"parents":["Cancer Cohort","BT","MB","MB","MB","Cancer Cohort","HM","AML","AML","HM","HM","Cancer Cohort","ST","ST","ST","ST"],"values":[0,4,1,1,1,0,1,2,1,3,2,0,2,8,2,4],"alpha_stroke":1,"sizes":[10,100],"spans":[1,20],"type":"sunburst"}},"layout":{"margin":{"b":40,"l":60,"t":25,"r":10},"hovermode":"closest","showlegend":false},"source":"A","config":{"modeBarButtonsToAdd":["hoverclosest","hovercompare"],"showSendToCloud":false},"data":[{"labels":["BT","MB","G3","G4","HGG","HM","AML","CBF","M7-AML","BALL","TALL","ST","EWS","NBL","OS","WLM"],"parents":["Cancer Cohort","BT","MB","MB","MB","Cancer Cohort","HM","AML","AML","HM","HM","Cancer Cohort","ST","ST","ST","ST"],"values":[0,4,1,1,1,0,1,2,1,3,2,0,2,8,2,4],"type":"sunburst","marker":{"color":"rgba(31,119,180,1)","line":{"color":"rgba(255,255,255,1)"}},"frame":null}],"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.2,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script>

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

<div id="htmlwidget-88eab691a15c6986e157" style="width:100%;height:576px;" class="plotly html-widget"></div>
<script type="application/json" data-for="htmlwidget-88eab691a15c6986e157">{"x":{"visdat":{"203444012037":["function () ","plotlyVisDat"]},"cur_data":"203444012037","attrs":{"203444012037":{"labels":["BT","MB","G3","G4","HGG","HM","AML","CBF","M7-AML","BALL","TALL","ST","EWS","NBL","OS","WLM"],"parents":["Cancer Cohort","BT","MB","MB","MB","Cancer Cohort","HM","AML","AML","HM","HM","Cancer Cohort","ST","ST","ST","ST"],"values":[0,4,1,1,1,0,1,2,1,3,2,0,2,8,2,4],"alpha_stroke":1,"sizes":[10,100],"spans":[1,20],"type":"sunburst"}},"layout":{"margin":{"b":40,"l":60,"t":25,"r":10},"hovermode":"closest","showlegend":false},"source":"A","config":{"modeBarButtonsToAdd":["hoverclosest","hovercompare"],"showSendToCloud":false},"data":[{"labels":["BT","MB","G3","G4","HGG","HM","AML","CBF","M7-AML","BALL","TALL","ST","EWS","NBL","OS","WLM"],"parents":["Cancer Cohort","BT","MB","MB","MB","Cancer Cohort","HM","AML","AML","HM","HM","Cancer Cohort","ST","ST","ST","ST"],"values":[0,4,1,1,1,0,1,2,1,3,2,0,2,8,2,4],"type":"sunburst","marker":{"color":"rgba(31,119,180,1)","line":{"color":"rgba(255,255,255,1)"}},"frame":null}],"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.2,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script>

## Acknowledgements

The engine driving the functionality of this package is `plotly`
packages. A big thanks to all involved in the creation and maintenance
of these packages.

Slides of my Data Beers BCN talk
================================

The slides RMarkdown source lives [here](slides.Rmd), with the html version right [here](slides.html), and if you want to see it without downloading it, head to [RPubs](http://rpubs.com/masalmon/databeersbcn).

# Code

Part of the visualization code is in the slides, but other parts of code are in separated R scripts in [the code folder](code/).

## Data preparation

* I got the PM2.5 data from Delhi and Beijing using [ropenaq](https://github.com/ropensci/ropenaq) for querying OpenAQ data and my own [repo/R package](https://github.com/masalmon/usaqmindia) with data [from the US embassy in Delhi](https://in.usembassy.gov/embassy-consulates/new-delhi/air-quality-data/). The code for getting the data is [in this script](code/get_data_delhi_beijing_pm25.R).

* I got the PM2.5 data for a station in Poble Nou, Barcelona, on [this website](http://dtes.gencat.cat/icqa/) and joined the 4 files [in this code](code/prepare_data_barcelona_pm25.R).

* I got the GDP per capita vs. PM2.5 data from [Christa Hasenkopf](https://github.com/RocketD0g) and put it in a long format in [this script](code/prepare_data_gdp_pm25.R).

* I got the PM2.5 data for the 4th of July using [ropenaq](https://github.com/ropensci/ropenaq) for querying OpenAQ data, see the code [here](code/get_data_us_fourth_of_july.R).

## Data visualization

See the slides themselves and the [data surfer code](code/make_data_surfer.R)

* For the slides I used RMarkdown, in particular the revealjs package. See [this webpage](http://rmarkdown.rstudio.com/revealjs_presentation_format.html)

* The location of the [data sources](http://www.who.int/phe/health_topics/outdoorair/databases/cities/en/) of the WHO 2016 report was prepared [in this repo](https://github.com/masalmon/who_aq_db)

* I use the R packages [ggplot2](https://github.com/tidyverse/ggplot2), [ggmap](https://github.com/dkahle/ggmap), [ggthemes](https://github.com/jrnold/ggthemes), [viridis](https://github.com/sjmgarnier/viridis).

* I made the data surfer using once again ropenaq for the data, and ggplot2, [emojifont](https://github.com/GuangchuangYu/emojifont) and [gganimate](https://github.com/dgrtwo/gganimate) for the plot. 

* For the fireworks viz I got the map from [this package](https://github.com/hrbrmstr/albersusa).

# Acknowledgements

I got data, pics and support from [Christa Hasenkopf](https://github.com/RocketD0g). Thanks, Christa!

# Further resources

The [OpenAQ website](https://openaq.org/) has links to their blog, community contributions, Github repos, etc., so check it out!


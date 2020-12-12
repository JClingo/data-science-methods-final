#' ---
#' title: "My amazing analysis"
#' author: "Daniel J. Hicks"
#' email: "dhicks4@ucmerced.edu"
#' 
#' output:
#'   rmarkdown::html_document:
#'     toc: true
#'     toc_float: TRUE
#'     number_sections: TRUE
#'     code_folding: "hide"
#' ---

#' This script analyzes the data. 

#+ setup
library(tidyverse)
library(knitr)
library(sessioninfo)

data_dir = file.path('..', 'data')
out_dir = file.path('..', 'out')

if (!dir.exists(out_dir)) {
    dir.create(out_dir)
}

dataf = read_rds(file.path(data_dir, '01_data.Rds'))

#' # Summary table #
#' `knitr::kable()` supports only very basic formatting.  For fancier options, check out these packages: 
#' 
#' - [`flextable`](https://davidgohel.github.io/flextable/)
#' - [`gt`](https://gt.rstudio.com/)
#' - [`huxtable`](https://hughjonesd.github.io/huxtable/)
#' - [`xtable`](https://cran.r-project.org/web/packages/xtable/index.html)

#+ summary_table
dataf %>% 
    summarize(across(everything(), mean)) %>% 
    kable(format = 'latex', digits = 2) %>% 
    write_lines(file.path(out_dir, '02_table.tex'))

#' # Amazing plot #
#' 

#+ plot
ggplot(dataf, aes(x, y)) +
    geom_point()

ggsave(file.path(out_dir, '02_plot.png'), width = 6, height = 3, scale = 1.5)

#' # Reproducibility #
session_info()
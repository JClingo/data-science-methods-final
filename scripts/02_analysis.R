#' ---
#' title: "EDA of 'An exploration of cross-cultural research on bias against atheists' "
#' author: "Joshua Clingo"
#' email: "jclingo@ucmerced.edu"
#' 
#' output:
#'   rmarkdown::html_document:
#'     toc: true
#'     toc_float: TRUE
#'     number_sections: TRUE
#'     code_folding: "hide"
#' ---

#' This script analyzes aggregate study data (cleaned in 01_data.R)

#+ setup
library(tidyverse)
library(knitr)
library(sessioninfo)
library(rethinking)

data_dir = file.path('..', 'data')
out_dir = file.path('..', 'out')

if (!dir.exists(out_dir)) {
    dir.create(out_dir)
}

dataf = read_rds(file.path(data_dir, '01_data.Rds'))


#' The intersection between the error rate and: 
#'   * Gender
#'   * Education
#'   * SES (Subjective Economic Status)
#'   
#'  Limit to a single country at a time
#'  

ggplot(dataf) + 
    geom_bar(aes(x = Country))

#' Finland has the most data by far so we'll use them

dataf_finland = dataf %>% 
    filter(Country == 'Finland')









#+ summary_table
# dataf %>% 
#     summarize(across(everything(), mean)) %>% 
#     kable(format = 'latex', digits = 2) %>% 
#     write_lines(file.path(out_dir, '02_table.tex'))

#' # Amazing plot #
#' 

#+ plot
# ggplot(dataf, aes(x, y)) +
#     geom_point()
# 
# ggsave(file.path(out_dir, '02_plot.png'), width = 6, height = 3, scale = 1.5)

#' # Reproducibility #
session_info()
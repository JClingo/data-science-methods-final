#' ---
#' title: Data processing of 'An exploration of cross-cultural research on bias against atheists' 
#' author: "Joshua Clingo"
#' email: "jclingo@ucmerced.edu"
#' 
#' output:
#'   rmarkdown::html_document:
#'     toc: false
#'     code_folding: "hide"
#' ---


## This script cleans the data and stores it for later analysis

#+ setup
library(tidyverse)

data_dir = file.path('..', 'data')

if (!dir.exists(data_dir)) {
    dir.create(data_dir)
}

## Load data ----

dataf_raw = read.csv(file.path(data_dir, 'aggregate-data.csv'))

## Strip out incomplete records

#' Note: Error rates tend to vary wildly across countries so any score comparison 
#'    should either be done for a single country or should normalize first

#' Note: Political data is quite incomplete (more than 1400 records are missing this)
#'    We will be excluding it from the analysis for this reason

#' Note: RelID sometimes came through a textual description but this was rare 
#'    enough that we'll just exclude those with the other malformed rows
#'    

dataf = dataf_raw %>% 
    subset(select = -c(PoliticsC, X)) %>% 
    filter(Error != 'NA', 
           BiG100 != 'NA', 
           GenFem != 'NA', 
           Age != 'NA', 
           Education != 'NA', 
           SES != 'NA', 
           as.integer(RelID) != 'NA')
dataf$RelID = as.integer(dataf$RelID)

#' Strip out non-standard religious affiliations

dataf = dataf %>% 
    filter(RelID < 11)

#' Get scaled values for quantities

dataf$BiG_z = scale(dataf$BiG100, scale=T, center=T)[,]  
dataf$Age_z = scale(dataf$Age, scale=T, center=T)[,]
dataf$Education_z = scale(dataf$Education, scale=T, center=T)[,]
dataf$SES_z = scale(dataf$SES, scale=T, center=T)[,]
dataf$GenFem_z = scale(dataf$GenFem, scale=T, center=T)[,]

#' Check that we've manually dealt with missing data
#' dataf <- dataf[complete.cases(dataf),]
#' ^ Running this yields the same number of rows -- looks like we're good
#' 
#' 

## All in all, we've lost a several hundred rows and the results from China (mainland), which used nonstandard religious IDs

summary(dataf)

## Write output ----
saveRDS(dataf, file.path(data_dir, '01_data.Rds'))

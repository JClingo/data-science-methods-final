## This script cleans the data and stores it for later analysis

data_dir = file.path('..', 'data')

if (!dir.exists(data_dir)) {
    dir.create(data_dir)
}

## Load data ----

dataf_raw = read.csv(file.path(data_dir, 'aggregate-data.csv'))

## Strip out incomplete records

#' Note: Political data is quite incomplete (more than 1400 records are missing this)
#'    We will be excluding it from the analysis for this reason

#' Note: RelID sometimes came through a textual description but this was rare 
#'    enough that we'll just exclude those with the other malformed rows

dataf = dataf_raw %>% 
    subset(select = -c(PoliticsC, X)) %>% 
    filter(Error != 'NA', BiG100 != 'NA', GenFem != 'NA', Age != 'NA', Education != 'NA', SES != 'NA', is.integer(RelID))

## All in all, we've lost a few hundred rows and the results from China (mainland), which used nonstandard religious IDs

## Write output ----
saveRDS(dataf, file.path(data_dir, '01_data.Rds'))

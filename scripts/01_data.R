## This script generates example data

N = 50
seed = 2020-12-02

mu = 0
sigma = 1

data_dir = file.path('..', 'data')

if (!dir.exists(data_dir)) {
    dir.create(data_dir)
}

## Generate data ----
set.seed(seed)
dataf = data.frame(x = 1:N, 
           y = rnorm(N, mu, sigma))

## Write output ----
saveRDS(dataf, file.path(data_dir, '01_data.Rds'))

#' ---
#' title: EDA of 'An exploration of cross-cultural research on bias against atheists'
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

summary(dataf)

ggplot(dataf) + 
    geom_bar(aes(x = Country))

#' Finland has the most data by far so we'll use them first

dataf_finland = dataf %>% 
    filter(Country == 'Finland')
dataf_usa = dataf %>% 
    filter(Country == 'USA')
dataf_india = dataf %>% 
    filter(Country == 'India')
dataf_australia = dataf %>% 
    filter(Country == 'Australia')
dataf_mauritius = dataf %>% 
    filter(Country == 'Mauritius')
dataf_netherlands= dataf %>% 
    filter(Country == 'Netherlands')
dataf_uae = dataf %>% 
    filter(Country == 'UAE')


summaryf = dataf_finland %>% 
    group_by(GenFem) %>% 
    summarize(
        ErrorRate = mean(Error),
        GenFem = GenFem) %>% 
    ungroup()
    
with(summaryf, cor(GenFem, ErrorRate))

summaryf = dataf_finland %>% 
    group_by(GenFem) %>% 
    summarize(
        ErrorRate = mean(Error),
        Gender = ifelse(GenFem == 1, 'Female', 'Male')) %>% 
    distinct() %>% 
    ungroup() %>% 
    select(-GenFem)
summaryf %>%
    kable(format = 'latex', digits = 4, col.names = c('Error Rate', 'Gender')) %>%
    write_lines(file.path(out_dir, '02_table_gender_finland.tex'))


#' Women significantly more likely to commit the error
#' We'll keep this in mind in case we want to shine a spotlight on it


summaryf = dataf_finland %>% 
    group_by(Education) %>% 
    summarize(
        ErrorRate = mean(Error),
        Education = Education) %>% 
    ungroup()
summaryf %>% 
    ggplot(aes(Education, ErrorRate)) + 
    geom_point(color="#F57F17") +
    geom_smooth(method='lm', color='black') + 
    labs (
        title = "Education versus error rate - Finland",
        subtitle = "(Mean per classification)"
    ) +
    theme(
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        panel.background = element_rect(fill="transparent")
    )

ggsave(file.path(out_dir, '02_plot_education_v_error_finland.png'))

#' Education level is also significant, though that isn't as surprising, given
#' the fact that the test is, at its heart, a basic logic test and education
#' conditions people for that task
#' 

summaryf = dataf_finland %>% 
    group_by(SES) %>% 
    summarize(
        ErrorRate = mean(Error),
        SES = SES) %>% 
    ungroup()

with(summaryf, cor(SES, ErrorRate))

summaryf %>% 
    ggplot(aes(SES, ErrorRate)) + 
    geom_point(color="#F57F17") +
    geom_smooth(method='lm', color='black') + 
    labs (
        title = "SES versus error rate - Finland",
        subtitle = "(Mean per classification)"
    ) +
    theme(
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        panel.background = element_rect(fill="transparent")
    )

ggsave(file.path(out_dir, '02_plot_ses_v_error_finland.png'))

#' Intriguingly, SES (social status) doesn't seem to follow our intuitions
#' Those who reported being relatively well-off scored worse, which goes against
#' the results we have from education -- so, is education simply not bound to SES
#' for some reason?

summaryf = dataf_finland %>% 
    group_by(SES) %>% 
    summarize(
        Education = mean(Education),
        SES = SES) %>% 
    ungroup()

summaryf %>% 
    ggplot(aes(SES, Education)) + 
    geom_point(color="#F57F17") +
    geom_smooth(method='lm', color='black') + 
    labs (
        title = "SES versus education level - Finland",
        subtitle = "(Mean per classification)"
    ) +
    theme(
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        panel.background = element_rect(fill="transparent")
    )

ggsave(file.path(out_dir, '02_plot_ses_v_education_finland.png'))

#' Nope! This looks completely typical. More education = more subjective social
#' status. So what's going on here?
#' 
#' Given the positive (though weak) correlation between education and scores 
#' and the negative (and decently strong) correlation between SES and scores,
#' the intuitive explanation is that people who overstate their SES are 
#' *significantly* more likely to make errors--so long as we're not just looking
#' at noise, this is a highly plausible explanation.
#' 
#' Let's check a few other countries to see if this replicates
#' 

summaryf = dataf_usa %>% 
    group_by(Education) %>% 
    summarize(
        ErrorRate = mean(Error),
        Education = Education) %>% 
    ungroup()
summaryf %>% 
    ggplot(aes(Education, ErrorRate)) + 
    geom_point(color="#F57F17") +
    geom_smooth(method='lm', color='black') + 
    labs (
        title = "Education level versus error rate - USA",
        subtitle = "(Mean per classification)"
    ) +
    theme(
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        panel.background = element_rect(fill="transparent")
    )

summaryf = dataf_india %>% 
    group_by(Education) %>% 
    summarize(
        ErrorRate = mean(Error),
        Education = Education) %>% 
    ungroup()
summaryf %>% 
    ggplot(aes(Education, ErrorRate)) + 
    geom_point(color="#F57F17") +
    geom_smooth(method='lm', color='black') + 
    labs (
        title = "Education level versus error rate - India",
        subtitle = "(Mean per classification)"
    ) +
    theme(
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        panel.background = element_rect(fill="transparent")
    )

#' `n` is much smaller but the trend is the same as we expected -- however, it's 
#' quite weak in India (and strong in the USA)
#' Let's look at SES

summaryf = dataf_usa %>% 
    group_by(SES) %>% 
    summarize(
        ErrorRate = mean(Error),
        SES = SES) %>% 
    ungroup()
summaryf %>% 
    ggplot(aes(SES, ErrorRate)) + 
    geom_point(color="#F57F17") +
    geom_smooth(method='lm', color='black') + 
    labs (
        title = "SES versus error rate - USA",
        subtitle = "(Mean per classification)"
    ) +
    theme(
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        panel.background = element_rect(fill="transparent")
    )

summaryf = dataf_india %>% 
    group_by(SES) %>% 
    summarize(
        ErrorRate = mean(Error),
        SES = SES) %>% 
    ungroup()
summaryf %>% 
    ggplot(aes(SES, ErrorRate)) + 
    geom_point(color="#F57F17") +
    geom_smooth(method='lm', color='black') + 
    labs (
        title = "SES versus error rate  - India",
        subtitle = "(Mean per classification)"
    ) +
    theme(
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        panel.background = element_rect(fill="transparent")
    )

#' Interesting--very interesting
#' Though our `n` is low, USA data kicks the trend. India confirms it.
#' So the overestimation effect could be a culturally sensitive feature.
#' Let's check a few more countries

summaryf = dataf_australia %>% 
    group_by(SES) %>% 
    summarize(
        ErrorRate = mean(Error),
        SES = SES) %>% 
    ungroup()
summaryf %>% 
    ggplot(aes(SES, ErrorRate)) + 
    geom_point(color="#F57F17") +
    geom_smooth(method='lm', color='black') + 
    labs (
        title = "SES versus error rate  - Australia",
        subtitle = "(Mean per classification)"
    ) +
    theme(
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        panel.background = element_rect(fill="transparent")
    )
#' Slightly positive

summaryf = dataf_netherlands %>% 
    group_by(SES) %>% 
    summarize(
        ErrorRate = mean(Error),
        SES = SES) %>% 
    ungroup()
summaryf %>% 
    ggplot(aes(SES, ErrorRate)) + 
    geom_point(color="#F57F17") +
    geom_smooth(method='lm', color='black') + 
    labs (
        title = "SES versus error rate  - Netherlands",
        subtitle = "(Mean per classification)"
    ) +
    theme(
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        panel.background = element_rect(fill="transparent")
    )
#' Positive

summaryf = dataf_mauritius %>% 
    group_by(SES) %>% 
    summarize(
        ErrorRate = mean(Error),
        SES = SES) %>% 
    ungroup()
summaryf %>% 
    ggplot(aes(SES, ErrorRate)) + 
    geom_point(color="#F57F17") +
    geom_smooth(method='lm', color='black') + 
    labs (
        title = "SES versus error rate - Mauritius",
        subtitle = "(Mean per classification)"
    ) +
    theme(
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        panel.background = element_rect(fill="transparent")
    )
#' Flat

summaryf = dataf_uae %>% 
    group_by(SES) %>% 
    summarize(
        ErrorRate = mean(Error),
        SES = SES) %>% 
    ungroup()
summaryf %>% 
    ggplot(aes(SES, ErrorRate)) + 
    geom_point(color="#F57F17") +
    geom_smooth(method='lm', color='black') + 
    labs (
        title = "SES versus error rate - UAE",
        subtitle = "(Mean per classification)"
    ) +
    theme(
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        panel.background = element_rect(fill="transparent")
    )
#' Negative

#' Returning to gender
#' We saw a modest effect on error rate for single country. We'll go ahead and 
#' sample a few more countries independently to see if that was just noise:
#' 

summaryf = dataf_usa %>% 
    group_by(GenFem) %>% 
    summarize(
        ErrorRate = mean(Error),
        Gender = ifelse(GenFem == 1, 'Female', 'Male')) %>% 
    distinct() %>% 
    ungroup() %>% 
    select(-GenFem)
summaryf %>%
    kable(digits = 4, col.names = c('Error Rate', 'Gender'))
# very modest (0.017) + difference

summaryf = dataf_india %>% 
    group_by(GenFem) %>% 
    summarize(
        ErrorRate = mean(Error),
        Gender = ifelse(GenFem == 1, 'Female', 'Male')) %>% 
    distinct() %>% 
    ungroup() %>% 
    select(-GenFem)
summaryf %>%
    kable(digits = 4, col.names = c('Error Rate', 'Gender'))
# flat

summaryf = dataf_australia %>% 
    group_by(GenFem) %>% 
    summarize(
        ErrorRate = mean(Error),
        Gender = ifelse(GenFem == 1, 'Female', 'Male')) %>% 
    distinct() %>% 
    ungroup() %>% 
    select(-GenFem)
summaryf %>%
    kable(digits = 4, col.names = c('Error Rate', 'Gender')) 
# very modest (0.025) + difference

summaryf = dataf_mauritius %>% 
    group_by(GenFem) %>% 
    summarize(
        ErrorRate = mean(Error),
        Gender = ifelse(GenFem == 1, 'Female', 'Male')) %>% 
    distinct() %>% 
    ungroup() %>% 
    select(-GenFem)
summaryf %>%
    kable(digits = 4, col.names = c('Error Rate', 'Gender'))
# moderate (0.13) - difference (!)

summaryf = dataf_netherlands %>% 
    group_by(GenFem) %>% 
    summarize(
        ErrorRate = mean(Error),
        Gender = ifelse(GenFem == 1, 'Female', 'Male')) %>% 
    distinct() %>% 
    ungroup() %>% 
    select(-GenFem)
summaryf %>%
    kable(digits = 4, col.names = c('Error Rate', 'Gender'))
# very modest (0.025) - difference

summaryf = dataf_uae %>% 
    group_by(GenFem) %>% 
    summarize(
        ErrorRate = mean(Error),
        Gender = ifelse(GenFem == 1, 'Female', 'Male')) %>% 
    distinct() %>% 
    ungroup() %>% 
    select(-GenFem)
summaryf %>%
    kable(digits = 4, col.names = c('Error Rate', 'Gender'))
# very modest (0.032) - difference

#' So, all in all--we have some very minor differences in different directions
#' Our sample sizes aren't all that large for every country except Finland (and)
#' India, so such minor differences ought not be read into. Overall, it looks
#' as though gender (M/F, at least) has no significant impact on resilience to
#' committing the conjunction fallacy for the atheist/believer vignette as
#' given. Just to underscore this (with a caveat that, again, we can't compare
#' country-level results to each other), we'll quickly repeat this step for
#' the aggregate dataset:
#' 

summaryf = dataf %>% 
    group_by(GenFem) %>% 
    summarize(
        ErrorRate = mean(Error),
        Gender = ifelse(GenFem == 1, 'Female', 'Male')) %>% 
    distinct() %>% 
    ungroup() %>% 
    select(-GenFem)
summaryf %>%
    kable(format = 'latex', digits = 4, col.names = c('Error Rate', 'Gender')) %>%
    write_lines(file.path(out_dir, '02_table_gender_overall.tex'))

#' Here we get what is essentially a flat line (-0.0075). Case closed on this
#' one.

#' Just out of curiosity and since we have this data here, let's take a peek at
#' the relationship between religious belief and age. We're more free to look
#' at the data all together because we're more interested in curiously observing
#' global trends than making any actual assertions:

dataf %>% 
    ggplot(aes(Age, BiG100)) +
    geom_point(color="#F57F17", alpha = 1/5) +
    geom_smooth(method='lm', color='black') + 
    labs (
        title = "BiG Score Frequencies - Overall",
        caption = "Darker circles indicate higher frequency"
    ) +
    theme(
        plot.title = element_text(hjust = 0.5),
        plot.caption = element_text(hjust = 0.5),
        panel.background = element_rect(fill="transparent")
    )
ggsave(file.path(out_dir, '02_plot_big100_v_age.png'))


#' Interesting! Looks like we're not globally going down in religiosity by age, 
#' at least in the countries polled and the people sampled. Curious.
#' 
#' What about education (let's exclude people until they're 30 since they're
#' unlikely to be finished before then)?
#' 
dataf_mature = dataf %>% 
    filter(Age > 29)
dataf_mature %>% 
    ggplot(aes(Age, Education)) +
    geom_point(color="#F57F17", alpha = 1/5) +
    geom_smooth(method='lm', color='black') + 
    labs (
        title = "Age versus education level - Overall",
        subtitle = "(>29 years)",
        caption = "Darker circles indicate higher frequency"
    ) +
    theme(
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        plot.caption = element_text(hjust = 0.5),
        panel.background = element_rect(fill="transparent")
    )
ggsave(file.path(out_dir, '02_plot_age_v_education.png'))

#' Flat! Looks like the average amount of education isn't changing much (at 
#' least among our samples)
#' 
#' Last bit of curiosity. What's the distribution of belief levels look like,
#' anyway?
#' 

dataf %>% 
    ggplot(aes(x=BiG100)) + 
    geom_histogram(binwidth = 5, fill = "#FBC02D") + 
    labs (
        title = "BiG score frequencies - Overall"
    ) +
    theme(
        plot.title = element_text(hjust = 0.5),
        panel.background = element_rect(fill="transparent")
    )

ggsave(file.path(out_dir, '02_plot_big100.png'))

#' Ah, now that's a non-representative global sample! I suspect Finland is to
#' blame.

dataf %>% 
    filter(Country != 'Finland') %>% 
    ggplot(aes(x=BiG100)) + 
    geom_histogram(binwidth = 5)

ggsave(file.path(out_dir, '02_plot_big100_sans_finland.png'))

#' Much better, though still a bit secular to be globally representative. At 
#' the very least, now it doesn't look like the researchers screened out 
#' everyone who wasn't fully committed to belief or disbelief.

#' # Reproducibility #
session_info()
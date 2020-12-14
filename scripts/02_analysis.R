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

summaryf %>% 
    ggplot(aes(GenFem, ErrorRate)) + 
    geom_point() 

#' Women significantly more likely to commit the error
#' We'll keep this in mind in case we want to shine a spotlight on it


summaryf = dataf_finland %>% 
    group_by(Education) %>% 
    summarize(
        ErrorRate = mean(Error),
        Education = Education) %>% 
    ungroup()

with(summaryf, cor(Education, ErrorRate))

summaryf %>% 
    ggplot(aes(Education, ErrorRate)) + 
    geom_point() +
    geom_smooth(method='lm')

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
    geom_point() +
    geom_smooth(method='lm')

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
    geom_point() +
    geom_smooth(method='lm')

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
    geom_point() +
    geom_smooth(method='lm')

summaryf = dataf_india %>% 
    group_by(Education) %>% 
    summarize(
        ErrorRate = mean(Error),
        Education = Education) %>% 
    ungroup()

summaryf %>% 
    ggplot(aes(Education, ErrorRate)) + 
    geom_point() +
    geom_smooth(method='lm')

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
    geom_point() +
    geom_smooth(method='lm')

summaryf = dataf_india %>% 
    group_by(SES) %>% 
    summarize(
        ErrorRate = mean(Error),
        SES = SES) %>% 
    ungroup()
summaryf %>% 
    ggplot(aes(SES, ErrorRate)) + 
    geom_point() +
    geom_smooth(method='lm')

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
    geom_point() +
    geom_smooth(method='lm')
#' Slightly positive

summaryf = dataf_netherlands %>% 
    group_by(SES) %>% 
    summarize(
        ErrorRate = mean(Error),
        SES = SES) %>% 
    ungroup()
summaryf %>% 
    ggplot(aes(SES, ErrorRate)) + 
    geom_point() +
    geom_smooth(method='lm')
#' Positive

summaryf = dataf_mauritius %>% 
    group_by(SES) %>% 
    summarize(
        ErrorRate = mean(Error),
        SES = SES) %>% 
    ungroup()
summaryf %>% 
    ggplot(aes(SES, ErrorRate)) + 
    geom_point() +
    geom_smooth(method='lm')
#' Flat

summaryf = dataf_uae %>% 
    group_by(SES) %>% 
    summarize(
        ErrorRate = mean(Error),
        SES = SES) %>% 
    ungroup()
summaryf %>% 
    ggplot(aes(SES, ErrorRate)) + 
    geom_point() +
    geom_smooth(method='lm')
#' Negative


#' Unfortunately, once the dust settles, it looks like we have a ton of inter-
#' country variance. In some countries (Finland, India, Netherlands, Australia),
#' we seem to have some number of over-confident individuals who think they are 
#' at a higher social class than they are (given education), who reliably mess 
#' up more than everyone else. In others (USA and UAE), the expected trend 
#' continues. Extremely tentative, speculative conclusion--there's a cultural 
#' difference for overrating one's abilities, given one's social standing (and 
#' ignoring) one's educational achievements, which becomes exposed when
#' confronted with the conjunction fallacy. So, while we can't say anything
#' about all humans, we can at least speculate that some cultural differences
#' seem to bring down our performance with conjunctive logic, particularly
#' when we are asked to rate our social standing, report our education level,
#' then perform a conjunctive logic task meant to trick us. In that sense,
#' it's a variation on the old over-confidence warnings of our teachers and
#' parents. 
#' 

#' Returning to gender
#' We saw a modest effect on error rate for single country. We'll go ahead and 
#' sample a few more countries independently to see if that was just noise:
#' 

summaryf = dataf_usa %>% 
    group_by(GenFem) %>% 
    summarize(
        ErrorRate = mean(Error),
        GenFem = GenFem) %>% 
    ungroup()
summaryf %>% 
    ggplot(aes(GenFem, ErrorRate)) + 
    geom_point() 
# very modest (0.017) + difference

summaryf = dataf_india %>% 
    group_by(GenFem) %>% 
    summarize(
        ErrorRate = mean(Error),
        GenFem = GenFem) %>% 
    ungroup()
summaryf %>% 
    ggplot(aes(GenFem, ErrorRate)) + 
    geom_point() 
# flat

summaryf = dataf_australia %>% 
    group_by(GenFem) %>% 
    summarize(
        ErrorRate = mean(Error),
        GenFem = GenFem) %>% 
    ungroup()
summaryf %>% 
    ggplot(aes(GenFem, ErrorRate)) + 
    geom_point() 
# very modest (0.025) + difference

summaryf = dataf_mauritius %>% 
    group_by(GenFem) %>% 
    summarize(
        ErrorRate = mean(Error),
        GenFem = GenFem) %>% 
    ungroup()
summaryf %>% 
    ggplot(aes(GenFem, ErrorRate)) + 
    geom_point() 
# moderate (0.13) - difference (!)

summaryf = dataf_netherlands %>% 
    group_by(GenFem) %>% 
    summarize(
        ErrorRate = mean(Error),
        GenFem = GenFem) %>% 
    ungroup()
summaryf %>% 
    ggplot(aes(GenFem, ErrorRate)) + 
    geom_point() 
# very modest (0.025) - difference

summaryf = dataf_uae %>% 
    group_by(GenFem) %>% 
    summarize(
        ErrorRate = mean(Error),
        GenFem = GenFem) %>% 
    ungroup()
summaryf %>% 
    ggplot(aes(GenFem, ErrorRate)) + 
    geom_point() 
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
        GenFem = GenFem) %>% 
    ungroup()
summaryf %>% 
    ggplot(aes(GenFem, ErrorRate)) + 
    geom_point() 

#' Here we get what is essentially a flat line (-0.0075). Case closed on this
#' one.

#' Just out of curiosity and since we have this data here, let's take a peek at
#' the relationship between religious belief and age. We're more free to look
#' at the data all together because we're more interested in curiously observing
#' global trends than making any actual assertions:

dataf %>% 
    ggplot(aes(Age, BiG100)) +
    geom_point() +
    geom_smooth(method='lm', se=FALSE, color='turquoise4')

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
    geom_point() +
    geom_smooth(method='lm', se=FALSE, color='turquoise4')

#' Flat! Looks like the average amount of education isn't changing much (at 
#' least among our samples)
#' 
#' Last bit of curiosity. What's the distribution of belief levels look like,
#' anyway?
#' 

dataf %>% 
    ggplot(aes(x=BiG100)) + 
    geom_histogram()

#' Ah, now that's a non-representative global sample! I suspect Finland is to
#' blame.

dataf %>% 
    filter(Country != 'Finland') %>% 
    ggplot(aes(x=BiG100)) + 
    geom_histogram()

#' Much better, though still a bit secular to be globally representative. At 
#' the very least, now it doesn't look like the researchers screened out 
#' everyone who wasn't fully committed to belief or disbelief.

#' 
#' In fact, this probably hints at the non-generalizability of the people who 
#' are responding to these studies. Education averages have steadily increased 
#' for a while now, so it's clear that isn't captured here at all. This ought 
#' not to be surprising to anyone who has ever run a study online (or on campus),
#' but any demographic conclusions we want to draw from these studies need to 
#' be carefully minded. Even my look into gender was ill-fated. What does this
#' mean for the actual study that was done on this data? Fortunately, they are
#' well aware of these issues and did some really clever statistical workarounds
#' to get something that might be generalizably true (moral bias against 
#' atheists). If found anything truly interesting in this EDA, I'd need to be
#' sure to employ the same kinds of workarounds before I ran around claiming
#' anything more than a few 'huh' moments.

#' Summary
#' 
#' We found a curious culturally sensitive discrepancy between education and 
#' SES, where even though education correlated with fewer errors and education
#' correlated with higher SES, there was an apparent blowback where people who
#' over-estimated their SES were especially likely to commit an error in 
#' judgment on the assessment. This was not true in every country, though it
#' was true in most. The places where it wasn't true were exactly aligned with
#' our priors.
#' 
#' We also noted a small quirk in error rates across genders, but further 
#' exploration showed this to be completely spurious. The overall results showed
#' a powerfully zero difference in error rates across two genders (the 'other'
#' gender results were not explored, as they were too few to reach significance.)
#' 
#' Further exploration ought to be done on the conjunction effect, though the 
#' aggregate dataset here doesn't seem to yield anything strong enough to
#' inspire its own new and detailed analysis. 
#' 
#' There were other datasets included in the supplementary content for the 
#' study. 
#' 
#' Most interesting of these (to the author) is a survey ran on this 
#' same model but with a different vignette and response. Instead of painting
#' a picture of a serial killer and asking whether this person was an atheist or
#' a believer, it paints a picture of a middle-aged man with a lot of free time
#' and access to young boys, who abuses this privilege to abuse those boys. 
#' It is then asked whether it's more likely that this man is a priest or whether
#' he's a priest who is an atheist/a believer in God. The point was to determine
#' whether the effect in the main study (atheists = immoral killers) was due to
#' the association with killing and psychopathy instead of more general moral 
#' violations. The expectation was that the common association between priests
#' and sexual crimes against children would override at least part of the 
#' association people have with religious people being morally upstanding.
#' Instead, they found that people were just as likely to think the priest was
#' just a closeted atheist if he indeed committed those heinous acts. In other 
#' words, a priest who commits extreme moral infractions is no true believer.
#' 
#' This study represents something really interesting to me, as it seems to 
#' suggest that the conjunction fallacy effect really does identify a strong
#' bias that's acted out in real behavior. It's one thing to show that people
#' (atheists included) think that atheists are over-represented among serial 
#' killers--maybe they just have bad priors. It's quite another to find that
#' something with reverse priors (priests are clearly expected to be highly
#' religious) has those priors completely overwritten by the stronger effect
#' of atheists being considered moral monsters of sorts, manifested by real
#' responses gathered without suspicion.

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
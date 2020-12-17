---
title: "An exploration of cross-cultural research on bias against atheists"
author: Joshua Clingo
date: Typeset \today
abstract: |
	Gervais et al. (2017) ran a study which wielded the Conjunction Fallacy to |
	fuss out an implicit bias both religious and non-religious individuals |
	hold against atheists--on moral grounds. This study included various |
	demographic measures (e.g., education, social status, etc.) but none were | 
	formally explored in their analysis. I'm explore a few of the |
	relationships and summarize the results.

colorlinks: true

bibliography: refs.json
---

---
output:
  html_document: default
  pdf_document: default
---
# An exploration of cross-cultural research on bias against atheists #

## Introduction ##

Researchers ran a wide (n=*3256*) study across *13* diverse countries in order to examine bias for and against atheists on moral grounds [@gervaisGlobalEvidenceExtreme2017]. The findings were, broadly, that in all but the most secular societies, believers and nonbelievers alike were more likely to commit the "conjunction fallacy" when performing a straightforward logic task that involved amoral nonbelievers (as opposed to moral believers and the other possible permutations). 

The original research paper is published here: 
[Global evidence of extreme intuitive moral
prejudice against atheists](http://dx.doi.org/10.1038/s41562-017-0151)

The data for this research is published here: 
[Cross Cultural Conjunction Atheists](https://osf.io/f0upy/)

As part of gathering the basic scores–whether or not the participant committed the conjunction fallacy–they also measured other values. Religiosity (0-100), religion, gender, race, country, age, perceived socio-economic status, and education level. Only religiosity, the version of the question they were given (atheist vs religious person–more on this later) country, and their pass/fail state were included in the analysis. Given the size, diversity, and quality of the data, it could be worthwhile to observe other patterns in the data. Does gender predict error rate? Race? Age? Education level? How about their combined intersections? 

My goal is to evaluate and visualize these relationships to see whether there's anything else worth knowing. In order to do so, I'll be checking the data for inconsistencies and discrepancies. Then I'll step through the interesting intersections as I see them and comment on the most promising (if any). Last I'll discuss what further improvements and alterations I'd like to see in further research in the research space. 

### Further experimental details

The conjunction fallacy became widely understood as such as a result of Amos Tversky and Daniel Kahneman's greater work on human biases. The most famous example is of Linda, a fictitious person whose description was given as follows: 

> Linda is 31 years old, single, outspoken, and very bright. She majored in philosophy. As a student, she was deeply concerned with issues of discrimination and social justice, and also participated in anti-nuclear demonstrations.

After being given this description, subjects were given the following response options:

> Which is more probable?
> 1. Linda is a bank teller.
> 2. Linda is a bank teller and is active in the feminist movement.

Surprisingly, though the answer is obviously *1*, a significant percentage of people answered *2*. The suspicion is that the indirect priming towards thinking about feminism (educated, single, justice/equality-activisty) overwrote subjects' ability to objectively reason. Since then, this study has undergone scrutiny and criticism (e.g., "Aren't people just inferring that the information about Linda was meant to be useful for determining the answer–otherwise, why include it?"). However, the results have actually stood up to this criticism even as later researchers have eliminated potential confounds. One of the innovations Gervais et al. had was to administer two separate tests, with opposed identities–religious versus atheist. The vignette was as follows: 

> When a man was young, he began inflicting harm on animals. It started with just pulling the wings off flies, but eventually progressed to torturing stray cats and other animals in his neighborhood. 
>
> As an adult, the man found that he did not get much thrill from harming animals, so he began hurting people instead. He has killed 5 homeless people that he abducted from poor neighborhoods in his home city. Their dismembered bodies are currently buried in his basement.

Then, there were two different response sets: 

> Which is more probable? 
> 1. The man is a teacher 
> 2. The man is a teacher and [does not believe in any gods. / is a religious believer.]

This way, when we analyze the results, instead of merely measuring error, we are measuring actual bias–or so the paper claims. The results were as described in the paper: subjects were significantly more likely to choose the conjunction (the wrong answer) when the man was associated with atheism as opposed to religion. This was mostly independent of the subject's own beliefs and mostly held true for all countries, with the exception of Finland (and to a lesser extent, New Zealand).

The experiment was executed over several months of data collection across countries. The thinking was that it would be less interesting and informative to find evidence of bias in a single, homogenous culture than in myriad, diverse ones. All of the data were included in a single place, with the combined, aggregate data providing the quantitative results used in the final tallying of the results. 

One last interesting point. Instead of measuring and comparing relative error rates, Gervais et al. instead compared Bayesian *predicted* error rates. That is, the probability of any person committing the conjunction fallacy in either case. They did this because the actual error rates vary across countries. Some countries are more likely than others to get tripped up. Since the only thing they wanted to demonstrate in this project was bias for or against atheists, they used these bayesian methods to normalize and compare bias across countries. 

## Data ##

For the sake of simplicity, I'll be using the [aggregate dataset](https://mfr.osf.io/render?url=https://osf.io/2nkeu/?direct%26mode=render%26action=download%26mode=render) from OSF called `Aggregate Data.csv`. 

This includes the following columns:

| Column Name | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|-------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Country     | Origin of data                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| Error       | 0: No error <br>1: Error (chose conjunction case)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| Target      | "Atheist"<br>"Religious"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| TargNum     | 1: "Atheist" <br>2: "Religious"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| BiG100      | 0-100: Certainty that God or gods exist, where 0 = zero belief and 100 = certain belief                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| GenFem      | 1: Identifies as Female \| 0: Male \| NA: Other                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| Age         | Integer: Self-reported age                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| Education   | Highest education level attained<br>1: < Some high school;<br>2: Some high school; <br>3: Completed high school or equivalent; <br>4: Some university/college;<br>5: Completed university/college;<br>6: Some postgraduate work;<br>7: Completed a postgraduate degree                                                                                                                                                                                                                                                                                                                              |
| SES         | 0-10 Perceived socio-economic status, where 0 is no status and 10 is top status                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| PoliticsC   | Political leanings<br>1: Very liberal <br>2: Liberal <br>3: Slightly liberal <br>4: Moderate <br>5: Slightly conservative <br>6: Conservative <br>7: Very conservative<br>(*Note: Netherlands also included 11s but there's no stated explanation for these in the public documentation*)                                                                                                                                                                                                                                                                                                             |
| RelID       | Religious affiliation<br>1: Christian <br>2: Christian (Baptist) <br>3: Christian (Other) <br>4: Hindu<br>5: Buddhist<br>6: Muslim <br>7: Jewish<br>8: Sikh <br>9: None <br>10: Atheist <br>11: Agnostic <br>Free response string: Other (Please specify)<br>(*Note: China and Hong Kong used slightly different religious ID options. Among other things, Atheist/agnostic was an option, rather than atheist or agnostic as separate choices. Singapore used a “freethinker” category instead of none, atheist, and agnostic. UAE used “Non-Religious Other philosophy not listed here” category.*) |


---

There are additional studies included in the full dataset but we'll focus on just the aggregate dataset for the primary study.

## Results ## 

The scriptual exploration of this dataset is found in *scripts/eda.r*.

What follows is a reenactment of that exploration


## EDA of 'An exploration of cross-cultural research on bias against atheists'

First, we loaded the cleaned dataset from `01_data.R`.

Next, we verify the integrity of the data.

Then, we begin to explore quantitative measures, particularly the intersections 
between the error rate and:
* Gender
* Education
* SES (Subjective Economic Status)

We limit our exploration to one level at a time, due to variations between 
countries (explored later).

Finland has the most data by far so we'll use them first:

\begin{table}
\centering
\input{../out/02_table_gender_finland.tex}
\caption{Mean error rate versus gender in Finland}
\end{table}

Women are significantly more likely to commit the error--at least in Finland. 
We'll keep this in mind in case we want to shine a spotlight on it later, but 
for now, we'll continue on.

![\label{fig:plot}](../out/02_plot_education_v_error_finland.png){ width=50% }

Education level is also significant, though that isn't as surprising, given the
fact that the test is, at its heart, a basic logic test--education conditions 
people for that task. Next is SES vs Error:

![\label{fig:plot}](../out/02_plot_ses_v_error_finland.png){ width=50% }

Intriguingly, SES (social status) doesn't seem to follow our intuitions. Those 
who reported being relatively well-off scored worse, which goes against the 
results we have from education -- so, is education simply not bound to SES for 
some reason?

![\label{fig:plot}](../out/02_plot_ses_v_education_finland.png){ width=50% }

Nope! This looks completely typical. More education = more subjective social 
status. So what's going on here?

Given the positive (though weak) correlation between education and scores 
and the negative (and decently strong) correlation between SES and scores,
the intuitive explanation is that people who overstate their SES are 
*significantly* more likely to make errors--so long as we're not just looking
at noise, this is a highly plausible explanation.

We checked a few other countries to see if this replicated. 

Summarizing the results, it looks like education level is inversely correlated 
with error rate--more education, fewer errors. This is expected.

We then looked at SES. Though our `n` is low for each, USA data kicks the trend.
India confirms it. So the overestimation effect could be a culturally sensitive feature.
We then checked a few more countries and found that most confirmed the effect--
more more error for more over-estimation of social status relative to education.

Unfortunately, once the dust settles, it looks like we have a ton of inter-
country variance. In some countries (Finland, India, Netherlands, Australia),
we seem to have some number of over-confident individuals who think they are 
at a higher social class than they are (given education), who reliably mess 
up more than everyone else. In others (USA and UAE), the expected trend 
continues. Extremely tentative, speculative conclusion--there's a cultural 
difference for overrating one's abilities, given one's social standing (and 
ignoring) one's educational achievements, which becomes exposed when
confronted with the conjunction fallacy. So, while we can't say anything
about all humans, we can at least speculate that some cultural differences
seem to bring down our performance with conjunctive logic, particularly
when we are asked to rate our social standing, report our education level,
then perform a conjunctive logic task meant to trick us. In that sense,
it's a variation on the old over-confidence warnings of our teachers and
parents. 
 
Returning to gender, we saw a modest effect on error rate for single country. 
We go ahead and sample a few more countries independently to see if that was 
just noise and find that--spoilers--it is. Correlations run every direction and 
are modest at best. Given sample sizes, there's just not a lot that can be said
here. This is a good thing for the study, however. It means that the conjunction
fallacy may indeed transcend at least some cultural differences.

So, all in all--we have some very minor differences in different directions.
Our sample sizes aren't all that large for every country except Finland (and)
India, so such minor differences ought not be read into. Overall, it looks
as though gender (M/F, at least) has no significant impact on resilience to
committing the conjunction fallacy for the atheist/believer vignette as
given. Just to underscore this (with a caveat that, again, we can't compare
country-level results to each other), we'll quickly repeat this step for
the aggregate dataset:

\begin{table}
\centering
\input{../out/02_table_gender_overall.tex}
\caption{Results}
\end{table}

Here we get what is essentially a flat line (-0.0075). Case closed on this one.

Just out of curiosity and since we have this data here, let's take a peek at
the relationship between religious belief and age. We're more free to look
at the data all together because we're more interested in curiously observing
global trends than making any actual assertions:

![\label{fig:plot}](../out/02_plot_big100.png){ width=50% }

Interesting! Looks like we're not globally going down in religiosity by age, 
at least in the countries polled and the people sampled. Curious.

What about education (let's exclude people until they're 30 since they're unlikely to be finished before then)?


![\label{fig:plot}](../out/02_plot_age_v_education.png){ width=50% }

Flat! Looks like the average amount of education isn't changing much (at least 
among our samples)

Last bit of curiosity. What's the distribution of belief levels look like, 
anyway?

![\label{fig:plot}](../out/02_plot_big100.png){ width=50% }

Ah, now that's a non-representative global sample! I suspect Finland is to 
blame.

![\label{fig:plot}](../out/02_plot_big100_sans_finland.png){ width=50% }

When we remove Finland, things start to align more with global average, though 
still a bit secular to be globally representative. At the very least, now it 
doesn't look like the researchers screened out everyone who wasn't fully 
committed to belief or disbelief.

In fact, this unsubtly hints at the non-generalizability of the people who 
are responding to these studies. Education averages have steadily increased 
for a while now, so it's clear that isn't captured here at all. This ought 
not to be surprising to anyone who has ever run a study online (or on campus),
but any demographic conclusions we want to draw from these studies need to 
be carefully minded. Even my look into gender was ill-fated. What does this
mean for the actual study that was done on this data? Fortunately, they are
well aware of these issues and did some really clever statistical workarounds
to get something that might be generalizably true (moral bias against 
atheists). If found anything truly interesting in this EDA, I'd need to be
sure to employ the same kinds of workarounds before I ran around claiming
anything more than a few 'huh' moments.

## Summary ##

We found a curious culturally sensitive discrepancy between education and 
SES, where even though education correlated with fewer errors and education
correlated with higher SES, there was an apparent blowback where people who
over-estimated their SES were especially likely to commit an error in 
judgment on the assessment. This was not true in every country, though it
was true in most. The places where it wasn't true were exactly aligned with
our priors.

We also noted a small quirk in error rates across genders, but further 
exploration showed this to be completely spurious. The overall results showed
a negligible difference in error rates across two genders (the 'other'
gender results were not explored, as they were too few to reach significance.)

Further exploration ought to be done on the conjunction effect, though the 
aggregate dataset here doesn't seem to yield anything strong enough to
inspire its own new and detailed analysis. 
 
There were other datasets included in the supplementary content for the study. 

Most interesting of these (to the author) is a survey ran on this same model 
but with a different vignette and response. Instead of painting
a picture of a serial killer and asking whether this person was an atheist or
a believer, it paints a picture of a middle-aged man with a lot of free time
and access to young boys, who abuses this privilege to abuse those boys. 
It is then asked whether it's more likely that this man is a priest or whether
he's a priest who is an atheist/a believer in God. The point was to determine
whether the effect in the main study (atheists = immoral killers) was due to
the association with killing and psychopathy instead of more general moral 
violations. The expectation was that the common association between priests
and sexual crimes against children would override at least part of the 
association people have with religious people being morally upstanding.
Instead, they found that people were just as likely to think the priest was
just a closeted atheist if he indeed committed those heinous acts. In other 
words, a priest who commits extreme moral infractions is no true believer.

This study represents something really interesting to me, as it seems to 
suggest that the conjunction fallacy effect really does identify a strong
bias that's acted out in real behavior. It's one thing to show that people
(atheists included) think that atheists are over-represented among serial 
killers--maybe they just have bad priors. It's quite another to find that
something with reverse priors (priests are clearly expected to be highly
religious) has those priors completely overwritten by the stronger effect
of atheists being considered moral monsters of sorts, manifested by real
responses gathered without suspicion.

# References #

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

Researchers ran a wide (n=*3256*) study across *13* diverse countries in order to examine bias for and against atheists on moral grounds. The findings were, broadly, that in all but the most secular societies, believers and nonbelievers alike were more likely to commit the "conjunction fallacy" when performing a straightforward logic task that involved amoral nonbelievers (as opposed to moral believers and the other possible permutations). 

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

The scriptual exploration of this dataset is found in *scripts/eda.r*

What were the findings? These are summarized in */paper/paper.pdf*, which was auto-generated from *paper.md*.







# Introduction #

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vitae enim vitae massa venenatis dapibus. Fusce eget eros id nibh placerat imperdiet et id dolor. Curabitur mollis libero sagittis odio malesuada venenatis. Fusce posuere arcu vitae erat aliquam pretium. Integer volutpat libero vel ipsum efficitur, et mollis nisi tincidunt. Pellentesque eu feugiat purus. Duis consequat nec elit a luctus. Nunc fermentum augue leo, ut gravida neque malesuada in [@HeadExtentConsequencesPHacking2015, 17]. 

See table \ref{tab:table} and figure \ref{fig:plot}.  Praesent suscipit semper risus, venenatis elementum dolor faucibus non. Integer a diam ullamcorper, dignissim erat id, venenatis ipsum. Sed rutrum, orci quis faucibus tincidunt, leo leo congue nunc, ac varius turpis enim vel nulla. Morbi commodo magna justo, eu euismod libero sollicitudin ac. Nulla quis mattis ante. Praesent finibus odio vel consequat pulvinar. Aenean vel ante leo. Donec massa massa, porttitor sit amet consequat in, commodo vel metus. Quisque sem purus, porta at magna eget, lobortis auctor turpis. Proin ut dolor sed lectus vulputate commodo [@MeehlTheoryTestingPsychologyPhysics1967; @SimonsohnPcurveKeyFiledrawer2014]. 

\begin{table}
\centering
\input{../out/02_table.tex}
\caption{Here is a table.  \texttt{pandoc} recognizes the \LaTeX code and passes it on verbatim.  However, it won't show up in HTML or Word output.  There are some other options for including tables, eg, \url{https://github.com/steindani/pandoc-include}.  But getting this to play nice with continuous integration is more than we have time for. \label{tab:table}}
\end{table}

![Amazing figure! \label{fig:plot}](../out/02_plot.png)

Aenean sed facilisis mauris. Pellentesque tempor eu dui mollis auctor. Etiam tincidunt ipsum vel consequat euismod. Vivamus ac magna egestas, tincidunt sem non, suscipit sapien. Fusce tempor tristique iaculis. Aliquam ut nisi vitae risus tristique vestibulum malesuada nec magna. Nulla suscipit vel nisi nec condimentum. Nam malesuada a tortor vel pulvinar. 

# References #

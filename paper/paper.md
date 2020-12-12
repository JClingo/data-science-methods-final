---
title: "My awesome paper"
author: Daniel J. Hicks
date: Typeset \today
abstract: |
	This is a paper about things.  

colorlinks: true

bibliography: refs.json
---

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

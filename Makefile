## Paths
DATA := data
SCRIPTS := scripts
OUT := out
PAPER := paper
LASTOUT := $(OUT)/02_plot.png  # Last output from the last file of the analysis pipeline

## Primary targets: all; (analysis) pipe and paper
.PHONY: all pipe paper paper_html
all: pipe paper paper_html


## Analysis pipe ----
pipe: $(LASTOUT)

$(OUT)/02_plot.png: $(SCRIPTS)/02_analysis.R \
                    $(DATA)/01_data.Rds
	cd $(SCRIPTS); Rscript -e "rmarkdown::render('02_analysis.R')"

# Exercise for the reader
$(DATA)/01_data.Rds: $(SCRIPTS)/01_data.R
	cd $(SCRIPTS); Rscript 01_data.R



## Paper ----
paper: $(PAPER)/paper.pdf
$(PAPER)/paper.pdf: $(PAPER)/paper.md \
                    $(PAPER)/refs.json \
                    $(LASTOUT)
	cd $(PAPER); pandoc paper.md -o paper.pdf --citeproc
	
## Paper HTML ----
paper_html: $(PAPER)/paper.html
$(PAPER)/paper.html: $(PAPER)/paper.md \
                    $(PAPER)/refs.json \
                    $(LASTOUT)
	cd $(PAPER); pandoc paper.md -o paper.html --citeproc


## Cleaning ----
.PHONY: clean
madedata := $(filter-out $(wildcard $(DATA)/00_*), $(wildcard $(DATA)/*))
made := $(wildcard $(OUT)/*) \
        $(SCRIPTS)/02_analysis.html \
        $(madedata) \
        $(PAPER)/paper.pdf \
        $(PAPER)/paper.html \ 
clean:
	rm $(made)
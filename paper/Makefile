all: pdf

pdf: paper.pdf
paper.pdf: paper.md
	pandoc header.yaml paper.md \
                     -o paper.pdf \
                     --filter=pandoc-citeproc \ 
                     --filter=pandoc-crossref \
                     --pdf-engine=lualatex

docx: paper.docx
paper.docx: paper.md
	pandoc header.yaml paper.md \
                    -o paper.docx \
                    --filter=pandoc-citeproc \
                    --filter=pandoc-crossref
                    
html: paper.html
paper.html: paper.md
	pandoc header.yaml paper.md \
                    -o paper.html \
                    --filter=pandoc-citeproc \
                    --filter=pandoc-crossref


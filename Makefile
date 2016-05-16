MEXT = md

SRC = $(wildcard *.$(MEXT))

BIB = sample.bib

CSL = ./support/apsa.csl


PDFS=$(SRC:.md=.pdf)
TEX=$(SRC:.md=.tex)

all:	$(PDFS) $(HTML) $(TEX) $(DOCX)

pdf:	clean $(PDFS)
tex:	clean $(TEX)

%.tex:	%.md
	pandoc -r markdown+simple_tables+table_captions+yaml_metadata_block -w latex -s -S --latex-engine=xelatex --template=./support/template.tex --filter pandoc-crossref --filter pandoc-citeproc --filter pandoc-citeproc-preamble -M citeproc-preamble=./support/preamble.tex --csl=$(CSL) --bibliography=$(BIB) -o $@ $<

%.pdf:	%.md
	pandoc -r markdown+simple_tables+table_captions+yaml_metadata_block -s -S --latex-engine=xelatex --template=./support/template.tex --filter pandoc-crossref --filter pandoc-citeproc --filter pandoc-citeproc-preamble -M citeproc-preamble=./support/preamble.tex --csl=$(CSL) --bibliography=$(BIB) -o $@ $<

clean:
	rm -f *.pdf *.tex *.aux *.log

.PHONY: clean

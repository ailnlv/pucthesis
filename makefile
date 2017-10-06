MAINFILE = main.tex
# descomentar para ocultar errores
PDFLATEX_OPS = #-interaction batchmode -file-line-error


pdf: *.tex
	xelatex $(PDFLATEX_OPS) $(MAINFILE)

all: biblio pdf

biblio: biblio.bib
	xelatex $(PDFLATEX_OPS) $(MAINFILE)
	bibtex main
	xelatex $(PDFLATEX_OPS) $(MAINFILE)

clean:
	-rm *.aux *.bbl *.blg *.dvi *.lof *.log *.lot *.out *.toc *.bak *.snm *.nav *.vrb *.fls *.fdb_latex_mk

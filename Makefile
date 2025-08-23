comp:
	latexmk -cd -shell-escape -pdf report.tex
	cp report.pdf report-backup.pdf

glossary:
	makeglossaries report

clean:
	latexmk -c
	rm -f *.bbl *.blg *.glg *.glo *.gls *.ist *.acn *.acr *.alg *.aux *.lof *.lot *.out *.toc

new: clean comp
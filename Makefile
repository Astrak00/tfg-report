comp:
	latexmk -cd -shell-escape -pdf report.tex

glossary:
	makeglossaries report

clean:
	latexmk -c
	rm -f *.bbl *.blg *.glg *.glo *.gls *.ist *.acn *.acr *.alg *.aux *.lof *.lot *.out *.toc

.PHONY: all
all: profitulo.ps profitulo-a4.ps profitulo.pdf profitulo-libreto.pdf


profitulo.tex: index.html Makefile	 ../latehxigu.xslt eo.sed  titolpag.tex
	xsltproc ../latehxigu.xslt index.html  | sed -f eo.sed | konwert utf8-tex > profitulo.tex

profitulo-a4.tex: index.html Makefile	 ../latehxigu.xslt eo.sed titolpag.tex
	xsltproc --stringparam geometry a4paper ../latehxigu.xslt index.html  | sed -f eo.sed | konwert utf8-tex > profitulo-a4.tex

profitulo.dvi: profitulo.tex
	latex profitulo.tex

profitulo-a4.dvi: profitulo-a4.tex
	latex profitulo-a4.tex

profitulo-a5.ps: profitulo.dvi
	dvips profitulo.dvi -f > profitulo-a5.ps

profitulo-a5-signature.ps: profitulo-a5.ps
	psbook -s32 profitulo-a5.ps profitulo-a5-signature.ps

profitulo-libreto.ps:  profitulo-a5-signature.ps
	psnup -d -l -pa4 -Pa5 -2  profitulo-a5-signature.ps profitulo-libreto.ps

profitulo-a5.pdf: profitulo-a5.ps
	ps2pdf profitulo-a5.ps

profitulo-libreto.pdf: profitulo-libreto.ps
	ps2pdf profitulo-libreto.ps


profitulo-a4.ps: profitulo-a4.dvi
	dvips profitulo-a4.dvi -f > profitulo-a4.ps

profitulo.ps.gz: profitulo.ps
	gzip -f profitulo.ps

profitulo.pdf: profitulo.tex
	pdflatex profitulo.tex

.PHONY: clean
clean:
	rm -f profitulo.pdf *.log *.aux *.dvi profitulo-a4*  *.ps profitulo.tex
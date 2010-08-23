
.PHONY: all
all: profitulo.ps profitulo-a4.ps profitulo.pdf


profitulo.tex: index.html Makefile	 ../latehxigu.xslt eo.sed
	xsltproc ../latehxigu.xslt index.html  | sed -f eo.sed | konwert utf8-tex > profitulo.tex 

profitulo-a4.tex: index.html Makefile	 ../latehxigu.xslt eo.sed
	xsltproc --stringparam geometry a4paper ../latehxigu.xslt index.html  | sed -f eo.sed | konwert utf8-tex > profitulo-a4.tex 

profitulo.dvi: profitulo.tex
	latex profitulo.tex

profitulo-a4.dvi: profitulo-a4.tex
	latex profitulo-a4.tex

profitulo.ps: profitulo.dvi
# por a5 libreto, (ne eblas per mia printilo)
#a5booklet profitulo.dvi
#dvips -ta4 -tlandscape profitulo-1 -f -O-2cm,0cm > profitulo-1.ps 
#dvips -ta4 -tlandscape profitulo-2 -f > profitulo-2.ps 
#dvips -ta4 -tlandscape profitulo-1 -f > profitulo-1.ps 
#dvips -ta4 -tlandscape profitulo-2 -f > profitulo-2.ps 
#simple a4:
#dvips profitulo.dvi -f -O-0.6cm,-1cm > profitulo.ps
	dvips profitulo.dvi -f > profitulo_.ps	
#pstops  "4:-3L(21cm,0)+0L(21cm,14.85cm),4:1L(21cm,0)+-2L(21cm,14.85cm)"  profitulo.ps profitulo2.ps
	pstops "4:-3L@1(29.2cm,0)+0L@1(29.2cm,14.85cm),1R@1(-8cm,29.7cm)+-2R@1(-8cm,14.85cm)" profitulo_.ps profitulo.ps

profitulo-a4.ps: profitulo-a4.dvi
	dvips profitulo-a4.dvi -f > profitulo-a4.ps

profitulo.ps.gz: profitulo.ps
	gzip -f profitulo.ps

profitulo.pdf: profitulo.tex
	pdflatex profitulo.tex

.PHONY: clean
clean:
	rm -f profitulo.pdf *.log *.aux *.dvi profitulo-a4*  *.ps profitulo.tex 
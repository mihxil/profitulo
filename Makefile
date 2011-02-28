
SHELL=/bin/bash

.PHONY: all revisio
all: profitulo-a4.pdf profitulo-a5.pdf profitulo-libreto.pdf

revisio:
	@svn up >/dev/null
	date  --rfc-3339=date | tr -d "\n" > revisio.tex
	svn info |  grep Revision | awk '{print " r" $$2}' >> revisio.tex

profitulo-a5.tex: index.html Makefile	 ../latehxigu.xslt eo.sed  titolpag.tex revisio
	xsltproc ../latehxigu.xslt index.html  | sed -f eo.sed | konwert utf8-tex > profitulo-a5.tex

profitulo-a4.tex: index.html Makefile	 ../latehxigu.xslt eo.sed titolpag.tex revisio
	xsltproc --stringparam geometry a4paper ../latehxigu.xslt index.html  | sed -f eo.sed | konwert utf8-tex > profitulo-a4.tex

%.dvi: %.tex
	latex $<

%.ps: %.dvi
	dvips $< -f > $@

%-signature.ps: %-a5.ps
	psbook -s32 $< $@

profitulo-libreto.ps:  profitulo-a5-signature.ps
	psnup -d -l -pa4 -Pa5 -2  $< $@


#%.pdf: %.ps
#	ps2pdf %.ps

%.pdf: %.tex
	pdflatex $<


%.ps.gz: %.ps
	gzip -f %<


.PHONY: clean
clean:
	rm -f *.pdf *.log *.aux *.dvi profitulo-a4*  *.ps profitulo-a5.tex profitulo-a4.tex
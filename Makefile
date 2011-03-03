
SHELL=/bin/bash
DEPS=index.html Makefile	 ../latehxigu.xslt eo.sed  titolpag.tex revisio.tex

.PHONY: all revisio
all: profitulo-a4.pdf profitulo-a5.pdf profitulo-libreto.pdf

revisio.tex: .svn
	-@svn up >/dev/null
	date  --rfc-3339=date | tr -d "\n" > revisio.tex
	svn info |  grep Revision | awk '{print " r" $$2}' >> revisio.tex

profitulo-a5.tex: $(DEPS)
	xsltproc -novalid --stringparam centering yes ../latehxigu.xslt index.html  \
	| sed -f eo.sed -f ../utf8-tex.sed \
	> profitulo-a5.tex

profitulo-a4.tex: $(DEPS)
	xsltproc -novalid --stringparam centerying yes --stringparam geometry a4paper ../latehxigu.xslt index.html \
	| sed -f eo.sed -f  ../utf8-tex.sed \
	> profitulo-a4.tex

%.dvi: %.tex
	latex $<

%.signature.ps: %-a5.ps
	psbook -s32 $< $@

%.ps: %.dvi
	dvips $< -f > $@


profitulo-libreto.ps:  profitulo.signature.ps
	psnup -d -l -pa4 -Pa5 -2  $< $@


%.pdf: %.ps
	ps2pdf $<

%.pdf: %.tex
	pdflatex $<


%.ps.gz: %.ps
	gzip -f $<


.PHONY: clean
clean:
	rm -f *.pdf *.log *.aux *.dvi profitulo-a4*  *.ps profitulo-a5*
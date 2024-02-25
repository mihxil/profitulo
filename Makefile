
DEPS=zeeland.eps im/sarphatistraat.jpg im/nijmegen.jpg im/kamer.jpg
TARGETS=profitulo-a4.pdf profitulo-a5.pdf profitulo-libreto.pdf profitulo.epub
PAGES=32
CENTERING=yes

include html2latex/libro.mk


im/sarphatistraat.jpg:
	mkdir -p im
	curl https://upload.wikimedia.org/wikipedia/commons/f/fd/Sarphatistraat_Amsterdam_ca_1903.jpg -o $@

im/nijmegen.jpg:
	mkdir -p im
	curl https://upload.wikimedia.org/wikipedia/commons/5/50/Spoorbrug_Nijmegen_1878.jpg -o $@


im/kamer.jpg: kamer.XCF
	mkdir -p img
	convert -layers merge $< $@

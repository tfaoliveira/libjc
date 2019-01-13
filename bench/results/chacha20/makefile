.PHONY: csv svg pdf

# sync with the most recent version of data/chacha20-********
csv:
	cp `find ../../data/ -type d -name "chacha20*" | sort -r | head -n1`/*.csv ./csv/

svg:
	(cd gnu && gnuplot *.gnu)

pdf:
	mkdir -p pdf
	(cd svg && find . -name "*.svg" -exec inkscape {} --export-pdf=../pdf/{}.pdf \;)

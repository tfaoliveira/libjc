.PHONY: csv svg pdf

# sync with the most recent version of data/poly1305-********
csv:
	cp `find ../../data/ -type d -name "keccak*" | sort -r | head -n1`/*.csv ./csv/

svg:
	(cd gnu && gnuplot *.gnu)

pdf:
	(cd svg && find . -name "*.svg" -exec inkscape {} --export-pdf=../pdf/{}.pdf \;)

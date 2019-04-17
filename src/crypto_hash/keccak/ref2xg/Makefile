# -*- Makefile -*-

.PHONY: default clean

default: keccak.japp
	@true

clean:
	rm -f keccak.japp

%.japp: %.jazz
	gpp -o $@ $<

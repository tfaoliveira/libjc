# -*- Makefile -*-

.PHONY: default

ROOT=../../../..
IDIR=$(ROOT)/src/crypto_core/keccakf160064bits/ref
IFIL=$(IDIR)/keccak_f1600_export.japp

default: keccak_f1600_ref.ec
	@true

clean:
	rm -f keccak_f1600_ref.ec

%.ec:
	make -C $(IDIR) clean
	make -C $(IDIR)
	jasminc -ec __keccak_f1600_ref -oec $@ $(IFIL)


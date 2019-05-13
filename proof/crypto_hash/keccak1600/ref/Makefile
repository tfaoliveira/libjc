# -*- Makefile -*-

.PHONY: default

ROOT=../../../..
IDIR=$(ROOT)/src/crypto_hash/keccak1600/ref
IFIL=$(IDIR)/keccak_1600.japp

default: keccak_1600_ref.ec
	@true

clean:
	rm -f keccak_1600_ref.ec

%.ec:
	make -C $(IDIR) clean
	make -C $(IDIR)
	jasminc -ec __keccak_1600 -oec $@ $(IFIL)


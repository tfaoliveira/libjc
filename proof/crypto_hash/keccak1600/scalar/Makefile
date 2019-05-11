# -*- Makefile -*-

.PHONY: default

ROOT=../../../..
IDIR=$(ROOT)/src/crypto_hash/keccak1600/scalar
IFIL=$(IDIR)/keccak_1600.japp

default: keccak_1600_scalar.ec
	@true

clean:
	rm -f keccak_1600_scalar.ec

%.ec:
	make -C $(IDIR) clean
	make -C $(IDIR)
	jasminc -ec __keccak_1600 -oec $@ $(IFIL)


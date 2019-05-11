# -*- Makefile -*-

.PHONY: default

ROOT=../../../..
IDIR=$(ROOT)/src/crypto_hash/keccak1600/avx2
IFIL=$(IDIR)/keccak_1600.japp

default: keccak_1600_avx2.ec
	@true

clean:
	rm -f keccak_1600_avx2.ec

%.ec:
	make -C $(IDIR) clean
	make -C $(IDIR)
	jasminc -ec __keccak_1600 -oec $@ $(IFIL)


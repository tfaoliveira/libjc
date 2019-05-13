# -*- Makefile -*-

.PHONY: default

ROOT=../../../..
IDIR=$(ROOT)/src/crypto_core/keccakf160064bits/avx2-openssl
IFIL=$(IDIR)/keccak_f1600_export.japp

default: keccak_f1600_avx2_openssl.ec
	@true

clean:
	rm -f keccak_f1600_avx2_openssl.ec

%.ec:
	make -C $(IDIR) clean
	make -C $(IDIR)
	jasminc -ec __keccak_f1600_avx2_openssl -oec $@ $(IFIL)


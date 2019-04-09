# -*- Makefile -*-

# --------------------------------------------------------------------
SUBDIRS := \
crypto_hash/shake256/ref2x/ \
crypto_onetimeauth/poly1305/ref3/ \
crypto_onetimeauth/poly1305/avx/ \
crypto_onetimeauth/poly1305/avx2/


# --------------------------------------------------------------------
.PHONY: default clean

default:
	@for i in $(SUBDIRS); do $(MAKE) -C $$i; done

clean:
	@for i in $(SUBDIRS); do $(MAKE) -C $$i clean; done

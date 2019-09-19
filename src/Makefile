# -*- Makefile -*-

# --------------------------------------------------------------------
SUBDIRS := \
crypto_hash/sha3224/scalar/ \
crypto_hash/sha3224/avx2/ \
\
crypto_hash/sha3256/scalar/ \
crypto_hash/sha3256/avx2/ \
\
crypto_hash/sha3384/scalar/ \
crypto_hash/sha3384/avx2/ \
\
crypto_hash/sha3512/scalar/ \
crypto_hash/sha3512/avx2/ \
\
crypto_hash/shake128/scalar/ \
crypto_hash/shake128/avx2/ \
\
crypto_hash/shake256/scalar/ \
crypto_hash/shake256/avx2/ \
\
crypto_onetimeauth/poly1305/ref3/ \
crypto_onetimeauth/poly1305/avx/ \
crypto_onetimeauth/poly1305/avx2/ \
\
crypto_stream/chacha20/ref/ \
crypto_stream/chacha20/avx/ \
crypto_stream/chacha20/avx2/

# --------------------------------------------------------------------
.PHONY: default clean

default:
	@for i in $(SUBDIRS); do $(MAKE) -C $$i; done

clean:
	@for i in $(SUBDIRS); do $(MAKE) -C $$i clean; done

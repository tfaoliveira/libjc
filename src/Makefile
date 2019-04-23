# -*- Makefile -*-

# --------------------------------------------------------------------
SUBDIRS := \
crypto_hash/keccak/ref2xg/ \
crypto_hash/keccak/avx2/ \
crypto_hash/shake256/ref2x/ \
crypto_hash/shake256/avx2/ \
crypto_hash/shake128/ref2x/ \
crypto_hash/shake128/avx2/ \
crypto_hash/sha3512/ref2x/ \
crypto_hash/sha3512/avx2/ \
crypto_hash/sha3384/ref2x/ \
crypto_hash/sha3384/avx2/ \
crypto_hash/sha3256/ref2x/ \
crypto_hash/sha3256/avx2/ \
crypto_hash/sha3224/ref2x/ \
crypto_hash/sha3224/avx2/


# --------------------------------------------------------------------
.PHONY: default clean

default:
	@for i in $(SUBDIRS); do $(MAKE) -C $$i; done

clean:
	@for i in $(SUBDIRS); do $(MAKE) -C $$i clean; done

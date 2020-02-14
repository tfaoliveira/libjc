# -*- Makefile -*-

# --------------------------------------------------------------------
SUBDIRS := \
  crypto_core/keccakf160064bits/ref \
  crypto_core/keccakf160064bits/scalar \
  crypto_core/keccakf160064bits/avx2 \
  crypto_core/keccakf160064bits/avx2_openssl \
  \
  crypto_hash/keccak1600/ref \
  crypto_hash/keccak1600/scalar \
  crypto_hash/keccak1600/avx2 \
  \
  crypto_hash/sha3224/scalar \
  crypto_hash/sha3224/avx2 \
  \
  crypto_hash/sha3256/scalar \
  crypto_hash/sha3256/avx2 \
  \
  crypto_hash/sha3384/scalar \
  crypto_hash/sha3384/avx2 \
  \
  crypto_hash/sha3512/scalar \
  crypto_hash/sha3512/avx2 \
  \
  crypto_hash/shake128/scalar \
  crypto_hash/shake128/avx2 \
  \
  crypto_hash/shake256/ref \
  crypto_hash/shake256/scalar \
  crypto_hash/shake256/avx2 \
  \
  crypto_onetimeauth/poly1305/ref3 \
  crypto_onetimeauth/poly1305/avx \
  crypto_onetimeauth/poly1305/avx2 \
  \
  crypto_stream/chacha20/ref \
  crypto_stream/chacha20/avx \
  crypto_stream/chacha20/avx2 \
  \
  crypto_scalarmult/curve25519/ref4 \
  crypto_scalarmult/curve25519/mulx

# --------------------------------------------------------------------
SRC    := $(shell find crypto_* -name '*.c')
ASM    := $(shell find crypto_* -name '*.s')
OBJ    := $(SRC:%.c=_build/%.o) $(ASM:%.s=_build/%.o)
AS     := as
CC     := gcc
CFLAGS := -Wall -Ofast

# --------------------------------------------------------------------
.PHONY: default clean __real_libjc __force

default: libjc.a

jasmin:
	for i in $(SUBDIRS); do $(MAKE) -C $$i; done

libjc.a: jasmin __force
	$(MAKE) __real_libjc

__real_libjc: $(OBJ)
	ar -rc libjc.a $(OBJ) && ranlib libjc.a

_build/%.c: %.c
	@mkdir -p _build/`dirname $<`; cp $< _build/`dirname $<`
	@echo '$< --> _build/'

_build/%.s: %.s
	@mkdir -p _build/`dirname $<`; cp $< _build/`dirname $<`
	@echo '$< --> _build/'

clean:
	for i in $(SUBDIRS); do $(MAKE) -C $$i clean; done
	rm -fr _build libjc.a

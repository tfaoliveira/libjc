# -*- Makefile -*-

# --------------------------------------------------------------------
ECROOT   ?=
ECCHECK  ?=
ECARGS   ?=
ECCONF   := tests.config 
XUNITOUT ?= xunit.xml
CHECKS   ?= poly1305

#CHECKS   ?= chacha20 poly1305
#CHECKS   ?= chacha20 poly1305 crypto_core crypto_hash

ifeq ($(ECCHECK),)
ifeq ($(ECROOT),)
ECCHECK := ec-runtest
else
PATH    := ${ECROOT}:${PATH}
ECCHECK := $(ECROOT)/scripts/testing/runtest
endif
endif

# --------------------------------------------------------------------

TOP := $(dir $(abspath $(lastword $(MAKEFILE_LIST))/..))

ECSRC := \
\
 crypto_stream/chacha20/ChaCha20_sref.ec \
 crypto_stream/chacha20/ChaCha20_savx.ec \
 crypto_stream/chacha20/ChaCha20_savx2.ec \
 crypto_stream/chacha20/ChaCha20_sref_CT.ec \
 crypto_stream/chacha20/ChaCha20_savx_CT.ec \
 crypto_stream/chacha20/ChaCha20_savx2_CT.ec \
\
 crypto_onetimeauth/poly1305/Poly1305_savx2.ec \
 crypto_onetimeauth/poly1305/Poly1305_savx2_CT.ec 

#	crypto_hash/keccak1600/avx2/keccak_1600_avx2.ec \
#	crypto_hash/keccak1600/ref/keccak_1600_ref.ec \
#	crypto_hash/keccak1600/scalar/keccak_1600_scalar.ec \
#	crypto_hash/keccak1600/avx2/keccak_1600_avx2_CT.ec \
#	crypto_hash/keccak1600/ref/keccak_1600_ref_CT.ec \
#	crypto_hash/keccak1600/scalar/keccak_1600_scalar_CT.ec \
#	crypto_core/keccakf160064bits/avx2/keccak_f1600_avx2.ec \
#	crypto_core/keccakf160064bits/ref/keccak_f1600_ref.ec \
#	crypto_core/keccakf160064bits/avx2_openssl/keccak_f1600_avx2_openssl.ec \
#	crypto_core/keccakf160064bits/scalar/keccak_f1600_scalar.ec



# --------------------------------------------------------------------
.PHONY: default usage check check-xunit generate clean

default: check

usage:
	@echo "Usage: make <target> where <target> in [check|check-xunit]" >&2

check: generate
	$(ECCHECK) --bin-args="$(ECARGS)" $(ECCONF) $(CHECKS)

check-xunit: generate
	$(ECCHECK) --bin-args="$(ECARGS)" --report=$(XUNITOUT) $(ECCONF) $(CHECKS)

generate: $(ECSRC)
	@true

# $(sort also removes duplicates
clean:
	rm -f $(ECSRC)
	for i in $(sort$(dir $(ECSRC))); do \
		rm -f $$i/WArray*.ec; rm -f $$i/Array*.ec; \
	done

# ChaCha20
crypto_stream/chacha20/ChaCha20_s%.ec: $(TOP)/src/crypto_stream/chacha20/%/chacha20.jazz
	cd $$(dirname $@) && jasminc -ec chacha20_$* -oec $$(basename $@) $<

crypto_stream/chacha20/ChaCha20_s%_CT.ec: $(TOP)/src/crypto_stream/chacha20/%/chacha20.jazz
	cd $$(dirname $@) && jasminc -ec chacha20_$* -oec $$(basename $@) -CT $<

# Poly1305 (needs make -C ../src/ bc of poly1305.japp)
crypto_onetimeauth/poly1305/Poly1305_s%.ec: $(TOP)/src/crypto_onetimeauth/poly1305/%/poly1305.japp
	cd $$(dirname $@) && jasminc -ec poly1305_$* -oec $$(basename $@) $<

crypto_onetimeauth/poly1305/Poly1305_s%_CT.ec: $(TOP)/src/crypto_onetimeauth/poly1305/%/poly1305.japp
	cd $$(dirname $@) && jasminc -ec poly1305_$* -oec $$(basename $@) -CT $<

# Keccak


#crypto_hash/keccak1600/avx2/keccak_1600_avx2.ec: $(TOP)/src/crypto_hash/keccak1600/avx2/keccak_1600.japp
#	cd $$(dirname $@) && jasminc -ec __keccak_1600 -oec $$(basename $@) $<

#crypto_hash/keccak1600/ref/keccak_1600_ref.ec: $(TOP)/src/crypto_hash/keccak1600/ref/keccak_1600.japp
#	cd $$(dirname $@) && jasminc -ec __keccak_1600 -oec $$(basename $@) $<

#crypto_hash/keccak1600/scalar/keccak_1600_scalar.ec: $(TOP)/src/crypto_hash/keccak1600/scalar/keccak_1600.japp
#	cd $$(dirname $@) && jasminc -ec __keccak_1600 -oec $$(basename $@) $<

#crypto_hash/keccak1600/avx2/keccak_1600_avx2_CT.ec: $(TOP)/src/crypto_hash/keccak1600/avx2/keccak_1600.japp
#	cd $$(dirname $@) && jasminc -ec __keccak_1600 -oec $$(basename $@) -CT $<

#crypto_hash/keccak1600/ref/keccak_1600_ref_CT.ec: $(TOP)/src/crypto_hash/keccak1600/ref/keccak_1600.japp
#	cd $$(dirname $@) && jasminc -ec __keccak_1600 -oec $$(basename $@) -CT $<

#crypto_hash/keccak1600/scalar/keccak_1600_scalar_CT.ec: $(TOP)/src/crypto_hash/keccak1600/scalar/keccak_1600.japp
#	cd $$(dirname $@) && jasminc -ec __keccak_1600 -oec $$(basename $@) -CT $<

#crypto_core/keccakf160064bits/avx2/keccak_f1600_avx2.ec: $(TOP)/src/crypto_core/keccakf160064bits/avx2/keccak_f1600_export.japp
#	cd $$(dirname $@) && jasminc -ec __keccak_f1600_avx2 -oec $$(basename $@) $<

#crypto_core/keccakf160064bits/ref/keccak_f1600_ref.ec: $(TOP)/src/crypto_core/keccakf160064bits/ref/keccak_f1600_export.japp
#	cd $$(dirname $@) && jasminc -ec __keccak_f1600_ref -oec $$(basename $@) $<

#crypto_core/keccakf160064bits/avx2_openssl/keccak_f1600_avx2_openssl.ec: $(TOP)/src/crypto_core/keccakf160064bits/avx2_openssl/keccak_f1600_export.japp
#	cd $$(dirname $@) && jasminc -ec __keccak_f1600_avx2_openssl -oec $$(basename $@) $<

#crypto_core/keccakf160064bits/scalar/keccak_f1600_scalar.ec: $(TOP)/src/crypto_core/keccakf160064bits/scalar/keccak_f1600_export.japp
#	cd $$(dirname $@) && jasminc -ec __keccak_f1600_scalar -oec $$(basename $@) $<


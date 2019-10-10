# -*- Makefile -*-

# --------------------------------------------------------------------
ECROOT   ?=
ECCHECK  ?=
ECARGS   ?=
ECCONF   := tests.config 
XUNITOUT ?= xunit.xml
CHECKS   ?= keccak1600

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
 crypto_onetimeauth/poly1305/Poly1305_savx2_CT.ec \
\
 crypto_core/keccakf160064bits/Keccakf1600_sref.ec \
 crypto_core/keccakf160064bits/Keccakf1600_sscalar.ec \
 crypto_core/keccakf160064bits/Keccakf1600_savx2.ec \
 crypto_core/keccakf160064bits/Keccakf1600_savx2_openssl.ec \
 crypto_core/keccakf160064bits/Keccakf1600_sref_CT.ec \
 crypto_core/keccakf160064bits/Keccakf1600_sscalar_CT.ec \
 crypto_core/keccakf160064bits/Keccakf1600_savx2_CT.ec \
 crypto_core/keccakf160064bits/Keccakf1600_savx2_openssl_CT.ec \
\
 crypto_hash/keccak1600/Keccak1600_sref.ec \
 crypto_hash/keccak1600/Keccak1600_sscalar.ec \
 crypto_hash/keccak1600/Keccak1600_savx2.ec \
 crypto_hash/keccak1600/Keccak1600_sref_CT.ec \
 crypto_hash/keccak1600/Keccak1600_sscalar_CT.ec \
 crypto_hash/keccak1600/Keccak1600_savx2_CT.ec

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
	for i in $(sort $(dir $(ECSRC))); do \
		rm -f $$i/WArray*.ec; rm -f $$i/Array*.ec; \
	done

# ChaCha20
crypto_stream/chacha20/ChaCha20_s%.ec: $(TOP)/src/crypto_stream/chacha20/%/chacha20.jazz
	cd $$(dirname $@) && jasminc -ec chacha20_$* -oec $$(basename $@) $<

crypto_stream/chacha20/ChaCha20_s%_CT.ec: $(TOP)/src/crypto_stream/chacha20/%/chacha20.jazz
	cd $$(dirname $@) && jasminc -ec chacha20_$* -oec $$(basename $@) -CT $<

# Poly1305
crypto_onetimeauth/poly1305/Poly1305_s%.ec: $(TOP)/src/crypto_onetimeauth/poly1305/%/poly1305.japp
	cd $$(dirname $@) && jasminc -ec poly1305_$* -oec $$(basename $@) $<

crypto_onetimeauth/poly1305/Poly1305_s%_CT.ec: $(TOP)/src/crypto_onetimeauth/poly1305/%/poly1305.japp
	cd $$(dirname $@) && jasminc -ec poly1305_$* -oec $$(basename $@) -CT $<

# Keccakf1600
crypto_core/keccakf160064bits/Keccakf1600_s%.ec: $(TOP)/src/crypto_core/keccakf160064bits/%/keccakf1600_export.japp
	cd $$(dirname $@) && jasminc -ec __keccakf1600_$* -oec $$(basename $@) $<

crypto_core/keccakf160064bits/Keccakf1600_s%_CT.ec: $(TOP)/src/crypto_core/keccakf160064bits/%/keccakf1600_export.japp
	cd $$(dirname $@) && jasminc -ec __keccakf1600_$* -oec $$(basename $@) -CT $<

# Keccak1600
crypto_hash/keccak1600/Keccak1600_s%.ec: $(TOP)/src/crypto_hash/keccak1600/%/keccak1600.japp
	cd $$(dirname $@) && jasminc -ec __keccak1600_$* -oec $$(basename $@) $<

crypto_hash/keccak1600/Keccak1600_s%_CT.ec: $(TOP)/src/crypto_hash/keccak1600/%/keccak1600.japp
	cd $$(dirname $@) && jasminc -ec __keccak1600_$* -oec $$(basename $@) -CT $<


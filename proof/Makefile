# -*- Makefile -*-

# --------------------------------------------------------------------
ECROOT   ?=
ECCHECK  ?=
ECARGS   ?=
ECCONF   := tests.config 
XUNITOUT ?= xunit.xml
CHECKS   ?= chacha20 poly1305

ifeq ($(ECCHECK),)
ifeq ($(ECROOT),)
ECCHECK := ec-runtest
else
PATH    := ${ECROOT}:${PATH}
ECCHECK := $(ECROOT)/scripts/testing/runtest
endif
endif

# --------------------------------------------------------------------
TOP := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))/..))

ECSRC := \
	crypto_stream/chacha20/ChaCha20_sref.ec \
	crypto_stream/chacha20/ChaCha20_savx.ec \
	crypto_stream/chacha20/ChaCha20_savx2.ec \
	crypto_stream/chacha20/ChaCha20_sref_CT.ec \
	crypto_stream/chacha20/ChaCha20_savx_CT.ec \
	crypto_stream/chacha20/ChaCha20_savx2_CT.ec \
	crypto_onetimeauth/poly1305/Poly1305_sref3.ec \
	crypto_onetimeauth/poly1305/Poly1305_savx.ec \
	crypto_onetimeauth/poly1305/Poly1305_savx2.ec \
	crypto_onetimeauth/poly1305/Poly1305_savx2_CT.ec

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

clean:
	rm -f $(ECSRC)
	for i in crypto_stream/chacha20 crypto_onetimeauth/poly1305; do \
	  rm -f $$I/WArray*.ec; rm -f $$i/Array*.ec; \
	done

crypto_stream/chacha20/ChaCha20_s%.ec: $(TOP)/src/crypto_stream/chacha20/%/chacha20.jazz
	cd $$(dirname $@) && jasminc -ec chacha20_$* -oec $$(basename $@) $<

crypto_stream/chacha20/ChaCha20_s%_CT.ec: $(TOP)/src/crypto_stream/chacha20/%/chacha20.jazz
	cd $$(dirname $@) && jasminc -ec chacha20_$* -oec $$(basename $@) -CT $<

crypto_onetimeauth/poly1305/Poly1305_s%.ec: $(TOP)/src/crypto_onetimeauth/poly1305/%/poly1305.japp
	cd $$(dirname $@) && jasminc -ec poly1305_$* -oec $$(basename $@) $<

crypto_onetimeauth/poly1305/Poly1305_s%_CT.ec: $(TOP)/src/crypto_onetimeauth/poly1305/%/poly1305.japp
	cd $$(dirname $@) && jasminc -ec poly1305_$* -oec $$(basename $@) -CT $<

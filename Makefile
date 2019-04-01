# -*- Makefile -*-

# --------------------------------------------------------------------
.PHONY: generate check clean

# --------------------------------------------------------------------
generate:
	$(MAKE) -C src/crypto_onetimeauth/poly1305
	$(MAKE) -C proof generate

# --------------------------------------------------------------------
check:
	$(MAKE) -C proof check

# --------------------------------------------------------------------
clean:
	$(MAKE) -C src/crypto_onetimeauth/poly1305 clean
	$(MAKE) -C proof clean

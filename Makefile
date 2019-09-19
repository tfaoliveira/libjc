# -*- Makefile -*-

# --------------------------------------------------------------------
.PHONY: generate check clean dist

NAME := libjc

# --------------------------------------------------------------------
generate:
	$(MAKE) -C src
	$(MAKE) -C proof generate

# --------------------------------------------------------------------
check:
	$(MAKE) -C proof check

# --------------------------------------------------------------------
clean:
	$(MAKE) -C src/crypto_onetimeauth/poly1305 clean
	$(MAKE) -C proof clean

# --------------------------------------------------------------------
dist: generate
	rm -rf $(NAME) $(NAME).tar.gz
	./scripts/distribution $(NAME) MANIFEST
	tar -czf $(NAME).tar.gz --owner=0 --group=0 $(NAME) && rm -rf $(NAME)

# --------------------------------------------------------------------
distcheck: dist
	tar -xof $(NAME).tar.gz
	set -x; \
	     $(MAKE) -C $(NAME) generate \
	  && $(MAKE) -C $(NAME) check \
	  && $(MAKE) -C $(NAME) dist \
	  && mkdir $(NAME)/dist1 $(NAME)/dist2 \
	  && ( cd $(NAME)/dist1 && tar -xof ../$(NAME).tar.gz ) \
	  && ( cd $(NAME)/dist2 && tar -xof ../../$(NAME).tar.gz ) \
	  && diff -rq $(NAME)/dist1 $(NAME)/dist2 \
	  || exit 1
	rm -rf $(NAME)
	@echo "$(NAME) is ready for distribution" | \
	  $(SED) -e 1h -e 1s/./=/g -e 1p -e 1x -e '$$p' -e '$$x'

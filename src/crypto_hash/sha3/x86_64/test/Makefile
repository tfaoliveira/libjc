# Makefile
# 19-Nov-11 Markku-Juhani O. Saarinen <mjos@iki.fi>

BINARY          = keccaktest
OBJS     	= sha3.o main.o
DIST            = tiny_sha3

CC              = gcc
CFLAGS		= -Wall -O3
LIBS            = keccakFtest_jazz.s shake256_jazz.s openssl_x86_64.s
LDFLAGS         =
INCLUDES	=

$(BINARY):      $(OBJS) $(LIBS)
		$(CC) $(LDFLAGS) -o $(BINARY) $(OBJS) $(LIBS)

.c.o:
		$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

clean:
		rm -rf $(DIST)-*.txz $(OBJS) $(BINARY) *~ 

dist:		clean
		cd ..; \
		tar cfvJ $(DIST)/$(DIST)-`date -u "+%Y%m%d%H%M00"`.txz \
			$(DIST)/*

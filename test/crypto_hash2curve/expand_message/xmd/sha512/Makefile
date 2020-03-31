TESTS=test0_ref0c
SRC=../../../../../src/
INC=../../../../

default: $(TESTS)
	@true

run: $(TESTS)
	@for t in $(TESTS); do echo $$t && ./$$t; done

$(SRC)/crypto_hash2curve/expand_message/xmd/sha512/%/xmd_export.s:
	make -C $(SRC)/crypto_hash2curve/expand_message/xmd/sha512/$* clean
	make -C $(SRC)/crypto_hash2curve/expand_message/xmd/sha512/$*

test0_%: test0.c $(SRC)/crypto_hash2curve/expand_message/xmd/sha512/%/xmd_export.s
	gcc -Wall -o $@ $^ \
   -I$(INC) \
   -Dsha512_ctx_size=sha512_ctx_size_$* \
   -Dexpand_message_xmd_sha512=expand_message_xmd_sha512_$*

clean:
	rm -f test0_*

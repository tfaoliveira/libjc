TESTS=test0_ref0c
SRC=../../../../../src/
INC=../../../../

default: $(TESTS)
	@true

run: $(TESTS)
	@for t in $(TESTS); do echo $$t && ./$$t; done

$(SRC)/crypto_hash2curve/expand_message/xmd/sha256/%/xmd_export.s:
	make -C $(SRC)/crypto_hash2curve/expand_message/xmd/sha256/$* clean
	make -C $(SRC)/crypto_hash2curve/expand_message/xmd/sha256/$*

test0_%: test0.c $(SRC)/crypto_hash2curve/expand_message/xmd/sha256/%/xmd_export.s
	gcc -Wall -o $@ $^ \
   -I$(INC) \
   -Dsha256_ctx_size=sha256_ctx_size_$* \
   -Dexpand_message_xmd_sha256=expand_message_xmd_sha256_$*

clean:
	rm -f test0_*

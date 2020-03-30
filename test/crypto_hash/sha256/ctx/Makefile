TESTS=test0_ref0c
SRC=../../../../src
INC=../../../

default: $(TESTS)
	@true

run: $(TESTS)
	@for t in $(TESTS); do echo $$t && ./$$t; done

$(SRC)/crypto_hash/sha256/%/sha256_export.s:
	make -C $(SRC)/crypto_hash/sha256/$* clean
	make -C $(SRC)/crypto_hash/sha256/$*

test0_%: test0.c $(SRC)/crypto_hash/sha256/%/sha256_export.s
	gcc -Wall -o $@ $^ \
   -I$(INC) \
   -Dsha256=sha256_$* \
   -Dsha256_ctx_size=sha256_ctx_size_$* \
   -Dsha256_init=sha256_init_$* \
   -Dsha256_update=sha256_update_$* \
   -Dsha256_finish=sha256_finish_$*

clean:
	rm -f test0_*

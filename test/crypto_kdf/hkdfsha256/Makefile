TESTS=test0_ref0 test0_ref test0_inplace
SRC=../../../src
INC=../../

default: $(TESTS)
	@true

run: $(TESTS)
	@for t in $(TESTS); do echo $$t && ./$$t; done

$(SRC)/crypto_kdf/hkdfsha256/%/hkdfsha256_export.s:
	make -C $(SRC)/crypto_kdf/hkdfsha256/$* clean
	make -C $(SRC)/crypto_kdf/hkdfsha256/$*

test0_%: test0.c $(SRC)/crypto_kdf/hkdfsha256/%/hkdfsha256_export.s
	gcc -Wall -o $@ $^ \
   -I$(INC) \
   -Dhkdfsha256_extract=hkdfsha256_extract_$* \
   -Dhkdfsha256_expand=hkdfsha256_expand_$*

clean:
	rm -f test0_*

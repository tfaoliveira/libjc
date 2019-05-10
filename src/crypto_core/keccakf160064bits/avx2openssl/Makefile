all: test_perm
	

keccak_f1600_avx2_openssl.s : keccak_f1600_avx2_openssl.jazz
	jasminc -lea -o keccak_f1600_avx2_openssl.s keccak_f1600_avx2_openssl.jazz

test_perm : test_perm.c keccak_f1600_avx2_openssl.s
	gcc keccak_f1600_avx2_openssl.s test_perm.c -o test_perm

clean:
	rm keccak_f1600_avx2_openssl.s test_perm

extract: keccak_f1600_avx2_openssl.jazz
	jasminc -ec __KeccakF1600 -oec keccak_f1600_avx2_openssl.ec keccak_f1600_avx2_openssl.jazz


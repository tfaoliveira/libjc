.PHONY: main

main: main.c
	gcc -O3 -Wall -o $@ main.c KeccakF1600_OpenSSL_AVX2.s KeccakF1600_OpenSSL_x86_64.s KeccakF1600_x86_64.s KeccakF1600_x86_64_STATE_IN_STACK_0.s KeccakF1600_x86_64_KECCAK_F_IMPL_3.s KeccakF1600_AVX2.s

KeccakF1600_OpenSSL_AVX2.s:
	./keccak1600-avx2.pl > $@

KeccakF1600_OpenSSL_x86_64.s:
	./keccak1600-x86_64.pl > $@

#KeccakF1600_x86_64.s:
#	gpp -o KeccakF1600_x86_64.japp KeccakF1600_x86_64.jazz
#	jasminc -pasm -lea KeccakF1600_x86_64.japp > KeccakF1600_x86_64.s

#KeccakF1600_x86_64_STATE_IN_STACK_0.s:
#	gpp -o KeccakF1600_x86_64_STATE_IN_STACK_0.japp KeccakF1600_x86_64_STATE_IN_STACK_0.jazz
#	jasminc -pasm -lea KeccakF1600_x86_64_STATE_IN_STACK_0.japp > KeccakF1600_x86_64_STATE_IN_STACK_0.s

#KeccakF1600_x86_64_KECCAK_F_IMPL_3.s:
#	gpp -o KeccakF1600_x86_64_KECCAK_F_IMPL_3.japp KeccakF1600_x86_64_KECCAK_F_IMPL_3.jazz
#	jasminc -pasm -lea KeccakF1600_x86_64_KECCAK_F_IMPL_3.japp > KeccakF1600_x86_64_KECCAK_F_IMPL_3.s

#KeccakF1600_AVX2.s:
#	gpp -o KeccakF1600_AVX2.japp KeccakF1600_AVX2.jazz
#	jasminc -pasm -lea KeccakF1600_AVX2.japp > KeccakF1600_AVX2.s

clean:
	rm -f main

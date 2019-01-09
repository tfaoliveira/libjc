set term svg enhanced background rgb 'white'

set output "chacha20_xor_cycles__jazz_vs_libsodium__512_4096.svg"


plot \
"csv/crypto_stream_chacha20_jazz_ref_4096.csv" using 1:2 title 'Jasmin - ref' with lines lc "blue", \
"csv/crypto_stream_chacha20_jazz_avx_4096.csv" using 1:2 title 'Jasmin - AVX' with lines lc "red", \
"csv/crypto_stream_chacha20_jazz_avx2_4096.csv" using 1:2 title 'Jasmin - AVX2' with lines lc "black", \
"csv/crypto_stream_chacha20_libsodium_static_disable_asm_4096.csv" using 1:2 title 'Libsodium (GCC 8.1 --disable-asm)' with lines lc "green", \
"csv/crypto_stream_chacha20_libsodium_static_4096.csv" using 1:2 title 'Libsodium (GCC 8.1)' with lines lc "violet"

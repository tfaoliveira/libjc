set term svg enhanced background rgb 'white'

set output "poly1305_cycles__jazz_vs_libsodium__32_512.svg"

plot \
"csv/crypto_onetimeauth_poly1305_jazz_ref3_512.csv" using 1:2 title 'Jasmin - ref' with lines lc "blue", \
"csv/crypto_onetimeauth_poly1305_jazz_avx_512.csv" using 1:2 title 'Jasmin - AVX' with lines lc "red", \
"csv/crypto_onetimeauth_poly1305_jazz_avx2_512.csv" using 1:2 title 'Jasmin - AVX2' with lines lc "black", \
"csv/crypto_onetimeauth_poly1305_libsodium_static_disable_asm_512.csv" using 1:2 title 'Libsodium (GCC 8.1 --disable-asm)' with lines lc "green", \
"csv/crypto_onetimeauth_poly1305_libsodium_static_512.csv" using 1:2 title 'Libsodium (GCC 8.1)' with lines lc "violet"

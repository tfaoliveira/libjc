set term svg enhanced background rgb 'white'
set yrange [0:3.5]

set output "../svg/poly1305_jazz_vs_libsodium_16384.svg"

plot \
"../csv/crypto_onetimeauth_poly1305_libsodium_static_disable_asm_16384.csv" using 1:2 title 'Libsodium (GCC 8.1 --disable-asm)' with lines lc "green", \
"../csv/crypto_onetimeauth_poly1305_libsodium_static_16384.csv" using 1:2 title 'Libsodium (GCC 8.1)' with lines lc "violet", \
"../csv/crypto_onetimeauth_poly1305_jazz_ref3_16384.csv" using 1:2 title 'Jasmin - ref' with lines lc "blue", \
"../csv/crypto_onetimeauth_poly1305_jazz_avx_16384.csv" using 1:2 title 'Jasmin - AVX' with lines lc "red", \
"../csv/crypto_onetimeauth_poly1305_jazz_avx2_16384.csv" using 1:2 title 'Jasmin - AVX2' with lines lc "black"

unset yrange
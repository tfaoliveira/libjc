set term svg enhanced background rgb 'white'

set output "../svg/poly1305_jazz_vs_openssl_512.svg"

plot \
"../csv/crypto_onetimeauth_poly1305_openssl_static_no_asm_512.csv" using 1:2 title 'OpenSSL 1.1.1 stable - no assembly' with lines lc "yellow", \
"../csv/crypto_onetimeauth_poly1305_openssl_static_ref_512.csv" using 1:2 title 'OpenSSL 1.1.1 stable - ref' with lines lc "green", \
"../csv/crypto_onetimeauth_poly1305_jazz_ref3_512.csv" using 1:2 title 'Jasmin - ref' with lines lc "blue", \
"../csv/crypto_onetimeauth_poly1305_openssl_static_avx_512.csv" using 1:2 title 'OpenSSL 1.1.1 stable - AVX' with lines lc "orange", \
"../csv/crypto_onetimeauth_poly1305_jazz_avx_512.csv" using 1:2 title 'Jasmin - AVX' with lines lc "red", \
"../csv/crypto_onetimeauth_poly1305_openssl_static_avx2_512.csv" using 1:2 title 'OpenSSL 1.1.1 stable - AVX2' with lines lc "violet", \
"../csv/crypto_onetimeauth_poly1305_jazz_avx2_512.csv" using 1:2 title 'Jasmin - AVX2' with lines lc "black"

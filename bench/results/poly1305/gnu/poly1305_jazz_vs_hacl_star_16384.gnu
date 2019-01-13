set term svg enhanced background rgb 'white'
set logscale y 8
set yrange [0.125:512]

set output "../svg/poly1305_jazz_vs_hacl_star_16384.svg"

plot \
"../csv/crypto_onetimeauth_poly1305_hacl_star_compcert_16384.csv" using 1:2 title 'HACL* (CompCert 3.4)' with lines lc "yellow", \
"../csv/crypto_onetimeauth_poly1305_hacl_star_gcc_16384.csv" using 1:2 title 'HACL* (GCC 8.1)' with lines lc "green", \
"../csv/crypto_onetimeauth_poly1305_jazz_ref3_16384.csv" using 1:2 title 'Jasmin - ref' with lines lc "blue", \
"../csv/crypto_onetimeauth_poly1305_jazz_avx_16384.csv" using 1:2 title 'Jasmin - AVX' with lines lc "red", \
"../csv/crypto_onetimeauth_poly1305_jazz_avx2_16384.csv" using 1:2 title 'Jasmin - AVX2' with lines lc "black"

unset logscale y
unset yrange

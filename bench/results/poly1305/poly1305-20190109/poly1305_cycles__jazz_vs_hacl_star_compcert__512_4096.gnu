set term svg enhanced background rgb 'white'
set logscale y 8
set yrange [0.125:512]

set output "poly1305_cycles__jazz_vs_hacl_star_compcert__512_4096.svg"

plot \
"csv/crypto_onetimeauth_poly1305_hacl_star_compcert_4096.csv" using 1:2 title 'HACL* (CompCert 3.4)' with lines lc "green", \
"csv/crypto_onetimeauth_poly1305_jazz_ref3_4096.csv" using 1:2 title 'Jasmin - ref' with lines lc "blue", \
"csv/crypto_onetimeauth_poly1305_jazz_avx_4096.csv" using 1:2 title 'Jasmin - AVX' with lines lc "red", \
"csv/crypto_onetimeauth_poly1305_jazz_avx2_4096.csv" using 1:2 title 'Jasmin - AVX2' with lines lc "black"


unset logscale y
unset yrange
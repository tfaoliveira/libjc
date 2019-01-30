set term svg enhanced background rgb 'white'
set yrange [0:24]

set output "../svg/chacha20_jazz_vs_hacl_star_16384.svg"

plot \
"../csv/crypto_stream_chacha20_hacl_star_compcert_16384.csv" using 1:2 title 'HACL* (CompCert 3.4)' with lines lc "yellow", \
"../csv/crypto_stream_chacha20_hacl_star_gcc_vec_16384.csv" using 1:2 title 'HACL* Vec (GCC 8.1)' with lines lc "orange", \
"../csv/crypto_stream_chacha20_hacl_star_gcc_16384.csv" using 1:2 title 'HACL* (GCC 8.1)' with lines lc "green" ,\
"../csv/crypto_stream_chacha20_jazz_ref_16384.csv" using 1:2 title 'Jasmin - ref' with lines lc "blue", \
"../csv/crypto_stream_chacha20_jazz_avx_16384.csv" using 1:2 title 'Jasmin - AVX' with lines lc "red", \
"../csv/crypto_stream_chacha20_jazz_avx2_16384.csv" using 1:2 title 'Jasmin - AVX2' with lines lc "black"

unset yrange
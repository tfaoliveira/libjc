set term svg enhanced background rgb 'white'

set output "../svg/chacha20_jazz_vs_usuba_512.svg"

plot \
"../csv/crypto_stream_chacha20_usuba-std_512.csv" using 1:2 title 'usuba-std' with lines lc "green", \
"../csv/crypto_stream_chacha20_jazz_ref_512.csv" using 1:2 title 'Jasmin - ref' with lines lc "blue", \
"../csv/crypto_stream_chacha20_usuba-sse-fast_512.csv" using 1:2 title 'usuba-sse-fast' with lines lc "orange", \
"../csv/crypto_stream_chacha20_jazz_avx_512.csv" using 1:2 title 'Jasmin - AVX' with lines lc "red", \
"../csv/crypto_stream_chacha20_usuba-avx_512.csv" using 1:2 title 'usuba-avx (AVX2)' with lines lc "violet", \
"../csv/crypto_stream_chacha20_usuba-avx-fast_512.csv" using 1:2 title 'usuba-avx-fast (AVX2)' with lines lc "yellow", \
"../csv/crypto_stream_chacha20_jazz_avx2_512.csv" using 1:2 title 'Jasmin - AVX2' with lines lc "black"


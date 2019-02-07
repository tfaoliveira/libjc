set term svg enhanced background rgb 'white'
set yrange [1:9]

set output "../svg/chacha20_jazz_vs_usuba_16384.svg"

plot \
"../csv/crypto_stream_chacha20_usuba-std_16384.csv" using 1:2 title 'usuba-std' with lines lc "green", \
"../csv/crypto_stream_chacha20_jazz_ref_16384.csv" using 1:2 title 'Jasmin - ref' with lines lc "blue", \
"../csv/crypto_stream_chacha20_usuba-sse-fast_16384.csv" using 1:2 title 'usuba-sse-fast' with lines lc "orange", \
"../csv/crypto_stream_chacha20_jazz_avx_16384.csv" using 1:2 title 'Jasmin - AVX' with lines lc "red", \
"../csv/crypto_stream_chacha20_usuba-avx_16384.csv" using 1:2 title 'usuba-avx (AVX2)' with lines lc "violet", \
"../csv/crypto_stream_chacha20_usuba-avx-fast_16384.csv" using 1:2 title 'usuba-avx-fast (AVX2)' with lines lc "yellow", \
"../csv/crypto_stream_chacha20_jazz_avx2_16384.csv" using 1:2 title 'Jasmin - AVX2' with lines lc "black"

unset yrange

set term svg enhanced background rgb 'white'
set logscale x 2

set xlabel "message length in bytes"
set ylabel "cycles per byte"

set output "../svg/chach20_libjc_supercop_v2_xor_cycles_32_16384.svg"

plot \
\
"../csv/crypto_stream_chacha20_krovetz_vec128_16384.csv" using 1:2 title 'krovetz/vec128/' with lines, \
\
"../csv/crypto_stream_chacha20_krovetz_avx2_16384.csv" using 1:2 title 'krovetz/avx2/' with lines, \
\
"../csv/crypto_stream_chacha20_goll_gueron_16384.csv" using 1:2 title 'goll\_gueron/' with lines, \
\
"../csv/crypto_stream_chacha20_jazz_avx2_16384.csv" using 1:2 title 'Jasmin (AVX2)' with lines

unset logscale x


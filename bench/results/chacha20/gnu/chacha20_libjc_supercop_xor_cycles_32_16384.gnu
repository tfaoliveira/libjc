set term svg enhanced background rgb 'white'
set logscale x 2

set xlabel "message length in bytes"
set ylabel "cycles per byte"

set output "../svg/chacha20_libjc_supercop_xor_cycles_32_16384.svg"

plot \
\
"../csv/crypto_stream_chacha20_e_ref_16384.csv" using 1:2 title 'e/ref' with lines, \
\
"../csv/crypto_stream_chacha20_e_amd64-3_16384.csv" using 1:2 title 'e/amd64-3' with lines, \
"../csv/crypto_stream_chacha20_jazz_ref_16384.csv" using 1:2 title 'Jasmin (Scalar)' with lines, \
\
"../csv/crypto_stream_chacha20_moon_avx_64_16384.csv" using 1:2 title 'moon/avx/64' with lines, \
"../csv/crypto_stream_chacha20_jazz_avx_16384.csv" using 1:2 title 'Jasmin (AVX)' with lines, \
\
"../csv/crypto_stream_chacha20_moon_avx2_64_16384.csv" using 1:2 title 'moon/avx2/64' with lines, \
"../csv/crypto_stream_chacha20_jazz_avx2_16384.csv" using 1:2 title 'Jasmin (AVX2)' with lines

unset logscale x


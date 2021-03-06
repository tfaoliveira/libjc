set term svg enhanced background rgb 'white'
set logscale x 2

set xlabel "message length in bytes"
set ylabel "cycles per byte"

set output "../svg/chacha20_libjc_usuba_xor_cycles_32_16384.svg"

plot \
\
"../csv/crypto_stream_chacha20_usuba-std_16384.csv" using 1:2 title 'Usuba (Std)' with lines, \
"../csv/crypto_stream_chacha20_jazz_ref_16384.csv" using 1:2 title 'Jasmin (Scalar)' with lines, \
\
"../csv/crypto_stream_chacha20_jazz_avx_16384.csv" using 1:2 title 'Jasmin (AVX)' with lines, \
\
"../csv/crypto_stream_chacha20_usuba-avx-fast_16384.csv" using 1:2 title 'Usuba (AVX2)' with lines, \
"../csv/crypto_stream_chacha20_jazz_avx2_16384.csv" using 1:2 title 'Jasmin (AVX2)' with lines

unset logscale x


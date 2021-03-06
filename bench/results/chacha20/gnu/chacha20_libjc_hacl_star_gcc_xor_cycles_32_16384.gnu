set term svg enhanced background rgb 'white'
set logscale x 2

set xlabel "message length in bytes"
set ylabel "cycles per byte"

set output "../svg/chacha20_libjc_hacl_star_gcc_xor_cycles_32_16384.svg"

plot \
\
"../csv/crypto_stream_chacha20_hacl_star_gcc_16384.csv" using 1:2 title 'HACL* (Scalar)' with lines, \
\
"../csv/crypto_stream_chacha20_jazz_ref_16384.csv" using 1:2 title 'Jasmin (Scalar)' with lines, \
\
"../csv/crypto_stream_chacha20_hacl_star_gcc_vec_16384.csv" using 1:2 title 'HACL* (Vec128)' with lines, \
\
"../csv/crypto_stream_chacha20_jazz_avx_16384.csv" using 1:2 title 'Jasmin (AVX)' with lines, \
\
"../csv/crypto_stream_chacha20_jazz_avx2_16384.csv" using 1:2 title 'Jasmin (AVX2)' with lines

unset logscale x

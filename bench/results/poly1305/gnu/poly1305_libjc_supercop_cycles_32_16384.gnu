set term svg enhanced background rgb 'white'
set logscale x 2

set xlabel "message length in bytes"
set ylabel "cycles per byte"

set output "../svg/poly1305_libjc_supercop_cycles_32_16384.svg"

plot \
\
"../csv/crypto_onetimeauth_poly1305_amd64_16384.csv" using 1:2 title 'amd64' with lines, \
"../csv/crypto_onetimeauth_poly1305_jazz_ref3_16384.csv" using 1:2 title 'Jasmin (Scalar)' with lines, \
\
"../csv/crypto_onetimeauth_poly1305_moon_avx_64_16384.csv" using 1:2 title 'moon/avx/64' with lines, \
"../csv/crypto_onetimeauth_poly1305_jazz_avx_16384.csv" using 1:2 title 'Jasmin (AVX)' with lines, \
\
"../csv/crypto_onetimeauth_poly1305_moon_avx2_64_16384.csv" using 1:2 title 'moon/avx2/64' with lines, \
"../csv/crypto_onetimeauth_poly1305_jazz_avx2_16384.csv" using 1:2 title 'Jasmin (AVX2)' with lines

unset logscale x


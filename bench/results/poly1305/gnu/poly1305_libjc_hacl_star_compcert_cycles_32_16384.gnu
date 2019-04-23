set term svg enhanced background rgb 'white'
set logscale x 2
set logscale y 2
set yrange [0.5:256]

set xlabel "message length in bytes"
set ylabel "cycles per byte (logscale)"

set output "../svg/poly1305_libjc_hacl_star_compcert_cycles_32_16384.svg"

plot \
\
"../csv/crypto_onetimeauth_poly1305_hacl_star_compcert_16384.csv" using 1:2 title 'HACL* (Scalar) ' with lines, \
\
"../csv/crypto_onetimeauth_poly1305_jazz_ref3_16384.csv" using 1:2 title 'Jasmin (Scalar)' with lines, \
\
"../csv/crypto_onetimeauth_poly1305_jazz_avx_16384.csv" using 1:2 title 'Jasmin (AVX)' with lines, \
\
"../csv/crypto_onetimeauth_poly1305_jazz_avx2_16384.csv" using 1:2 title 'Jasmin (AVX2)' with lines

unset logscale x
unset logscale y
unset yrange

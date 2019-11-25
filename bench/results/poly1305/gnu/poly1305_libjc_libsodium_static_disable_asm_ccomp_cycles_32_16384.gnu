set term svg enhanced background rgb 'white'
set logscale x 2

set xlabel "message length in bytes"
set ylabel "cycles per byte"

set output "../svg/poly1305_libjc_libsodium_static_disable_asm_ccomp_cycles_32_16384.svg"

plot \
\
"../csv/crypto_onetimeauth_poly1305_libsodium_static_disable_asm_ccomp_16384.csv" using 1:2 title 'Libsodium (Scalar) - CompCert 3.6' with lines, \
\
"../csv/crypto_onetimeauth_poly1305_jazz_ref3_16384.csv" using 1:2 title 'Jasmin (Scalar)' with lines, \
\
"../csv/crypto_onetimeauth_poly1305_jazz_avx_16384.csv" using 1:2 title 'Jasmin (AVX)' with lines, \
\
"../csv/crypto_onetimeauth_poly1305_jazz_avx2_16384.csv" using 1:2 title 'Jasmin (AVX2)' with lines

unset logscale x

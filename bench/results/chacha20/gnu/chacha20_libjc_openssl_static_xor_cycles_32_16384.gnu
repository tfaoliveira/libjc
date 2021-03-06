set term svg enhanced background rgb 'white'
set logscale x 2

set xlabel "message length in bytes"
set ylabel "cycles per byte"

set output "../svg/chacha20_libjc_openssl_static_xor_cycles_32_16384.svg"

plot \
\
"../csv/crypto_stream_chacha20_openssl_static_ref_16384.csv" using 1:2 title 'OpenSSL (Scalar)' with lines, \
"../csv/crypto_stream_chacha20_jazz_ref_16384.csv" using 1:2 title 'Jasmin (Scalar)' with lines, \
\
"../csv/crypto_stream_chacha20_openssl_static_avx_16384.csv" using 1:2 title 'OpenSSL (AVX)' with lines, \
"../csv/crypto_stream_chacha20_jazz_avx_16384.csv" using 1:2 title 'Jasmin (AVX)' with lines, \
\
"../csv/crypto_stream_chacha20_openssl_static_avx2_16384.csv" using 1:2 title 'OpenSSL (AVX2)' with lines, \
"../csv/crypto_stream_chacha20_jazz_avx2_16384.csv" using 1:2 title 'Jasmin (AVX2)' with lines

unset logscale x


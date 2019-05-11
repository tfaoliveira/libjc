set term svg enhanced background rgb 'white'
set logscale x 2

set xlabel "message length in bytes"
set ylabel "cycles per byte"

set output "../svg/shake128_cycles_128_16384.svg"
plot "../csv/crypto_hash_shake128_openssl_ref_16384.csv" using 1:2 title 'OpenSSL (Scalar)' with lines, \
"../csv/crypto_hash_shake128_jazz_scalar_16384.csv" using 1:2 title 'Jasmin (Scalar)' with lines, \
"../csv/crypto_hash_shake128_openssl_avx2_16384.csv" using 1:2 title 'OpenSSL (AVX2)' with lines, \
"../csv/crypto_hash_shake128_jazz_avx2_16384.csv" using 1:2 title 'Jasmin (AVX2)' with lines
unset logscale x

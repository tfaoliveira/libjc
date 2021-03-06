set term svg enhanced background rgb 'white'
set logscale x 2

set xlabel "message length in bytes"
set ylabel "cycles per byte"

set output "../svg/sha3384_openssl_cycles_128_16384.svg"
plot "../csv/crypto_hash_sha3384_openssl_no_asm_16384.csv" using 1:2 title 'OpenSSL (no-asm)' with lines, \
"../csv/crypto_hash_sha3384_openssl_scalar_16384.csv" using 1:2 title 'OpenSSL (Scalar)' with lines, \
"../csv/crypto_hash_sha3384_jazz_scalar_16384.csv" using 1:2 title 'Jasmin (Scalar)' with lines, \
"../csv/crypto_hash_sha3384_openssl_avx2_16384.csv" using 1:2 title 'OpenSSL (AVX2)' with lines, \
"../csv/crypto_hash_sha3384_jazz_avx2_16384.csv" using 1:2 title 'Jasmin (AVX2)' with lines
unset logscale x

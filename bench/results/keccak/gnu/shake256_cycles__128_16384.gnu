set term svg enhanced background rgb 'white'
set logscale x 2
set logscale y 2

set yrange [8:128]

set xlabel "message length in bytes"
set ylabel "cycles per byte (logscale)"

set output "../svg/shake256_cycles_128_16384.svg"
plot "../csv/crypto_hash_shake256_jazz_ref_16384.csv" using 1:2 title 'Jasmin (Ref)' with lines, \
"../csv/crypto_hash_shake256_openssl_ref_16384.csv" using 1:2 title 'OpenSSL (Scalar)' with lines, \
"../csv/crypto_hash_shake256_jazz_scalar_16384.csv" using 1:2 title 'Jasmin (Scalar)' with lines, \
"../csv/crypto_hash_shake256_jazz_scalar_g_16384.csv" using 1:2 title 'Jasmin (Scalar + Global Variables)' with lines, \
"../csv/crypto_hash_shake256_jazz_scalar_gr_16384.csv" using 1:2 title 'Jasmin (Scalar + Global Variables + Code Size)' with lines, \
"../csv/crypto_hash_shake256_openssl_avx2_16384.csv" using 1:2 title 'OpenSSL (AVX2)' with lines, \
"../csv/crypto_hash_shake256_jazz_avx2_16384.csv" using 1:2 title 'Jasmin (AVX2)' with lines

unset yrange
unset logscale y
unset logscale x


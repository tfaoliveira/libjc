set term svg enhanced background rgb 'white'
set logscale x 2

set xrange [1024:16384]

set xlabel "message length in bytes"
set ylabel "cycles per byte"

set output "../svg/shake256_scalar_cycles_128_16384.svg"
plot "../csv/crypto_hash_shake256_openssl_ref_16384.csv" using 1:2 title 'OpenSSL (Scalar)' with lines, \
"../csv/crypto_hash_shake256_jazz_scalar_16384.csv" using 1:2 title 'Jasmin (Scalar)' with lines, \
"../csv/crypto_hash_shake256_jazz_scalar_g_16384.csv" using 1:2 title 'Jasmin (Scalar + Global Variables)' with lines

unset xrange
unset logscale x


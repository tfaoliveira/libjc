set term svg enhanced background rgb 'white'
set logscale y 2
set yrange [0.5:32]

set output "chacha20_xor_cycles__jazz_vs_openssl__4096_16384.svg"

plot \
"csv/crypto_stream_chacha20_openssl_static_no_asm_16384.csv" using 1:2 title 'OpenSSL 1.1.1 stable - no assembly' with lines lc "yellow", \
"csv/crypto_stream_chacha20_jazz_ref_16384.csv" using 1:2 title 'Jasmin - ref' with lines lc "blue", \
"csv/crypto_stream_chacha20_openssl_static_avx_16384.csv" using 1:2 title 'OpenSSL 1.1.1 stable - AVX' with lines lc "orange", \
"csv/crypto_stream_chacha20_jazz_avx_16384.csv" using 1:2 title 'Jasmin - AVX' with lines lc "red", \
"csv/crypto_stream_chacha20_openssl_static_avx2_16384.csv" using 1:2 title 'OpenSSL 1.1.1 stable - AVX2' with lines lc "violet", \
"csv/crypto_stream_chacha20_jazz_avx2_16384.csv" using 1:2 title 'Jasmin - AVX2' with lines lc "black"

unset logscale y
unset yrange

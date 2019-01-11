set term svg enhanced background rgb 'white'

set output "chacha20_xor_cycles__jazz_vs_hacl_star_compcert__4096_16384.svg"

plot \
"csv/crypto_stream_chacha20_jazz_ref_16384.csv" using 1:2 title 'Jasmin - ref' with lines lc "blue", \
"csv/crypto_stream_chacha20_jazz_avx_16384.csv" using 1:2 title 'Jasmin - AVX' with lines lc "red", \
"csv/crypto_stream_chacha20_jazz_avx2_16384.csv" using 1:2 title 'Jasmin - AVX2' with lines lc "black", \
"csv/crypto_stream_chacha20_hacl_star_compcert_16384.csv" using 1:2 title 'HACL* (CompCert 3.4)' with lines lc "green"

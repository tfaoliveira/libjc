set term svg enhanced background rgb 'white'

set output "chacha20_xor_cycles__jazz_vs_hacl_star_gcc__32_512.svg"

plot \
"csv/crypto_stream_chacha20_jazz_ref_512.csv" using 1:2 title 'Jasmin - ref' with lines lc "blue", \
"csv/crypto_stream_chacha20_jazz_avx_512.csv" using 1:2 title 'Jasmin - AVX' with lines lc "red", \
"csv/crypto_stream_chacha20_jazz_avx2_512.csv" using 1:2 title 'Jasmin - AVX2' with lines lc "black", \
"csv/crypto_stream_chacha20_hacl_star_gcc_512.csv" using 1:2 title 'HACL* (GCC 8.1)' with lines lc "green"

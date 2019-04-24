set term svg enhanced background rgb 'white'

set yrange [1000:1500]
set xrange [1:1000000]

set xlabel "measurement number ..."
set ylabel "cycles"

set output "cycles.svg"

plot \
"openssl_x86\_64.csv" using 1:2 title 'openssl x86\_64' with lines, \
"jazz_x86_64_state_in_stack_0.csv" using 1:2 title 'jazz x86\_64 (ext memory)' with lines, \
"jazz_x86\_64.csv" using 1:2 title 'jazz x86\_64' with lines, \
"jazz_x86_64_keccak_f_impl_3.csv" using 1:2 title 'jazz x86\_64 (openssl port)' with lines, \
"openssl_avx2.csv" using 1:2 title 'openssl avx2' with lines, \
"jazz_avx2.csv" using 1:2 title 'jazz avx2' with lines

unset yrange
unset xrange

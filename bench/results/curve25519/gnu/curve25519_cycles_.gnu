
set term svg enhanced background rgb 'white'
set title "curve25519"
set output "../svg/curve25519_cycles.svg"
set boxwidth 0.5 relative
set style fill solid 0.5
set xlabel "implementations"
set ylabel "cycles"
set xtics rotate
plot "../csv/curve25519_cycles_.csv" using 0:2:xticlabels(1) with boxes notitle

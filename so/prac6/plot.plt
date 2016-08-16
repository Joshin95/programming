#!/usr/bin/gnuplot

reset
set xlabel "Agrupacions"
set ylabel "Vots (Percentatge)"
set title "Resultats Electorals"
set grid
set ytics 2
set yrange [0:*]
set boxwidth 0.95 relative
set style fill transparent solid 0.5 noborder
plot "vots.dat" using 2:xtic(1) with boxes linecolor rgb "#00FF00" notitle
pause -1
mlr --from reg-test/input/s.dkvp put -q 'begin{@sum=[3,4]} @sum[1+NR%2] += $x; end{dump}'

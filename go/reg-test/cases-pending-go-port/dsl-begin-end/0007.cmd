mlr --from reg-test/input/s.dkvp put -q 'begin{@sum=[]} @sum[1+NR%2] += $x; end{dump}'

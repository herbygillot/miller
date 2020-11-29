
# With mlr -n put v, we are only parsing the DSL expression into an AST and
# then CST, but not executing it

run_mlr -n put -v '$y = 1 || 2'
run_mlr -n put -v '$y = 1 || 2 || 3'
run_mlr -n put -v '$y = 1 || 2 && 3'
run_mlr -n put -v '$y = 1 && 2 || 3'
run_mlr -n put -v '$y = 1 ? 2 : 3'
run_mlr -n put -v '$y = $a + $b * $c'
run_mlr -n put -v '$y = $a * $b * $c'
run_mlr -n put -v '$y = $a ** $b ** $c'
run_mlr -n put -v '$[2] = 3'
run_mlr -n put -v '$[$y] = 4'
#run_mlr -n put -v '${1} = 4'
run_mlr -n put -v '$x = "abc"'
run_mlr -n put -v '$["abc"] = "def"'
run_mlr -n put -v '$[FILENAME] = FNR'
run_mlr -n put -v '$x = $a + $b + $c'
run_mlr -n put -v '$x = ($a + $b) + $c; $y = $a + ($b + $c); $z = $a + ($b)+ $c'
run_mlr -n put -v '$x = 2 * $a + $b . $c'
run_mlr -n put -v '$x = 2 * $a + ($b . $c)'
run_mlr -n put -v '$x = (NF + NR) * 7; $y = OFS . $y . "hello"'
run_mlr -n put -v '$x = 123. + 1e-2 / .2e3 + 1.e-3'
run_mlr -n put -v '$z=0x7fffffffffffffff  + 0x7fffffffffffffff'
run_mlr -n put -v '$z=0x7fffffffffffffff .+ 0x7fffffffffffffff'
run_mlr -n put -v '$z=0x7fffffffffffffff  * 0x7fffffffffffffff'
run_mlr -n put -v '$z=0x7fffffffffffffff .* 0x7fffffffffffffff'

run_mlr --opprint --from $indir/s.dkvp head -n 1 then put '$z=2.3'
run_mlr --opprint --from $indir/s.dkvp head -n 1 then put '$z=2.'
run_mlr --opprint --from $indir/s.dkvp head -n 1 then put '$z=.3'
run_mlr --opprint --from $indir/s.dkvp head -n 1 then put '$z=2.3e4'
run_mlr --opprint --from $indir/s.dkvp head -n 1 then put '$z=2.e4'
run_mlr --opprint --from $indir/s.dkvp head -n 1 then put '$z=.3e4'
run_mlr --opprint --from $indir/s.dkvp head -n 1 then put '$z=2.3e-4'
run_mlr --opprint --from $indir/s.dkvp head -n 1 then put '$z=2.e-4'
run_mlr --opprint --from $indir/s.dkvp head -n 1 then put '$z=.3e-4'

run_mlr -n put -v '$y = 1 * 2 ?? 3'
run_mlr -n put -v '$y = 1 ?? 2 * 3'

run_mlr -n put -v '$z = []'
run_mlr -n put -v '$z = [1,]'
run_mlr -n put -v '$z = [1,2]'
run_mlr -n put -v '$z = [1,2,]'
run_mlr -n put -v '$z = [1,2,3]'
run_mlr -n put -v '$z = [1,2,3,]'

run_mlr -n put -v '$z = {}'
run_mlr -n put -v '$z = {"a":"1"}'
run_mlr -n put -v '$z = {"a":"1",}'
run_mlr -n put -v '$z = {"a":"1", "b":2}'
run_mlr -n put -v '$z = {"a":"1", "b":2,}'
run_mlr -n put -v '$z = {"a":"1", "b":2, "c":3}'
run_mlr -n put -v '$z = {"a":"1", "b":2, "c":3,}'

run_mlr -n put -v '$z = $a[1]'
run_mlr -n put -v '$z = $a["index"]'
run_mlr -n put -v '$z = "abcde"[1]'
run_mlr -n put -v '$z = "abcde"["index"]'
run_mlr -n put -v '$z = $a[1:2]'
run_mlr -n put -v '$z = $a[:2]'
run_mlr -n put -v '$z = $a[1:]'
run_mlr -n put -v '$z = $a[:]'
run_mlr -n put -v '$z = [5,6,7,8,9][1]'
run_mlr -n put -v '$z = {"a":1, "b":2, "c":3}["b"]'

run_mlr -n put -v 'begin{}'
run_mlr -n put -v 'begin{@y=1}'
run_mlr -n put -v 'end{}'
run_mlr -n put -v 'end{@y=1}'
# disallowed run_mlr -n put -v 'begin{}; end {}'
# disallowed run_mlr -n put -v 'begin{@y=1}; $x=2'
run_mlr -n put -v '$x=2; end{@y=1}'
run_mlr -n put -v 'begin{@y=1} $x=2'
run_mlr -n put -v 'begin{} end {}'
run_mlr -n put -v '$x=1;'
run_mlr -n put -v '$x=1;$y=2;'
run_mlr -n put -v 'begin{@x=1;@y=2}'
run_mlr -n put -v 'begin{@x=1;@y=2;}'
run_mlr -n put -v 'begin{@x=1;@y=2;} $z=3'
run_mlr -n put -v 'begin{@x=1;@y=2;} $z=3;'
# disallow in the CST builder
# run_mlr -n put -v 'begin{end{}}'

run_mlr -n put -v 'if (NR == 1) { $z = 100 }'
run_mlr -n put -v 'if (NR == 1) { $z = 100 } else { $z = 900 }'
run_mlr -n put -v 'if (NR == 1) { $z = 100 } elif (NR == 2) { $z = 200 }'
run_mlr -n put -v 'if (NR == 1) { $z = 100 } elif (NR == 2) { $z = 200 } else { $z = 900 }'
run_mlr -n put -v 'if (NR == 1) { $z = 100 } elif (NR == 2) { $z = 200 } elif (NR == 3) { $z = 300 } else { $z = 900 }'

run_mlr -n put -v 'for (k in $*) { emit { k : k } }'

run_mlr -n put -v 'begin {}'
run_mlr -n put -v 'end {}'
run_mlr -n put -v 'if (1) {}'
run_mlr -n put -v 'if (1) {2}'
run_mlr -n put -v 'for (k in $*) {}'
run_mlr -n put -v 'for (k in $*) {2}'
run_mlr -n put -v 'while (false) {}'
run_mlr -n put -v 'do {} while (false)'

run_mlr -n put -v 'nr=NR; $nr=nr'

run_mlr -n put -v 'for (i = 0; i < 10; i += 1) { $x += i }'
run_mlr -n put -v 'for (;;) {}'

run_mlr -n put -v 'for (i = 0; i < NR; i += 1) { $i += i }'
run_mlr -n put -v 'for (i = 0; i < NR; i += 1) { if (i == 2) { continue} $i += i }'
run_mlr -n put -v 'for (i = 0; i < NR; i += 1) { if (i == 2) { break}    $i += i }'

run_mlr -n put -v 'func f(){}'
run_mlr -n put -v 'func f(a){}'
run_mlr -n put -v 'func f(a,){}'
run_mlr -n put -v 'func f(a,b){}'
run_mlr -n put -v 'func f(a,b,){}'
run_mlr -n put -v 'func f(a,b,c){}'
run_mlr -n put -v 'func f(a,b,c,){}'

run_mlr -n put -v 'func f(){return 1}'
run_mlr -n put -v 'func f(a){return 1}'
run_mlr -n put -v 'func f(a,){return 1}'
run_mlr -n put -v 'func f(a,b){return 1}'
run_mlr -n put -v 'func f(a,b,){return 1}'
run_mlr -n put -v 'func f(a,b,c){return 1}'
run_mlr -n put -v 'func f(a,b,c,){return 1}'

run_mlr -n put -v 'func f(x, y) { z = 3}'
run_mlr -n put -v 'func f(var x, var y): var { var z = 3}'

run_mlr -n put -v 'unset $x'
run_mlr -n put -v 'unset $*'
run_mlr -n put -v 'unset @x'
run_mlr -n put -v 'unset @*'
run_mlr -n put -v 'unset x'

mlr_expect_fail -n put -v 'unset 3'

mlr_expect_fail -n put -f $indir/lex-error.mlr
mlr_expect_fail -n put -f $indir/parse-error.mlr

run_mlr put -v 'begin{@a=1}; $e=2; $f==$g||$h==$i {};               $x=6; end{@z=9}' /dev/null
run_mlr put -v 'begin{@a=1}; $e=2; $f==$g||$h==$i {$s=1};           $x=6; end{@z=9}' /dev/null
run_mlr put -v 'begin{@a=1}; $e=2; $f==$g||$h==$i {$s=1;$t=2};      $x=6; end{@z=9}' /dev/null
run_mlr put -v 'begin{@a=1}; $e=2; $f==$g||$h==$i {$s=1;$t=2;$u=3}; $x=6; end{@z=9}' /dev/null
run_mlr put -v 'begin{@a=1}; $e=2; $f==$g||$h==$i {$s=1;@t["u".$5]=2;emit @v;emit @w; dump}; $x=6; end{@z=9}' /dev/null
run_mlr put -v 'begin{true{@x=1}}; true{@x=2}; end{true{@x=3}}' /dev/null

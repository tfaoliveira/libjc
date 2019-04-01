require import AllCore Int IntDiv IntExtra.

op c1(i : int,n) = i < n.
op c2(i : int,n) = i + 4 < n.

module M = {
  proc f(n : int, a: int, b : int) : int = {
     var i : int;
     i <- 0;
     while(c1 i n){
       a <- (a + 1) * b;
       i <- i + 1;
     }
     return a;
  }

  proc g(n : int, a: int, b : int) : int = {
     var i : int;
     i <- 0;
     while(c2 i n){
       a <- (a + 1) * b;
       a <- (a + 1) * b;
       a <- (a + 1) * b;
       a <- (a + 1) * b;
       i <- i + 4;
     }
     while(c1 i n){
       a <- (a + 1) * b;
       i <- i + 1;
     }
     return a;
  }
}.

op f : real -> real -> bool = fun x y => x = y.
op g : real -> real -> bool = fun x y => x = y.
op p : real -> real = fun x => x.
op q : real -> real = fun x => x.
op inv1(inv : bool) : bool = inv.
op inv2(inv : bool) : bool = inv.
op inv3(inv : bool) : bool = inv.

(* 
inlen2 - inlen02 %% 64 = 0 => 64 <= inlen02  =>
inlen02 < 128 => !(128 <= inlen1 /\ 128 <= inlen1 /% 64 * 64) => 
(inlen1 = inlen02 \/ inlen1 = inlen2 + 16 \/ inlen1 = inlen02 + 32 \/ inlen1 = inlen02 + 48) => inlen1 = inlen02.
*)

lemma aux  a b n :
     a %% 4 = 0 => a < n =>
     n <= a + 4 => (n <= b \/ n <= b %/ 4 * 4 + 4) =>
     (b = a \/ b+1 = a \/ b+2 = a \/ b+3 = a) => b = a by smt.

equiv asyncloop : M.f ~ M.g : ={arg} ==> ={res}.
proof.
proc.
splitwhile {1} 2 : (i %/ 4 * 4 + 4 < n).
seq 1 1 : (#pre /\ (i{1} = i{2})); first by auto => />.
seq 1 1 : #pre.
async while
  [ f (i%r), p (i{2})%r ]
  [ g (i%r), q (i{1})%r ]
    (inv1 (={i}))
    (inv2 (i{1} <= i{2}))
  : (inv3 (i{2} <= n{1} /\ ={n,b} /\ (i{2} %% 4 = 0) /\ (n{2} <= i{2} + 4 => i{2} < n{2}) /\
       ((i{1} = i{2} /\ a{1} = a{2}) \/ 
        (i{1} + 1 = i{2} /\ a{2} = (a{1} + 1)*b{1}) \/ 
        (i{1} + 2 = i{2} /\ a{2} = ((a{1} + 1)*b{1} + 1) * b{1})  \/ 
        (i{1} + 3 = i{2} /\ a{2} = (((a{1} + 1)*b{1} + 1) * b{1} + 1) * b{1})))).
(* inv3 => c1 \/ c2 => inv1 => c1 /\ c2 /\ f p /\ g q *)
rewrite /c1 /c2 /inv3 /inv1 /f /g;smt.
(* inv3 => c1 \/ c2 => !inv1 => inv2 => c1 *)
rewrite /c1 /c2 /inv3 /inv1 /inv2 /f /g;smt.
(* inv3 => c1 \/ c2 => !inv1 => !inv2 => c2 *)
rewrite /c1 /c2 /inv3 /inv1 /inv2 /f /g => /#.
(* {inv3 /\ c1 /\ !inv1 /\ inv2} Body1 {inv3} *)
rewrite /c1 /c2 /inv3 /inv1 /inv2 /f /g.
by auto => />;smt.
(* { inv3 /\ c2 /\ !inv1 /\ !inv2} Body2 {inv3} *)
rewrite /c1 /c2 /inv3 /inv1 /inv2 /f /g.
by auto => /#.
(*
forall v1 v2,
{inv3 /\ (c1 \/ c2) /\ inv1 /\ v1_ = p /\ v2_ = q}
    while (c1 /\ f v1) Body1 ~ while (c2 /\ g v2) Body2
{inv3}
*)
move => *.
while(i{2} <= n{1} /\ ={n,b} /\ (i{2} %% 4 = 0) /\ (n{2} <= i{2} + 4 => i{2} < n{2}) /\
      ((i{1} = i{2} /\ v1_ = i{2}%r /\ v2_ = i{1}%r /\ ={a}) \/ 
       (i{1} + 3 = i{2} /\ a{2} = (((a{1} + 1)*b{1} + 1) * b{1} + 1) * b{1} 
            /\ v1_ = i{2}%r - 4%r /\ v2_ = i{1}%r - 1%r))).
wp;skip;progress;
[smt() | smt | smt |
case (i{1} = i{2} /\ v1_ = i{2}%r /\ v2_ = i{1}%r /\ a{1} = a{2}) => /# | 
       smt() | smt() | smt() | smt() | smt() ].
by auto => />;smt.
(* inv3 ==> islossless while(c1 /\ !inv1 /\ inv2) Body1 *)
while (true) (n-i).
by auto => /#.
by auto => /#.
(* inv3 ==> islossless while(c1 /\ !inv1 /\ !inv2) Body2 *)
while (true) (n-i).
by auto => /#.
by auto => /#.
(* !c1 => !c2 => inv3 => #post *)
skip;progress.
   have ? : (i_L = i_R). apply : (aux i_R i_L n{2});smt(). smt().
   apply : (aux i_R i_L n{2});smt(). 
by sim />.
qed.

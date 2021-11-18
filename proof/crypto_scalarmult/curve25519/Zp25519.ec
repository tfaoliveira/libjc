require import Core Int Ring IntDiv StdOrder List.

import Ring.IntID IntOrder.

(*
require import EClib.
*)

from Jasmin require import JModel.

from JasminExtra require import JBigNum.

require import Array4 Array8.

abbrev nlimbs = 4.

clone import BigNum as W64x4 with
 op nlimbs <- nlimbs,
 theory R.A <= Array4,
 theory R2.A <= Array8
 proof gt0_nlimbs by done.

type R = W64.t Array4.t.
type R2 = W64.t Array8.t.

(* modular operations modulo P *)
op P = 2^255 - 19 axiomatized by pE.

axiom P_prime: prime P.

lemma two_pow255E: 2^255 = 57896044618658097711785492504343953926634992332820282019728792003956564819968 by done.

lemma pVal: P = 57896044618658097711785492504343953926634992332820282019728792003956564819949 by smt(pE two_pow255E).

(* Embedding into ring theory *)
require ZModP. (**** ****)
clone import ZModP.ZModField as Zp with
        op p <= P
        rename "zmod" as "zp"
        proof prime_p by exact P_prime.

(* congruence "mod p" *)
lemma zpcgr_over a b:
 zpcgr (a + 2^255 * b) (a + 19 * b).
proof.
have /= ->: (2^ 255) = 19 + P by rewrite pE.
by rewrite (mulzC _ b) mulzDr addzA modzMDr mulzC.
qed.

lemma inzp_over x:
 inzp (2^255 * x) = inzp (19*x).
proof. by have /= := zpcgr_over 0 x; rewrite -eq_inzp. qed.

lemma twop255_cgr : 2^255 %% P = 19 by smt.
lemma twop256_cgr : 2^256 %% P = 38 by smt.

lemma P_cgr: (2^256 - 2^255 - 19)%%P = 0.
proof.
by rewrite -modzDml -(modzDm (2^256) (-2^255)) -modzNm
     twop256_cgr twop255_cgr modzDmr /= modzDml.
qed.

lemma ltP_overflow x:
 (x + 2^255 + 19 < 2^256) = (x < P).
proof.
have ->: 2^255 = P + 19 by rewrite pE /#. 
have ->: 2^256 = P + P + 19 + 19 by rewrite !pE /#.
smt().
qed.

op red x = if x + 2^255 + 19 < 2^256 then x else (x + 2^255 + 19) %% 2^256.

lemma redE x:
 P <= x < 2^256 =>
 (x + 2^255 + 19) %% 2^256 = x - P.
proof.
move=> [H1 H2].
pose y := x-P.
rewrite (_: x= y+P) 1:/# (_:2^255 = P+19) 1:pE 1:/#.
rewrite -addrA -addrA (_:P + (P + 19 + 19) = 2^256) 1:pE 1:/#.
rewrite modzDr modz_small; last reflexivity.
apply bound_abs.
move: H2; have ->: 2^256 = P + P + 19 + 19 by rewrite !pE /#.
smt(pVal).
qed.

lemma redP x:
 0 <= x < 2^256 =>
 x %% P = red (red x).
proof.
move=> [H1 H2].
rewrite /red !ltP_overflow.
case: (x < P) => Hx1.
 rewrite Hx1 /= modz_small; last done.
 by apply bound_abs => /#.
rewrite redE.
 split => *; [smt() | assumption].
case: (x - P < P) => Hx2.
 rewrite {1}(_: x = x - P + P) 1:/# modzDr modz_small; last reflexivity.
 by apply bound_abs => /#.
rewrite redE.
 split => *; first smt().
 rewrite (_:W256.modulus = W256.modulus-0) 1:/#. 
 apply (ltr_le_sub); first assumption. 
 smt(pVal). 
rewrite (_: x = x - P - P + P + P) 1:/#.
rewrite modzDr modzDr modz_small.
apply bound_abs; split => *; first smt().
 move: H2; have ->: 2^256 = P + P + 19 + 19 by rewrite !pE /#.
 smt(pVal).
smt().
qed.


(** "Implements" relation *)
(*abbrev ImplBool x y = (W64.to_uint x) = b2i y.*)
abbrev ImplWord x y = W64.to_uint x = y.
abbrev ImplZZ x y = valR x = y.
abbrev ImplZZ2 x y = valR2 x = y.
abbrev ImplFp x y = valR x = asint y.
abbrev ImplFpC (y : zp , x : R (*W64.t Array4.t*)) : bool = zpcgr (asint y) (valR x).

op pR: R = R.A.of_list 
             W64.zero
             [ W64.of_int 18446744073709551597
             ; W64.of_int 18446744073709551615
             ; W64.of_int 18446744073709551615
             ; W64.of_int 9223372036854775807
             ].

lemma pRE: ImplZZ pR P.
proof.
by rewrite /pR R.bn2seq /= R.A.of_listK 1:/# /bn_seq pVal.
qed.

op zeroR : R = R.A.of_list W64.zero
                 [ W64.zero; W64.zero; W64.zero; W64.zero ].

lemma zeroRE: valR zeroR = 0.
proof.
by rewrite /zeroR R.bn2seq /= R.A.of_listK 1:/# /bn_seq.
qed.


abbrev M = 115792089237316195423570985008687907853269984665640564039457584007913129639936.

op split256 x = (x %/ 2^256, x %% 2^256).

op red256 (x: int) : int =
 (split256 x).`2 + 38 * (split256 x).`1.

lemma red256P x: zpcgr x (red256 x).
proof.
by rewrite {1}(divz_eq x (2^256)) -modzDml -modzMmr twop256_cgr 
           modzDml /red256 /split256 /= addrC mulrC.
qed.

lemma red256_bnd B x:
 0 <= x < M * B => 
 0 <= red256 x < M + 38*B.
proof.
move=> [Hx1 Hx2]; rewrite /red256 /split256 /=; split => *.
 apply addz_ge0; first smt(modz_cmp).
 apply mulr_ge0; first done.
 apply divz_ge0; smt().
have H1: x %/ M < B by smt().
have H2: x %% M < M by smt(modz_cmp).
smt().
qed.

lemma red256_once x:
 0 <= x < M*M =>
 0 <= red256 x < M*39.
proof.
have ->: M*39 = M + 38*M by ring.
exact red256_bnd.
qed.

lemma red256_twice x:
 0 <= x < M*M =>
 0 <= red256 (red256 x) < M*2.
proof.
move=> Hx; split => *.
 smt(red256_once).
move: (red256_once x Hx).
move => Hy.
move: (red256_bnd 39 _ Hy); smt().
qed.

lemma red256_twiceP x a b:
 0 <= x < M*M =>
 (a,b) = split256 (red256 (red256 x)) =>
(* 0 <= a < 2 /\ (a=0 \/ b <= 38*38).*)
 a=0 \/ a=1 /\ b <= 38*38.
proof.
move=> Hx Hab.
have Ha: 0 <= a < 2.
 have H := (red256_twice x Hx).
 move: Hab; rewrite /split256 => [[-> _]]; smt().
case: (a=0) => Ea /=; first done.
have {Ea} Ea: a=1 by smt().
rewrite Ea /=.
move: Hab; pose y := red256 x.
rewrite /red256 /split256 /=.
pose yL := y%%M.
pose yH := y%/M.
have Hy := red256_once x Hx.
have HyH : 0 <= yH <= 38 by smt().
move => [Hab1 Hab2].
have E: M + b = yL + 38 * yH.
 by move: (divz_eq (yL + 38 * yH) M); smt().
smt(modz_cmp).
qed.

lemma red256_thrice x:
 0 <= x < M*M =>
 0 <= red256 (red256 (red256 x)) < M.
proof.
move=> Hx; pose y:= red256 (red256 x).
rewrite /red256.
have := (red256_twiceP x (split256 y).`1 (split256 y).`2 _ _).
  smt(red256_twice).
 smt().
move=> [->|[-> H2]] /=.
 rewrite /split256; smt(modz_cmp).
split.
 rewrite /split256; smt(modz_cmp).
smt().
qed.

op reduce x = red256 (red256 (red256 x)).

lemma reduceP x:
 0 <= x < M*M =>
 zpcgr x (reduce x) /\ 0 <= reduce x < M.
proof.
rewrite /reduce => H; split; first smt(red256P).
smt(red256_thrice).
qed.



(******************************************************************)
(*                  ABSTRACT SPECIFICATIONS                       *)
(******************************************************************)
module ASpecFp = {
  (* INTEGER OPS *)
  proc eqn(a b: int) : bool = {
    var r;
    r <- (a=b);
    return r;
  }
  proc eqn0(a: int) : bool = {
    var r;
    r <- (a=0);
    return r;
  }
  proc addn(a b: int): bool * int = {
    var c, r;
    c <- modulusR <= (a+b);
    r <- (a + b) %% modulusR;
    return (c, r);
  }
  proc subn(a b: int): bool * int = {
    var c, r;
    c <- a < b;
    r <- (a - b) %% modulusR;
    return (c, r);
  }
  proc muln(a b: int): int = {
    var r;
    r <- a * b;
    return r;
  }
  (* reduces "a \in [0..2^256[" into "x \in [0..P[" *)
  proc freeze(a: int): zp = {
    var r;
    r <- inzp a;
    return r;
  }
  proc set0n(): int = {
    var r;
    r <- 0;
    return r;
  }
  proc ctseln(cond: bool, c a: int): int = {
    var r;
    r <- (if cond then a else c);
    return r;
  }
  proc copyn(a: int): int = {
    var r;
    r <- a;
    return r;
  }
  proc cminusP(a: int): int = {
    var r;
    r <- if a < P then a else a-P;
    return r;
  }
  proc caddP(c: bool, a: int): int = {
    var r;
    r <- if c then (a+P)%%modulusR else a%%modulusR;
    return r;
  }
  proc reduce(a: int): int = {
    var r;
    r <- reduce a;
    return r;
  }
  (********************)
  (* Finite Field Ops *)
  (********************)
  proc copym(a: zp): zp = {
    var r;
    r <- a;
    return r;
  }
  proc set0m(): zp = {
    var r;
    r <- Zp.zero;
    return r;
  }
  (* modular operations: finite field [Fp] *)
  proc addm(a b: zp): zp = {
    var r;
    r <- a + b;
    return r;
  }
  proc subm(a b: zp): zp = {
    var r;
    r <- a - b;
    return r;
  }
  proc mulm(a b: zp): zp = {
    var r;
    r <- a * b;
    return r;
  }
}.

(******************************************************************)
(*                  CONCRETE SPECIFICATIONS                       *)
(******************************************************************)
module CSpecFp = {
 proc cminusP(a: int): int = {
  var c, x, r;
  (c, x) <@ ASpecFp.addn(a, 2^255 + 19);
  r <@ ASpecFp.ctseln(c, a, x);
  return r;
 }
 proc addm(a b: zp): int = {
  var c, x, r;
  (c, x) <@ ASpecFp.addn(asint a, asint b);
  r <@ ASpecFp.cminusP(x);
  return r;
 }
 proc caddP(c: bool, a: int): int = {
  var x, r;
  x <- ASpecFp.ctseln(c, 0, P);
  (c, r) <@ ASpecFp.addn(a, x);
  return r;
 }
 proc subm(a b: zp): int = {
  var c, r, x;
  (c, r) <@ ASpecFp.subn(asint a, asint b);
  x <- ASpecFp.caddP(c, r);
  return x;
 }
 proc freeze(a: int): int = {
   var r;
   r <@ ASpecFp.cminusP(a);
   r <@ ASpecFp.cminusP(r);
   return r;
 }
 proc mulm(a b: zp): int = {
  var r, x;
  r <@ ASpecFp.muln(asint a, asint b);
  x <@ ASpecFp.reduce(r);
  x <@ freeze(x);
  return x;
 }
}.

equiv cminusP_eq:
 ASpecFp.cminusP ~ CSpecFp.cminusP: ={a} /\ a{2}<modulusR ==> ={res}.
proof.
proc; inline*; wp; skip => &1 &2.
have ->: modulusR = 2^256 by rewrite R.bn_modulusE /= !mulrA expr0. 
move=> [-> Ha] X.
rewrite lerNgt if_neg.
rewrite /X addrA ltP_overflow.
case: (a{2} < P) => H; first done.
rewrite redE 2://.
split; last done. 
smt().
qed.

equiv freeze_eq:
 ASpecFp.freeze ~ CSpecFp.freeze: ={a} /\ 0<=a{2}<modulusR ==> asint res{1}=res{2}.
proof.
proc; inline*; wp; skip => &1 &2.
have ->: modulusR = 2^256 by rewrite R.bn_modulusE /= !mulrA expr0. 
move=> [-> [Ha1 Ha2]] /=.
rewrite inzpK; case: (a{2} < P) => H0.
 by rewrite modz_small /#.
case: (a{2} - P < P) => H1.
 rewrite {1}(_: a{2} = a{2} - P + P) 1:/# modzDr modz_small; last reflexivity.
 by apply bound_abs => /#.
rewrite (_: a{2} = a{2} - P - P + P + P) 1:/#.
rewrite modzDr modzDr modz_small.
apply bound_abs; split => *; first smt().
move: Ha2 => /=; smt(pVal).
smt().
qed.


equiv addm_eq:
 ASpecFp.addm ~ CSpecFp.addm: ={a,b} ==> asint res{1}=res{2}.
proof.
proc; simplify.
+ inline*; wp; skip => /> &2.
  have ->: (asint a{2} + asint b{2}) %% modulusR = (asint a{2} + asint b{2}).
   rewrite modz_small. smt.
   done.
  case: (asint a{2} + asint b{2} < P) => H.
   by rewrite addE modz_small; smt(rg_asint).
  rewrite addE. smt. 
qed.

equiv caddP_eq:
 ASpecFp.caddP ~ CSpecFp.caddP:
  ={c,a} (*/\ 0<=a{2}<modulusR /\ (c{2} => modulusR < a{2}+P)*)
  ==> ={res}.
proof.
proc; inline*; wp; skip => &1 &2 /=.
have ->: modulusR = 2^256 by rewrite R.bn_modulusE /= !mulrA expr0. 
move=> [-> ->] /=.
case: (c{2}) => ?; first smt().
by move=> /> *; rewrite modz_small /#.
qed.

equiv subm_eq:
 ASpecFp.subm ~ CSpecFp.subm:
  ={a,b} ==> asint res{1}=res{2}.
proof.
proc; simplify.
inline*. wp; skip => />  &2.
case: (asint a{2} < asint b{2} ) => /= H.
 rewrite modzDml modz_small.
  smt.
 rewrite addE oppE modzDmr. smt.
rewrite modz_small.
 smt.
rewrite addE oppE modzDmr. smt. 
qed.

equiv mulm_eq:
 ASpecFp.mulm ~ CSpecFp.mulm: ={a,b} ==> asint res{1}=res{2}.
proof.
proc; simplify.
transitivity {2}
 { r <@ ASpecFp.muln(asint a, asint b); x <- reduce r; a <@ ASpecFp.freeze(x); }
 ( ={a,b} ==> r{1}=a{2} )
 ( ={a,b} ==> asint a{1} = x{2} ).
 + by move=> /> &2; exists a{2} b{2} => /#.
 + by move=> /> /#.
 + inline*; wp; skip => /> &2.
   apply asint_inj.
   rewrite Zp.mulE inzpK. 
   move: (reduceP (asint a{2}*asint b{2}) _).
    move: (rg_asint a{2}) (rg_asint b{2}); smt(pVal).
   smt().
 + call freeze_eq.
   inline*; wp; skip => &1 &2 [-> ->] /=.
   move: (reduceP (asint a{2}*asint b{2}) _).
    move: (rg_asint a{2}) (rg_asint b{2}); smt(pVal).
   by rewrite R.bn_modulusE -exprM /= /#.
qed.

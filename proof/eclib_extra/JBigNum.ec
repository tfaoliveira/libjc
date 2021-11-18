require import Core Int IntDiv List StdOrder Bool.
require import BitEncoding StdBigop Bigalg.
(*---*) import Ring.IntID IntOrder BS2Int.
(*---*) import Bigint BIA.

from Jasmin require import JWord JUtils JArray.

(* Where does this belongs? *)
lemma divzU a b q r:
 0 <= r < `|b|%Int => a = b*q+r => q=a%/b.
proof.
move=> r_bnd E.
have Ediv := divz_eq a b.
have [??] := euclideU b q (a%/b) r (a%%b) _ _ _ => //.
 by rewrite mulzC -E {1}Ediv.
smt(modz_ge0 ltz_mod).
qed.

lemma divz_div a b c:
 0 <= b => 0 <= c => a %/ b %/ c = a %/ (b * c).
proof.
move=> H H0.
case: (b*c = 0) => [|E].
 by rewrite Ring.IntID.mulf_eq0; move => [->|->] /=.
apply (divzU _ _ _ (b*((a%/b)%%c) + a %% b)).
 apply bound_abs; split.
  smt(StdOrder.IntOrder.mulr_ge0 addz_ge0 modz_ge0).
 move => *.
 apply (StdOrder.IntOrder.ltr_le_trans (b * (a %/ b %% c) + b)).
  rewrite StdOrder.IntOrder.ltr_add2l; smt(modz_cmp).
 have ->: b * (a %/ b %% c) + b = b * (a %/ b %% c + 1) by smt().
 have -> := (StdOrder.IntOrder.ler_pmul2l b _) => /#.
rewrite {1}(divz_eq a b) addzA; congr.
rewrite mulzA -mulzDr mulzC; congr.
by rewrite {1}(divz_eq (a%/b) c); ring.
qed.

lemma lex_lt x1 x2 m y1 y2:
 0 < m => 0 <= x1 < m => 0 <= x2 < m => 0 <= y1 => 0 <= y2 =>
 (y1*m + x1 < y2*m + x2) = (y1 < y2 \/ y1=y2 /\ x1 < x2).
proof. by move=> /> *; rewrite (divzU (y1 * m + x1) m y1 x1) /#. qed.

lemma lex_le x1 x2 m y1 y2:
 0 < m => 0 <= x1 < m => 0 <= x2 < m => 0 <= y1 => 0 <= y2 =>
 (y1*m + x1 <= y2*m + x2) = (y1 < y2 \/ y1=y2 /\ x1 <= x2).
proof. by move=> /> *; rewrite (divzU (y1 * m + x1) m y1 x1) /#. qed.

lemma modz_pow (a b d: int):
 0 <= b => a ^ b %% d = (a %% d) ^ b %% d.
proof.
elim/natind: b.
 by move => n *; rewrite (_:n=0) 1:/# !expr0.
move=> n Hn IH H.
rewrite !exprS 1..2://.
by rewrite eq_sym -modzMmr -IH 1:// modzMmr modzMml.
qed.

lemma mul_pow (a b c: int):
 0 <= c => (a*b)^c = a^c * b^c.
proof.
elim/natind: c => n *.
 by rewrite (_:n=0) 1:/# !expr0.
by rewrite !exprS 1..3:// /#.
qed.

lemma one_pow x: 1 ^ x = 1.
proof.
elim/natind: x => *.
 by rewrite expr1z.
by rewrite exprS.
qed.

(* END: *)


abstract theory BN.

(*
(* Words *)
op wsize : int.
axiom gt0_wsize: 0 < wsize.
clone import WordExt as Word with
  op size <- wsize
  proof gt0_size by apply gt0_wsize.
*)
import W64.

(** Number of limbs *)
op nlimbs : int.
axiom gt0_nlimbs: 0 < nlimbs.
clone export PolyArray as A with
  op size <- nlimbs.
(*
  proof ge0_size by (apply ltrW; apply gt0_nlimbs).
*)

(* BigInt view of an array... *)
type t = W64.t A.t.

op bn_modulus : int = W64.modulus ^ nlimbs.
lemma bn_modulusE: bn_modulus = W64.modulus ^ nlimbs by rewrite /bn_modulus.

(* digits *)
op dig (x: t) (i:int): int = to_uint x.[i]*W64.modulus^i.
lemma digE (x: t) (i:int): dig x i = to_uint x.[i]*W64.modulus^i by rewrite /dig.
hint simplify digE.

(* BigInt value for a prefix of an array *)
op bnk (k:int) (x:t): int = bigi predT (dig x) 0 k.
abbrev [-printing] bn (x:t): int = bnk nlimbs x.

lemma bnkN k x: k <= 0 => bnk k x = 0.
proof. by move => ?; rewrite /bnk big_geq. qed.

lemma bnk0 x: bnk 0 x = 0.
proof. by rewrite bnkN. qed.

lemma bnkS k x: 0 <= k => bnk (k+1) x = dig x k + bnk k x.
proof. 
case: (k=0) => E.
 by rewrite E /= /bnk rangeS range_geq 1:// big_cons /#.
move=> ?; rewrite /bnk (range_cat k) // 1:/# big_cat rangeS addzC; congr.
by rewrite big_cons big_nil /#.
qed.

lemma bnk1 x: bnk 1 x = dig x 0.
proof. by rewrite -(add0z 1) bnkS 1:/# digE expr0 bnk0. qed.

require import StdOrder.
lemma bnk_cmp k x: 0 <= bnk k x < W64.modulus^k.
proof.
case: (k <= 0).
 by move=> *; rewrite bnkN // expr_gt0.
elim/natind: k => // k Hk IH H.
rewrite bnkS // exprS // digE. 
case: (k=0) => E.
  rewrite E bnk0 !expr0 !mulr1 !addr0.
  move: to_uint_cmp; smt().
  (* ??? falha com "smt(to_uint_cmp)." ??? *)
move: (IH _); first smt().
move=> /> ??; split; first smt(@IntOrder to_uint_cmp).
move=> H2; rewrite ltzE -addzA.
apply (lez_trans (to_uint x.[k] * W64.modulus ^ k + W64.modulus^k)).
 smt().
rewrite (_:to_uint x.[k] * W64.modulus ^ k + W64.modulus ^ k=(to_uint x.[k]+1)*W64.modulus^k) 1:/#.
rewrite ler_pmul2r 1:/# -ltzE.
by move: (to_uint_cmp x.[k]) => /#.
qed.

lemma bnk_ltb k x y b:
 0 <= k =>
 bnk (k+1) x < bnk (k+1) y + b2i b
 = (to_uint x.[k] < to_uint y.[k] \/ x.[k]=y.[k] /\ bnk k x < bnk k y + b2i b).
proof.
move=> ?; rewrite !bnkS // !digE.
move: (to_uint_cmp x.[k]) (to_uint_cmp y.[k]) =>  *.
case: b => E; rewrite ?b2i1 ?b2i0 => *.
 rewrite !ltzS lex_le ?expr_gt0 //; move: bnk_cmp to_uint_eq; smt().
by rewrite /= lex_lt ?expr_gt0 //; move: bnk_cmp to_uint_eq; smt().
qed.

lemma bnk_setO k (x: t) i y:
 0 <= k <= i < nlimbs =>
 bnk k x.[i <- y] = bnk k x.
proof.
elim/natind: k => /=.
 by move=> k *; rewrite (_:k=0) 1:/# !bnk0.
by move=> k Hk IH H; rewrite !bnkS // !digE !get_setE 1:/# IH /#.
qed.

(* upper part of a bigint (useful in decreasing loops...) *)

op bnkup k (x: t): int =
 bigi predT (fun i => to_uint x.[i] * W64.modulus^(i-k)) k nlimbs.

lemma bnkup0 x: bnkup 0 x = bn x by done.

lemma bnkup_nlimbs x: bnkup nlimbs x = 0.
proof. by rewrite /bnkup range_geq 1:// big_nil. qed.

lemma bnkupP k x:
 0 < k <= nlimbs =>
 bnkup (k-1) x = to_uint x.[k-1] + bnkup (k) x * W64.modulus.
proof.
move=> *; rewrite /bnkup (range_cat k) 1..2:/# big_cat.
rewrite rangeS big_cons big_nil /predT /= expr0; congr => //.
rewrite mulr_suml; apply eq_big_int => i * /=.
rewrite mulzA; congr.
by rewrite (_:i-(k-1)=i-k+1) 1:/# exprS /#.
qed.

lemma bnkup_setO k (x: t) y:
 0 < k <= nlimbs =>
 bnkup k x.[k - 1 <- y] = bnkup k x.
proof.
move=> H; apply eq_big_seq => x0; rewrite mem_range => * /=.
by rewrite get_setE 1:/# (_:x0 <> k - 1) 1:/#.
qed.

lemma bn_k_kup k x:
 0 <= k <= nlimbs =>
 bn x = bnk k x + bnkup k x * W64.modulus^k.
proof.
elim/natind: k=> [k Hk H|k Hk IH H].
 by rewrite (_:k=0) 1:/# bnk0 bnkup0 expr0.
rewrite bnkS 1:// exprS 1:/# IH 1:/#.
move: (bnkupP (k+1) x _); first smt().
by move=> /= ->; ring.
qed.

lemma bn_mod k x:
 0 <= k <= nlimbs =>
 bn x %% W64.modulus^k = bnk k x.
proof.
by move=> H; rewrite (bn_k_kup k x _) 1:/# modzMDr modz_small; move:bnk_cmp; smt().
qed.
 
lemma bghint_div k x:
 0 <= k <= nlimbs =>
 bn x %/ W64.modulus^k = bnkup k x.
proof.
move=> H; rewrite (bn_k_kup k x _) 1:/# divzMDr; first smt(expr_gt0).
rewrite divz_small; move: bnk_cmp; smt().
qed.

lemma bn_inj x y:
 bn x = bn y => x = y.
proof.
move=> E.
have HH: forall k, 0 <= k <= nlimbs => bnk k x = bnk k y.
 by move=> k Hk; rewrite -!(bn_mod k) 1..2:/# E.
apply A.ext_eq => k Hk; rewrite to_uint_eq.
move: (HH (k+1) _); first smt(). 
rewrite !bnkS 1..2:/# !digE (HH k _) 1:/# => /addIz.
move: (mulIf (W64.modulus ^ k) _); first smt(expr_gt0).
by move => I /I.
qed.

(* BigNum of an integer *)

op bn_ofint x = A.init (fun i => JWord.W64.of_int (x %/ W64.modulus^i)).

lemma bn_ofintE x i:
 0 <= i < nlimbs =>
 (bn_ofint x).[i] = W64.of_int (x %/ W64.modulus^i).
proof. by move=> Hi; rewrite /bn_ofint initiE 1:/#. qed.

lemma bnk_ofintK x k:
 0 <= k <= nlimbs =>
 bnk k (bn_ofint x) = x %% W64.modulus ^ k.
proof.
elim/natind: k x.
 move=> k Hk0 x Hk.
 by rewrite (_:k=0) 1:/# bnk0 expr0 modz1.
move=> k Hk0 IH /= x Hk.
case: (k=0) => [->/=|Ek].
 rewrite expr0 /= bnk1 digE expr0 bn_ofintE; first smt(gt0_nlimbs).
 by rewrite expr0 divz1 W64.of_uintK.
rewrite bnkS 1:/# /= IH 1:/# bn_ofintE 1:/# of_uintK.
rewrite exprS 1:/#.
have ->: x %/ W64.modulus ^ k %% W64.modulus 
         = (x %% W64.modulus ^ (k+1)) %/ W64.modulus ^ k.
 rewrite -divz_mod_mul /=; first 2 smt(StdOrder.IntOrder.expr_gt0).
 rewrite exprS; smt(StdOrder.IntOrder.expr_gt0).
have ->: x %% W64.modulus ^ k = (x %% W64.modulus ^ (k+1)) %% W64.modulus ^ k.
 by rewrite modz_dvd_pow 1:/#.
by rewrite /= -divz_eq exprS /#.
qed.

require import StdOrder.
lemma bn_ofintK x:
 bn (bn_ofint x) = x %% bn_modulus.
proof. by rewrite bnk_ofintK /bn_modulus; smt(gt0_nlimbs). qed.

lemma bnK x:
 bn_ofint (bn x) = x.
proof.
apply bn_inj.
rewrite bnk_ofintK; first smt(gt0_nlimbs).
rewrite modz_small; move: bnk_cmp; smt().
qed.

(* to prove by simplification... *)

op bn_seq (x: W64.t list) : int = foldr (fun w r => W64.to_uint w + W64.modulus * r) 0 x.

import List.
lemma bn2seq x:
 bn x = bn_seq (to_list x).
proof.
have ->: bn x = bigi predT (fun i => to_uint (nth W64.zero (to_list x) i) * W64.modulus ^ i) 0 (size (to_list x)).
 rewrite size_to_list; apply eq_big_seq => y; rewrite mem_range => /> *; congr.
 rewrite -get_to_list; congr.
 by rewrite !nth_mkseq.
elim: (to_list x) => //=.
 by rewrite /bn_seq big1_eq.
move=> y ys IH; rewrite /bn_seq /= -/(bn_seq ys).
rewrite (range_cat 1) //; first smt(size_ge0).
rewrite big_cat rangeS big_cons big_nil /predT /= expr0 /=; congr.
rewrite -(add0z 1) big_addn /= -IH.
rewrite big_distrr // 1:/#.
apply eq_big_seq => z; rewrite mem_range => /> *.
by rewrite (_:! z+1=0) 1:/# /= exprS // /#.
qed.

(* carry/borrow propagation... *)

(* better specification of [addc] and [subc]
   TODO: move it to JWord.ec                        *)
op carry (x y: W64.t) (c: bool): bool = W64.modulus <= to_uint x + to_uint y + b2i c.
lemma carryE (x y: W64.t) (c: bool): carry x y c = W64.modulus <= to_uint x + to_uint y + b2i c
by rewrite /carry.

lemma addcP' x y c:
 to_uint (W64.addc x y c).`2 = to_uint x + to_uint y + b2i c - b2i (carry x y c) * W64.modulus.
proof.
rewrite addcE /= carryE.
case: (W64.modulus <= to_uint x + to_uint y + b2i c) => E.
 rewrite to_uintD of_uintK b2i1 /= (modz_small (b2i c)); first smt(ge2_modulus).
 rewrite to_uintD modzDml -(modzMDr (-1)) modz_small //=.
 case: c E; rewrite /b2i /=; move: to_uint_cmp; smt().  
smt(to_uintD_small of_uintK modz_small to_uint_cmp ge2_modulus bound_abs).
qed.

op borrow (x y: W64.t) (c: bool): bool = to_uint x < to_uint y + b2i c.
lemma borrowE (x y: W64.t) (c: bool): borrow x y c = to_uint x < to_uint y + b2i c
by rewrite /borrow.

lemma subcP' x y c:
 to_uint (W64.subc x y c).`2 = to_uint x - to_uint y - b2i c + b2i (borrow x y c) * W64.modulus.
proof.
rewrite subcE /= borrowE.
case: (to_uint x < to_uint y + b2i c) => E.
 rewrite to_uintD to_uintN modzDmr to_uintD of_uintK (modz_small (b2i c)); first smt(ge2_modulus).
 by rewrite -modzDmr modzNm modzDmr b2i1 -(modzMDr (1)) /= modz_small; case: c E; move: to_uint_cmp; smt().
rewrite to_uintD to_uintN to_uintD of_uintK modzNm modzDmr b2i0 /=.
rewrite -modzDmr -modzNm !modzDmr -modzDmr modzNm modzDmr modz_small; move: to_uint_cmp; smt().
qed.
(* end TODO: move it to JWord.ec                        *)

op bn_carry (k:int) (x y: t) (c:bool): bool =
 iteri k (fun i r => carry x.[i] y.[i] r) c.

lemma bn_carry0 x y c: bn_carry 0 x y c = c by rewrite /bn_carry iteri0.

lemma bn_carryS k x y c:
 0 <= k =>
 bn_carry (k+1) x y c = (carry x.[k] y.[k] (bn_carry k x y c))
 by move=> *; rewrite /bn_carry iteriS.

lemma bn_carryP k x y c:
 0 <= k =>
 b2i (bn_carry k x y c) = (bnk k x + bnk k y + b2i c) %/ W64.modulus^k.
proof.
elim: k.
 by rewrite expr0 !bnk0 // bn_carry0 /#.
move=> k Hk IH; rewrite bn_carryS // carryE IH; clear IH.
pose X:= (_ <= _)%Int.
have ->{X}: X = (W64.modulus-(to_uint x.[k]+to_uint y.[k]) 
              <= (bnk k x + bnk k y + b2i c)%/ W64.modulus^k) by smt. 
rewrite lez_divRL 1:expr_gt0 1:expr_gt0 1:// mulzDl -ler_subr_addr /= -exprS //.
pose X:= ( _ - _ * _)%Int.
have ->{X}: X = bnk (k+1) x + bnk (k+1) y + b2i c.
 by rewrite !bnkS /#.
pose X:= (_<=_)%Int; case: X => E.
 rewrite b2i1.
 pose Y:= (_ + b2i c); rewrite (_: Y = 1*(W64.modulus ^ (k+1)) + (Y-W64.modulus^(k+1))) 1:/#.
 rewrite  divzMDl; first smt(expr_gt0). 
 rewrite divz_small //.
 by apply bound_abs; split => *; move: to_uint_cmp bnk_cmp; smt(). 
rewrite b2i0 eq_sym; apply divz_eq0; first smt(exprS expr_gt0).
smt(to_uint_cmp bnk_cmp). 
qed.

lemma bn_carryE k x y c:
 0 <= k =>
 bn_carry k x y c = (W64.modulus^k <= bnk k x + bnk k y + b2i c).
proof.
elim/natind: k => //=.
 by move=> n Hn Hn'; rewrite (_:n=0) 1:/# bn_carry0 expr0 !bnk0 /#.
move=> k Hk IH {IH} H {H}; rewrite bn_carryS // !bnkS // /dig /= carryE bn_carryP //.
pose X:= (_ <= _)%Int.
have ->{X}: X = (W64.modulus-(to_uint x.[k]+to_uint y.[k]) 
              <= (bnk k x + bnk k y + b2i c)%/ W64.modulus^k) by smt.
by rewrite lez_divRL 1:expr_gt0 1:expr_gt0 1:// mulzDl -ler_subr_addr /=
           -exprS // /#.
qed.

op bn_borrow (k:int) (x y: t) (c:bool): bool =
 iteri k (fun i r=> to_uint x.[i] < to_uint y.[i] + b2i r) c.

lemma bn_borrow0 x y c: bn_borrow 0 x y c = c by rewrite /bn_borrow iteri0.

lemma bn_borrowS k x y c:
 0 <= k =>
 bn_borrow (k+1) x y c = (to_uint x.[k] < to_uint y.[k] + b2i (bn_borrow k x y c))
 by move=> *; rewrite /bn_borrow iteriS.

lemma bn_borrowP k x y c:
 0 <= k =>
 b2i (bn_borrow k x y c) = - (bnk k x - bnk k y - b2i c) %/ W64.modulus^k.
proof.
elim: k.
 by rewrite expr0 !bnk0 // bn_borrow0 /=. 
move=> k Hk IH; rewrite bn_borrowS // IH; clear IH.
pose X:= (_ < _)%Int.
have ->{X}: X = (bnk k x - bnk k y - b2i c) %/ W64.modulus ^ k < to_uint y.[k] - to_uint x.[k]
 by smt.
rewrite ltz_divLR 1:expr_gt0 1:expr_gt0 1:// mulzDl.
pose X:= (_ < _)%Int.
have ->{X}: X = bnk (k+1) x < bnk (k+1) y + b2i c.
 rewrite !bnkS // /dig /X /#.
pose X:= (_<_)%Int; case: X => E.
 rewrite b2i1.
 pose Y:= (_ - b2i c); rewrite (_: Y = (-1)*(W64.modulus ^ (k+1)) + (Y+W64.modulus^(k+1))) 1:/#.
 rewrite  divzMDl; first smt(expr_gt0). 
 rewrite divz_small //.
 by apply bound_abs; split => *; move: to_uint_cmp bnk_cmp; smt().
rewrite b2i0 eq_sym divz_small //.
apply bound_abs; split => *; first smt(exprS expr_gt0).
move: to_uint_cmp bnk_cmp; smt().
qed.

lemma bn_borrowE k x y c:
 0 <= k =>
 bn_borrow k x y c = (bnk k x < bnk k y + b2i c).
proof.
elim/natind: k => //=.
 by move=> n Hn1 Hn2; rewrite (_:n=0) 1:/# bn_borrow0 !bnk0 /#.
move=> k Hk IH {IH} H {H}; rewrite bn_borrowS // !bnkS // /dig /= bn_borrowP //.
pose X:= (_ < _)%Int.
have ->{X}: X = (bnk k x - bnk k y - b2i c) %/ W64.modulus ^ k < to_uint y.[k] - to_uint x.[k] by rewrite /X /#.
by rewrite ltz_divLR 1:expr_gt0 1:expr_gt0 1:// mulzDl /#.
qed.

(* Basic Ops. *)

module Ops = {
  (* set 0 *)
  proc set0R(): t = {
    var i: int;
    var r: t;
    r <- witness;
    i <- 0;
    while (i < nlimbs) {
      r.[i] <- W64.of_int 0;
      i <- i+1;
    }
    return r;
  }
      
  (* constant time selection t *)
  proc ctselR(cond: bool, a:t, b:t): t = {
    var i: int;
    var r: t;
    r <- witness;
    i <- 0;
    while (i < nlimbs) {
      r.[i] <- cond ? b.[i] : a.[i];
      i <- i+1;
    }
    return r;
  }

  (* copy R *)
  proc copyR(a:t): t = {
    var i: int;
    var r: t;
    r <- witness;
    i <- 0;
    while (i < nlimbs) {
      r.[i] <- a.[i];
      i <- i+1;
    }
    return r;
  }

  (* tests if is zero *)
  proc test0R(a:t): bool = {
    var zf, f0, f1, f2, f3, f4: bool;
    var i: int;
    var acc: W64.t;
    acc <- a.[0];
    i <- 1;
    while (i < nlimbs) {
      acc <- acc `|` a.[i];
      i <- i+1;
    }
    (f0, f1, f2, f3, zf, acc) <- ALU.AND_64 acc acc;
    return zf;
  }

  proc eqR(a b:t): bool = {
    var zf, f0, f1, f2, f3, f4: bool;
    var i: int;
    var t, acc: W64.t;
    acc <- W64.of_int 0;
    i <- 0;
    while (i < nlimbs) {
      t <- a.[i];
      t <- t `^` b.[i];
      acc <- acc `|` t;
      i <- i+1;
    }
    (f0, f1, f2, f3, zf, acc) <- ALU.AND_64 acc acc;
    return zf;
  }

  (* SHIFTS *)
  proc shl1R(a: t): bool * t = {
    var cf, f1, f2, f3, f4: bool;
    var r: t;
    var t;
    var i;
    r <- witness;
    (cf, f1, f2, f3, f4, t) <- SHIFT.SHL_64 a.[0] (JWord.W8.of_int 1);
    r.[0] <- t;
    i <- 1;
    while (i < nlimbs) {
      (f1, cf, t) <- SHIFT.RCL_64 a.[i] (JWord.W8.of_int 1) cf;
      r.[i] <- t;
      i <- i+1;
    }
    return (cf, r);
  }

  proc shr1R(a: t): bool * t = {
    var cf, f1, f2, f3, f4: bool;
    var r: t;
    var t;
    var i;
    r <- witness;
    (cf, f1, f2, f3, f4, t) <- SHIFT.SHR_64 a.[nlimbs-1] (JWord.W8.of_int 1);
    r.[nlimbs-1] <- t;
    i <- nlimbs-1;
    while (0 < i) {
      i <- i-1;
      (f1, cf, t) <- SHIFT.RCR_64 a.[i] (JWord.W8.of_int 1) cf;
      r.[i] <- t;
    }
    return (cf, r);
  }

  proc rcl1R(a: t, cf: bool): bool * t = {
    var f1, f2, f3, f4: bool;
    var r: t;
    var t;
    var i;
    r <- witness;
    i <- 0;
    while (i < nlimbs) {
      (f1, cf, t) <- SHIFT.RCL_64 a.[i] (JWord.W8.of_int 1) cf;
      r.[i] <- t;
      i <- i+1;
    }
    return (cf, r);
  }

  proc rcr1R(a: t, cf:bool): bool * t = {
    var f1, f2, f3, f4: bool;
    var r: t;
    var t;
    var i;
    (*r <@ set0R();*)
    r <- witness;
    i <- nlimbs;
    while (0 < i) {
      i <- i-1;
      (f1, cf, t) <- SHIFT.RCR_64 a.[i] (JWord.W8.of_int 1) cf;
      r.[i] <- t;
    }
    return (cf, r);
  }

  (* add digit and propagate carry *)
  proc add1R(a: t, b: W64.t, c: bool): bool*t = {
    var r: t;
    var i, x;
    r <- witness;
    (c, x) <- addc a.[0] b c;
    r.[0] <- x;
    i <- 1;
    while (i < nlimbs) {
      (c, x) <- addc a.[i] (W64.of_int 0) c;
      r.[i] <- x;
      i <- i + 1;
    }
    return (c,r);
  }

  (* addition *)
  proc addcR( a: t, b: t, c: bool): bool*t = {
    var r: t;
    var i, x;
    r <- witness;
    i <- 0;
    while (i < nlimbs) {
      (c, x) <- addc a.[i] b.[i] c;
      r.[i] <- x;
      i <- i + 1;
    }
    return (c,r);
  }

  (* subtract a word and propagate borrow *)
  proc sub1R( a: t, b: W64.t, c: bool): bool*t = {
    var rc: bool; 
    var r: t;
    var i, x;
    r <- witness;
    (c, x) <- subc a.[0] b c;
    r.[0] <- x;
    i <- 1;
    while (i < nlimbs) {
      (c, x) <- subc a.[i] (W64.of_int 0) c;
      r.[i] <- x;
      i <- i + 1;
    }
    return (c,r);
  }

  (* subtraction *)
  proc subcR( a: t, b: t, c: bool): bool*t = {
    var rc: bool; 
    var r: t;
    var i, x;
    r <- witness;
    i <- 0;
    while (i < nlimbs) {
      (c, x) <- subc a.[i] b.[i] c;
      r.[i] <- x;
      i <- i + 1;
    }
    return (c,r);
  }

  proc subcRcond( a: t, b:t): t = { (* r = a<b ? a : b-a *)
    var rc: bool;
    var r: t;
    (rc, r) <@ subcR( a, b, false);
    r <@ ctselR(rc, r, a);
    return r;
  }

}.

(* Specs... *)

lemma set0R_h:
  hoare [ Ops.set0R:
          true
          ==>
          bn res = 0
        ].
proof.
proc; while (0 <= i <= nlimbs /\ (forall j, 0 <= j < i => r.[j] = W64.zero)).
 by wp; skip; progress; [smt() | smt() | by rewrite get_setE => /#]. 
wp; skip; progress; [smt(gt0_nlimbs) | smt() |].
apply big1_seq => k; rewrite /predT mem_range /= => *.
by rewrite H2 /#.
qed.

lemma set0R_ll: islossless Ops.set0R.
proof.
proc; while (0 <= i <= nlimbs) (nlimbs-i).
 by move => z; wp; skip => /#.
by wp; skip; progress; smt(gt0_nlimbs).
qed.

lemma set0R_ph:
 phoare [ Ops.set0R:
          true
          ==>
          bn res = 0
        ] = 1%r.
proof. by conseq set0R_ll set0R_h. qed.

lemma ctselR_h cc aa bb:
  hoare [ Ops.ctselR:
          cc = cond /\ aa = a /\ bb = b
          ==>
          res = if cc then bb else aa
        ].
proof.
proc => //=. 
while (0 <= i <= nlimbs /\ cc = cond /\ aa = a /\ bb = b /\
       forall j, 0 <= j < i => r.[j] = if cc then b.[j] else a.[j]).
 by wp; skip; progress; [smt() | smt() | rewrite get_setE => /#]. 
wp; skip; progress; first 2 smt(gt0_nlimbs).  
by rewrite tP /#.
qed.

lemma ctselR_ll: islossless Ops.ctselR.
proof.
proc; while (0 <= i <= nlimbs) (nlimbs-i).
 by move => z; wp; skip => /#.
by wp; skip; progress; smt(gt0_nlimbs).
qed.

lemma ctselR_ph cc aa bb:
 phoare [ Ops.ctselR:
          cc = cond /\ aa = a /\ bb = b
          ==>
          res = if cc then bb else aa
        ] = 1%r.
proof. by conseq ctselR_ll (ctselR_h cc aa bb). qed.

lemma copyR_h aa:
  hoare [ Ops.copyR:
          aa = a
          ==>
          res = aa
        ].
proof.
proc; while (0 <= i <= nlimbs /\ aa = a /\ (forall j, 0 <= j < i => r.[j] = aa.[j])).
 by wp; skip; progress; [smt() | smt() | rewrite get_setE => /#]. 
wp; skip; progress; first 2 smt(gt0_nlimbs).  
by rewrite tP /#.
qed.

lemma copyR_ll: islossless Ops.copyR.
proof.
proc; while (0 <= i <= nlimbs) (nlimbs-i).
 by move => z; wp; skip => /#.
by wp; skip; progress; smt(gt0_nlimbs). 
qed.

lemma copyR_ph aa:
 phoare [ Ops.copyR:
          aa = a
          ==>
          res = aa
        ] = 1%r.
proof. by conseq copyR_ll (copyR_h aa). qed.

(* COMPARISONS *)

lemma orw_eq0 w1 w2:
 W64.orw w1 w2 = W64.zero <=> w1=W64.zero /\ w2=W64.zero.
proof.
split.
 case: (w1=W64.zero) => [E|E].
  by rewrite E or0w.
 move=> H /=.
 have := ule_orw w1 w2; rewrite H uleE to_uint0.
 smt.
by move=> [-> ->]; rewrite or0w.
qed.

lemma xorw_eq0 (w1 w2: W64.t):
 w1 +^ w2 = W64.zero <=> w1=w2.
proof.
split => H.
 move/wordP: H => H.
 apply wordP => i Hi.
 move: (H i Hi).
 by rewrite xorE /map2 initiE 1:/# /= /#.
by rewrite H xorwK.
qed.

lemma bnkS_eq0 k x:
 0 <= k => bnk (k+1) x = 0 =>
 to_uint x.[k] = 0 /\ bnk k x = 0.
proof. 
move=> Hk; rewrite bnkS 1:/# /=.
smt.
qed.

lemma bnkS_eq k x y:
 0 <= k => bnk (k+1) x = bnk (k+1) y =>
 x.[k] = y.[k] /\ bnk k x = bnk k y.
proof. 
move=> Hk; rewrite !bnkS 1..2:/# /=.
smt.
qed.

lemma test0R_h aa:
  hoare [ Ops.test0R:
          aa = a
          ==>
          res = (bn aa = 0)
        ].
proof.
proc.
wp; while ( #pre /\ 0 <= i <= nlimbs /\ ((acc = W64.zero) <=> (bnk i a = 0))).
 wp; skip => /> &hr; progress. smt(). smt().
 move: H3; rewrite orw_eq0 => [[E1 E2]].
 by rewrite bnkS 1:/# /= E2 to_uint0 /= -H1 E1.
 move: (bnkS_eq0 _ _ H H3) => {H3} [H31 H32].
 by rewrite orw_eq0 H1 H32 /= to_uint_eq /#.
wp; skip => />; progress. smt(gt0_nlimbs).
by rewrite bnk1 /= H to_uint0.
move: H; rewrite bnk1 /= expr0 /=. smt.
move: H2; rewrite (_:i0=nlimbs) 1:/# => <-.
by rewrite /ALU.AND_64 /#.
qed.

lemma test0R_ll: islossless Ops.test0R.
proof.
proc; wp; while true (nlimbs-i).
 by move=> *; wp; skip => /#.
wp; skip => /#.
qed.

lemma test0R_ph aa:
 phoare [ Ops.test0R:
          aa = a
          ==>
          res = (bn aa = 0)
        ] = 1%r.
proof. by conseq test0R_ll (test0R_h aa). qed.

lemma eqR_h aa bb:
  hoare [ Ops.eqR:
          aa = a /\ bb = b
          ==>
          res = (aa = bb)
        ].
proof.
proc; simplify. 
wp; while ( #pre /\ 0 <= i <= nlimbs /\ ((acc = W64.zero) <=> (bnk i a = bnk i b))).
 wp; skip => /> &hr Hi1 Hi2 [HL HR] Hi3.
 split; first smt().
 split.
  rewrite orw_eq0 xorw_eq0; move => [E1 E2].
  by rewrite !bnkS 1..2:/# /= E2 (HL E1) /#.
 move => /(bnkS_eq _ _ _ Hi1) [E1 E2].
 by rewrite orw_eq0 (HR E2) E1.
wp; skip; progress; first 2 smt(gt0_nlimbs bnk0).
move: H2; rewrite (_:i0=nlimbs) 1:/# => H2.
rewrite /AND_XX /rflags_of_bwop_w /flags_w /rflags_of_bwop /ZF_of /=.
case: (acc0 = W64.zero).
 rewrite H2; move=> /bn_inj E /=.
 by rewrite /AND_64 /bflags_of_bwop /rflags_of_bwop_w /flags_w /rflags_of_bwop /ZF_of /= E H2 E.
rewrite H2 => ?.
by rewrite /AND_64 /rflags_of_bwop_w /flags_w /rflags_of_bwop /ZF_of /= H2 /#.
qed.

lemma eqR_ll: islossless Ops.eqR.
proof.
proc; wp; while true (nlimbs-i).
 by move=> *; wp; skip => /#.
wp; skip => /#.
qed.

lemma eqR_ph aa bb:
 phoare [ Ops.eqR:
          aa = a /\ bb = b
          ==>
          res = (aa = bb)
        ] = 1%r.
proof. by conseq eqR_ll (eqR_h aa bb). qed.


(* bn from digit *)
op bn_digit (w: W64.t) : t = A.init (fun k => if k=0 then w else W64.zero). 
lemma bn_digit0 w : (bn_digit w).[0] = w.
proof. by rewrite /bn_digit initE /=; smt(gt0_nlimbs). qed.
lemma bn_digitS w i : 1 <= i < nlimbs => (bn_digit w).[i] = W64.zerow.
proof. by rewrite /bn_digit initE /#. qed.

lemma bnkup_digit w: bnkup 1 (bn_digit w) = 0.
proof.
rewrite /bnkup.
apply big1_seq => /> i _ /mem_range Hi /=.
by rewrite /bn_digit initE (_:0 <= i && i < nlimbs) 1:/# /= (_:!i=0) 1:/# /=.
qed.

lemma bn_digit (w : W64.t) : bn (bn_digit w) = to_uint w.
proof.
rewrite (bn_k_kup 1); first smt(gt0_nlimbs).
by rewrite bnk1 /= expr0 /= bn_digit0 bnkup_digit.
qed.

lemma mod_sub x y b m : 
  0 <= m =>
  0 <= x < m =>
  0 <= y < m =>
  m <= x + y + b2i b =>
  0 <= x + y + b2i b - m < m.
proof. by smt(). qed.

lemma add1R_h aa bb cc:
  hoare [ Ops.add1R:
          aa = a /\ bb = b /\ cc = c
          ==>
          res.`1 = (bn_modulus <= bn aa + to_uint bb + b2i cc)
          /\ bn res.`2 = (bn aa + W64.to_uint bb + b2i cc) %% bn_modulus
        ].
proof.
have Hlimbs:= gt0_nlimbs; proc; simplify.
while (1 <= i <= nlimbs /\ aa = a /\ bb = b /\
       c = bn_carry i aa (bn_digit bb) cc /\
       bnk i r = bnk i aa + to_uint bb + b2i cc - b2i c * W64.modulus^i).
 wp; skip => &hr [[[H H0]]] /> H1 H2.
 split; [smt() | split].
  by rewrite addcE !bn_carryS /= 1:/# carryE /carry_add /= bn_digitS // to_uint0 /=.
 rewrite !bnkS /= 1..2:/# get_setE 1:/# /= bnk_setO 1:/# H1.
 by rewrite addcP' !exprS 1:/# carryE addcE /carry_add /=; ring.
wp; skip => /> .
split.
 split; first by smt().
 split.
  by rewrite (_: 1 = 0 + 1) // bn_carryS // bn_carry0 bn_digit0 carryE addcE /= /carry_add.
 rewrite (_: 1 = 0 + 1) // !bnkS //= !bnk0 //= get_setE 1:/# //=.
 by rewrite addcP' addcE carryE /carry_add /= expr0.
move => j dd Hj1 Hj2 Hj3 Hwsize; split.
 by rewrite (_ : j = nlimbs) 1:/# bn_carryE 1:/# bn_modulusE bn_digit.
move: Hwsize; rewrite (_:j = nlimbs) 1:/# => ->.
have Hwsize:= W64.ge0_size.
pose X:= (bn_carry _ _ _ _); case: X; rewrite /X => {X} H.
 rewrite b2i1 -(modzMDr (-1)) bn_modulusE /= modz_small.
  rewrite ger0_norm; first smt(expr_gt0).
  have ->/=: bnk nlimbs aa + to_uint bb + b2i cc + (-1) * W64.modulus ^ nlimbs = bnk nlimbs aa + to_uint bb + b2i cc + -1 * W64.modulus ^ nlimbs by smt().
  apply mod_sub.
  - by smt(expr_gt0).
  - by move: bnk_cmp; smt().
  - split => *; first smt(to_uint_cmp).
    by move: to_uint_cmp ler_eexpr; smt().
  - by move: H; rewrite bn_carryE 1:/# bn_digit /#.
 by smt().
rewrite b2i0 bn_modulusE -exprM /=.
move: H; rewrite /X bn_carryE 1:/# => H.
rewrite modz_small // ger0_norm; first smt(expr_gt0).
split => *; first move: to_uint_cmp bnk_cmp; smt().
by rewrite exprM; rewrite bn_digit -ltzNge in H.
qed.

lemma add1R_ll: islossless Ops.add1R.
proof.
proc; while (1 <= i <= nlimbs) (nlimbs-i).
 by move => z; wp; skip => /> /#.
by wp; skip => />; smt(gt0_nlimbs).
qed.

lemma add1R_ph aa bb cc:
 phoare [ Ops.add1R:
          aa = a /\ bb = b /\ cc = c
          ==>
          res.`1 = (bn_modulus <= bn aa + to_uint bb + b2i cc)
          /\ bn res.`2 = (bn aa + W64.to_uint bb + b2i cc) %% bn_modulus
        ] = 1%r.
proof. by conseq add1R_ll (add1R_h aa bb cc). qed.

lemma addcR_h aa bb cc:
  hoare [ Ops.addcR:
          aa = a /\ bb = b /\ cc = c
          ==>
          res.`1 = bn_carry nlimbs aa bb cc
          /\ bn res.`2 = (bn aa + bn bb + b2i cc) %% bn_modulus
        ].
proof.
proc => /=.
while (0 <= i <= nlimbs /\ a = aa /\ b = bb /\
       c = bn_carry i aa bb cc /\
       bnk i r = bnk i aa + bnk i bb + b2i cc - b2i c * W64.modulus^i).
 wp; skip => &hr [[[H H0]]] /> H1 H2.
 split; first smt().
 split.
  by rewrite addcE !bn_carryS /= // carryE.
 rewrite !bnkS // !digE get_setE //= bnk_setO 1:/# H1.
 by rewrite addcP' !exprS // carryE addcE /carry_add /=; ring.
wp; skip => />; progress.
- by smt( gt0_nlimbs).
- by rewrite bn_carry0.
- by rewrite !bnk0 // expr0 /#.
- smt().
- move: H2; rewrite (_:i0 = nlimbs) 1:/# => ->.
  have ?:= W64.ge0_size.
  pose X:= (bn_carry _ _ _ _); case: X; rewrite /X bn_carryE 1:/# => E.
   rewrite b2i1 -(modzMDr (-1)) bn_modulusE /= modz_small 2:/# /=.
   smt. (*bnk_cmp exprM*)
  rewrite b2i0 bn_modulusE /= modz_small //.
  smt. (*bnk_cmp exprM*)
qed.

lemma addcR_ll: islossless Ops.addcR.
proof.
proc; while true (nlimbs-i) => *.
 wp; skip; progress; smt().
wp; skip; progress; smt().
qed.

lemma addcR_ph aa bb cc:
 phoare [ Ops.addcR:
          aa = a /\ bb = b /\ cc = c
          ==>
          res.`1 = bn_carry nlimbs aa bb cc
          /\ bn res.`2 = (bn aa + bn bb + b2i cc) %% bn_modulus
        ] = 1%r.
proof. by conseq addcR_ll (addcR_h aa bb cc). qed.

lemma mod_add x y b m :
  0 <= m =>
  0 <= x < m =>
  0 <= y < m =>
  x < y + b2i b =>
  0 <= x - (y + b2i b) + m < m.
proof. by smt(). qed.

lemma sub1R_h aa bb cc:
  hoare [ Ops.sub1R:
          aa = a /\ bb = b /\ cc = c
          ==>
          res.`1 = (bn aa < W64.to_uint bb + b2i cc)
          /\ bn res.`2 = (bn aa - (W64.to_uint bb + b2i cc)) %% bn_modulus
        ].
proof.
have Hlimbs:= gt0_nlimbs; proc; simplify.
while (1 <= i <= nlimbs /\ aa = a /\ bb = b /\
       c = bn_borrow i aa (bn_digit bb) cc /\
       bnk i r = bnk i aa - to_uint bb - b2i cc + b2i c * W64.modulus^i).
 wp; skip => &hr [[[H H0]]] /> H1 H2.
 split; [smt() | split].
  by rewrite subcE !bn_borrowS /= 1:/# /borrow_sub /= bn_digitS // to_uint0 /=.
 rewrite !bnkS /= 1..2:/# get_setE 1:/# /= bnk_setO 1:/# H1.
 by rewrite subcP' !exprS 1:/# borrowE subcE /borrow_sub /=; ring.
wp; skip => /> .
split.
 split; first by smt().
 split.
  by rewrite (_: 1 = 0 + 1) // bn_borrowS // bn_borrow0 bn_digit0 subcE /= /borrow_add.
 rewrite (_: 1 = 0 + 1) // !bnkS //= !bnk0 //= get_setE 1:/# //=.
 by rewrite subcP' subcE borrowE /borrow_sub /= expr0.
move => j dd Hj1 Hj2 Hj3 Hwsize; split.
 by rewrite (_ : j = nlimbs) 1:/# bn_borrowE 1:/# bn_digit.
move: Hwsize; rewrite (_:j = nlimbs) 1:/# => ->.
have Hwsize:= W64.ge0_size.
pose X:= (bn_borrow _ _ _ _); case: X; rewrite /X => {X} H.
 rewrite b2i1 -(modzMDr (1)) bn_modulusE modz_small 2:/#.
 rewrite ger0_norm /=; first smt(expr_gt0).
 rewrite mod_add //=.
 - by smt(expr_gt0).
 - by move: bnk_cmp; smt().
 - split => *; first smt(to_uint_cmp).
   by move: to_uint_cmp ler_eexpr; smt().
 - by move: H; rewrite bn_borrowE 1:/# bn_digit /#.
rewrite b2i0 bn_modulusE /=. 
move: H; rewrite /X bn_borrowE 1:/# => H.
rewrite modz_small //; last smt().
apply bound_abs; rewrite bn_digit -lezNgt in H.
split => *; move: to_uint_cmp bnk_cmp; smt().
qed.

lemma sub1R_ll: islossless Ops.sub1R.
proof.
  proc; while (1 <= i <= nlimbs) (nlimbs-i).
    by move => z; wp; skip => /> /#.
  by wp; skip => />; smt(gt0_nlimbs).
qed.

lemma sub1R_ph aa bb cc:
 phoare [ Ops.sub1R:
          aa = a /\ bb = b /\ cc = c
          ==>
          res.`1 = (bn aa < W64.to_uint bb + b2i cc)
          /\ bn res.`2 = (bn aa - (W64.to_uint bb + b2i cc)) %% bn_modulus
        ] = 1%r.
proof. by conseq sub1R_ll (sub1R_h aa bb cc). qed.

lemma subcR_h aa bb cc:
  hoare [ Ops.subcR:
          aa = a /\ bb = b /\ cc = c
          ==>
          res.`1 = bn_borrow nlimbs aa bb cc
          /\ bn res.`2 = (bn aa - (bn bb + b2i cc)) %% bn_modulus 
        ].
proof.
proc; while (0 <= i <= nlimbs /\ aa = a /\ bb = b /\
             c = bn_borrow i aa bb cc /\
             bnk i r = bnk i aa - (bnk i bb + b2i cc) + b2i c * W64.modulus^i).
 wp; skip => &hr [[[H H0]]] /> H1 H2.
 split; [smt() | split].
  by rewrite subcE !bn_borrowS /= 1:/# /borrow_sub /= // to_uint0 /=.
 rewrite !bnkS /= 1..3:/# // get_setE 1:/# /= bnk_setO 1:/# H1. 
 by rewrite subcP' !exprS 1:/# borrowE subcE /borrow_sub /=; ring.
wp; skip => />; split.
 split; first by smt(gt0_nlimbs).
 split; first by rewrite bn_borrow0.
 by rewrite !bnk0 //= expr0.
move => j xx H H0 H1 H2; split.
 by rewrite (_ : j = nlimbs) 1:/# bn_borrowE 1:/#.
move: H2; rewrite (_:j = nlimbs) 1:/# => ->.
have ?:= W64.ge0_size.
pose X:= (bn_borrow _ _ _ _); case: X; rewrite /X bn_borrowE 1:/# => E.
 rewrite b2i1 -(modzMDr (1)) bn_modulusE modz_small.
 rewrite ger0_norm; first smt(expr_gt0).
 have ->: bnk nlimbs aa - (bnk nlimbs bb + b2i cc) + 1 * W64.modulus ^ nlimbs = bnk nlimbs aa - (bnk nlimbs bb + b2i cc) + W64.modulus ^ nlimbs by smt(). 
 rewrite mod_add //=.
 - by smt(expr_gt0).
 - by move: bnk_cmp; smt().
 - by move: bnk_cmp; smt().
 - by done.
by rewrite b2i0 bn_modulusE modz_small //; case (cc); move: bnk_cmp; smt().
qed.

lemma subcR_ll: islossless Ops.subcR.
proof.
proc; while (0 <= i <= nlimbs) (nlimbs-i).
 by move => z; wp; skip => /> /#.
by wp; skip => />; smt(gt0_nlimbs).
qed.

lemma subcR_ph aa bb cc:
 phoare [ Ops.subcR:
          aa = a /\ bb = b /\ cc = c
          ==>
          res.`1 = bn_borrow nlimbs aa bb cc
          /\ bn res.`2 = (bn aa - (bn bb + b2i cc)) %% bn_modulus 
        ] = 1%r.
proof. by conseq subcR_ll (subcR_h aa bb cc). qed.

lemma subcRcond_h aa bb:
  hoare [ Ops.subcRcond:
          aa = a /\ bb = b
          ==>
          bn res = if bn aa < bn bb then bn aa else bn aa - bn bb
        ].
proof.
proc.
seq 1 : (#pre /\ rc = bn_borrow nlimbs aa bb false /\ 
         bnk nlimbs r = (bnk nlimbs aa - (bnk nlimbs bb)) %% bn_modulus).
 by call (subcR_h aa bb false); skip => />.
exists* r; elim* => r'.
call (ctselR_h (bn_borrow nlimbs aa bb false) r' aa).
skip => /> => E *.
have ?:= gt0_nlimbs.
pose X:= (bn_borrow _ _ _ _); case: X; rewrite /X bn_borrowE 1:/# b2i0 /= => C //=; rewrite C //=.
rewrite E modz_small //.
rewrite ger0_norm; first smt(expr_gt0).
split => *; first smt(bnk_cmp).
rewrite /bn_modulus; move: bnk_cmp; smt().
qed.

lemma subcRcond_ll: islossless Ops.subcRcond.
proof. by proc; call ctselR_ll; call subcR_ll; skip; progress. qed.

lemma subcRcond_ph aa bb:
 phoare [ Ops.subcRcond:
          aa = a /\ bb = b
          ==>
          bn res = if bn aa < bn bb then bn aa else bn aa - bn bb
        ] = 1%r.
proof. by conseq subcRcond_ll (subcRcond_h aa bb). qed.

end BN.


abstract theory BigNum.

(*(* Words *)
op wsize : int.
axiom gt0_wsize: 0 < wsize.
clone import WordExt with
  op size <- wsize
  proof gt0_size by apply gt0_wsize.
*)
import W64.

(** Number of limbs *)
op nlimbs : int.
axiom gt0_nlimbs: 0 < nlimbs.

clone BN as R with
(*  op wsize <- wsize,*)
  op nlimbs <- nlimbs
(*  theory Word.W <- W*)
(*  proof gt0_wsize by apply gt0_wsize*)
  proof gt0_nlimbs by apply gt0_nlimbs.

clone BN as R2 with
(*  op wsize <- wsize,*)
  op nlimbs <- 2*nlimbs
(*  theory Word.W <- W
  proof gt0_wsize by apply gt0_wsize*)
  proof gt0_nlimbs by (apply mulr_gt0 => //; apply gt0_nlimbs).

import R2 R (*WordExt.*).

(*
type R = R.t.
type R2 = R2.t.
*)
(*type W = WordExt.W.t.*)

abbrev modulusR = R.bn_modulus.
abbrev modulusR2 = R2.bn_modulus.
abbrev valR x = R.bn x.
abbrev valR2 x = R2.bn x.

clone import PolyArray as Array3 with op size <- 3.

abbrev MULhi a b = (W64.mulu a b).`1.
abbrev MULlo a b = (W64.mulu a b).`2.

lemma muluP a b:
 to_uint (MULlo a b)
 = to_uint a * to_uint b - to_uint (MULhi a b) * W64.modulus.
proof. by rewrite -mulhiP /mulu /=; ring. qed.

abbrev ADDC a b c = (W64.addc a b c).`2.
abbrev ADDcarry a b c = (W64.addc a b c).`1.
abbrev M = W64.modulus.

lemma addcPP a b c:
 to_uint (ADDC a b c)
 = to_uint a + to_uint b + b2i c
   - b2i (ADDcarry a b c) * W64.modulus.
proof.
by rewrite addcP' /addc /= /carry_add carryE; ring.
qed.


op valAcc (b: int) (x: W64.t Array3.t) : int =
 to_uint x.[b%%3]
 + to_uint x.[(b+1)%%3] * W64.modulus
 + to_uint x.[(b+2)%%3] * W64.modulus^2.

lemma valAccS k (a: W64.t Array3.t):
  valAcc (k + 1) a.[k %% 3 <- W64.zero] = (valAcc k a) %/ W64.modulus.
proof.
rewrite /valAcc /= modzDr !get_setE 1..3:/# /=.
have E: forall x, x <> 0 => 0 <= x < 3 =>
         ((k + x) %% 3 <> (k %% 3)) by smt().
rewrite !E // expr0 -addzA mulr1 -mulzA -mulzDl /= divzMDr //.
by rewrite divz_small; move: to_uint_cmp; smt().
qed.

lemma valAcc_mod k (a: W64.t Array3.t):
  (valAcc k a) %% W64.modulus = to_uint a.[k%%3].
proof.
rewrite /valAcc -addzA (_:W64.modulus^2=W64.modulus*W64.modulus).
 by rewrite expr2.
rewrite -mulzA -mulzDl -modzDm modzMl /=.
rewrite modz_mod modz_small; move: to_uint_cmp; smt().
qed.

module MulOps = {
  proc packR2(a b: R.t): R2.t = {
    var i: int;
    var r: R2.t;
    r <- witness;
    i <- 0;
    while (i < nlimbs) {
      r.[i] <- a.[i];
      i <- i + 1;
    }
    i <- 0;
    while (i < nlimbs) {
      r.[i+nlimbs] <- b.[i];
      i <- i+1;
    }
    return r;
  }
  proc unpackR2(a: R2.t): R.t*R.t = {
    var i: int;
    var lo, hi: R.t;
    lo <- witness;
    hi <- witness;
    i <- 0;
    while (i < nlimbs) {
      lo.[i] <- a.[i];
      i <- i + 1;
    }
    i <- 0;
    while (i < nlimbs) {
      hi.[i] <- a.[i+nlimbs];
      i <- i + 1;
    }
    return (hi, lo);
  }
  (* multiplication by a scalar (operand scanning, using two
     addition-chains)
     ensures: (of, cf, rR2) = (false, false, akW * bR) *)
  proc mul1( ak: W64.t, b: R.t): bool * bool * R2.t = {
    var i;
    var _cf, _of: bool;
    var hi, lo, tmp: W64.t;
    var r: R2.t;
    r <- witness;
    _of <- false;
    _cf <- false;
    (hi, lo) <-  mulu ak b.[0];
    r.[0] <- lo;
    r.[1] <- hi;
    i <- 1;
    while (i < nlimbs) {
      (hi,lo) <- mulu ak b.[i];
      (_cf, tmp) <- addc r.[i] lo _cf;
      r.[i] <- tmp;
      r.[i+1] <- hi;
      i <- i+1;
    }
    (_cf, tmp) <- addc r.[nlimbs] (W64.of_int 0) _cf;
    r.[nlimbs] <- tmp;
    return (_of, _cf, r);
  }

  (* multiply by a scalar and accumulate *)
  proc mul1acc( k: int, a : W64.t, b: R.t, x: R2.t, _of _cf: bool): bool*bool*R2.t = {
    var i;
    var hi, lo, tmp: W64.t;
    i <- 0;
    while (i < nlimbs-1) {
      (hi,lo) <- mulu a b.[i];
      (_of, tmp) <- addc x.[k+i] lo _of;
      x.[k+i] <- tmp;
      (_cf, tmp) <- addc x.[k+i+1] hi _cf;
      x.[k+i+1] <- tmp;
      i <- i+1;
    }
    (hi,lo) <- mulu a b.[nlimbs-1];
    x.[k+nlimbs] <- hi;
    (_of, tmp) <- addc x.[k+nlimbs-1] lo _of;
    x.[k+nlimbs-1] <- tmp;
    (_cf, tmp) <- addc x.[k+nlimbs] (W64.of_int 0) _cf;
    x.[k+nlimbs] <- tmp;
    (_of, tmp) <- addc x.[k+nlimbs] (W64.of_int 0) _of;
    x.[k+nlimbs] <- tmp;
    return (_of, _cf, x);
  }
  proc mulR(a b: R.t): bool * bool * R2.t = {
    var k:int;
    var _cf, _of: bool;
    var r: R2.t;
    var ak: W64.t;
    (_of, _cf, r) <@ mul1(a.[0], b);
    k <- 1;
    while (k < nlimbs) {
      (_of, _cf, r) <@ mul1acc(k, a.[k], b, r, _of, _cf);
      k <- k+1;
    }
    return (_of,_cf,r);
  }
  (* multiplication -- product scanning *)
  proc addacc3(b1 b0: W64.t, a: W64.t Array3.t, k:int) : W64.t Array3.t = { 
    (* res = (a2,a1,a0) + x*y *)
    var cf;
    (cf, b0) <- addc a.[k %% 3] b0 false;
    a.[k %% 3] <- b0;
    (cf, b0) <- addc a.[(k+1) %% 3] b1 cf;
    a.[(k+1) %% 3] <- b0;
    (cf, b0) <- addc a.[(k+2) %% 3] (W64.of_int 0) cf;
    a.[(k+2) %% 3] <- b0;
    return a;
  }
  proc mulRcomba_innerloop ( k i i2: int,
                             a b:R.t,
                             x: W64.t Array3.t )
                           : W64.t Array3.t = {
    var t1, t0;
    var cf: bool;
    var j: int;
    while (i < i2) {
      j <- k-i;
      (t1,t0) <- mulu a.[i] b.[j];
      x <@ addacc3(t1, t0, x, k);
      i <- i + 1;
    }
    return x;
  }
  proc mulRcomba( a: R.t, b: R.t): R2.t = {
    var r: R2.t;
    var x: W64.t Array3.t;
    var k;
    r <- witness;
    x <- witness;
    x.[0] <- W64.of_int 0;
    x.[1] <- W64.of_int 0;
    x.[2] <- W64.of_int 0;
    k <- 0;
    while (k < nlimbs) {
      x <@ mulRcomba_innerloop(k,0,k+1,a,b,x);
      r.[k] <- x.[k%%3];
      x.[k%%3] <- W64.of_int 0;
      k <- k + 1;
    }
    while (k < 2*nlimbs-1) {
      x <@ mulRcomba_innerloop(k,k-nlimbs+1,nlimbs,a,b,x);
      r.[k] <- x.[k%%3];
      x.[k%%3] <- W64.of_int 0;
      k <- k + 1;
    }
    r.[2*nlimbs-1] <- x.[(2*nlimbs-1)%%3];
    return r;
  }
  proc muladdacc3x2(x y: W64.t, a: W64.t Array3.t, k:int) : W64.t Array3.t = { 
    var cf, f1, f2, f3, f4: bool;
    var b2, b1, b0;
    (b1, b0) <- mulu x y;
    b2 <- W64.of_int 0;
    (f1, cf, f2, f3, f4, b0) <- SHIFT.SHL_64 b0 (JWord.W8.of_int 1);
    (cf, f1, b1) <- SHIFT.RCL_64 b1 (JWord.W8.of_int 1) cf;
    (cf, b2) <- addc b2 b2 cf;

    (cf, b0) <- addc a.[k %% 3] b0 false;
    a.[k %% 3] <- b0;
    (cf, b0) <- addc a.[(k+1) %% 3] b1 cf;
    a.[(k+1) %% 3] <- b0;
    (cf, b0) <- addc a.[(k+2) %% 3] b2 cf;
    a.[(k+2) %% 3] <- b0;
    return a;
  }
  proc sqrRcomba_innerloop ( k i i2: int,
                             a: R.t,
                             x: W64.t Array3.t )
                           : W64.t Array3.t = {
    var cf: bool;
    var j: int;
    while (i < i2) {
      j <- k-i;
      x <@ muladdacc3x2(a.[i], a.[j], x, k);
      i <- i + 1;
    }
    return x;
  }
  proc sqrRcomba( a: R.t): R2.t = {
    var r: R2.t;
    var x: W64.t Array3.t;
    var t1, t0;
    var k;
    r <- witness;
    x <- witness;
    x.[0] <- W64.of_int 0;
    x.[1] <- W64.of_int 0;
    x.[2] <- W64.of_int 0;
    k <- 0;
    while (k < nlimbs) {
      x <@ sqrRcomba_innerloop(k,0,(k+1)%/2,a,x);
      if (k %% 2 = 0) {
        (t1, t0) <- mulu a.[k%/2] a.[k%/2];
        x <@ addacc3(t1, t0, x, k);
      }
      r.[k] <- x.[k%%3];
      x.[k%%3] <- W64.of_int 0;
      k <- k + 1;
    }
    while (k < 2*nlimbs-1) {
      x <@ sqrRcomba_innerloop(k,k-nlimbs+1,(k+1)%/2,a,x);
      if (k %% 2 = 0) {
        (t1, t0) <- mulu a.[k%/2] a.[k%/2];
        x <@ addacc3(t1, t0, x, k);
      }
      r.[k] <- x.[k%%3];
      x.[k%%3] <- W64.of_int 0;
      k <- k + 1;
    }
    r.[k] <- x.[k%%3];
    return r;
  }

(* (wInv * modulus) %% P = 1   --- obs: rInv = wInv^nlimbs  
   (n' * n) %% modulus = (-1) %% modulus 
https://iacr.org/archive/ches2005/006.pdf (page 13)
*)
  proc redmRcomba(p0Inv: W64.t, p: R.t, x: R2.t): R.t = {
    var m, r: R.t;
    var a: W64.t Array3.t;
    var i, t1, t0;
    i <- 0;
    m <- witness;
    r <- witness;
    a <- witness;
    a.[0] <- W64.of_int 0;
    a.[1] <- W64.of_int 0;
    a.[2] <- W64.of_int 0;
    while (i < nlimbs) {
      a <@ mulRcomba_innerloop(i, 0, i, m, p, a);
      a <@ addacc3(W64.of_int 0, x.[i], a, i);
      m.[i] <- a.[i %% 3] * p0Inv;
      (t1, t0) <- mulu m.[i] p.[0];
      a <@ addacc3(t1, t0, a, i);
      (* FACT: a.[i %% 3] = 0 *)
      i <- i+1;
    }
    while (i < 2*nlimbs - 1) {
      a <@ mulRcomba_innerloop(i,i-nlimbs+1,nlimbs,m,p,a);
      a <@ addacc3(W64.of_int 0, x.[i], a, i);
      r.[i-nlimbs] <- a.[i%%3];
      a.[i%%3] <- W64.of_int 0;
      i <- i + 1;
    }
    a <@ addacc3(W64.of_int 0, x.[2*nlimbs-1], a, 2*nlimbs-1);   
    r.[nlimbs-1] <- a.[(2*nlimbs-1) %% 3];
    r <@ R.Ops.subcRcond(r, p);
    return r;
  }

  proc mulmRcomba(p0Inv: W64.t, p: R.t, a b: R.t): R.t = {
    var x: R2.t;
    var r: R.t;
    x <@ mulRcomba(a, b);
    r <@ redmRcomba(p0Inv, p, x);
    return r;
  }

  proc sqrmRcomba(p0Inv: W64.t, p: R.t, a: R.t): R.t = {
    var x: R2.t;
    var r: R.t;
    x <@ sqrRcomba(a);
    r <@ redmRcomba(p0Inv, p, x);
    return r;
  }

  proc expm1Rcomba(p0Inv: W64.t, p: R.t,
                   x y: R.t, t:W64.t): R.t * R.t = {
    var cf, f1, f2, f3, f4: bool;
    var k: int;
    k <- 0;
    while (k < W64.size) {
      (f1, cf, f2, f3, f4, t) <- SHIFT.SHR_64 t (JWord.W8.of_int 1);
      if (cf) {
        y <@ mulmRcomba(p0Inv, p, x, y);
      }
      x <@ sqrmRcomba(p0Inv, p, x);
      k <- k+1;
    }
    return (x,y);
  }

  proc expmRcomba (p0Inv: W64.t, p oneM: R.t,
                   a b:R.t): R.t = {
    var x, y, j;
    x <- a;
    y <- oneM;
    j <- 0;
    while (j < nlimbs) {
      (x,y) <@ expm1Rcomba(p0Inv, p, x, y, b.[j]);
      j <- j+1;
    }
    return y;
  }
}.


(* COMBA LEMMAS... *)

op allpairs_comba1 nlimbs = 
 flatten (map (fun s => (map (fun x => (s,x)) (range 0 (s+1))))
              (range 0 nlimbs)).
 
lemma mem_allpairs_comba1 nlimbs x:
 x \in allpairs_comba1 nlimbs
 <=> x.`1 \in range 0 nlimbs /\ x.`2 \in range 0 (x.`1 + 1).
proof.
rewrite /allpairs_comba1 -flatten_mapP; split.
 move=> [y]; rewrite !mem_range => /> ??; rewrite mapP => [[?]].
 by rewrite !mem_range /= => /> * /#.
rewrite !mem_range => /> *.
exists (x.`1).
rewrite !mem_range; split; first smt().
rewrite mapP /=; exists x.`2.
by rewrite mem_range /#.
qed.

lemma uniq_allpairs_comba1 nlimbs: uniq (allpairs_comba1 nlimbs).
proof.
apply uniq_flatten_map.
  move=> x /=; rewrite map_inj_in_uniq.
   by move => y z; rewrite !mem_range /#.
  by apply range_uniq.
 move => y z; rewrite !mem_range => ?? /hasP [[??]].
 rewrite !mapP; move=> [[?][]]; rewrite mem_range /= => ?[??] []?.
 by rewrite mem_range => />.
by apply range_uniq.
qed.

op allpairs_comba2 nlimbs = 
 flatten (map (fun s => (map (fun x => (s,x)) (range (1+s-nlimbs) nlimbs)))
              (range nlimbs (2*nlimbs))).
 
lemma mem_allpairs_comba2 nlimbs x:
 x \in allpairs_comba2 nlimbs
 <=> x.`1 \in range nlimbs (2*nlimbs)
     /\ x.`2 \in range (x.`1 + 1 - nlimbs) nlimbs.
proof.
rewrite /allpairs_comba2 -flatten_mapP; split.
 move=> [y]; rewrite !mem_range => /> ??; rewrite mapP => [[?]].
 by rewrite !mem_range /= => /> * /#.
rewrite !mem_range => /> *.
exists (x.`1).
rewrite !mem_range; split; first smt().
rewrite mapP /=; exists x.`2.
by rewrite mem_range /#.
qed.

lemma uniq_allpairs_comba2 nlimbs: uniq (allpairs_comba2 nlimbs).
proof.
apply uniq_flatten_map.
  move=> x /=; rewrite map_inj_in_uniq.
   by move => y z; rewrite !mem_range /#.
  by apply range_uniq.
 move => y z; rewrite !mem_range => ?? /hasP [[??]].
 rewrite !mapP; move=> [[?][]]; rewrite mem_range /= => ?[??] []?.
 by rewrite mem_range => />.
by apply range_uniq.
qed.

(** SQUARE *)
(* up *)
op allpairs_sqrcomba1 nlimbs = 
 flatten (map (fun s => (map (fun x => (s,x)) (range 0 (s%/2))))
              (range 0 nlimbs)).
(* diag *)
op allpairs_sqrcombadigag nlimbs = 
 map (fun x => (2*x,x)) (range 0 nlimbs).
(* down *)
op allpairs_sqrcomba2 nlimbs = 
 flatten (map (fun s => (map (fun x => (s,x)) (range (1+s-nlimbs) ((s-nlimbs)%/2))))
              (range nlimbs (2*nlimbs-1))).
 
require import BitEncoding StdBigop Bigalg.
(*---*) import Bigint BIA.

op val_mul_comba1 (x y: R.t) =
  big predT
      (fun si:_*_ => to_uint x.[si.`2] * to_uint y.[si.`1 - si.`2] * W64.modulus ^ si.`1)%Int
      (allpairs_comba1 nlimbs).

op val_mul_comba2 (x y: R.t) =
  big predT
      (fun si:_*_ => to_uint x.[si.`2] * to_uint y.[si.`1 - si.`2] * W64.modulus ^ si.`1)%Int
      (allpairs_comba2 nlimbs).

op val_mul_comba_up k (x y:R.t) =
  bigi predT
       (fun (s : int) => bigi predT 
                          (fun (i : int) =>
                            to_uint x.[i] * to_uint y.[s - i]*W64.modulus ^ s)
                          0 (s + 1))
     0 k.

lemma val_mul_comba1E x y:
 val_mul_comba1 x y = val_mul_comba_up nlimbs x y.
proof.
rewrite /val_mul_comba1 /val_mul_comba_up big_flatten big_map /(\o) /=.
rewrite (eq_big _ predT _ 
 (fun s:int => BIA.bigi predT (fun i:int => to_uint x.[i] * to_uint y.[s-i] * W64.modulus^s) 0 (s+1))); first smt().
 by move=> s /= ?; rewrite big_map /(\o) /=; apply eq_bigr.
smt().
qed.

op val_mul_comba_down k (x y:R.t) =
  bigi predT
       (fun (s : int) => bigi predT 
                          (fun (i : int) =>
                            to_uint x.[i] * to_uint y.[s - i]*W64.modulus ^ s)
                           (1 + s - nlimbs) nlimbs)
     nlimbs k.

lemma val_mul_comba2E x y:
 val_mul_comba2 x y = val_mul_comba_down (2*nlimbs-1) x y.
proof.
rewrite /val_mul_comba2 /val_mul_comba_up big_flatten big_map /(\o) /=.
rewrite (eq_big _ predT _ 
 (fun s:int => BIA.bigi predT (fun i:int => to_uint x.[i] * to_uint y.[s-i] * W64.modulus^s) (1+s-nlimbs) nlimbs)); first smt().
 move=> s /= ?; rewrite big_map /(\o) /=.
 by apply eq_bigr.
rewrite (range_cat (2*nlimbs-1)); first 2 by smt(gt0_nlimbs).
rewrite big_cat rangeS big_cons big_nil /= (_:(predT (2*nlimbs-1)) = true) //=.
by rewrite (_:2*nlimbs-nlimbs=nlimbs) 1:/# (range_geq nlimbs nlimbs).
qed.

lemma mul_combaP (x y: R.t):
 bn x * bn y = val_mul_comba1 x y + val_mul_comba2 x y.
proof.
rewrite eq_sym /bnk BIA.big_distr /=; first 3 smt().
rewrite -(BIA.big_allpairs
            (fun x y =>(x,y))
            (fun ij:_*_ => to_uint x.[ij.`1] * W64.modulus ^ ij.`1
                           * (to_uint y.[ij.`2] * W64.modulus ^ ij.`2))).
rewrite (BIA.eq_big_seq _ (fun ij:_*_ => to_uint x.[ij.`1] * to_uint y.[ij.`2]
                                        * W64.modulus ^ (ij.`1 + ij.`2))).
 move=> [x1 x2] /=.
 rewrite allpairsP => [[[y1 y2]]] /=.
 rewrite !mem_range => /> Hy11 Hy12 Hy21 Hy22.
 by rewrite exprD_nneg /#.
rewrite (BIA.big_reindex _ _ 
         (fun si:_*_ => (si.`2, si.`1 - si.`2))%Int
         (fun ij:int*int => (ij.`1 + ij.`2, ij.`1))
       ).
 by move=> ? /= /#.
rewrite Core.predTofV /(\o) /= /val_mul_comba1 /val_mul_comba2.
have H: perm_eq
         (map (fun (ij : int * int) => (ij.`1 + ij.`2, ij.`1))
           (allpairs (fun (x0 y0 : int) => (x0, y0)) (range 0 nlimbs)
             (range 0 nlimbs)))
         (allpairs_comba1 nlimbs ++ allpairs_comba2 nlimbs).
 apply uniq_perm_eq.
   rewrite map_inj_in_uniq.
    move=> [x11 x12] [x21 x22]; rewrite !allpairsP => [[[x1 x2]]]; rewrite !mem_range /=.
    move=> [?[?[??]]].
    by move=> [[??]]; rewrite !mem_range /= /#.
   by apply allpairs_uniq; smt(range_uniq).
  rewrite cat_uniq.
  split; first by apply uniq_allpairs_comba1.
  split; last by apply uniq_allpairs_comba2.
  rewrite hasP negb_exists => [[x1 x2]].
  rewrite negb_and.
  case: (x1 < nlimbs) => E.
   by left; rewrite mem_allpairs_comba2 !mem_range /= /#.
  by right; rewrite mem_allpairs_comba1 !mem_range /= /#.
 move=> [x1 x2]; split.
  rewrite mapP => [[[x11 x12]]].
  rewrite allpairsP => [[[[x21 x22]]]] /=.
  rewrite !mem_range mem_cat => /> *.
  case: ((x21+x22) < nlimbs) => E.
   by left; rewrite mem_allpairs_comba1 /= !mem_range /#.
  by right; rewrite mem_allpairs_comba2 /= !mem_range /#.
 rewrite mem_cat; move => [/mem_allpairs_comba1 | /mem_allpairs_comba2] /=;
 rewrite !mem_range mapP => /> *.
  exists (x2,x1-x2) => /=; split; last by smt().
  by rewrite allpairsP; exists (x2,x1-x2) => /=; rewrite !mem_range /#.
 exists (x2,x1-x2) => /=; split; last by smt().
 by rewrite allpairsP; exists (x2,x1-x2) => /=; rewrite !mem_range /#.
rewrite (BIA.eq_big_perm _ _ _ _ H) -big_cat.
apply BIA.eq_bigr.
smt().
qed.

lemma val_mul_comba_upS k x y:
 0 <= k =>
 val_mul_comba_up (k+1) x y
 = val_mul_comba_up k x y
   + bigi predT (fun (i : int) => to_uint x.[i] * to_uint y.[k - i] * W64.modulus ^ k)
          0 (k+1).
proof.
move=> *; rewrite /val_mul_comba_up {1}(range_cat k) 1..2:/# rangeS big_cat big_cons big_nil /#.
qed.

lemma val_mul_comba_downS k x y:
 nlimbs <= k =>
 val_mul_comba_down (k+1) x y
 = val_mul_comba_down k x y
   + bigi predT (fun (i : int) => to_uint x.[i] * to_uint y.[k - i] * W64.modulus ^ k)
          (1 + k - nlimbs) nlimbs.
proof.
move=> *; rewrite /val_mul_comba_down (range_cat k) 1..2:/# rangeS big_cat big_cons big_nil /#.
qed.


(* end COMBA LEMMAS *)


lemma packR2_h aa bb:
  hoare [ MulOps.packR2:
          a = aa /\ b = bb
          ==>
          valR2 res = valR aa + modulusR * valR bb
        ].
proof.
proc.
while (0 <= i <= nlimbs /\
       (forall j, 0 <= j < nlimbs => r.[j] = a.[j]) /\ 
        forall j, 0 <= j < i => r.[j+nlimbs] = b.[j]).
 wp; skip; progress; first 2 smt().
  rewrite get_setE 1:/# (_:!j = i{hr} + nlimbs) 1:/# /=.
  by rewrite H1 /#.
 rewrite get_setE 1:/#.
 case: (j = i{hr}) => E; first by smt().
 by rewrite (_:j + nlimbs <> i{hr} + nlimbs) 1:/# /= H2 /#.
wp; while (i <= nlimbs /\
           forall j, 0 <= j < i => r.[j] = a.[j]).
 wp; skip; progress; first smt().
 rewrite get_setE 1:/#.
 case: (j = i{hr}) => E; first by smt().
 by rewrite H0 /#.
wp; skip; progress; first 5 smt(gt0_nlimbs).
rewrite addzC (mulzC modulusR) /bnk mulr_suml /=.
rewrite (range_cat nlimbs); first 2 smt(gt0_nlimbs).
rewrite big_cat addzC; congr.
 rewrite -{1}(addz0 nlimbs) addzC big_addn /predT /=.
 rewrite (_:2*nlimbs-nlimbs=nlimbs) 1:/#.
 apply eq_big_seq => ?; rewrite mem_range => /> *.
 rewrite exprD_nneg 1..2:/#.
 by rewrite H6 1:/# R.bn_modulusE /=; ring.
apply eq_big_seq => ?; rewrite mem_range => /> *.
by rewrite H5 1:/#.
qed.

lemma packR2_ll: islossless MulOps.packR2.
proof.
proc; while (0<=i<=nlimbs) (nlimbs-i).
 move=> *; wp; skip; progress; smt().
wp; while (0<=i<=nlimbs) (nlimbs-i).
 move=> *; wp; skip; progress; smt().
wp; skip; progress; smt(gt0_nlimbs).
qed.

lemma packR2_ph aa bb:
 phoare [ MulOps.packR2:
          a = aa /\ b = bb
          ==>
          valR2 res = valR aa + modulusR * valR bb
        ] = 1%r.
proof. by conseq packR2_ll (packR2_h aa bb). qed.

lemma unpackR2_h aa:
  hoare [ MulOps.unpackR2:
          a = aa
          ==>
          valR2 aa = valR res.`2 + modulusR * valR res.`1
        ].
proof.
proc.
while (#pre /\ 0 <= i <= nlimbs /\
       bnk (nlimbs+i) aa = valR lo + modulusR * bnk i hi).
 wp; skip; progress; first 2 smt(). 
 rewrite addrA !bnkS 1,2:/# /= H1 get_setE 1:/# /= bnk_setO 1:/#. 
 rewrite !exprD_nneg 1,2:/# /bn_modulus /#.
wp; while (#pre /\ 0 <= i <= nlimbs /\
           bnk i aa = bnk i lo).
 wp; skip; progress; first 2 smt(). 
 rewrite !bnkS 1,2:/# /= H1 /bn_modulus bnk_setO 1:/#.
 by rewrite get_setE 1:/#.
wp; skip => />; progress; smt.
qed.

lemma unpackR2_h2 aa:
  hoare [ MulOps.unpackR2:
          a = aa
          ==>
          valR res.`1 = valR2 aa %/ modulusR
          /\ valR res.`2 = valR2 aa %% modulusR
        ].
proof.
conseq (unpackR2_h aa).
move=> &hr Ha [ah al] /= => E.
rewrite E mulrC; split.
 rewrite divzMDr; smt(bnk_cmp).
by rewrite modzMDr modz_small; smt(R.bnk_cmp).
qed.

lemma unpackR2_ll: islossless MulOps.unpackR2.
proof.
proc; while (0<=i<=nlimbs) (nlimbs-i).
 move=> *; wp; skip; progress; smt().
wp; while (0<=i<=nlimbs) (nlimbs-i).
 move=> *; wp; skip; progress; smt().
wp; skip; progress; smt(gt0_nlimbs).
qed.

lemma unpackR2_ph aa:
 phoare [ MulOps.unpackR2:
          a = aa 
          ==>
          valR2 aa = valR res.`2 + modulusR * valR res.`1
        ] = 1%r.
proof. by conseq unpackR2_ll (unpackR2_h aa). qed.

lemma unpackR2_ph2 aa:
 phoare [ MulOps.unpackR2:
          a = aa 
          ==>
          valR res.`1 = valR2 aa %/ modulusR
          /\ valR res.`2 = valR2 aa %% modulusR
        ] = 1%r.
proof. by conseq unpackR2_ll (unpackR2_h2 aa). qed.

lemma leftovers0 (x y a b c xM yM: int):
 x * y = a + b * c =>
 0 <= x < xM =>
 0 <= y < yM =>
 0 <= a =>
 0 <= b =>
 c = xM*yM =>
 b=0.
proof.
move=> E Hx Hy Ha Hb Hc.
have : x*y < xM*yM by apply ltr_pmul => /#.
by rewrite E Hc /#.
qed.

lemma mul1_h aak bb:
  hoare [ MulOps.mul1:
          aak = ak /\ bb = b
          ==>
          !res.`1 /\ !res.`2 /\
          bnk (nlimbs+1) res.`3 =  to_uint aak * valR bb
        ].
proof.
proc; simplify.
have nlimbs_pos:= gt0_nlimbs.
wp.
while (#pre /\ 0 <= i <= nlimbs /\ !_of /\
       to_uint aak * bnk i bb
       = bnk (i+1) r + b2i _cf * W64.modulus^i).
 wp; skip => />; progress; first 2 smt().
 rewrite R.bnkS 1:/# /=.
 rewrite  (_:i{hr}+2=i{hr}+1+1) 1:/#.
 move: H2; rewrite !R2.bnkS 1..3:/# /= => H2.
 rewrite !get_setE /= 1..4:/#.
 rewrite (_:!i{hr} = i{hr} + 1) 1:/# /=.
 rewrite !bnk_setO 1,2:/#.
 rewrite mulrDr mulrA H2.
 rewrite !exprS 1:/#.
 have L1 := muluP aak bb.[i{hr}].
 have L2 := addcPP r{hr}.[i{hr}] (MULlo aak bb.[i{hr}]) _cf{hr}.
 by ring L1 L2.
wp; skip => />; split.
 progress; first smt().
 rewrite (_:1=0+1) 1:/# (_:2=0+1+1) 1:/#.
 rewrite !bnkS 1..3:/# /= !bnk0.
 rewrite b2i0 expr0 /= !get_setE 1..4:/# /=.
 have L1 := muluP aak bb.[0].
 by ring L1.
move=> _cf0 i0 r0 Hc Hi1 Hi2.
rewrite (_:i0=nlimbs) 1:/# => {Hc Hi1 Hi2}.
rewrite !R2.bnkS 1..2:/# /=.
have /= L1:= addcPP r0.[nlimbs] W64.zero _cf0.
rewrite bnk_setO 1:/# !get_setE 1:/# /=.
move => H2; rewrite -andaE; split. 
 (* last carry is 0 *)
 have L1':
  to_uint r0.[nlimbs]
  = to_uint (ADDC r0.[nlimbs] W64.zero _cf0)
    - b2i _cf0
    + b2i (ADDcarry r0.[nlimbs] W64.zero _cf0) * W64.modulus
 by ring L1.
 move: H2; rewrite L1' mulrDl -addrA addrC !addrA -!mulrA. 
 move => H2.
 by have:= (leftovers0 _ _ _ _ _ M (M^nlimbs) H2 _ _ _ _ _);
    move: to_uint_cmp R2.bnk_cmp R.bnk_cmp; smt().
move => NC.
by rewrite H2 L1 NC; ring.
qed.

lemma mul1_ll: islossless MulOps.mul1.
proof.
proc; wp; while true (nlimbs-i).
 by move=> *; wp; skip => /> /#.
by wp; skip => /> /#.
qed.

lemma mul1_ph aak bb:
 phoare [ MulOps.mul1:
          aak = ak /\ bb = b
          ==>
          !res.`1 /\ !res.`2 /\
          bnk (nlimbs+1) res.`3 =  to_uint aak * valR bb
        ] = 1%r.
proof. by conseq mul1_ll (mul1_h aak bb). qed.

lemma mul1acc_bnds k n a b c:
 0 <= k =>
 0 < n =>
 0 <= b =>
 0 <= c =>
 a < M^(k+n+1) =>
 a = b + c*M^(k+n+1) =>
 c = 0.
proof.
move => Hk Hn Hb Hc Ha E.
move: Ha; rewrite E => {E}.
have Aux: forall (a b c:int), 0 <= a => a+b < c => b<c by smt().
move=> /(Aux _ _ _ Hb) {Aux}.
smt.
qed.

lemma mul1acc_aux k a b c:
 0 <= k =>
 0 <= a < M^k =>
 0 <= b < M =>
 0 <= c < M^k =>
 a + b * c < M^(k+1).
proof.
move=> Hk [Ha0 Ha] [Hb0 Hb] [Hc0].
move: Ha Hb.
have E: forall (a b:int), a < b <=> a <= b-1 by smt().
rewrite 3!E => *.
apply (ler_lt_trans ((M^k-1)+(M-1)*(M^k-1))).
 apply ler_add; first done.
 by apply ler_pmul.
smt.
qed.

lemma mul1acc_h kk aa bb xx:
  hoare [ MulOps.mul1acc:
          1 < nlimbs /\
          kk = k /\ aa = a /\ bb = b /\ 0 <= kk < nlimbs
          /\ xx=x /\ !_of /\ !_cf
          ==>
          !res.`1 /\ !res.`2 /\
          bnk (kk+nlimbs+1) res.`3
          = to_uint aa * M^kk * valR bb + R2.bnk (kk+nlimbs) xx
        ].
proof.
proc; simplify.
have nlimbs_pos:= gt0_nlimbs.
splitwhile 2: (i < nlimbs-2).
seq 2: (#[:-3]pre /\ i=nlimbs-2 /\
        bnk (kk+nlimbs) x
        = bnk (kk+nlimbs) xx
          + bnk i bb * to_uint a * W64.modulus^k
          - b2i _of * W64.modulus^(kk+i) - b2i _cf * W64.modulus^(kk+i+1)).
 while (#[:-3]pre /\ 0 <= i <= nlimbs-2 /\
        bnk i bb * to_uint a * W64.modulus^k
        + bnk (k+i+2) xx
        = bnk (k+i+2) x
          + b2i _of * W64.modulus^(kk+i) + b2i _cf * W64.modulus^(kk+i+1) /\
        forall j, k+i+1 < j <= nlimbs+k => x.[j]=xx.[j]).
  have E: forall x, x+2 = x+1+1 by smt().
  wp; skip => />; progress; first 2 smt(). 
   rewrite !get_setE 1:/#.
   rewrite (_:!kk + i{hr} + 1 = kk + i{hr}) 1:/# /=.
   rewrite !E addrA !R2.bnkS 1..6:/# /=.
   rewrite !get_setE 1..6:/#.
   rewrite (_:!kk+i{hr}+2 = kk+i{hr}+1) 1:/# /=.
   rewrite (_:!kk+i{hr}+2 = kk+i{hr}) 1:/# /=.
   rewrite (_:!kk + i{hr} = kk + i{hr} + 1) 1:/# /=.
   rewrite !R.bnkS 1:/# /=.
   move: H4.
   rewrite !E !R2.bnkS 1..4:/# /=.
   rewrite !exprD_nneg 1..8:/# /= => H4.
   rewrite !bnk_setO 1..2:/# !expr0 /=.
   have L1 := muluP aa bb.[i{hr}].
   have L2 := addcPP x{hr}.[kk + i{hr}] (MULlo aa bb.[i{hr}]) _of{hr}.
   have L3 := addcPP x{hr}.[kk + i{hr} + 1] (MULhi aa bb.[i{hr}]) _cf{hr}.
   rewrite (H5 (kk + i{hr} + 2)) 1:/#.
   by ring L1 L2 L3 H4.
  rewrite !get_setE 1..3:/#.
  rewrite (_:! j = kk + i{hr} + 1 ) 1:/# /=.
  rewrite (_:! j = kk + i{hr}) 1:/# /=.
  by rewrite H5 /#.
 wp; skip => />; smt(bnk0).
rcondt 1; first by skip => /> /#.
rcondf 7; first by wp; skip => /#.
seq 6: (#[:-2]pre /\ i=nlimbs-1 /\
        bnk (kk+nlimbs) x
        = bnk (kk+nlimbs) xx
          + bnk (nlimbs-1) bb
            * to_uint a * M ^ k
          - b2i _of * M ^ (kk+nlimbs-1)
          - b2i _cf * M ^ (kk+nlimbs)).
 wp; skip=> />; progress.
 rewrite (_:R2.bnk (kk+nlimbs)=R2.bnk (kk+(nlimbs-2)+1+1)) 1:/#.
 rewrite !R2.bnkS 1..4:/# /= !addrA /=.
 rewrite !get_setE 1..4:/# /=.
 rewrite (_:!kk+nlimbs-1=kk+nlimbs-2) 1:/#.
 rewrite (_:!kk+nlimbs-2=kk+nlimbs-1) 1:/# /=.
 rewrite !bnk_setO 1..2:/#.
 rewrite (_:R.bnk (nlimbs-1)=R.bnk (nlimbs-2+1)) 1:/#.
 rewrite !R.bnkS 1:/# /=.
 have L1:= muluP aa bb.[nlimbs-2].
 have L2:= addcPP x{hr}.[kk+nlimbs-2] (MULlo aa bb.[nlimbs-2]) _of{hr}.
 have L3:= addcPP x{hr}.[kk+nlimbs-1] (MULhi aa bb.[nlimbs-2]) _cf{hr}.
 move: H2.
 rewrite (_:R2.bnk (kk+nlimbs)=R2.bnk (kk+nlimbs-2+1+1)) 1:/#.
 rewrite !R2.bnkS 1..4:/# /=.
 rewrite L2 L3.
 rewrite !mulrDl !mulNr !mulzA !addrA /=.
 rewrite (_:M^(kk+nlimbs)=M^1*M^1*M^kk*M^(nlimbs-2)) 1:-!exprD_nneg 1..7:/# !expr1.
 rewrite (_:M^(kk+nlimbs-1)=M^1*M^kk*M^(nlimbs-2)) 1:-!exprD_nneg 1..5:/# !expr1.
 rewrite (_:M^(kk+nlimbs-2)=M^kk*M^(nlimbs-2)) 1:-!exprD_nneg 1..3:/#.
 move=> H3; ring L1 L2 L3 H3.  rewrite /=. ring.
seq 4: (#[:-2]pre /\
        bnk (kk + nlimbs) xx + to_uint aa * valR bb * M^kk
        = bnk (kk+nlimbs+1) x
          + b2i _of * M ^ (kk+nlimbs)
          + b2i _cf * M ^ (kk+nlimbs)).
 wp; skip => />; progress.
 rewrite (_:R2.bnk (kk+nlimbs+1)=R2.bnk (kk+nlimbs-1+1+1)) 1:/#.
 rewrite !R2.bnkS 1..2:/# /= !addrA /=.
 rewrite !get_setE 1..5:/# /=.
 rewrite (_:!kk+nlimbs=kk+nlimbs-1) 1:/#.
 rewrite (_:!kk+nlimbs-1=kk+nlimbs) 1:/# /=.
 rewrite !bnk_setO 1..2:/#.
 rewrite (_:R.bnk nlimbs=R.bnk (nlimbs-1+1)) 1:/#.
 rewrite !R.bnkS 1..1:/# /=.
 have /=L1:= muluP aa bb.[nlimbs-1].
 have /=L2:= addcPP x{hr}.[kk+nlimbs-1] (MULlo aa bb.[nlimbs-1]) _of{hr}.
 move: H2.
 rewrite (_:R2.bnk (kk+nlimbs)=R2.bnk (kk+nlimbs-1+1)) 1:/#.
 rewrite !R2.bnkS 1..2:/# /=.
 rewrite L2 !mulrDl !mulNr !mulzA !addrA /=.
 rewrite (_:M^(kk+nlimbs)=M^1*M^kk*M^(nlimbs-1)) 1:-!exprD_nneg 1..5:/# !expr1.
 rewrite (_:M^(kk+nlimbs-1)=M^kk*M^(nlimbs-1)) 1:-!exprD_nneg 1..3:/#.
 by move=> /= H2; ring L1 L2 H2. 
seq 4: (#[/:-2]pre /\
        bnk (kk+nlimbs) xx + to_uint aa * valR bb * M^kk
        = bnk (kk + nlimbs + 1) x
          + (b2i _cf{hr} + b2i _of{hr})
            * (M^(kk+nlimbs+1))).
 wp; skip => />; progress.
 rewrite R2.bnkS 1:/# /=.
 rewrite !get_setE 1..2:/# /=.
 rewrite !bnk_setO 1:/#. 
 move: (addcPP x{hr}.[kk+nlimbs] (W64.of_int 0) _cf{hr}).
 rewrite to_uint0 /= => L2.
 move: (addcPP (ADDC x{hr}.[kk+nlimbs] (W64.of_int 0) _cf{hr}) (W64.of_int 0) _of{hr}).
 rewrite to_uint0 /= => L1.
 rewrite L1 L2.
 move: H2.
 by rewrite R2.bnkS 1:/# /= mulrDl exprS 1:/# => H2; ring H2.
skip => /> &hr H Hk1 E.
rewrite andbA -andaE -!b2i_eq0; split.
 move: (mul1acc_bnds kk nlimbs _ _ _ _ _ _ _ _ E);
   first 4 smt(R2.bnk_cmp).
  rewrite -mulrA; apply mul1acc_aux; first 3 move: R2.bnk_cmp to_uint_cmp; smt().
  by rewrite (exprD_nneg) 1..2:/#; move: R.bnk_cmp expr_gt0; smt().
 smt().
smt().
qed.

lemma mul1acc_ll: islossless MulOps.mul1acc.
proof.
proc; wp; while true (nlimbs-i).
 by move=> *; wp; skip => /> /#.
by wp; skip => /> /#.
qed.

lemma mul1acc_ph kk aa bb xx:
 phoare [ MulOps.mul1acc:
          1 < nlimbs /\
          kk = k /\ aa = a /\ bb = b /\ 0 <= kk < nlimbs
          /\ xx=x /\ !_of /\ !_cf
          ==>
          !res.`1 /\ !res.`2 /\
          bnk (kk+nlimbs+1) res.`3
          = to_uint aa * M^kk * valR bb + R2.bnk (kk+nlimbs) xx
        ] = 1%r.
proof. by conseq mul1acc_ll (mul1acc_h kk aa bb xx). qed.

lemma mulR_h aa bb:
  hoare [ MulOps.mulR:
          1 < nlimbs /\ aa = a /\ bb = b
          ==>
          !res.`1 /\ !res.`2 /\ valR2 res.`3 = valR aa * valR bb
        ].
proof.
proc; simplify.
while (#pre /\ 1 <= k <= nlimbs /\ 
       !_of /\ !_cf /\
       bnk (nlimbs+k) r = bnk k aa * valR bb).
 wp; ecall (mul1acc_h k a.[k] b r); skip => />; progress;
 first 3 smt().
 by rewrite addrA (addzC nlimbs) H9 bnkS /#.
wp; ecall (mul1_h a.[0] b); wp; skip => />; progress.
  smt(gt0_nlimbs).
 rewrite H2 /=. 
 have ->: bnk 1 aa = bnk (0+1) aa by smt().
 by rewrite bnkS 1:/# /= expr0 bnk0 1:// /#.
smt().
qed.

lemma mulR_ll: islossless MulOps.mulR.
proof.
proc; while true (nlimbs-k).
 by move=> *; wp; call mul1acc_ll; skip => /#.
by wp; call mul1_ll; skip => /#.
qed.

lemma mulR_ph aa bb:
 phoare [ MulOps.mulR:
          1 < nlimbs /\ aa = a /\ bb = b
          ==>
          !res.`1 /\ !res.`2 /\ valR2 res.`3 = valR aa * valR bb
        ] = 1%r.
proof. by conseq mulR_ll (mulR_h aa bb). qed.

lemma addacc3_h kk bb1 bb0 acc:
  hoare [ MulOps.addacc3:
          kk = k /\ bb1 = b1 /\ bb0 = b0 /\ acc = a /\
          to_uint acc.[(kk+2)%%3] < W64.modulus - 1
          ==>
          valAcc kk res = valAcc kk acc + to_uint bb1 * W64.modulus + to_uint bb0 /\
          to_uint res.[(kk+2)%%3] <= to_uint acc.[(kk+2)%%3] + 1
        ].
proof.
proc; wp; skip => /> *.
rewrite /valAcc !get_setE /=; first 12 smt().
rewrite (_: (kk %% 3) = ((kk+0)%%3)) 1:/#.
have E: forall x y, x <> y => 0 <= x < 3 => 0 <= y < 3 => 
         ((kk + x) %% 3 <> ((kk + y)%%3)) by smt().
rewrite !E //= !R.addcP' !addcE /carry_add !carryE /=.
split.
 ring; smt.
smt.
qed.

lemma addacc3_ll: islossless MulOps.addacc3.
proof. by islossless. qed.

lemma addacc3_ph kk bb1 bb0 acc:
 phoare [ MulOps.addacc3:
          kk = k /\ bb1 = b1 /\ bb0 = b0 /\ acc = a /\
          to_uint acc.[(kk+2)%%3] < W64.modulus - 1
          ==>
          valAcc kk res = valAcc kk acc + to_uint bb1 * W64.modulus + to_uint bb0 /\
          to_uint res.[(kk+2)%%3] <= to_uint acc.[(kk+2)%%3] + 1
        ] = 1%r.
proof. by conseq addacc3_ll (addacc3_h kk bb1 bb0 acc). qed.

lemma mulRcomba_innerloop_h kk istart iend aa bb acc:
  hoare [ MulOps.mulRcomba_innerloop:
          kk = k /\ istart = i /\ iend = i2 /\ 
          0 <= istart /\ 0 <= iend-istart < W64.max_uint /\
          aa = a /\ bb = b /\ acc = x /\
          to_uint acc.[(kk+2)%%3] = 0 
          ==>
          valAcc kk res = valAcc kk acc + bigi predT (fun i => to_uint aa.[i] * to_uint bb.[kk-i]) istart iend /\
          to_uint res.[(kk+2)%%3] <= iend - istart
        ].
proof.
proc.
while (i2 = iend /\ k = kk /\ a = aa /\ b = bb
       /\ 0 <= istart <= i <= i2 /\ i2-istart < W64.max_uint 
       /\ to_uint x.[(kk+2)%%3] <= i - istart
       /\ valAcc kk x 
          = valAcc kk acc
            + bigi predT (fun i=> to_uint a.[i]*to_uint b.[kk-i]) istart i).
 wp; ecall (addacc3_h k t1 t0 x); wp; skip => />; progress; first 4 by smt().
 rewrite H7 (range_cat i{hr}) 1..2:/# rangeS big_cat big_cons big_nil. 
 rewrite muluE H4 /predT /= -!addzA; congr; ring.
 move: (mulhiP a{hr}.[i{hr}] b{hr}.[k{hr}-i{hr}]); smt. 
wp; skip => />; progress; first 2 smt().
- by rewrite range_geq // big_nil.
- by rewrite H7 /#.
- smt().
qed.

lemma mulRcomba_innerloop_ll: islossless MulOps.mulRcomba_innerloop.
proof.
proc; while true (i2-i).
 by move=> *; wp; call addacc3_ll; wp; skip; smt().
by wp; skip; smt().
qed.

lemma mulRcomba_innerloop_ph kk istart iend aa bb acc:
 phoare [ MulOps.mulRcomba_innerloop:
          kk = k /\ istart = i /\ iend = i2 /\ 
          0 <= istart /\ 0 <= iend-istart < W64.max_uint /\
          aa = a /\ bb = b /\ acc = x /\
          to_uint acc.[(kk+2)%%3] = 0 
          ==>
          valAcc kk res = valAcc kk acc + bigi predT (fun i => to_uint aa.[i] * to_uint bb.[kk-i]) istart iend /\
          to_uint res.[(kk+2)%%3] <= iend - istart
        ] = 1%r.
proof. by conseq mulRcomba_innerloop_ll (mulRcomba_innerloop_h kk istart iend aa bb acc). qed.

lemma mulRcomba_h aa bb:
  hoare [ MulOps.mulRcomba:
          aa = a /\ bb = b /\ nlimbs < W64.max_uint
          ==>
          valR2 res = valR aa * valR bb
        ].
proof.
proc; wp.
while (a=aa /\ b=bb /\ nlimbs <= k <= 2*nlimbs - 1 /\ nlimbs < W64.max_uint /\
       to_uint x.[(k+2) %% 3] = 0 /\
       bnk k r + valAcc k x * W64.modulus^k = val_mul_comba1 aa bb + val_mul_comba_down k aa bb).
 wp; ecall (mulRcomba_innerloop_h k (k-nlimbs+1) nlimbs aa bb x).
 skip; progress; first 5 smt().
 - by rewrite modzDr get_setE 1:/#.
 - rewrite /val_mul_comba_down (range_cat k{hr}) 1..2:/#.
   rewrite big_cat rangeS big_cons big_nil /= /predT /= -/predT addzA -H3 => {H3}.
   rewrite -divr_suml bnkS 1:/# digE get_setE 1:/# /= bnk_setO  1:/#.
   rewrite (_:1+k{hr}-nlimbs = k{hr}-nlimbs + 1) 1:/#.
   move: H9; rewrite (divz_eq (valAcc k{hr} result) W64.modulus).
   rewrite -valAccS valAcc_mod => H9.
   by rewrite exprS 1:/#; ring H9.
while (a=aa /\ b=bb /\ 0 <= k <= nlimbs < W64.max_uint /\
       to_uint x.[(k+2) %% 3] = 0 /\
       bnk k r + valAcc k x * W64.modulus^k = val_mul_comba_up k aa bb).
 wp; ecall (mulRcomba_innerloop_h k 0 (k+1) aa bb x).
 skip; progress; first 3 smt().
 - by rewrite modzDr get_setE /= /#.
 - move: H3; rewrite /val_mul_comba_up => H3.
   rewrite (range_cat k{hr}) 1..2:/#.
   rewrite big_cat rangeS big_cons big_nil /= /predT /= -/predT.
   rewrite -H3 => {H3}.
   rewrite -divr_suml bnkS 1:/# digE get_setE 1:/# /= bnk_setO  1:/#.
   move: H8; rewrite (divz_eq (valAcc k{hr} result) W64.modulus).
   rewrite -valAccS valAcc_mod => H8.
   by rewrite exprS 1:/#; ring H8.
wp; skip => /> *; progress.
- by smt(gt0_nlimbs).
- by rewrite /valAcc /val_mul_comba_up range_geq // big_nil bnk0 //=.
- smt().
- smt(gt0_nlimbs).
- move: H3; rewrite (_:k0=nlimbs) 1:/# val_mul_comba1E => ->.
  by rewrite /val_mul_comba_down range_geq // big_nil.
- have: valR aa * valR bb < W64.modulus^(2*nlimbs).
   move: (bnk_cmp nlimbs aa) => /> B1 B2.
   move: (bnk_cmp nlimbs bb) => /> B3 B4.
   rewrite (_:2*nlimbs=nlimbs+nlimbs) 1:/# exprD_nneg; first 2 smt(gt0_nlimbs).
   by apply ltr_pmul.
  move: H7 H8; rewrite mul_combaP (_:k1=2*nlimbs-1) 1:/# -val_mul_comba2E => ? E.
  rewrite (_:2*nlimbs = 2*nlimbs-1+1) 1:/# bnkS /=; first smt(gt0_nlimbs).
  rewrite get_setE 1:/# /= -E.
  move=> B; have ->: valAcc (2 * nlimbs - 1) x1 = to_uint x1.[(2 * nlimbs - 1) %% 3].
   case: (valAcc (2*nlimbs-1) x1 < W64.modulus).
    by rewrite /valAcc; smt(to_uint_cmp).
   rewrite -lerNgt -(ler_pmul2l (W64.modulus^(2*nlimbs-1))); first smt(expr_gt0).
   rewrite mulzC -exprS 1:/# /= lerNgt mulzC => *; smt(R2.bnk_cmp).
  by rewrite bnk_setO /#.
qed.

lemma mulRcomba_ll: islossless MulOps.mulRcomba.
proof.
proc; wp.
while true (2*nlimbs-k).
 by move=> *; wp; call mulRcomba_innerloop_ll; skip; smt().
while true (nlimbs-k).
 by move=> *; wp; call mulRcomba_innerloop_ll; skip; smt().
wp; skip; progress; smt().
qed.

lemma mulRcomba_ph aa bb:
 phoare [ MulOps.mulRcomba:
          aa = a /\ bb = b /\ nlimbs < W64.max_uint
          ==>
          valR2 res = valR aa * valR bb
        ] = 1%r.
proof. by conseq mulRcomba_ll (mulRcomba_h aa bb). qed.

lemma redmRcomba_h rrInv (pp:R.t) xx:
  hoare [ MulOps.redmRcomba:
          nlimbs < W64.max_uint /\ 2 * valR pp < modulusR /\
          to_uint (p0Inv * pp.[0]) = (-1)%%W64.modulus /\
          valR2 x < valR pp * modulusR /\
          (rrInv * modulusR) %% valR pp = 1 %% valR pp /\
          x = xx /\ p = pp
          ==>
          valR res = (valR2 xx * rrInv) %% valR pp
        ].
proof.
proc.
ecall (R.subcRcond_h r p).
wp; ecall (addacc3_h (2*nlimbs-1) W64.zero x.[2*nlimbs - 1] a).
while (x = xx /\ p = pp /\ to_uint (p0Inv{hr} * pp.[0]) = (-1) %% W64.modulus /\
       nlimbs <= i <= 2*nlimbs - 1 /\ nlimbs < W64.max_uint /\
       to_uint a.[(i+2) %% 3] = 0 /\
       bnk (i-nlimbs) r * W64.modulus^nlimbs + valAcc i a * W64.modulus^i
       = bnk i x + val_mul_comba_up nlimbs m p + val_mul_comba_down i m p).
 wp; ecall (addacc3_h i W64.zero x.[i] a).
 ecall (mulRcomba_innerloop_h i (i-nlimbs+1) nlimbs m p a).
 wp; skip; progress; first 6 smt().
 - by rewrite modzDr get_setE /#. 
 - rewrite (_:i{hr} + 1 - nlimbs = i{hr} - nlimbs + 1) 1:/# bnkS 1:/# /=.
   rewrite get_setE 1:/# /= R2.bnkS 1:/# /= bnk_setO 1:/#.
   rewrite val_mul_comba_downS 1:/#.
   rewrite eq_sym -2!addzA addzC !addzA eq_sym -H4 (_:1+i{hr}-nlimbs=i{hr}-nlimbs+1) 1:/#; clear H4.
   move: H13; rewrite(divz_eq (valAcc i{hr} result0) W64.modulus) -valAccS valAcc_mod H10.
   move=> /(congr1 (fun a=>a*W64.modulus^i{hr})) /=.
   rewrite mulzDl mulzA -exprS 1:/# => E.
   rewrite mulzDl mulzA -exprD_nneg 1..2:/# (_:i{hr}-nlimbs+nlimbs=i{hr}) 1:/#.
   by rewrite -divr_suml; ring E.
while (x = xx /\ p = pp /\ to_uint (p0Inv{hr} * pp.[0]) = (-1) %% W64.modulus /\ 
       0 <= i <= nlimbs < W64.max_uint /\
       to_uint a.[(i+2) %% 3] = 0 /\
       valAcc i a * W64.modulus^i = bnk i x + val_mul_comba_up i m p).
 wp; ecall (addacc3_h i t1 t0 a).
 wp; ecall (addacc3_h i W64.zero x.[i] a).
 ecall (mulRcomba_innerloop_h i 0 i m p a).
 skip => |> &hr H H0 H1 H2 H3 H4 H5.
 rewrite (_:18446744073709551615 = (-1)%%M) 1:/# in H.
 split => [|H6 r1 H7 H8]; first smt().
 split => [|H9 r2 H10 H11]; first smt().
 split => [|H12 r3 H13 H14]; first smt().
 split; first smt().
 rewrite -andabP.
 split.
  rewrite modzDr.
  move: H13; rewrite get_setE 1:/# /= mulzC muluE /= -addzA (addzC (_*_)%Int) mulhiP.
  rewrite (divz_eq (valAcc i{hr} r2) W64.modulus) valAcc_mod.
  rewrite -(valAcc_mod i{hr} r3) => ->.
  rewrite -addzA modzMDl to_uintM.
  rewrite -modzDm modzMml mulzA -modzMmr -to_uintM H.
  by rewrite modzMmr modzDm mulzC /#.
 - rewrite modzDr => H15.
   rewrite val_mul_comba_upS 1:/#.
   have ->: val_mul_comba_up i{hr} m{hr}.[i{hr} <- r2.[i{hr} %% 3] * p0Inv{hr}] pp
            = val_mul_comba_up i{hr} m{hr} pp.
    apply eq_big_seq => k1; rewrite mem_range /= => Hk1.
    apply eq_big_seq => k2; rewrite mem_range /= => Hk2.
    by rewrite get_setE 1:/# (_:k2<>i{hr}) 1:/#.
   rewrite  bnkS 1:/# -addzA eq_sym addzC addzA -H4 eq_sym; clear H4.
   rewrite (range_cat i{hr}) 1..2:/# big_cat rangeS big_cons big_nil /predT /= -/predT.
   rewrite -divr_suml /=.
   move: H13; rewrite (divz_eq (valAcc i{hr} r3) W64.modulus) -valAccS valAcc_mod.
   have ->: r3.[i{hr} %% 3 <- W64.zero] = r3.
    apply Array3.ext_eq => k Hk; rewrite get_setE 1:/#.
    case: (k = i{hr}%%3) => // ->.
    by rewrite to_uint_eq to_uint0 /#.
   move => /(congr1 (fun a=>a*W64.modulus^i{hr})) /=.
   rewrite mulzDl mulzA -exprS 1:/# H15 /= H10  H7 => {H7 H10} ->.
   pose B1 := bigi _ _ _ _; pose B2 := bigi _ _ _ _.
   have ->: B2 = B1.
    apply eq_big_seq => k; rewrite mem_range => Hk /=.
    by rewrite get_setE 1:/# (_:k<>i{hr}) 1:/#.
   rewrite get_setE 1:/# /= muluE /= -addzA.
   have ->: to_uint (mulhi (r2.[i{hr} %% 3] * p0Inv{hr}) pp.[0]) * W64.modulus
            + to_uint (r2.[i{hr} %% 3] * p0Inv{hr} * pp.[0])
            = to_uint (r2.[i{hr} %% 3] * p0Inv{hr}) * to_uint pp.[0]
    by move: mulhiP; smt().
   by ring.
wp; skip; progress.
- smt(gt0_nlimbs).
- by rewrite /valAcc /= bnk0 1:// /val_mul_comba_up range_geq 1:/# big_nil.
- smt().
- smt(gt0_nlimbs).
- have E: i0 = nlimbs by smt().
  by move: H10; rewrite !E /= bnk0 1:// /= /val_mul_comba_down range_geq 1:/# big_nil.
- smt().
- have E0: i0 = nlimbs by smt().
  have E1: i1 = 2*nlimbs-1 by smt().
  move: H16; rewrite !E1 /=; pose redc := r0.[nlimbs - 1 <- result.[(2*nlimbs - 1) %% 3]].
  move => H22; move: H17; rewrite !E1 (_:2 * nlimbs - 1 - nlimbs = nlimbs-1) 1:/#.
  rewrite -val_mul_comba1E -val_mul_comba2E -addzA -mul_combaP => H23.
  have B0: 0 < valR p{hr}.
   move: H2; case: (valR p{hr}=0) => [->|] /=; last smt(bnk_cmp).
   smt(R2.bnk_cmp).
  have B1: valR2 x{hr} + valR m0 * valR p{hr} < W64.modulus^(2*nlimbs).
   apply (ltr_trans (2* valR p{hr} * modulusR)).
    rewrite (_:2=1+1) 1:/# mulzA (mulzDl _ _ (_*_)%Int) /=.
    apply ltr_add; first smt().
    rewrite mulzC ltr_pmul2l; first smt().
    by rewrite bn_modulusE; move: bnk_cmp; smt().
   move: H0; rewrite -(ltr_pmul2r (W64.modulus^nlimbs)); first smt(expr_gt0).
   by rewrite !bn_modulusE -exprD_nneg /#.
  have B2: valAcc (2*nlimbs-1) result < W64.modulus.
   move/(congr1 (fun a=>to_uint x{hr}.[2 * nlimbs - 1]*W64.modulus ^ (2 * nlimbs - 1)+a)): H23 B1=> /=.
   rewrite !addzA.
   have ->: to_uint x{hr}.[2 * nlimbs - 1] * W64.modulus ^ (2 * nlimbs - 1)
            + R2.bnk (2 * nlimbs - 1) x{hr}
            = bnk (2 * nlimbs) x{hr}. 
    by rewrite (_:2*nlimbs=2*nlimbs-1+1) 1:/# R2.bnkS /#.
   move=> <-.
   have ->: to_uint x{hr}.[2 * nlimbs - 1] * W64.modulus ^ (2 * nlimbs - 1)
            + bnk (nlimbs - 1) r0 * W64.modulus ^ nlimbs
            + valAcc (2 * nlimbs - 1) a1 * W64.modulus ^ (2 * nlimbs - 1)
            = bnk (nlimbs - 1) r0 * W64.modulus ^ nlimbs
            + valAcc (2 * nlimbs - 1) result * W64.modulus ^ (2 * nlimbs - 1)
    by ring H19.
   move=> H23; have ?: valAcc (2 * nlimbs - 1) result * W64.modulus ^ (2 * nlimbs - 1)
                     < W64.modulus ^ (2 * nlimbs).
    by rewrite /= in H23; move: bnk_cmp; smt().
   rewrite -(ltr_pmul2r (W64.modulus^(2*nlimbs-1))).
    by rewrite -exprM; smt(gt0_nlimbs expr_gt0).
   by rewrite -exprS 1:/# /=.
  have E2: valAcc (2*nlimbs-1) result = to_uint result.[(2*nlimbs-1)%%3].
   rewrite (divz_eq (valAcc (2 * nlimbs - 1) result) W64.modulus) divz_small /=.
    apply bound_abs; split; [rewrite /valAcc /= !expr0 /=|].
     move: to_uint_cmp expr_gt0; smt().
    rewrite /= in B2.
    move: to_uint_cmp expr_gt0; smt().
   by rewrite valAcc_mod.   
  have B3: valAcc (2*nlimbs-1) a1 < W64.modulus by move: to_uint_cmp; smt().
  have E3: valAcc (2*nlimbs-1) a1 = to_uint a1.[(2*nlimbs-1)%%3].
   rewrite (divz_eq (valAcc (2 * nlimbs - 1) a1) W64.modulus) divz_small /=.
    apply bound_abs; split; [rewrite /valAcc/= expr0 /=|].
     by move: to_uint_cmp expr_gt0; smt().
    rewrite /= in B3.
    move: to_uint_cmp expr_gt0; smt().
   by rewrite valAcc_mod.
  have redc_val: valR redc * modulusR = valR2 x{hr} + valR m0 * valR p{hr}.
   have ->: modulusR = W64.modulus ^nlimbs.
    by rewrite bn_modulusE -exprM; first smt().
   rewrite /redc (_:nlimbs = nlimbs - 1 + 1) 1:/# bnkS 1:/# /dig /= get_setE /= 1:/#.
   rewrite bnk_setO 1:/# -E2 H19 E3.
   rewrite (_:2*nlimbs=2*nlimbs-1+1) 1:/# bnkS 1:/# /= -addzA -H23 E3.
   rewrite !mulzDl !mulzA -!exprD_nneg; smt().
  have redc_congr: valR redc %% valR p{hr} = valR2 x{hr} * rrInv %% valR p{hr}.
   rewrite -(mulz1 (valR _)) -modzMmr -H3 modzMmr (mulzC rrInv) -mulzA redc_val.
   by rewrite mulzDl mulzA (mulzC (valR p{hr})) -mulzA modzMDr.
  have redc_bonds: 0 <= valR redc < 2 * valR p{hr}.
   split => *; first by smt(bnk_cmp).
   rewrite -(ltr_pmul2r modulusR); first smt(bn_modulusE expr_gt0).
   rewrite redc_val (_:2*valR p{hr} * modulusR=valR p{hr} * modulusR+valR p{hr} * modulusR) 1:/#.
   apply ltr_add; first smt().
   rewrite mulzC ltr_pmul2l.
    case: (valR p{hr} = 0) => Ep.
     by move: H3; rewrite Ep !modz0 => /Ring.IntID.unitP [?|?]; smt(bn_modulusE expr_gt0).
    move: (bnk_cmp nlimbs p{hr}); smt().
   move: (bnk_cmp nlimbs m0); rewrite !bn_modulusE -exprM; smt(gt0_nlimbs). 
  rewrite H21 -/redc; case: (valR redc < valR p{hr}) => E.
   by have ->: valR redc = valR redc %% valR p{hr} by rewrite modz_small /#.
  by have ->: valR redc - valR p{hr} = valR redc %% valR p{hr}
   by rewrite -(modzMDr (-1)) modz_small /#.
qed.

lemma redmRcomba_ll: islossless MulOps.redmRcomba.
proof.
proc.
wp; call R.subcRcond_ll.
wp; call addacc3_ll.
while true (2*nlimbs - i).
 move=> *; wp; call addacc3_ll; call mulRcomba_innerloop_ll; skip; smt().
while true (nlimbs - i).
 move=> *; wp; call addacc3_ll; wp; call addacc3_ll; call mulRcomba_innerloop_ll; skip; smt().
wp; skip; smt().
qed.

lemma redmRcomba_ph rrInv (pp:R.t) xx:
 phoare [ MulOps.redmRcomba:
          nlimbs < W64.max_uint /\ 2 * valR pp < modulusR /\
          to_uint (p0Inv * pp.[0]) = (-1)%%W64.modulus /\
          valR2 x < valR pp * modulusR /\
          (rrInv * modulusR) %% valR pp = 1 %% valR pp /\
          x = xx /\ p = pp
          ==>
          valR res = (valR2 xx * rrInv) %% valR pp
        ] = 1%r.
proof. by conseq redmRcomba_ll (redmRcomba_h rrInv pp xx). qed.

lemma mulmRcomba_h rrInv (pp:R.t) aa bb:
  hoare [ MulOps.mulmRcomba:
          nlimbs < W64.max_uint /\ 2 * valR pp < modulusR /\
          to_uint (p0Inv * pp.[0]) = (-1)%%W64.modulus /\
          (rrInv * modulusR) %% valR pp = 1 %% valR pp /\
          valR aa < valR pp /\
          a = aa /\ b = bb /\ p = pp
          ==>
          valR res = (valR aa * valR bb * rrInv) %% valR pp
        ].
proof.
proc.
ecall (redmRcomba_h rrInv p x).
ecall (mulRcomba_h a b).
skip; progress.
 rewrite bn_modulusE H5; apply ltr_pmul;
 move: R.bnk_cmp R2.bnk_cmp; smt().
by rewrite H11 H5.
qed.

lemma mulmRcomba_ll: islossless MulOps.mulmRcomba.
proof. by move: mulRcomba_ll redmRcomba_ll=>*; islossless. qed.

lemma mulmRcomba_ph rrInv (pp:R.t) aa bb:
 phoare [ MulOps.mulmRcomba:
          nlimbs < W64.max_uint /\ 2 * valR pp < modulusR /\
          to_uint (p0Inv * pp.[0]) = (-1)%%W64.modulus /\
          (rrInv * modulusR) %% valR pp = 1 %% valR pp /\
          valR aa < valR pp /\
          a = aa /\ b = bb /\ p = pp
          ==>
          valR res = (valR aa * valR bb * rrInv) %% valR pp
        ] = 1%r.
proof. by conseq mulmRcomba_ll (mulmRcomba_h rrInv pp aa bb). qed.

end BigNum.


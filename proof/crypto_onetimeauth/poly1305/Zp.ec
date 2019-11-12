require import List Int IntDiv IntExtra CoreMap.
require import EClib.

from Jasmin require import JModel.

(* modular operations modulo P *)
op p = 2^130 - 5 axiomatized by pE.

lemma two_pow130E: 2^130 = 1361129467683753853853498429727072845824 by done.

(* Embedding into ring theory *)

require ZModP.

clone import ZModP as Zp with
        op p <- p 
        rename "zmod" as "zp"
        proof le2_p by rewrite pE.


(* congruence "mod p" *)

lemma zpcgr_over a b:
 zpcgr (a + 1361129467683753853853498429727072845824 * b) (a + 5 * b).
proof.
have /= ->: (2^ 130) = 5 + p by rewrite pE.
by rewrite (mulzC _ b) mulzDr addzA modzMDr mulzC.
qed.

lemma inzp_over x:
 inzp (1361129467683753853853498429727072845824 * x) = inzp (5*x).
proof. by have /= := zpcgr_over 0 x; rewrite -eq_inzp. qed.

lemma zp_over_lt2p_red x:
 p <= x < 2*p =>
 x %% p = (x + 5) %% 2^130.
proof.
move=> *.
rewrite modz_minus //.
have ->: x-p = x+5-2^130.
 by rewrite pE; ring.
rewrite modz_minus.
 by move: H; rewrite !pE /= /#.
done.
qed.

require import W64limbs.

op inzp_limbs base l = inzp (val_limbs base l).

lemma val_limbs64_div2130 x0 x1 x2:
 val_limbs64 [x0; x1; x2] %/ 2^130 = to_uint x2 %/ 4.
proof.
rewrite /val_digits /=.
have := (divz_eq (to_uint x2) 4).
rewrite addzC mulzC => {1}->.
rewrite !mulzDr -!mulzA /=.
have ? := W64.to_uint_cmp x0.
have ? := W64.to_uint_cmp x1.
have ? := W64.to_uint_cmp x2.
have ? : 0 <= to_uint x2 %% 4 < 4 by smt(W64.to_uint_cmp modz_cmp).
rewrite !addzA (mulzC 1361129467683753853853498429727072845824) divzMDr //.
smt. (*smt(divz_eq0 ...)*)  
qed.

lemma val_limbs64_mod2128 x0 x1 x2:
 val_limbs64 [x0; x1; x2] %% 2^128 = val_limbs64 [x0; x1].
proof.
rewrite /val_digits /= !mulzDr -!mulzA /= !addzA -modzDmr modzMr /= modz_small //.
apply bound_abs.
have ? := W64.to_uint_cmp x0.
have ? := W64.to_uint_cmp x1.
split.
 smt(addz_ge0 StdOrder.IntOrder.pmulr_lge0).
smt. 
qed.

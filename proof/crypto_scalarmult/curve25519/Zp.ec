require import List Int IntDiv IntExtra CoreMap.
require import EClib.

from Jasmin require import JModel.

(* modular operations modulo P *)
op p = 2^255 - 19 axiomatized by pE.

lemma two_pow255E: 2^255 = 57896044618658097711785492504343953926634992332820282019728792003956564819968 by done.

(* Embedding into ring theory *)

require ZModP.

clone import ZModP as Zp with
        op p <- p 
        rename "zmod" as "zp"
        proof le2_p by rewrite pE.


(* congruence "mod p" *)

lemma zpcgr_over a b:
 zpcgr (a + 57896044618658097711785492504343953926634992332820282019728792003956564819968 * b) (a + 19 * b).
proof.
have /= ->: (2^ 255) = 19 + p by rewrite pE.
by rewrite (mulzC _ b) mulzDr addzA modzMDr mulzC.
qed.

lemma inzp_over x:
 inzp (57896044618658097711785492504343953926634992332820282019728792003956564819968 * x) = inzp (19*x).
proof. by have /= := zpcgr_over 0 x; rewrite -eq_inzp. qed.

lemma zp_over_lt2p_red x:
 p <= x < 2*p =>
 x %% p = (x + 19) %% 2^255.
proof.
move=> *.
rewrite modz_minus //.
have ->: x-p = x+19-2^255.
 by rewrite pE; ring.
rewrite modz_minus.
 by move: H; rewrite !pE /= /#.
done.
qed.

require import W64limbs.

op inzp_limbs base l = inzp (val_limbs base l).

lemma val_limbs64_div2255 x0 x1 x2 x3:
 val_limbs64 [x0; x1; x2; x3] %/ 2^255 = to_uint x3 %/ 9223372036854775808.
proof.
rewrite /val_digits /=.
have := (divz_eq (to_uint x3) 9223372036854775808).
rewrite addzC mulzC => {1}->.
rewrite !mulzDr -!mulzA /=.
have /= ? := W64.to_uint_cmp x0.
have /= ? := W64.to_uint_cmp x1.
have /= ? := W64.to_uint_cmp x2.
have /= ? := W64.to_uint_cmp x3.
have ? : 0 <= to_uint x3 %% 9223372036854775808 < 9223372036854775808 by smt(W64.to_uint_cmp modz_cmp).
rewrite !addzA (mulzC 57896044618658097711785492504343953926634992332820282019728792003956564819968) divzMDr //.
have ->: (to_uint x0 + 18446744073709551616 * to_uint x1 +
         340282366920938463463374607431768211456 * to_uint x2 +
         6277101735386680763835789423207666416102355444464034512896 * (to_uint x3 %% 9223372036854775808)) %/
         57896044618658097711785492504343953926634992332820282019728792003956564819968 = 0.
 by rewrite -divz_eq0 /#.
by ring.
qed.


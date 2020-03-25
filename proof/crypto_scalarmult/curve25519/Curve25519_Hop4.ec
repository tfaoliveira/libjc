require import AllCore Bool List Int IntExtra IntDiv CoreMap Real Zp.
from Jasmin require import JModel.
require import Curve25519_Spec.
require import Curve25519_Hop1.
require import Curve25519_Hop2.
require import Curve25519_Hop3.
require import Curve25519_smulx.
import Zp ZModpRing.
import Curve25519_Spec Curve25519_Hop1 Curve25519_Hop2 Curve25519_Hop3.
import Curve25519_smulx.

require import Array4 Array8.
require import W64limbs.

(** representation : move to another file/use rep3/5 **)
type Rep4 = W64.t Array4.t.
op valRep4  (x : Rep4) : int = val_limbs64 (to_list x).
op inzpRep4 (x : Rep4) : zp  = inzp (valRep4 x) axiomatized by inzpRep4E.
abbrev zpcgrRep4 (x : Rep4) (z : int) : bool = zpcgr (valRep4 x) z.
(** ************************************* **)

(** step 0 : add sub mul sqr **)
equiv eq_h4_add : MHop2.add ~ M._fe64_add_rrs:
   f{1} = inzpRep4 f{2} /\
   g{1} = inzpRep4 g{2}
    ==>
   res{1} = inzpRep4 res{2}.
proof.
proc.
admit.
qed.

equiv eq_h4_sub : MHop2.sub ~ M._fe64_sub_rrs:
   f{1} = inzpRep4 f{2} /\
   g{1} = inzpRep4 gs{2}
    ==>
   res{1} = inzpRep4 res{2}.
proof.
proc.
admit.
qed.

equiv eq_h4_mul_a24 : MHop2.mul_a24 ~ M._fe64_mul_a24:
   f{1} = inzpRep4 fs{2} /\
   a24{1} = to_uint a24{2}
    ==>
   res{1} = inzpRep4 res{2}.
proof.
proc.
admit.
qed.

equiv eq_h4_mul : MHop2.mul ~ M._fe64_mul_rsr:
   f{1} = inzpRep4 fs{2} /\
   g{1} = inzpRep4 g{2}
    ==>
   res{1} = inzpRep4 res{2}.
proof.
proc.
admit.
qed.

equiv eq_h4_sqr : MHop2.sqr ~ M._fe64_sqr_rr:
    f{1} = inzpRep4 f{2}
    ==>
    res{1} = inzpRep4 res{2}.
proof.
proc.
admit.
qed.

(** step 0.5 : transitivity stuff **)
equiv eq_h4_add_ssr : MHop2.add ~ M._fe64_add_ssr:
   f{1} = inzpRep4 fs{2} /\
   g{1} = inzpRep4 g{2}
    ==>
   res{1} = inzpRep4 res{2}.
proof.
proc.
admit.
qed.

equiv eq_h4_add_sss : MHop2.add ~ M._fe64_add_sss:
   f{1} = inzpRep4 fs{2} /\
   g{1} = inzpRep4 gs{2}
    ==>
   res{1} = inzpRep4 res{2}.
proof.
proc.
admit.
qed.

equiv eq_h4_sub_ssr : MHop2.sub ~ M._fe64_sub_ssr:
   f{1} = inzpRep4 fs{2} /\
   g{1} = inzpRep4 g{2}
    ==>
   res{1} = inzpRep4 res{2}.
proof.
proc.
admit.
qed.

equiv eq_h4_sub_sss : MHop2.sub ~ M._fe64_sub_sss:
   f{1} = inzpRep4 fs{2} /\
   g{1} = inzpRep4 gs{2}
    ==>
   res{1} = inzpRep4 res{2}.
proof.
proc.
admit.
qed.

equiv eq_h4_mul_a24_ss : MHop2.mul_a24 ~ M._fe64_mul_a24_ss:
   f{1} = inzpRep4 fs{2} /\
   a24{1} = to_uint a24{2}
    ==>
   res{1} = inzpRep4 res{2}.
proof.
proc.
admit.
qed.

equiv eq_h4_mul_rss : MHop2.mul ~ M._fe64_mul_rss:
   f{1} = inzpRep4 fs{2} /\
   g{1} = inzpRep4 gs{2}
    ==>
   res{1} = inzpRep4 res{2}.
proof.
proc.
admit.
qed.

equiv eq_h4_mul_ssr : MHop2.mul ~ M._fe64_mul_ssr:
   f{1} = inzpRep4 fs{2} /\
   g{1} = inzpRep4 g{2}
    ==>
   res{1} = inzpRep4 res{2}.
proof.
proc.
admit.
qed.

equiv eq_h4_mul_sss : MHop2.mul ~ M._fe64_mul_sss:
   f{1} = inzpRep4 fs{2} /\
   g{1} = inzpRep4 gs{2}
    ==>
   res{1} = inzpRep4 res{2}.
proof.
proc.
admit.
qed.

equiv eq_h4_sqr_rs : MHop2.sqr ~ M._fe64_sqr_rs:
    f{1} = inzpRep4 fs{2}
    ==>
    res{1} = inzpRep4 res{2}.
proof.
proc.
admit.
qed.

equiv eq_h4_sqr_ss : MHop2.sqr ~ M._fe64_sqr_ss:
    f{1} = inzpRep4 fs{2}
    ==>
    res{1} = inzpRep4 res{2}.
proof.
proc.
admit.
qed.

(** step 1 : decode_scalar_25519 **)
equiv eq_h4_decode_scalar_25519 :
  MHop2.decode_scalar_25519 ~ M.decode_scalar_25519:
  true ==> true.
proof.
admit.
qed.

(** step 2 : decode_u_coordinate **)
equiv eq_h4_decode_u_coordinate :
  MHop2.decode_u_coordinate ~ M.decode_u_coordinate:
  true ==> true.
proof.
admit.
qed.

(** step 3 : ith_bit **)
equiv eq_h4_ith_bit :
  MHop2.ith_bit ~ M.ith_bit:
  true ==> true.
proof.
admit.
qed.

(** step 4 : cswap **)
equiv eq_h4_cswap :
  MHop2.cswap ~ M._fe64_cswap:
  x2{1}         = inzpRep4 x2{2}  /\
  z2{1}         = inzpRep4 z2r{2} /\
  x3{1}         = inzpRep4 x3{2}  /\
  z3{1}         = inzpRep4 z3{2}  /\
  b2i toswap{1} = to_uint toswap{2}
  ==>
  res{1}.`1     = inzpRep4 res{2}.`1  /\
  res{1}.`2     = inzpRep4 res{2}.`2  /\
  res{1}.`3     = inzpRep4 res{2}.`3  /\
  res{1}.`4     = inzpRep4 res{2}.`4.
proof.
proc.
do 4! unroll for{2} ^while.
case: (toswap{1}).
  rcondt {1} 1 => //. wp => /=; skip.
    move => &1 &2 [#] 4!->> ??.
    have mask_set :  (set0_64.`6 - toswap{2}) = W64.onew. rewrite /set0_64 /=. smt(@W64).
    rewrite !mask_set /=.
    have lxor1 : forall (x1 x2:W64.t),  x1 `^` (x2 `^` x1) = x2.
      move=> *. rewrite xorwC -xorwA xorwK xorw0 //.
    have lxor2 : forall (x1 x2:W64.t),  x1 `^` (x1 `^` x2) = x2.
      move=> *. rewrite xorwA xorwK xor0w //. 
  rewrite !lxor1 !lxor2.
      split. congr. apply Array4.ext_eq. smt(@Array4).
      split. congr. apply Array4.ext_eq. smt(@Array4).
      split. congr. apply Array4.ext_eq. smt(@Array4).
             congr. apply Array4.ext_eq. smt(@Array4).
  rcondf {1} 1 => //. wp => /=; skip.
    move => &1 &2 [#] 4!->> ??.
    have mask_not_set :  (set0_64.`6 - toswap{2}) = W64.zero. smt(@W64).
    rewrite !mask_not_set !andw0 !xorw0.
    smt(@Array4).
qed.

(** step 5 : add_and_double **)
equiv eq_h4_add_and_double :
  MHop2.add_and_double ~ M.add_and_double:
  init{1} = inzpRep4 init{2} /\
  x2{1}   = inzpRep4 x2{2}   /\
  z2{1}   = inzpRep4 z2r{2}  /\
  x3{1}   = inzpRep4 x3{2}   /\
  z3{1}   = inzpRep4 z3{2}
  ==>
  res{1}.`1 = inzpRep4 res{2}.`1 /\
  res{1}.`2 = inzpRep4 res{2}.`2 /\
  res{1}.`3 = inzpRep4 res{2}.`3 /\
  res{1}.`4 = inzpRep4 res{2}.`4.
proof.
proc => /=.
  call eq_h4_mul_rss.
  call eq_h4_mul_sss.
  call eq_h4_add_sss.
  call eq_h4_sqr_ss.
  call eq_h4_mul_a24_ss.
  call eq_h4_sqr_ss.
  call eq_h4_sub_ssr.
  call eq_h4_mul_ssr.
  call eq_h4_sub_sss.
  call eq_h4_add_sss.
  call eq_h4_sqr_rs.
  call eq_h4_sqr_ss.
  call eq_h4_mul_sss.
  call eq_h4_mul_sss.
  call eq_h4_add_sss.
  call eq_h4_sub_sss.
  call eq_h4_add_ssr.
  call eq_h4_sub_ssr.
  wp. done.
qed.

(** step 6 : montgomery_ladder_step **)
equiv eq_h4_montgomery_ladder_step :
 MHop2.montgomery_ladder_step ~ M.montgomery_ladder_step:
 true ==> true.
proof.
admit.
qed.   

(** step 7 : montgomery_ladder **)
equiv eq_h4_montgomery_ladder :
  MHop2.montgomery_ladder ~ M.montgomery_ladder :
  true ==> true.
proof.
admit.
qed.

(** step 8 : iterated square **)
equiv eq_h4_it_sqr :
 MHop2.it_sqr ~ M._fe64_it_sqr:
   f{1}            =    inzpRep4 f{2} /\
   i{1}            =    to_uint i{2}  /\
   i{1}            <=   W64.modulus   /\
    2              <=   i{1}          /\
   i{1} %% 2        =   0
   ==>
   res{1} = inzpRep4 res{2}.`2.
proof.
proc.
  while (f{1}            =    inzpRep4 f{2}            /\ 
         i{1}            =    to_uint i{2}             /\
         i{1}            <=   W64.modulus              /\
         0               <=   i{1}                     /\
         i{1}            %%   2 = 0 /\
         zf{2} = (i{2} = W64.zero)).
  swap 2 3 3. wp. conseq(_: _ ==> f{1} = inzpRep4 f{2}).
  move=> &1 &2 [#] ????? ->> ?? ??? /=.
    rewrite /DEC_64 /rflags_of_aluop_nocf64 /ZF_of_w64 => /=.
    progress.
    smt(@W64). move : H1; smt(). smt(). smt(). smt(@W64). smt(@W64).
  by do 2! call eq_h4_sqr; skip; done.
  swap 3 4 4. wp. conseq(_: _ ==> f{1} = inzpRep4 f{2}).
  move=> &1 &2 [#] /= ->> ->> ??? ?? ->> /=.
    rewrite /DEC_64 /rflags_of_aluop_nocf64 /ZF_of_w64 => /=.
    progress.
    smt(@W64). move : H1; smt(). smt(). smt(). smt(@W64). smt(@W64).
  by do 2! call eq_h4_sqr; wp; skip; done.
qed.

(** step 9 : invert **)
equiv eq_h4_invert :
  MHop2.invert ~ M._fe64_invert : 
     z1'{1} = inzpRep4 f{2}
  ==> res{1} = inzpRep4 res{2}.
proof.
proc.
  call eq_h4_mul.
  call eq_h4_sqr.
  call eq_h4_it_sqr. wp.
  call eq_h4_mul.
  call eq_h4_it_sqr. wp.
  call eq_h4_mul.
  call eq_h4_it_sqr. wp.
  call eq_h4_mul.
  call eq_h4_it_sqr. wp.
  call eq_h4_mul.
  call eq_h4_it_sqr. wp.
  call eq_h4_mul.
  call eq_h4_it_sqr. wp.
  call eq_h4_mul.
  call eq_h4_it_sqr. wp.
  call eq_h4_mul. wp.
  call eq_h4_it_sqr. wp.
  call eq_h4_sqr. wp.
  call eq_h4_mul.
  call eq_h4_sqr. wp.
  call eq_h4_mul. wp.
  call eq_h4_mul.
  call eq_h4_sqr.
  call eq_h4_sqr. wp.
  call eq_h4_sqr. wp.
  done.
qed.

(** step 10 : encode point **)
equiv eq_h4_encode_point : 
  MHop2.encode_point ~ M.encode_point:
  true ==> true.
proof.
admit.
qed.

(** step 11 : scalarmult **)
equiv eq_h4_scalarmult :
  MHop2.scalarmult ~ M._x25519_scalarmult:
  true ==> true.
proof.
admit.
qed.

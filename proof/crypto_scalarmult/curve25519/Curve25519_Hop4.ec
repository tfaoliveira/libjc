require import AllCore Bool List Int IntDiv CoreMap Real Zp25519.
from Jasmin require import JModel.
from JasminExtra require import JBigNum.
require import Curve25519_Spec Curve25519_Hop1 Curve25519_Hop2 Curve25519_Hop3.

require import Curve25519_smulx.
import Zp ZModpRing.
require import Array4 Array8.

(** step 0 : add sub mul sqr **)
equiv eq_h4_add_rrs : MHop2.add ~ M.__add4_rrs:
   ImplFpC f{1} f{2} /\
   ImplFpC g{1} g{2}
    ==>
   ImplFpC res{1} res{2}.
proof.
proc.
admit.
qed.

equiv eq_h4_sub_rrs : MHop2.sub ~ M.__sub4_rrs:
   ImplFpC f{1} f{2} /\
   ImplFpC g{1} gs{2}
    ==>
   ImplFpC res{1} res{2}.
proof.
proc.
admit.
qed.

equiv eq_h4_mul_a24_rs : MHop2.mul_a24 ~ M.__mulx_mul4_a24_rs:
   ImplFpC f{1} fs{2} /\
   a24{1} = to_uint a24{2}
    ==>
   ImplFpC res{1} res{2}.
proof.
proc.
admit.
qed.

equiv eq_h4_mul_rss : MHop2.mul ~ M.__mulx_mul4_rss:
   ImplFpC f{1} fs{2} /\
   ImplFpC g{1} gs{2}
    ==>
   ImplFpC res{1} res{2}.
proof.
proc.
admit.
qed.

equiv eq_h4_sqr_rr : MHop2.sqr ~ M.__mulx_sqr4_rr:
    ImplFpC f{1} f{2}
    ==>
    ImplFpC res{1} res{2}.
proof.
proc.
admit.
qed.

(** step 0.5 : transitivity **** **** **** **** *)

(** add **)
equiv eq_h4_add_ssr : MHop2.add ~ M.__add4_ssr:
   ImplFpC f{1} fs{2} /\
   ImplFpC g{1} g{2}
    ==>
   ImplFpC res{1} res{2}.
proof.
proc.
admit.
qed.

equiv eq_h4_add_sss : MHop2.add ~ M.__add4_sss:
   ImplFpC f{1} fs{2} /\
   ImplFpC g{1} gs{2}
    ==>
   ImplFpC res{1} res{2}.
proof.
proc.
admit.
qed.

(** sub **)
equiv eq_h4_sub_ssr : MHop2.sub ~ M.__sub4_ssr:
   ImplFpC f{1} fs{2} /\
   ImplFpC g{1} g{2}
    ==>
   ImplFpC res{1} res{2}.
proof.
proc.
admit.
qed.

equiv eq_h4_sub_sss : MHop2.sub ~ M.__sub4_sss:
   ImplFpC f{1} fs{2} /\
   ImplFpC g{1} gs{2}
    ==>
   ImplFpC res{1} res{2}.
proof.
proc.
admit.
qed.

(** mul a24 **)
equiv eq_h4_mul_a24_ss : MHop2.mul_a24 ~ M.__mulx_mul4_a24_ss:
   ImplFpC f{1} fs{2} /\
   a24{1} = to_uint a24{2}
    ==>
   ImplFpC res{1} res{2}.
proof.
proc.
admit.
qed.

(** mul **)
equiv eq_h4_mul_ssr : MHop2.mul ~ M.__mulx_mul4_ssr:
   ImplFpC f{1} fs{2} /\
   ImplFpC g{1} g{2}
    ==>
   ImplFpC res{1} res{2}.
proof.
proc.
admit.
qed.

equiv eq_h4_mul_sss : MHop2.mul ~ M.__mulx_mul4_sss:
   ImplFpC f{1} fs{2} /\
   ImplFpC g{1} gs{2}
    ==>
   ImplFpC res{1} res{2}.
proof.
proc.
admit.
qed.


(** sqr **)
equiv eq_h4_sqr_rs : MHop2.sqr ~ M.__mulx_sqr4_rs:
    ImplFpC f{1} fs{2}
    ==>
    ImplFpC res{1} res{2}.
proof.
proc.
admit.
qed.

equiv eq_h4_sqr_ss : MHop2.sqr ~ M.__mulx_sqr4_ss:
    ImplFpC f{1} fs{2}
    ==>
    ImplFpC res{1} res{2}.
proof.
proc.
admit.
qed.

(** step 1 : decode_scalar_25519 **)
equiv eq_h4_decode_scalar_25519 :
  MHop2.decode_scalar_25519 ~ M.__decode_scalar_25519_shl1:
  true ==> true.
proof.
admit.
qed.

(** step 2 : decode_u_coordinate **)
equiv eq_h4_decode_u_coordinate :
  MHop2.decode_u_coordinate ~ M.__decode_u_coordinate:
  true ==> true.
proof.
admit.
qed.

(** step 3 : ith_bit **) (** TODO CHECKME : this should be handled before Hop4 **)
equiv eq_h4_ith_bit :
  MHop2.ith_bit ~ M.__next_bit:
  true ==> true.
proof.
proc.
admit.
qed.

(** step 4 : cswap **)
equiv eq_h4_cswap :
  MHop2.cswap ~ M.__cswap4:
  ImplFpC x2{1} x2{2}  /\
  ImplFpC z2{1} z2r{2} /\
  ImplFpC x3{1} x3{2}  /\
  ImplFpC z3{1} z3{2}  /\
  b2i toswap{1} = to_uint toswap{2}
  ==>
  ImplFpC res{1}.`1 res{2}.`1  /\
  ImplFpC res{1}.`2 res{2}.`2  /\
  ImplFpC res{1}.`3 res{2}.`3  /\
  ImplFpC res{1}.`4 res{2}.`4.
proof.
proc.
do 4! unroll for{2} ^while.
case: (toswap{1}).
  rcondt {1} 1 => //. wp => /=; skip.
    admit.
(** TODO FROM HERE
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
**)
  admit.
qed.

(** step 5 : add_and_double **)
equiv eq_h4_add_and_double :
  MHop2.add_and_double ~ M.__add_and_double_mulx:
  ImplFp  init{2} init{1} /\
  ImplFpC x2{1} x2{2}     /\
  ImplFpC z2{1} z2r{2}    /\
  ImplFpC x3{1} x3{2}     /\
  ImplFpC z3{1} z3{2}
  ==>
  ImplFpC res{1}.`1 res{2}.`1 /\
  ImplFpC res{1}.`2 res{2}.`2 /\
  ImplFpC res{1}.`3 res{2}.`3 /\
  ImplFpC res{1}.`4 res{2}.`4.
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
  wp. skip => /#.
qed.

(** step 6 : montgomery_ladder_step **)
equiv eq_h4_montgomery_ladder_step :
 MHop2.montgomery_ladder_step ~ M.__montgomery_ladder_mulx:
 true ==> true.
proof.
admit.
qed.   

(** step 7 : montgomery_ladder **)
equiv eq_h4_montgomery_ladder :
  MHop2.montgomery_ladder ~ M.__montgomery_ladder_mulx :
  true ==> true.
proof.
admit.
qed.

(** step 8 : iterated square **)
equiv eq_h4_it_sqr :
 MHop2.it_sqr ~ M.__mulx_it_sqr4_x2:
   ImplFpC f{1} f{2}                  /\
   i{1}            =    to_uint i{2}  /\
   i{1}            <=   W64.modulus   /\
    2              <=   i{1}          /\
   i{1} %% 2        =   0
   ==>
   ImplFpC res{1} res{2}.`2.
proof.
proc.
  while (f{1}            =    inzpRep4 f{2}            /\ 
         i{1}            =    to_uint i{2}             /\
         i{1}            <=   W64.modulus              /\
         0               <=   i{1}                     /\
         i{1}            %%   2 = 0 /\
         zf{2} = (i{2} = W64.zero)).
  swap 2 3 3. wp. conseq(_: _ ==> f{1} = inzpRep4 f{2}).
  move=> &1 &2 [#] ????? ->> ?? ??? /=. print DEC_64.
    rewrite /DEC_64 /rflags_of_aluop_nocf_w /ZF_of_w64 => /=.
    progress.
    smt(@W64). move : H1; smt(). smt(). smt(). smt(@W64). smt(@W64).
  by do 2! call eq_h4_sqr; skip; done.
  swap 3 4 4. wp. conseq(_: _ ==> f{1} = inzpRep4 f{2}).
  move=> &1 &2 [#] /= ->> ->> ??? ?? ->> /=.
    rewrite /DEC_64 /rflags_of_aluop_nocf_w /ZF_of_w64 => /=.
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

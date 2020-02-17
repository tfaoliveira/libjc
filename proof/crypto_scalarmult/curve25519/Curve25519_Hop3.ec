require import Bool List Int IntExtra IntDiv CoreMap Real Zp.
from Jasmin require import JModel.
require import Curve25519_Spec.
require import Curve25519_Hop1.
require import Curve25519_Hop2.

import Zp ZModpRing Curve25519_Spec Curve25519_Hop1 Curve25519_Hop2.

(** step 1 : decode_scalar_25519 **)
lemma ill_decode_scalar_25519 : islossless MHop2.decode_scalar_25519.
proof. islossless. qed.

lemma eq_h3_decode_scalar_25519 k:
  phoare [ MHop2.decode_scalar_25519 : k' = k
           ==> res = decodeScalar25519 k] = 1%r.
proof. by conseq ill_decode_scalar_25519 (eq_h2_decode_scalar_25519 k). qed.

(** step 2 : decode_u_coordinate **)
lemma ill_decode_u_coordinate : islossless MHop2.decode_u_coordinate.
proof. islossless. qed.

lemma eq_h3_decode_u_coordinate u:
  phoare [ MHop2.decode_u_coordinate : u' = u
           ==> res = decodeUCoordinate u] = 1%r.
proof. by conseq ill_decode_u_coordinate (eq_h2_decode_u_coordinate u). qed.
  
(** step 3 : ith_bit **)
lemma ill_ith_bit : islossless MHop2.ith_bit.
proof. islossless. qed.

lemma eq_h3_ith_bit (k : W256.t) i:
  phoare [MHop2.ith_bit : k' = k /\ ctr = i ==> res = ith_bit k i] = 1%r.
proof. by conseq ill_ith_bit (eq_h2_ith_bit k i). qed.

(** step 4 : cswap **)
lemma ill_cswap : islossless MHop2.cswap.
proof. islossless. qed.

lemma eq_h3_cswap (t : (zp * zp) * (zp * zp) )  b:
  phoare [MHop2.cswap : x2 = (t.`1).`1 /\
                        z2 = (t.`1).`2 /\
                        x3 = (t.`2).`1 /\
                        z3 = (t.`2).`2 /\
                       toswap = b 
          ==> ((res.`1, res.`2),(res.`3, res.`4)) = cswap t b] = 1%r.
proof. by conseq ill_cswap (eq_h2_cswap t b). qed.

(** step 5 : add_and_double **)
lemma ill_add_and_double : islossless MHop2.add_and_double.
proof. islossless. qed.

lemma eq_h3_add_and_double (qx : zp) (nqs : (zp * zp) * (zp * zp)):
  phoare [MHop2.add_and_double : init = qx /\ 
                                 x2 = nqs.`1.`1 /\
                                 z2 = nqs.`1.`2 /\
                                 x3 = nqs.`2.`1 /\
                                 z3 = nqs.`2.`2
          ==> ((res.`1, res.`2),(res.`3, res.`4)) = add_and_double1 qx nqs] = 1%r.
proof. by conseq ill_add_and_double (eq_h2_add_and_double qx nqs). qed.

(** step 6 : montgomery_ladder_step **)
lemma ill_montgomery_ladder_step : islossless MHop2.montgomery_ladder_step.
proof. islossless. qed.

lemma eq_h3_montgomery_ladder_step (k : W256.t) 
                                   (init : zp)
                                   (nqs : (zp * zp) * (zp * zp) * bool) 
                                   (ctr : int) :
  phoare [MHop2.montgomery_ladder_step : k' = k /\ 
                                         init' = init /\
                                         x2 = nqs.`1.`1 /\
                                         z2 = nqs.`1.`2 /\
                                         x3 = nqs.`2.`1 /\
                                         z3 = nqs.`2.`2 /\
                                         swapped = nqs.`3 /\
                                         ctr' = ctr
          ==> ((res.`1, res.`2),(res.`3, res.`4),res.`5) =
              montgomery_ladder3_step k init nqs ctr] = 1%r.
proof. by conseq ill_montgomery_ladder_step (eq_h2_montgomery_ladder_step k init nqs ctr). qed.

(** step 7 : montgomery_ladder **)
lemma ill_montgomery_ladder : islossless MHop2.montgomery_ladder.
proof.
  islossless. while true (ctr+1). move => ?. wp. simplify.
  call(_:true ==> true). islossless. skip; smt().
  skip; smt().
qed.

lemma eq_h3_montgomery_ladder (init : zp)
                              (k : W256.t) :
  phoare [MHop2.montgomery_ladder : init' = init /\
                                    k.[0] = false /\
                                    k' = k
          ==> ((res.`1, res.`2),(res.`3,res.`4)) =
              select_tuple_12 (montgomery_ladder3 init k)] = 1%r.
proof. by conseq ill_montgomery_ladder (eq_h2_montgomery_ladder init k). qed.

(** step 8 : iterated square **)
lemma ill_it_sqr : islossless MHop2.it_sqr.
proof.
  islossless. while true i. move => ?. wp.
  inline MHop2.sqr. wp. skip. smt().
  skip. smt().
qed.

lemma eq_h3_it_sqr (e : int) (z : zp) : 
  phoare[MHop2.it_sqr :
          i = e && 2 <= i && i %% 2 = 0 && f =  z 
          ==>
          res = it_sqr1 e z] = 1%r.
proof. by conseq ill_it_sqr (eq_h2_it_sqr e z). qed.

(** step 9 : invert **)
lemma ill_invert : islossless MHop2.invert.
proof.
  proc.
  inline MHop2.sqr MHop2.mul.
  wp; sp. call(_: true ==> true). apply ill_it_sqr.
  wp; sp. call(_: true ==> true). apply ill_it_sqr.
  wp; sp. call(_: true ==> true). apply ill_it_sqr.
  wp; sp. call(_: true ==> true). apply ill_it_sqr.
  wp; sp. call(_: true ==> true). apply ill_it_sqr.
  wp; sp. call(_: true ==> true). apply ill_it_sqr.
  wp; sp. call(_: true ==> true). apply ill_it_sqr.
  wp; sp. call(_: true ==> true). apply ill_it_sqr.
  skip. trivial.
qed.

lemma eq_h3_invert (z : zp) : 
  phoare[MHop2.invert : z1' =  z ==> res = invert2 z] = 1%r.
proof. by conseq ill_invert (eq_h2_invert z). qed.

(** step 10 : encode point **)
lemma ill_encode_point : islossless MHop2.encode_point.
proof.
  proc. inline MHop2.mul. wp; sp. call(_: true ==> true). apply ill_invert.
  skip. trivial.
qed.

lemma eq_h3_encode_point (q : zp * zp) : 
  phoare[MHop2.encode_point : x2 =  q.`1 /\ z2 = q.`2 ==> res = encodePoint1 q] = 1%r.
proof. by conseq ill_encode_point (eq_h2_encode_point q). qed.

(** step 11 : scalarmult **)
lemma ill_scalarmult : islossless MHop2.scalarmult.
proof.
  proc. sp.
  call(_: true ==> true). apply ill_encode_point.
  call(_: true ==> true). apply ill_montgomery_ladder.
  call(_: true ==> true). apply ill_decode_u_coordinate.
  call(_: true ==> true). apply ill_decode_scalar_25519.
  skip. trivial.
qed.

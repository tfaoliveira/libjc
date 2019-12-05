require import Bool List Int IntExtra IntDiv CoreMap Real.
require import Zp.
import Zp.

from Jasmin require import JModel.

require import Curve25519_Spec.

(** equiv between add_and_double with add_and_double1 - reordered **)
op add_and_double1 (qx : zp) (nqs : (zp * zp) * (zp * zp)) =
  let x1 = qx in
  let (x2, z2) = nqs.`1 in
  let (x3, z3) = nqs.`2 in
  let t0 = x2 + (- z2) in
  let x2 = x2 + z2 in 
  let t1 = x3 + (- z3) in
  let z2 = x3 + z3 in
  let z3 = x2 * t1 in
  let z2 = z2 * t0 in
  let t2 = x2 * x2 in
  let t1 = t0 * t0 in
  let x3 = z3 + z2 in
  let z2 = z3 + (- z2) in
  let x2 = t2 * t1 in
  let t0 = t2 + (- t1) in
  let z2 = z2 * z2 in
  let z3 = t0 * (inzp 121665) in
  let x3 = x3 * x3 in
  let t2 = t2 + z3 in
  let z3 = x1 * z2 in
  let z2 = t0 * t2
  in  ((x2,z2), (x3,z3)).

lemma eq_add_and_double1 (qx : zp) (nqs : (zp * zp) * (zp * zp)) :
  forall qx nqs, add_and_double qx nqs = add_and_double1 qx nqs.
proof.
rewrite /add_and_double /add_and_double1.
simplify => /#.
qed.

(** move ith_bit outside : montgomery_ladder1 **)
op montgomery_ladder1(init : zp, k : W256.t) =
  let nqs0 = ((Zp.one,Zp.zero),(init,Zp.one)) in
  let nqs = foldl (fun (nqs : (zp * zp) * (zp * zp)) bit => 
                   if bit
                   then swap_ (add_and_double init (swap_(nqs)))
                   else add_and_double init nqs) nqs0 (map (fun i => ith_bit k i) (rev (iota_ 0 255)))
  in nqs.`1.

lemma eq_montgomery_ladder1 (init : zp) (k : W256.t) :
  forall init k, montgomery_ladder init k = montgomery_ladder1 init k.
proof.
rewrite /montgomery_ladder /montgomery_ladder1.
by simplify rev.
qed.

(** isolate foldl function : montgomery_ladder2 **)
op montgomery_ladder2_step(init, nqs : (zp * zp) * (zp * zp), bit) =
  if bit
  then swap_ (add_and_double init (swap_(nqs)))
  else add_and_double init nqs.

op montgomery_ladder2(init : zp, k : W256.t) =
  let nqs0 = ((Zp.one,Zp.zero),(init,Zp.one)) in
  let nqs = foldl (montgomery_ladder2_step init) nqs0
                  (map (fun i => ith_bit k i) (rev (iota_ 0 255)))
  in nqs.`1.

lemma eq_montgomery_ladder2 (init : zp) (k : W256.t) :
  forall init k, montgomery_ladder1 init k = montgomery_ladder2 init k.
proof.
rewrite /montgomery_ladder1 /montgomery_ladder2.
rewrite /montgomery_ladder2_step.
by simplify rev.
qed.

(** extend nqs to contain an additional bit stating if the state is swapped **)
op montgomery_ladder3_step(init, nqs : (zp * zp) * (zp * zp) * bool, bit : bool) =
  let nqs = if nqs.`3 ^^ bit
            then add_and_double init (nqs.`2, nqs.`1)
            else add_and_double init (nqs.`1, nqs.`2)
  in (nqs.`1, nqs.`2, bit). 

op select_tuple_12 (t : 'a * 'b * 'c) = (t.`1, t.`2).

op reconstruct_nqs (nqs : (zp * zp) * (zp * zp) * bool) =
  if nqs.`3
  then swap_ (select_tuple_12 nqs)
  else select_tuple_12 nqs.

lemma eq_montgomery_ladder3_step (init : zp) (nqs : (zp * zp) * (zp * zp) * bool) (bit : bool) :
    forall init nqs bit,
    reconstruct_nqs (montgomery_ladder3_step init nqs bit) =
    montgomery_ladder2_step init (select_tuple_12 nqs) bit.
proof.
rewrite /reconstruct_nqs /montgomery_ladder3_step /montgomery_ladder2_step.
rewrite /swap_ /select_tuple_12 /(^^).
simplify.
admit.
qed.

op montgomery_ladder3(init : zp, k : W256.t) =
  let nqs0 = ((Zp.one,Zp.zero),(init,Zp.one),false) in
  let nqs = foldl (montgomery_ladder3_step init) nqs0
                  (map (fun i => ith_bit k i) (rev (iota_ 0 255))) in
     nqs.`1.

lemma eq_montgomery_ladder3 (init : zp) (k : W256.t) :
  (* k1 contains first bits at 0 which means that it will be swapped *)
  let k1 = decodeScalar25519 k in
  forall init, montgomery_ladder2 init k1 = montgomery_ladder3 init k1.
proof.
rewrite /montgomery_ladder2 /montgomery_ladder3.
admit.
qed.

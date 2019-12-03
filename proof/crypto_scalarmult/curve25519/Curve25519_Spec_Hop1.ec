require import List Int IntExtra IntDiv CoreMap Real.
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
  let z2 = t0 * t2 in
  ((x2,z2), (x3,z3)).

lemma eq_add_and_double1 (qx : zp) (nqs : (zp * zp) * (zp * zp)) :
  forall qx nqs, add_and_double qx nqs = add_and_double1 qx nqs.
proof.
rewrite /add_and_double /add_and_double1.
simplify => /#.
qed.

(** removing the first if ctr = 0 - to get closer to the implementation **)
op montgomery_ladder1(init : zp, k : W256.t) =
  let nqs0 = ((Zp.one,Zp.zero),(init,Zp.one)) in
  foldl (fun (nqs : (zp * zp) * (zp * zp)) ctr => 
             if k.[254-ctr]
             then swap_ (add_and_double init (swap_(nqs)))
             else add_and_double init nqs) nqs0 (iota_ 0 255).

lemma eq_montgomery_ladder1 (init : zp) (k : W256.t) :
  forall init k, montgomery_ladder init k = montgomery_ladder1 init k.
proof.
admit. (**still need to check how the math works for this**)
qed.
    
(** define a conditional swap and redefine ladder
     - since montgomery ladder is defined using a fold
       we need to have the swap bit in a state
**)
op cswap_( nqs_b : (zp * zp) * (zp * zp) * bool ) =
  if nqs_b.`3
  then (nqs_b.`2, nqs_b.`1)
  else (nqs_b.`1, nqs_b.`2). 

op montgomery_ladder2(init : zp, k : W256.t) =
  let nqs0 = ((Zp.one,Zp.zero),(init,Zp.one),false) in
  let nqs = foldl (fun (nqs : (zp * zp) * (zp * zp) * bool) ctr => 
                       let bit = k.[254-ctr] in
                       let nqs = cswap_ (nqs.`1, nqs.`2, nqs.`3 ^ bit) in
                       let nqs' = add_and_double1 init nqs in
                       (nqs'.`1, nqs'.`2, bit)) nqs0 (iota_ 0 255)
  in (nqs.`1, nqs.`2). 

lemma eq_montgomery_ladder2 (init : zp) (k : W256.t) :
  forall init k, montgomery_ladder1 init k = montgomery_ladder2 init k.
proof.
admit.
qed.

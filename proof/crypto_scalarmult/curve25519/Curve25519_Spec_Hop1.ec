require import Bool List Int IntExtra IntDiv CoreMap Real.
require import Zp.
import Zp.

from Jasmin require import JModel.

require import Curve25519_Spec.

(** generic stuff **)

(* returns the first 2 elements of the input triple *)
op select_tuple_12 (t : 'a * 'a * 'c) = (t.`1, t.`2).

(* if the third element is true then the first 2 elements are swapped *)
(*  - this op returns the first 2 elements in the correct order       *)
op reconstruct_tuple (t : 'a * 'a * bool) =
  if t.`3
  then swap_tuple (select_tuple_12 t)
  else select_tuple_12 t.

lemma eq_reconstruct_select_tuple (t : ('a * 'a * bool)) :
  t.`3 = false => 
  select_tuple_12 t = reconstruct_tuple t.
proof.
  rewrite /reconstruct_tuple /select_tuple_12.
  by move => ? /#.
qed.

(* similar to foldl_in_eq -- the proof is the same -- defined in JMemory           *)
(* - foldl_in_eq states that any 2 foldl's are the same if the functions are equiv *)
(* - we will need to prove that + that the state a2 have a relational invariant r  *)
lemma foldl_in_eq_r (f1 : 'a1 -> 'b -> 'a1)
                    (f2 : 'a2 -> 'b -> 'a2)
                    (s  : 'b list)
                    (a2 : 'a2)
                    (r  : 'a2 -> 'a1) :
(forall a2 b, b \in s => f1 (r a2) b = r (f2 a2 b)) => foldl f1 (r a2) s = r (foldl f2 a2 s).
proof.
  elim: s a2 => [ | b s hrec] a //= hin.
  by rewrite hin // hrec // => ?? h;apply hin;rewrite h.
qed.

(** step1: add_and_double = add_and_double1 : reordered to match implementation **)
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
  add_and_double qx nqs = add_and_double1 qx nqs.
proof.
  rewrite /add_and_double /add_and_double1.
  simplify => /#.
qed.

op montgomery_ladder1(init : zp, k : W256.t) =
  let nqs0 = ((Zp.one,Zp.zero),(init,Zp.one)) in
  foldl (fun (nqs : (zp * zp) * (zp * zp)) ctr => 
         if ith_bit k ctr
         then swap_tuple (add_and_double1 init (swap_tuple(nqs)))
         else add_and_double1 init nqs) nqs0 (rev (iota_ 0 255)).

(* lemma: montgomery_ladder = montgomery_ladder1 *)
lemma eq_montgomery_ladder1 (init : zp) (k : W256.t) :
  montgomery_ladder init k = montgomery_ladder1 init k.
proof.
  rewrite /montgomery_ladder /montgomery_ladder1 /=.
  apply foldl_in_eq.
  move => nqs ctr inlist => /=.
  case (ith_bit k ctr).
    by move => ?; rewrite /swap_tuple /#.
    by move => ?; rewrite /swap_tuple /#.
qed.

(** step 2: isolate foldl function and introduce reconstruct tuple **)
op montgomery_ladder2_step(k : W256.t, init : zp, nqs : (zp * zp) * (zp * zp), ctr : int) =
  if ith_bit k ctr
  then swap_tuple(add_and_double1 init (swap_tuple(nqs)))
  else add_and_double1 init nqs.

op montgomery_ladder2(init : zp, k : W256.t) =
  let nqs0 = reconstruct_tuple ((Zp.one,Zp.zero),(init,Zp.one),false) in
  foldl (montgomery_ladder2_step k init) nqs0 (rev (iota_ 0 255)).

(* lemma: montgomery_ladder1 = montgomery_ladder2 *)
lemma eq_montgomery_ladder2 (init : zp) (k : W256.t) :
  montgomery_ladder1 init k = montgomery_ladder2 init k.
proof.
  rewrite /montgomery_ladder1 /montgomery_ladder2 /reconstruct_tuple /select_tuple_12.
  rewrite /montgomery_ladder2_step.
  by simplify.
qed.

(** step 3: extend the state to contain an additional bit stating if the state is swapped **)
op montgomery_ladder3_step(k : W256.t, init : zp, nqs : (zp * zp) * (zp * zp) * bool, ctr : int) =
  let nqs = if nqs.`3 ^^ (ith_bit k ctr)
            then add_and_double1 init (nqs.`2, nqs.`1)
            else add_and_double1 init (nqs.`1, nqs.`2)
  in (nqs.`1, nqs.`2, (ith_bit k ctr)).

op montgomery_ladder3(init : zp, k : W256.t) =
  let nqs0 = ((Zp.one,Zp.zero),(init,Zp.one),false) in
  foldl (montgomery_ladder3_step k init) nqs0 (rev (iota_ 0 255)).

lemma eq_montgomery_ladder3_reconstruct (init : zp) (k: W256.t) :
  montgomery_ladder2 init k = reconstruct_tuple (montgomery_ladder3 init k).
proof.
  rewrite /montgomery_ladder2 /montgomery_ladder3 //=.
  apply foldl_in_eq_r.
  move => ? ? ?.
  rewrite /reconstruct_tuple /montgomery_ladder2_step /montgomery_ladder3_step.
  rewrite /swap_tuple /select_tuple_12 /(^^).
  simplify => /#.
qed.

(* lemma: if the first bit of k is 0, which will be because of decodeScalar25519, *)
(*  then montgomery_ladder2 = select_tuple_12 montgomery_ladder3 *)
lemma eq_montgomery_ladder3 (init : zp) (k: W256.t) :
  k.[0] = false =>
  montgomery_ladder2 init k = select_tuple_12 (montgomery_ladder3 init k).
proof.
  move => hkf.
  have tbf : (montgomery_ladder3 init k).`3 = false. (*third bit false*)
    rewrite /montgomery_ladder3 /montgomery_ladder3_step.
    by simplify rev; rewrite /ith_bit.
  have seqr : select_tuple_12 (montgomery_ladder3 init k) = (*select eq reconstruct*)
              reconstruct_tuple (montgomery_ladder3 init k).
    by apply /eq_reconstruct_select_tuple /tbf.
  rewrite seqr.
    by apply eq_montgomery_ladder3_reconstruct.
qed.

(** step 4: montgomery_ladder = select_tuple_12 montgomery_ladder3 **)
lemma eq_montgomery_ladder123 (init : zp) (k: W256.t) :
  k.[0] = false =>
  montgomery_ladder init k = select_tuple_12 (montgomery_ladder3 init k).
proof.
  move => hkf.
  have ml01 : montgomery_ladder init k = montgomery_ladder1 init k. (*montgomery_ladder 0 -> 1*)
    by apply eq_montgomery_ladder1.
  have ml12 : montgomery_ladder1 init k = montgomery_ladder2 init k.
    by apply eq_montgomery_ladder2.
  have ml23 : montgomery_ladder2 init k = select_tuple_12 (montgomery_ladder3 init k).
    by apply eq_montgomery_ladder3.
  rewrite ml01 ml12 ml23 //.
qed.

(** step 5: scalarmult with updated montgomery_ladder3 **)
op scalarmult1 (k:W256.t) (u:W256.t) : W256.t =
  let k = decodeScalar25519 k in
  let u = decodeUCoordinate u in
  let r = montgomery_ladder3 u k in
      encodePoint (r.`1).

(* lemma scalarmult = scalarmult1 *)
lemma eq_scalarmult1 (k:W256.t) (u:W256.t) :
  scalarmult k u = scalarmult1 k u.
proof.
  rewrite /scalarmult /scalarmult1.
  simplify.
  congr.
  have kb0f : (decodeScalar25519 k).[0] = false. (*k bit 0 false*) 
    by rewrite /decodeScalar25519 /=.
  have ml123 : montgomery_ladder (decodeUCoordinate u) (decodeScalar25519 k) =
               select_tuple_12 (montgomery_ladder3 (decodeUCoordinate u) (decodeScalar25519 k)).
    by move : kb0f; apply eq_montgomery_ladder123.
  move : ml123 => /#.
qed.

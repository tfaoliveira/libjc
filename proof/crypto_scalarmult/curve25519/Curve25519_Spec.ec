require import List Int IntExtra IntDiv CoreMap Real.
require import Zp.
import Zp.

from Jasmin require import JModel.

op decodeScalar25519 (k:W256.t) =
  let k = k.[0   <- false] in
  let k = k.[1   <- false] in
  let k = k.[2   <- false] in
  let k = k.[255 <- false] in
  let k = k.[254 <- true ] in
      k.

op decodeUCoordinate (u:W256.t) = inzp (to_uint u).

op add_and_double (qx : zp) (nqs : (zp * zp) * (zp * zp)) =
  let x_1 = qx in
  let (x_2, z_2) = nqs.`1 in
  let (x_3, z_3) = nqs.`2 in
  let a  = x_2 + z_2 in
  let aa = a * a in
  let b  = x_2 + (- z_2) in
  let bb = b*b in
  let e = aa + (- bb) in
  let c = x_3 + z_3 in
  let d = x_3 + (- z_3) in
  let da = d * a in
  let cb = c * b in
  let x_3 = (da + cb)*(da + cb) in
  let z_3 = x_1 * ((da + (- cb))*(da + (- cb))) in
  let x_2 = aa * bb in
  let z_2 = e * (aa + (inzp 121665 * e)) in
      ((x_2,z_2), (x_3,z_3)).

op swap_tuple( t : ('a * 'a) * ('a * 'a) ) = (t.`2, t.`1).

op ith_bit(k : W256.t, i : int) = k.[i].

op montgomery_ladder(init : zp, k : W256.t) =
  let nqs0 = ((Zp.one,Zp.zero),(init,Zp.one)) in
  foldl (fun (nqs : (zp * zp) * (zp * zp)) ctr => 
         if ith_bit k ctr
         then swap_tuple (add_and_double init (swap_tuple(nqs)))
         else add_and_double init nqs) nqs0 (rev (iota_ 0 255)).

op encodePoint (q: zp * zp) : W256.t =
  let q = q.`1 * (ZModpRing.exp q.`2 (p - 2)) in
      W256.of_int (asint q) axiomatized by encodePointE.

op scalarmult (k:W256.t) (u:W256.t) : W256.t =
  let k = decodeScalar25519 k in
  let u = decodeUCoordinate u in
  let r = montgomery_ladder u k in
      encodePoint (r.`1) axiomatized by scalarmultE.

hint simplify scalarmultE.

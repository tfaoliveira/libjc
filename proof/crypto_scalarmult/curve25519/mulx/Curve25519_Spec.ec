require import List JModel Int IntExtra IntDiv CoreMap Real.
require import Zp.
import Zp.

(* To specify as a memory lift 
let decodeScalar25519 (k:scalar) =
  let k   = k.[0] <- (k.[0] &^ 248uy)          in
  let k   = k.[31] <- ((k.[31] &^ 127uy) |^ 64uy) in k 

let decodePoint (u:serialized_point) =
  (little_endian u % pow2 255) % prime *)

op add_and_double (qx : zp) (nq : zp * zp) (nqp1 : zp * zp) =
  let x_1 = qx in
  let (x_2, z_2) = nq in
  let (x_3, z_3) = nqp1 in
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

let ith_bit (k:scalar) (i:nat{i < 256}) =
  let q = i / 8 in let r = i % 8 in
  (v (k.[q]) / pow2 r) % 2

let rec montgomery_ladder_ (init:elem) x xp1 (k:scalar) (ctr:nat{ctr<=256})
  : Tot proj_point (decreases ctr) =
  if ctr = 0 then x
  else (
    let ctr' = ctr - 1 in
    let (x', xp1') =
      if ith_bit k ctr' = 1 then (
        let nqp2, nqp1 = add_and_double init xp1 x in
        nqp1, nqp2
      ) else add_and_double init x xp1 in
    montgomery_ladder_ init x' xp1' k ctr'
  )

let montgomery_ladder (init:elem) (k:scalar) : Tot proj_point =
  montgomery_ladder_ init (Proj one zero) (Proj init one) k 256

let encodePoint (p:proj_point) : Tot serialized_point =
  let p = p.x `fmul` (p.z ** (prime - 2)) in
  little_bytes 32ul p

let scalarmult (k:scalar) (u:serialized_point) : Tot serialized_point =
  let k = decodeScalar25519 k in
  let u = decodePoint u in
  let res = montgomery_ladder u k in
  encodePoint res
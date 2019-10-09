require import List Int IntExtra IntDiv CoreMap Real.
require import Zp.
import Zp.

from Jasmin require import JModel.

(* First equivalence proof. Change control flow to match avx2 implementation. *)

require import Poly1305_Spec.

module Mhop1 = { 
  proc poly1305_setup(k:W64.t): zp * W64.t = {
    var r;
    r <- load_clamp Glob.mem k;
    k <- k + (W64.of_int 16);
    return (r, k);
  }
  proc poly1305_update(in_0 inlen: W64.t, h r: zp): W64.t * W64.t * zp = {
    var x;
    while (((W64.of_int 16) \ule inlen)) {
      x <- load_block Glob.mem in_0;
      h <- h + x;
      h <- h * r;
      in_0 <- (in_0 + (W64.of_int 16));
      inlen <- (inlen - (W64.of_int 16));
    }
    return (in_0, inlen, h);
  }
  proc poly1305_finish(out in_0 inlen k: W64.t, h r: zp): unit = {
    var x, h_int, s;
    if (((W64.of_int 0) \ult inlen)) {
      x <- load_lblock Glob.mem inlen in_0;
      h <- h + x;
      h <- h * r;
    }
    h_int <- (asint h) %% 2^128;
    s <- W128.to_uint (loadW128 Glob.mem (to_uint k));
    h_int <- (h_int + s) %% 2^128;
    Glob.mem <- storeW128 Glob.mem (to_uint out) (W128.of_int h_int);
    return ();
  }
  proc poly1305_short (out:W64.t, in_0:W64.t, inlen:W64.t, k:W64.t) : unit = {
    var r, h : zp;
    var s, h_int : int;
    (r, k) <@ poly1305_setup(k);
    h <- Zp.zero;
    (in_0, inlen, h) <@ poly1305_update(in_0, inlen, h, r);
    poly1305_finish(out, in_0, inlen, k, h, r);
  }
  proc poly1305_long (out:W64.t, in_0:W64.t, inlen:W64.t, k:W64.t) : unit = {
    var r, h, x : zp;
    var s, h_int : int;

    (r, k) <- poly1305_setup(k);
    h <- Zp.zero;
    
    while (((W64.of_int 64) \ule inlen)) {
      x <- load_block Glob.mem in_0;
      h <- h + x;
      h <- h * r;
      in_0 <- (in_0 + (W64.of_int 16));
      x <- load_block Glob.mem in_0;
      h <- h + x;
      h <- h * r;
      in_0 <- (in_0 + (W64.of_int 16));
      x <- load_block Glob.mem in_0;
      h <- h + x;
      h <- h * r;
      in_0 <- (in_0 + (W64.of_int 16));
      x <- load_block Glob.mem in_0;
      h <- h + x;
      h <- h * r;
      in_0 <- (in_0 + (W64.of_int 16));
      inlen <- (inlen - (W64.of_int 64));
    }
    (in_0, inlen, h) <@ poly1305_update(in_0, inlen, h, r);
    poly1305_finish(out, in_0, inlen, k, h, r);
    return ();
  }
  proc poly1305 (out:W64.t, in_0:W64.t, inlen:W64.t, k:W64.t) : unit = {
    if ((inlen \ult (W64.of_int 257))) {
      poly1305_short (out, in_0, inlen, k);
    } else {
      poly1305_long (out, in_0, inlen, k);
    }
    return ();
  }
}.

equiv hop1eq : 
    Mspec.poly1305 ~ Mhop1.poly1305 : ={Glob.mem, out, in_0, inlen, k} ==> ={Glob.mem}.
proof.
proc; if {2}.
 (* Short messages *)
 inline*; simplify.
 by swap {1} 7 -5; sim.
(* Long messages *)
simplify; inline*.
swap {1} 3 -2; swap {2} 3 -2; swap {1} 7 -4.
sp 1 5.
seq 3 4 : (#{/~ ={k}}{/~ k{2}}{/~ k1{2}}pre /\ ={r,h} /\ k{1}=k0{2}); first by auto.
splitwhile {1} 1 : (64 <= to_uint inlen0 \/ (to_uint inlen - to_uint inlen0) %% 64 <> 0).
seq 1 1 : (#{/~inlen0{2}}
            {~inlen0{1}}
            {~in_00{2}}
            {~={in_0}}
            {~={inlen}}pre /\ inlen0{1} = inlen0{2} /\
                              in_0{1} = in_00{2} /\
                              W64.to_uint inlen0{1} <= 64); last by sim.
async while
  [ (fun r => r = (to_uint inlen0)%r), 
    (to_uint inlen0{2})%r ]
  [ (fun r => r = (to_uint inlen0)%r), 
    (to_uint inlen0{1})%r ]
    (to_uint inlen0{1} = to_uint inlen0{2}) 
    (to_uint inlen0{2} <= to_uint inlen0{1})
  :
    (#{/~ ={in_0}}
      {~(in_00{2} = in_0{2})}
      {~(inlen0{1} = inlen{1})}
      {~(inlen0{2} = inlen{2})}
      {~(in_0{1} = in_00{2})}
      {~={r}}
      {~={h}}pre /\
      (to_uint inlen{2} - to_uint inlen0{2}) %% 64 = 0 /\
      (   (* in sync *)
          (to_uint inlen0{1} = to_uint inlen0{2} /\
           ={h,r} /\ in_0{1} = in_00{2}) \/
          (* 3 ahead *)
          (to_uint inlen0{1} - 3*16 = to_uint inlen0{2} /\
           ={r} /\ 
           ((((h{1} + load_block Glob.mem{1} in_0{1}) * r{1}
              + load_block Glob.mem{1} (in_0{1} + W64.of_int 16)) * r{1})
                + load_block Glob.mem{1} (in_0{1} + W64.of_int 32)) * r{1}
                  = h{2} /\
           in_0{1} + W64.of_int (3*16) = in_00{2}) \/
          (* 2 ahead *)
          (to_uint inlen0{1} - 2*16 = to_uint inlen0{2} /\
           ={r} /\ 
           (((h{1} + load_block Glob.mem{1} in_0{1}) * r{1}
              + load_block Glob.mem{1} (in_0{1} + W64.of_int 16)) * r{1}
                 = h{2})  /\
           in_0{1} + W64.of_int (2*16) = in_00{2})  \/
          (* 1 ahead *)
          (to_uint inlen0{1} - 16 = to_uint inlen0{2} /\
           ={r} /\ 
           ((h{1} + load_block Glob.mem{1} in_0{1}) * r{1}
               = h{2})  /\
           in_0{1} + W64.of_int 16 = in_00{2})
      )).
 (* inv3 => c1 \/ c2 => inv1 => c1 /\ c2 /\ f p /\ g q *)
 + by rewrite !ultE !uleE /#. 
 (* inv3 => c1 \/ c2 => !inv1 => inv2 => c1 *)
 + by rewrite !ultE !uleE /#. 
 (* inv3 => c1 \/ c2 => !inv1 => !inv2 => c2 *)
 + by rewrite !ultE !uleE /#. 
 (* {inv3 /\ c1 /\ !inv1 /\ inv2} Body1 {inv3} *)
 + move => *; wp; skip; rewrite !ultE !uleE => /> *.
   by rewrite to_uintB ?uleE //= /#.
 (* { inv3 /\ c2 /\ !inv1 /\ !inv2} Body2 {inv3} *)
 + move => *; exfalso; smt().
 + move => *. 
   while 
     (#{/~inlen0{2}}
              {~in_00{2}}
              {~={in_0}}
              {~={r}}
              {~={h}}
              {~v1_}
              {~v2_}pre /\
       (to_uint inlen{2} - to_uint inlen0{2}) %% 64 = 0 /\ 
       (  (* in sync *)
          (to_uint inlen0{1} = to_uint inlen0{2} /\
           ={h,r} /\ in_0{1} = in_00{2} /\
          v1_ = (to_uint inlen0{2})%r /\ v2_ = (to_uint inlen0{1})%r) \/
          (* 3 ahead *)
          (to_uint inlen0{1} - 3*16 = to_uint inlen0{2} /\
           ={r} /\ 
           ((((h{1} + load_block Glob.mem{1} in_0{1}) * r{1}
              + load_block Glob.mem{1} (in_0{1} + W64.of_int 16)) * r{1})
                + load_block Glob.mem{1} (in_0{1} + W64.of_int 32)) * r{1}
                  = h{2} /\
           in_0{1} + W64.of_int (3*16) = in_00{2} /\
          v1_ = (to_uint inlen0{2})%r + 64%r /\ v2_ = (to_uint inlen0{1})%r + 16%r) 
        )).
    inline *; wp; skip; rewrite !ultE !uleE => /> ????; elim; progress;
    [ 1,2,8,9: by rewrite ?uleE !to_uintB ?uleE /#
    | 3,4,10,11: by move: H7 H9; rewrite ?uleE !to_uintB ?uleE /#
    | 5..7,12..: by move: H7 H8; rewrite ?uleE !to_uintB ?uleE /#
    ].
    - skip; rewrite !ultE !uleE => /> ????; elim; progress; smt().
 (* inv3 ==> islossless while(c1 /\ !inv1 /\ inv2) Body1 *)
 + while true (W64.to_uint inlen0).
    by move => *; wp; skip; progress => //=; rewrite to_uintB /#. 
   by skip; progress; rewrite uleE /#.
 (* inv3 ==> islossless while(c1 /\ !inv1 /\ !inv2) Body2 *)
 + while (#pre) (W64.to_uint inlen0).
    by move => *; wp; skip; rewrite !ultE !uleE => ? /> ??; elim; smt().
   by skip; rewrite !ultE !uleE => ? /> ??; elim; smt().
 (* !c1 => !c2 => inv3 => #post *)
 + skip; rewrite !ultE => /> ????????.
   rewrite !uleE of_uintK /= negb_and; move => [?|?] /> ??; elim; smt(@W64).
qed.


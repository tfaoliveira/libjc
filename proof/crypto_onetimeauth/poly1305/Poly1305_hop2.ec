require import List Int IntExtra IntDiv CoreMap Real.
require import Zp.
import Zp.

from Jasmin require import JModel.

(* Second equivalence proof: introduce paralellism and prove down to
   Horner formulae using ring tactics *)

require import Poly1305_Spec Poly1305_hop1.

module Mhop2 = {

  include Mhop1[-poly1305_long, poly1305]

  proc load_4x(m:W64.t) : zp * zp * zp * zp * W64.t= {
    var m1, m2, m3, m4 : zp;
    m1 <- load_block Glob.mem m;
    m <- m + W64.of_int 16;
    m2 <- load_block Glob.mem m;
    m <- m + W64.of_int 16;
    m3 <- load_block Glob.mem m;
    m <- m + W64.of_int 16;
    m4 <- load_block Glob.mem m;
    m <- m + W64.of_int 16;
    return (m1,m2,m3,m4,m);
  }
 
  proc poly1305_long (out:W64.t, in_0:W64.t, inlen:W64.t, k:W64.t) : unit = {
    var r,h,x1,x2,x3,x4,h1,h2,h3,h4,rpow2,rpow3,rpow4:zp;
    var s:int;
    var h_int:int;

    (r,k) <@ poly1305_setup (k);
    h1 <- Zp.zero;
    h2 <- Zp.zero;
    h3 <- Zp.zero;
    h4 <- Zp.zero;
   
    rpow2 = r*r;
    rpow3 = rpow2*r;
    rpow4 = rpow3*r;
 
    (x1,x2,x3,x4,in_0) <- load_4x(in_0);
    while (((W64.of_int 128) \ule inlen)) {
      h1 <- h1 + x1;
      h1 <- h1 * rpow4;
      h2 <- h2 + x2;
      h2 <- h2 * rpow4;
      h3 <- h3 + x3;
      h3 <- h3 * rpow4;
      h4 <- h4 + x4;
      h4 <- h4 * rpow4;
      (x1,x2,x3,x4,in_0) <- load_4x(in_0);
      inlen <- (inlen - (W64.of_int 64));
    }
    inlen <- (inlen - (W64.of_int 64));
    h1 <- h1 + x1;
    h1 <- h1 * rpow4;
    h2 <- h2 + x2;
    h2 <- h2 * rpow3;
    h3 <- h3 + x3;
    h3 <- h3 * rpow2;
    h4 <- h4 + x4;
    h4 <- h4 * r;
    h = h1 + h2 + h3 + h4;
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

equiv hop2eq : 
    Mhop1.poly1305 ~ Mhop2.poly1305 : ={Glob.mem, out, in_0, inlen, k} ==> ={Glob.mem}.
proof.
proc; if => //=; first by sim.
(* long *)
inline Mhop1.poly1305_long Mhop2.poly1305_long.
call(_: ={Glob.mem}); first by auto.
call (_: ={Glob.mem}); first by sim.
seq 5 5: (={Glob.mem,out0, in_00, inlen0, k0, r} 
          /\ ! (inlen0{1} \ult (of_int 257)%W64));
first by inline*; wp; skip; progress.
seq 1 7: (#pre /\
          h{1}*rpow4{2} = h1{2}*rpow4{2}+h2{2}*rpow3{2}+h3{2}*rpow2{2}+h4{2}*r{2} /\ 
          rpow4{2} = r{2}*r{2}*r{2}*r{2} /\ 
          rpow3{2} = r{2}*r{2}*r{2} /\ 
          rpow2{2} = r{2}*r{2}); first by inline *; wp; skip; progress; ring.
seq 0 1: (#{/~ ={in_00}}pre /\ 
          x1{2} = load_block Glob.mem{2} in_00{1} /\
          x2{2} = load_block Glob.mem{2} (in_00{1} + W64.of_int 16) /\
          x3{2} = load_block Glob.mem{2} (in_00{1} + W64.of_int 32) /\
          x4{2} = load_block Glob.mem{2} (in_00{1} + W64.of_int 48) /\
          in_00{2} = in_00{1} + W64.of_int 64);
first by inline*; wp; skip; progress.
simplify; splitwhile {1} 1: ((of_int 128)%W64 \ule inlen0).
seq 1 1: (#[/1:6,7:]pre /\ (of_int 64)%W64 \ule inlen0{1} /\ inlen0{1} \ult (of_int 128)%W64).
 while (#[/1:6,7:]pre /\ (of_int 64)%W64 \ule inlen0{1}).
  inline *; wp; skip; rewrite !uleE; progress;
  last 2 by rewrite uleE //= to_uintB ?uleE /#.
  by ring H.  
 skip; progress.
   by move: H; rewrite !ultE !uleE /#.
  by move: H1; rewrite !uleE /#.
 by move: H2; rewrite !uleE ultE /#.
unroll {1} 1; rcondt {1} 1; first by auto.
rcondf {1} 18.
 progress; wp; skip; progress.
 by move: H0 H1; rewrite !ultE !uleE /= => ??; rewrite to_uintB ?uleE /#.
wp; skip; progress.
by ring H.
qed.

require import List Int IntDiv CoreMap.
require import Array2 Array3 Array4 Array5.
require import WArray16 WArray24 WArray64 WArray96 WArray128 WArray160. 
require import Ops.

require import W64limbs. (* for bW64 *)

from Jasmin require import JModel.

(* Pre-vectorized code is identical to final implementation,
   but vectorized instructions are replaced with non-vectorized
   code that can be reorganized for connection to the hop3 code. *)

require Rep3Limb Rep5Limb.

abbrev bit25_u64 = W64.of_int 16777216.
abbrev mask26_u64 = W64.of_int 67108863.
abbrev five_u64 = W64.of_int 5.
abbrev zero_u64 = W64.of_int 0.

module Mprevec = {

  module Rep3Impl = Rep3Limb.Mrep3
  
  (*********************************************)
  (*********************************************)
  (*********************************************)
  (*********************************************)
  (*********************************************)
  (*********************************************)

  proc unpack (r1234:t4u64 Array5.t,rt:W64.t Array3.t,o:int) : t4u64 Array5.t = {
    
    var mask26:int;
    var l:W64.t;
    var h:W64.t;
    var  _0:bool;
    var  _1:bool;
    var  _2:bool;
    var  _3:bool;
    var  _4:bool;
    var  _5:bool;
    var  _6:bool;
    var  _7:bool;
    var  _8:bool;
    var  _9:bool;
    
    mask26 <- 67108863;
    l <- rt.[0];
    l <- (l `&` (W64.of_int mask26));
    r1234 = Ops.set_160(r1234,0,o,l);
    l <- rt.[0];
    l <- (l `>>` (W8.of_int 26));
    l <- (l `&` (W64.of_int mask26));
    r1234 = Ops.set_160(r1234,1,o,l);
    l <- rt.[0];
    ( _0, _1, _2, _3, _4,l) <- SHRD_64 l rt.[1] (W8.of_int 52);
    h <- l;
    l <- (l `&` (W64.of_int mask26));
    r1234 = Ops.set_160(r1234,2,o,l);
    l <- h;
    l <- (l `>>` (W8.of_int 26));
    l <- (l `&` (W64.of_int mask26));
    r1234 = Ops.set_160(r1234,3,o,l);
    l <- rt.[1];
    ( _5, _6, _7, _8, _9,l) <- SHRD_64 l rt.[2] (W8.of_int 40);
    r1234 = Ops.set_160(r1234,4,o,l);
    return (r1234);
  }
  
  proc times_5 (r1234:t4u64 Array5.t) : t4u64 Array4.t = {
    var aux: int;
    
    var r1234x5:t4u64 Array4.t;
    var five:t4u64;
    var i:int;
    var t:t4u64;
    r1234x5 <- witness;
    five <@ Ops.iVPBROADCAST_4u64(five_u64);
    i <- 0;
    while (i < 4) {
      t <@ Ops.iVPMULU_256(five,r1234.[(1 + i)]);
      r1234x5.[i] <- t;
      i <- i + 1;
    }
    return (r1234x5);
  }
  
  proc broadcast_r4 (r1234:t4u64 Array5.t,r1234x5:t4u64 Array4.t) : 
  t4u64 Array5.t * t4u64 Array4.t = {
    var aux: int;
    
    var r4444:t4u64 Array5.t;
    var r4444x5:t4u64 Array4.t;
    var i:int;
    var t:t4u64 Array5.t;
    var xx : W64.t;
    r4444 <- witness;
    r4444x5 <- witness;
    t <- witness;
    i <- 0;
    while (i < 5) {
      xx <@ Ops.get_160(r1234,i,0);
      t.[i] <@ Ops.iVPBROADCAST_4u64(xx);
      r4444.[i] <- t.[i];
      i <- i + 1;
    }
    i <- 0;
    while (i < 4) {
      xx <@ Ops.get_128(r1234x5,i,0);
      t.[i] <@ Ops.iVPBROADCAST_4u64(xx);
      r4444x5.[i] <- t.[i];
      i <- i + 1;
    }
    return (r4444,r4444x5);
  }
  
  proc poly1305_avx2_setup (r:W64.t Array3.t) : t4u64 Array5.t *
                                                t4u64 Array4.t *
                                                t4u64 Array5.t *
                                                t4u64 Array4.t = {
    var aux: int;
    
    var r4444:t4u64 Array5.t;
    var r4444x5:t4u64 Array4.t;
    var r1234:t4u64 Array5.t;
    var r1234x5:t4u64 Array4.t;
    var i:int;
    var rt:W64.t Array3.t;
    r1234 <- witness;
    r1234x5 <- witness;
    r4444 <- witness;
    r4444x5 <- witness;
    rt <- witness;
    i <- 0;
    while (i < 2) {
      rt.[i] <- r.[i];
      i <- i + 1;
    }
    rt.[2] <- (W64.of_int 0);
    r1234 <@ unpack (r1234,rt,3);
    i <- 0;
    while (i < 3) {
      rt <@ Rep3Impl.mulmod (rt,r);
      r1234 <@ unpack (r1234,rt,(2 - i));
      i <- i + 1;
    }
    r1234x5 <@ times_5 (r1234);
    (r4444,r4444x5) <@ broadcast_r4 (r1234,r1234x5);
    return (r4444,r4444x5,r1234,r1234x5);
  }
  
  proc load_avx2 (in_0:W64.t,mask26:t4u64,s_bit25:t4u64) : t4u64 Array5.t *
                                                               W64.t = {
    
    var m:t4u64 Array5.t;
    var t:t4u64;
    m <- witness;
    t <@ Ops.iload4u64(Glob.mem,in_0 + (W64.of_int 0));
    m.[1] <@ Ops.iload4u64(Glob.mem,in_0 + (W64.of_int 32));
    in_0 <- (in_0 + (W64.of_int 64));
    m.[0] <@ Ops.iVPERM2I128(t,m.[1],(W8.of_int 32));
    m.[1] <@ Ops.iVPERM2I128(t,m.[1],(W8.of_int 49));
    m.[2] <@ Ops.iVPSRLDQ_256(m.[0],(W8.of_int 6));
    m.[3] <@ Ops.iVPSRLDQ_256(m.[1],(W8.of_int 6));
    m.[4] <@ Ops.iVPUNPCKH_4u64(m.[0],m.[1]);
    m.[0] <@ Ops.iVPUNPCKL_4u64(m.[0],m.[1]);
    m.[3] <@ Ops.iVPUNPCKL_4u64(m.[2],m.[3]);
    m.[2] <@ Ops.ivshr64u256(m.[3],(W8.of_int 4));
    m.[2] <@ Ops.iland4u64(m.[2],mask26);
    m.[1] <@ Ops.ivshr64u256(m.[0],(W8.of_int 26));
    m.[0] <@ Ops.iland4u64(m.[0],mask26);
    m.[3] <@ Ops.ivshr64u256(m.[3],(W8.of_int 30));
    m.[3] <@ Ops.iland4u64(m.[3],mask26);
    m.[4] <@ Ops.ivshr64u256(m.[4],(W8.of_int 40));
    m.[4] <@ Ops.ilor4u64(m.[4],s_bit25);
    m.[1] <@ Ops.iland4u64(m.[1],mask26);
    return (m,in_0);
  }
  
  proc pack_avx2 (h:t4u64 Array5.t) : W64.t Array3.t = {
    var aux: bool;
    var aux_0: W64.t;
    
    var r:W64.t Array3.t;
    var t:t4u64 Array3.t;
    var u:t4u64 Array2.t;
    var t0:t2u64;
    var d:W64.t Array3.t;
    var cf:bool;
    var c:W64.t;
    var cx4:W64.t;
    var  _0:bool;
    var  _1:bool;
    var xx;
    d <- witness;
    r <- witness;
    t <- witness;
    u <- witness;
    t.[0] <@ Ops.ivshl64u256(h.[1],(W8.of_int 26));
    t.[0] <@ Ops.ivadd64u256(t.[0],h.[0]);
    t.[1] <@ Ops.ivshl64u256(h.[3],(W8.of_int 26));
    t.[1] <@ Ops.ivadd64u256(t.[1],h.[2]);
    t.[2] <@ Ops.iVPSRLDQ_256(h.[4],(W8.of_int 8));
    t.[2] <@ Ops.ivadd64u256(t.[2],h.[4]);
    t.[2] <@ Ops.iVPERMQ(t.[2],(W8.of_int 128));
    u.[0] <@ Ops.iVPERM2I128(t.[0],t.[1],(W8.of_int 32));
    u.[1] <@ Ops.iVPERM2I128(t.[0],t.[1],(W8.of_int 49));
    t.[0] <@ Ops.ivadd64u256(u.[0],u.[1]);
    u.[0] <@ Ops.iVPUNPCKL_4u64(t.[0],t.[2]);
    u.[1] <@ Ops.iVPUNPCKH_4u64(t.[0],t.[2]);
    t.[0] <@ Ops.ivadd64u256(u.[0],u.[1]);
    t0 <@ Ops.iVEXTRACTI128(t.[0],(W8.of_int 1));
    xx <@ Ops.itruncate_4u64_2u64(t.[0]);
    d.[0] <@ Ops.iVPEXTR_64(xx,(W8.of_int 0)); 
    d.[1] <@ Ops.iVPEXTR_64(t0,(W8.of_int 0));
    d.[2] <@ Ops.iVPEXTR_64(t0,(W8.of_int 1));
    r.[0] <- d.[1];
    r.[0] <- (r.[0] `<<` (W8.of_int 52));
    r.[1] <- d.[1];
    r.[1] <- (r.[1] `>>` (W8.of_int 12));
    r.[2] <- d.[2];
    r.[2] <- (r.[2] `>>` (W8.of_int 24));
    d.[2] <- (d.[2] `<<` (W8.of_int 40));
    (aux,aux_0) <- addc_64 r.[0] d.[0] false;
    cf <- aux;
    r.[0] <- aux_0;
    (aux,aux_0) <- addc_64 r.[1] d.[2] cf;
    cf <- aux;
    r.[1] <- aux_0;
    (aux,aux_0) <- addc_64 r.[2] (W64.of_int 0) cf;
     _0 <- aux;
    r.[2] <- aux_0;
    c <- r.[2];
    cx4 <- r.[2];
    r.[2] <- (r.[2] `&` (W64.of_int 3));
    c <- (c `>>` (W8.of_int 2));
    cx4 <- (cx4 `&` (W64.of_int (- 4)));
    c <- (c + cx4);
    (aux,aux_0) <- addc_64 r.[0] c false;
    cf <- aux;
    r.[0] <- aux_0;
    (aux,aux_0) <- addc_64 r.[1] (W64.of_int 0) cf;
    cf <- aux;
    r.[1] <- aux_0;
    (aux,aux_0) <- addc_64 r.[2] (W64.of_int 0) cf;
     _1 <- aux;
    r.[2] <- aux_0;
    return (r);
  }
  
  proc carry_reduce_avx2 (x:t4u64 Array5.t,mask26:t4u64) : t4u64 Array5.t = {
    
    var z:t4u64 Array2.t;
    var t:t4u64;
    z <- witness;
    z.[0] <@ Ops.ivshr64u256(x.[0],(W8.of_int 26));
    z.[1] <@ Ops.ivshr64u256(x.[3],(W8.of_int 26));
    x.[0] <@ Ops.iland4u64(x.[0],mask26);
    x.[3] <@ Ops.iland4u64(x.[3],mask26);
    x.[1] <@ Ops.ivadd64u256(x.[1],z.[0]);
    x.[4] <@ Ops.ivadd64u256(x.[4],z.[1]);
    z.[0] <@ Ops.ivshr64u256(x.[1],(W8.of_int 26));
    z.[1] <@ Ops.ivshr64u256(x.[4],(W8.of_int 26));
    t <@ Ops.ivshl64u256(z.[1],(W8.of_int 2));
    z.[1] <@ Ops.ivadd64u256(z.[1],t);
    x.[1] <@ Ops.iland4u64(x.[1],mask26);
    x.[4] <@ Ops.iland4u64(x.[4],mask26);
    x.[2] <@ Ops.ivadd64u256(x.[2],z.[0]);
    x.[0] <@ Ops.ivadd64u256(x.[0],z.[1]);
    z.[0] <@ Ops.ivshr64u256(x.[2],(W8.of_int 26));
    z.[1] <@ Ops.ivshr64u256(x.[0],(W8.of_int 26));
    x.[2] <@ Ops.iland4u64(x.[2],mask26);
    x.[0] <@ Ops.iland4u64(x.[0],mask26);
    x.[3] <@ Ops.ivadd64u256(x.[3],z.[0]);
    x.[1] <@ Ops.ivadd64u256(x.[1],z.[1]);
    z.[0] <@ Ops.ivshr64u256(x.[3],(W8.of_int 26));
    x.[3] <@ Ops.iland4u64(x.[3],mask26);
    x.[4] <@ Ops.ivadd64u256(x.[4],z.[0]);
    return (x);
  }
  
  proc add_mulmod_avx2 (h:t4u64 Array5.t,m:t4u64 Array5.t,
                        s_r:t4u64 Array5.t,s_rx5:t4u64 Array4.t,
                        s_mask26:t4u64,s_bit25:t4u64) : t4u64 Array5.t = {
    var r0:t4u64;
    var r1:t4u64;
    var r4x5:t4u64;
    var t:t4u64 Array5.t;
    var u:t4u64 Array4.t;
    var r2:t4u64;
    var r3x5:t4u64;
    var r3:t4u64;
    var r2x5:t4u64;
    t <- witness;
    u <- witness;
    r0 <- s_r.[0];
    r1 <- s_r.[1];
    r4x5 <- s_rx5.[(4 - 1)];
    h.[0] <@ Ops.ivadd64u256(h.[0],m.[0]);
    h.[1] <@ Ops.ivadd64u256(h.[1],m.[1]);
    h.[2] <@ Ops.ivadd64u256(h.[2],m.[2]);
    h.[3] <@ Ops.ivadd64u256(h.[3],m.[3]);
    h.[4] <@ Ops.ivadd64u256(h.[4],m.[4]);
    t.[0] <@ Ops.iVPMULU_256(h.[0],r0);
    t.[1] <@ Ops.iVPMULU_256(h.[1],r0);
    t.[2] <@ Ops.iVPMULU_256(h.[2],r0);
    t.[3] <@ Ops.iVPMULU_256(h.[3],r0);
    t.[4] <@ Ops.iVPMULU_256(h.[4],r0);
    u.[0] <@ Ops.iVPMULU_256(h.[0],r1);
    u.[1] <@ Ops.iVPMULU_256(h.[1],r1);
    u.[2] <@ Ops.iVPMULU_256(h.[2],r1);
    u.[3] <@ Ops.iVPMULU_256(h.[3],r1);
    r2 <- s_r.[2];
    t.[1] <@ Ops.ivadd64u256(t.[1],u.[0]);
    t.[2] <@ Ops.ivadd64u256(t.[2],u.[1]);
    t.[3] <@ Ops.ivadd64u256(t.[3],u.[2]);
    t.[4] <@ Ops.ivadd64u256(t.[4],u.[3]);
    u.[0] <@ Ops.iVPMULU_256(h.[1],r4x5);
    u.[1] <@ Ops.iVPMULU_256(h.[2],r4x5);
    u.[2] <@ Ops.iVPMULU_256(h.[3],r4x5);
    u.[3] <@ Ops.iVPMULU_256(h.[4],r4x5);
    r3x5 <- s_rx5.[(3 - 1)];
    t.[0] <@ Ops.ivadd64u256(t.[0],u.[0]);
    t.[1] <@ Ops.ivadd64u256(t.[1],u.[1]);
    t.[2] <@ Ops.ivadd64u256(t.[2],u.[2]);
    t.[3] <@ Ops.ivadd64u256(t.[3],u.[3]);
    u.[0] <@ Ops.iVPMULU_256(h.[0],r2);
    u.[1] <@ Ops.iVPMULU_256(h.[1],r2);
    u.[2] <@ Ops.iVPMULU_256(h.[2],r2);
    r3 <- s_r.[3];
    t.[2] <@ Ops.ivadd64u256(t.[2],u.[0]);
    t.[3] <@ Ops.ivadd64u256(t.[3],u.[1]);
    t.[4] <@ Ops.ivadd64u256(t.[4],u.[2]);
    u.[0] <@ Ops.iVPMULU_256(h.[2],r3x5);
    u.[1] <@ Ops.iVPMULU_256(h.[3],r3x5);
    h.[2] <@ Ops.iVPMULU_256(h.[4],r3x5);
    r2x5 <- s_rx5.[(2 - 1)];
    t.[0] <@ Ops.ivadd64u256(t.[0],u.[0]);
    t.[1] <@ Ops.ivadd64u256(t.[1],u.[1]);
    h.[2] <@ Ops.ivadd64u256(h.[2],t.[2]);
    u.[0] <@ Ops.iVPMULU_256(h.[0],r3);
    u.[1] <@ Ops.iVPMULU_256(h.[1],r3);
    t.[3] <@ Ops.ivadd64u256(t.[3],u.[0]);
    t.[4] <@ Ops.ivadd64u256(t.[4],u.[1]);
    u.[0] <@ Ops.iVPMULU_256(h.[3],r2x5);
    h.[1] <@ Ops.iVPMULU_256(h.[4],r2x5);
    t.[0] <@ Ops.ivadd64u256(t.[0],u.[0]);
    h.[1] <@ Ops.ivadd64u256(h.[1],t.[1]);
    u.[0] <@ Ops.iVPMULU_256(h.[4],s_rx5.[(1 - 1)]);
    u.[1] <@ Ops.iVPMULU_256(h.[0],s_r.[4]);
    h.[0] <@ Ops.ivadd64u256(t.[0],u.[0]);
    h.[3] <- t.[3];
    h.[4] <@ Ops.ivadd64u256(t.[4],u.[1]);
    return (h);
  }
  
  proc mainloop_avx2_v1 (h:t4u64 Array5.t,m:t4u64 Array5.t,in_0:W64.t,
                         s_r:t4u64 Array5.t,s_rx5:t4u64 Array4.t,
                         s_mask26:t4u64,s_bit25:t4u64) : t4u64 Array5.t *
                                                            t4u64 Array5.t *
                                                            W64.t = {
    
    var r0:t4u64;
    var r1:t4u64;
    var r4x5:t4u64;
    var t:t4u64 Array5.t;
    var u:t4u64 Array4.t;
    var m0:t4u64;
    var r2:t4u64;
    var r3x5:t4u64;
    var r3:t4u64;
    var r2x5:t4u64;
    var mask26:t4u64;
    var z:t4u64 Array2.t;
    var z0:t4u64;
    t <- witness;
    u <- witness;
    z <- witness;
    r0 <- s_r.[0];
    r1 <- s_r.[1];
    r4x5 <- s_rx5.[(4 - 1)];
    h.[0] <@ Ops.ivadd64u256(h.[0],m.[0]);
    h.[1] <@ Ops.ivadd64u256(h.[1],m.[1]);
    t.[0] <@ Ops.iVPMULU_256(h.[0],r0);
    h.[2] <@ Ops.ivadd64u256(h.[2],m.[2]);
    u.[0] <@ Ops.iVPMULU_256(h.[0],r1);
    h.[3] <@ Ops.ivadd64u256(h.[3],m.[3]);
    t.[1] <@ Ops.iVPMULU_256(h.[1],r0);
    h.[4] <@ Ops.ivadd64u256(h.[4],m.[4]);
    u.[1] <@ Ops.iVPMULU_256(h.[1],r1);
    t.[2] <@ Ops.iVPMULU_256(h.[2],r0);
    u.[2] <@ Ops.iVPMULU_256(h.[2],r1);
    t.[3] <@ Ops.iVPMULU_256(h.[3],r0);
    t.[1] <@ Ops.ivadd64u256 (t.[1],u.[0]);
    u.[3] <@ Ops.iVPMULU_256(h.[3],r1);
    t.[2] <@ Ops.ivadd64u256(t.[2],u.[1]);
    t.[4] <@ Ops.iVPMULU_256(h.[4],r0);
    t.[3] <@ Ops.ivadd64u256(t.[3],u.[2]);
    t.[4] <@ Ops.ivadd64u256(t.[4],u.[3]);
    u.[0] <@ Ops.iVPMULU_256(h.[1],r4x5);
    m0 <@ Ops.iload4u64(Glob.mem,in_0 + W64.of_int 0);
    u.[1] <@ Ops.iVPMULU_256(h.[2],r4x5);
    r2 <- s_r.[2];
    u.[2] <@ Ops.iVPMULU_256(h.[3],r4x5);
    u.[3] <@ Ops.iVPMULU_256(h.[4],r4x5);
    t.[0] <@ Ops.ivadd64u256(t.[0],u.[0]);
    m.[1] <@ Ops.iload4u64(Glob.mem,in_0 + W64.of_int 32);
    t.[1] <@ Ops.ivadd64u256(t.[1],u.[1]);
    t.[2] <@ Ops.ivadd64u256(t.[2],u.[2]);
    t.[3] <@ Ops.ivadd64u256(t.[3],u.[3]);
    u.[0] <@ Ops.iVPMULU_256(h.[0],r2);
    m.[0] <@ Ops.iVPERM2I128(m0,m.[1],W8.of_int 32);
    u.[1] <@ Ops.iVPMULU_256(h.[1],r2);
    m.[1] <@ Ops.iVPERM2I128(m0,m.[1],W8.of_int 49);
    u.[2] <@ Ops.iVPMULU_256(h.[2],r2);
    t.[2] <@ Ops.ivadd64u256(t.[2],u.[0]);
    r3x5 <- s_rx5.[(3 - 1)];
    t.[3] <@ Ops.ivadd64u256(t.[3],u.[1]);
    t.[4] <@ Ops.ivadd64u256(t.[4],u.[2]);
    u.[0] <@ Ops.iVPMULU_256(h.[2],r3x5);
    u.[1] <@ Ops.iVPMULU_256(h.[3],r3x5);
    r3 <- s_r.[3];
    h.[2] <@ Ops.iVPMULU_256(h.[4],r3x5);
    m.[2] <@ Ops.iVPSRLDQ_256(m.[0],W8.of_int 6);
    t.[0] <@ Ops.ivadd64u256(t.[0],u.[0]);
    m.[3] <@ Ops.iVPSRLDQ_256(m.[1],W8.of_int 6);
    t.[1] <@ Ops.ivadd64u256(t.[1],u.[1]);
    h.[2] <@ Ops.ivadd64u256(h.[2],t.[2]);
    r2x5 <- s_rx5.[(2 - 1)];
    u.[0] <@ Ops.iVPMULU_256(h.[0],r3);
    u.[1] <@ Ops.iVPMULU_256(h.[1],r3);
    m.[4] <@ Ops.iVPUNPCKH_4u64(m.[0],m.[1]);
    m.[0] <@ Ops.iVPUNPCKL_4u64(m.[0],m.[1]);
    t.[3] <@ Ops.ivadd64u256(t.[3],u.[0]);
    t.[4] <@ Ops.ivadd64u256(t.[4],u.[1]);
    u.[0] <@ Ops.iVPMULU_256(h.[3],r2x5);
    h.[1] <@ Ops.iVPMULU_256(h.[4],r2x5);
    t.[0] <@ Ops.ivadd64u256(t.[0],u.[0]);
    h.[1] <@ Ops.ivadd64u256(h.[1],t.[1]);
    mask26 <- s_mask26;
    u.[0] <@ Ops.iVPMULU_256(h.[4],s_rx5.[(1 - 1)]);
    u.[1] <@ Ops.iVPMULU_256(h.[0],s_r.[4]);
    m.[3] <@ Ops.iVPUNPCKL_4u64(m.[2],m.[3]);
    m.[2] <@ Ops.ivshr64u256(m.[3],(W8.of_int 4));
    h.[0] <@ Ops.ivadd64u256(t.[0],u.[0]);
    z.[0] <@ Ops.ivshr64u256(h.[0],(W8.of_int 26));
    h.[0] <@ Ops.iland4u64(h.[0],mask26);
    h.[3] <@ Ops.iland4u64(t.[3],mask26);
    z.[1] <@ Ops.ivshr64u256(t.[3],(W8.of_int 26));
    h.[4] <@ Ops.ivadd64u256(t.[4],u.[1]);
    m.[2] <@ Ops.iland4u64(m.[2],mask26);
    m.[1] <@ Ops.ivshr64u256(m.[0],(W8.of_int 26));
    h.[1] <@ Ops.ivadd64u256(h.[1],z.[0]);
    h.[4] <@ Ops.ivadd64u256(h.[4],z.[1]);
    z.[0] <@ Ops.ivshr64u256(h.[1],(W8.of_int 26));
    z.[1] <@ Ops.ivshr64u256(h.[4],(W8.of_int 26));
    z0 <@ Ops.ivshl64u256(z.[1],(W8.of_int 2));
    z.[1] <@ Ops.ivadd64u256(z.[1],z0);
    h.[1] <@ Ops.iland4u64(h.[1],mask26);
    h.[4] <@ Ops.iland4u64(h.[4],mask26);
    h.[2] <@ Ops.ivadd64u256(h.[2],z.[0]);
    h.[0] <@ Ops.ivadd64u256(h.[0],z.[1]);
    z.[0] <@ Ops.ivshr64u256(h.[2],(W8.of_int 26));
    z.[1] <@ Ops.ivshr64u256(h.[0],(W8.of_int 26));
    h.[2] <@ Ops.iland4u64(h.[2],mask26);
    h.[0] <@ Ops.iland4u64(h.[0],mask26);
    h.[3] <@ Ops.ivadd64u256(h.[3],z.[0]);
    h.[1] <@ Ops.ivadd64u256(h.[1],z.[1]);
    z.[0] <@ Ops.ivshr64u256(h.[3],(W8.of_int 26));
    h.[3] <@ Ops.iland4u64(h.[3],mask26);
    h.[4] <@ Ops.ivadd64u256(h.[4],z.[0]);
    in_0 <- (in_0 + (W64.of_int 64));
    m.[0] <@ Ops.iland4u64(m.[0],mask26);
    m.[3] <@ Ops.ivshr64u256(m.[3],(W8.of_int 30));
    m.[3] <@ Ops.iland4u64(m.[3],mask26);
    m.[4] <@ Ops.ivshr64u256(m.[4],(W8.of_int 40));
    m.[4] <@ Ops.ilor4u64(m.[4],s_bit25);
    m.[1] <@ Ops.iland4u64(m.[1],mask26);
    return (h,m,in_0);
  }
  
  proc final_avx2_v0 (h:t4u64 Array5.t,m:t4u64 Array5.t,
                      s_r:t4u64 Array5.t,s_rx5:t4u64 Array4.t,
                      s_mask26:t4u64,s_bit25:t4u64) : t4u64 Array5.t = {
    
    var mask26:t4u64;
    
    h <@ add_mulmod_avx2 (h,m,s_r,s_rx5,s_mask26,s_bit25);
    mask26 <- s_mask26;
    h <@ carry_reduce_avx2 (h,mask26);
    return (h);
  }
  
  proc poly1305_avx2_update (in_0:W64.t,len:W64.t,r4444:t4u64 Array5.t,
                             r4444x5:t4u64 Array4.t,r1234:t4u64 Array5.t,
                             r1234x5:t4u64 Array4.t) : W64.t * W64.t *
                                                        W64.t Array3.t = {
    var aux: int;
    
    var h64:W64.t Array3.t;
    var i:int;
    var h:t4u64 Array5.t;
    var t:t4u64;
    var s_mask26:t4u64;
    var mask26:t4u64;
    var s_bit25:t4u64;
    var m:t4u64 Array5.t;
    h <- witness;
    h64 <- witness;
    m <- witness;
    i <- 0;
    while (i < 5) {
      h.[i] <@ Ops.iVPBROADCAST_4u64(zero_u64);
      i <- i + 1;
    }
    t <@ Ops.iVPBROADCAST_4u64(mask26_u64);
    s_mask26 <- t;
    mask26 <- t;
    t <@ Ops.iVPBROADCAST_4u64(bit25_u64);
    s_bit25 <- t;
    (m,in_0) <@ load_avx2 (in_0,mask26,s_bit25);
    
    while (((W64.of_int 128) \ule len)) {
      (h,m,in_0) <@ mainloop_avx2_v1 (h,m,in_0,r4444,r4444x5,s_mask26,
      s_bit25);
      len <- (len - (W64.of_int 64));
    }
    len <- (len - (W64.of_int 64));
    h <@ final_avx2_v0 (h,m,r1234,r1234x5,s_mask26,s_bit25);
    h64 <@ pack_avx2 (h);
    return (in_0,len,h64);
  }
  
  proc poly1305_avx2_wrapper (out:W64.t,in_0:W64.t,inlen:W64.t,k:W64.t) : unit = {
    
    var len:W64.t;
    var h:W64.t Array3.t;
    var r:W64.t Array3.t;
    var r4444:t4u64 Array5.t;
    var r4444x5:t4u64 Array4.t;
    var r1234:t4u64 Array5.t;
    var r1234x5:t4u64 Array4.t;
    h <- witness;
    r <- witness;
    r1234 <- witness;
    r1234x5 <- witness;
    r4444 <- witness;
    r4444x5 <- witness;
    len <- inlen;
    (h,r,k) <@ Rep3Impl.setup (k);
    (r4444,r4444x5,r1234,r1234x5) <@ poly1305_avx2_setup (r);
    (in_0,len,h) <@ poly1305_avx2_update (in_0,len,r4444,r4444x5,r1234,
    r1234x5);
    (in_0,len,h) <@ Rep3Impl.update (in_0,len,h,r);
    Rep3Impl.finish (out,in_0,len,k,h,r);
    return ();
  }
  
  proc poly1305(out:W64.t,in_0:W64.t,inlen:W64.t,k:W64.t) : unit = {
    
    
    
    if ((inlen \ult (W64.of_int 257))) {
      Rep3Impl.poly1305 (out,in_0,inlen,k);
    } else {
      poly1305_avx2_wrapper (out,in_0,inlen,k);
    }
    return ();
  }
}.

require import Poly1305_hop3.

op of_columns5 (h1 h2 h3 h4 : W64.t Array5.t) =
 Array5.of_list witness [ 
        Array4.of_list witness [ h1.[0]; h2.[0]; h3.[0]; h4.[0] ] ;
        Array4.of_list witness [ h1.[1]; h2.[1]; h3.[1]; h4.[1] ] ;
        Array4.of_list witness [ h1.[2]; h2.[2]; h3.[2]; h4.[2] ] ;
        Array4.of_list witness [ h1.[3]; h2.[3]; h3.[3]; h4.[3] ] ;
        Array4.of_list witness [ h1.[4]; h2.[4]; h3.[4]; h4.[4] ] 
].

op is_column5 (hv : W64.t Array4.t Array5.t, h : W64.t Array5.t, i : int) =
     hv.[0].[i] = h.[0] /\ 
     hv.[1].[i] = h.[1] /\ 
     hv.[2].[i] = h.[2] /\ 
     hv.[3].[i] = h.[3] /\ 
     hv.[4].[i] = h.[4].

op of_columns4 (h1 h2 h3 h4 : W64.t Array4.t) =
 Array4.of_list witness [ 
        Array4.of_list witness [ h1.[0]; h2.[0]; h3.[0]; h4.[0] ] ;
        Array4.of_list witness [ h1.[1]; h2.[1]; h3.[1]; h4.[1] ] ;
        Array4.of_list witness [ h1.[2]; h2.[2]; h3.[2]; h4.[2] ] ;
        Array4.of_list witness [ h1.[3]; h2.[3]; h3.[3]; h4.[3] ] 
].

op is_column4 (hv : W64.t Array4.t Array4.t, h : W64.t Array5.t, i : int) =
     hv.[0].[i] = h.[0] /\ 
     hv.[1].[i] = h.[1] /\ 
     hv.[2].[i] = h.[2] /\ 
     hv.[3].[i] = h.[3].

(* remark: work-around to avoid reduction of an huge term in the proof bellow *)
lemma upd4_oflist (v: 'a Array4.t) x0 x1 x2 x3:
 v.[0 <- x0].[1 <- x1].[2 <- x2].[3 <- x3]
 = Array4.of_list witness [x0; x1; x2; x3].
proof. by apply (Array4.all_eq_eq); rewrite /all_eq. qed.

equiv hop3_savx2prevec_eq : 
    Mhop3.poly1305 ~ Mprevec.poly1305 : ={Glob.mem, out, in_0, inlen, k} ==> ={Glob.mem}.
proof.
proc.
if => //=; first by sim.
(* long messages *)
inline Mhop3.poly1305_long  Mprevec.poly1305_avx2_wrapper Mprevec.Rep3Impl.setup
       Mprevec.poly1305_avx2_setup Mprevec.poly1305_avx2_update.
swap {2} 12 -7.
swap {2} 14 -8.
swap {2} 17 -10.
swap {1} 17 -11.
swap {2} 18 -10.
swap {2} 20 5.
call(_: ={Glob.mem}) => /=; first by sim.
call (_: ={Glob.mem}) => /=; first by sim.
seq 6 24: (#[/1,6]pre /\ ={out0, in_00, k0, r} /\ inlen0{1}=len{2}).
 by unroll for {2} 18; wp; call (_: ={Glob.mem}); wp; skip; progress.
swap {2} [11..12] 14.
seq 6 27: ( (* MAIN LOOP INV *)
            ={Glob.mem, out0, k0, r} /\ (in_00,inlen0,r){1}=(in_01,len0,r1){2} /\
            h1{2} = of_columns5 h1{1} h2{1} h3{1} h4{1} /\
            m{2} = of_columns5 x1{1} x2{1} x3{1} x4{1} /\            
            r44441{2} = of_columns5 rpow4{1} rpow4{1} rpow4{1} rpow4{1} /\
            r12341{2} = of_columns5 rpow4{1} rpow3{1} rpow2{1} rpow1{1} /\ 
            r4444x51{2} = of_columns4 rpow4x5{1} rpow4x5{1} rpow4x5{1} rpow4x5{1} /\
            r1234x51{2} = of_columns4 rpow4x5{1} rpow3x5{1} rpow2x5{1} rpow1x5{1} /\
            s_mask26{2} = Array4.create mask26_u64 /\
            s_bit25{2} = Array4.create bit25_u64).
 (* pre-processing *)
 swap{1} 5 -4.
 seq 1 14: (#[/1:5,8:12]post /\ ={in_00} /\ inlen0{1} = len{2} /\ (r){2}=(r1){2}).
  inline Mhop3.precompute_Rep5.
  sp 1 1.
  seq 4 3: (#pre /\ ={rt} /\ r0{1}=r1{2}). 
   unroll for {1} 3; unroll for {2} 2.
   by wp; skip; progress; apply Array3.all_eq_eq; rewrite /all_eq.
  seq 1 1 : (#pre /\ is_column5 r12340{2} rpow10{1} 3); first by inline *; auto. 
  unroll for {2} 2.
  seq 1 2: (i0{2}=0 /\ #pre); first by inline*; auto.
  seq 1 1: (#pre /\ is_column5 r12340{2} rpow20{1} 2); first by inline *; auto => />; progress.
  seq 1 2: (i0{2}=1 /\ #[/2:]pre); first by inline*; auto.
  seq 1 1: (#pre /\ is_column5 r12340{2} rpow30{1} 1); first by inline *; auto => />; progress.
  seq 1 2: (i0{2}=2 /\ #[/2:]pre); first by inline*; auto.
  seq 1 1: (#pre /\ is_column5 r12340{2} rpow40{1} 0); first by inline *; auto => />; progress.
  inline*.
  unroll for {2} 21; unroll for {2} 19; unroll for {2} 11. 
  wp; auto => />; progress.
  - by apply (Array5.all_eq_eq); rewrite /all_eq /of_columns5 /=;
       progress; apply (Array4.all_eq_eq).
  - by apply (Array5.all_eq_eq); rewrite /all_eq /of_columns5 /=;
              progress; apply (Array4.all_eq_eq).
  - by apply (Array4.all_eq_eq); rewrite /all_eq /of_columns4 /=; progress;
       progress; apply (Array4.all_eq_eq); rewrite /all_eq /= /#.
  - by apply (Array4.all_eq_eq); rewrite /all_eq /of_columns4 /=; progress;
       progress; apply (Array4.all_eq_eq); rewrite /all_eq /= /#.
 unroll for {2} 5; inline*; wp; skip; progress.
 - apply (Array5.all_eq_eq); rewrite /all_eq /of_columns5 /=.
   by progress; apply (Array4.all_eq_eq).
 - apply (Array5.all_eq_eq); rewrite /all_eq /of_columns5 /=.
   by progress; apply (Array4.all_eq_eq).
 - by apply (Array4.all_eq_eq).
 - by apply (Array4.all_eq_eq).
(* main loop *)
seq 1 1: (#pre).
 while (#pre) => //.
 inline Mhop3.add_mulmod_x4_Rep5 Mprevec.mainloop_avx2_v1.
 (* in order to allow "sim" tackle these goals...
 inline Mhop3.Rep5Impl.add.
 (*usage: interleave [pos1:n1] [pos2:n2] k *)
 interleave {1} [11:1] [19:1]8.
 interleave {1} [11:2] [27:1]8.
 interleave {1} [11:3] [35:1]8.*)
 inline*; wp; skip; auto => />; progress.
  rewrite /of_columns5 /of_columns4 /=. 
  by apply (Array5.all_eq_eq); rewrite /all_eq /=; progress;
     rewrite upd4_oflist.
 rewrite /of_columns5 /of_columns4 /=. 
 by apply (Array5.all_eq_eq); rewrite /all_eq /=; progress;
    rewrite upd4_oflist.
(* final *)
simplify; seq 2 2: (#{~m{2}}{~r44441{2}}{~r12341{2}}{~r4444x51{2}}{~r1234x51{2}}
                     {~s_mask26{2}}{~s_bit25{2}}pre).
 (* final iter *)
 inline Mhop3.add_mulmod_x4_final_Rep5 Mprevec.final_avx2_v0; wp.
 seq 1 1: #pre; first by auto => />.
 sp.
 seq 8 1: (#{/s_mask26{2}}pre /\ #post).
  (* add_mulmod *)
  inline*; wp; skip; progress.
  by apply (Array5.all_eq_eq); rewrite /all_eq /of_columns5 /=; progress;
     apply (Array4.all_eq_eq); rewrite /all_eq /of_columns4 /=; progress.
 (* carry reduce *)
 inline*; wp; skip; progress.
 by apply (Array5.all_eq_eq); rewrite /all_eq /of_columns5 /=; progress;
    apply (Array4.all_eq_eq); rewrite /all_eq /of_columns4 /=; progress.
(* final pack *)
inline Mhop3.Rep5Impl.add_pack Mprevec.pack_avx2.
seq 22 30: (#[/1:7]pre /\ r0{1}=r2{2} /\ ={r,k0} /\ d{1}.[0] = d{2}.[0] /\ d{1}.[2] = d{2}.[2]).
 inline*; auto => />; progress.
   by rewrite /of_columns5 /=; apply (Array3.all_eq_eq); rewrite /all_eq /=; progress; congr; ring.
  by rewrite /truncate_4u64_2u64 /of_columns5 /=; ring.
  by rewrite /of_columns5 /=; congr; ring.
by wp; skip; progress; apply (Array3.all_eq_eq); rewrite /all_eq !H !H0.
qed.


require import List Int IntDiv CoreMap.
require import Array2 Array3 Array4 Array5.
require import WArray16 WArray24 WArray32 WArray40 WArray48 WArray64 WArray80.

from Jasmin require import JModel.

abbrev bit25_u64 = W64.of_int 16777216.


abbrev mask26_u64 = W64.of_int 67108863.


abbrev five_u64 = W64.of_int 5.


abbrev zero_u64 = W64.of_int 0.


module M = {
  proc load (p:W64.t) : W64.t Array2.t = {
    
    var x:W64.t Array2.t;
    x <- witness;
    x.[0] <- (loadW64 Glob.mem (p + (W64.of_int 0)));
    x.[1] <- (loadW64 Glob.mem (p + (W64.of_int 8)));
    return (x);
  }
  
  proc load_add (h:W64.t Array3.t, in_0:W64.t) : W64.t Array3.t = {
    var aux: bool;
    var aux_0: W64.t;
    
    var cf:bool;
    var  _0:bool;
    
    (aux, aux_0) <- addc_64 h.[0] (loadW64 Glob.mem (in_0 + (W64.of_int 0)))
    false;
    cf <- aux;
    h.[0] <- aux_0;
    (aux, aux_0) <- addc_64 h.[1] (loadW64 Glob.mem (in_0 + (W64.of_int 8)))
    cf;
    cf <- aux;
    h.[1] <- aux_0;
    (aux, aux_0) <- addc_64 h.[2] (W64.of_int 1) cf;
     _0 <- aux;
    h.[2] <- aux_0;
    return (h);
  }
  
  proc load_last_add (h:W64.t Array3.t, in_0:W64.t, len:W64.t) : W64.t Array3.t = {
    var aux: bool;
    var aux_0: W64.t;
    
    var s:W64.t Array2.t;
    var j:W64.t;
    var c:W8.t;
    var cf:bool;
    var  _0:bool;
    s <- witness;
    s.[0] <- (W64.of_int 0);
    s.[1] <- (W64.of_int 0);
    j <- (W64.of_int 0);
    
    while ((j \ult len)) {
      c <- (loadW8 Glob.mem (in_0 + j));
      s =
      Array2.init
      (WArray16.get64 (WArray16.set8 (WArray16.init64 (fun i => s.[i])) (W64.to_uint j) c));
      j <- (j + (W64.of_int 1));
    }
    s =
    Array2.init
    (WArray16.get64 (WArray16.set8 (WArray16.init64 (fun i => s.[i])) (W64.to_uint j) (W8.of_int 1)));
    (aux, aux_0) <- addc_64 h.[0] s.[0] false;
    cf <- aux;
    h.[0] <- aux_0;
    (aux, aux_0) <- addc_64 h.[1] s.[1] cf;
    cf <- aux;
    h.[1] <- aux_0;
    (aux, aux_0) <- addc_64 h.[2] (W64.of_int 0) cf;
     _0 <- aux;
    h.[2] <- aux_0;
    return (h);
  }
  
  proc store (p:W64.t, x:W64.t Array3.t) : unit = {
    
    
    
    Glob.mem <- storeW64 Glob.mem (p + (W64.of_int 0)) x.[0];
    Glob.mem <- storeW64 Glob.mem (p + (W64.of_int 8)) x.[1];
    return ();
  }
  
  proc clamp (k:W64.t) : W64.t Array3.t = {
    
    var r:W64.t Array3.t;
    r <- witness;
    r.[0] <- (loadW64 Glob.mem (k + (W64.of_int 0)));
    r.[1] <- (loadW64 Glob.mem (k + (W64.of_int 8)));
    r.[0] <- (r.[0] `&` (W64.of_int 1152921487695413247));
    r.[1] <- (r.[1] `&` (W64.of_int 1152921487695413244));
    r.[2] <- r.[1];
    r.[2] <- (r.[2] `>>` (W8.of_int 2));
    r.[2] <- (r.[2] + r.[1]);
    return (r);
  }
  
  proc add (h:W64.t Array3.t, s:W64.t Array2.t) : W64.t Array3.t = {
    var aux: bool;
    var aux_0: W64.t;
    
    var cf:bool;
    var  _0:bool;
    
    (aux, aux_0) <- addc_64 h.[0] s.[0] false;
    cf <- aux;
    h.[0] <- aux_0;
    (aux, aux_0) <- addc_64 h.[1] s.[1] cf;
     _0 <- aux;
    h.[1] <- aux_0;
    return (h);
  }
  
  proc mulmod (h:W64.t Array3.t, r:W64.t Array3.t) : W64.t Array3.t = {
    var aux: bool;
    var aux_0: W64.t;
    
    var t:W64.t Array3.t;
    var rax:W64.t;
    var rdx:W64.t;
    var cf:bool;
    var v0:W64.t;
    var tt:W64.t;
    var  _0:bool;
    var  _1:bool;
    var  _2:bool;
    t <- witness;
    t.[1] <- r.[2];
    t.[1] <- (t.[1] * h.[2]);
    rax <- r.[2];
    (rdx, rax) <- mulu_64 rax h.[1];
    t.[1] <- (t.[1] + rdx);
    t.[0] <- rax;
    rax <- r.[0];
    (rdx, rax) <- mulu_64 rax h.[1];
    t.[2] <- rdx;
    h.[1] <- rax;
    h.[2] <- (h.[2] * r.[0]);
    rax <- r.[0];
    (rdx, rax) <- mulu_64 rax h.[0];
    (aux, aux_0) <- addc_64 h.[1] rdx false;
    cf <- aux;
    h.[1] <- aux_0;
    (aux, aux_0) <- addc_64 h.[2] t.[2] cf;
     _0 <- aux;
    h.[2] <- aux_0;
    v0 <- rax;
    rax <- r.[1];
    (rdx, rax) <- mulu_64 rax h.[0];
    (aux, aux_0) <- addc_64 t.[0] v0 false;
    cf <- aux;
    t.[0] <- aux_0;
    (aux, aux_0) <- addc_64 h.[1] rax cf;
    cf <- aux;
    h.[1] <- aux_0;
    (aux, aux_0) <- addc_64 h.[2] rdx cf;
     _1 <- aux;
    h.[2] <- aux_0;
    h.[0] <- (W64.of_int 18446744073709551612);
    h.[0] <- (h.[0] `&` h.[2]);
    h.[2] <- (h.[2] `&` (W64.of_int 3));
    tt <- h.[0];
    tt <- (tt `>>` (W8.of_int 2));
    h.[0] <- (h.[0] + tt);
    (aux, aux_0) <- addc_64 h.[0] t.[0] false;
    cf <- aux;
    h.[0] <- aux_0;
    (aux, aux_0) <- addc_64 h.[1] t.[1] cf;
    cf <- aux;
    h.[1] <- aux_0;
    (aux, aux_0) <- addc_64 h.[2] (W64.of_int 0) cf;
     _2 <- aux;
    h.[2] <- aux_0;
    return (h);
  }
  
  proc freeze (h:W64.t Array3.t) : W64.t Array3.t = {
    var aux: bool;
    var aux_0: W64.t;
    
    var g:W64.t Array3.t;
    var cf:bool;
    var mask:W64.t;
    var  _0:bool;
    g <- witness;
    g <- h;
    (aux, aux_0) <- addc_64 g.[0] (W64.of_int 5) false;
    cf <- aux;
    g.[0] <- aux_0;
    (aux, aux_0) <- addc_64 g.[1] (W64.of_int 0) cf;
    cf <- aux;
    g.[1] <- aux_0;
    (aux, aux_0) <- addc_64 g.[2] (W64.of_int 0) cf;
     _0 <- aux;
    g.[2] <- aux_0;
    g.[2] <- (g.[2] `>>` (W8.of_int 2));
    mask <- (- g.[2]);
    g.[0] <- (g.[0] `^` h.[0]);
    g.[1] <- (g.[1] `^` h.[1]);
    g.[0] <- (g.[0] `&` mask);
    g.[1] <- (g.[1] `&` mask);
    h.[0] <- (h.[0] `^` g.[0]);
    h.[1] <- (h.[1] `^` g.[1]);
    return (h);
  }
  
  proc poly1305_ref3_setup (k:W64.t) : W64.t Array3.t * W64.t Array3.t *
                                       W64.t = {
    var aux: int;
    
    var h:W64.t Array3.t;
    var r:W64.t Array3.t;
    var i:int;
    h <- witness;
    r <- witness;
    i <- 0;
    while (i < 3) {
      h.[i] <- (W64.of_int 0);
      i <- i + 1;
    }
    r <@ clamp (k);
    k <- (k + (W64.of_int 16));
    return (h, r, k);
  }
  
  proc poly1305_ref3_update (in_0:W64.t, inlen:W64.t, h:W64.t Array3.t,
                             r:W64.t Array3.t) : W64.t * W64.t *
                                                 W64.t Array3.t = {
    
    
    
    
    while (((W64.of_int 16) \ule inlen)) {
      h <@ load_add (h, in_0);
      h <@ mulmod (h, r);
      in_0 <- (in_0 + (W64.of_int 16));
      inlen <- (inlen - (W64.of_int 16));
    }
    return (in_0, inlen, h);
  }
  
  proc poly1305_ref3_last (out:W64.t, in_0:W64.t, inlen:W64.t, k:W64.t,
                           h:W64.t Array3.t, r:W64.t Array3.t) : unit = {
    
    var s:W64.t Array2.t;
    s <- witness;
    if (((W64.of_int 0) \ult inlen)) {
      h <@ load_last_add (h, in_0, inlen);
      h <@ mulmod (h, r);
    } else {
      
    }
    h <@ freeze (h);
    s <@ load (k);
    h <@ add (h, s);
    store (out, h);
    return ();
  }
  
  proc poly1305_ref3_local (out:W64.t, in_0:W64.t, inlen:W64.t, k:W64.t) : unit = {
    
    var h:W64.t Array3.t;
    var r:W64.t Array3.t;
    var len:W64.t;
    h <- witness;
    r <- witness;
    (h, r, k) <@ poly1305_ref3_setup (k);
    len <- inlen;
    (in_0, len, h) <@ poly1305_ref3_update (in_0, len, h, r);
    poly1305_ref3_last (out, in_0, len, k, h, r);
    return ();
  }
  
  proc unpack (r12:W128.t Array5.t, rt:W64.t Array3.t, o:int) : W128.t Array5.t = {
    
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
    r12 =
    Array5.init
    (WArray80.get128 (WArray80.set64 (WArray80.init128 (fun i => r12.[i])) (o + 0) l));
    l <- rt.[0];
    l <- (l `>>` (W8.of_int 26));
    l <- (l `&` (W64.of_int mask26));
    r12 =
    Array5.init
    (WArray80.get128 (WArray80.set64 (WArray80.init128 (fun i => r12.[i])) (o + 2) l));
    l <- rt.[0];
    ( _0,  _1,  _2,  _3,  _4, l) <- x86_SHRD_64 l rt.[1] (W8.of_int 52);
    h <- l;
    l <- (l `&` (W64.of_int mask26));
    r12 =
    Array5.init
    (WArray80.get128 (WArray80.set64 (WArray80.init128 (fun i => r12.[i])) (o + 4) l));
    l <- h;
    l <- (l `>>` (W8.of_int 26));
    l <- (l `&` (W64.of_int mask26));
    r12 =
    Array5.init
    (WArray80.get128 (WArray80.set64 (WArray80.init128 (fun i => r12.[i])) (o + 6) l));
    l <- rt.[1];
    ( _5,  _6,  _7,  _8,  _9, l) <- x86_SHRD_64 l rt.[2] (W8.of_int 40);
    r12 =
    Array5.init
    (WArray80.get128 (WArray80.set64 (WArray80.init128 (fun i => r12.[i])) (o + 8) l));
    return (r12);
  }
  
  proc times_5 (r12:W128.t Array5.t) : W128.t Array4.t = {
    var aux: int;
    
    var r12x5:W128.t Array4.t;
    var five:W128.t;
    var i:int;
    var t:W128.t;
    r12x5 <- witness;
    five <- x86_VPBROADCAST_2u64 five_u64;
    i <- 0;
    while (i < 4) {
      t <- x86_VPMULU_128 five r12.[(1 + i)];
      r12x5.[i] <- t;
      i <- i + 1;
    }
    return (r12x5);
  }
  
  proc broadcast_r2 (r12:W128.t Array5.t, r12x5:W128.t Array4.t) : W128.t Array5.t *
                                                                   W128.t Array4.t = {
    var aux: int;
    
    var r22:W128.t Array5.t;
    var r22x5:W128.t Array4.t;
    var i:int;
    var t:W128.t Array5.t;
    r22 <- witness;
    r22x5 <- witness;
    t <- witness;
    i <- 0;
    while (i < 5) {
      t.[i] <-
      x86_VPBROADCAST_2u64 (get64 (WArray80.init128 (fun i => r12.[i]))
                           (2 * i));
      r22.[i] <- t.[i];
      i <- i + 1;
    }
    i <- 0;
    while (i < 4) {
      t.[i] <-
      x86_VPBROADCAST_2u64 (get64 (WArray64.init128 (fun i => r12x5.[i]))
                           (2 * i));
      r22x5.[i] <- t.[i];
      i <- i + 1;
    }
    return (r22, r22x5);
  }
  
  proc broadcast_r4 (r4:W64.t Array3.t) : W128.t Array5.t * W128.t Array4.t = {
    var aux: int;
    
    var r44:W128.t Array5.t;
    var r44x5:W128.t Array4.t;
    var i:int;
    var t:W64.t Array5.t;
    r44 <- witness;
    r44x5 <- witness;
    t <- witness;
    r44 <@ unpack (r44, r4, 0);
    i <- 0;
    while (i < 5) {
      t.[i] <- (get64 (WArray80.init128 (fun i => r44.[i])) (2 * i));
      r44 =
      Array5.init
      (WArray80.get128 (WArray80.set64 (WArray80.init128 (fun i => r44.[i])) (1 + (2 * i)) 
      t.[i]));
      i <- i + 1;
    }
    r44x5 <@ times_5 (r44);
    return (r44, r44x5);
  }
  
  proc poly1305_avx_setup (r:W64.t Array3.t) : W128.t Array5.t *
                                               W128.t Array4.t *
                                               W128.t Array5.t *
                                               W128.t Array4.t *
                                               W128.t Array5.t *
                                               W128.t Array4.t = {
    var aux: int;
    
    var r44:W128.t Array5.t;
    var r44x5:W128.t Array4.t;
    var r22:W128.t Array5.t;
    var r22x5:W128.t Array4.t;
    var r12:W128.t Array5.t;
    var r12x5:W128.t Array4.t;
    var i:int;
    var rt:W64.t Array3.t;
    r12 <- witness;
    r12x5 <- witness;
    r22 <- witness;
    r22x5 <- witness;
    r44 <- witness;
    r44x5 <- witness;
    rt <- witness;
    i <- 0;
    while (i < 2) {
      rt.[i] <- r.[i];
      i <- i + 1;
    }
    rt.[2] <- (W64.of_int 0);
    r12 <@ unpack (r12, rt, 1);
    rt <@ mulmod (rt, r);
    r12 <@ unpack (r12, rt, 0);
    r12x5 <@ times_5 (r12);
    (r22, r22x5) <@ broadcast_r2 (r12, r12x5);
    rt <@ mulmod (rt, r);
    rt <@ mulmod (rt, r);
    (r44, r44x5) <@ broadcast_r4 (rt);
    return (r44, r44x5, r22, r22x5, r12, r12x5);
  }
  
  proc pack_avx (h:W128.t Array5.t) : W64.t Array3.t = {
    var aux: bool;
    var aux_0: W64.t;
    
    var r:W64.t Array3.t;
    var t:W128.t Array3.t;
    var u:W128.t Array2.t;
    var d:W64.t Array3.t;
    var cf:bool;
    var c:W64.t;
    var cx4:W64.t;
    var  _0:bool;
    var  _1:bool;
    d <- witness;
    r <- witness;
    t <- witness;
    u <- witness;
    t.[0] <- (h.[1] \vshl64u128 (W8.of_int 26));
    t.[0] <- (t.[0] \vadd64u128 h.[0]);
    t.[1] <- (h.[3] \vshl64u128 (W8.of_int 26));
    t.[1] <- (t.[1] \vadd64u128 h.[2]);
    t.[2] <- x86_VPSRLDQ_128 h.[4] (W8.of_int 8);
    t.[2] <- (t.[2] \vadd64u128 h.[4]);
    u.[0] <- x86_VPUNPCKL_2u64 t.[0] t.[1];
    u.[1] <- x86_VPUNPCKH_2u64 t.[0] t.[1];
    t.[0] <- (u.[0] \vadd64u128 u.[1]);
    d.[0] <- x86_VPEXTR_64 t.[0] (W8.of_int 0);
    d.[1] <- x86_VPEXTR_64 t.[0] (W8.of_int 1);
    d.[2] <- x86_VPEXTR_64 t.[2] (W8.of_int 0);
    r.[0] <- d.[1];
    r.[0] <- (r.[0] `<<` (W8.of_int 52));
    r.[1] <- d.[1];
    r.[1] <- (r.[1] `>>` (W8.of_int 12));
    r.[2] <- d.[2];
    r.[2] <- (r.[2] `>>` (W8.of_int 24));
    d.[2] <- (d.[2] `<<` (W8.of_int 40));
    (aux, aux_0) <- addc_64 r.[0] d.[0] false;
    cf <- aux;
    r.[0] <- aux_0;
    (aux, aux_0) <- addc_64 r.[1] d.[2] cf;
    cf <- aux;
    r.[1] <- aux_0;
    (aux, aux_0) <- addc_64 r.[2] (W64.of_int 0) cf;
     _0 <- aux;
    r.[2] <- aux_0;
    c <- r.[2];
    cx4 <- r.[2];
    r.[2] <- (r.[2] `&` (W64.of_int 3));
    c <- (c `>>` (W8.of_int 2));
    cx4 <- (cx4 `&` (W64.of_int (- 4)));
    c <- (c + cx4);
    (aux, aux_0) <- addc_64 r.[0] c false;
    cf <- aux;
    r.[0] <- aux_0;
    (aux, aux_0) <- addc_64 r.[1] (W64.of_int 0) cf;
    cf <- aux;
    r.[1] <- aux_0;
    (aux, aux_0) <- addc_64 r.[2] (W64.of_int 0) cf;
     _1 <- aux;
    r.[2] <- aux_0;
    return (r);
  }
  
  proc carry_reduce_avx (x:W128.t Array5.t, mask26:W128.t) : W128.t Array5.t = {
    
    var z:W128.t Array2.t;
    var t:W128.t;
    z <- witness;
    z.[0] <- (x.[0] \vshr64u128 (W8.of_int 26));
    z.[1] <- (x.[3] \vshr64u128 (W8.of_int 26));
    x.[0] <- (x.[0] `&` mask26);
    x.[3] <- (x.[3] `&` mask26);
    x.[1] <- (x.[1] \vadd64u128 z.[0]);
    x.[4] <- (x.[4] \vadd64u128 z.[1]);
    z.[0] <- (x.[1] \vshr64u128 (W8.of_int 26));
    z.[1] <- (x.[4] \vshr64u128 (W8.of_int 26));
    t <- (z.[1] \vshl64u128 (W8.of_int 2));
    z.[1] <- (z.[1] \vadd64u128 t);
    x.[1] <- (x.[1] `&` mask26);
    x.[4] <- (x.[4] `&` mask26);
    x.[2] <- (x.[2] \vadd64u128 z.[0]);
    x.[0] <- (x.[0] \vadd64u128 z.[1]);
    z.[0] <- (x.[2] \vshr64u128 (W8.of_int 26));
    z.[1] <- (x.[0] \vshr64u128 (W8.of_int 26));
    x.[2] <- (x.[2] `&` mask26);
    x.[0] <- (x.[0] `&` mask26);
    x.[3] <- (x.[3] \vadd64u128 z.[0]);
    x.[1] <- (x.[1] \vadd64u128 z.[1]);
    z.[0] <- (x.[3] \vshr64u128 (W8.of_int 26));
    x.[3] <- (x.[3] `&` mask26);
    x.[4] <- (x.[4] \vadd64u128 z.[0]);
    return (x);
  }
  
  proc mulmod_avx (h:W128.t Array5.t, s_r:W128.t Array5.t,
                   s_rx5:W128.t Array4.t, s_mask26:W128.t, s_bit25:W128.t) : 
  W128.t Array5.t = {
    
    var r0:W128.t;
    var r1:W128.t;
    var r4x5:W128.t;
    var t:W128.t Array5.t;
    var u:W128.t Array4.t;
    var r2:W128.t;
    var r3x5:W128.t;
    var r3:W128.t;
    var r2x5:W128.t;
    t <- witness;
    u <- witness;
    r0 <- s_r.[0];
    r1 <- s_r.[1];
    r4x5 <- s_rx5.[(4 - 1)];
    t.[0] <- x86_VPMULU_128 h.[0] r0;
    t.[1] <- x86_VPMULU_128 h.[1] r0;
    t.[2] <- x86_VPMULU_128 h.[2] r0;
    t.[3] <- x86_VPMULU_128 h.[3] r0;
    t.[4] <- x86_VPMULU_128 h.[4] r0;
    u.[0] <- x86_VPMULU_128 h.[0] r1;
    u.[1] <- x86_VPMULU_128 h.[1] r1;
    u.[2] <- x86_VPMULU_128 h.[2] r1;
    u.[3] <- x86_VPMULU_128 h.[3] r1;
    r2 <- s_r.[2];
    t.[1] <- (t.[1] \vadd64u128 u.[0]);
    t.[2] <- (t.[2] \vadd64u128 u.[1]);
    t.[3] <- (t.[3] \vadd64u128 u.[2]);
    t.[4] <- (t.[4] \vadd64u128 u.[3]);
    u.[0] <- x86_VPMULU_128 h.[1] r4x5;
    u.[1] <- x86_VPMULU_128 h.[2] r4x5;
    u.[2] <- x86_VPMULU_128 h.[3] r4x5;
    u.[3] <- x86_VPMULU_128 h.[4] r4x5;
    r3x5 <- s_rx5.[(3 - 1)];
    t.[0] <- (t.[0] \vadd64u128 u.[0]);
    t.[1] <- (t.[1] \vadd64u128 u.[1]);
    t.[2] <- (t.[2] \vadd64u128 u.[2]);
    t.[3] <- (t.[3] \vadd64u128 u.[3]);
    u.[0] <- x86_VPMULU_128 h.[0] r2;
    u.[1] <- x86_VPMULU_128 h.[1] r2;
    u.[2] <- x86_VPMULU_128 h.[2] r2;
    r3 <- s_r.[3];
    t.[2] <- (t.[2] \vadd64u128 u.[0]);
    t.[3] <- (t.[3] \vadd64u128 u.[1]);
    t.[4] <- (t.[4] \vadd64u128 u.[2]);
    u.[0] <- x86_VPMULU_128 h.[2] r3x5;
    u.[1] <- x86_VPMULU_128 h.[3] r3x5;
    h.[2] <- x86_VPMULU_128 h.[4] r3x5;
    r2x5 <- s_rx5.[(2 - 1)];
    t.[0] <- (t.[0] \vadd64u128 u.[0]);
    t.[1] <- (t.[1] \vadd64u128 u.[1]);
    h.[2] <- (h.[2] \vadd64u128 t.[2]);
    u.[0] <- x86_VPMULU_128 h.[0] r3;
    u.[1] <- x86_VPMULU_128 h.[1] r3;
    t.[3] <- (t.[3] \vadd64u128 u.[0]);
    t.[4] <- (t.[4] \vadd64u128 u.[1]);
    u.[0] <- x86_VPMULU_128 h.[3] r2x5;
    h.[1] <- x86_VPMULU_128 h.[4] r2x5;
    t.[0] <- (t.[0] \vadd64u128 u.[0]);
    h.[1] <- (h.[1] \vadd64u128 t.[1]);
    u.[0] <- x86_VPMULU_128 h.[4] s_rx5.[(1 - 1)];
    u.[1] <- x86_VPMULU_128 h.[0] s_r.[4];
    h.[0] <- (t.[0] \vadd64u128 u.[0]);
    h.[3] <- t.[3];
    h.[4] <- (t.[4] \vadd64u128 u.[1]);
    return (h);
  }
  
  proc mainloop_avx_v1 (h:W128.t Array5.t, in_0:W64.t, s_r44:W128.t Array5.t,
                        s_r44x5:W128.t Array4.t, s_r22:W128.t Array5.t,
                        s_r22x5:W128.t Array4.t, s_mask26:W128.t,
                        s_bit25:W128.t) : W128.t Array5.t * W64.t = {
    
    var r0:W128.t;
    var r1:W128.t;
    var r4x5:W128.t;
    var t:W128.t Array5.t;
    var u:W128.t Array4.t;
    var m0:W128.t;
    var r2:W128.t;
    var m1:W128.t;
    var m:W128.t Array5.t;
    var r3x5:W128.t;
    var r3:W128.t;
    var s_h:W128.t Array5.t;
    var r2x5:W128.t;
    var mt:W128.t;
    var mask26:W128.t;
    m <- witness;
    s_h <- witness;
    t <- witness;
    u <- witness;
    r0 <- s_r44.[0];
    r1 <- s_r44.[1];
    r4x5 <- s_r44x5.[(4 - 1)];
    t.[0] <- x86_VPMULU_128 h.[0] r0;
    u.[0] <- x86_VPMULU_128 h.[0] r1;
    t.[1] <- x86_VPMULU_128 h.[1] r0;
    u.[1] <- x86_VPMULU_128 h.[1] r1;
    t.[2] <- x86_VPMULU_128 h.[2] r0;
    u.[2] <- x86_VPMULU_128 h.[2] r1;
    t.[3] <- x86_VPMULU_128 h.[3] r0;
    t.[1] <- (t.[1] \vadd64u128 u.[0]);
    u.[3] <- x86_VPMULU_128 h.[3] r1;
    t.[2] <- (t.[2] \vadd64u128 u.[1]);
    t.[4] <- x86_VPMULU_128 h.[4] r0;
    t.[3] <- (t.[3] \vadd64u128 u.[2]);
    t.[4] <- (t.[4] \vadd64u128 u.[3]);
    u.[0] <- x86_VPMULU_128 h.[1] r4x5;
    m0 <- (loadW128 Glob.mem (in_0 + (W64.of_int 0)));
    u.[1] <- x86_VPMULU_128 h.[2] r4x5;
    r2 <- s_r44.[2];
    u.[2] <- x86_VPMULU_128 h.[3] r4x5;
    u.[3] <- x86_VPMULU_128 h.[4] r4x5;
    t.[0] <- (t.[0] \vadd64u128 u.[0]);
    m1 <- (loadW128 Glob.mem (in_0 + (W64.of_int 16)));
    t.[1] <- (t.[1] \vadd64u128 u.[1]);
    t.[2] <- (t.[2] \vadd64u128 u.[2]);
    t.[3] <- (t.[3] \vadd64u128 u.[3]);
    u.[0] <- x86_VPMULU_128 h.[0] r2;
    m.[0] <- x86_VPUNPCKL_2u64 m0 m1;
    u.[1] <- x86_VPMULU_128 h.[1] r2;
    m.[3] <- x86_VPUNPCKH_2u64 m0 m1;
    u.[2] <- x86_VPMULU_128 h.[2] r2;
    t.[2] <- (t.[2] \vadd64u128 u.[0]);
    r3x5 <- s_r44x5.[(3 - 1)];
    t.[3] <- (t.[3] \vadd64u128 u.[1]);
    t.[4] <- (t.[4] \vadd64u128 u.[2]);
    u.[0] <- x86_VPMULU_128 h.[2] r3x5;
    u.[1] <- x86_VPMULU_128 h.[3] r3x5;
    m.[1] <- m.[0];
    h.[2] <- x86_VPMULU_128 h.[4] r3x5;
    m.[1] <- (m.[1] \vshr64u128 (W8.of_int 26));
    m.[1] <- (m.[1] `&` s_mask26);
    r3 <- s_r44.[3];
    t.[0] <- (t.[0] \vadd64u128 u.[0]);
    t.[1] <- (t.[1] \vadd64u128 u.[1]);
    h.[2] <- (h.[2] \vadd64u128 t.[2]);
    u.[0] <- x86_VPMULU_128 h.[0] r3;
    m.[4] <- m.[3];
    s_h.[2] <- h.[2];
    u.[1] <- x86_VPMULU_128 h.[1] r3;
    m.[4] <- (m.[4] \vshr64u128 (W8.of_int 40));
    m.[4] <- (m.[4] `|` s_bit25);
    r2x5 <- s_r44x5.[(2 - 1)];
    t.[3] <- (t.[3] \vadd64u128 u.[0]);
    t.[4] <- (t.[4] \vadd64u128 u.[1]);
    u.[0] <- x86_VPMULU_128 h.[3] r2x5;
    m.[2] <- m.[0];
    s_h.[3] <- t.[3];
    h.[1] <- x86_VPMULU_128 h.[4] r2x5;
    m.[2] <- (m.[2] \vshr64u128 (W8.of_int 52));
    t.[0] <- (t.[0] \vadd64u128 u.[0]);
    h.[1] <- (h.[1] \vadd64u128 t.[1]);
    u.[0] <- x86_VPMULU_128 h.[4] s_r44x5.[(1 - 1)];
    mt <- (m.[3] \vshl64u128 (W8.of_int 12));
    s_h.[1] <- h.[1];
    u.[1] <- x86_VPMULU_128 h.[0] s_r44.[4];
    m.[2] <- (m.[2] `|` mt);
    mask26 <- s_mask26;
    h.[0] <- (t.[0] \vadd64u128 u.[0]);
    h.[4] <- (t.[4] \vadd64u128 u.[1]);
    s_h.[0] <- h.[0];
    s_h.[4] <- h.[4];
    m.[0] <- (m.[0] `&` mask26);
    m.[2] <- (m.[2] `&` mask26);
    m.[3] <- (m.[3] \vshr64u128 (W8.of_int 14));
    m.[3] <- (m.[3] `&` mask26);
    r0 <- s_r22.[0];
    r1 <- s_r22.[1];
    r4x5 <- s_r22x5.[(4 - 1)];
    t.[0] <- x86_VPMULU_128 m.[0] r0;
    u.[0] <- x86_VPMULU_128 m.[0] r1;
    t.[1] <- x86_VPMULU_128 m.[1] r0;
    u.[1] <- x86_VPMULU_128 m.[1] r1;
    t.[2] <- x86_VPMULU_128 m.[2] r0;
    u.[2] <- x86_VPMULU_128 m.[2] r1;
    t.[0] <- (t.[0] \vadd64u128 s_h.[0]);
    t.[3] <- x86_VPMULU_128 m.[3] r0;
    t.[1] <- (t.[1] \vadd64u128 s_h.[1]);
    t.[1] <- (t.[1] \vadd64u128 u.[0]);
    u.[3] <- x86_VPMULU_128 m.[3] r1;
    t.[2] <- (t.[2] \vadd64u128 s_h.[2]);
    t.[2] <- (t.[2] \vadd64u128 u.[1]);
    t.[4] <- x86_VPMULU_128 m.[4] r0;
    t.[3] <- (t.[3] \vadd64u128 s_h.[3]);
    t.[3] <- (t.[3] \vadd64u128 u.[2]);
    t.[4] <- (t.[4] \vadd64u128 s_h.[4]);
    t.[4] <- (t.[4] \vadd64u128 u.[3]);
    u.[0] <- x86_VPMULU_128 m.[1] r4x5;
    m0 <- (loadW128 Glob.mem (in_0 + (W64.of_int 32)));
    u.[1] <- x86_VPMULU_128 m.[2] r4x5;
    r2 <- s_r22.[2];
    u.[2] <- x86_VPMULU_128 m.[3] r4x5;
    u.[3] <- x86_VPMULU_128 m.[4] r4x5;
    t.[0] <- (t.[0] \vadd64u128 u.[0]);
    m1 <- (loadW128 Glob.mem (in_0 + (W64.of_int 48)));
    t.[1] <- (t.[1] \vadd64u128 u.[1]);
    t.[2] <- (t.[2] \vadd64u128 u.[2]);
    t.[3] <- (t.[3] \vadd64u128 u.[3]);
    u.[0] <- x86_VPMULU_128 m.[0] r2;
    h.[0] <- x86_VPUNPCKL_2u64 m0 m1;
    u.[1] <- x86_VPMULU_128 m.[1] r2;
    h.[3] <- x86_VPUNPCKH_2u64 m0 m1;
    u.[2] <- x86_VPMULU_128 m.[2] r2;
    t.[2] <- (t.[2] \vadd64u128 u.[0]);
    r3x5 <- s_r22x5.[(3 - 1)];
    t.[3] <- (t.[3] \vadd64u128 u.[1]);
    t.[4] <- (t.[4] \vadd64u128 u.[2]);
    u.[0] <- x86_VPMULU_128 m.[2] r3x5;
    u.[1] <- x86_VPMULU_128 m.[3] r3x5;
    h.[1] <- h.[0];
    m.[2] <- x86_VPMULU_128 m.[4] r3x5;
    h.[1] <- (h.[1] \vshr64u128 (W8.of_int 26));
    h.[1] <- (h.[1] `&` s_mask26);
    r3 <- s_r22.[3];
    t.[0] <- (t.[0] \vadd64u128 u.[0]);
    t.[1] <- (t.[1] \vadd64u128 u.[1]);
    m.[2] <- (m.[2] \vadd64u128 t.[2]);
    u.[0] <- x86_VPMULU_128 m.[0] r3;
    h.[4] <- h.[3];
    u.[1] <- x86_VPMULU_128 m.[1] r3;
    h.[4] <- (h.[4] \vshr64u128 (W8.of_int 40));
    h.[4] <- (h.[4] `|` s_bit25);
    r2x5 <- s_r22x5.[(2 - 1)];
    t.[3] <- (t.[3] \vadd64u128 u.[0]);
    t.[4] <- (t.[4] \vadd64u128 u.[1]);
    u.[0] <- x86_VPMULU_128 m.[3] r2x5;
    h.[2] <- h.[0];
    m.[1] <- x86_VPMULU_128 m.[4] r2x5;
    h.[2] <- (h.[2] \vshr64u128 (W8.of_int 52));
    t.[0] <- (t.[0] \vadd64u128 u.[0]);
    m.[1] <- (m.[1] \vadd64u128 t.[1]);
    u.[0] <- x86_VPMULU_128 m.[4] s_r22x5.[(1 - 1)];
    mt <- (h.[3] \vshl64u128 (W8.of_int 12));
    u.[1] <- x86_VPMULU_128 m.[0] s_r22.[4];
    h.[2] <- (h.[2] `|` mt);
    mask26 <- s_mask26;
    m.[0] <- (t.[0] \vadd64u128 u.[0]);
    m.[3] <- t.[3];
    m.[4] <- (t.[4] \vadd64u128 u.[1]);
    h.[0] <- (h.[0] `&` mask26);
    h.[0] <- (h.[0] \vadd64u128 m.[0]);
    h.[2] <- (h.[2] `&` mask26);
    h.[2] <- (h.[2] \vadd64u128 m.[2]);
    h.[3] <- (h.[3] \vshr64u128 (W8.of_int 14));
    h.[3] <- (h.[3] `&` mask26);
    h.[3] <- (h.[3] \vadd64u128 m.[3]);
    in_0 <- (in_0 + (W64.of_int 64));
    h.[1] <- (h.[1] \vadd64u128 m.[1]);
    h.[4] <- (h.[4] \vadd64u128 m.[4]);
    h <@ carry_reduce_avx (h, mask26);
    return (h, in_0);
  }
  
  proc final_avx_v0 (h:W128.t Array5.t, s_r:W128.t Array5.t,
                     s_rx5:W128.t Array4.t, s_mask26:W128.t, s_bit25:W128.t) : 
  W128.t Array5.t = {
    
    var mask26:W128.t;
    
    h <@ mulmod_avx (h, s_r, s_rx5, s_mask26, s_bit25);
    mask26 <- s_mask26;
    h <@ carry_reduce_avx (h, mask26);
    return (h);
  }
  
  proc poly1305_avx_update (in_0:W64.t, len:W64.t, r44:W128.t Array5.t,
                            r44x5:W128.t Array4.t, r22:W128.t Array5.t,
                            r22x5:W128.t Array4.t, r12:W128.t Array5.t,
                            r12x5:W128.t Array4.t) : W64.t * W64.t *
                                                     W64.t Array3.t = {
    var aux: int;
    
    var h64:W64.t Array3.t;
    var i:int;
    var h:W128.t Array5.t;
    var t:W128.t;
    var s_mask26:W128.t;
    var mask26:W128.t;
    var s_bit25:W128.t;
    h <- witness;
    h64 <- witness;
    i <- 0;
    while (i < 5) {
      h.[i] <- x86_VPBROADCAST_2u64 zero_u64;
      i <- i + 1;
    }
    t <- x86_VPBROADCAST_2u64 mask26_u64;
    s_mask26 <- t;
    mask26 <- t;
    t <- x86_VPBROADCAST_2u64 bit25_u64;
    s_bit25 <- t;
    
    while (((W64.of_int 64) \ule len)) {
      (h, in_0) <@ mainloop_avx_v1 (h, in_0, r44, r44x5, r22, r22x5,
      s_mask26, s_bit25);
      len <- (len - (W64.of_int 64));
    }
    h <@ final_avx_v0 (h, r12, r12x5, s_mask26, s_bit25);
    h64 <@ pack_avx (h);
    return (in_0, len, h64);
  }
  
  proc poly1305_avx_wrapper (out:W64.t, in_0:W64.t, inlen:W64.t, k:W64.t) : unit = {
    
    var len:W64.t;
    var h:W64.t Array3.t;
    var r:W64.t Array3.t;
    var r44:W128.t Array5.t;
    var r44x5:W128.t Array4.t;
    var r22:W128.t Array5.t;
    var r22x5:W128.t Array4.t;
    var r12:W128.t Array5.t;
    var r12x5:W128.t Array4.t;
    h <- witness;
    r <- witness;
    r12 <- witness;
    r12x5 <- witness;
    r22 <- witness;
    r22x5 <- witness;
    r44 <- witness;
    r44x5 <- witness;
    len <- inlen;
    (h, r, k) <@ poly1305_ref3_setup (k);
    (r44, r44x5, r22, r22x5, r12, r12x5) <@ poly1305_avx_setup (r);
    (in_0, len, h) <@ poly1305_avx_update (in_0, len, r44, r44x5, r22, r22x5,
    r12, r12x5);
    (in_0, len, h) <@ poly1305_ref3_update (in_0, len, h, r);
    poly1305_ref3_last (out, in_0, len, k, h, r);
    return ();
  }
  
  proc poly1305_avx (out:W64.t, in_0:W64.t, inlen:W64.t, k:W64.t) : unit = {
    
    
    
    if ((inlen \ult (W64.of_int 1024))) {
      poly1305_ref3_local (out, in_0, inlen, k);
    } else {
      poly1305_avx_wrapper (out, in_0, inlen, k);
    }
    return ();
  }
}.


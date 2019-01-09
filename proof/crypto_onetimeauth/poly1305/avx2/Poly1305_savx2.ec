require import List Jasmin_model Int IntDiv CoreMap.
require import Array2 Array3 Array4 Array5.
require import WArray16 WArray24 WArray64 WArray96 WArray128 WArray160.

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
  
  proc load_last (ptr:W64.t, len:W64.t) : W64.t Array2.t = {
    
    var x:W64.t Array2.t;
    var s:W64.t Array2.t;
    var j:W64.t;
    var c:W8.t;
    s <- witness;
    x <- witness;
    s.[0] <- (W64.of_int 0);
    s.[1] <- (W64.of_int 0);
    j <- (W64.of_int 0);
    
    while ((j \ult len)) {
      c <- (loadW8 Glob.mem (ptr + j));
      s =
      Array2.init
      (WArray16.get64 (WArray16.set8 (WArray16.init64 (fun i => s.[i])) (W64.to_uint j) c));
      j <- (j + (W64.of_int 1));
    }
    s =
    Array2.init
    (WArray16.get64 (WArray16.set8 (WArray16.init64 (fun i => s.[i])) (W64.to_uint j) (W8.of_int 1)));
    x.[0] <- s.[0];
    x.[1] <- s.[1];
    return (x);
  }
  
  proc store (p:W64.t, x:W64.t Array3.t) : unit = {
    
    
    
    Glob.mem <- storeW64 Glob.mem (p + (W64.of_int 0)) x.[0];
    Glob.mem <- storeW64 Glob.mem (p + (W64.of_int 8)) x.[1];
    return ();
  }
  
  proc clamp (k:W64.t) : W64.t Array2.t * W64.t = {
    
    var r:W64.t Array2.t;
    var r54:W64.t;
    r <- witness;
    r <@ load (k);
    r.[0] <- (r.[0] `&` (W64.of_int 1152921487695413247));
    r.[1] <- (r.[1] `&` (W64.of_int 1152921487695413244));
    r54 <- r.[1];
    r54 <- (r54 `>>` (W8.of_int 2));
    r54 <- (r54 + r.[1]);
    return (r, r54);
  }
  
  proc add_bit (h:W64.t Array3.t, m:W64.t Array2.t, b:int) : W64.t Array3.t = {
    var aux: bool;
    var aux_0: W64.t;
    
    var cf:bool;
    var  _0:bool;
    
    (aux, aux_0) <- addc_64 h.[0] m.[0] false;
    cf <- aux;
    h.[0] <- aux_0;
    (aux, aux_0) <- addc_64 h.[1] m.[1] cf;
    cf <- aux;
    h.[1] <- aux_0;
    (aux, aux_0) <- addc_64 h.[2] (W64.of_int b) cf;
     _0 <- aux;
    h.[2] <- aux_0;
    return (h);
  }
  
  proc mulmod (h:W64.t Array3.t, r:W64.t Array2.t, r54:W64.t) : W64.t Array3.t = {
    var aux: bool;
    var aux_0: W64.t;
    
    var low:W64.t;
    var high:W64.t;
    var t:W64.t Array3.t;
    var cf:bool;
    var h2r:W64.t;
    var h2rx4:W64.t;
    var  _0:bool;
    var  _1:bool;
    var  _2:bool;
    var  _3:bool;
    var  _4:bool;
    t <- witness;
    low <- h.[0];
    (high, low) <- mulu_64 low r.[0];
    t.[0] <- low;
    t.[1] <- high;
    low <- h.[1];
    (high, low) <- mulu_64 low r54;
    (aux, aux_0) <- addc_64 t.[0] low false;
    cf <- aux;
    t.[0] <- aux_0;
    (aux, aux_0) <- addc_64 t.[1] high cf;
     _0 <- aux;
    t.[1] <- aux_0;
    t.[2] <- (W64.of_int 0);
    low <- h.[0];
    (high, low) <- mulu_64 low r.[1];
    (aux, aux_0) <- addc_64 t.[1] low false;
    cf <- aux;
    t.[1] <- aux_0;
    (aux, aux_0) <- addc_64 t.[2] high cf;
     _1 <- aux;
    t.[2] <- aux_0;
    low <- h.[1];
    (high, low) <- mulu_64 low r.[0];
    (aux, aux_0) <- addc_64 t.[1] low false;
    cf <- aux;
    t.[1] <- aux_0;
    (aux, aux_0) <- addc_64 t.[2] high cf;
     _2 <- aux;
    t.[2] <- aux_0;
    low <- h.[2];
    low <- (low * r54);
    (aux, aux_0) <- addc_64 t.[1] low false;
    cf <- aux;
    t.[1] <- aux_0;
    (aux, aux_0) <- addc_64 t.[2] (W64.of_int 0) cf;
     _3 <- aux;
    t.[2] <- aux_0;
    h.[2] <- (h.[2] * r.[0]);
    h.[0] <- t.[0];
    h.[1] <- t.[1];
    h.[2] <- (h.[2] + t.[2]);
    h2r <- h.[2];
    h2rx4 <- h.[2];
    h.[2] <- (h.[2] `&` (W64.of_int 3));
    h2r <- (h2r `>>` (W8.of_int 2));
    h2rx4 <- (h2rx4 `&` (W64.of_int (- 4)));
    h2r <- (h2r + h2rx4);
    (aux, aux_0) <- addc_64 h.[0] h2r false;
    cf <- aux;
    h.[0] <- aux_0;
    (aux, aux_0) <- addc_64 h.[1] (W64.of_int 0) cf;
    cf <- aux;
    h.[1] <- aux_0;
    (aux, aux_0) <- addc_64 h.[2] (W64.of_int 0) cf;
     _4 <- aux;
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
  
  proc poly1305_ref3_setup (k:W64.t) : W64.t Array3.t * W64.t Array2.t *
                                       W64.t * W64.t = {
    var aux: int;
    
    var h:W64.t Array3.t;
    var r:W64.t Array2.t;
    var r54:W64.t;
    var i:int;
    h <- witness;
    r <- witness;
    i <- 0;
    while (i < 3) {
      h.[i] <- (W64.of_int 0);
      i <- i + 1;
    }
    (r, r54) <@ clamp (k);
    k <- (k + (W64.of_int 16));
    return (h, r, r54, k);
  }
  
  proc poly1305_ref3_update (in_0:W64.t, inlen:W64.t, h:W64.t Array3.t,
                             r:W64.t Array2.t, r54:W64.t) : W64.t * W64.t *
                                                            W64.t Array3.t = {
    
    var m:W64.t Array2.t;
    m <- witness;
    
    while (((W64.of_int 16) \ule inlen)) {
      m <@ load (in_0);
      h <@ add_bit (h, m, 1);
      h <@ mulmod (h, r, r54);
      in_0 <- (in_0 + (W64.of_int 16));
      inlen <- (inlen - (W64.of_int 16));
    }
    return (in_0, inlen, h);
  }
  
  proc poly1305_ref3_last (out:W64.t, in_0:W64.t, inlen:W64.t, k:W64.t,
                           h:W64.t Array3.t, r:W64.t Array2.t, r54:W64.t) : unit = {
    
    var m:W64.t Array2.t;
    var s:W64.t Array2.t;
    m <- witness;
    s <- witness;
    if (((W64.of_int 0) \ult inlen)) {
      m <@ load_last (in_0, inlen);
      h <@ add_bit (h, m, 0);
      h <@ mulmod (h, r, r54);
    } else {
      
    }
    h <@ freeze (h);
    s <@ load (k);
    h <@ add_bit (h, s, 0);
    store (out, h);
    return ();
  }
  
  proc poly1305_ref3_local (out:W64.t, in_0:W64.t, inlen:W64.t, k:W64.t) : unit = {
    
    var h:W64.t Array3.t;
    var r:W64.t Array2.t;
    var r54:W64.t;
    var len:W64.t;
    h <- witness;
    r <- witness;
    (h, r, r54, k) <@ poly1305_ref3_setup (k);
    len <- inlen;
    (in_0, len, h) <@ poly1305_ref3_update (in_0, len, h, r, r54);
    poly1305_ref3_last (out, in_0, len, k, h, r, r54);
    return ();
  }
  
  proc unpack (r1234:W256.t Array5.t, rt:W64.t Array3.t, o:int) : W256.t Array5.t = {
    
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
    r1234 =
    Array5.init
    (WArray160.get256 (WArray160.set64 (WArray160.init256 (fun i => r1234.[i])) (o + 0) l));
    l <- rt.[0];
    l <- (l `>>` (W8.of_int 26));
    l <- (l `&` (W64.of_int mask26));
    r1234 =
    Array5.init
    (WArray160.get256 (WArray160.set64 (WArray160.init256 (fun i => r1234.[i])) (o + 4) l));
    l <- rt.[0];
    ( _0,  _1,  _2,  _3,  _4, l) <- x86_SHRD_64 l rt.[1] (W8.of_int 52);
    h <- l;
    l <- (l `&` (W64.of_int mask26));
    r1234 =
    Array5.init
    (WArray160.get256 (WArray160.set64 (WArray160.init256 (fun i => r1234.[i])) (o + 8) l));
    l <- h;
    l <- (l `>>` (W8.of_int 26));
    l <- (l `&` (W64.of_int mask26));
    r1234 =
    Array5.init
    (WArray160.get256 (WArray160.set64 (WArray160.init256 (fun i => r1234.[i])) (o + 12) l));
    l <- rt.[1];
    ( _5,  _6,  _7,  _8,  _9, l) <- x86_SHRD_64 l rt.[2] (W8.of_int 40);
    r1234 =
    Array5.init
    (WArray160.get256 (WArray160.set64 (WArray160.init256 (fun i => r1234.[i])) (o + 16) l));
    return (r1234);
  }
  
  proc times_5 (r1234:W256.t Array5.t) : W256.t Array4.t = {
    var aux: int;
    
    var r1234x5:W256.t Array4.t;
    var five:W256.t;
    var i:int;
    var t:W256.t;
    r1234x5 <- witness;
    five <- x86_VPBROADCAST_4u64 five_u64;
    i <- 0;
    while (i < 4) {
      t <- x86_VPMULU_256 five r1234.[(1 + i)];
      r1234x5.[i] <- t;
      i <- i + 1;
    }
    return (r1234x5);
  }
  
  proc broadcast_r4 (r1234:W256.t Array5.t, r1234x5:W256.t Array4.t) : 
  W256.t Array5.t * W256.t Array4.t = {
    var aux: int;
    
    var r4444:W256.t Array5.t;
    var r4444x5:W256.t Array4.t;
    var i:int;
    var t:W256.t Array5.t;
    r4444 <- witness;
    r4444x5 <- witness;
    t <- witness;
    i <- 0;
    while (i < 5) {
      t.[i] <-
      x86_VPBROADCAST_4u64 (get64 (WArray160.init256 (fun i => r1234.[i]))
                           (4 * i));
      r4444.[i] <- t.[i];
      i <- i + 1;
    }
    i <- 0;
    while (i < 4) {
      t.[i] <-
      x86_VPBROADCAST_4u64 (get64 (WArray128.init256 (fun i => r1234x5.[i]))
                           (4 * i));
      r4444x5.[i] <- t.[i];
      i <- i + 1;
    }
    return (r4444, r4444x5);
  }
  
  proc poly1305_avx2_setup (r:W64.t Array2.t, r54:W64.t) : W256.t Array5.t *
                                                           W256.t Array4.t *
                                                           W256.t Array5.t *
                                                           W256.t Array4.t = {
    var aux: int;
    
    var r4444:W256.t Array5.t;
    var r4444x5:W256.t Array4.t;
    var r1234:W256.t Array5.t;
    var r1234x5:W256.t Array4.t;
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
    r1234 <@ unpack (r1234, rt, 3);
    i <- 0;
    while (i < 3) {
      rt <@ mulmod (rt, r, r54);
      r1234 <@ unpack (r1234, rt, (2 - i));
      i <- i + 1;
    }
    r1234x5 <@ times_5 (r1234);
    (r4444, r4444x5) <@ broadcast_r4 (r1234, r1234x5);
    return (r4444, r4444x5, r1234, r1234x5);
  }
  
  proc load_avx2 (in_0:W64.t, mask26:W256.t, s_bit25:W256.t) : W256.t Array5.t *
                                                               W64.t = {
    
    var m:W256.t Array5.t;
    var t:W256.t;
    m <- witness;
    t <- (loadW256 Glob.mem (in_0 + (W64.of_int 0)));
    m.[1] <- (loadW256 Glob.mem (in_0 + (W64.of_int 32)));
    in_0 <- (in_0 + (W64.of_int 64));
    m.[0] <- x86_VPERM2I128 t m.[1] (W8.of_int 32);
    m.[1] <- x86_VPERM2I128 t m.[1] (W8.of_int 49);
    m.[2] <- x86_VPSRLDQ_256 m.[0] (W8.of_int 6);
    m.[3] <- x86_VPSRLDQ_256 m.[1] (W8.of_int 6);
    m.[4] <- x86_VPUNPCKH_4u64 m.[0] m.[1];
    m.[0] <- x86_VPUNPCKL_4u64 m.[0] m.[1];
    m.[3] <- x86_VPUNPCKL_4u64 m.[2] m.[3];
    m.[2] <- (m.[3] \vshr64u256 (W8.of_int 4));
    m.[2] <- (m.[2] `&` mask26);
    m.[1] <- (m.[0] \vshr64u256 (W8.of_int 26));
    m.[0] <- (m.[0] `&` mask26);
    m.[3] <- (m.[3] \vshr64u256 (W8.of_int 30));
    m.[3] <- (m.[3] `&` mask26);
    m.[4] <- (m.[4] \vshr64u256 (W8.of_int 40));
    m.[4] <- (m.[4] `|` s_bit25);
    m.[1] <- (m.[1] `&` mask26);
    return (m, in_0);
  }
  
  proc pack_avx2 (h:W256.t Array5.t) : W64.t Array3.t = {
    var aux: bool;
    var aux_0: W64.t;
    
    var r:W64.t Array3.t;
    var t:W256.t Array3.t;
    var u:W256.t Array2.t;
    var t0:W128.t;
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
    t.[0] <- (h.[1] \vshl64u256 (W8.of_int 26));
    t.[0] <- (t.[0] \vadd64u256 h.[0]);
    t.[1] <- (h.[3] \vshl64u256 (W8.of_int 26));
    t.[1] <- (t.[1] \vadd64u256 h.[2]);
    t.[2] <- x86_VPSRLDQ_256 h.[4] (W8.of_int 8);
    t.[2] <- (t.[2] \vadd64u256 h.[4]);
    t.[2] <- x86_VPERMQ t.[2] (W8.of_int 128);
    u.[0] <- x86_VPERM2I128 t.[0] t.[1] (W8.of_int 32);
    u.[1] <- x86_VPERM2I128 t.[0] t.[1] (W8.of_int 49);
    t.[0] <- (u.[0] \vadd64u256 u.[1]);
    u.[0] <- x86_VPUNPCKL_4u64 t.[0] t.[2];
    u.[1] <- x86_VPUNPCKH_4u64 t.[0] t.[2];
    t.[0] <- (u.[0] \vadd64u256 u.[1]);
    t0 <- x86_VEXTRACTI128 t.[0] (W8.of_int 1);
    d.[0] <- x86_VPEXTR_64 (truncateu128 t.[0]) (W8.of_int 0);
    d.[1] <- x86_VPEXTR_64 t0 (W8.of_int 0);
    d.[2] <- x86_VPEXTR_64 t0 (W8.of_int 1);
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
  
  proc carry_reduce_avx2 (x:W256.t Array5.t, mask26:W256.t) : W256.t Array5.t = {
    
    var z:W256.t Array2.t;
    var t:W256.t;
    z <- witness;
    z.[0] <- (x.[0] \vshr64u256 (W8.of_int 26));
    z.[1] <- (x.[3] \vshr64u256 (W8.of_int 26));
    x.[0] <- (x.[0] `&` mask26);
    x.[3] <- (x.[3] `&` mask26);
    x.[1] <- (x.[1] \vadd64u256 z.[0]);
    x.[4] <- (x.[4] \vadd64u256 z.[1]);
    z.[0] <- (x.[1] \vshr64u256 (W8.of_int 26));
    z.[1] <- (x.[4] \vshr64u256 (W8.of_int 26));
    t <- (z.[1] \vshl64u256 (W8.of_int 2));
    z.[1] <- (z.[1] \vadd64u256 t);
    x.[1] <- (x.[1] `&` mask26);
    x.[4] <- (x.[4] `&` mask26);
    x.[2] <- (x.[2] \vadd64u256 z.[0]);
    x.[0] <- (x.[0] \vadd64u256 z.[1]);
    z.[0] <- (x.[2] \vshr64u256 (W8.of_int 26));
    z.[1] <- (x.[0] \vshr64u256 (W8.of_int 26));
    x.[2] <- (x.[2] `&` mask26);
    x.[0] <- (x.[0] `&` mask26);
    x.[3] <- (x.[3] \vadd64u256 z.[0]);
    x.[1] <- (x.[1] \vadd64u256 z.[1]);
    z.[0] <- (x.[3] \vshr64u256 (W8.of_int 26));
    x.[3] <- (x.[3] `&` mask26);
    x.[4] <- (x.[4] \vadd64u256 z.[0]);
    return (x);
  }
  
  proc add_mulmod_avx2 (h:W256.t Array5.t, m:W256.t Array5.t,
                        s_r:W256.t Array5.t, s_rx5:W256.t Array4.t,
                        s_mask26:W256.t, s_bit25:W256.t) : W256.t Array5.t = {
    
    var r0:W256.t;
    var r1:W256.t;
    var r4x5:W256.t;
    var t:W256.t Array5.t;
    var u:W256.t Array4.t;
    var r2:W256.t;
    var r3x5:W256.t;
    var r3:W256.t;
    var r2x5:W256.t;
    t <- witness;
    u <- witness;
    r0 <- s_r.[0];
    r1 <- s_r.[1];
    r4x5 <- s_rx5.[(4 - 1)];
    h.[0] <- (h.[0] \vadd64u256 m.[0]);
    h.[1] <- (h.[1] \vadd64u256 m.[1]);
    h.[2] <- (h.[2] \vadd64u256 m.[2]);
    h.[3] <- (h.[3] \vadd64u256 m.[3]);
    h.[4] <- (h.[4] \vadd64u256 m.[4]);
    t.[0] <- x86_VPMULU_256 h.[0] r0;
    t.[1] <- x86_VPMULU_256 h.[1] r0;
    t.[2] <- x86_VPMULU_256 h.[2] r0;
    t.[3] <- x86_VPMULU_256 h.[3] r0;
    t.[4] <- x86_VPMULU_256 h.[4] r0;
    u.[0] <- x86_VPMULU_256 h.[0] r1;
    u.[1] <- x86_VPMULU_256 h.[1] r1;
    u.[2] <- x86_VPMULU_256 h.[2] r1;
    u.[3] <- x86_VPMULU_256 h.[3] r1;
    r2 <- s_r.[2];
    t.[1] <- (t.[1] \vadd64u256 u.[0]);
    t.[2] <- (t.[2] \vadd64u256 u.[1]);
    t.[3] <- (t.[3] \vadd64u256 u.[2]);
    t.[4] <- (t.[4] \vadd64u256 u.[3]);
    u.[0] <- x86_VPMULU_256 h.[1] r4x5;
    u.[1] <- x86_VPMULU_256 h.[2] r4x5;
    u.[2] <- x86_VPMULU_256 h.[3] r4x5;
    u.[3] <- x86_VPMULU_256 h.[4] r4x5;
    r3x5 <- s_rx5.[(3 - 1)];
    t.[0] <- (t.[0] \vadd64u256 u.[0]);
    t.[1] <- (t.[1] \vadd64u256 u.[1]);
    t.[2] <- (t.[2] \vadd64u256 u.[2]);
    t.[3] <- (t.[3] \vadd64u256 u.[3]);
    u.[0] <- x86_VPMULU_256 h.[0] r2;
    u.[1] <- x86_VPMULU_256 h.[1] r2;
    u.[2] <- x86_VPMULU_256 h.[2] r2;
    r3 <- s_r.[3];
    t.[2] <- (t.[2] \vadd64u256 u.[0]);
    t.[3] <- (t.[3] \vadd64u256 u.[1]);
    t.[4] <- (t.[4] \vadd64u256 u.[2]);
    u.[0] <- x86_VPMULU_256 h.[2] r3x5;
    u.[1] <- x86_VPMULU_256 h.[3] r3x5;
    h.[2] <- x86_VPMULU_256 h.[4] r3x5;
    r2x5 <- s_rx5.[(2 - 1)];
    t.[0] <- (t.[0] \vadd64u256 u.[0]);
    t.[1] <- (t.[1] \vadd64u256 u.[1]);
    h.[2] <- (h.[2] \vadd64u256 t.[2]);
    u.[0] <- x86_VPMULU_256 h.[0] r3;
    u.[1] <- x86_VPMULU_256 h.[1] r3;
    t.[3] <- (t.[3] \vadd64u256 u.[0]);
    t.[4] <- (t.[4] \vadd64u256 u.[1]);
    u.[0] <- x86_VPMULU_256 h.[3] r2x5;
    h.[1] <- x86_VPMULU_256 h.[4] r2x5;
    t.[0] <- (t.[0] \vadd64u256 u.[0]);
    h.[1] <- (h.[1] \vadd64u256 t.[1]);
    u.[0] <- x86_VPMULU_256 h.[4] s_rx5.[(1 - 1)];
    u.[1] <- x86_VPMULU_256 h.[0] s_r.[4];
    h.[0] <- (t.[0] \vadd64u256 u.[0]);
    h.[3] <- t.[3];
    h.[4] <- (t.[4] \vadd64u256 u.[1]);
    return (h);
  }
  
  proc mainloop_avx2_v1 (h:W256.t Array5.t, m:W256.t Array5.t, in_0:W64.t,
                         s_r:W256.t Array5.t, s_rx5:W256.t Array4.t,
                         s_mask26:W256.t, s_bit25:W256.t) : W256.t Array5.t *
                                                            W256.t Array5.t *
                                                            W64.t = {
    
    var r0:W256.t;
    var r1:W256.t;
    var r4x5:W256.t;
    var t:W256.t Array5.t;
    var u:W256.t Array4.t;
    var m0:W256.t;
    var r2:W256.t;
    var r3x5:W256.t;
    var r3:W256.t;
    var r2x5:W256.t;
    var mask26:W256.t;
    var z:W256.t Array2.t;
    var z0:W256.t;
    t <- witness;
    u <- witness;
    z <- witness;
    r0 <- s_r.[0];
    r1 <- s_r.[1];
    r4x5 <- s_rx5.[(4 - 1)];
    h.[0] <- (h.[0] \vadd64u256 m.[0]);
    h.[1] <- (h.[1] \vadd64u256 m.[1]);
    t.[0] <- x86_VPMULU_256 h.[0] r0;
    h.[2] <- (h.[2] \vadd64u256 m.[2]);
    u.[0] <- x86_VPMULU_256 h.[0] r1;
    h.[3] <- (h.[3] \vadd64u256 m.[3]);
    t.[1] <- x86_VPMULU_256 h.[1] r0;
    h.[4] <- (h.[4] \vadd64u256 m.[4]);
    u.[1] <- x86_VPMULU_256 h.[1] r1;
    t.[2] <- x86_VPMULU_256 h.[2] r0;
    u.[2] <- x86_VPMULU_256 h.[2] r1;
    t.[3] <- x86_VPMULU_256 h.[3] r0;
    t.[1] <- (t.[1] \vadd64u256 u.[0]);
    u.[3] <- x86_VPMULU_256 h.[3] r1;
    t.[2] <- (t.[2] \vadd64u256 u.[1]);
    t.[4] <- x86_VPMULU_256 h.[4] r0;
    t.[3] <- (t.[3] \vadd64u256 u.[2]);
    t.[4] <- (t.[4] \vadd64u256 u.[3]);
    u.[0] <- x86_VPMULU_256 h.[1] r4x5;
    m0 <- (loadW256 Glob.mem (in_0 + (W64.of_int 0)));
    u.[1] <- x86_VPMULU_256 h.[2] r4x5;
    r2 <- s_r.[2];
    u.[2] <- x86_VPMULU_256 h.[3] r4x5;
    u.[3] <- x86_VPMULU_256 h.[4] r4x5;
    t.[0] <- (t.[0] \vadd64u256 u.[0]);
    m.[1] <- (loadW256 Glob.mem (in_0 + (W64.of_int 32)));
    t.[1] <- (t.[1] \vadd64u256 u.[1]);
    t.[2] <- (t.[2] \vadd64u256 u.[2]);
    t.[3] <- (t.[3] \vadd64u256 u.[3]);
    u.[0] <- x86_VPMULU_256 h.[0] r2;
    m.[0] <- x86_VPERM2I128 m0 m.[1] (W8.of_int 32);
    u.[1] <- x86_VPMULU_256 h.[1] r2;
    m.[1] <- x86_VPERM2I128 m0 m.[1] (W8.of_int 49);
    u.[2] <- x86_VPMULU_256 h.[2] r2;
    t.[2] <- (t.[2] \vadd64u256 u.[0]);
    r3x5 <- s_rx5.[(3 - 1)];
    t.[3] <- (t.[3] \vadd64u256 u.[1]);
    t.[4] <- (t.[4] \vadd64u256 u.[2]);
    u.[0] <- x86_VPMULU_256 h.[2] r3x5;
    u.[1] <- x86_VPMULU_256 h.[3] r3x5;
    r3 <- s_r.[3];
    h.[2] <- x86_VPMULU_256 h.[4] r3x5;
    m.[2] <- x86_VPSRLDQ_256 m.[0] (W8.of_int 6);
    t.[0] <- (t.[0] \vadd64u256 u.[0]);
    m.[3] <- x86_VPSRLDQ_256 m.[1] (W8.of_int 6);
    t.[1] <- (t.[1] \vadd64u256 u.[1]);
    h.[2] <- (h.[2] \vadd64u256 t.[2]);
    r2x5 <- s_rx5.[(2 - 1)];
    u.[0] <- x86_VPMULU_256 h.[0] r3;
    u.[1] <- x86_VPMULU_256 h.[1] r3;
    m.[4] <- x86_VPUNPCKH_4u64 m.[0] m.[1];
    m.[0] <- x86_VPUNPCKL_4u64 m.[0] m.[1];
    t.[3] <- (t.[3] \vadd64u256 u.[0]);
    t.[4] <- (t.[4] \vadd64u256 u.[1]);
    u.[0] <- x86_VPMULU_256 h.[3] r2x5;
    h.[1] <- x86_VPMULU_256 h.[4] r2x5;
    t.[0] <- (t.[0] \vadd64u256 u.[0]);
    h.[1] <- (h.[1] \vadd64u256 t.[1]);
    mask26 <- s_mask26;
    u.[0] <- x86_VPMULU_256 h.[4] s_rx5.[(1 - 1)];
    u.[1] <- x86_VPMULU_256 h.[0] s_r.[4];
    m.[3] <- x86_VPUNPCKL_4u64 m.[2] m.[3];
    m.[2] <- (m.[3] \vshr64u256 (W8.of_int 4));
    h.[0] <- (t.[0] \vadd64u256 u.[0]);
    z.[0] <- (h.[0] \vshr64u256 (W8.of_int 26));
    h.[0] <- (h.[0] `&` mask26);
    h.[3] <- (t.[3] `&` mask26);
    z.[1] <- (t.[3] \vshr64u256 (W8.of_int 26));
    h.[4] <- (t.[4] \vadd64u256 u.[1]);
    m.[2] <- (m.[2] `&` mask26);
    m.[1] <- (m.[0] \vshr64u256 (W8.of_int 26));
    h.[1] <- (h.[1] \vadd64u256 z.[0]);
    h.[4] <- (h.[4] \vadd64u256 z.[1]);
    z.[0] <- (h.[1] \vshr64u256 (W8.of_int 26));
    z.[1] <- (h.[4] \vshr64u256 (W8.of_int 26));
    z0 <- (z.[1] \vshl64u256 (W8.of_int 2));
    z.[1] <- (z.[1] \vadd64u256 z0);
    h.[1] <- (h.[1] `&` mask26);
    h.[4] <- (h.[4] `&` mask26);
    h.[2] <- (h.[2] \vadd64u256 z.[0]);
    h.[0] <- (h.[0] \vadd64u256 z.[1]);
    z.[0] <- (h.[2] \vshr64u256 (W8.of_int 26));
    z.[1] <- (h.[0] \vshr64u256 (W8.of_int 26));
    h.[2] <- (h.[2] `&` mask26);
    h.[0] <- (h.[0] `&` mask26);
    h.[3] <- (h.[3] \vadd64u256 z.[0]);
    h.[1] <- (h.[1] \vadd64u256 z.[1]);
    z.[0] <- (h.[3] \vshr64u256 (W8.of_int 26));
    h.[3] <- (h.[3] `&` mask26);
    h.[4] <- (h.[4] \vadd64u256 z.[0]);
    in_0 <- (in_0 + (W64.of_int 64));
    m.[0] <- (m.[0] `&` mask26);
    m.[3] <- (m.[3] \vshr64u256 (W8.of_int 30));
    m.[3] <- (m.[3] `&` mask26);
    m.[4] <- (m.[4] \vshr64u256 (W8.of_int 40));
    m.[4] <- (m.[4] `|` s_bit25);
    m.[1] <- (m.[1] `&` mask26);
    return (h, m, in_0);
  }
  
  proc final_avx2_v0 (h:W256.t Array5.t, m:W256.t Array5.t,
                      s_r:W256.t Array5.t, s_rx5:W256.t Array4.t,
                      s_mask26:W256.t, s_bit25:W256.t) : W256.t Array5.t = {
    
    var mask26:W256.t;
    
    h <@ add_mulmod_avx2 (h, m, s_r, s_rx5, s_mask26, s_bit25);
    mask26 <- s_mask26;
    h <@ carry_reduce_avx2 (h, mask26);
    return (h);
  }
  
  proc poly1305_avx2_update (in_0:W64.t, len:W64.t, r4444:W256.t Array5.t,
                             r4444x5:W256.t Array4.t, r1234:W256.t Array5.t,
                             r1234x5:W256.t Array4.t) : W64.t * W64.t *
                                                        W64.t Array3.t = {
    var aux: int;
    
    var h64:W64.t Array3.t;
    var i:int;
    var h:W256.t Array5.t;
    var t:W256.t;
    var s_mask26:W256.t;
    var mask26:W256.t;
    var s_bit25:W256.t;
    var m:W256.t Array5.t;
    h <- witness;
    h64 <- witness;
    m <- witness;
    i <- 0;
    while (i < 5) {
      h.[i] <- x86_VPBROADCAST_4u64 zero_u64;
      i <- i + 1;
    }
    t <- x86_VPBROADCAST_4u64 mask26_u64;
    s_mask26 <- t;
    mask26 <- t;
    t <- x86_VPBROADCAST_4u64 bit25_u64;
    s_bit25 <- t;
    (m, in_0) <@ load_avx2 (in_0, mask26, s_bit25);
    
    while (((W64.of_int 128) \ule len)) {
      (h, m, in_0) <@ mainloop_avx2_v1 (h, m, in_0, r4444, r4444x5, s_mask26,
      s_bit25);
      len <- (len - (W64.of_int 64));
    }
    len <- (len - (W64.of_int 64));
    h <@ final_avx2_v0 (h, m, r1234, r1234x5, s_mask26, s_bit25);
    h64 <@ pack_avx2 (h);
    return (in_0, len, h64);
  }
  
  proc poly1305_avx2_wrapper (out:W64.t, in_0:W64.t, inlen:W64.t, k:W64.t) : unit = {
    
    var len:W64.t;
    var h:W64.t Array3.t;
    var r:W64.t Array2.t;
    var r54:W64.t;
    var r4444:W256.t Array5.t;
    var r4444x5:W256.t Array4.t;
    var r1234:W256.t Array5.t;
    var r1234x5:W256.t Array4.t;
    h <- witness;
    r <- witness;
    r1234 <- witness;
    r1234x5 <- witness;
    r4444 <- witness;
    r4444x5 <- witness;
    len <- inlen;
    (h, r, r54, k) <@ poly1305_ref3_setup (k);
    (r4444, r4444x5, r1234, r1234x5) <@ poly1305_avx2_setup (r, r54);
    (in_0, len, h) <@ poly1305_avx2_update (in_0, len, r4444, r4444x5, r1234,
    r1234x5);
    (in_0, len, h) <@ poly1305_ref3_update (in_0, len, h, r, r54);
    poly1305_ref3_last (out, in_0, len, k, h, r, r54);
    return ();
  }
  
  proc poly1305_avx2 (out:W64.t, in_0:W64.t, inlen:W64.t, k:W64.t) : unit = {
    
    
    
    if ((inlen \ult (W64.of_int 257))) {
      poly1305_ref3_local (out, in_0, inlen, k);
    } else {
      poly1305_avx2_wrapper (out, in_0, inlen, k);
    }
    return ();
  }
}.

require import List Int IntExtra IntDiv CoreMap.
from Jasmin require import JModel.

require import Array4 Array8 Array32.
require import WArray32 WArray64.



module M = {
  proc _fe64_add_rrs (f:W64.t Array4.t, g:W64.t Array4.t, z:W64.t) : 
  W64.t Array4.t = {
    var aux: bool;
    var aux_1: int;
    var aux_0: W64.t;
    
    var h:W64.t Array4.t;
    var cf:bool;
    var i:int;
    var  _0:bool;
    var  _1:bool;
    h <- witness;
    h <- f;
    (aux, aux_0) <- addc_64 h.[0] g.[0] false;
    cf <- aux;
    h.[0] <- aux_0;
    i <- 1;
    while (i < 4) {
      (aux, aux_0) <- addc_64 h.[i] g.[i] cf;
      cf <- aux;
      h.[i] <- aux_0;
      i <- i + 1;
    }
    ( _0, z) <- subc_64 z z cf;
    z <- (z `&` (W64.of_int 38));
    (aux, aux_0) <- addc_64 h.[0] z false;
    cf <- aux;
    h.[0] <- aux_0;
    i <- 1;
    while (i < 4) {
      (aux, aux_0) <- addc_64 h.[i] (W64.of_int 0) cf;
      cf <- aux;
      h.[i] <- aux_0;
      i <- i + 1;
    }
    ( _1, z) <- subc_64 z z cf;
    z <- (z `&` (W64.of_int 38));
    h.[0] <- (h.[0] + z);
    return (h);
  }
  
  proc _fe64_add_sss (fs:W64.t Array4.t, gs:W64.t Array4.t) : W64.t Array4.t = {
    
    var hs:W64.t Array4.t;
    var z:W64.t;
    var f:W64.t Array4.t;
    var h:W64.t Array4.t;
    var  _0:bool;
    var  _1:bool;
    var  _2:bool;
    var  _3:bool;
    var  _4:bool;
    f <- witness;
    h <- witness;
    hs <- witness;
    ( _0,  _1,  _2,  _3,  _4, z) <- set0_64 ;
    f <- fs;
    h <@ _fe64_add_rrs (f, gs, z);
    hs <- h;
    return (hs);
  }
  
  proc _fe64_add_ssr (fs:W64.t Array4.t, g:W64.t Array4.t) : W64.t Array4.t = {
    
    var hs:W64.t Array4.t;
    var z:W64.t;
    var h:W64.t Array4.t;
    var  _0:bool;
    var  _1:bool;
    var  _2:bool;
    var  _3:bool;
    var  _4:bool;
    h <- witness;
    hs <- witness;
    ( _0,  _1,  _2,  _3,  _4, z) <- set0_64 ;
    h <@ _fe64_add_rrs (g, fs, z);
    hs <- h;
    return (hs);
  }
  
  proc _fe64_sub_rrs (f:W64.t Array4.t, g:W64.t Array4.t, z:W64.t) : 
  W64.t Array4.t = {
    var aux: bool;
    var aux_1: int;
    var aux_0: W64.t;
    
    var h:W64.t Array4.t;
    var cf:bool;
    var i:int;
    var  _0:bool;
    var  _1:bool;
    h <- witness;
    h <- f;
    (aux, aux_0) <- subc_64 h.[0] g.[0] false;
    cf <- aux;
    h.[0] <- aux_0;
    i <- 1;
    while (i < 4) {
      (aux, aux_0) <- subc_64 h.[i] g.[i] cf;
      cf <- aux;
      h.[i] <- aux_0;
      i <- i + 1;
    }
    ( _0, z) <- subc_64 z z cf;
    z <- (z `&` (W64.of_int 38));
    (aux, aux_0) <- subc_64 h.[0] z false;
    cf <- aux;
    h.[0] <- aux_0;
    i <- 1;
    while (i < 4) {
      (aux, aux_0) <- subc_64 h.[i] (W64.of_int 0) cf;
      cf <- aux;
      h.[i] <- aux_0;
      i <- i + 1;
    }
    ( _1, z) <- subc_64 z z cf;
    z <- (z `&` (W64.of_int 38));
    h.[0] <- (h.[0] - z);
    return (h);
  }
  
  proc _fe64_sub_sss (fs:W64.t Array4.t, gs:W64.t Array4.t) : W64.t Array4.t = {
    
    var hs:W64.t Array4.t;
    var z:W64.t;
    var f:W64.t Array4.t;
    var h:W64.t Array4.t;
    var  _0:bool;
    var  _1:bool;
    var  _2:bool;
    var  _3:bool;
    var  _4:bool;
    f <- witness;
    h <- witness;
    hs <- witness;
    ( _0,  _1,  _2,  _3,  _4, z) <- set0_64 ;
    f <- fs;
    h <@ _fe64_sub_rrs (f, gs, z);
    hs <- h;
    return (hs);
  }
  
  proc _fe64_sub_rsr (fs:W64.t Array4.t, g:W64.t Array4.t) : W64.t Array4.t = {
    var aux: bool;
    var aux_1: int;
    var aux_0: W64.t;
    
    var h:W64.t Array4.t;
    var z:W64.t;
    var cf:bool;
    var i:int;
    var  _0:bool;
    var  _1:bool;
    var  _2:bool;
    var  _3:bool;
    var  _4:bool;
    var  _5:bool;
    var  _6:bool;
    h <- witness;
    ( _0,  _1,  _2,  _3,  _4, z) <- set0_64 ;
    h <- fs;
    (aux, aux_0) <- subc_64 h.[0] g.[0] false;
    cf <- aux;
    h.[0] <- aux_0;
    i <- 1;
    while (i < 4) {
      (aux, aux_0) <- subc_64 h.[i] g.[i] cf;
      cf <- aux;
      h.[i] <- aux_0;
      i <- i + 1;
    }
    ( _5, z) <- subc_64 z z cf;
    z <- (z `&` (W64.of_int 38));
    (aux, aux_0) <- subc_64 h.[0] z false;
    cf <- aux;
    h.[0] <- aux_0;
    i <- 1;
    while (i < 4) {
      (aux, aux_0) <- subc_64 h.[i] (W64.of_int 0) cf;
      cf <- aux;
      h.[i] <- aux_0;
      i <- i + 1;
    }
    ( _6, z) <- subc_64 z z cf;
    z <- (z `&` (W64.of_int 38));
    h.[0] <- (h.[0] - z);
    return (h);
  }
  
  proc _fe64_sub_ssr (fs:W64.t Array4.t, g:W64.t Array4.t) : W64.t Array4.t = {
    
    var hs:W64.t Array4.t;
    var h:W64.t Array4.t;
    h <- witness;
    hs <- witness;
    h <@ _fe64_sub_rsr (fs, g);
    hs <- h;
    return (hs);
  }
  
  proc _fe64_mul_a24 (f:W64.t Array4.t, a24:W64.t) : W64.t Array4.t = {
    var aux_1: bool;
    var aux_0: W64.t;
    var aux: W64.t;
    
    var h:W64.t Array4.t;
    var c:W64.t;
    var lo:W64.t;
    var cf:bool;
    var r0:W64.t;
    var  _0:bool;
    var  _1:bool;
    var  _2:bool;
    var  _3:bool;
    var  _4:bool;
    var  _5:bool;
    var  _6:bool;
    h <- witness;
    c <- a24;
    (aux_0, aux) <- x86_MULX_64 c f.[0];
    h.[1] <- aux_0;
    h.[0] <- aux;
    (aux_0, aux) <- x86_MULX_64 c f.[1];
    h.[2] <- aux_0;
    lo <- aux;
    (aux_1, aux_0) <- addc_64 h.[1] lo false;
    cf <- aux_1;
    h.[1] <- aux_0;
    (aux_0, aux) <- x86_MULX_64 c f.[2];
    h.[3] <- aux_0;
    lo <- aux;
    (aux_1, aux_0) <- addc_64 h.[2] lo cf;
    cf <- aux_1;
    h.[2] <- aux_0;
    (r0, lo) <- x86_MULX_64 c f.[3];
    (aux_1, aux_0) <- addc_64 h.[3] lo cf;
    cf <- aux_1;
    h.[3] <- aux_0;
    ( _0, r0) <- addc_64 r0 (W64.of_int 0) cf;
    ( _1,  _2,  _3,  _4,  _5, r0) <- x86_IMULtimm_64 r0 (W64.of_int 38);
    (aux_1, aux_0) <- addc_64 h.[0] r0 false;
    cf <- aux_1;
    h.[0] <- aux_0;
    (aux_1, aux_0) <- addc_64 h.[1] (W64.of_int 0) cf;
    cf <- aux_1;
    h.[1] <- aux_0;
    (aux_1, aux_0) <- addc_64 h.[2] (W64.of_int 0) cf;
    cf <- aux_1;
    h.[2] <- aux_0;
    (aux_1, aux_0) <- addc_64 h.[3] (W64.of_int 0) cf;
    cf <- aux_1;
    h.[3] <- aux_0;
    ( _6, c) <- subc_64 c c cf;
    c <- (c `&` (W64.of_int 38));
    h.[0] <- (h.[0] + c);
    return (h);
  }
  
  proc _fe64_mul_a24_ss (f:W64.t Array4.t, a24:W64.t) : W64.t Array4.t = {
    
    var hs:W64.t Array4.t;
    var h:W64.t Array4.t;
    h <- witness;
    hs <- witness;
    h <@ _fe64_mul_a24 (f, a24);
    hs <- h;
    return (hs);
  }
  
  proc _fe64_reduce (h:W64.t Array4.t, r:W64.t Array4.t, _38:W64.t, z:W64.t,
                     cf:bool, of_0:bool) : W64.t Array4.t = {
    var aux: bool;
    var aux_1: W64.t;
    var aux_0: W64.t;
    
    var hi:W64.t;
    var lo:W64.t;
    var  _0:bool;
    var  _1:bool;
    var  _2:bool;
    var  _3:bool;
    var  _4:bool;
    var  _5:bool;
    
    (hi, lo) <- x86_MULX_64 _38 r.[0];
    (aux, aux_1) <- x86_ADOX_64 h.[0] lo of_0;
    of_0 <- aux;
    h.[0] <- aux_1;
    (aux, aux_1) <- x86_ADCX_64 h.[1] hi cf;
    cf <- aux;
    h.[1] <- aux_1;
    (hi, lo) <- x86_MULX_64 _38 r.[1];
    (aux, aux_1) <- x86_ADOX_64 h.[1] lo of_0;
    of_0 <- aux;
    h.[1] <- aux_1;
    (aux, aux_1) <- x86_ADCX_64 h.[2] hi cf;
    cf <- aux;
    h.[2] <- aux_1;
    (hi, lo) <- x86_MULX_64 _38 r.[2];
    (aux, aux_1) <- x86_ADOX_64 h.[2] lo of_0;
    of_0 <- aux;
    h.[2] <- aux_1;
    (aux, aux_1) <- x86_ADCX_64 h.[3] hi cf;
    cf <- aux;
    h.[3] <- aux_1;
    (aux_1, aux_0) <- x86_MULX_64 _38 r.[3];
    r.[0] <- aux_1;
    lo <- aux_0;
    (aux, aux_1) <- x86_ADOX_64 h.[3] lo of_0;
    of_0 <- aux;
    h.[3] <- aux_1;
    (aux, aux_1) <- x86_ADCX_64 r.[0] z cf;
    cf <- aux;
    r.[0] <- aux_1;
    (aux, aux_1) <- x86_ADOX_64 r.[0] z of_0;
    of_0 <- aux;
    r.[0] <- aux_1;
    ( _0,  _1,  _2,  _3,  _4, lo) <- x86_IMULtimm_64 r.[0] (W64.of_int 38);
    (aux, aux_1) <- addc_64 h.[0] lo false;
    cf <- aux;
    h.[0] <- aux_1;
    (aux, aux_1) <- addc_64 h.[1] z cf;
    cf <- aux;
    h.[1] <- aux_1;
    (aux, aux_1) <- addc_64 h.[2] z cf;
    cf <- aux;
    h.[2] <- aux_1;
    (aux, aux_1) <- addc_64 h.[3] z cf;
    cf <- aux;
    h.[3] <- aux_1;
    ( _5, z) <- subc_64 z z cf;
    z <- (z `&` (W64.of_int 38));
    h.[0] <- (h.[0] + z);
    return (h);
  }
  
  proc fe64_mul_c0 (f0:W64.t, g:W64.t Array4.t, z:W64.t, cf:bool, of_0:bool) : 
  W64.t Array4.t * W64.t Array4.t * bool * bool = {
    var aux_1: bool;
    var aux_0: W64.t;
    var aux: W64.t;
    
    var h:W64.t Array4.t;
    var r:W64.t Array4.t;
    var lo:W64.t;
    h <- witness;
    r <- witness;
    (aux_0, aux) <- x86_MULX_64 f0 g.[0];
    h.[1] <- aux_0;
    h.[0] <- aux;
    (aux_0, aux) <- x86_MULX_64 f0 g.[1];
    h.[2] <- aux_0;
    lo <- aux;
    (aux_1, aux_0) <- x86_ADCX_64 h.[1] lo cf;
    cf <- aux_1;
    h.[1] <- aux_0;
    (aux_0, aux) <- x86_MULX_64 f0 g.[2];
    h.[3] <- aux_0;
    lo <- aux;
    (aux_1, aux_0) <- x86_ADCX_64 h.[2] lo cf;
    cf <- aux_1;
    h.[2] <- aux_0;
    (aux_0, aux) <- x86_MULX_64 f0 g.[3];
    r.[0] <- aux_0;
    lo <- aux;
    (aux_1, aux_0) <- x86_ADCX_64 h.[3] lo cf;
    cf <- aux_1;
    h.[3] <- aux_0;
    (aux_1, aux_0) <- x86_ADCX_64 r.[0] z cf;
    cf <- aux_1;
    r.[0] <- aux_0;
    return (h, r, cf, of_0);
  }
  
  proc fe64_mul_c1 (h:W64.t Array4.t, r:W64.t Array4.t, f:W64.t,
                    g:W64.t Array4.t, z:W64.t, cf:bool, of_0:bool) : 
  W64.t Array4.t * W64.t Array4.t * bool * bool = {
    var aux: bool;
    var aux_1: W64.t;
    var aux_0: W64.t;
    
    var hi:W64.t;
    var lo:W64.t;
    
    (hi, lo) <- x86_MULX_64 f g.[0];
    (aux, aux_1) <- x86_ADOX_64 h.[1] lo of_0;
    of_0 <- aux;
    h.[1] <- aux_1;
    (aux, aux_1) <- x86_ADCX_64 h.[2] hi cf;
    cf <- aux;
    h.[2] <- aux_1;
    (hi, lo) <- x86_MULX_64 f g.[1];
    (aux, aux_1) <- x86_ADOX_64 h.[2] lo of_0;
    of_0 <- aux;
    h.[2] <- aux_1;
    (aux, aux_1) <- x86_ADCX_64 h.[3] hi cf;
    cf <- aux;
    h.[3] <- aux_1;
    (hi, lo) <- x86_MULX_64 f g.[2];
    (aux, aux_1) <- x86_ADOX_64 h.[3] lo of_0;
    of_0 <- aux;
    h.[3] <- aux_1;
    (aux, aux_1) <- x86_ADCX_64 r.[0] hi cf;
    cf <- aux;
    r.[0] <- aux_1;
    (aux_1, aux_0) <- x86_MULX_64 f g.[3];
    r.[1] <- aux_1;
    lo <- aux_0;
    (aux, aux_1) <- x86_ADOX_64 r.[0] lo of_0;
    of_0 <- aux;
    r.[0] <- aux_1;
    (aux, aux_1) <- x86_ADCX_64 r.[1] z cf;
    cf <- aux;
    r.[1] <- aux_1;
    (aux, aux_1) <- x86_ADOX_64 r.[1] z of_0;
    of_0 <- aux;
    r.[1] <- aux_1;
    return (h, r, cf, of_0);
  }
  
  proc fe64_mul_c2 (h:W64.t Array4.t, r:W64.t Array4.t, f:W64.t,
                    g:W64.t Array4.t, z:W64.t, cf:bool, of_0:bool) : 
  W64.t Array4.t * W64.t Array4.t * bool * bool = {
    var aux: bool;
    var aux_1: W64.t;
    var aux_0: W64.t;
    
    var hi:W64.t;
    var lo:W64.t;
    
    (hi, lo) <- x86_MULX_64 f g.[0];
    (aux, aux_1) <- x86_ADOX_64 h.[2] lo of_0;
    of_0 <- aux;
    h.[2] <- aux_1;
    (aux, aux_1) <- x86_ADCX_64 h.[3] hi cf;
    cf <- aux;
    h.[3] <- aux_1;
    (hi, lo) <- x86_MULX_64 f g.[1];
    (aux, aux_1) <- x86_ADOX_64 h.[3] lo of_0;
    of_0 <- aux;
    h.[3] <- aux_1;
    (aux, aux_1) <- x86_ADCX_64 r.[0] hi cf;
    cf <- aux;
    r.[0] <- aux_1;
    (hi, lo) <- x86_MULX_64 f g.[2];
    (aux, aux_1) <- x86_ADOX_64 r.[0] lo of_0;
    of_0 <- aux;
    r.[0] <- aux_1;
    (aux, aux_1) <- x86_ADCX_64 r.[1] hi cf;
    cf <- aux;
    r.[1] <- aux_1;
    (aux_1, aux_0) <- x86_MULX_64 f g.[3];
    r.[2] <- aux_1;
    lo <- aux_0;
    (aux, aux_1) <- x86_ADOX_64 r.[1] lo of_0;
    of_0 <- aux;
    r.[1] <- aux_1;
    (aux, aux_1) <- x86_ADCX_64 r.[2] z cf;
    cf <- aux;
    r.[2] <- aux_1;
    (aux, aux_1) <- x86_ADOX_64 r.[2] z of_0;
    of_0 <- aux;
    r.[2] <- aux_1;
    return (h, r, cf, of_0);
  }
  
  proc fe64_mul_c3 (h:W64.t Array4.t, r:W64.t Array4.t, f:W64.t,
                    g:W64.t Array4.t, z:W64.t, cf:bool, of_0:bool) : 
  W64.t Array4.t * W64.t Array4.t * bool * bool = {
    var aux: bool;
    var aux_1: W64.t;
    var aux_0: W64.t;
    
    var hi:W64.t;
    var lo:W64.t;
    
    (hi, lo) <- x86_MULX_64 f g.[0];
    (aux, aux_1) <- x86_ADOX_64 h.[3] lo of_0;
    of_0 <- aux;
    h.[3] <- aux_1;
    (aux, aux_1) <- x86_ADCX_64 r.[0] hi cf;
    cf <- aux;
    r.[0] <- aux_1;
    (hi, lo) <- x86_MULX_64 f g.[1];
    (aux, aux_1) <- x86_ADOX_64 r.[0] lo of_0;
    of_0 <- aux;
    r.[0] <- aux_1;
    (aux, aux_1) <- x86_ADCX_64 r.[1] hi cf;
    cf <- aux;
    r.[1] <- aux_1;
    (hi, lo) <- x86_MULX_64 f g.[2];
    (aux, aux_1) <- x86_ADOX_64 r.[1] lo of_0;
    of_0 <- aux;
    r.[1] <- aux_1;
    (aux, aux_1) <- x86_ADCX_64 r.[2] hi cf;
    cf <- aux;
    r.[2] <- aux_1;
    (aux_1, aux_0) <- x86_MULX_64 f g.[3];
    r.[3] <- aux_1;
    lo <- aux_0;
    (aux, aux_1) <- x86_ADOX_64 r.[2] lo of_0;
    of_0 <- aux;
    r.[2] <- aux_1;
    (aux, aux_1) <- x86_ADCX_64 r.[3] z cf;
    cf <- aux;
    r.[3] <- aux_1;
    (aux, aux_1) <- x86_ADOX_64 r.[3] z of_0;
    of_0 <- aux;
    r.[3] <- aux_1;
    return (h, r, cf, of_0);
  }
  
  proc _fe64_mul_rsr (fs:W64.t Array4.t, g:W64.t Array4.t) : W64.t Array4.t = {
    
    var h:W64.t Array4.t;
    var of_0:bool;
    var cf:bool;
    var z:W64.t;
    var f:W64.t;
    var r:W64.t Array4.t;
    var _38:W64.t;
    var  _0:bool;
    var  _1:bool;
    var  _2:bool;
    h <- witness;
    r <- witness;
    (of_0, cf,  _0,  _1,  _2, z) <- set0_64 ;
    f <- fs.[0];
    (h, r, cf, of_0) <@ fe64_mul_c0 (f, g, z, cf, of_0);
    f <- fs.[1];
    (h, r, cf, of_0) <@ fe64_mul_c1 (h, r, f, g, z, cf, of_0);
    f <- fs.[2];
    (h, r, cf, of_0) <@ fe64_mul_c2 (h, r, f, g, z, cf, of_0);
    f <- fs.[3];
    (h, r, cf, of_0) <@ fe64_mul_c3 (h, r, f, g, z, cf, of_0);
    _38 <- (W64.of_int 38);
    h <@ _fe64_reduce (h, r, _38, z, cf, of_0);
    return (h);
  }
  
  proc _fe64_mul_ssr (fs:W64.t Array4.t, g:W64.t Array4.t) : W64.t Array4.t = {
    
    var hs:W64.t Array4.t;
    var h:W64.t Array4.t;
    h <- witness;
    hs <- witness;
    h <@ _fe64_mul_rsr (fs, g);
    hs <- h;
    return (hs);
  }
  
  proc _fe64_mul_sss (fs:W64.t Array4.t, gs:W64.t Array4.t) : W64.t Array4.t = {
    
    var hs:W64.t Array4.t;
    var g:W64.t Array4.t;
    var h:W64.t Array4.t;
    g <- witness;
    h <- witness;
    hs <- witness;
    g <- gs;
    h <@ _fe64_mul_rsr (fs, g);
    hs <- h;
    return (hs);
  }
  
  proc _fe64_mul_rss (fs:W64.t Array4.t, gs:W64.t Array4.t) : W64.t Array4.t = {
    
    var h:W64.t Array4.t;
    var g:W64.t Array4.t;
    g <- witness;
    h <- witness;
    g <- gs;
    h <@ _fe64_mul_rsr (fs, g);
    return (h);
  }
  
  proc _fe64_sqr_rr (f:W64.t Array4.t) : W64.t Array4.t = {
    var aux_1: bool;
    var aux_0: W64.t;
    var aux: W64.t;
    
    var h:W64.t Array4.t;
    var of_0:bool;
    var cf:bool;
    var z:W64.t;
    var fx:W64.t;
    var t:W64.t Array8.t;
    var r:W64.t Array4.t;
    var _38:W64.t;
    var  _0:bool;
    var  _1:bool;
    var  _2:bool;
    h <- witness;
    r <- witness;
    t <- witness;
    (of_0, cf,  _0,  _1,  _2, z) <- set0_64 ;
    fx <- f.[0];
    (aux_0, aux) <- x86_MULX_64 fx fx;
    t.[1] <- aux_0;
    h.[0] <- aux;
    (aux_0, aux) <- x86_MULX_64 fx f.[1];
    h.[2] <- aux_0;
    h.[1] <- aux;
    (aux_0, aux) <- x86_MULX_64 fx f.[2];
    h.[3] <- aux_0;
    t.[2] <- aux;
    (aux_1, aux_0) <- x86_ADCX_64 h.[2] t.[2] cf;
    cf <- aux_1;
    h.[2] <- aux_0;
    (aux_0, aux) <- x86_MULX_64 fx f.[3];
    r.[0] <- aux_0;
    t.[3] <- aux;
    (aux_1, aux_0) <- x86_ADCX_64 h.[3] t.[3] cf;
    cf <- aux_1;
    h.[3] <- aux_0;
    fx <- f.[1];
    (aux_0, aux) <- x86_MULX_64 fx f.[2];
    t.[4] <- aux_0;
    t.[3] <- aux;
    (aux_1, aux_0) <- x86_ADOX_64 h.[3] t.[3] of_0;
    of_0 <- aux_1;
    h.[3] <- aux_0;
    (aux_1, aux_0) <- x86_ADCX_64 r.[0] t.[4] cf;
    cf <- aux_1;
    r.[0] <- aux_0;
    (aux_0, aux) <- x86_MULX_64 fx f.[3];
    r.[1] <- aux_0;
    t.[4] <- aux;
    (aux_1, aux_0) <- x86_ADOX_64 r.[0] t.[4] of_0;
    of_0 <- aux_1;
    r.[0] <- aux_0;
    (aux_0, aux) <- x86_MULX_64 fx fx;
    t.[3] <- aux_0;
    t.[2] <- aux;
    fx <- f.[2];
    (aux_0, aux) <- x86_MULX_64 fx f.[3];
    r.[2] <- aux_0;
    t.[5] <- aux;
    (aux_1, aux_0) <- x86_ADCX_64 r.[1] t.[5] cf;
    cf <- aux_1;
    r.[1] <- aux_0;
    (aux_1, aux_0) <- x86_ADOX_64 r.[1] z of_0;
    of_0 <- aux_1;
    r.[1] <- aux_0;
    (aux_1, aux_0) <- x86_ADCX_64 r.[2] z cf;
    cf <- aux_1;
    r.[2] <- aux_0;
    (aux_1, aux_0) <- x86_ADOX_64 r.[2] z of_0;
    of_0 <- aux_1;
    r.[2] <- aux_0;
    (aux_0, aux) <- x86_MULX_64 fx fx;
    t.[5] <- aux_0;
    t.[4] <- aux;
    fx <- f.[3];
    (aux_0, aux) <- x86_MULX_64 fx fx;
    r.[3] <- aux_0;
    t.[6] <- aux;
    (aux_1, aux_0) <- x86_ADCX_64 h.[1] h.[1] cf;
    cf <- aux_1;
    h.[1] <- aux_0;
    (aux_1, aux_0) <- x86_ADOX_64 h.[1] t.[1] of_0;
    of_0 <- aux_1;
    h.[1] <- aux_0;
    (aux_1, aux_0) <- x86_ADCX_64 h.[2] h.[2] cf;
    cf <- aux_1;
    h.[2] <- aux_0;
    (aux_1, aux_0) <- x86_ADOX_64 h.[2] t.[2] of_0;
    of_0 <- aux_1;
    h.[2] <- aux_0;
    (aux_1, aux_0) <- x86_ADCX_64 h.[3] h.[3] cf;
    cf <- aux_1;
    h.[3] <- aux_0;
    (aux_1, aux_0) <- x86_ADOX_64 h.[3] t.[3] of_0;
    of_0 <- aux_1;
    h.[3] <- aux_0;
    (aux_1, aux_0) <- x86_ADCX_64 r.[0] r.[0] cf;
    cf <- aux_1;
    r.[0] <- aux_0;
    (aux_1, aux_0) <- x86_ADOX_64 r.[0] t.[4] of_0;
    of_0 <- aux_1;
    r.[0] <- aux_0;
    (aux_1, aux_0) <- x86_ADCX_64 r.[1] r.[1] cf;
    cf <- aux_1;
    r.[1] <- aux_0;
    (aux_1, aux_0) <- x86_ADOX_64 r.[1] t.[5] of_0;
    of_0 <- aux_1;
    r.[1] <- aux_0;
    (aux_1, aux_0) <- x86_ADCX_64 r.[2] r.[2] cf;
    cf <- aux_1;
    r.[2] <- aux_0;
    (aux_1, aux_0) <- x86_ADOX_64 r.[2] t.[6] of_0;
    of_0 <- aux_1;
    r.[2] <- aux_0;
    (aux_1, aux_0) <- x86_ADCX_64 r.[3] z cf;
    cf <- aux_1;
    r.[3] <- aux_0;
    (aux_1, aux_0) <- x86_ADOX_64 r.[3] z of_0;
    of_0 <- aux_1;
    r.[3] <- aux_0;
    _38 <- (W64.of_int 38);
    h <@ _fe64_reduce (h, r, _38, z, cf, of_0);
    return (h);
  }
  
  proc _fe64_it_sqr (i:W64.t, f:W64.t Array4.t) : W64.t * W64.t Array4.t = {
    
    var zf:bool;
    var h:W64.t Array4.t;
    var  _0:bool;
    var  _1:bool;
    var  _2:bool;
    var  _3:bool;
    var  _4:bool;
    var  _5:bool;
    var  _6:bool;
    h <- witness;
    h <@ _fe64_sqr_rr (f);
    ( _0,  _1,  _2,  _3, i) <- x86_DEC_64 i;
    f <@ _fe64_sqr_rr (h);
    ( _4,  _5,  _6, zf, i) <- x86_DEC_64 i;
    while ((! zf)) {
      h <@ _fe64_sqr_rr (f);
      ( _0,  _1,  _2,  _3, i) <- x86_DEC_64 i;
      f <@ _fe64_sqr_rr (h);
      ( _4,  _5,  _6, zf, i) <- x86_DEC_64 i;
    }
    return (i, f);
  }
  
  proc _fe64_sqr_ss (fs:W64.t Array4.t) : W64.t Array4.t = {
    
    var hs:W64.t Array4.t;
    var f:W64.t Array4.t;
    var h:W64.t Array4.t;
    f <- witness;
    h <- witness;
    hs <- witness;
    f <- fs;
    h <@ _fe64_sqr_rr (f);
    hs <- h;
    return (hs);
  }
  
  proc _fe64_invert (f:W64.t Array4.t) : W64.t Array4.t = {
    
    var t1:W64.t Array4.t;
    var fs:W64.t Array4.t;
    var t0:W64.t Array4.t;
    var t0s:W64.t Array4.t;
    var t1s:W64.t Array4.t;
    var t2:W64.t Array4.t;
    var i:W64.t;
    var t2s:W64.t Array4.t;
    var t3:W64.t Array4.t;
    fs <- witness;
    t0 <- witness;
    t0s <- witness;
    t1 <- witness;
    t1s <- witness;
    t2 <- witness;
    t2s <- witness;
    t3 <- witness;
    fs <- f;
    t0 <@ _fe64_sqr_rr (f);
    t0s <- t0;
    t1 <@ _fe64_sqr_rr (t0);
    t1 <@ _fe64_sqr_rr (t1);
    t1 <@ _fe64_mul_rsr (fs, t1);
    t1s <- t1;
    t0 <@ _fe64_mul_rsr (t0s, t1);
    t0s <- t0;
    t2 <@ _fe64_sqr_rr (t0);
    t1 <@ _fe64_mul_rsr (t1s, t2);
    t1s <- t1;
    t2 <@ _fe64_sqr_rr (t1);
    i <- (W64.of_int 4);
    (i, t2) <@ _fe64_it_sqr (i, t2);
    t2s <- t2;
    t1 <@ _fe64_mul_rsr (t1s, t2);
    t1s <- t1;
    i <- (W64.of_int 10);
    (i, t2) <@ _fe64_it_sqr (i, t1);
    t2 <@ _fe64_mul_rsr (t1s, t2);
    t2s <- t2;
    i <- (W64.of_int 20);
    (i, t3) <@ _fe64_it_sqr (i, t2);
    t2 <@ _fe64_mul_rsr (t2s, t3);
    i <- (W64.of_int 10);
    (i, t2) <@ _fe64_it_sqr (i, t2);
    t1 <@ _fe64_mul_rsr (t1s, t2);
    t1s <- t1;
    i <- (W64.of_int 50);
    (i, t2) <@ _fe64_it_sqr (i, t1);
    t2 <@ _fe64_mul_rsr (t1s, t2);
    t2s <- t2;
    i <- (W64.of_int 100);
    (i, t3) <@ _fe64_it_sqr (i, t2);
    t2 <@ _fe64_mul_rsr (t2s, t3);
    i <- (W64.of_int 50);
    (i, t2) <@ _fe64_it_sqr (i, t2);
    t1 <@ _fe64_mul_rsr (t1s, t2);
    i <- (W64.of_int 4);
    (i, t1) <@ _fe64_it_sqr (i, t1);
    t1 <@ _fe64_sqr_rr (t1);
    t1 <@ _fe64_mul_rsr (t0s, t1);
    return (t1);
  }
  
  proc _fe64_tobytes (f:W64.t Array4.t) : W64.t Array4.t = {
    var aux_3: bool;
    var aux_2: bool;
    var aux_1: bool;
    var aux_0: bool;
    var aux: bool;
    var aux_4: W64.t;
    
    var t:W64.t;
    var cf:bool;
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
    
    t <- (f.[3] + f.[3]);
    (aux_3, aux_2, aux_1, aux_0, aux, aux_4) <- x86_SAR_64 f.[3]
    (W8.of_int 63);
     _0 <- aux_3;
     _1 <- aux_2;
     _2 <- aux_1;
     _3 <- aux_0;
     _4 <- aux;
    f.[3] <- aux_4;
    t <- (t `>>` (W8.of_int 1));
    f.[3] <- (f.[3] `&` (W64.of_int 19));
    f.[3] <- (f.[3] + (W64.of_int 19));
    (aux_3, aux_4) <- addc_64 f.[0] f.[3] false;
    cf <- aux_3;
    f.[0] <- aux_4;
    (aux_3, aux_4) <- addc_64 f.[1] (W64.of_int 0) cf;
    cf <- aux_3;
    f.[1] <- aux_4;
    (aux_3, aux_4) <- addc_64 f.[2] (W64.of_int 0) cf;
    cf <- aux_3;
    f.[2] <- aux_4;
    (cf, t) <- addc_64 t (W64.of_int 0) cf;
    f.[3] <- (t + t);
    ( _5,  _6,  _7,  _8,  _9, t) <- x86_SAR_64 t (W8.of_int 63);
    f.[3] <- (f.[3] `>>` (W8.of_int 1));
    t <- (invw t);
    t <- (t `&` (W64.of_int 19));
    (aux_3, aux_4) <- subc_64 f.[0] t false;
    cf <- aux_3;
    f.[0] <- aux_4;
    (aux_3, aux_4) <- subc_64 f.[1] (W64.of_int 0) cf;
    cf <- aux_3;
    f.[1] <- aux_4;
    (aux_3, aux_4) <- subc_64 f.[2] (W64.of_int 0) cf;
    cf <- aux_3;
    f.[2] <- aux_4;
    (aux_3, aux_4) <- subc_64 f.[3] (W64.of_int 0) cf;
    cf <- aux_3;
    f.[3] <- aux_4;
    return (f);
  }
  
  proc _fe64_frombytes (_f:W64.t) : W64.t Array4.t * W64.t Array4.t = {
    var aux: int;
    
    var f1s:W64.t Array4.t;
    var f2s:W64.t Array4.t;
    var i:int;
    var f:W64.t Array4.t;
    f <- witness;
    f1s <- witness;
    f2s <- witness;
    i <- 0;
    while (i < 3) {
      f.[i] <- (loadW64 Glob.mem (W64.to_uint (_f + (W64.of_int (8 * i)))));
      f1s.[i] <- f.[i];
      f2s.[i] <- f.[i];
      i <- i + 1;
    }
    f.[3] <- (loadW64 Glob.mem (W64.to_uint (_f + (W64.of_int (8 * 3)))));
    f.[3] <- (f.[3] `&` (W64.of_int 9223372036854775807));
    f1s.[3] <- f.[3];
    f2s.[3] <- f.[3];
    return (f1s, f2s);
  }
  
  proc _fe64_cswap_ssss (xs:W64.t Array4.t, ys:W64.t Array4.t, swap_0:W64.t) : 
  W64.t Array4.t * W64.t Array4.t = {
    var aux: int;
    
    var x:W64.t Array4.t;
    var mask:W64.t;
    var i:int;
    var y:W64.t Array4.t;
    var t:W64.t;
    x <- witness;
    y <- witness;
    x <- xs;
    mask <- (W64.of_int 0);
    mask <- (mask - swap_0);
    i <- 0;
    while (i < 4) {
      y.[i] <- ys.[i];
      t <- x.[i];
      t <- (t `^` y.[i]);
      t <- (t `&` mask);
      x.[i] <- (x.[i] `^` t);
      y.[i] <- (y.[i] `^` t);
      ys.[i] <- y.[i];
      i <- i + 1;
    }
    xs <- x;
    return (xs, ys);
  }
  
  proc _fe64_cswap_rsrs (x:W64.t Array4.t, ys:W64.t Array4.t, swap_0:W64.t) : 
  W64.t Array4.t * W64.t Array4.t = {
    var aux: int;
    
    var mask:W64.t;
    var i:int;
    var y:W64.t Array4.t;
    var t:W64.t;
    y <- witness;
    mask <- (W64.of_int 0);
    mask <- (mask - swap_0);
    i <- 0;
    while (i < 4) {
      y.[i] <- ys.[i];
      t <- x.[i];
      t <- (t `^` y.[i]);
      t <- (t `&` mask);
      x.[i] <- (x.[i] `^` t);
      y.[i] <- (y.[i] `^` t);
      ys.[i] <- y.[i];
      i <- i + 1;
    }
    return (x, ys);
  }
  
  proc _fe64_0_1_x2 () : W64.t Array4.t * W64.t Array4.t * W64.t Array4.t = {
    var aux: int;
    
    var f1s:W64.t Array4.t;
    var f2s:W64.t Array4.t;
    var f3s:W64.t Array4.t;
    var z:W64.t;
    var i:int;
    var  _0:bool;
    var  _1:bool;
    var  _2:bool;
    var  _3:bool;
    var  _4:bool;
    f1s <- witness;
    f2s <- witness;
    f3s <- witness;
    ( _0,  _1,  _2,  _3,  _4, z) <- set0_64 ;
    f1s.[0] <- z;
    f2s.[0] <- (W64.of_int 1);
    f3s.[0] <- (W64.of_int 1);
    i <- 1;
    while (i < 4) {
      f1s.[i] <- z;
      f2s.[i] <- z;
      f3s.[i] <- z;
      i <- i + 1;
    }
    return (f1s, f2s, f3s);
  }
  
  proc _bit_select (e:W8.t Array32.t, pos:W64.t) : W64.t = {
    
    var b:W64.t;
    var p:W64.t;
    
    p <- pos;
    p <- (p `>>` (W8.of_int 3));
    b <- (zeroextu64 e.[(W64.to_uint p)]);
    p <- pos;
    p <- (p `&` (W64.of_int 7));
    b <- (b `>>` (truncateu8 p));
    b <- (b `&` (W64.of_int 1));
    return (b);
  }
  
  proc _x25519_scalarmult (out:W64.t, scalar:W64.t, point:W64.t) : unit = {
    var aux: int;
    
    var outs:W64.t;
    var i:int;
    var t:W64.t;
    var e:W8.t Array32.t;
    var x3:W64.t Array4.t;
    var x1:W64.t Array4.t;
    var z2r:W64.t Array4.t;
    var z3:W64.t Array4.t;
    var x2:W64.t Array4.t;
    var pos:W64.t;
    var swaps:W64.t;
    var poss:W64.t;
    var swap_0:W64.t;
    var b:W64.t;
    var z2:W64.t Array4.t;
    var t0:W64.t Array4.t;
    var t1:W64.t Array4.t;
    var t2:W64.t Array4.t;
    var t1r:W64.t Array4.t;
    var x2r:W64.t Array4.t;
    e <- witness;
    t0 <- witness;
    t1 <- witness;
    t1r <- witness;
    t2 <- witness;
    x1 <- witness;
    x2 <- witness;
    x2r <- witness;
    x3 <- witness;
    z2 <- witness;
    z2r <- witness;
    z3 <- witness;
    outs <- out;
    i <- 0;
    while (i < 4) {
      t <- (loadW64 Glob.mem (W64.to_uint (scalar + (W64.of_int (8 * i)))));
      e =
      Array32.init
      (WArray32.get8 (WArray32.set64 (WArray32.init8 (fun i => e.[i])) i t));
      i <- i + 1;
    }
    e.[0] <- (e.[0] `&` (W8.of_int 248));
    e.[31] <- (e.[31] `&` (W8.of_int 127));
    e.[31] <- (e.[31] `|` (W8.of_int 64));
    (x3, x1) <@ _fe64_frombytes (point);
    (z2r, z3, x2) <@ _fe64_0_1_x2 ();
    pos <- (W64.of_int 254);
    swaps <- (W64.of_int 0);
    poss <- pos;
    swap_0 <- swaps;
    b <@ _bit_select (e, pos);
    swap_0 <- (swap_0 `^` b);
    (x2, x3) <@ _fe64_cswap_ssss (x2, x3, swap_0);
    (z2r, z3) <@ _fe64_cswap_rsrs (z2r, z3, swap_0);
    swaps <- b;
    z2 <- z2r;
    t0 <@ _fe64_sub_ssr (x2, z2r);
    x2 <@ _fe64_add_ssr (x2, z2r);
    t1 <@ _fe64_sub_sss (x3, z3);
    z2 <@ _fe64_add_sss (x3, z3);
    z3 <@ _fe64_mul_sss (x2, t1);
    z2 <@ _fe64_mul_sss (z2, t0);
    t2 <@ _fe64_sqr_ss (x2);
    t1r <@ _fe64_sqr_ss (t0);
    t1 <- t1r;
    x3 <@ _fe64_add_sss (z3, z2);
    z2 <@ _fe64_sub_sss (z3, z2);
    x2 <@ _fe64_mul_ssr (t2, t1r);
    t0 <@ _fe64_sub_ssr (t2, t1r);
    z2 <@ _fe64_sqr_ss (z2);
    z3 <@ _fe64_mul_a24_ss (t0, (W64.of_int 121665));
    x3 <@ _fe64_sqr_ss (x3);
    t2 <@ _fe64_add_sss (t2, z3);
    z3 <@ _fe64_mul_sss (x1, z2);
    z2r <@ _fe64_mul_rss (t0, t2);
    pos <- poss;
    pos <- (pos - (W64.of_int 1));
    while (((W64.of_int 0) \sle pos)) {
      poss <- pos;
      swap_0 <- swaps;
      b <@ _bit_select (e, pos);
      swap_0 <- (swap_0 `^` b);
      (x2, x3) <@ _fe64_cswap_ssss (x2, x3, swap_0);
      (z2r, z3) <@ _fe64_cswap_rsrs (z2r, z3, swap_0);
      swaps <- b;
      z2 <- z2r;
      t0 <@ _fe64_sub_ssr (x2, z2r);
      x2 <@ _fe64_add_ssr (x2, z2r);
      t1 <@ _fe64_sub_sss (x3, z3);
      z2 <@ _fe64_add_sss (x3, z3);
      z3 <@ _fe64_mul_sss (x2, t1);
      z2 <@ _fe64_mul_sss (z2, t0);
      t2 <@ _fe64_sqr_ss (x2);
      t1r <@ _fe64_sqr_ss (t0);
      t1 <- t1r;
      x3 <@ _fe64_add_sss (z3, z2);
      z2 <@ _fe64_sub_sss (z3, z2);
      x2 <@ _fe64_mul_ssr (t2, t1r);
      t0 <@ _fe64_sub_ssr (t2, t1r);
      z2 <@ _fe64_sqr_ss (z2);
      z3 <@ _fe64_mul_a24_ss (t0, (W64.of_int 121665));
      x3 <@ _fe64_sqr_ss (x3);
      t2 <@ _fe64_add_sss (t2, z3);
      z3 <@ _fe64_mul_sss (x1, z2);
      z2r <@ _fe64_mul_rss (t0, t2);
      pos <- poss;
      pos <- (pos - (W64.of_int 1));
    }
    z2r <@ _fe64_invert (z2r);
    x2r <@ _fe64_mul_rsr (x2, z2r);
    x2r <@ _fe64_tobytes (x2r);
    out <- outs;
    i <- 0;
    while (i < 4) {
      Glob.mem <-
      storeW64 Glob.mem (W64.to_uint (out + (W64.of_int (8 * i)))) x2r.[i];
      i <- i + 1;
    }
    return ();
  }
  
  proc curve25519_mulx (out:W64.t, scalar:W64.t, point:W64.t) : unit = {
    
    
    
    _x25519_scalarmult (out, scalar, point);
    return ();
  }
}.


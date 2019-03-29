require import List Int IntDiv CoreMap.
require import Array2 Array3.
require import WArray16 WArray24.

from Jasmin require import JModel.

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
}.


require import List Int IntExtra IntDiv CoreMap.
from Jasmin require import JModel.

require import Array5 Array25.
require import WArray40 WArray200.



module M = {
  proc spill_2 (a:W64.t, b:W64.t) : W64.t * W64.t = {
    
    var sa:W64.t;
    var sb:W64.t;
    
    sa <- a;
    sb <- b;
    return (sa, sb);
  }
  
  proc load_2 (sa:W64.t, sb:W64.t) : W64.t * W64.t = {
    
    var a:W64.t;
    var b:W64.t;
    
    a <- sa;
    b <- sb;
    return (a, b);
  }
  
  proc rOL64 (x:W64.t, c:int) : W64.t = {
    
    var y:W64.t;
    var  _0:bool;
    var  _1:bool;
    
    if ((c = 0)) {
      y <- x;
    } else {
      ( _0,  _1, y) <- x86_ROL_64 x (W8.of_int c);
    }
    return (y);
  }
  
  proc keccak_init () : W64.t Array25.t = {
    
    var state:W64.t Array25.t;
    var t:W64.t;
    var i:W64.t;
    var  _0:bool;
    var  _1:bool;
    var  _2:bool;
    var  _3:bool;
    var  _4:bool;
    state <- witness;
    ( _0,  _1,  _2,  _3,  _4, t) <- set0_64 ;
    i <- (W64.of_int 0);
    
    while ((i \ult (W64.of_int 25))) {
      state.[(W64.to_uint i)] <- t;
      i <- (i + (W64.of_int 1));
    }
    return (state);
  }
  
  proc index (x:int, y:int) : int = {
    
    var r:int;
    
    r <- ((5 * (x %% 5)) + (y %% 5));
    return (r);
  }
  
  proc keccak_rho_offsets (i:int) : int = {
    var aux: int;
    
    var r:int;
    var x:int;
    var y:int;
    var t:int;
    var z:int;
    
    r <- 0;
    x <- 1;
    y <- 0;
    t <- 0;
    while (t < 24) {
      if ((i = (x + (5 * y)))) {
        r <- ((((t + 1) * (t + 2)) %/ 2) %% 64);
      } else {
        
      }
      z <- (((2 * x) + (3 * y)) %% 5);
      x <- y;
      y <- z;
      t <- t + 1;
    }
    return (r);
  }
  
  proc rhotates (x:int, y:int) : int = {
    
    var r:int;
    var i:int;
    
    i <@ index (x, y);
    r <@ keccak_rho_offsets (i);
    return (r);
  }
  
  proc theta_sum (A:W64.t Array25.t) : W64.t Array5.t = {
    var aux: int;
    
    var C:W64.t Array5.t;
    var i:int;
    var j:int;
    C <- witness;
    i <- 0;
    while (i < 5) {
      C.[i] <- A.[((5 * (0 %% 5)) + (i %% 5))];
      j <- 1;
      while (j < 5) {
        C.[i] <- (C.[i] `^` A.[((5 * (j %% 5)) + (i %% 5))]);
        j <- j + 1;
      }
      i <- i + 1;
    }
    return (C);
  }
  
  proc theta_rol (C:W64.t Array5.t) : W64.t Array5.t = {
    var aux: int;
    
    var D:W64.t Array5.t;
    var i:int;
    var r:W64.t;
    D <- witness;
    i <- 0;
    while (i < 5) {
      r <@ rOL64 (C.[((i + 1) %% 5)], 1);
      D.[i] <- r;
      D.[i] <- (D.[i] `^` C.[((i + 4) %% 5)]);
      i <- i + 1;
    }
    return (D);
  }
  
  proc rol_sum (D:W64.t Array5.t, A:W64.t Array25.t, offset:int) : W64.t Array5.t = {
    var aux: int;
    
    var C:W64.t Array5.t;
    var j:int;
    var j1:int;
    var k:int;
    var t:W64.t;
    C <- witness;
    j <- 0;
    while (j < 5) {
      j1 <- ((j + offset) %% 5);
      k <@ rhotates (j, j1);
      t <- A.[((5 * (j %% 5)) + (j1 %% 5))];
      t <- (t `^` D.[j1]);
      t <@ rOL64 (t, k);
      C.[j] <- t;
      j <- j + 1;
    }
    return (C);
  }
  
  proc set_row (R:W64.t Array25.t, row:int, C:W64.t Array5.t, iota_0:W64.t) : 
  W64.t Array25.t = {
    var aux: int;
    
    var j:int;
    var j1:int;
    var j2:int;
    var t:W64.t;
    
    j <- 0;
    while (j < 5) {
      j1 <- ((j + 1) %% 5);
      j2 <- ((j + 2) %% 5);
      t <- ((invw C.[j1]) `&` C.[j2]);
      if (((row = 0) /\ (j = 0))) {
        t <- (t `^` iota_0);
      } else {
        
      }
      t <- (t `^` C.[j]);
      R.[((5 * (row %% 5)) + (j %% 5))] <- t;
      j <- j + 1;
    }
    return (R);
  }
  
  proc round2x (A:W64.t Array25.t, R:W64.t Array25.t, iotas:W64.t, o:int) : 
  W64.t Array25.t * W64.t Array25.t = {
    
    var iota_0:W64.t;
    var C:W64.t Array5.t;
    var D:W64.t Array5.t;
    C <- witness;
    D <- witness;
    iota_0 <- (loadW64 Glob.mem (W64.to_uint (iotas + (W64.of_int o))));
    C <@ theta_sum (A);
    D <@ theta_rol (C);
    C <@ rol_sum (D, A, 0);
    R <@ set_row (R, 0, C, iota_0);
    C <@ rol_sum (D, A, 3);
    R <@ set_row (R, 1, C, iota_0);
    C <@ rol_sum (D, A, 1);
    R <@ set_row (R, 2, C, iota_0);
    C <@ rol_sum (D, A, 4);
    R <@ set_row (R, 3, C, iota_0);
    C <@ rol_sum (D, A, 2);
    R <@ set_row (R, 4, C, iota_0);
    return (A, R);
  }
  
  proc keccak_f (A:W64.t Array25.t, iotas:W64.t) : W64.t Array25.t * W64.t = {
    
    var zf:bool;
    var R:W64.t Array25.t;
    var  _0:bool;
    var  _1:bool;
    var  _2:bool;
    var  _3:bool;
    R <- witness;
    (A, R) <@ round2x (A, R, iotas, 0);
    (R, A) <@ round2x (R, A, iotas, 8);
    iotas <- (iotas + (W64.of_int 16));
    ( _0,  _1,  _2,  _3, zf) <- x86_TEST_8 (truncateu8 iotas)
    (W8.of_int 255);
    while ((! zf)) {
      (A, R) <@ round2x (A, R, iotas, 0);
      (R, A) <@ round2x (R, A, iotas, 8);
      iotas <- (iotas + (W64.of_int 16));
      ( _0,  _1,  _2,  _3, zf) <- x86_TEST_8 (truncateu8 iotas)
      (W8.of_int 255);
    }
    iotas <- (iotas - (W64.of_int 192));
    return (A, iotas);
  }
  
  proc keccak_1600_add_full_block (state:W64.t Array25.t, in_0:W64.t,
                                   inlen:W64.t, rate_in_bytes:int) : 
  W64.t Array25.t * W64.t * W64.t = {
    var aux: int;
    
    var i:int;
    var t:W64.t;
    
    aux <- (rate_in_bytes %/ 8);
    i <- 0;
    while (i < aux) {
      t <- (loadW64 Glob.mem (W64.to_uint (in_0 + (W64.of_int (8 * i)))));
      state.[i] <- (state.[i] `^` t);
      i <- i + 1;
    }
    in_0 <- (in_0 + (W64.of_int rate_in_bytes));
    inlen <- (inlen - (W64.of_int rate_in_bytes));
    return (state, in_0, inlen);
  }
  
  proc lastu64 (in_0:W64.t, inlen:W64.t, suffix:int) : W64.t = {
    
    var res_0:W64.t;
    var delta_0:W64.t;
    var zf:bool;
    var t:W64.t;
    var suffix_u64:W64.t;
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
    var  _10:bool;
    var  _11:bool;
    
    res_0 <- (W64.of_int 0);
    delta_0 <- (W64.of_int 0);
    ( _0,  _1,  _2,  _3, zf) <- x86_TEST_8 (truncateu8 inlen) (W8.of_int 4);
    if ((! zf)) {
      res_0 <-
      (zeroextu64 (loadW32 Glob.mem (W64.to_uint (in_0 + (W64.of_int 0)))));
      in_0 <- (in_0 + (W64.of_int 4));
      delta_0 <- (W64.of_int 32);
    } else {
      
    }
    ( _4,  _5,  _6,  _7, zf) <- x86_TEST_8 (truncateu8 inlen) (W8.of_int 2);
    if ((! zf)) {
      t <-
      (zeroextu64 (loadW16 Glob.mem (W64.to_uint (in_0 + (W64.of_int 0)))));
      in_0 <- (in_0 + (W64.of_int 2));
      t <- (t `<<` (truncateu8 delta_0));
      delta_0 <- (delta_0 + (W64.of_int 16));
      res_0 <- (res_0 + t);
    } else {
      
    }
    ( _8,  _9,  _10,  _11, zf) <- x86_TEST_8 (truncateu8 inlen)
    (W8.of_int 1);
    if ((! zf)) {
      t <-
      (zeroextu64 (loadW8 Glob.mem (W64.to_uint (in_0 + (W64.of_int 0)))));
      t <- (t `<<` (truncateu8 delta_0));
      delta_0 <- (delta_0 + (W64.of_int 8));
      res_0 <- (res_0 + t);
    } else {
      
    }
    suffix_u64 <- (W64.of_int suffix);
    suffix_u64 <- (suffix_u64 `<<` (truncateu8 delta_0));
    res_0 <- (res_0 + suffix_u64);
    return (res_0);
  }
  
  proc keccak_1600_add_final_block (state:W64.t Array25.t, in_0:W64.t,
                                    inlen:W64.t, suffix:int,
                                    rate_in_bytes:int) : W64.t Array25.t = {
    
    var inlen8:W64.t;
    var i:W64.t;
    var t:W64.t;
    
    inlen8 <- inlen;
    inlen8 <- (inlen8 `>>` (W8.of_int 3));
    i <- (W64.of_int 0);
    
    while ((i \ult inlen8)) {
      t <- (loadW64 Glob.mem (W64.to_uint (in_0 + ((W64.of_int 8) * i))));
      state.[(W64.to_uint i)] <- (state.[(W64.to_uint i)] `^` t);
      i <- (i + (W64.of_int 1));
    }
    in_0 <- (in_0 + ((W64.of_int 8) * i));
    inlen <- (inlen `&` (W64.of_int 7));
    t <@ lastu64 (in_0, inlen, suffix);
    state.[(W64.to_uint i)] <- (state.[(W64.to_uint i)] `^` t);
    state =
    Array25.init
    (WArray200.get64 (WArray200.set8 (WArray200.init64 (fun i => state.[i])) (rate_in_bytes - 1) (
    (get8 (WArray200.init64 (fun i => state.[i])) (rate_in_bytes - 1)) `^` (W8.of_int 128))));
    return (state);
  }
  
  proc keccak_1600_absorb (state:W64.t Array25.t, iotas:W64.t, in_0:W64.t,
                           inlen:W64.t, suffix:int, rate_in_bytes:int) : 
  W64.t Array25.t * W64.t = {
    
    var s_in:W64.t;
    var s_inlen:W64.t;
    
    
    while (((W64.of_int rate_in_bytes) \ule inlen)) {
      (state, in_0, inlen) <@ keccak_1600_add_full_block (state, in_0, inlen,
      rate_in_bytes);
      (s_in, s_inlen) <@ spill_2 (in_0, inlen);
      (state, iotas) <@ keccak_f (state, iotas);
      (in_0, inlen) <@ load_2 (s_in, s_inlen);
    }
    state <@ keccak_1600_add_final_block (state, in_0, inlen, suffix,
    rate_in_bytes);
    return (state, iotas);
  }
  
  proc keccak_1600_xtr_block (state:W64.t Array25.t, out:W64.t, len:W64.t) : 
  W64.t = {
    
    var len8:W64.t;
    var i:W64.t;
    var t:W64.t;
    var c:W8.t;
    
    len8 <- len;
    len8 <- (len8 `>>` (W8.of_int 3));
    i <- (W64.of_int 0);
    
    while ((i \ult len8)) {
      t <- state.[(W64.to_uint i)];
      Glob.mem <-
      storeW64 Glob.mem (W64.to_uint (out + ((W64.of_int 8) * i))) t;
      i <- (i + (W64.of_int 1));
    }
    i <- (i `<<` (W8.of_int 3));
    
    while ((i \ult len)) {
      c <- (get8 (WArray200.init64 (fun i => state.[i])) (W64.to_uint i));
      Glob.mem <- storeW8 Glob.mem (W64.to_uint (out + i)) c;
      i <- (i + (W64.of_int 1));
    }
    out <- (out + len);
    return (out);
  }
  
  proc keccak_1600_squeeze (state:W64.t Array25.t, iotas:W64.t, out:W64.t,
                            s_hash_bytes:W64.t, rate_in_bytes:int) : unit = {
    
    var s_out:W64.t;
    
    
    while (((W64.of_int 0) \ult s_hash_bytes)) {
      s_out <- out;
      (state, iotas) <@ keccak_f (state, iotas);
      out <- s_out;
      out <@ keccak_1600_xtr_block (state, out, (W64.of_int rate_in_bytes));
      s_hash_bytes <- (s_hash_bytes - (W64.of_int rate_in_bytes));
    }
    return ();
  }
  
  proc keccak_1600 (out:W64.t, in_0:W64.t, inlen:W64.t, iotas_:W64.t,
                    hash_bytes:W64.t, suffix:int, rate:int, capacity:int) : unit = {
    
    var iotas:W64.t;
    var out_s:W64.t;
    var s_hash_bytes:W64.t;
    var state:W64.t Array25.t;
    state <- witness;
    iotas <- iotas_;
    out_s <- out;
    s_hash_bytes <- hash_bytes;
    state <@ keccak_init ();
    (state, iotas) <@ keccak_1600_absorb (state, iotas, in_0, inlen, suffix,
    (rate %/ 8));
    out <- out_s;
    keccak_1600_squeeze (state, iotas, out, s_hash_bytes, (rate %/ 8));
    return ();
  }
}.


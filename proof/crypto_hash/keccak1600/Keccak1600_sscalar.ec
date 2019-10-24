require import List Int IntExtra IntDiv CoreMap.
from Jasmin require import JModel.

require import Array5 Array25.
require import WArray40 WArray200.



module M = {
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
  
  proc theta_sum (a:W64.t Array25.t) : W64.t Array5.t = {
    var aux: int;
    
    var c:W64.t Array5.t;
    var i:int;
    var j:int;
    c <- witness;
    i <- 0;
    while (i < 5) {
      c.[i] <- a.[((5 * (0 %% 5)) + (i %% 5))];
      i <- i + 1;
    }
    j <- 1;
    while (j < 5) {
      i <- 0;
      while (i < 5) {
        c.[i] <- (c.[i] `^` a.[((5 * (j %% 5)) + (i %% 5))]);
        i <- i + 1;
      }
      j <- j + 1;
    }
    return (c);
  }
  
  proc theta_rol (c:W64.t Array5.t) : W64.t Array5.t = {
    var aux_1: bool;
    var aux_0: bool;
    var aux: int;
    var aux_2: W64.t;
    
    var d:W64.t Array5.t;
    var i:int;
    var  _0:bool;
    var  _1:bool;
    d <- witness;
    i <- 0;
    while (i < 5) {
      d.[i] <- c.[((i + 1) %% 5)];
      (aux_1, aux_0, aux_2) <- x86_ROL_64 d.[i] (W8.of_int 1);
       _0 <- aux_1;
       _1 <- aux_0;
      d.[i] <- aux_2;
      d.[i] <- (d.[i] `^` c.[((i + 4) %% 5)]);
      i <- i + 1;
    }
    return (d);
  }
  
  proc rol_sum (d:W64.t Array5.t, a:W64.t Array25.t, offset:int) : W64.t Array5.t = {
    var aux: int;
    
    var c:W64.t Array5.t;
    var j:int;
    var j1:int;
    var k:int;
    var t:W64.t;
    c <- witness;
    j <- 0;
    while (j < 5) {
      j1 <- ((j + offset) %% 5);
      k <@ rhotates (j, j1);
      t <- a.[((5 * (j %% 5)) + (j1 %% 5))];
      t <- (t `^` d.[j1]);
      t <@ rOL64 (t, k);
      c.[j] <- t;
      j <- j + 1;
    }
    return (c);
  }
  
  proc set_row (r:W64.t Array25.t, row:int, c:W64.t Array5.t, iota_0:W64.t) : 
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
      t <- ((invw c.[j1]) `&` c.[j2]);
      if (((row = 0) /\ (j = 0))) {
        t <- (t `^` iota_0);
      } else {
        
      }
      t <- (t `^` c.[j]);
      r.[((5 * (row %% 5)) + (j %% 5))] <- t;
      j <- j + 1;
    }
    return (r);
  }
  
  proc round2x (a:W64.t Array25.t, r:W64.t Array25.t, iotas:W64.t, o:int) : 
  W64.t Array25.t * W64.t Array25.t = {
    
    var iota_0:W64.t;
    var c:W64.t Array5.t;
    var d:W64.t Array5.t;
    c <- witness;
    d <- witness;
    iota_0 <- (loadW64 Glob.mem (W64.to_uint (iotas + (W64.of_int o))));
    c <@ theta_sum (a);
    d <@ theta_rol (c);
    c <@ rol_sum (d, a, 0);
    r <@ set_row (r, 0, c, iota_0);
    c <@ rol_sum (d, a, 3);
    r <@ set_row (r, 1, c, iota_0);
    c <@ rol_sum (d, a, 1);
    r <@ set_row (r, 2, c, iota_0);
    c <@ rol_sum (d, a, 4);
    r <@ set_row (r, 3, c, iota_0);
    c <@ rol_sum (d, a, 2);
    r <@ set_row (r, 4, c, iota_0);
    return (a, r);
  }
  
  proc __keccakf1600_scalar (a:W64.t Array25.t, iotas:W64.t) : W64.t Array25.t *
                                                               W64.t = {
    
    var zf:bool;
    var r:W64.t Array25.t;
    var  _0:bool;
    var  _1:bool;
    var  _2:bool;
    var  _3:bool;
    r <- witness;
    (a, r) <@ round2x (a, r, iotas, 0);
    (r, a) <@ round2x (r, a, iotas, 8);
    iotas <- (iotas + (W64.of_int 16));
    ( _0,  _1,  _2,  _3, zf) <- x86_TEST_8 (truncateu8 iotas)
    (W8.of_int 255);
    while ((! zf)) {
      (a, r) <@ round2x (a, r, iotas, 0);
      (r, a) <@ round2x (r, a, iotas, 8);
      iotas <- (iotas + (W64.of_int 16));
      ( _0,  _1,  _2,  _3, zf) <- x86_TEST_8 (truncateu8 iotas)
      (W8.of_int 255);
    }
    iotas <- (iotas - (W64.of_int 192));
    return (a, iotas);
  }
  
  proc spill_2 (a:W64.t, b:W64.t) : W64.t * W64.t = {
    
    var sa:W64.t;
    var sb:W64.t;
    
    sa <- a;
    sb <- b;
    return (sa, sb);
  }
  
  proc spill_3 (a:W64.t, b:W64.t, c:W64.t) : W64.t * W64.t * W64.t = {
    
    var sa:W64.t;
    var sb:W64.t;
    var sc:W64.t;
    
    sa <- a;
    sb <- b;
    sc <- c;
    return (sa, sb, sc);
  }
  
  proc load_2 (sa:W64.t, sb:W64.t) : W64.t * W64.t = {
    
    var a:W64.t;
    var b:W64.t;
    
    a <- sa;
    b <- sb;
    return (a, b);
  }
  
  proc load_3 (sa:W64.t, sb:W64.t, sc:W64.t) : W64.t * W64.t * W64.t = {
    
    var a:W64.t;
    var b:W64.t;
    var c:W64.t;
    
    a <- sa;
    b <- sb;
    c <- sc;
    return (a, b, c);
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
  
  proc add_full_block (state:W64.t Array25.t, in_0:W64.t, inlen:W64.t,
                       rate:W64.t) : W64.t Array25.t * W64.t * W64.t = {
    
    var rate64:W64.t;
    var i:W64.t;
    var t:W64.t;
    
    rate64 <- rate;
    rate64 <- (rate64 `>>` (W8.of_int 3));
    i <- (W64.of_int 0);
    
    while ((i \ult rate64)) {
      t <- (loadW64 Glob.mem (W64.to_uint (in_0 + ((W64.of_int 8) * i))));
      state.[(W64.to_uint i)] <- (state.[(W64.to_uint i)] `^` t);
      i <- (i + (W64.of_int 1));
    }
    in_0 <- (in_0 + rate);
    inlen <- (inlen - rate);
    return (state, in_0, inlen);
  }
  
  proc add_final_block (state:W64.t Array25.t, in_0:W64.t, inlen:W64.t,
                        trail_byte:W8.t, rate:W64.t) : W64.t Array25.t = {
    
    var inlen8:W64.t;
    var i:W64.t;
    var t:W64.t;
    var c:W8.t;
    
    inlen8 <- inlen;
    inlen8 <- (inlen8 `>>` (W8.of_int 3));
    i <- (W64.of_int 0);
    
    while ((i \ult inlen8)) {
      t <- (loadW64 Glob.mem (W64.to_uint (in_0 + ((W64.of_int 8) * i))));
      state.[(W64.to_uint i)] <- (state.[(W64.to_uint i)] `^` t);
      i <- (i + (W64.of_int 1));
    }
    i <- (i `<<` (W8.of_int 3));
    
    while ((i \ult inlen)) {
      c <- (loadW8 Glob.mem (W64.to_uint (in_0 + i)));
      state =
      Array25.init
      (WArray200.get64 (WArray200.set8 (WArray200.init64 (fun i => state.[i])) (W64.to_uint i) (
      (get8 (WArray200.init64 (fun i => state.[i])) (W64.to_uint i)) `^` c)));
      i <- (i + (W64.of_int 1));
    }
    state =
    Array25.init
    (WArray200.get64 (WArray200.set8 (WArray200.init64 (fun i => state.[i])) (W64.to_uint i) (
    (get8 (WArray200.init64 (fun i => state.[i])) (W64.to_uint i)) `^` trail_byte)));
    i <- rate;
    i <- (i - (W64.of_int 1));
    state =
    Array25.init
    (WArray200.get64 (WArray200.set8 (WArray200.init64 (fun i => state.[i])) (W64.to_uint i) (
    (get8 (WArray200.init64 (fun i => state.[i])) (W64.to_uint i)) `^` (W8.of_int 128))));
    return (state);
  }
  
  proc absorb (state:W64.t Array25.t, iotas:W64.t, in_0:W64.t, inlen:W64.t,
               s_trail_byte:W64.t, rate:W64.t) : W64.t Array25.t * W64.t *
                                                 W64.t = {
    
    var s_in:W64.t;
    var s_inlen:W64.t;
    var s_rate:W64.t;
    var t:W64.t;
    var trail_byte:W8.t;
    
    
    while ((rate \ule inlen)) {
      (state, in_0, inlen) <@ add_full_block (state, in_0, inlen, rate);
      (s_in, s_inlen, s_rate) <@ spill_3 (in_0, inlen, rate);
      (state, iotas) <@ __keccakf1600_scalar (state, iotas);
      (in_0, inlen, rate) <@ load_3 (s_in, s_inlen, s_rate);
    }
    t <- s_trail_byte;
    trail_byte <- (truncateu8 t);
    state <@ add_final_block (state, in_0, inlen, trail_byte, rate);
    return (state, iotas, rate);
  }
  
  proc xtr_full_block (state:W64.t Array25.t, out:W64.t, outlen:W64.t,
                       rate:W64.t) : W64.t * W64.t = {
    
    var rate64:W64.t;
    var i:W64.t;
    var t:W64.t;
    
    rate64 <- rate;
    rate64 <- (rate64 `>>` (W8.of_int 3));
    i <- (W64.of_int 0);
    
    while ((i \ult rate64)) {
      t <- state.[(W64.to_uint i)];
      Glob.mem <-
      storeW64 Glob.mem (W64.to_uint (out + ((W64.of_int 8) * i))) t;
      i <- (i + (W64.of_int 1));
    }
    out <- (out + rate);
    outlen <- (outlen - rate);
    return (out, outlen);
  }
  
  proc xtr_bytes (state:W64.t Array25.t, out:W64.t, outlen:W64.t) : W64.t = {
    
    var outlen8:W64.t;
    var i:W64.t;
    var t:W64.t;
    var c:W8.t;
    
    outlen8 <- outlen;
    outlen8 <- (outlen8 `>>` (W8.of_int 3));
    i <- (W64.of_int 0);
    
    while ((i \ult outlen8)) {
      t <- state.[(W64.to_uint i)];
      Glob.mem <-
      storeW64 Glob.mem (W64.to_uint (out + ((W64.of_int 8) * i))) t;
      i <- (i + (W64.of_int 1));
    }
    i <- (i `<<` (W8.of_int 3));
    
    while ((i \ult outlen)) {
      c <- (get8 (WArray200.init64 (fun i => state.[i])) (W64.to_uint i));
      Glob.mem <- storeW8 Glob.mem (W64.to_uint (out + i)) c;
      i <- (i + (W64.of_int 1));
    }
    out <- (out + outlen);
    return (out);
  }
  
  proc squeeze (state:W64.t Array25.t, iotas:W64.t, s_out:W64.t,
                outlen:W64.t, rate:W64.t) : unit = {
    
    var s_outlen:W64.t;
    var s_rate:W64.t;
    var out:W64.t;
    
    
    while ((rate \ult outlen)) {
      (s_outlen, s_rate) <@ spill_2 (outlen, rate);
      (state, iotas) <@ __keccakf1600_scalar (state, iotas);
      (out, outlen, rate) <@ load_3 (s_out, s_outlen, s_rate);
      (out, outlen) <@ xtr_full_block (state, out, outlen, rate);
      s_out <- out;
    }
    s_outlen <- outlen;
    (state, iotas) <@ __keccakf1600_scalar (state, iotas);
    (out, outlen) <@ load_2 (s_out, s_outlen);
    out <@ xtr_bytes (state, out, outlen);
    return ();
  }
  
  proc __keccak1600_scalar (s_out:W64.t, s_outlen:W64.t, iotas:W64.t,
                            in_0:W64.t, inlen:W64.t, s_trail_byte:W64.t,
                            rate:W64.t) : unit = {
    
    var state:W64.t Array25.t;
    var outlen:W64.t;
    state <- witness;
    state <@ keccak_init ();
    (state, iotas, rate) <@ absorb (state, iotas, in_0, inlen, s_trail_byte,
    rate);
    outlen <- s_outlen;
    squeeze (state, iotas, s_out, outlen, rate);
    return ();
  }
}.


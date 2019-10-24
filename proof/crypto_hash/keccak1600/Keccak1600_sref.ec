require import List Int IntExtra IntDiv CoreMap.
from Jasmin require import JModel.

require import Array5 Array24 Array25.
require import WArray40 WArray192 WArray200.



module M = {
  proc index (x:int, y:int) : int = {
    
    var r:int;
    
    r <- ((x %% 5) + (5 * (y %% 5)));
    return (r);
  }
  
  proc theta (a:W64.t Array25.t) : W64.t Array25.t = {
    var aux_1: bool;
    var aux_0: bool;
    var aux: int;
    var aux_2: W64.t;
    
    var x:int;
    var c:W64.t Array5.t;
    var y:int;
    var d:W64.t Array5.t;
    var  _0:bool;
    var  _1:bool;
    c <- witness;
    d <- witness;
    x <- 0;
    while (x < 5) {
      c.[x] <- (W64.of_int 0);
      y <- 0;
      while (y < 5) {
        c.[x] <- (c.[x] `^` a.[(x + (5 * y))]);
        y <- y + 1;
      }
      x <- x + 1;
    }
    x <- 0;
    while (x < 5) {
      d.[x] <- c.[((x + 1) %% 5)];
      (aux_1, aux_0, aux_2) <- x86_ROL_64 d.[x] (W8.of_int 1);
       _0 <- aux_1;
       _1 <- aux_0;
      d.[x] <- aux_2;
      d.[x] <- (d.[x] `^` c.[((x + 4) %% 5)]);
      x <- x + 1;
    }
    x <- 0;
    while (x < 5) {
      y <- 0;
      while (y < 5) {
        a.[(x + (5 * y))] <- (a.[(x + (5 * y))] `^` d.[x]);
        y <- y + 1;
      }
      x <- x + 1;
    }
    return (a);
  }
  
  proc keccakRhoOffsets (i:int) : int = {
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
  
  proc rho (a:W64.t Array25.t) : W64.t Array25.t = {
    var aux_1: bool;
    var aux_0: bool;
    var aux: int;
    var aux_2: W64.t;
    
    var x:int;
    var y:int;
    var i:int;
    var z:int;
    var  _0:bool;
    var  _1:bool;
    
    x <- 0;
    while (x < 5) {
      y <- 0;
      while (y < 5) {
        i <@ index (x, y);
        z <@ keccakRhoOffsets (i);
        (aux_1, aux_0, aux_2) <- x86_ROL_64 a.[i] (W8.of_int z);
         _0 <- aux_1;
         _1 <- aux_0;
        a.[i] <- aux_2;
        y <- y + 1;
      }
      x <- x + 1;
    }
    return (a);
  }
  
  proc pi (a:W64.t Array25.t) : W64.t Array25.t = {
    var aux: int;
    
    var i:int;
    var t:W64.t;
    var b:W64.t Array25.t;
    var y:int;
    var x:int;
    b <- witness;
    i <- 0;
    while (i < 25) {
      t <- a.[i];
      b.[i] <- t;
      i <- i + 1;
    }
    x <- 0;
    while (x < 5) {
      y <- 0;
      while (y < 5) {
        t <- b.[(x + (5 * y))];
        i <@ index (y, ((2 * x) + (3 * y)));
        a.[i] <- t;
        y <- y + 1;
      }
      x <- x + 1;
    }
    return (a);
  }
  
  proc chi (a:W64.t Array25.t) : W64.t Array25.t = {
    var aux: int;
    
    var x:int;
    var y:int;
    var i:int;
    var c:W64.t Array5.t;
    c <- witness;
    y <- 0;
    while (y < 5) {
      x <- 0;
      while (x < 5) {
        i <@ index ((x + 1), y);
        c.[x] <- a.[i];
        c.[x] <- (invw c.[x]);
        i <@ index ((x + 2), y);
        c.[x] <- (c.[x] `&` a.[i]);
        i <@ index (x, y);
        c.[x] <- (c.[x] `^` a.[i]);
        x <- x + 1;
      }
      x <- 0;
      while (x < 5) {
        a.[(x + (5 * y))] <- c.[x];
        x <- x + 1;
      }
      y <- y + 1;
    }
    return (a);
  }
  
  proc iota_0 (a:W64.t Array25.t, c:W64.t) : W64.t Array25.t = {
    
    
    
    a.[0] <- (a.[0] `^` c);
    return (a);
  }
  
  proc keccakP1600_round (state:W64.t Array25.t, c:W64.t) : W64.t Array25.t = {
    
    
    
    state <@ theta (state);
    state <@ rho (state);
    state <@ pi (state);
    state <@ chi (state);
    state <@ iota_0 (state, c);
    return (state);
  }
  
  proc keccakRoundConstants () : W64.t Array24.t = {
    
    var constants:W64.t Array24.t;
    var t:W64.t;
    constants <- witness;
    t <- (W64.of_int 1);
    constants.[0] <- t;
    t <- (W64.of_int 32898);
    constants.[1] <- t;
    t <- (W64.of_int 9223372036854808714);
    constants.[2] <- t;
    t <- (W64.of_int 9223372039002292224);
    constants.[3] <- t;
    t <- (W64.of_int 32907);
    constants.[4] <- t;
    t <- (W64.of_int 2147483649);
    constants.[5] <- t;
    t <- (W64.of_int 9223372039002292353);
    constants.[6] <- t;
    t <- (W64.of_int 9223372036854808585);
    constants.[7] <- t;
    t <- (W64.of_int 138);
    constants.[8] <- t;
    t <- (W64.of_int 136);
    constants.[9] <- t;
    t <- (W64.of_int 2147516425);
    constants.[10] <- t;
    t <- (W64.of_int 2147483658);
    constants.[11] <- t;
    t <- (W64.of_int 2147516555);
    constants.[12] <- t;
    t <- (W64.of_int 9223372036854775947);
    constants.[13] <- t;
    t <- (W64.of_int 9223372036854808713);
    constants.[14] <- t;
    t <- (W64.of_int 9223372036854808579);
    constants.[15] <- t;
    t <- (W64.of_int 9223372036854808578);
    constants.[16] <- t;
    t <- (W64.of_int 9223372036854775936);
    constants.[17] <- t;
    t <- (W64.of_int 32778);
    constants.[18] <- t;
    t <- (W64.of_int 9223372039002259466);
    constants.[19] <- t;
    t <- (W64.of_int 9223372039002292353);
    constants.[20] <- t;
    t <- (W64.of_int 9223372036854808704);
    constants.[21] <- t;
    t <- (W64.of_int 2147483649);
    constants.[22] <- t;
    t <- (W64.of_int 9223372039002292232);
    constants.[23] <- t;
    return (constants);
  }
  
  proc __keccakf1600_ref (state:W64.t Array25.t) : W64.t Array25.t = {
    var aux: int;
    
    var constants:W64.t Array24.t;
    var round:int;
    constants <- witness;
    constants <@ keccakRoundConstants ();
    round <- 0;
    while (round < 24) {
      state <@ keccakP1600_round (state, constants.[round]);
      round <- round + 1;
    }
    return (state);
  }
  
  proc st0 () : W64.t Array25.t = {
    var aux: int;
    
    var state:W64.t Array25.t;
    var i:int;
    state <- witness;
    i <- 0;
    while (i < 25) {
      state.[i] <- (W64.of_int 0);
      i <- i + 1;
    }
    return (state);
  }
  
  proc add_full_block (state:W64.t Array25.t, in_0:W64.t, inlen:W64.t,
                       r8:W64.t) : W64.t Array25.t * W64.t * W64.t = {
    
    var r64:W64.t;
    var i:W64.t;
    var t:W64.t;
    
    r64 <- r8;
    r64 <- (r64 `>>` (W8.of_int 3));
    i <- (W64.of_int 0);
    
    while ((i \ult r64)) {
      t <- (loadW64 Glob.mem (W64.to_uint (in_0 + ((W64.of_int 8) * i))));
      state.[(W64.to_uint i)] <- (state.[(W64.to_uint i)] `^` t);
      i <- (i + (W64.of_int 1));
    }
    in_0 <- (in_0 + r8);
    inlen <- (inlen - r8);
    return (state, in_0, inlen);
  }
  
  proc add_final_block (state:W64.t Array25.t, in_0:W64.t, inlen:W64.t,
                        trail_byte:W8.t, r8:W64.t) : W64.t Array25.t = {
    
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
    i <- r8;
    i <- (i - (W64.of_int 1));
    state =
    Array25.init
    (WArray200.get64 (WArray200.set8 (WArray200.init64 (fun i => state.[i])) (W64.to_uint i) (
    (get8 (WArray200.init64 (fun i => state.[i])) (W64.to_uint i)) `^` (W8.of_int 128))));
    return (state);
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
  
  proc xtr_bytes (state:W64.t Array25.t, out:W64.t, outlen:W64.t) : unit = {
    
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
    return ();
  }
  
  proc __keccak1600_ref (s_out:W64.t, s_outlen:W64.t, in_0:W64.t,
                         inlen:W64.t, s_trail_byte:W64.t, rate:W64.t) : unit = {
    
    var state:W64.t Array25.t;
    var s_in:W64.t;
    var s_inlen:W64.t;
    var s_rate:W64.t;
    var t:W64.t;
    var trail_byte:W8.t;
    var outlen:W64.t;
    var out:W64.t;
    state <- witness;
    state <@ st0 ();
    
    while ((rate \ule inlen)) {
      (state, in_0, inlen) <@ add_full_block (state, in_0, inlen, rate);
      s_in <- in_0;
      s_inlen <- inlen;
      s_rate <- rate;
      state <@ __keccakf1600_ref (state);
      inlen <- s_inlen;
      in_0 <- s_in;
      rate <- s_rate;
    }
    t <- s_trail_byte;
    trail_byte <- (truncateu8 t);
    state <@ add_final_block (state, in_0, inlen, trail_byte, rate);
    outlen <- s_outlen;
    
    while ((rate \ult outlen)) {
      s_outlen <- outlen;
      s_rate <- rate;
      state <@ __keccakf1600_ref (state);
      out <- s_out;
      outlen <- s_outlen;
      rate <- s_rate;
      (out, outlen) <@ xtr_full_block (state, out, outlen, rate);
      s_outlen <- outlen;
      s_out <- out;
    }
    state <@ __keccakf1600_ref (state);
    out <- s_out;
    outlen <- s_outlen;
    xtr_bytes (state, out, outlen);
    return ();
  }
}.


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
  
  proc __keccak_f1600_ref (state:W64.t Array25.t) : W64.t Array25.t = {
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
  
  proc add_full_block (state:W64.t Array25.t, in_0:W64.t, r64:W64.t) : 
  W64.t Array25.t = {
    
    var i:W64.t;
    var t:W64.t;
    
    i <- (W64.of_int 0);
    
    while ((i \ult r64)) {
      t <- (loadW64 Glob.mem (W64.to_uint (in_0 + ((W64.of_int 8) * i))));
      state.[(W64.to_uint i)] <- (state.[(W64.to_uint i)] `^` t);
      i <- (i + (W64.of_int 1));
    }
    return (state);
  }
  
  proc add_final_block (state:W64.t Array25.t, in_0:W64.t, inlen:W64.t,
                        trail_byte:W8.t, r8:W64.t) : W64.t Array25.t = {
    
    var i:W64.t;
    var t:W64.t;
    var j:W64.t;
    var c:W8.t;
    
    i <- (W64.of_int 0);
    
    while (((W64.of_int 8) \ule inlen)) {
      t <- (loadW64 Glob.mem (W64.to_uint (in_0 + ((W64.of_int 8) * i))));
      state.[(W64.to_uint i)] <- (state.[(W64.to_uint i)] `^` t);
      i <- (i + (W64.of_int 1));
      inlen <- (inlen - (W64.of_int 8));
    }
    j <- ((W64.of_int 8) * i);
    
    while (((W64.of_int 0) \ult inlen)) {
      c <- (loadW8 Glob.mem (W64.to_uint (in_0 + j)));
      state =
      Array25.init
      (WArray200.get64 (WArray200.set8 (WArray200.init64 (fun i => state.[i])) (W64.to_uint j) (
      (get8 (WArray200.init64 (fun i => state.[i])) (W64.to_uint j)) `^` c)));
      inlen <- (inlen - (W64.of_int 1));
      j <- (j + (W64.of_int 1));
    }
    c <- trail_byte;
    state =
    Array25.init
    (WArray200.get64 (WArray200.set8 (WArray200.init64 (fun i => state.[i])) (W64.to_uint j) (
    (get8 (WArray200.init64 (fun i => state.[i])) (W64.to_uint j)) `^` c)));
    state =
    Array25.init
    (WArray200.get64 (WArray200.set8 (WArray200.init64 (fun i => state.[i])) ((W64.to_uint r8) - 1) (
    (get8 (WArray200.init64 (fun i => state.[i])) ((W64.to_uint r8) - 1)) `^` (W8.of_int 128))));
    return (state);
  }
  
  proc xtr_full_block (state:W64.t Array25.t, out:W64.t, r64:W64.t) : unit = {
    
    var i:W64.t;
    var t:W64.t;
    
    i <- (W64.of_int 0);
    
    while ((i \ult r64)) {
      t <- state.[(W64.to_uint i)];
      Glob.mem <-
      storeW64 Glob.mem (W64.to_uint (out + ((W64.of_int 8) * i))) t;
      i <- (i + (W64.of_int 1));
    }
    return ();
  }
  
  proc xtr_bytes (state:W64.t Array25.t, out:W64.t, outlen:W64.t) : unit = {
    
    var i:W64.t;
    var t:W64.t;
    var j:W64.t;
    var c:W8.t;
    
    i <- (W64.of_int 0);
    
    while (((W64.of_int 8) \ule outlen)) {
      t <- state.[(W64.to_uint i)];
      Glob.mem <-
      storeW64 Glob.mem (W64.to_uint (out + ((W64.of_int 8) * i))) t;
      i <- (i + (W64.of_int 1));
      outlen <- (outlen - (W64.of_int 8));
    }
    j <- ((W64.of_int 8) * i);
    
    while (((W64.of_int 0) \ult outlen)) {
      c <- (get8 (WArray200.init64 (fun i => state.[i])) (W64.to_uint j));
      Glob.mem <- storeW8 Glob.mem (W64.to_uint (out + j)) c;
      outlen <- (outlen - (W64.of_int 1));
      j <- (j + (W64.of_int 1));
    }
    return ();
  }
  
  proc __keccak_1600 (out:W64.t, outlen:W64.t, in_0:W64.t, inlen:W64.t,
                      trail_byte:W64.t, r64:W64.t) : unit = {
    
    var state:W64.t Array25.t;
    var rate:W64.t;
    var trailbyte:W8.t;
    state <- witness;
    state <@ st0 ();
    rate <- r64;
    
    while ((rate \ule inlen)) {
      state <@ add_full_block (state, in_0, rate);
      state <@ __keccak_f1600_ref (state);
      inlen <- (inlen - rate);
      in_0 <- (in_0 + rate);
      rate <- r64;
    }
    trailbyte <- (truncateu8 trail_byte);
    rate <- (rate `>>` (W8.of_int 3));
    state <@ add_final_block (state, in_0, inlen, trailbyte, rate);
    
    while ((rate \ult outlen)) {
      state <@ __keccak_f1600_ref (state);
      rate <- r64;
      xtr_full_block (state, out, rate);
      rate <- (rate `>>` (W8.of_int 3));
      outlen <- (outlen - rate);
      out <- (out + rate);
    }
    state <@ __keccak_f1600_ref (state);
    xtr_bytes (state, out, outlen);
    return ();
  }
}.


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
      (aux_1, aux_0, aux_2) <- x86_ROL_64 c.[((x + 1) %% 5)] (W8.of_int 1);
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
    constants <- witness;
    constants.[0] <- (W64.of_int 1);
    constants.[1] <- (W64.of_int 32898);
    constants.[2] <- (W64.of_int 9223372036854808714);
    constants.[3] <- (W64.of_int 9223372039002292224);
    constants.[4] <- (W64.of_int 32907);
    constants.[5] <- (W64.of_int 2147483649);
    constants.[6] <- (W64.of_int 9223372039002292353);
    constants.[7] <- (W64.of_int 9223372036854808585);
    constants.[8] <- (W64.of_int 138);
    constants.[9] <- (W64.of_int 136);
    constants.[10] <- (W64.of_int 2147516425);
    constants.[11] <- (W64.of_int 2147483658);
    constants.[12] <- (W64.of_int 2147516555);
    constants.[13] <- (W64.of_int 9223372036854775947);
    constants.[14] <- (W64.of_int 9223372036854808713);
    constants.[15] <- (W64.of_int 9223372036854808579);
    constants.[16] <- (W64.of_int 9223372036854808578);
    constants.[17] <- (W64.of_int 9223372036854775936);
    constants.[18] <- (W64.of_int 32778);
    constants.[19] <- (W64.of_int 9223372039002259466);
    constants.[20] <- (W64.of_int 9223372039002292353);
    constants.[21] <- (W64.of_int 9223372036854808704);
    constants.[22] <- (W64.of_int 2147483649);
    constants.[23] <- (W64.of_int 9223372039002292232);
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
}.


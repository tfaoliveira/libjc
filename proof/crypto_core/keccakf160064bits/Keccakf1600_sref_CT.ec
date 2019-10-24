require import List Int IntExtra IntDiv CoreMap.
from Jasmin require import JModel.

require import Array5 Array24 Array25.
require import WArray40 WArray192 WArray200.



module M = {
  var leakages : leakages_t
  
  proc index (x:int, y:int) : int = {
    var aux: int;
    
    var r:int;
    
    leakages <- LeakAddr([]) :: leakages;
    aux <- ((x %% 5) + (5 * (y %% 5)));
    r <- aux;
    return (r);
  }
  
  proc theta (a:W64.t Array25.t) : W64.t Array25.t = {
    var aux_2: bool;
    var aux_1: bool;
    var aux: int;
    var aux_0: W64.t;
    
    var x:int;
    var c:W64.t Array5.t;
    var y:int;
    var d:W64.t Array5.t;
    var  _0:bool;
    var  _1:bool;
    c <- witness;
    d <- witness;
    leakages <- LeakFor(0,5) :: LeakAddr([]) :: leakages;
    x <- 0;
    while (x < 5) {
      leakages <- LeakAddr([]) :: leakages;
      aux_0 <- (W64.of_int 0);
      leakages <- LeakAddr([x]) :: leakages;
      c.[x] <- aux_0;
      leakages <- LeakFor(0,5) :: LeakAddr([]) :: leakages;
      y <- 0;
      while (y < 5) {
        leakages <- LeakAddr([(x + (5 * y)); x]) :: leakages;
        aux_0 <- (c.[x] `^` a.[(x + (5 * y))]);
        leakages <- LeakAddr([x]) :: leakages;
        c.[x] <- aux_0;
        y <- y + 1;
      }
      x <- x + 1;
    }
    leakages <- LeakFor(0,5) :: LeakAddr([]) :: leakages;
    x <- 0;
    while (x < 5) {
      leakages <- LeakAddr([((x + 1) %% 5)]) :: leakages;
      aux_0 <- c.[((x + 1) %% 5)];
      leakages <- LeakAddr([x]) :: leakages;
      d.[x] <- aux_0;
      leakages <- LeakAddr([x]) :: leakages;
      (aux_2, aux_1, aux_0) <- x86_ROL_64 d.[x] (W8.of_int 1);
       _0 <- aux_2;
       _1 <- aux_1;
      leakages <- LeakAddr([x]) :: leakages;
      d.[x] <- aux_0;
      leakages <- LeakAddr([((x + 4) %% 5); x]) :: leakages;
      aux_0 <- (d.[x] `^` c.[((x + 4) %% 5)]);
      leakages <- LeakAddr([x]) :: leakages;
      d.[x] <- aux_0;
      x <- x + 1;
    }
    leakages <- LeakFor(0,5) :: LeakAddr([]) :: leakages;
    x <- 0;
    while (x < 5) {
      leakages <- LeakFor(0,5) :: LeakAddr([]) :: leakages;
      y <- 0;
      while (y < 5) {
        leakages <- LeakAddr([x; (x + (5 * y))]) :: leakages;
        aux_0 <- (a.[(x + (5 * y))] `^` d.[x]);
        leakages <- LeakAddr([(x + (5 * y))]) :: leakages;
        a.[(x + (5 * y))] <- aux_0;
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
    
    leakages <- LeakAddr([]) :: leakages;
    aux <- 0;
    r <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- 1;
    x <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- 0;
    y <- aux;
    leakages <- LeakFor(0,24) :: LeakAddr([]) :: leakages;
    t <- 0;
    while (t < 24) {
      leakages <- LeakCond((i = (x + (5 * y)))) :: LeakAddr([]) :: leakages;
      if ((i = (x + (5 * y)))) {
        leakages <- LeakAddr([]) :: leakages;
        aux <- ((((t + 1) * (t + 2)) %/ 2) %% 64);
        r <- aux;
      } else {
        
      }
      leakages <- LeakAddr([]) :: leakages;
      aux <- (((2 * x) + (3 * y)) %% 5);
      z <- aux;
      leakages <- LeakAddr([]) :: leakages;
      aux <- y;
      x <- aux;
      leakages <- LeakAddr([]) :: leakages;
      aux <- z;
      y <- aux;
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
    
    leakages <- LeakFor(0,5) :: LeakAddr([]) :: leakages;
    x <- 0;
    while (x < 5) {
      leakages <- LeakFor(0,5) :: LeakAddr([]) :: leakages;
      y <- 0;
      while (y < 5) {
        leakages <- LeakAddr([]) :: leakages;
        aux <@ index (x, y);
        i <- aux;
        leakages <- LeakAddr([]) :: leakages;
        aux <@ keccakRhoOffsets (i);
        z <- aux;
        leakages <- LeakAddr([i]) :: leakages;
        (aux_1, aux_0, aux_2) <- x86_ROL_64 a.[i] (W8.of_int z);
         _0 <- aux_1;
         _1 <- aux_0;
        leakages <- LeakAddr([i]) :: leakages;
        a.[i] <- aux_2;
        y <- y + 1;
      }
      x <- x + 1;
    }
    return (a);
  }
  
  proc pi (a:W64.t Array25.t) : W64.t Array25.t = {
    var aux: int;
    var aux_0: W64.t;
    
    var i:int;
    var t:W64.t;
    var b:W64.t Array25.t;
    var y:int;
    var x:int;
    b <- witness;
    leakages <- LeakFor(0,25) :: LeakAddr([]) :: leakages;
    i <- 0;
    while (i < 25) {
      leakages <- LeakAddr([i]) :: leakages;
      aux_0 <- a.[i];
      t <- aux_0;
      leakages <- LeakAddr([]) :: leakages;
      aux_0 <- t;
      leakages <- LeakAddr([i]) :: leakages;
      b.[i] <- aux_0;
      i <- i + 1;
    }
    leakages <- LeakFor(0,5) :: LeakAddr([]) :: leakages;
    x <- 0;
    while (x < 5) {
      leakages <- LeakFor(0,5) :: LeakAddr([]) :: leakages;
      y <- 0;
      while (y < 5) {
        leakages <- LeakAddr([(x + (5 * y))]) :: leakages;
        aux_0 <- b.[(x + (5 * y))];
        t <- aux_0;
        leakages <- LeakAddr([]) :: leakages;
        aux <@ index (y, ((2 * x) + (3 * y)));
        i <- aux;
        leakages <- LeakAddr([]) :: leakages;
        aux_0 <- t;
        leakages <- LeakAddr([i]) :: leakages;
        a.[i] <- aux_0;
        y <- y + 1;
      }
      x <- x + 1;
    }
    return (a);
  }
  
  proc chi (a:W64.t Array25.t) : W64.t Array25.t = {
    var aux: int;
    var aux_0: W64.t;
    
    var x:int;
    var y:int;
    var i:int;
    var c:W64.t Array5.t;
    c <- witness;
    leakages <- LeakFor(0,5) :: LeakAddr([]) :: leakages;
    y <- 0;
    while (y < 5) {
      leakages <- LeakFor(0,5) :: LeakAddr([]) :: leakages;
      x <- 0;
      while (x < 5) {
        leakages <- LeakAddr([]) :: leakages;
        aux <@ index ((x + 1), y);
        i <- aux;
        leakages <- LeakAddr([i]) :: leakages;
        aux_0 <- a.[i];
        leakages <- LeakAddr([x]) :: leakages;
        c.[x] <- aux_0;
        leakages <- LeakAddr([x]) :: leakages;
        aux_0 <- (invw c.[x]);
        leakages <- LeakAddr([x]) :: leakages;
        c.[x] <- aux_0;
        leakages <- LeakAddr([]) :: leakages;
        aux <@ index ((x + 2), y);
        i <- aux;
        leakages <- LeakAddr([i; x]) :: leakages;
        aux_0 <- (c.[x] `&` a.[i]);
        leakages <- LeakAddr([x]) :: leakages;
        c.[x] <- aux_0;
        leakages <- LeakAddr([]) :: leakages;
        aux <@ index (x, y);
        i <- aux;
        leakages <- LeakAddr([i; x]) :: leakages;
        aux_0 <- (c.[x] `^` a.[i]);
        leakages <- LeakAddr([x]) :: leakages;
        c.[x] <- aux_0;
        x <- x + 1;
      }
      leakages <- LeakFor(0,5) :: LeakAddr([]) :: leakages;
      x <- 0;
      while (x < 5) {
        leakages <- LeakAddr([x]) :: leakages;
        aux_0 <- c.[x];
        leakages <- LeakAddr([(x + (5 * y))]) :: leakages;
        a.[(x + (5 * y))] <- aux_0;
        x <- x + 1;
      }
      y <- y + 1;
    }
    return (a);
  }
  
  proc iota_0 (a:W64.t Array25.t, c:W64.t) : W64.t Array25.t = {
    var aux: W64.t;
    
    
    
    leakages <- LeakAddr([0]) :: leakages;
    aux <- (a.[0] `^` c);
    leakages <- LeakAddr([0]) :: leakages;
    a.[0] <- aux;
    return (a);
  }
  
  proc keccakP1600_round (state:W64.t Array25.t, c:W64.t) : W64.t Array25.t = {
    var aux: W64.t Array25.t;
    
    
    
    leakages <- LeakAddr([]) :: leakages;
    aux <@ theta (state);
    state <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <@ rho (state);
    state <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <@ pi (state);
    state <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <@ chi (state);
    state <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <@ iota_0 (state, c);
    state <- aux;
    return (state);
  }
  
  proc keccakRoundConstants () : W64.t Array24.t = {
    var aux: W64.t;
    
    var constants:W64.t Array24.t;
    var t:W64.t;
    constants <- witness;
    leakages <- LeakAddr([]) :: leakages;
    aux <- (W64.of_int 1);
    t <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- t;
    leakages <- LeakAddr([0]) :: leakages;
    constants.[0] <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- (W64.of_int 32898);
    t <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- t;
    leakages <- LeakAddr([1]) :: leakages;
    constants.[1] <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- (W64.of_int 9223372036854808714);
    t <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- t;
    leakages <- LeakAddr([2]) :: leakages;
    constants.[2] <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- (W64.of_int 9223372039002292224);
    t <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- t;
    leakages <- LeakAddr([3]) :: leakages;
    constants.[3] <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- (W64.of_int 32907);
    t <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- t;
    leakages <- LeakAddr([4]) :: leakages;
    constants.[4] <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- (W64.of_int 2147483649);
    t <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- t;
    leakages <- LeakAddr([5]) :: leakages;
    constants.[5] <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- (W64.of_int 9223372039002292353);
    t <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- t;
    leakages <- LeakAddr([6]) :: leakages;
    constants.[6] <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- (W64.of_int 9223372036854808585);
    t <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- t;
    leakages <- LeakAddr([7]) :: leakages;
    constants.[7] <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- (W64.of_int 138);
    t <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- t;
    leakages <- LeakAddr([8]) :: leakages;
    constants.[8] <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- (W64.of_int 136);
    t <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- t;
    leakages <- LeakAddr([9]) :: leakages;
    constants.[9] <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- (W64.of_int 2147516425);
    t <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- t;
    leakages <- LeakAddr([10]) :: leakages;
    constants.[10] <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- (W64.of_int 2147483658);
    t <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- t;
    leakages <- LeakAddr([11]) :: leakages;
    constants.[11] <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- (W64.of_int 2147516555);
    t <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- t;
    leakages <- LeakAddr([12]) :: leakages;
    constants.[12] <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- (W64.of_int 9223372036854775947);
    t <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- t;
    leakages <- LeakAddr([13]) :: leakages;
    constants.[13] <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- (W64.of_int 9223372036854808713);
    t <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- t;
    leakages <- LeakAddr([14]) :: leakages;
    constants.[14] <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- (W64.of_int 9223372036854808579);
    t <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- t;
    leakages <- LeakAddr([15]) :: leakages;
    constants.[15] <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- (W64.of_int 9223372036854808578);
    t <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- t;
    leakages <- LeakAddr([16]) :: leakages;
    constants.[16] <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- (W64.of_int 9223372036854775936);
    t <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- t;
    leakages <- LeakAddr([17]) :: leakages;
    constants.[17] <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- (W64.of_int 32778);
    t <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- t;
    leakages <- LeakAddr([18]) :: leakages;
    constants.[18] <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- (W64.of_int 9223372039002259466);
    t <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- t;
    leakages <- LeakAddr([19]) :: leakages;
    constants.[19] <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- (W64.of_int 9223372039002292353);
    t <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- t;
    leakages <- LeakAddr([20]) :: leakages;
    constants.[20] <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- (W64.of_int 9223372036854808704);
    t <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- t;
    leakages <- LeakAddr([21]) :: leakages;
    constants.[21] <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- (W64.of_int 2147483649);
    t <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- t;
    leakages <- LeakAddr([22]) :: leakages;
    constants.[22] <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- (W64.of_int 9223372039002292232);
    t <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- t;
    leakages <- LeakAddr([23]) :: leakages;
    constants.[23] <- aux;
    return (constants);
  }
  
  proc __keccakf1600_ref (state:W64.t Array25.t) : W64.t Array25.t = {
    var aux_0: int;
    var aux: W64.t Array24.t;
    var aux_1: W64.t Array25.t;
    
    var constants:W64.t Array24.t;
    var round:int;
    constants <- witness;
    leakages <- LeakAddr([]) :: leakages;
    aux <@ keccakRoundConstants ();
    constants <- aux;
    leakages <- LeakFor(0,24) :: LeakAddr([]) :: leakages;
    round <- 0;
    while (round < 24) {
      leakages <- LeakAddr([round]) :: leakages;
      aux_1 <@ keccakP1600_round (state, constants.[round]);
      state <- aux_1;
      round <- round + 1;
    }
    return (state);
  }
}.


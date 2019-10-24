require import List Int IntExtra IntDiv CoreMap.
from Jasmin require import JModel.

require import Array5 Array25.
require import WArray40 WArray200.



module M = {
  var leakages : leakages_t
  
  proc index (x:int, y:int) : int = {
    var aux: int;
    
    var r:int;
    
    leakages <- LeakAddr([]) :: leakages;
    aux <- ((5 * (x %% 5)) + (y %% 5));
    r <- aux;
    return (r);
  }
  
  proc keccak_rho_offsets (i:int) : int = {
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
  
  proc rhotates (x:int, y:int) : int = {
    var aux: int;
    
    var r:int;
    var i:int;
    
    leakages <- LeakAddr([]) :: leakages;
    aux <@ index (x, y);
    i <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <@ keccak_rho_offsets (i);
    r <- aux;
    return (r);
  }
  
  proc rOL64 (x:W64.t, c:int) : W64.t = {
    var aux_1: bool;
    var aux_0: bool;
    var aux: W64.t;
    
    var y:W64.t;
    var  _0:bool;
    var  _1:bool;
    
    leakages <- LeakCond((c = 0)) :: LeakAddr([]) :: leakages;
    if ((c = 0)) {
      leakages <- LeakAddr([]) :: leakages;
      aux <- x;
      y <- aux;
    } else {
      leakages <- LeakAddr([]) :: leakages;
      (aux_1, aux_0, aux) <- x86_ROL_64 x (W8.of_int c);
       _0 <- aux_1;
       _1 <- aux_0;
      y <- aux;
    }
    return (y);
  }
  
  proc theta_sum (a:W64.t Array25.t) : W64.t Array5.t = {
    var aux: int;
    var aux_0: W64.t;
    
    var c:W64.t Array5.t;
    var i:int;
    var j:int;
    c <- witness;
    leakages <- LeakFor(0,5) :: LeakAddr([]) :: leakages;
    i <- 0;
    while (i < 5) {
      leakages <- LeakAddr([((5 * (0 %% 5)) + (i %% 5))]) :: leakages;
      aux_0 <- a.[((5 * (0 %% 5)) + (i %% 5))];
      leakages <- LeakAddr([i]) :: leakages;
      c.[i] <- aux_0;
      i <- i + 1;
    }
    leakages <- LeakFor(1,5) :: LeakAddr([]) :: leakages;
    j <- 1;
    while (j < 5) {
      leakages <- LeakFor(0,5) :: LeakAddr([]) :: leakages;
      i <- 0;
      while (i < 5) {
        leakages <- LeakAddr([((5 * (j %% 5)) + (i %% 5)); i]) :: leakages;
        aux_0 <- (c.[i] `^` a.[((5 * (j %% 5)) + (i %% 5))]);
        leakages <- LeakAddr([i]) :: leakages;
        c.[i] <- aux_0;
        i <- i + 1;
      }
      j <- j + 1;
    }
    return (c);
  }
  
  proc theta_rol (c:W64.t Array5.t) : W64.t Array5.t = {
    var aux_2: bool;
    var aux_1: bool;
    var aux: int;
    var aux_0: W64.t;
    
    var d:W64.t Array5.t;
    var i:int;
    var  _0:bool;
    var  _1:bool;
    d <- witness;
    leakages <- LeakFor(0,5) :: LeakAddr([]) :: leakages;
    i <- 0;
    while (i < 5) {
      leakages <- LeakAddr([((i + 1) %% 5)]) :: leakages;
      aux_0 <- c.[((i + 1) %% 5)];
      leakages <- LeakAddr([i]) :: leakages;
      d.[i] <- aux_0;
      leakages <- LeakAddr([i]) :: leakages;
      (aux_2, aux_1, aux_0) <- x86_ROL_64 d.[i] (W8.of_int 1);
       _0 <- aux_2;
       _1 <- aux_1;
      leakages <- LeakAddr([i]) :: leakages;
      d.[i] <- aux_0;
      leakages <- LeakAddr([((i + 4) %% 5); i]) :: leakages;
      aux_0 <- (d.[i] `^` c.[((i + 4) %% 5)]);
      leakages <- LeakAddr([i]) :: leakages;
      d.[i] <- aux_0;
      i <- i + 1;
    }
    return (d);
  }
  
  proc rol_sum (d:W64.t Array5.t, a:W64.t Array25.t, offset:int) : W64.t Array5.t = {
    var aux: int;
    var aux_0: W64.t;
    
    var c:W64.t Array5.t;
    var j:int;
    var j1:int;
    var k:int;
    var t:W64.t;
    c <- witness;
    leakages <- LeakFor(0,5) :: LeakAddr([]) :: leakages;
    j <- 0;
    while (j < 5) {
      leakages <- LeakAddr([]) :: leakages;
      aux <- ((j + offset) %% 5);
      j1 <- aux;
      leakages <- LeakAddr([]) :: leakages;
      aux <@ rhotates (j, j1);
      k <- aux;
      leakages <- LeakAddr([((5 * (j %% 5)) + (j1 %% 5))]) :: leakages;
      aux_0 <- a.[((5 * (j %% 5)) + (j1 %% 5))];
      t <- aux_0;
      leakages <- LeakAddr([j1]) :: leakages;
      aux_0 <- (t `^` d.[j1]);
      t <- aux_0;
      leakages <- LeakAddr([]) :: leakages;
      aux_0 <@ rOL64 (t, k);
      t <- aux_0;
      leakages <- LeakAddr([]) :: leakages;
      aux_0 <- t;
      leakages <- LeakAddr([j]) :: leakages;
      c.[j] <- aux_0;
      j <- j + 1;
    }
    return (c);
  }
  
  proc set_row (r:W64.t Array25.t, row:int, c:W64.t Array5.t, iota_0:W64.t) : 
  W64.t Array25.t = {
    var aux: int;
    var aux_0: W64.t;
    
    var j:int;
    var j1:int;
    var j2:int;
    var t:W64.t;
    
    leakages <- LeakFor(0,5) :: LeakAddr([]) :: leakages;
    j <- 0;
    while (j < 5) {
      leakages <- LeakAddr([]) :: leakages;
      aux <- ((j + 1) %% 5);
      j1 <- aux;
      leakages <- LeakAddr([]) :: leakages;
      aux <- ((j + 2) %% 5);
      j2 <- aux;
      leakages <- LeakAddr([j2; j1]) :: leakages;
      aux_0 <- ((invw c.[j1]) `&` c.[j2]);
      t <- aux_0;
      leakages <- LeakCond(((row = 0) /\ (j = 0))) :: LeakAddr([]) :: leakages;
      if (((row = 0) /\ (j = 0))) {
        leakages <- LeakAddr([]) :: leakages;
        aux_0 <- (t `^` iota_0);
        t <- aux_0;
      } else {
        
      }
      leakages <- LeakAddr([j]) :: leakages;
      aux_0 <- (t `^` c.[j]);
      t <- aux_0;
      leakages <- LeakAddr([]) :: leakages;
      aux_0 <- t;
      leakages <- LeakAddr([((5 * (row %% 5)) + (j %% 5))]) :: leakages;
      r.[((5 * (row %% 5)) + (j %% 5))] <- aux_0;
      j <- j + 1;
    }
    return (r);
  }
  
  proc round2x (a:W64.t Array25.t, r:W64.t Array25.t, iotas:W64.t, o:int) : 
  W64.t Array25.t * W64.t Array25.t = {
    var aux: W64.t;
    var aux_0: W64.t Array5.t;
    var aux_1: W64.t Array25.t;
    
    var iota_0:W64.t;
    var c:W64.t Array5.t;
    var d:W64.t Array5.t;
    c <- witness;
    d <- witness;
    leakages <- LeakAddr([(W64.to_uint (iotas + (W64.of_int o)))]) :: leakages;
    aux <- (loadW64 Glob.mem (W64.to_uint (iotas + (W64.of_int o))));
    iota_0 <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <@ theta_sum (a);
    c <- aux_0;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <@ theta_rol (c);
    d <- aux_0;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <@ rol_sum (d, a, 0);
    c <- aux_0;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <@ set_row (r, 0, c, iota_0);
    r <- aux_1;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <@ rol_sum (d, a, 3);
    c <- aux_0;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <@ set_row (r, 1, c, iota_0);
    r <- aux_1;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <@ rol_sum (d, a, 1);
    c <- aux_0;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <@ set_row (r, 2, c, iota_0);
    r <- aux_1;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <@ rol_sum (d, a, 4);
    c <- aux_0;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <@ set_row (r, 3, c, iota_0);
    r <- aux_1;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <@ rol_sum (d, a, 2);
    c <- aux_0;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <@ set_row (r, 4, c, iota_0);
    r <- aux_1;
    return (a, r);
  }
  
  proc __keccakf1600_scalar (a:W64.t Array25.t, iotas:W64.t) : W64.t Array25.t *
                                                               W64.t = {
    var aux_6: bool;
    var aux_5: bool;
    var aux_4: bool;
    var aux_3: bool;
    var aux_2: bool;
    var aux_1: W64.t;
    var aux_0: W64.t Array25.t;
    var aux: W64.t Array25.t;
    
    var zf:bool;
    var r:W64.t Array25.t;
    var  _0:bool;
    var  _1:bool;
    var  _2:bool;
    var  _3:bool;
    r <- witness;
    leakages <- LeakAddr([]) :: leakages;
    (aux_0, aux) <@ round2x (a, r, iotas, 0);
    a <- aux_0;
    r <- aux;
    leakages <- LeakAddr([]) :: leakages;
    (aux_0, aux) <@ round2x (r, a, iotas, 8);
    r <- aux_0;
    a <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- (iotas + (W64.of_int 16));
    iotas <- aux_1;
    leakages <- LeakAddr([]) :: leakages;
    (aux_6, aux_5, aux_4, aux_3, aux_2) <- x86_TEST_8 (truncateu8 iotas)
    (W8.of_int 255);
     _0 <- aux_6;
     _1 <- aux_5;
     _2 <- aux_4;
     _3 <- aux_3;
    zf <- aux_2;
    leakages <- LeakCond((! zf)) :: LeakAddr([]) :: leakages;
    
    while ((! zf)) {
      leakages <- LeakAddr([]) :: leakages;
      (aux_0, aux) <@ round2x (a, r, iotas, 0);
      a <- aux_0;
      r <- aux;
      leakages <- LeakAddr([]) :: leakages;
      (aux_0, aux) <@ round2x (r, a, iotas, 8);
      r <- aux_0;
      a <- aux;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- (iotas + (W64.of_int 16));
      iotas <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      (aux_6, aux_5, aux_4, aux_3, aux_2) <- x86_TEST_8 (truncateu8 iotas)
      (W8.of_int 255);
       _0 <- aux_6;
       _1 <- aux_5;
       _2 <- aux_4;
       _3 <- aux_3;
      zf <- aux_2;
    leakages <- LeakCond((! zf)) :: LeakAddr([]) :: leakages;
    
    }
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- (iotas - (W64.of_int 192));
    iotas <- aux_1;
    return (a, iotas);
  }
}.


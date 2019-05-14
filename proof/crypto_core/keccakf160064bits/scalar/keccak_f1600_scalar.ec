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
  
  proc __keccak_f1600_scalar (a:W64.t Array25.t, iotas:W64.t) : W64.t Array25.t *
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
}.


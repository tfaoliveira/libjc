require import List Int IntExtra IntDiv CoreMap.
from Jasmin require import JModel.

require import Array5 Array25.
require import WArray40 WArray200.



module M = {
  proc rOL64 (x:W64.t, c:int) : W64.t = {
    
    var y:W64.t;
    var  _0:bool;
    var  _1:bool;
    
    ( _0,  _1, y) <- x86_ROL_64 x (W8.of_int c);
    return (y);
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
}.


require import List Jasmin_model Int IntDiv CoreMap.
require import Array3 Array8 Array16.
require import WArray12 WArray32 WArray64.



module M = {
  proc init (key:W64.t, nonce:W64.t, counter:W32.t) : W32.t Array16.t = {
    var aux: int;
    
    var st:W32.t Array16.t;
    var i:int;
    var k:W32.t Array8.t;
    var n:W32.t Array3.t;
    k <- witness;
    n <- witness;
    st <- witness;
    st.[0] <- (W32.of_int 1634760805);
    st.[1] <- (W32.of_int 857760878);
    st.[2] <- (W32.of_int 2036477234);
    st.[3] <- (W32.of_int 1797285236);
    i <- 0;
    while (i < 8) {
      k.[i] <- (loadW32 Glob.mem (W64.to_uint (key + (W64.of_int (4 * i)))));
      st.[(4 + i)] <- k.[i];
      i <- i + 1;
    }
    st.[12] <- counter;
    i <- 0;
    while (i < 3) {
      n.[i] <-
      (loadW32 Glob.mem (W64.to_uint (nonce + (W64.of_int (4 * i)))));
      st.[(13 + i)] <- n.[i];
      i <- i + 1;
    }
    return (st);
  }
  
  proc copy_state (st:W32.t Array16.t) : W32.t Array16.t * W32.t = {
    var aux: int;
    
    var k:W32.t Array16.t;
    var s_k15:W32.t;
    var k15:W32.t;
    var i:int;
    k <- witness;
    k15 <- st.[15];
    s_k15 <- k15;
    i <- 0;
    while (i < 15) {
      k.[i] <- st.[i];
      i <- i + 1;
    }
    return (k, s_k15);
  }
  
  proc line (k:W32.t Array16.t, a:int, b:int, c:int, r:int) : W32.t Array16.t = {
    var aux_0: bool;
    var aux: bool;
    var aux_1: W32.t;
    
    var  _0:bool;
    var  _1:bool;
    
    k.[a] <- (k.[a] + k.[b]);
    k.[c] <- (k.[c] `^` k.[a]);
    (aux_0, aux, aux_1) <- x86_ROL_32 k.[c] (W8.of_int r);
     _0 <- aux_0;
     _1 <- aux;
    k.[c] <- aux_1;
    return (k);
  }
  
  proc quarter_round (k:W32.t Array16.t, a:int, b:int, c:int, d:int) : 
  W32.t Array16.t = {
    
    
    
    k <@ line (k, a, b, d, 16);
    k <@ line (k, c, d, b, 12);
    k <@ line (k, a, b, d, 8);
    k <@ line (k, c, d, b, 7);
    return (k);
  }
  
  proc rounds (k:W32.t Array16.t, k15:W32.t) : W32.t Array16.t * W32.t = {
    
    var c:W32.t;
    var k14:W32.t;
    
    c <- (W32.of_int 0);
    
    while ((c \ult (W32.of_int 10))) {
      k <@ quarter_round (k, 0, 4, 8, 12);
      k <@ quarter_round (k, 2, 6, 10, 14);
      k14 <- k.[14];
      k.[15] <- k15;
      k <@ quarter_round (k, 1, 5, 9, 13);
      k <@ quarter_round (k, 3, 7, 11, 15);
      k <@ quarter_round (k, 1, 6, 11, 12);
      k <@ quarter_round (k, 0, 5, 10, 15);
      k15 <- k.[15];
      k.[14] <- k14;
      k <@ quarter_round (k, 2, 7, 8, 13);
      k <@ quarter_round (k, 3, 4, 9, 14);
      c <- (c + (W32.of_int 1));
    }
    return (k, k15);
  }
  
  proc sum_states (k:W32.t Array16.t, k15:W32.t, st:W32.t Array16.t) : 
  W32.t Array16.t * W32.t = {
    var aux: int;
    
    var i:int;
    var k14:W32.t;
    var t:W32.t;
    
    i <- 0;
    while (i < 15) {
      k.[i] <- (k.[i] + st.[i]);
      i <- i + 1;
    }
    k14 <- k.[14];
    t <- k15;
    t <- (t + st.[15]);
    k15 <- t;
    k.[14] <- k14;
    return (k, k15);
  }
  
  proc update_ptr (output:W64.t, plain:W64.t, len:W32.t, n:int) : W64.t *
                                                                  W64.t *
                                                                  W32.t = {
    
    
    
    output <- (output + (W64.of_int n));
    plain <- (plain + (W64.of_int n));
    len <- (len - (W32.of_int n));
    return (output, plain, len);
  }
  
  proc store (s_output:W64.t, s_plain:W64.t, s_len:W32.t, k:W32.t Array16.t,
              k15:W32.t) : W64.t * W64.t * W32.t = {
    var aux: int;
    
    var i:int;
    var s_k:W32.t Array3.t;
    var output:W64.t;
    var plain:W64.t;
    var len:W32.t;
    s_k <- witness;
    i <- 0;
    while (i < 3) {
      s_k.[i] <- k.[(12 + i)];
      i <- i + 1;
    }
    output <- s_output;
    plain <- s_plain;
    len <- s_len;
    i <- 0;
    while (i < 12) {
      k.[i] <-
      (k.[i] `^` (loadW32 Glob.mem (W64.to_uint (plain + (W64.of_int (4 * i))))));
      Glob.mem <-
      storeW32 Glob.mem (W64.to_uint (output + (W64.of_int (4 * i)))) 
      k.[i];
      i <- i + 1;
    }
    i <- 0;
    while (i < 3) {
      k.[(12 + i)] <- s_k.[i];
      i <- i + 1;
    }
    k.[15] <- k15;
    i <- 12;
    while (i < 16) {
      k.[i] <-
      (k.[i] `^` (loadW32 Glob.mem (W64.to_uint (plain + (W64.of_int (4 * i))))));
      Glob.mem <-
      storeW32 Glob.mem (W64.to_uint (output + (W64.of_int (4 * i)))) 
      k.[i];
      i <- i + 1;
    }
    (output, plain, len) <@ update_ptr (output, plain, len, 64);
    s_output <- output;
    s_plain <- plain;
    s_len <- len;
    return (s_output, s_plain, s_len);
  }
  
  proc store_last (s_output:W64.t, s_plain:W64.t, s_len:W32.t,
                   k:W32.t Array16.t, k15:W32.t) : unit = {
    var aux: int;
    
    var i:int;
    var s_k:W32.t Array16.t;
    var t:W32.t;
    var output:W64.t;
    var plain:W64.t;
    var len:W32.t;
    var j:W64.t;
    var pi:W8.t;
    s_k <- witness;
    i <- 0;
    while (i < 15) {
      s_k.[i] <- k.[i];
      i <- i + 1;
    }
    t <- k15;
    s_k.[15] <- t;
    output <- s_output;
    plain <- s_plain;
    len <- s_len;
    j <- (W64.of_int 0);
    
    while (((truncateu32 j) \ult len)) {
      pi <- (loadW8 Glob.mem (W64.to_uint (plain + j)));
      pi <-
      (pi `^` (get8 (WArray64.init32 (fun i => s_k.[i])) (W64.to_uint j)));
      Glob.mem <- storeW8 Glob.mem (W64.to_uint (output + j)) pi;
      j <- (j + (W64.of_int 1));
    }
    return ();
  }
  
  proc increment_counter (st:W32.t Array16.t) : W32.t Array16.t = {
    
    var t:W32.t;
    
    t <- (W32.of_int 1);
    t <- (t + st.[12]);
    st.[12] <- t;
    return (st);
  }
  
  proc chacha20_ref (output:W64.t, plain:W64.t, len:W32.t, key:W64.t,
                     nonce:W64.t, counter:W32.t) : unit = {
    
    var s_output:W64.t;
    var s_plain:W64.t;
    var s_len:W32.t;
    var st:W32.t Array16.t;
    var k:W32.t Array16.t;
    var k15:W32.t;
    k <- witness;
    st <- witness;
    s_output <- output;
    s_plain <- plain;
    s_len <- len;
    st <@ init (key, nonce, counter);
    
    while (((W32.of_int 64) \ule s_len)) {
      (k, k15) <@ copy_state (st);
      (k, k15) <@ rounds (k, k15);
      (k, k15) <@ sum_states (k, k15, st);
      (s_output, s_plain, s_len) <@ store (s_output, s_plain, s_len, k, k15);
      st <@ increment_counter (st);
    }
    if (((W32.of_int 0) \ult s_len)) {
      (k, k15) <@ copy_state (st);
      (k, k15) <@ rounds (k, k15);
      (k, k15) <@ sum_states (k, k15, st);
      store_last (s_output, s_plain, s_len, k, k15);
    } else {
      
    }
    return ();
  }
}.


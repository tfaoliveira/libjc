require import List Jasmin_model Int IntExtra IntDiv CoreMap.
require import Array3 Array8 Array16.
require import WArray12 WArray32 WArray64.



module M = {
  var leakages : leakages_t
  
  proc init (key:W64.t, nonce:W64.t, counter:W32.t) : W32.t Array16.t = {
    var aux_0: int;
    var aux: W32.t;
    
    var st:W32.t Array16.t;
    var i:int;
    var k:W32.t Array8.t;
    var n:W32.t Array3.t;
    k <- witness;
    n <- witness;
    st <- witness;
    leakages <- LeakAddr([]) :: leakages;
    aux <- (W32.of_int 1634760805);
    leakages <- LeakAddr([0]) :: leakages;
    st.[0] <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- (W32.of_int 857760878);
    leakages <- LeakAddr([1]) :: leakages;
    st.[1] <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- (W32.of_int 2036477234);
    leakages <- LeakAddr([2]) :: leakages;
    st.[2] <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- (W32.of_int 1797285236);
    leakages <- LeakAddr([3]) :: leakages;
    st.[3] <- aux;
    leakages <- LeakFor(0,8) :: LeakAddr([]) :: leakages;
    i <- 0;
    while (i < 8) {
      leakages <- LeakAddr([(W64.to_uint (key + (W64.of_int (4 * i))))]) :: leakages;
      aux <- (loadW32 Glob.mem (W64.to_uint (key + (W64.of_int (4 * i)))));
      leakages <- LeakAddr([i]) :: leakages;
      k.[i] <- aux;
      leakages <- LeakAddr([i]) :: leakages;
      aux <- k.[i];
      leakages <- LeakAddr([(4 + i)]) :: leakages;
      st.[(4 + i)] <- aux;
      i <- i + 1;
    }
    leakages <- LeakAddr([]) :: leakages;
    aux <- counter;
    leakages <- LeakAddr([12]) :: leakages;
    st.[12] <- aux;
    leakages <- LeakFor(0,3) :: LeakAddr([]) :: leakages;
    i <- 0;
    while (i < 3) {
      leakages <- LeakAddr([(W64.to_uint (nonce + (W64.of_int (4 * i))))]) :: leakages;
      aux <- (loadW32 Glob.mem (W64.to_uint (nonce + (W64.of_int (4 * i)))));
      leakages <- LeakAddr([i]) :: leakages;
      n.[i] <- aux;
      leakages <- LeakAddr([i]) :: leakages;
      aux <- n.[i];
      leakages <- LeakAddr([(13 + i)]) :: leakages;
      st.[(13 + i)] <- aux;
      i <- i + 1;
    }
    return (st);
  }
  
  proc copy_state (st:W32.t Array16.t) : W32.t Array16.t * W32.t = {
    var aux_0: int;
    var aux: W32.t;
    
    var k:W32.t Array16.t;
    var s_k15:W32.t;
    var k15:W32.t;
    var i:int;
    k <- witness;
    leakages <- LeakAddr([15]) :: leakages;
    aux <- st.[15];
    k15 <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- k15;
    s_k15 <- aux;
    leakages <- LeakFor(0,15) :: LeakAddr([]) :: leakages;
    i <- 0;
    while (i < 15) {
      leakages <- LeakAddr([i]) :: leakages;
      aux <- st.[i];
      leakages <- LeakAddr([i]) :: leakages;
      k.[i] <- aux;
      i <- i + 1;
    }
    return (k, s_k15);
  }
  
  proc line (k:W32.t Array16.t, a:int, b:int, c:int, r:int) : W32.t Array16.t = {
    var aux_1: bool;
    var aux_0: bool;
    var aux: W32.t;
    
    var  _0:bool;
    var  _1:bool;
    
    leakages <- LeakAddr([b; a]) :: leakages;
    aux <- (k.[a] + k.[b]);
    leakages <- LeakAddr([a]) :: leakages;
    k.[a] <- aux;
    leakages <- LeakAddr([a; c]) :: leakages;
    aux <- (k.[c] `^` k.[a]);
    leakages <- LeakAddr([c]) :: leakages;
    k.[c] <- aux;
    leakages <- LeakAddr([c]) :: leakages;
    (aux_1, aux_0, aux) <- x86_ROL_32 k.[c] (W8.of_int r);
     _0 <- aux_1;
     _1 <- aux_0;
    leakages <- LeakAddr([c]) :: leakages;
    k.[c] <- aux;
    return (k);
  }
  
  proc quarter_round (k:W32.t Array16.t, a:int, b:int, c:int, d:int) : 
  W32.t Array16.t = {
    var aux: W32.t Array16.t;
    
    
    
    leakages <- LeakAddr([]) :: leakages;
    aux <@ line (k, a, b, d, 16);
    k <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <@ line (k, c, d, b, 12);
    k <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <@ line (k, a, b, d, 8);
    k <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <@ line (k, c, d, b, 7);
    k <- aux;
    return (k);
  }
  
  proc rounds (k:W32.t Array16.t, k15:W32.t) : W32.t Array16.t * W32.t = {
    var aux: W32.t;
    var aux_0: W32.t Array16.t;
    
    var c:W32.t;
    var k14:W32.t;
    
    leakages <- LeakAddr([]) :: leakages;
    aux <- (W32.of_int 0);
    c <- aux;
    
    leakages <- LeakCond((c \ult (W32.of_int 10))) :: LeakAddr([]) :: leakages;
    
    while ((c \ult (W32.of_int 10))) {
      leakages <- LeakAddr([]) :: leakages;
      aux_0 <@ quarter_round (k, 0, 4, 8, 12);
      k <- aux_0;
      leakages <- LeakAddr([]) :: leakages;
      aux_0 <@ quarter_round (k, 2, 6, 10, 14);
      k <- aux_0;
      leakages <- LeakAddr([14]) :: leakages;
      aux <- k.[14];
      k14 <- aux;
      leakages <- LeakAddr([]) :: leakages;
      aux <- k15;
      leakages <- LeakAddr([15]) :: leakages;
      k.[15] <- aux;
      leakages <- LeakAddr([]) :: leakages;
      aux_0 <@ quarter_round (k, 1, 5, 9, 13);
      k <- aux_0;
      leakages <- LeakAddr([]) :: leakages;
      aux_0 <@ quarter_round (k, 3, 7, 11, 15);
      k <- aux_0;
      leakages <- LeakAddr([]) :: leakages;
      aux_0 <@ quarter_round (k, 1, 6, 11, 12);
      k <- aux_0;
      leakages <- LeakAddr([]) :: leakages;
      aux_0 <@ quarter_round (k, 0, 5, 10, 15);
      k <- aux_0;
      leakages <- LeakAddr([15]) :: leakages;
      aux <- k.[15];
      k15 <- aux;
      leakages <- LeakAddr([]) :: leakages;
      aux <- k14;
      leakages <- LeakAddr([14]) :: leakages;
      k.[14] <- aux;
      leakages <- LeakAddr([]) :: leakages;
      aux_0 <@ quarter_round (k, 2, 7, 8, 13);
      k <- aux_0;
      leakages <- LeakAddr([]) :: leakages;
      aux_0 <@ quarter_round (k, 3, 4, 9, 14);
      k <- aux_0;
      leakages <- LeakAddr([]) :: leakages;
      aux <- (c + (W32.of_int 1));
      c <- aux;
    leakages <- LeakCond((c \ult (W32.of_int 10))) :: LeakAddr([]) :: leakages;
    
    }
    return (k, k15);
  }
  
  proc sum_states (k:W32.t Array16.t, k15:W32.t, st:W32.t Array16.t) : 
  W32.t Array16.t * W32.t = {
    var aux: int;
    var aux_0: W32.t;
    
    var i:int;
    var k14:W32.t;
    var t:W32.t;
    
    leakages <- LeakFor(0,15) :: LeakAddr([]) :: leakages;
    i <- 0;
    while (i < 15) {
      leakages <- LeakAddr([i; i]) :: leakages;
      aux_0 <- (k.[i] + st.[i]);
      leakages <- LeakAddr([i]) :: leakages;
      k.[i] <- aux_0;
      i <- i + 1;
    }
    leakages <- LeakAddr([14]) :: leakages;
    aux_0 <- k.[14];
    k14 <- aux_0;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <- k15;
    t <- aux_0;
    leakages <- LeakAddr([15]) :: leakages;
    aux_0 <- (t + st.[15]);
    t <- aux_0;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <- t;
    k15 <- aux_0;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <- k14;
    leakages <- LeakAddr([14]) :: leakages;
    k.[14] <- aux_0;
    return (k, k15);
  }
  
  proc update_ptr (output:W64.t, plain:W64.t, len:W32.t, n:int) : W64.t *
                                                                  W64.t *
                                                                  W32.t = {
    var aux_0: W32.t;
    var aux: W64.t;
    
    
    
    leakages <- LeakAddr([]) :: leakages;
    aux <- (output + (W64.of_int n));
    output <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- (plain + (W64.of_int n));
    plain <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <- (len - (W32.of_int n));
    len <- aux_0;
    return (output, plain, len);
  }
  
  proc store (s_output:W64.t, s_plain:W64.t, s_len:W32.t, k:W32.t Array16.t,
              k15:W32.t) : W64.t * W64.t * W32.t = {
    var aux_1: int;
    var aux_2: W32.t;
    var aux_3: W64.t;
    var aux_0: W64.t;
    
    var kk:W64.t Array8.t;
    var aux:W64.t;
    var plain:W64.t;
    var output:W64.t;
    var i:int;
    var len:W32.t;
    kk <- witness;
    leakages <- LeakAddr([1]) :: leakages;
    aux_3 <- (zeroextu64 k.[1]);
    leakages <- LeakAddr([0]) :: leakages;
    kk.[0] <- aux_3;
    leakages <- LeakAddr([0]) :: leakages;
    aux_3 <- (kk.[0] `<<` (W8.of_int 32));
    leakages <- LeakAddr([0]) :: leakages;
    kk.[0] <- aux_3;
    leakages <- LeakAddr([0]) :: leakages;
    aux_3 <- (zeroextu64 k.[0]);
    aux <- aux_3;
    leakages <- LeakAddr([0]) :: leakages;
    aux_3 <- (kk.[0] `^` aux);
    leakages <- LeakAddr([0]) :: leakages;
    kk.[0] <- aux_3;
    leakages <- LeakAddr([]) :: leakages;
    aux_3 <- s_plain;
    plain <- aux_3;
    leakages <- LeakAddr([(W64.to_uint (plain + (W64.of_int (8 * 0)))); 0]) :: leakages;
    aux_3 <- (kk.[0] `^` (loadW64 Glob.mem (W64.to_uint (plain + (W64.of_int (8 * 0))))));
    leakages <- LeakAddr([0]) :: leakages;
    kk.[0] <- aux_3;
    leakages <- LeakAddr([3]) :: leakages;
    aux_3 <- (zeroextu64 k.[3]);
    leakages <- LeakAddr([1]) :: leakages;
    kk.[1] <- aux_3;
    leakages <- LeakAddr([1]) :: leakages;
    aux_3 <- (kk.[1] `<<` (W8.of_int 32));
    leakages <- LeakAddr([1]) :: leakages;
    kk.[1] <- aux_3;
    leakages <- LeakAddr([2]) :: leakages;
    aux_3 <- (zeroextu64 k.[2]);
    aux <- aux_3;
    leakages <- LeakAddr([1]) :: leakages;
    aux_3 <- (kk.[1] `^` aux);
    leakages <- LeakAddr([1]) :: leakages;
    kk.[1] <- aux_3;
    leakages <- LeakAddr([(W64.to_uint (plain + (W64.of_int (8 * 1)))); 1]) :: leakages;
    aux_3 <- (kk.[1] `^` (loadW64 Glob.mem (W64.to_uint (plain + (W64.of_int (8 * 1))))));
    leakages <- LeakAddr([1]) :: leakages;
    kk.[1] <- aux_3;
    leakages <- LeakAddr([]) :: leakages;
    aux_3 <- s_output;
    output <- aux_3;
    leakages <- LeakAddr([0]) :: leakages;
    aux_3 <- kk.[0];
    leakages <- LeakAddr([(W64.to_uint (output + (W64.of_int (8 * 0))))]) :: leakages;
    Glob.mem <-
    storeW64 Glob.mem (W64.to_uint (output + (W64.of_int (8 * 0)))) aux_3;
    leakages <- LeakFor(2,8) :: LeakAddr([]) :: leakages;
    i <- 2;
    while (i < 8) {
      leakages <- LeakAddr([((2 * i) + 1)]) :: leakages;
      aux_3 <- (zeroextu64 ((i = 7) ? k15 : k.[((2 * i) + 1)]));
      leakages <- LeakAddr([i]) :: leakages;
      kk.[i] <- aux_3;
      leakages <- LeakAddr([i]) :: leakages;
      aux_3 <- (kk.[i] `<<` (W8.of_int 32));
      leakages <- LeakAddr([i]) :: leakages;
      kk.[i] <- aux_3;
      leakages <- LeakAddr([(2 * i)]) :: leakages;
      aux_3 <- (zeroextu64 k.[(2 * i)]);
      aux <- aux_3;
      leakages <- LeakAddr([i]) :: leakages;
      aux_3 <- (kk.[i] `^` aux);
      leakages <- LeakAddr([i]) :: leakages;
      kk.[i] <- aux_3;
      leakages <- LeakAddr([(W64.to_uint (plain + (W64.of_int (8 * i)))); i]) :: leakages;
      aux_3 <- (kk.[i] `^` (loadW64 Glob.mem (W64.to_uint (plain + (W64.of_int (8 * i))))));
      leakages <- LeakAddr([i]) :: leakages;
      kk.[i] <- aux_3;
      leakages <- LeakAddr([(i - 1)]) :: leakages;
      aux_3 <- kk.[(i - 1)];
      leakages <- LeakAddr([(W64.to_uint (output + (W64.of_int (8 * (i - 1)))))]) :: leakages;
      Glob.mem <-
      storeW64 Glob.mem (W64.to_uint (output + (W64.of_int (8 * (i - 1))))) aux_3;
      i <- i + 1;
    }
    leakages <- LeakAddr([7]) :: leakages;
    aux_3 <- kk.[7];
    leakages <- LeakAddr([(W64.to_uint (output + (W64.of_int (8 * 7))))]) :: leakages;
    Glob.mem <-
    storeW64 Glob.mem (W64.to_uint (output + (W64.of_int (8 * 7)))) aux_3;
    leakages <- LeakAddr([]) :: leakages;
    aux_2 <- s_len;
    len <- aux_2;
    leakages <- LeakAddr([]) :: leakages;
    (aux_3, aux_0, aux_2) <@ update_ptr (output, plain, len, 64);
    output <- aux_3;
    plain <- aux_0;
    len <- aux_2;
    leakages <- LeakAddr([]) :: leakages;
    aux_3 <- output;
    s_output <- aux_3;
    leakages <- LeakAddr([]) :: leakages;
    aux_3 <- plain;
    s_plain <- aux_3;
    leakages <- LeakAddr([]) :: leakages;
    aux_2 <- len;
    s_len <- aux_2;
    return (s_output, s_plain, s_len);
  }
  
  proc store_last (s_output:W64.t, s_plain:W64.t, s_len:W32.t,
                   k:W32.t Array16.t, k15:W32.t) : unit = {
    var aux: int;
    var aux_2: W8.t;
    var aux_0: W32.t;
    var aux_1: W64.t;
    
    var i:int;
    var s_k:W32.t Array16.t;
    var u:W32.t;
    var output:W64.t;
    var plain:W64.t;
    var len:W32.t;
    var len8:W32.t;
    var j:W64.t;
    var t:W64.t;
    var pi:W8.t;
    s_k <- witness;
    leakages <- LeakFor(0,15) :: LeakAddr([]) :: leakages;
    i <- 0;
    while (i < 15) {
      leakages <- LeakAddr([i]) :: leakages;
      aux_0 <- k.[i];
      leakages <- LeakAddr([i]) :: leakages;
      s_k.[i] <- aux_0;
      i <- i + 1;
    }
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <- k15;
    u <- aux_0;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <- u;
    leakages <- LeakAddr([15]) :: leakages;
    s_k.[15] <- aux_0;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- s_output;
    output <- aux_1;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- s_plain;
    plain <- aux_1;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <- s_len;
    len <- aux_0;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <- len;
    len8 <- aux_0;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <- (len8 `>>` (W8.of_int 3));
    len8 <- aux_0;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- (W64.of_int 0);
    j <- aux_1;
    
    leakages <- LeakCond(((truncateu32 j) \ult len8)) :: LeakAddr([]) :: leakages;
    
    while (((truncateu32 j) \ult len8)) {
      leakages <- LeakAddr([(W64.to_uint (plain + ((W64.of_int 8) * j)))]) :: leakages;
      aux_1 <- (loadW64 Glob.mem (W64.to_uint (plain + ((W64.of_int 8) * j))));
      t <- aux_1;
      leakages <- LeakAddr([(W64.to_uint j)]) :: leakages;
      aux_1 <- (t `^` (get64 (WArray64.init32 (fun i => s_k.[i]))
                      (W64.to_uint j)));
      t <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- t;
      leakages <- LeakAddr([(W64.to_uint (output + ((W64.of_int 8) * j)))]) :: leakages;
      Glob.mem <-
      storeW64 Glob.mem (W64.to_uint (output + ((W64.of_int 8) * j))) aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- (j + (W64.of_int 1));
      j <- aux_1;
    leakages <- LeakCond(((truncateu32 j) \ult len8)) :: LeakAddr([]) :: leakages;
    
    }
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- (j `<<` (W8.of_int 3));
    j <- aux_1;
    
    leakages <- LeakCond(((truncateu32 j) \ult len)) :: LeakAddr([]) :: leakages;
    
    while (((truncateu32 j) \ult len)) {
      leakages <- LeakAddr([(W64.to_uint (plain + j))]) :: leakages;
      aux_2 <- (loadW8 Glob.mem (W64.to_uint (plain + j)));
      pi <- aux_2;
      leakages <- LeakAddr([(W64.to_uint j)]) :: leakages;
      aux_2 <- (pi `^` (get8 (WArray64.init32 (fun i => s_k.[i]))
                       (W64.to_uint j)));
      pi <- aux_2;
      leakages <- LeakAddr([]) :: leakages;
      aux_2 <- pi;
      leakages <- LeakAddr([(W64.to_uint (output + j))]) :: leakages;
      Glob.mem <- storeW8 Glob.mem (W64.to_uint (output + j)) aux_2;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- (j + (W64.of_int 1));
      j <- aux_1;
    leakages <- LeakCond(((truncateu32 j) \ult len)) :: LeakAddr([]) :: leakages;
    
    }
    return ();
  }
  
  proc increment_counter (st:W32.t Array16.t) : W32.t Array16.t = {
    var aux: W32.t;
    
    var t:W32.t;
    
    leakages <- LeakAddr([]) :: leakages;
    aux <- (W32.of_int 1);
    t <- aux;
    leakages <- LeakAddr([12]) :: leakages;
    aux <- (t + st.[12]);
    t <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- t;
    leakages <- LeakAddr([12]) :: leakages;
    st.[12] <- aux;
    return (st);
  }
  
  proc chacha20_ref (output:W64.t, plain:W64.t, len:W32.t, key:W64.t,
                     nonce:W64.t, counter:W32.t) : unit = {
    var aux_0: W32.t;
    var aux_2: W64.t;
    var aux: W64.t;
    var aux_1: W32.t Array16.t;
    
    var s_output:W64.t;
    var s_plain:W64.t;
    var s_len:W32.t;
    var st:W32.t Array16.t;
    var k:W32.t Array16.t;
    var k15:W32.t;
    k <- witness;
    st <- witness;
    leakages <- LeakAddr([]) :: leakages;
    aux_2 <- output;
    s_output <- aux_2;
    leakages <- LeakAddr([]) :: leakages;
    aux_2 <- plain;
    s_plain <- aux_2;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <- len;
    s_len <- aux_0;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <@ init (key, nonce, counter);
    st <- aux_1;
    
    leakages <- LeakCond(((W32.of_int 64) \ule s_len)) :: LeakAddr([]) :: leakages;
    
    while (((W32.of_int 64) \ule s_len)) {
      leakages <- LeakAddr([]) :: leakages;
      (aux_1, aux_0) <@ copy_state (st);
      k <- aux_1;
      k15 <- aux_0;
      leakages <- LeakAddr([]) :: leakages;
      (aux_1, aux_0) <@ rounds (k, k15);
      k <- aux_1;
      k15 <- aux_0;
      leakages <- LeakAddr([]) :: leakages;
      (aux_1, aux_0) <@ sum_states (k, k15, st);
      k <- aux_1;
      k15 <- aux_0;
      leakages <- LeakAddr([]) :: leakages;
      (aux_2, aux, aux_0) <@ store (s_output, s_plain, s_len, k, k15);
      s_output <- aux_2;
      s_plain <- aux;
      s_len <- aux_0;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <@ increment_counter (st);
      st <- aux_1;
    leakages <- LeakCond(((W32.of_int 64) \ule s_len)) :: LeakAddr([]) :: leakages;
    
    }
    leakages <- LeakCond(((W32.of_int 0) \ult s_len)) :: LeakAddr([]) :: leakages;
    if (((W32.of_int 0) \ult s_len)) {
      leakages <- LeakAddr([]) :: leakages;
      (aux_1, aux_0) <@ copy_state (st);
      k <- aux_1;
      k15 <- aux_0;
      leakages <- LeakAddr([]) :: leakages;
      (aux_1, aux_0) <@ rounds (k, k15);
      k <- aux_1;
      k15 <- aux_0;
      leakages <- LeakAddr([]) :: leakages;
      (aux_1, aux_0) <@ sum_states (k, k15, st);
      k <- aux_1;
      k15 <- aux_0;
      leakages <- LeakAddr([]) :: leakages;
      store_last (s_output, s_plain, s_len, k, k15);
    } else {
      
    }
    return ();
  }
}.


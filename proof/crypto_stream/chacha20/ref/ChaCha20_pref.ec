require import List Jasmin_model Int IntDiv CoreMap.
require import Array16.
require import WArray64.



module M = {
  proc init (key:W64.t, nonce:W64.t, counter:W32.t) : W32.t Array16.t = {
    var aux: int;
    
    var st:W32.t Array16.t;
    var i:int;
    st <- witness;
    st.[0] <- (W32.of_int 1634760805);
    st.[1] <- (W32.of_int 857760878);
    st.[2] <- (W32.of_int 2036477234);
    st.[3] <- (W32.of_int 1797285236);
    i <- 0;
    while (i < 8) {
      st.[(4 + i)] <- (loadW32 Glob.mem (key + (W64.of_int (4 * i))));
      i <- i + 1;
    }
    st.[12] <- counter;
    i <- 0;
    while (i < 3) {
      st.[(13 + i)] <- (loadW32 Glob.mem (nonce + (W64.of_int (4 * i))));
      i <- i + 1;
    }
    return (st);
  }
  
  proc copy_state (st:W32.t Array16.t) : W32.t Array16.t = {
    
    var k:W32.t Array16.t;
    k <- witness;
    k <- st;
    return (k);
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
  
  proc column_round (k:W32.t Array16.t) : W32.t Array16.t = {
    
    
    
    k <@ quarter_round (k, 0, 4, 8, 12);
    k <@ quarter_round (k, 2, 6, 10, 14);
    k <@ quarter_round (k, 1, 5, 9, 13);
    k <@ quarter_round (k, 3, 7, 11, 15);
    return (k);
  }
  
  proc diagonal_round (k:W32.t Array16.t) : W32.t Array16.t = {
    
    
    
    k <@ quarter_round (k, 1, 6, 11, 12);
    k <@ quarter_round (k, 0, 5, 10, 15);
    k <@ quarter_round (k, 2, 7, 8, 13);
    k <@ quarter_round (k, 3, 4, 9, 14);
    return (k);
  }
  
  proc round (k:W32.t Array16.t) : W32.t Array16.t = {
    
    
    
    k <@ column_round (k);
    k <@ diagonal_round (k);
    return (k);
  }
  
  proc rounds (k:W32.t Array16.t) : W32.t Array16.t = {
    
    var c:W32.t;
    
    c <- (W32.of_int 0);
    
    while ((c \ult (W32.of_int 10))) {
      k <@ round (k);
      c <- (c + (W32.of_int 1));
    }
    return (k);
  }
  
  proc sum_states (k:W32.t Array16.t, st:W32.t Array16.t) : W32.t Array16.t = {
    var aux: int;
    
    var i:int;
    
    i <- 0;
    while (i < 16) {
      k.[i] <- (k.[i] + st.[i]);
      i <- i + 1;
    }
    return (k);
  }
  
  proc update_ptr (output:W64.t, plain:W64.t, len:W32.t, n:int) : W64.t *
                                                                  W64.t *
                                                                  W32.t = {
    
    
    
    output <- (output + (W64.of_int n));
    plain <- (plain + (W64.of_int n));
    len <- (len - (W32.of_int n));
    return (output, plain, len);
  }
  
  proc store (output:W64.t, plain:W64.t, len:W32.t, k:W32.t Array16.t) : 
  W64.t * W64.t * W32.t = {
    
    var i:int;
    
    i <- 0;
    
    while ((((W32.of_int i) \ult len) /\ (i < 64))) {
      Glob.mem <-
      storeW8 Glob.mem (output + (W64.of_int i)) ((get8
                                                  (WArray64.init32 (fun i => k.[i]))
                                                  i) `^` (loadW8 Glob.mem (plain + (W64.of_int i))));
      i <- (i + 1);
    }
    (output, plain, len) <@ update_ptr (output, plain, len, i);
    return (output, plain, len);
  }
  
  proc increment_counter (st:W32.t Array16.t) : W32.t Array16.t = {
    
    
    
    st.[12] <- (st.[12] + (W32.of_int 1));
    return (st);
  }
  
  proc chacha20_ref (output:W64.t, plain:W64.t, len:W32.t, key:W64.t,
                     nonce:W64.t, counter:W32.t) : unit = {
    
    var st:W32.t Array16.t;
    var k:W32.t Array16.t;
    k <- witness;
    st <- witness;
    st <@ init (key, nonce, counter);
    
    while (((W32.of_int 0) \ult len)) {
      k <@ copy_state (st);
      k <@ rounds (k);
      k <@ sum_states (k, st);
      (output, plain, len) <@ store (output, plain, len, k);
      st <@ increment_counter (st);
    }
    return ();
  }
}.


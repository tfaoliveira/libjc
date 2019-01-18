require import List Jasmin_model Int IntDiv CoreMap.
require import Array16.
require import WArray64.
require import ChaCha20_pref.

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
    
  proc store_last (output:W64.t, plain:W64.t, len:W32.t, k:W32.t Array16.t) : unit = {
    
    var s_k:W32.t Array16.t;
    var j:W64.t;
    var pi:W8.t;
    s_k <- witness;
    s_k <- k;
    j <- (W64.of_int 0);
    
    while (((truncateu32 j) \ult len)) {
      pi <- (loadW8 Glob.mem (plain + j));
      pi <-
      (pi `^` (get8 (WArray64.init32 (fun i => s_k.[i])) (W64.to_uint j)));
      Glob.mem <- storeW8 Glob.mem (output + j) pi;
      j <- (j + (W64.of_int 1));
    }
    return ();
  }
  
  proc store_x2 (output:W64.t, plain:W64.t, len:W32.t, k_1:W32.t Array16.t,
                 k_2:W32.t Array16.t) : W64.t * W64.t * W32.t = {
    
    
    
    (output, plain, len) <@ ChaCha20_pref.M.store32 (output, plain, len, k_1);
    (output, plain, len) <@ ChaCha20_pref.M.store32 (output, plain, len, k_2);
    return (output, plain, len);
  }
  
  proc store_x2_last (output:W64.t, plain:W64.t, len:W32.t,
                      k_1:W32.t Array16.t, k_2:W32.t Array16.t) : unit = {
    
    var r:W32.t Array16.t;
    r <- witness;
    r <- k_1;
    if (((W32.of_int 64) \ule len)) {
      (output, plain, len) <@ ChaCha20_pref.M.store32 (output, plain, len, r);
      r <- k_2;
    } else {
      
    }
    store_last (output, plain, len, r);
    return ();
  }
  
  proc store_x4 (output:W64.t, plain:W64.t, len:W32.t, k_1:W32.t Array16.t,
                 k_2:W32.t Array16.t, k_3:W32.t Array16.t,
                 k_4:W32.t Array16.t) : W64.t * W64.t * W32.t = {
    
    
    
    (output, plain, len) <@ ChaCha20_pref.M.store32 (output, plain, len, k_1);
    (output, plain, len) <@ ChaCha20_pref.M.store32 (output, plain, len, k_2);
    (output, plain, len) <@ ChaCha20_pref.M.store32 (output, plain, len, k_3);
    (output, plain, len) <@ ChaCha20_pref.M.store32 (output, plain, len, k_4);
    return (output, plain, len);
  }
  
  proc store_x4_last (output:W64.t, plain:W64.t, len:W32.t,
                      k_1:W32.t Array16.t, k_2:W32.t Array16.t,
                      k_3:W32.t Array16.t, k_4:W32.t Array16.t) : unit = {
    
    var r_1:W32.t Array16.t;
    var r_2:W32.t Array16.t;
    r_1 <- witness;
    r_2 <- witness;
    r_1 <- k_1;
    r_2 <- k_2;
    if (((W32.of_int 128) \ule len)) {
      (output, plain, len) <@ store_x2 (output, plain, len, r_1, r_2);
      r_1 <- k_3;
      r_2 <- k_4;
    } else {
      
    }
    store_x2_last (output, plain, len, r_1, r_2);
    return ();
  }
  
  proc store_x8 (output:W64.t, plain:W64.t, len:W32.t, k_1:W32.t Array16.t,
                 k_2:W32.t Array16.t, k_3:W32.t Array16.t,
                 k_4:W32.t Array16.t, k_5:W32.t Array16.t,
                 k_6:W32.t Array16.t, k_7:W32.t Array16.t,
                 k_8:W32.t Array16.t) : W64.t * W64.t * W32.t = {
    
    
    
    (output, plain, len) <@ ChaCha20_pref.M.store32 (output, plain, len, k_1);
    (output, plain, len) <@ ChaCha20_pref.M.store32 (output, plain, len, k_2);
    (output, plain, len) <@ ChaCha20_pref.M.store32 (output, plain, len, k_3);
    (output, plain, len) <@ ChaCha20_pref.M.store32 (output, plain, len, k_4);
    (output, plain, len) <@ ChaCha20_pref.M.store32 (output, plain, len, k_5);
    (output, plain, len) <@ ChaCha20_pref.M.store32 (output, plain, len, k_6);
    (output, plain, len) <@ ChaCha20_pref.M.store32 (output, plain, len, k_7);
    (output, plain, len) <@ ChaCha20_pref.M.store32 (output, plain, len, k_8);
    return (output, plain, len);
  }
  
  proc store_x8_last (output:W64.t, plain:W64.t, len:W32.t,
                      k_1:W32.t Array16.t, k_2:W32.t Array16.t,
                      k_3:W32.t Array16.t, k_4:W32.t Array16.t,
                      k_5:W32.t Array16.t, k_6:W32.t Array16.t,
                      k_7:W32.t Array16.t, k_8:W32.t Array16.t) : unit = {
    
    var r_1:W32.t Array16.t;
    var r_2:W32.t Array16.t;
    var r_3:W32.t Array16.t;
    var r_4:W32.t Array16.t;
    r_1 <- witness;
    r_2 <- witness;
    r_3 <- witness;
    r_4 <- witness;
    r_1 <- k_1;
    r_2 <- k_2;
    r_3 <- k_3;
    r_4 <- k_4;
    if (((W32.of_int 256) \ule len)) {
      (output, plain, len) <@ store_x4 (output, plain, len, r_1, r_2, r_3,
      r_4);
      r_1 <- k_5;
      r_2 <- k_6;
      r_3 <- k_7;
      r_4 <- k_8;
    } else {
      
    }
    store_x4_last (output, plain, len, r_1, r_2, r_3, r_4);
    return ();
  }
  
  proc increment_counter (st:W32.t Array16.t) : W32.t Array16.t = {
    
    
    
    st.[12] <- (st.[12] + (W32.of_int 1));
    return (st);
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
  
  proc round (k:W32.t Array16.t) : W32.t Array16.t = {
    k <@ quarter_round (k, 0, 4, 8, 12);
    k <@ quarter_round (k, 2, 6, 10, 14);
    k <@ quarter_round (k, 1, 5, 9, 13);
    k <@ quarter_round (k, 3, 7, 11, 15);
    k <@ quarter_round (k, 1, 6, 11, 12);
    k <@ quarter_round (k, 0, 5, 10, 15);
    k <@ quarter_round (k, 2, 7, 8, 13);
    k <@ quarter_round (k, 3, 4, 9, 14);
    return k;
  }

  proc rounds (k:W32.t Array16.t) : W32.t Array16.t = {
    
    var c:W32.t;
    
    c <- (W32.of_int 0);
    
    while ((c \ult (W32.of_int 10))) {
      k <@ round(k);
      c <- (c + (W32.of_int 1));
    }
    return (k);
  }
  
  proc chacha20_body (st:W32.t Array16.t) : W32.t Array16.t * W32.t Array16.t = {
    
    var k:W32.t Array16.t;
    k <- witness;
    k <@ copy_state (st);
    k <@ rounds (k);
    k <@ sum_states (k, st);
    st <@ increment_counter (st);
    return (k, st);
  }
  
  proc chacha20_more_than_256 (output:W64.t, plain:W64.t, len:W32.t,
                               key:W64.t, nonce:W64.t, counter:W32.t) : unit = {
    
    var st_1:W32.t Array16.t;
    var k_1:W32.t Array16.t;
    var st_2:W32.t Array16.t;
    var k_2:W32.t Array16.t;
    var st_3:W32.t Array16.t;
    var k_3:W32.t Array16.t;
    var st_4:W32.t Array16.t;
    var k_4:W32.t Array16.t;
    var st_5:W32.t Array16.t;
    var k_5:W32.t Array16.t;
    var st_6:W32.t Array16.t;
    var k_6:W32.t Array16.t;
    var st_7:W32.t Array16.t;
    var k_7:W32.t Array16.t;
    var st_8:W32.t Array16.t;
    var k_8:W32.t Array16.t;
    k_1 <- witness;
    k_2 <- witness;
    k_3 <- witness;
    k_4 <- witness;
    k_5 <- witness;
    k_6 <- witness;
    k_7 <- witness;
    k_8 <- witness;
    st_1 <- witness;
    st_2 <- witness;
    st_3 <- witness;
    st_4 <- witness;
    st_5 <- witness;
    st_6 <- witness;
    st_7 <- witness;
    st_8 <- witness;
    st_1 <@ init (key, nonce, counter);
    
    while (((W32.of_int 512) \ule len)) {
      (k_1, st_2) <@ chacha20_body (st_1);
      (k_2, st_3) <@ chacha20_body (st_2);
      (k_3, st_4) <@ chacha20_body (st_3);
      (k_4, st_5) <@ chacha20_body (st_4);
      (k_5, st_6) <@ chacha20_body (st_5);
      (k_6, st_7) <@ chacha20_body (st_6);
      (k_7, st_8) <@ chacha20_body (st_7);
      (k_8, st_1) <@ chacha20_body (st_8);
      (output, plain, len) <@ store_x8 (output, plain, len, k_1, k_2, k_3,
      k_4, k_5, k_6, k_7, k_8);
    }
    if (((W32.of_int 0) \ult len)) {
      (k_1, st_2) <@ chacha20_body (st_1);
      (k_2, st_3) <@ chacha20_body (st_2);
      (k_3, st_4) <@ chacha20_body (st_3);
      (k_4, st_5) <@ chacha20_body (st_4);
      (k_5, st_6) <@ chacha20_body (st_5);
      (k_6, st_7) <@ chacha20_body (st_6);
      (k_7, st_8) <@ chacha20_body (st_7);
      (k_8, st_1) <@ chacha20_body (st_8);
      store_x8_last (output, plain, len, k_1, k_2, k_3, k_4, k_5, k_6, k_7,
      k_8);
    } else {
      
    }
    return ();
  }

  proc chacha20_ref_loop (output:W64.t, plain:W64.t, len:W32.t, st : W32.t Array16.t) : unit = {
     var k:W32.t Array16.t;
     while (((W32.of_int 0) \ult len)) {
      (k, st) <@ chacha20_body(st);
      (output, plain, len) <@ ChaCha20_pref.M.store (output, plain, len, k);
    }
    return ();
  }

  proc chacha20_ref (output:W64.t, plain:W64.t, len:W32.t,
                               key:W64.t, nonce:W64.t, counter:W32.t) : unit = {
    var st, k:W32.t Array16.t; (* Do not remove k *)
    st <@ init (key, nonce, counter);
    chacha20_ref_loop(output, plain, len, st);
  }
    
  proc chacha20_less_than_128 (output:W64.t, plain:W64.t, len:W32.t, st : W32.t Array16.t) : unit = {
     var k1_1:W32.t Array16.t;
     var st_2:W32.t Array16.t;
     var k1_2:W32.t Array16.t;
     var st_3:W32.t Array16.t;
     (k1_1, st_2) <@ chacha20_body (st);
     (k1_2, st_3) <@ chacha20_body (st_2);
     store_x2_last (output, plain, len, k1_1, k1_2);
  }

  proc chacha20_between_128_255 (output:W64.t, plain:W64.t, len:W32.t, st : W32.t Array16.t) : unit = {
    var k_1, k_2, k_3, k_4, st_2, st_3, st_4, st_5 : W32.t Array16.t;
    (k_1, st_2) <@ chacha20_body(st);
    (k_2, st_3) <@ chacha20_body(st_2);
    (k_3, st_4) <@ chacha20_body(st_3); 
    (k_4, st_5) <@ chacha20_body(st_4);                                           
    store_x4_last(output, plain, len, k_1, k_2, k_3, k_4);
  }

  proc chacha20_between_128_255_1 (output:W64.t, plain:W64.t, len:W32.t, st : W32.t Array16.t) : unit = {
    var k_1, k_2, k_3, k_4, st_2, st_3, st_4, st_5 : W32.t Array16.t;
    (k_1, st_2) <@ chacha20_body(st);
    (k_2, st_3) <@ chacha20_body(st_2);
    (output, plain, len) <@ store_x2 (output, plain, len, k_1, k_2);
    chacha20_less_than_128(output, plain, len, st_3);
  }

  proc chacha20_less_than_257 (output:W64.t, plain:W64.t, len:W32.t,
                               key:W64.t, nonce:W64.t, counter:W32.t) : unit = {
    var st_1:W32.t Array16.t;
    var k1_1:W32.t Array16.t;
    var st_2:W32.t Array16.t;
    var k1_2:W32.t Array16.t;
    var st_3:W32.t Array16.t;
    st_1 <@ init (key, nonce, counter);
    if (((W32.of_int 128) \ult len)) {
      chacha20_between_128_255_1(output, plain, len, st_1);
    } else {
      chacha20_less_than_128 (output, plain, len, st_1);
    }
    return ();
  }
  
  proc chacha20_avx2 (output:W64.t, plain:W64.t, len:W32.t, key:W64.t,
                      nonce:W64.t, counter:W32.t) : unit = {
    
    
    
    if ((len \ult (W32.of_int 257))) {
      chacha20_less_than_257 (output, plain, len, key, nonce, counter);
    } else {
      chacha20_more_than_256 (output, plain, len, key, nonce, counter);
    }
    return ();
  }
}.


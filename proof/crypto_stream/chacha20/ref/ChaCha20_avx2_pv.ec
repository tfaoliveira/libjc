require import List Jasmin_model Int IntDiv CoreMap.
require import Array16.
require import WArray64.
require import ChaCha20_pref.

module M = {
    
  proc store_last (output plain len: int, k :W32.t Array16.t) : unit = {
    ChaCha20_pref.M.store (output, plain, len, k);
  }
  
  proc store_x2 (output plain len: int, k_1 k_2: W32.t Array16.t) : int * int * int = {
    (output, plain, len) <@ ChaCha20_pref.M.store (output, plain, len, k_1);
    (output, plain, len) <@ ChaCha20_pref.M.store (output, plain, len, k_2);
    return (output, plain, len);
  }
  
  proc store_x2_last (output plain len: int, k_1 k_2 : W32.t Array16.t) : unit = {
    var r:W32.t Array16.t;
    r <- k_1;
    if (64 <= len) {
      (output, plain, len) <@ ChaCha20_pref.M.store (output, plain, len, r);
      r <- k_2;
    }
    store_last (output, plain, len, r);
  }
  
  proc store_x4 (output plain len: int, k_1 k_2 k_3 k_4: W32.t Array16.t) : int * int * int = {
    (output, plain, len) <@ ChaCha20_pref.M.store (output, plain, len, k_1);
    (output, plain, len) <@ ChaCha20_pref.M.store (output, plain, len, k_2);
    (output, plain, len) <@ ChaCha20_pref.M.store (output, plain, len, k_3);
    (output, plain, len) <@ ChaCha20_pref.M.store (output, plain, len, k_4);
    return (output, plain, len);
  }
  
  proc store_x4_last (output plain len: int, k_1 k_2 k_3 k_4: W32.t Array16.t) : unit = {
    var r_1:W32.t Array16.t;
    var r_2:W32.t Array16.t;
    r_1 <- k_1;
    r_2 <- k_2;
    if (128 <= len) {
      (output, plain, len) <@ store_x2 (output, plain, len, r_1, r_2);
      r_1 <- k_3;
      r_2 <- k_4;
    } 
    store_x2_last (output, plain, len, r_1, r_2);
  }
  
  proc store_x8 (output plain len: int, k_1 k_2 k_3 k_4 k_5 k_6 k_7 k_8: W32.t Array16.t) : int * int * int = {
    (output, plain, len) <@ ChaCha20_pref.M.store (output, plain, len, k_1);
    (output, plain, len) <@ ChaCha20_pref.M.store (output, plain, len, k_2);
    (output, plain, len) <@ ChaCha20_pref.M.store (output, plain, len, k_3);
    (output, plain, len) <@ ChaCha20_pref.M.store (output, plain, len, k_4);
    (output, plain, len) <@ ChaCha20_pref.M.store (output, plain, len, k_5);
    (output, plain, len) <@ ChaCha20_pref.M.store (output, plain, len, k_6);
    (output, plain, len) <@ ChaCha20_pref.M.store (output, plain, len, k_7);
    (output, plain, len) <@ ChaCha20_pref.M.store (output, plain, len, k_8);
    return (output, plain, len);
  }
  
  proc store_x8_last (output plain len: int, k_1 k_2 k_3 k_4 k_5 k_6 k_7 k_8: W32.t Array16.t) : unit = {
    var r_1:W32.t Array16.t;
    var r_2:W32.t Array16.t;
    var r_3:W32.t Array16.t;
    var r_4:W32.t Array16.t;
    r_1 <- k_1;
    r_2 <- k_2;
    r_3 <- k_3;
    r_4 <- k_4;
    if (256 <= len) {
      (output, plain, len) <@ store_x4 (output, plain, len, r_1, r_2, r_3, r_4);
      r_1 <- k_5;
      r_2 <- k_6;
      r_3 <- k_7;
      r_4 <- k_8;
    }
    store_x4_last (output, plain, len, r_1, r_2, r_3, r_4);
  }  
  
  proc body_x8(st_1: W32.t Array16.t) = {
    var st_2, st_3, st_4, st_5, st_6, st_7, st_8 : W32.t Array16.t;
    var k_1, k_2, k_3, k_4, k_5, k_6, k_7, k_8 : W32.t Array16.t;

    k_1 <@ ChaCha20_pref.M.rounds (st_1);
    k_1 <@ ChaCha20_pref.M.sum_states (k_1, st_1);
    st_2 <@ ChaCha20_pref.M.increment_counter (st_1);

    k_2 <@ ChaCha20_pref.M.rounds (st_2);
    k_2 <@ ChaCha20_pref.M.sum_states (k_2, st_2);
    st_3 <@ ChaCha20_pref.M.increment_counter (st_2);
  
    k_3 <@ ChaCha20_pref.M.rounds (st_3);
    k_3 <@ ChaCha20_pref.M.sum_states (k_3, st_3);
    st_4 <@ ChaCha20_pref.M.increment_counter (st_3);

    k_4 <@ ChaCha20_pref.M.rounds (st_4);
    k_4 <@ ChaCha20_pref.M.sum_states (k_4, st_4);
    st_5 <@ ChaCha20_pref.M.increment_counter (st_4);

    k_5 <@ ChaCha20_pref.M.rounds (st_5);
    k_5 <@ ChaCha20_pref.M.sum_states (k_5, st_5);
    st_6 <@ ChaCha20_pref.M.increment_counter (st_5);

    k_6 <@ ChaCha20_pref.M.rounds (st_6);
    k_6 <@ ChaCha20_pref.M.sum_states (k_6, st_6);
    st_7 <@ ChaCha20_pref.M.increment_counter (st_6);
  
    k_7 <@ ChaCha20_pref.M.rounds (st_7);
    k_7 <@ ChaCha20_pref.M.sum_states (k_7, st_7);
    st_8 <@ ChaCha20_pref.M.increment_counter (st_7);

    k_8 <@ ChaCha20_pref.M.rounds (st_8);
    k_8 <@ ChaCha20_pref.M.sum_states (k_8, st_8);
    st_1 <@ ChaCha20_pref.M.increment_counter (st_8);
    return (st_1, k_1, k_2, k_3, k_4, k_5, k_6, k_7, k_8);
  }
     
  proc chacha20_more_than_256 (output plain len: int, key nonce: int, counter:W32.t) : unit = {
    
    var st_1:W32.t Array16.t;
    var k_1, k_2, k_3, k_4, k_5, k_6, k_7, k_8 : W32.t Array16.t;

    st_1 <@ ChaCha20_pref.M.init (key, nonce, counter);
    
    while (512 <= len) {
      (st_1, k_1, k_2, k_3, k_4, k_5, k_6, k_7, k_8) <- body_x8(st_1);
      (output, plain, len) <@ store_x8 (output, plain, len, k_1, k_2, k_3, k_4, k_5, k_6, k_7, k_8);
    }
    if (0 < len) {
      (st_1, k_1, k_2, k_3, k_4, k_5, k_6, k_7, k_8) <- body_x8(st_1);
      store_x8_last (output, plain, len, k_1, k_2, k_3, k_4, k_5, k_6, k_7, k_8);
    } 
  }

  proc chacha20_less_than_128 (output plain len: int, st_1 : W32.t Array16.t) : unit = {
    var k_1, k_2, st_2 :W32.t Array16.t;
      
    k_1 <@ ChaCha20_pref.M.rounds (st_1);
    k_1 <@ ChaCha20_pref.M.sum_states (k_1, st_1);
    st_2 <@ ChaCha20_pref.M.increment_counter (st_1);

    k_2 <@ ChaCha20_pref.M.rounds (st_2);
    k_2 <@ ChaCha20_pref.M.sum_states (k_2, st_2);

    store_x2_last (output, plain, len, k_1, k_2);
  }

  proc chacha20_between_128_255 (output plain len: int, st_1 : W32.t Array16.t) : unit = {
    var k_1, k_2, k_3, k_4, st_2, st_3, st_4 : W32.t Array16.t;

    k_1 <@ ChaCha20_pref.M.rounds (st_1);
    k_1 <@ ChaCha20_pref.M.sum_states (k_1, st_1);
    st_2 <@ ChaCha20_pref.M.increment_counter (st_1);

    k_2 <@ ChaCha20_pref.M.rounds (st_2);
    k_2 <@ ChaCha20_pref.M.sum_states (k_2, st_2);
    st_3 <@ ChaCha20_pref.M.increment_counter (st_2);
  
    k_3 <@ ChaCha20_pref.M.rounds (st_3);
    k_3 <@ ChaCha20_pref.M.sum_states (k_3, st_3);
    st_4 <@ ChaCha20_pref.M.increment_counter (st_3);

    k_4 <@ ChaCha20_pref.M.rounds (st_4);
    k_4 <@ ChaCha20_pref.M.sum_states (k_4, st_4);

    (output, plain, len) <@ store_x2 (output, plain, len, k_1, k_2);
    store_x2_last (output, plain, len, k_3, k_4);

  }

  proc chacha20_less_than_257 (output plain len: int, key nonce: int, counter:W32.t) : unit = {
    var st_1:W32.t Array16.t;
    var k1_1:W32.t Array16.t;
    var st_2:W32.t Array16.t;
    var k1_2:W32.t Array16.t;
    var st_3:W32.t Array16.t;
    st_1 <@ ChaCha20_pref.M.init (key, nonce, counter);
    if (128 < len) {
      chacha20_between_128_255(output, plain, len, st_1);
    } else {
      chacha20_less_than_128 (output, plain, len, st_1);
    }
  }

  proc chacha20_avx2 (output plain len: int, key nonce: int, counter:W32.t) : unit = {
    if (len < 257) {
      chacha20_less_than_257 (output, plain, len, key, nonce, counter);
    } else {
      chacha20_more_than_256 (output, plain, len, key, nonce, counter);
    }
  }
 
  (* ------------------------------------------------------------------------------------- *)
  (* Usefull functions to help the proof                                                   *)
  proc chacha20_body (st:W32.t Array16.t) : W32.t Array16.t * W32.t Array16.t = {
    
    var k, st1:W32.t Array16.t;
    k <@ ChaCha20_pref.M.rounds (st);
    k <@ ChaCha20_pref.M.sum_states (k, st);
    st1 <@ ChaCha20_pref.M.increment_counter (st);
    return (k, st1);
  }

  proc chacha20_ref_loop (output plain len: int, st : W32.t Array16.t) : unit = {
     var k:W32.t Array16.t;
     while (0 < len) {
      (k, st) <@ chacha20_body(st);
      (output, plain, len) <@ ChaCha20_pref.M.store (output, plain, len, k);
    }
    return ();
  }

  proc chacha20_ref (output plain len: int, key nonce: int, counter:W32.t) : unit = {
    var st, k:W32.t Array16.t; (* Do not remove k *)
    st <@ ChaCha20_pref.M.init (key, nonce, counter);
    chacha20_ref_loop(output, plain, len, st);
  }

  proc chacha20_between_128_255_1 (output plain len: int, st : W32.t Array16.t) : unit = {
    var k_1, k_2, st_2, st_3 : W32.t Array16.t;
    (k_1, st_2) <@ chacha20_body(st);
    (k_2, st_3) <@ chacha20_body(st_2);
    (output, plain, len) <@ store_x2 (output, plain, len, k_1, k_2);
    chacha20_less_than_128(output, plain, len, st_3);
  }

  (* ------------------------------------------------------------------------------------- *)

}.



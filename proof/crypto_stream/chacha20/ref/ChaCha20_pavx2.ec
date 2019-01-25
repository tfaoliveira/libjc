require import List Jasmin_model Int IntDiv CoreMap.
require import Array16.
require import WArray64.
require import ChaCha20_pref ChaCha20_avx2_pv.

module M = {
  proc init_x2(key:W64.t, nonce:W64.t, counter:W32.t) : W32.t Array16.t * W32.t Array16.t = {
    var st_1, st_2: W32.t Array16.t;
    st_1 <@ ChaCha20_pref.M.init (key, nonce, counter);
    st_2 <@ ChaCha20_pref.M.increment_counter(st_1);
    return (st_1, st_2);
  }

  proc column_round_x2(k1_1 k1_2: W32.t Array16.t) : W32.t Array16.t * W32.t Array16.t = {
    k1_1 <@  ChaCha20_pref.M.column_round(k1_1);
    k1_2 <@  ChaCha20_pref.M.column_round(k1_2);
    return (k1_1, k1_2);
  }

  proc diagonal_round_x2(k1_1 k1_2: W32.t Array16.t) : W32.t Array16.t * W32.t Array16.t = {
    k1_1 <@  ChaCha20_pref.M.diagonal_round(k1_1);
    k1_2 <@  ChaCha20_pref.M.diagonal_round(k1_2);
    return (k1_1, k1_2);
  }

  proc rounds_x2_aux(k1_1 k1_2: W32.t Array16.t) : W32.t Array16.t * W32.t Array16.t = {
    k1_1 <@ ChaCha20_pref.M.rounds(k1_1);
    k1_2 <@ ChaCha20_pref.M.rounds(k1_2);
    return (k1_1, k1_2);
  }

  proc rounds_x2(k1_1 k1_2: W32.t Array16.t) : W32.t Array16.t * W32.t Array16.t = {
    var c : int;
    c <- 0;
    while (c < 10) {
      (k1_1, k1_2) <- column_round_x2(k1_1, k1_2);
      (k1_1, k1_2) <- diagonal_round_x2(k1_1, k1_2);
      c <- c + 1;
    }
    return (k1_1, k1_2);
  }

  proc sum_states_x2(k1_1 k1_2 st_1 st_2: W32.t Array16.t) : W32.t Array16.t * W32.t Array16.t = {
    var k1, k2 :  W32.t Array16.t;
    k1 <@ ChaCha20_pref.M.sum_states(k1_1, st_1);
    k2 <@ ChaCha20_pref.M.sum_states(k1_2, st_2);
    return (k1, k2);
  }
    
  proc copy_state_x4(st_1 st_2: W32.t Array16.t) : W32.t Array16.t * W32.t Array16.t = {
    st_1.[12] <- st_1.[12] + W32.of_int 2;
    st_2.[12] <- st_2.[12] + W32.of_int 2;
    return (st_1, st_2);
  }

  proc rounds_x4 (st_1, st_2, st_3, st_4 :  W32.t Array16.t) = {
    (st_1, st_2) <@ rounds_x2 (st_1, st_2);
    (st_3, st_4) <@ rounds_x2 (st_3, st_4);
    return (st_1, st_2, st_3, st_4);
  }

  proc sum_states_x4(k1_1 k1_2 k2_1 k2_2 st_1 st_2: W32.t Array16.t) = {
    (k1_1, k1_2) = sum_states_x2(k1_1, k1_2, st_1, st_2);
    (k2_1, k2_2) = sum_states_x2(k2_1, k2_2, st_1, st_2);
    k2_1.[12] <- k2_1.[12] + W32.of_int 2;
    k2_2.[12] <- k2_2.[12] + W32.of_int 2;
    return (k1_1, k1_2, k2_1, k2_2);
  }

  proc chacha20_less_than_257(output:W64.t, plain:W64.t, len:W32.t,
                               key:W64.t, nonce:W64.t, counter:W32.t) : unit = {
    var st_1, st_2, st_3, st_4, k1_1, k1_2, k2_1, k2_2: W32.t Array16.t;
    (st_1, st_2) <@ init_x2(key, nonce, counter);
    if (W32.of_int 128 \ult len) {
       (st_3, st_4) <@ copy_state_x4(st_1, st_2);
       (k1_1, k1_2, k2_1, k2_2) <@ rounds_x4(st_1, st_2, st_3, st_4);
       (k1_1, k1_2, k2_1, k2_2) <@ sum_states_x4(k1_1, k1_2, k2_1, k2_2, st_1, st_2);
       (output, plain, len) <@ ChaCha20_avx2_pv.M.store_x2(output, plain, len, k1_1, k1_2);
       ChaCha20_avx2_pv.M.store_x2_last(output, plain, len, k2_1, k2_2);
    } else {
      (k1_1, k1_2) <@ rounds_x2 (st_1, st_2);
      (k1_1, k1_2) <@ sum_states_x2(k1_1, k1_2, st_1, st_2);
      ChaCha20_avx2_pv.M.store_x2_last(output, plain, len, k1_1, k1_2);
    } 
  }

  proc chacha20_more_than_256(output:W64.t, plain:W64.t, len:W32.t,
                               key:W64.t, nonce:W64.t, counter:W32.t) : unit = {
  }


  proc chacha20_avx2(output:W64.t, plain:W64.t, len:W32.t,
                               key:W64.t, nonce:W64.t, counter:W32.t) : unit = {
    if (len \ult W32.of_int 257) {
      chacha20_less_than_257(output, plain, len, key, nonce, counter);
    } else {
      chacha20_more_than_256(output, plain, len, key, nonce, counter);
      
    }
  }
}.

equiv eq_chacha20_init_x2 : ChaCha20_pref.M.init ~ M.init_x2 : 
   ={key, nonce, counter, Glob.mem} ==> res{1} = res{2}.`1 /\  res{2}.`2 = res{1}.[12 <- res{1}.[12] + W32.of_int 1].
proof.
  proc => /=.
  inline ChaCha20_pref.M.increment_counter.
  wp 10 1; conseq (_: st{1} = st_1{2}) => />.
  by inline [tuple] *; sim.
qed.

equiv eq_chacha20_less_than_257 : ChaCha20_avx2_pv.M.chacha20_less_than_257 ~ M.chacha20_less_than_257 :
   ={output, plain, len, key, nonce, counter, Glob.mem} ==> 
   ={Glob.mem}.
proof.
  proc => /=.
  seq 1 1 : (#pre /\ st_1{1} = st_1{2} /\ st_2{2} = st_1{1}.[12 <- st_1{1}.[12] + W32.of_int 1]).
  + by call eq_chacha20_init_x2; skip.
  if => //; last first.
  + inline ChaCha20_avx2_pv.M.chacha20_less_than_128; sim.
    swap{1} 7 -2. interleave{1} [6:1] [8:1] 2.  
    inline [-tuple] M.sum_states_x2 ChaCha20_pref.M.increment_counter M.rounds_x2 ChaCha20_pref.M.rounds; sim.
    swap{1} 11 3. swap{1} 11 -2.
    wp; sp 9 2.  
    transitivity * {1} {
      c <- 0;
      while (c < 10) {
        k <@ ChaCha20_pref.M.round(k);
        k0 <@ ChaCha20_pref.M.round(k0);
        c <- c + 1;
      }
    }.
    + smt(). + done.
    + unroll for {1} 4;unroll for {1} 2;unroll for {2} 2.
      by interleave{1} [1:2] [22:2] 10; sim.
    while (#post /\ ={c}); last by auto.
    inline [-tuple] ChaCha20_pref.M.round M.column_round_x2 M.diagonal_round_x2.
    by swap{1} [5..6] -2; wp; sim />. 
  
 

inline ChaCha20_pref.M.rounds.
 
    transitivity * {  
inline [-tuple] ChaCha20_avx2_pv.M.chacha20_less_than_128 ChaCha20_avx2_pv.M.chacha20_body; sim.
    inline{1} (2) ChaCha20_pref.M.increment_counter; wp.
    swap{1} 8 -2. 
    inline [-tuple] M.sum_states_x2; wp.
    swap{1} [8..9] 1. swap{1} [9..11] 3. sim.
    replace * {1} {_ as c1; (_ <@ _; _; _ <@ _) as c2} by 
                  {c1; 
                   (k,k0) <@ M.rounds_x2_aux(st0, st1);
                   st2 <- st1; }.
    + smt (). + done.
    + by inline M.rounds_x2_aux; sim.
    wp; call rounds_x2_aux_rounds_x2.
    by inline ChaCha20_pref.M.increment_counter; auto.
  inline{1} ChaCha20_avx2_pv.M.chacha20_between_128_255_1.
  inline{1} [-tuple] ChaCha20_avx2_pv.M.chacha20_body ChaCha20_avx2_pv.M.chacha20_less_than_128.
  swap{1} 11 -1. swap{1} [9..10] 10.
  swap{1} 14 -2. swap{1} [8..12] -2.
  swap{1} [19..24] 17.
  swap{1} 23 -2. swap{1} [18..21] -1. swap{1} [16..20] -5.
  swap{1} 31 -2. swap{1} [27..29] -1. swap{1} [25..28] -9.
  swap{1} 21 1. swap{1} [22..25] 1. swap{1} [23..29] 1. 
  inline{2} [-tuple] M.sum_states_x4 M.sum_states_x2; sim.
  wp.
  

swap{1} [24..29] 1. swap{1} [25..
  
  swap{1} 16 -2.
  

qed.



  inline [-tuple] M.rounds_x2 ChaCha20_pref.M.rounds.
  
    
  inline 
  
  interleave{2} [2:1] [4:1] 2.
  interleave{
  transitivity{1}
    {
      output0 <- output;
      plain0 <- plain;                             
      len0 <- len;                               
      st <- st_1;                                   
      st0 <- st;                                     
      st1 <@ ChaCha20_pref.M.increment_counter(st0);
      k <@ ChaCha20_pref.M.rounds(st0); 
      k <@ ChaCha20_avx2_pv.M.sum_states(k, st0);
      k1_10 <- k;
      st_20 <- st1;    
      st2 <- st_20;                    
      k0 <@ ChaCha20_pref.M.rounds(st2);
      k0 <@ ChaCha20_avx2_pv.M.sum_states(k0, st2);
    }
    (={output, plain, len, st_1, Glob.mem} ==> ={k0, k1_10, len0, plain0, output0, Glob.mem})
  
    ((={output, plain, len, key, nonce, counter, Glob.mem} /\ ={st_1} /\ st_2{2} = st_1{1}.[12 <- st_1{1}.[12] + W32.one]) /\
     ! ((of_int 128)%W32 \ult len{1}) ==>
     k0{1} = k2{2} /\
     k1_10{1} = k1{2} /\ len0{1} = len{2} /\ plain0{1} = plain{2} /\ output0{1} = output{2} /\ ={Glob.mem}) => //.
   + smt().  
   + by sim.
   swap{1} [8 .. 9] 3; sim.
   swap{1} [8..9] -1.
   seq 8 0 : (#{/~k0{1}}{ ~ k{1}}post).
   + by inline *;auto.
   inline M.rounds_x2.
   inline ChaCha20_pref.M.rounds.
   inline M.column_round_x2 M.diagonal_round_x2.
   sp; wp.
   transitivity{2} {
      while (c < 10) {                                
         k1_12 <@ ChaCha20_pref.M.column_round(k1_11);  
         k1_22 <@ ChaCha20_pref.M.column_round(k1_21);  
         k1_11 <@ ChaCha20_pref.M.diagonal_round(k1_12);
         k1_21 <@ ChaCha20_pref.M.diagonal_round(k1_22);
         c <- c + 1;                                    
       }                                               
       (k1_1, k1_2) <- (k1_11, k1_21);
     }
   (k1_11{2} = st_1{2} /\
  k1_21{2} = st_2{2} /\
  c{2} = 0 /\
  k1{1} = st0{1} /\
  c{1} = W32.zero /\
  st2{1} = st_2{2} /\
  st0{1} = st_1{2} /\ len0{1} = len{2} /\ plain0{1} = plain{2} /\ output0{1} = output{2} /\ ={Glob.mem} ==>

    k2{1} = k1_21{2} /\
  st2{1} = st_2{2} /\
  k{1} = k1_11{2} /\
  st0{1} = st_1{2} /\ len0{1} = len{2} /\ plain0{1} = plain{2} /\ output0{1} = output{2} /\ ={Glob.mem})
  (={c,k1_11, k1_12, Glob.mem, st_1, st_2, output, plain, len} ==> ={k1_11, k1_21, st_1, st_2, Glob.mem,output, plain, len}) => //. 
  + smt().
  + admit.
  while (#pre).

 
deadcode.
constprop.


 st0{1} = st_1{2} /\ st2{1} = st_2{2} /\ 

len0{1} = len{2} /\ plain0{1} = plain{2} /\ output0{1} = output{2} /\ ={Glob.mem}
   sim.
  splittuple 





  swap{1} 6 -3.
equiv eq_chacha20_avx2 : ChaCha20_avx2_pv.M.chacha20_avx2 ~ M.chacha20_avx2 :
   ={output, plain, len, key, nonce, counter, Glob.mem} ==> 
   ={Glob.mem}.
proof.
  proc => /=.
  if => //.

  

module M = {
  proc shuffle_state_1 (st:W32.t Array16.t) : W32.t Array16.t = {
    var st':W32.t Array16.t;
    st'.[0]  <- st.[0];
    st'.[1]  <- st.[1];
    st'.[2]  <- st.[2];
    st'.[3]  <- st.[3];
             
    st'.[4]  <- st.[5];
    st'.[5]  <- st.[6];
    st'.[6]  <- st.[7];
    st'.[7]  <- st.[4];

    st'.[8]  <- st.[10];
    st'.[9]  <- st.[11];
    st'.[10] <- st.[8];
    st'.[11] <- st.[9];

    st'.[12] <- st.[15];
    st'.[13] <- st.[12];
    st'.[14] <- st.[13];
    st'.[15] <- st.[14];
    return st';
  }

 proc reverse_shuffle_state_1 (st':W32.t Array16.t) : W32.t Array16.t = {
    var st:W32.t Array16.t;
    st.[0]  <- st'.[0];
    st.[1]  <- st'.[1];
    st.[2]  <- st'.[2];
    st.[3]  <- st'.[3];
                       
    st.[5]  <- st'.[4];
    st.[6]  <- st'.[5];
    st.[7]  <- st'.[6];
    st.[4]  <- st'.[7];
                       
    st.[10] <- st'.[8];
    st.[11] <- st'.[9];
    st.[8]  <- st'.[10];
    st.[9]  <- st'.[11];
                       
    st.[15] <- st'.[12];
    st.[12] <- st'.[13];
    st.[13] <- st'.[14];
    st.[14] <- st'.[15];
    return st;
  }

 proc rotate_1(k:W32.t Array16.t, i r : int) :  W32.t Array16.t = {
   k.[i + 0] <- W32.rol k.[i + 0] r;
   k.[i + 1] <- W32.rol k.[i + 1] r;
   k.[i + 2] <- W32.rol k.[i + 2] r;
   k.[i + 3] <- W32.rol k.[i + 3] r;
   return k;
 }

 proc line_1 (k:W32.t Array16.t, a b c r : int) : W32.t Array16.t = {
   var i, a4, b4, c4 : int;
   i <- 0;
  
   k.[a + 0] <-  k.[a + 0] + k.[b + 0];
   k.[a + 1] <-  k.[a + 1] + k.[b + 1];
   k.[a + 2] <-  k.[a + 2] + k.[b + 2];
   k.[a + 3] <-  k.[a + 3] + k.[b + 3];

   k.[c + 0] <-  k.[c + 0] `^` k.[a + 0];
   k.[c + 1] <-  k.[c + 1] `^` k.[a + 1];
   k.[c + 2] <-  k.[c + 2] `^` k.[a + 2];
   k.[c + 3] <-  k.[c + 3] `^` k.[a + 3];

   k <@ rotate_1(k, c, r);
   return k;   
 }

 proc column_round_1 (k:W32.t Array16.t) : W32.t Array16.t = {
   k <@ line_1(k, 0, 4, 12, 16);
   k <@ line_1(k, 8, 12, 4, 12);
   k <@ line_1(k, 0, 4, 12,  8);
   k <@ line_1(k, 8, 12, 4,  7);
  return k;
 }

 proc diagonal_round_1(k:W32.t Array16.t) : W32.t Array16.t = {
   var k1, k2, k3 : W32.t Array16.t; 
   k1 <@ shuffle_state_1(k);
   k2 <@ column_round_1(k1);
   k3 <@ reverse_shuffle_state_1(k2);
   return k3;
 }

 proc round_1 (k:W32.t Array16.t) : W32.t Array16.t = {
   var k1, k2 : W32.t Array16.t; 
   k1 <@ column_round_1 (k);
   k2 <@ diagonal_round_1 (k1);
   return k2;
 }

 proc rounds_1 (k:W32.t Array16.t) : W32.t Array16.t = {
   var c : int;
   while (c < 20) {
     k <@ round_1(k);
     c <- c + 1;
   }
   return k;
 }
   
 proc shuffle_state_2 (st1, st2:W32.t Array16.t) : W32.t Array16.t * W32.t Array16.t = {
   st1 <@ shuffle_state_1(st1);
   st2 <@ shuffle_state_1(st2);
   return (st1, st2);
 }

 proc reverse_shuffle_state_2 (st1, st2:W32.t Array16.t) : W32.t Array16.t * W32.t Array16.t = {
   st1 <@ reverse_shuffle_state_1(st1);
   st2 <@ reverse_shuffle_state_1(st2);
   return (st1, st2);
 }


 proc rotate_2 (k1 k2:W32.t Array16.t, i r : int) :  W32.t Array16.t * W32.t Array16.t = {
   k1 <@ rotate_1(k1, i, r);
   k2 <@ rotate_1(k2, i, r);
   return (k1, k2);
 }

 proc line_2 (k1 k2:W32.t Array16.t, a b c r : int) :  W32.t Array16.t * W32.t Array16.t = {
   k1 <@ line_1(k1, a, b, c, r);
   k2 <@ line_1(k2, a, b, c, r);
   return (k1, k2);
 }

 proc column_round_2 (k1 k2:W32.t Array16.t) : W32.t Array16.t  * W32.t Array16.t = {
   (k1, k2) <@ line_2(k1, k2, 0, 4, 12, 16);
   (k1, k2) <@ line_2(k1, k2, 8, 12, 4, 12);
   (k1, k2) <@ line_2(k1, k2, 0, 4, 12,  8);
   (k1, k2) <@ line_2(k1, k2, 8, 12, 4,  7);
  return (k1, k2);
 }

 proc diagonal_round_2(k1, k2:W32.t Array16.t) : W32.t Array16.t * W32.t Array16.t = {
   var k1_1, k1_2, k2_1, k2_2, k1_3, k2_3 : W32.t Array16.t; 
   (k1_1, k2_2) <@ shuffle_state_2(k1, k2);
   (k1_2, k2_2) <@ column_round_2(k1_1, k2_1);
   (k1_3, k2_3) <@ reverse_shuffle_state_2(k2_1, k2_2);
   return (k1_3, k2_3);
 }

 proc round_2 (k1 k2:W32.t Array16.t) : W32.t Array16.t * W32.t Array16.t = {
   var k1_1, k1_2, k2_1, k2_2 : W32.t Array16.t; 
   (k1_1, k2_1) <@ column_round_2 (k1, k2);
   (k1_2, k2_2) <@ diagonal_round_2 (k1_1, k2_1);
   return (k1_2, k2_2);
 }

 proc rounds_1_2 (k1 k2:W32.t Array16.t) : W32.t Array16.t * W32.t Array16.t = {
   var c : int;
   k1 <@ rounds_1(k1);
   k2 <@ rounds_1(k2);
   return (k1, k2);
 }

 proc rounds_2 (k1 k2:W32.t Array16.t) : W32.t Array16.t * W32.t Array16.t = {
   var c : int;
   while (c < 20) {
     (k1, k2) <@ round_2(k1, k2);
     c <- c + 1;
   }
   return (k1, k2);
 }

 proc chacha20_less_than_128 (output:W64.t, plain:W64.t, len:W32.t, st1 st2 : W32.t Array16.t) : unit = {
   (k1,k2) <@ rounds_2 
}.



proc chacha20_less_than_128 (output:W64.t, plain:W64.t, len:W32.t, st : W32.t Array16.t) : unit = {
     var k1_1:W32.t Array16.t;
     var st_2:W32.t Array16.t;
     var k1_2:W32.t Array16.t;
     var st_3:W32.t Array16.t;
     (k1_1, st_2) <@ chacha20_body (st);
     (k1_2, st_3) <@ chacha20_body (st_2);
     store_x2_last (output, plain, len, k1_1, k1_2);
  }






(* proc round_x2(k1:W32.t Array16.t, k2:W32.t Array16.t) : W32.t Array16.t *  W32.t Array16.t = {
   (k1, k2) = column_round_x2  (k1, k2)
   (k1, k2) = diagonal_round_x2(k1, k2)
   return (k1, k2)
 proc rounds_x2 *)
}.

(*
hoare test k0 : M.id : k = k0 ==> Array16.all_eq k0 res.
proof.
  rewrite /Array16.all_eq /=.
  proc. 
  inline *; wp; skip => &hr heq /=.
  rewrite heq //=.
qed.
*)

equiv eq_column_round : ChaCha20_pref.M.column_round ~ M.column_round : ={k} ==> ={res}.
proof.
  conseq (_: Array16.all_eq res{1} res{2}).
  + move=> &1 &2 ???; apply Array16.all_eq_eq.
  rewrite /Array16.all_eq /=.
  proc; inline *; wp; skip.
  move=> &1 &2 heq; cbv delta; rewrite heq //=.
qed.

equiv diagonal_round_pref_shuffle1 : ChaCha20_pref.M.diagonal_round ~ M.diagonal_round :
  ={k} ==> ={res}.
proof.
  conseq (_: Array16.all_eq res{1} res{2}).
  + move=> &1 &2 ???; apply Array16.all_eq_eq.
  rewrite /Array16.all_eq /=.
  proc; inline *; wp; skip.
  move => &1 &2 heq /=; rewrite heq //=.
qed. 
admitted.


rewrite /Array16.all

  

abbrev bswap = W128.of_int 5233100606242806050955395731361295.


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
  
  proc init_x2 (key:W64.t, nonce:W64.t, counter:W32.t) : W32.t Array16.t *
                                                         W32.t Array16.t = {
    
    var st_1:W32.t Array16.t;
    var st_2:W32.t Array16.t;
    st_1 <- witness;
    st_2 <- witness;
    st_1 <@ init (key, nonce, counter);
    counter <- (counter + (W32.of_int 1));
    st_2 <@ init (key, nonce, counter);
    return (st_1, st_2);
  }
  
  proc init_x8 (key:W64.t, nonce:W64.t, counter:W32.t) : W32.t Array16.t *
                                                         W32.t Array16.t *
                                                         W32.t Array16.t *
                                                         W32.t Array16.t *
                                                         W32.t Array16.t *
                                                         W32.t Array16.t *
                                                         W32.t Array16.t *
                                                         W32.t Array16.t = {
    
    var st_1:W32.t Array16.t;
    var st_2:W32.t Array16.t;
    var st_3:W32.t Array16.t;
    var st_4:W32.t Array16.t;
    var st_5:W32.t Array16.t;
    var st_6:W32.t Array16.t;
    var st_7:W32.t Array16.t;
    var st_8:W32.t Array16.t;
    st_1 <- witness;
    st_2 <- witness;
    st_3 <- witness;
    st_4 <- witness;
    st_5 <- witness;
    st_6 <- witness;
    st_7 <- witness;
    st_8 <- witness;
    st_1 <@ init (key, nonce, counter);
    counter <- (counter + (W32.of_int 1));
    st_2 <@ init (key, nonce, counter);
    counter <- (counter + (W32.of_int 1));
    st_3 <@ init (key, nonce, counter);
    counter <- (counter + (W32.of_int 1));
    st_4 <@ init (key, nonce, counter);
    counter <- (counter + (W32.of_int 1));
    st_5 <@ init (key, nonce, counter);
    counter <- (counter + (W32.of_int 1));
    st_6 <@ init (key, nonce, counter);
    counter <- (counter + (W32.of_int 1));
    st_7 <@ init (key, nonce, counter);
    counter <- (counter + (W32.of_int 1));
    st_8 <@ init (key, nonce, counter);
    return (st_1, st_2, st_3, st_4, st_5, st_6, st_7, st_8);
  }
  
  proc copy_state (st:W32.t Array16.t) : W32.t Array16.t = {
    
    var k:W32.t Array16.t;
    k <- witness;
    k <- st;
    return (k);
  }
  
  proc copy_state_x2 (st_1:W32.t Array16.t, st_2:W32.t Array16.t) : W32.t Array16.t *
                                                                    W32.t Array16.t = {
    
    var k_1:W32.t Array16.t;
    var k_2:W32.t Array16.t;
    k_1 <- witness;
    k_2 <- witness;
    k_1 <@ copy_state (st_1);
    k_2 <@ copy_state (st_2);
    return (k_1, k_2);
  }
  
  proc copy_state_x4 (st_1:W32.t Array16.t, st_2:W32.t Array16.t) : W32.t Array16.t *
                                                                    W32.t Array16.t *
                                                                    W32.t Array16.t *
                                                                    W32.t Array16.t = {
    
    var k_1:W32.t Array16.t;
    var k_2:W32.t Array16.t;
    var k_3:W32.t Array16.t;
    var k_4:W32.t Array16.t;
    k_1 <- witness;
    k_2 <- witness;
    k_3 <- witness;
    k_4 <- witness;
    k_1 <@ copy_state (st_1);
    k_2 <@ copy_state (st_2);
    k_3 <@ copy_state (st_1);
    k_4 <@ copy_state (st_2);
    k_3.[12] <- (k_3.[12] + (W32.of_int 2));
    k_4.[12] <- (k_4.[12] + (W32.of_int 2));
    return (k_1, k_2, k_3, k_4);
  }
  
  proc copy_state_x8 (st_1:W32.t Array16.t, st_2:W32.t Array16.t,
                      st_3:W32.t Array16.t, st_4:W32.t Array16.t,
                      st_5:W32.t Array16.t, st_6:W32.t Array16.t,
                      st_7:W32.t Array16.t, st_8:W32.t Array16.t) : W32.t Array16.t *
                                                                    W32.t Array16.t *
                                                                    W32.t Array16.t *
                                                                    W32.t Array16.t *
                                                                    W32.t Array16.t *
                                                                    W32.t Array16.t *
                                                                    W32.t Array16.t *
                                                                    W32.t Array16.t = {
    
    var k_1:W32.t Array16.t;
    var k_2:W32.t Array16.t;
    var k_3:W32.t Array16.t;
    var k_4:W32.t Array16.t;
    var k_5:W32.t Array16.t;
    var k_6:W32.t Array16.t;
    var k_7:W32.t Array16.t;
    var k_8:W32.t Array16.t;
    k_1 <- witness;
    k_2 <- witness;
    k_3 <- witness;
    k_4 <- witness;
    k_5 <- witness;
    k_6 <- witness;
    k_7 <- witness;
    k_8 <- witness;
    k_1 <@ copy_state (st_1);
    k_2 <@ copy_state (st_2);
    k_3 <@ copy_state (st_3);
    k_4 <@ copy_state (st_4);
    k_5 <@ copy_state (st_5);
    k_6 <@ copy_state (st_6);
    k_7 <@ copy_state (st_7);
    k_8 <@ copy_state (st_8);
    return (k_1, k_2, k_3, k_4, k_5, k_6, k_7, k_8);
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
  
  proc sum_states_x2 (k_1:W32.t Array16.t, k_2:W32.t Array16.t,
                      st_1:W32.t Array16.t, st_2:W32.t Array16.t) : W32.t Array16.t *
                                                                    W32.t Array16.t = {
    
    
    
    k_1 <@ sum_states (k_1, st_1);
    k_2 <@ sum_states (k_2, st_2);
    return (k_1, k_2);
  }
  
  proc sum_states_x4 (k1_1:W32.t Array16.t, k1_2:W32.t Array16.t,
                      k2_1:W32.t Array16.t, k2_2:W32.t Array16.t,
                      st_1:W32.t Array16.t, st_2:W32.t Array16.t) : W32.t Array16.t *
                                                                    W32.t Array16.t *
                                                                    W32.t Array16.t *
                                                                    W32.t Array16.t = {
    
    
    
    (k1_1, k1_2) <@ sum_states_x2 (k1_1, k1_2, st_1, st_2);
    (k2_1, k2_2) <@ sum_states_x2 (k2_1, k2_2, st_1, st_2);
    k2_1.[12] <- (k2_1.[12] + (W32.of_int 2));
    k2_2.[12] <- (k2_2.[12] + (W32.of_int 2));
    return (k1_1, k1_2, k2_1, k2_2);
  }
  
  proc sum_states_x8 (k_1:W32.t Array16.t, k_2:W32.t Array16.t,
                      k_3:W32.t Array16.t, k_4:W32.t Array16.t,
                      k_5:W32.t Array16.t, k_6:W32.t Array16.t,
                      k_7:W32.t Array16.t, k_8:W32.t Array16.t,
                      st_1:W32.t Array16.t, st_2:W32.t Array16.t,
                      st_3:W32.t Array16.t, st_4:W32.t Array16.t,
                      st_5:W32.t Array16.t, st_6:W32.t Array16.t,
                      st_7:W32.t Array16.t, st_8:W32.t Array16.t) : W32.t Array16.t *
                                                                    W32.t Array16.t *
                                                                    W32.t Array16.t *
                                                                    W32.t Array16.t *
                                                                    W32.t Array16.t *
                                                                    W32.t Array16.t *
                                                                    W32.t Array16.t *
                                                                    W32.t Array16.t = {
    
    
    
    k_1 <@ sum_states (k_1, st_1);
    k_2 <@ sum_states (k_2, st_2);
    k_3 <@ sum_states (k_3, st_3);
    k_4 <@ sum_states (k_4, st_4);
    k_5 <@ sum_states (k_5, st_5);
    k_6 <@ sum_states (k_6, st_6);
    k_7 <@ sum_states (k_7, st_7);
    k_8 <@ sum_states (k_8, st_8);
    return (k_1, k_2, k_3, k_4, k_5, k_6, k_7, k_8);
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
    var aux: int;
    
    var i:int;
    
    i <- 0;
    while (i < 16) {
      k.[i] <- (k.[i] `^` (loadW32 Glob.mem (plain + (W64.of_int (4 * i)))));
      Glob.mem <- storeW32 Glob.mem (output + (W64.of_int (4 * i))) k.[i];
      i <- i + 1;
    }
    (output, plain, len) <@ update_ptr (output, plain, len, 64);
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
    
    
    
    (output, plain, len) <@ store (output, plain, len, k_1);
    (output, plain, len) <@ store (output, plain, len, k_2);
    return (output, plain, len);
  }
  
  proc store_x2_last (output:W64.t, plain:W64.t, len:W32.t,
                      k_1:W32.t Array16.t, k_2:W32.t Array16.t) : unit = {
    
    var r:W32.t Array16.t;
    r <- witness;
    r <- k_1;
    if (((W32.of_int 64) \ule len)) {
      (output, plain, len) <@ store (output, plain, len, r);
      r <- k_2;
    } else {
      
    }
    store_last (output, plain, len, r);
    return ();
  }
  
  proc store_x4 (output:W64.t, plain:W64.t, len:W32.t, k_1:W32.t Array16.t,
                 k_2:W32.t Array16.t, k_3:W32.t Array16.t,
                 k_4:W32.t Array16.t) : W64.t * W64.t * W32.t = {
    
    
    
    (output, plain, len) <@ store (output, plain, len, k_1);
    (output, plain, len) <@ store (output, plain, len, k_2);
    (output, plain, len) <@ store (output, plain, len, k_3);
    (output, plain, len) <@ store (output, plain, len, k_4);
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
    
    
    
    (output, plain, len) <@ store (output, plain, len, k_1);
    (output, plain, len) <@ store (output, plain, len, k_2);
    (output, plain, len) <@ store (output, plain, len, k_3);
    (output, plain, len) <@ store (output, plain, len, k_4);
    (output, plain, len) <@ store (output, plain, len, k_5);
    (output, plain, len) <@ store (output, plain, len, k_6);
    (output, plain, len) <@ store (output, plain, len, k_7);
    (output, plain, len) <@ store (output, plain, len, k_8);
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
    
    
    
    st.[12] <- (st.[12] + (W32.of_int 8));
    return (st);
  }
  
  proc increment_counter_x8 (st_1:W32.t Array16.t, st_2:W32.t Array16.t,
                             st_3:W32.t Array16.t, st_4:W32.t Array16.t,
                             st_5:W32.t Array16.t, st_6:W32.t Array16.t,
                             st_7:W32.t Array16.t, st_8:W32.t Array16.t) : 
  W32.t Array16.t * W32.t Array16.t * W32.t Array16.t * W32.t Array16.t *
  W32.t Array16.t * W32.t Array16.t * W32.t Array16.t * W32.t Array16.t = {
    
    
    
    st_1 <@ increment_counter (st_1);
    st_2 <@ increment_counter (st_2);
    st_3 <@ increment_counter (st_3);
    st_4 <@ increment_counter (st_4);
    st_5 <@ increment_counter (st_5);
    st_6 <@ increment_counter (st_6);
    st_7 <@ increment_counter (st_7);
    st_8 <@ increment_counter (st_8);
    return (st_1, st_2, st_3, st_4, st_5, st_6, st_7, st_8);
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
  
  proc quarter_round (k:W32.t Array16.t, a:int, b:int, c:int, d:int) : W32.t Array16.t = {  
    k <@ line (k, a, b, d, 16);
    k <@ line (k, c, d, b, 12);
    k <@ line (k, a, b, d, 8);
    k <@ line (k, c, d, b, 7);
    return (k);
  }
  
  proc rounds (k:W32.t Array16.t) : W32.t Array16.t = {
    
    var c:W32.t;
    
    c <- (W32.of_int 0);
    
    while ((c \ult (W32.of_int 10))) {
      k <@ quarter_round (k, 0, 4, 8, 12);
      k <@ quarter_round (k, 2, 6, 10, 14);
      k <@ quarter_round (k, 1, 5, 9, 13);
      k <@ quarter_round (k, 3, 7, 11, 15);
      k <@ quarter_round (k, 1, 6, 11, 12);
      k <@ quarter_round (k, 0, 5, 10, 15);
      k <@ quarter_round (k, 2, 7, 8, 13);
      k <@ quarter_round (k, 3, 4, 9, 14);
      c <- (c + (W32.of_int 1));
    }
    return (k);
  }
  
  proc round_x2_body (k_1:W32.t Array16.t, k_2:W32.t Array16.t) : W32.t Array16.t *
                                                              W32.t Array16.t = {
    (k_1, k_2) = column_round_x2(k, r16, r8);
    (k_1, k_2) = diagonal_round_x2(k, r16, r8);
    return (k_1, k_2);
  }

  proc rounds_x2_body (k_1:W32.t Array16.t, k_2:W32.t Array16.t) : W32.t Array16.t *
                                                              W32.t Array16.t = {
    var c : int;
    c = 0;
    while (c < 10) {
      (k_1, k_2) <- round_x2(k_1, k_2);
      c <- c + 1;
    }
    return (k_1, k_2);
  }
  
  proc rounds_x4 (k_1:W32.t Array16.t, k_2:W32.t Array16.t,
                  k_3:W32.t Array16.t, k_4:W32.t Array16.t) : W32.t Array16.t *
                                                              W32.t Array16.t *
                                                              W32.t Array16.t *
                                                              W32.t Array16.t = {
    
    
    
    k_1 <@ rounds (k_1);
    k_2 <@ rounds (k_2);
    k_3 <@ rounds (k_3);
    k_4 <@ rounds (k_4);
    return (k_1, k_2, k_3, k_4);
  }
  
  proc rounds_x8 (k_1:W32.t Array16.t, k_2:W32.t Array16.t,
                  k_3:W32.t Array16.t, k_4:W32.t Array16.t,
                  k_5:W32.t Array16.t, k_6:W32.t Array16.t,
                  k_7:W32.t Array16.t, k_8:W32.t Array16.t) : W32.t Array16.t *
                                                              W32.t Array16.t *
                                                              W32.t Array16.t *
                                                              W32.t Array16.t *
                                                              W32.t Array16.t *
                                                              W32.t Array16.t *
                                                              W32.t Array16.t *
                                                              W32.t Array16.t = {
    
    
    
    k_1 <@ rounds (k_1);
    k_2 <@ rounds (k_2);
    k_3 <@ rounds (k_3);
    k_4 <@ rounds (k_4);
    k_5 <@ rounds (k_5);
    k_6 <@ rounds (k_6);
    k_7 <@ rounds (k_7);
    k_8 <@ rounds (k_8);
    return (k_1, k_2, k_3, k_4, k_5, k_6, k_7, k_8);
  }
  
  proc chacha20_more_than_256 (output:W64.t, plain:W64.t, len:W32.t,
                               key:W64.t, nonce:W64.t, counter:W32.t) : unit = {
    
    var st_1:W32.t Array16.t;
    var st_2:W32.t Array16.t;
    var st_3:W32.t Array16.t;
    var st_4:W32.t Array16.t;
    var st_5:W32.t Array16.t;
    var st_6:W32.t Array16.t;
    var st_7:W32.t Array16.t;
    var st_8:W32.t Array16.t;
    var k_1:W32.t Array16.t;
    var k_2:W32.t Array16.t;
    var k_3:W32.t Array16.t;
    var k_4:W32.t Array16.t;
    var k_5:W32.t Array16.t;
    var k_6:W32.t Array16.t;
    var k_7:W32.t Array16.t;
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
    (st_1, st_2, st_3, st_4, st_5, st_6, st_7, st_8) <@ init_x8 (key, nonce,
    counter);
    
    while (((W32.of_int 512) \ule len)) {
      (k_1, k_2, k_3, k_4, k_5, k_6, k_7, k_8) <@ copy_state_x8 (st_1, st_2,
      st_3, st_4, st_5, st_6, st_7, st_8);
      (k_1, k_2, k_3, k_4, k_5, k_6, k_7, k_8) <@ rounds_x8 (k_1, k_2, k_3,
      k_4, k_5, k_6, k_7, k_8);
      (k_1, k_2, k_3, k_4, k_5, k_6, k_7, k_8) <@ sum_states_x8 (k_1, k_2,
      k_3, k_4, k_5, k_6, k_7, k_8, st_1, st_2, st_3, st_4, st_5, st_6, st_7,
      st_8);
      (output, plain, len) <@ store_x8 (output, plain, len, k_1, k_2, k_3,
      k_4, k_5, k_6, k_7, k_8);
      (st_1, st_2, st_3, st_4, st_5, st_6, st_7,
      st_8) <@ increment_counter_x8 (st_1, st_2, st_3, st_4, st_5, st_6,
      st_7, st_8);
    }
    if (((W32.of_int 0) \ult len)) {
      (k_1, k_2, k_3, k_4, k_5, k_6, k_7, k_8) <@ copy_state_x8 (st_1, st_2,
      st_3, st_4, st_5, st_6, st_7, st_8);
      (k_1, k_2, k_3, k_4, k_5, k_6, k_7, k_8) <@ rounds_x8 (k_1, k_2, k_3,
      k_4, k_5, k_6, k_7, k_8);
      (k_1, k_2, k_3, k_4, k_5, k_6, k_7, k_8) <@ sum_states_x8 (k_1, k_2,
      k_3, k_4, k_5, k_6, k_7, k_8, st_1, st_2, st_3, st_4, st_5, st_6, st_7,
      st_8);
      store_x8_last (output, plain, len, k_1, k_2, k_3, k_4, k_5, k_6, k_7,
      k_8);
    } else {
      
    }
    return ();
  }
  
  proc chacha20_less_than_257 (output:W64.t, plain:W64.t, len:W32.t,
                               key:W64.t, nonce:W64.t, counter:W32.t) : unit = {
    
    var st_1:W32.t Array16.t;
    var st_2:W32.t Array16.t;
    var k1_1:W32.t Array16.t;
    var k1_2:W32.t Array16.t;
    var k2_1:W32.t Array16.t;
    var k2_2:W32.t Array16.t;
    k1_1 <- witness;
    k1_2 <- witness;
    k2_1 <- witness;
    k2_2 <- witness;
    st_1 <- witness;
    st_2 <- witness;
    (st_1, st_2) <@ init_x2 (key, nonce, counter);
    if (((W32.of_int 128) \ult len)) {
      (k1_1, k1_2, k2_1, k2_2) <@ copy_state_x4 (st_1, st_2);
      (k1_1, k1_2, k2_1, k2_2) <@ rounds_x4 (k1_1, k1_2, k2_1, k2_2);
      (k1_1, k1_2, k2_1, k2_2) <@ sum_states_x4 (k1_1, k1_2, k2_1, k2_2,
      st_1, st_2);
      (output, plain, len) <@ store_x2 (output, plain, len, k1_1, k1_2);
      store_x2_last (output, plain, len, k2_1, k2_2);
    } else {
      (k1_1, k1_2) <@ copy_state_x2 (st_1, st_2);
      (k1_1, k1_2) <@ rounds_x2 (k1_1, k1_2);
      (k1_1, k1_2) <@ sum_states_x2 (k1_1, k1_2, st_1, st_2);
      store_x2_last (output, plain, len, k1_1, k1_2);
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


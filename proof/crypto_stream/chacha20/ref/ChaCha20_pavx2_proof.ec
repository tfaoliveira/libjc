require import AllCore List Jasmin_model Int IntDiv IntExtra CoreMap LoopTransform.
import IterOp.

require import ChaCha20_Spec ChaCha20_pref ChaCha20_pref_proof ChaCha20_sref_proof ChaCha20_avx2_pv (* ChaCha20_pavx2 *).
require import Array3 Array8 Array16.
require import WArray64.

require import Distr.

hoare store_len len0 : ChaCha20_pref.M.store : 
  len = len0 /\ 64 <= to_uint len ==> to_uint res.`3 = to_uint len0 - 64.
proof.
  proc; inline *; wp => /=.
  while (0 <= i <= 64); wp; skip; 1: smt().
  move => /> &m hlen i + h0i hi .
  have eqi : to_uint (W32.of_int i) = i by rewrite W32.to_uint_small /= /#.
  rewrite ultE eqi => ?.
  rewrite W32.to_uintB 1:uleE /#.
qed.

phoare chacha20_body_ll : [ChaCha20_avx2_pv.M.chacha20_body : true ==> true] = 1%r.
proof.
  islossless.
  + by while (true) (16 - i) => //; auto => /#.
  while (true) (10 - W32.to_uint c); 2: by skip => *; rewrite ultE /= /#.
  move=> *; wp; conseq (_ : true); 2: by islossless.
  move=> &hr;rewrite ultE /= => /> *.
  by rewrite W32.to_uintD_small /= /#. 
qed.

equiv store_last : ChaCha20_pref.M.store ~ ChaCha20_avx2_pv.M.store_last : 
  ={Glob.mem, output, plain, len, k} /\ to_uint len{1} <= 64
  ==>
  ={Glob.mem} /\ to_uint res{1}.`3 = 0.
proof.
  proc => /=.
  inline ChaCha20_pref.M.update_ptr; wp.
  while (#pre /\ k{1} = s_k{2} /\ i{1} = to_uint j{2} /\ to_uint j{2} <= to_uint len{1}). 
  + wp; skip => /> &m2; rewrite W8.xorwC /= !ultE => h1 _ + h2.
    have heq : to_uint (W32.of_int (to_uint j{m2})) = to_uint j{m2}.
    + by rewrite W32.to_uint_small //=; smt (W64.to_uint_cmp).
    rewrite heq W2u32.to_uint_truncateu32 => _ h3.
    have <- /= : to_uint j{m2} + 1 = to_uint (j{m2} + W64.one).
    + by rewrite to_uintD_small //= /#.
    rewrite modz_small; 1: smt (W64.to_uint_cmp).
    by rewrite W32.of_intD W32.to_uintD_small heq /= /#.
  wp; skip => /> &m2 h1; split; 1: smt (W32.to_uint_cmp).
  move=> j + + hj; rewrite !ultE.
  have heq : to_uint (W32.of_int (to_uint j)) = to_uint j.
  + by rewrite W32.to_uint_small //=; smt (W64.to_uint_cmp).
  rewrite heq => h;rewrite W32.to_uintB 1:uleE heq /#.
qed.

equiv pref_pavx2_less_than_128: ChaCha20_avx2_pv.M.chacha20_ref_loop ~ ChaCha20_avx2_pv.M.chacha20_less_than_128 :
  ={Glob.mem, output, plain, len, st} /\ (inv_ptr output plain (to_uint len)){1} /\ to_uint len{1} <= 128 
  ==>
  ={Glob.mem}.
proof.
  proc => /=; inline ChaCha20_avx2_pv.M.store_x2_last.
  case : (64 <= W32.to_uint len{1}).
  + rcondt{2} 10; 1: by move=> &m; wp; conseq (_:true) => // &m' />; rewrite uleE.
    rcondt{1} 1; 1: by move=> &m;skip => &m' />; rewrite ultE /= /#.
    swap{2} 2 4; swap{2} [6..7] 3.
    seq 2 8 : (={Glob.mem} /\ output{1} = output0{2} /\ plain{1} = plain0{2} /\ len{1} = len0{2} /\
               st{1} = st_2{2} /\ to_uint len{1} <= 64).
    + ecall (store_store32 len{1});wp.
      call (_:true); 1: by sim.
      skip => |> &m. rewrite uleE /= => /> ????????? heq.
      rewrite heq W32.to_uintB 1:uleE //= /#.
    case (W32.zero \ult len{1}).
    + rcondt{1} 1; 1: by move=> *;skip.
      seq 2 4 : (={Glob.mem} /\ to_uint len{1} = 0).
      + by call store_last;wp; sim />. 
      by rcondf{1} 1 => // *;skip => /> ? h1;rewrite ultE h1.
    rcondf{1} 1 => //. 
    inline ChaCha20_avx2_pv.M.store_last.
    rcondf{2} 11; 1: by move=> *; wp; conseq (_:true).
    by wp; call{2} chacha20_body_ll.
  rcondf{2} 10; 1: by move=> &m; wp; conseq (_:true) => // &m' />; rewrite uleE.
  case (W32.zero \ult len{1}).
  + rcondt{1} 1; 1: by move=> *;skip.
    seq 2 10 : (={Glob.mem} /\ to_uint len{1} = 0).
    + call store_last;wp. 
      call{2} chacha20_body_ll.
      conseq (_ : k{1} = k1_1{2}); 1: by move=> |> ??; rewrite ultE /= /#.
      by sim.
    rcondf{1} 1 => //; 1: by move=> *; skip => /> ? h;rewrite ultE h.
  rcondf{1} 1 => //.
  inline ChaCha20_avx2_pv.M.store_last.
  rcondf{2} 17; 1: by move=> *; wp; conseq (_:true).
  by wp; do 2! call{2} chacha20_body_ll.
qed.

equiv pref_pavx2_between_128_255_1 : 
  ChaCha20_avx2_pv.M.chacha20_ref_loop ~ ChaCha20_avx2_pv.M.chacha20_between_128_255_1 :
  ={output, plain, len, Glob.mem, st} /\ (inv_ptr output plain (to_uint len)){1} /\ 
   128 <= to_uint len{2} <= 256 
  ==>
  ={Glob.mem}.
proof.
  proc => /=.
  transitivity{1}
    { (k, st) <@ ChaCha20_avx2_pv.M.chacha20_body(st);
      (output, plain, len) <@ ChaCha20_pref.M.store (output, plain, len, k);
      (k, st) <@ ChaCha20_avx2_pv.M.chacha20_body(st);
      (output, plain, len) <@ ChaCha20_pref.M.store (output, plain, len, k);
      ChaCha20_avx2_pv.M.chacha20_ref_loop(output, plain, len, st);
    }
    (={output, plain, len, Glob.mem, st} /\ 128 <= to_uint len{2} ==> ={Glob.mem})
    (={output, plain, len, Glob.mem, st} /\ inv_ptr output{1} plain{1} (to_uint len{1}) /\ 
      128 <= to_uint len{2} <= 256 ==> ={Glob.mem}) => //.
  + smt().
  + inline ChaCha20_avx2_pv.M.chacha20_ref_loop.
    rcondt{1} 1; 1: by move=> *;auto => ?;rewrite ultE /#. 
    rcondt{1} 3; 2: by sim.
    by move=> ?; sp; ecall (store_len len); conseq (_:true) => // />; smt (W32.ultE W32.to_uint0).
  call pref_pavx2_less_than_128.
  inline ChaCha20_avx2_pv.M.store_x2; wp.
  swap{2} 2 4; swap{2} [6..7] 1. 
  ecall (store_store32 len{1});wp.
  call (_:true); 1: by sim.
  ecall (store_store32 len{1});wp.
  call (_:true); 1: by sim.
  skip => |> *; rewrite uleE /=; split; 1: smt().
  move=> ??? ->; rewrite uleE /=.
  have h :  to_uint (len{2} - W32.of_int 64) = to_uint len{2} - 64.
  + by rewrite W32.to_uintB 1:uleE //= /#.
  rewrite h; split; 1:smt().
  move=> ??? ->;rewrite W32.to_uintB 1:uleE /= h /#.
qed.

equiv pref_pavx2_less_than_257 :  ChaCha20_avx2_pv.M.chacha20_ref ~ ChaCha20_avx2_pv.M.chacha20_less_than_257 :
  ={output, plain, len, key, nonce,counter, Glob.mem} /\
  (inv_ptr output plain (to_uint len)){1} /\ W32.to_uint len{2}  <= 256
  ==>
  ={Glob.mem}.
proof.
  proc => /=. 
  seq 1 1 : (#pre /\ st{1} = st_1{2}); 1: by sim |>.
  if{2};
    last by call pref_pavx2_less_than_128; skip => |> ??;rewrite ultE /= /#.
  call pref_pavx2_between_128_255_1; skip => |> &2.
  rewrite ultE /=; smt().
qed.

equiv pref_pavx2_between_128_255 : 
  ChaCha20_avx2_pv.M.chacha20_ref_loop ~ ChaCha20_avx2_pv.M.chacha20_between_128_255 :
  ={output, plain, len, Glob.mem, st} /\ (inv_ptr output plain (to_uint len)){1} /\ 
   to_uint len{2} <= 256 
  ==>
  ={Glob.mem}.
proof.
  proc *.
  case: (128 <= to_uint len{2}).
  + transitivity{1} { 
      ChaCha20_avx2_pv.M.chacha20_between_128_255_1(output, plain, len, st); } 
      ( ={output, plain, len, Glob.mem, st} /\ (inv_ptr output plain (to_uint len)){1} /\ 
        128 <= to_uint len{2} <= 256 ==> ={Glob.mem} )
      ( ={output, plain, len, Glob.mem, st} /\ 128 <= to_uint len{2} ==> ={Glob.mem}) => //.
    + smt().
    + by call pref_pavx2_between_128_255_1; skip => />.
    inline ChaCha20_avx2_pv.M.chacha20_between_128_255_1
           ChaCha20_avx2_pv.M.chacha20_between_128_255.
    inline ChaCha20_avx2_pv.M.chacha20_less_than_128 ChaCha20_avx2_pv.M.store_x4_last.
    rcondt{2} 20.
    + move=> &m;wp;sp;conseq (_: true) => //.
      by move=> &hr />; rewrite W32.uleE.
    swap{2} [7..8] 5. swap{2} [12..15] 5.
    by sim 4 4; wp; skip.
  transitivity{1} { ChaCha20_avx2_pv.M.chacha20_less_than_128(output, plain, len, st); }
      ( ={output, plain, len, Glob.mem, st} /\ (inv_ptr output plain (to_uint len)){1} /\ 
        to_uint len{2} < 128 ==> ={Glob.mem} )
      ( ={output, plain, len, Glob.mem, st} /\ to_uint len{2} < 128 ==> ={Glob.mem}) => //.
  + smt().
  + by call pref_pavx2_less_than_128; skip => /> /#.
  inline ChaCha20_avx2_pv.M.chacha20_less_than_128.
  inline ChaCha20_avx2_pv.M.chacha20_between_128_255
         ChaCha20_avx2_pv.M.store_x4_last.
  rcondf{2} 20.
  + move=> &m; wp; sp; conseq (_: true) => //. 
    by move=> &hr; rewrite uleE /= /#.
  sim.
  do 2! call{2} chacha20_body_ll.
  by sim 4 4; wp; skip.
qed.

clone import ExactIter as Loop0 with
   type t <- W64.t * W64.t * W32.t * W32.t Array16.t,
   op c <- 8,
   op step <- 64
   proof * by done.

module Body = {
  proc body (t: W64.t * W64.t * W32.t * W32.t Array16.t, i:int) = {
    var output, plain, len, k, st;
    (output, plain, len, st) <- t;
    (k, st) <@ ChaCha20_avx2_pv.M.chacha20_body(st);
    (output, plain, len) <@ ChaCha20_pref.M.store (output, plain, len, k);
    return (output, plain, len, st);
  }
}.

equiv pref_store len0: ChaCha20_pref.M.store ~ ChaCha20_pref.M.store : 
   ={Glob.mem, output, plain, len, k} /\ len{1} =len0 
   ==> 
   ={Glob.mem, res} /\ W32.to_uint res{1}.`3 = to_uint len0 - min (to_uint len0) 64.
proof.
  proc => /=;inline *; wp.
  while (={i,Glob.mem, output, plain, len, k} /\ 0 <= i{1} <= min 64 (to_uint len{1})).
  + by wp; skip => /> ???; rewrite ultE W32.to_uint_small /#.
  wp; skip => /> &2;split; 1: smt (W32.to_uint_cmp).
  move=> i _ + h1 h2; have heq :  to_uint (W32.of_int i) = i.
  + by rewrite W32.to_uint_small /#.
  rewrite ultE heq W32.to_uintB 1:uleE heq /#.
qed.

equiv pref_pavx2_more_than_256 : ChaCha20_avx2_pv.M.chacha20_ref ~ ChaCha20_avx2_pv.M.chacha20_more_than_256 :
  ={output, plain, len, key, nonce,counter, Glob.mem} /\
  (inv_ptr output plain (to_uint len)){1} /\ 256 < W32.to_uint len{2}
  ==>
  ={Glob.mem}.
proof.
  proc => /=.
  seq 1 1 : (  ={output, plain, len, Glob.mem} /\ inv_ptr output{1} plain{1} (to_uint len{1}) /\
                  st{1} = st_1{2}).
  + by sim |>.
  transitivity{1}
    { ILoop(Body).loop1((output, plain, len, st), to_uint len); }
    (={output, plain, len, st, Glob.mem} ==> ={Glob.mem})
    (={output, plain, len, Glob.mem} /\
       inv_ptr output{1} plain{1} (to_uint len{1}) /\ st{1} = st_1{2}==> ={Glob.mem}) => //.
   + smt().
   + inline ChaCha20_avx2_pv.M.chacha20_ref_loop ILoop(Body).loop1 Body.body.
     while (={Glob.mem} /\ (output0, plain0, len0, st0){1} = t{2} /\ 
            to_uint len0{1} = (if i <= n then n - i else 0){2}).
     + wp; sp.
       ecall (pref_store len0{1}) => /=.
       conseq (_: ={Glob.mem, k0, st0}); 2: by sim.
       move=> /> ?? + *; rewrite !W32.ultE; smt ().
     wp;skip => /> *; rewrite !W32.ultE; smt (W32.to_uint_cmp).
  transitivity{1}
    { ILoop(Body).loopc((output, plain, len, st),to_uint len); }
    ( ={output, plain, len, Glob.mem, st} ==> ={Glob.mem})
    (={output, plain, len, Glob.mem} /\ inv_ptr output{1} plain{1} (to_uint len{1}) /\ st{1} = st_1{2}
     ==> ={Glob.mem}) => //.
  + smt().
  + by call (Iloop1_loopc Body); skip.
  inline ILoop(Body).loopc.
  seq 4 1 : (={Glob.mem} /\ t{1} = (output,plain,len,st_1){2} /\ 
             to_uint len{2} = (n - i){1} /\ inv_ptr output{2} plain{2} (to_uint len{2}) /\ (n - i){1} < 512).
  + while ( #[/:-1]post /\ (i <= n){1}).
    + inline Body.body ChaCha20_avx2_pv.M.store_x8.
      inline Body.body; unroll for {1} 2;wp.
      swap{2} 20 -7. swap{2} [9..13] -7.
      seq 8 6 : (={Glob.mem} /\ inv_ptr output0{2} plain0{2} (to_uint len0{2}) /\
           to_uint len0{2} = (n - i){1} /\
           t{1} = (output0{2}, plain0{2}, len0{2}, st_2{2}) /\ 
          i{1} + 64 * 7 <= n{1}).
      + wp; ecall (store_store32 len0{1}); wp.
        call (_:true); 1: by sim.
        wp;skip => |> ?? h1 h2 h3 h4; rewrite !uleE /= => h5;split; 1: smt().
        move => ??? ->; rewrite W32.to_uintB 1:uleE //= h1; ring.
      swap{2} 15 -6. swap{2} [8..9] -6.
      seq 8 3 : (#[/:-2]pre /\ 
        t{1} = (output0{2}, plain0{2}, len0{2}, st_3{2}) /\ 
        i{1} + 64 * 6 <= n{1}).
      + wp; ecall (store_store32 len0{1}); wp.
        call (_:true); 1: by sim.
        wp;skip => |> ?? h1 h2 h3; rewrite !uleE /=; split; 1: smt().
        move => ???? ->; rewrite W32.to_uintB 1:uleE //= h2;ring.
      swap{2} 13 -5. swap{2} [7..8] -5.
      seq 8 3 : (#[/:-2]pre /\ 
        t{1} = (output0{2}, plain0{2}, len0{2}, st_4{2}) /\ 
        i{1} + 64 * 5 <= n{1}).
      + wp; ecall (store_store32 len0{1}); wp.
        call (_:true); 1: by sim.
        wp;skip => |> ?? h1 h2 h3; rewrite !uleE /=; split; 1: smt().
        move => ???? ->; rewrite W32.to_uintB 1:uleE //= h2;ring.
      swap{2} 11 -4. swap{2} [6..7] -4.
      seq 8 3 : (#[/:-2]pre /\ 
        t{1} = (output0{2}, plain0{2}, len0{2}, st_5{2}) /\ 
        i{1} + 64 * 4 <= n{1}).
      + wp; ecall (store_store32 len0{1}); wp.
        call (_:true); 1: by sim.
        wp;skip => |> ?? h1 h2 h3; rewrite !uleE /=; split; 1: smt().
        move => ???? ->; rewrite W32.to_uintB 1:uleE //= h2;ring.
      swap{2} 9 -3. swap{2} [5..6] -3.
      seq 8 3 : (#[/:-2]pre /\ 
        t{1} = (output0{2}, plain0{2}, len0{2}, st_6{2}) /\ 
        i{1} + 64 * 3 <= n{1}).
      + wp; ecall (store_store32 len0{1}); wp.
        call (_:true); 1: by sim.
        wp;skip => |> ?? h1 h2 h3; rewrite !uleE /=; split; 1: smt().
        move => ???? ->; rewrite W32.to_uintB 1:uleE //= h2;ring.
      swap{2} 7 -2. swap{2} [4..5] -2.
      seq 8 3 : (#[/:-2]pre /\ 
        t{1} = (output0{2}, plain0{2}, len0{2}, st_7{2}) /\ 
        i{1} + 64 * 2 <= n{1}).
      + wp; ecall (store_store32 len0{1}); wp.
        call (_:true); 1: by sim.
        wp;skip => |> ?? h1 h2 h3; rewrite !uleE /=; split; 1: smt().
        move => ???? ->; rewrite W32.to_uintB 1:uleE //= h2;ring.
      swap{2} 5 -1. swap{2} [3..4] -1.
      seq 8 3 : (#[/:-2]pre /\ 
        t{1} = (output0{2}, plain0{2}, len0{2}, st_8{2}) /\ 
        i{1} + 64 * 1 <= n{1}).
      + wp; ecall (store_store32 len0{1}); wp.
        call (_:true); 1: by sim.
        wp;skip => |> ?? h1 h2 h3; rewrite !uleE /=; split; 1: smt().
        move => ???? ->; rewrite W32.to_uintB 1:uleE //= h2;ring.
      ecall (store_store32 len0{1}); wp.
      call (_:true); 1: by sim.
      wp;skip => |> ?? h1 h2 h3; rewrite !uleE /=; split; 1: smt().
      move => ???? ->; rewrite W32.to_uintB uleE //= h2.
      by rewrite W32.to_uintB 1:uleE //= /#.
    wp; skip => |> &2 h1;rewrite uleE /=;split; 1: smt(W32.to_uint_cmp).
    by move=> ????; rewrite W32.uleE; smt().
  if{2}; first last.
  + rcondf{1} 1 => //.
    by move=> &m;skip => /> &hr; rewrite W32.ultE /=; smt().
  inline ChaCha20_avx2_pv.M.store_x8_last.
  case: (256 <= to_uint len{2}).
  + rcondt{2} 24.
    + by move=> &m; wp; conseq (_:true) => // /> *; rewrite W32.uleE.
    rcondt{1} 1.
    + by move=> &m; skip => /> &hr; rewrite W32.ultE /= /#.
    inline ChaCha20_avx2_pv.M.store_x4.   
    swap{2} 31 -3. swap{2} [24..28] -3. swap{2} [20..25] -7. swap{2} [9..18] -7.
    seq 2 11 : (={Glob.mem} /\
                to_uint len1{2} = n{1} - i{1} /\ inv_ptr output1{2} plain1{2} (to_uint len1{2}) /\
                t{1} = (output1{2}, plain1{2}, len1{2}, st_2{2}) /\ n{1} - i{1} < 64 * 7 /\
                64 * 3 <= to_uint len1{2}).
    + inline Body.body; wp; ecall (store_store32 len0{1}); wp.
      call (_:true); 1: by sim.
      wp; skip => |> &1 &2 h; rewrite W32.ultE W32.uleE /= => *; split; 1: smt().
      by move=> ??? ->; rewrite W32.to_uintB 1:uleE //= /#.
    rcondt{1} 1; 1 : by move=> &m; skip => /#.
    swap{2} 21 -2. swap{2} [18..19] -2. swap{2} [15..17] -6. swap{2} [8..11] -6.
    seq 2 5 : (#[/:-3]pre /\  t{1} = (output1{2}, plain1{2}, len1{2}, st_3{2}) /\
               n{1} - i{1} < 64 * 6 /\ 64 * 2 <= to_uint len1{2}).
    + inline Body.body; wp; ecall (store_store32 len0{1}); wp.
      call (_:true); 1: by sim.
      wp; skip => |> &1 &2 h; rewrite W32.uleE /= => *; split; 1: smt().
      by move=> ???? ->; rewrite W32.to_uintB 1:uleE //= /#.
    rcondt{1} 1; 1 : by move=> &m; skip => /#.
    swap{2} 17 -1. swap{2} [15..16] -1. swap{2} [13..15] -5. swap{2} [7..10] -5.

    seq 2 5 : (#[/:-3]pre /\  t{1} = (output1{2}, plain1{2}, len1{2}, st_4{2}) /\
               n{1} - i{1} < 64 * 5 /\ 64 * 1 <= to_uint len1{2}).
    + inline Body.body; wp; ecall (store_store32 len0{1}); wp.
      call (_:true); 1: by sim.
      wp; skip => |> &1 &2 h; rewrite W32.uleE /= => *; split; 1: smt().
      by move=> ???? ->; rewrite W32.to_uintB 1:uleE //= /#.
    rcondt{1} 1; 1 : by move=> &m; skip => /#.
    swap{2} [11..13] -4. swap{2} [6..9] -4.
    seq 2 5 : (#[/:-3]pre /\  t{1} = (output1{2}, plain1{2}, len1{2}, st_5{2}) /\
               n{1} - i{1} < 64 * 4 ).
    + inline Body.body; wp; ecall (store_store32 len0{1}); wp.
      call (_:true); 1: by sim.
      wp; skip => |> &1 &2 h; rewrite W32.uleE /= => *; split; 1: smt().
      by move=> ???? ->; rewrite W32.to_uintB 1:uleE //= /#.
    transitivity{1} { ChaCha20_avx2_pv.M.chacha20_ref_loop(t.`1, t.`2, t.`3, t.`4); }
       (={t,Glob.mem} /\ to_uint t{2}.`3 = n{1} - i{1} ==> ={Glob.mem}) 
       ((={Glob.mem} /\ inv_ptr output1{2} plain1{2} (to_uint len1{2})) /\
          t{1} = (output1{2}, plain1{2}, len1{2}, st_5{2}) /\ (to_uint len1{2}) < 64 * 4 ==>  ={Glob.mem}).
    + smt(). + done. 
    + inline ChaCha20_avx2_pv.M.chacha20_ref_loop. 
      while (={Glob.mem} /\ t{1} = (output0,plain0,len0,st0){2} /\
             to_uint len0{2} = (if i < n then n - i else 0){1}).
      + inline Body.body; wp.
        ecall (pref_store len0{1}).
        call (_: true); 1:by sim.
        wp; skip => /> &1 &2 h ? + ?.
        by rewrite !ultE h /#.
      by wp; skip => /> &1 &2; rewrite !ultE /=; smt(W32.to_uint_cmp).
    transitivity{2} { ChaCha20_avx2_pv.M.chacha20_between_128_255(output1, plain1, len1, st_5); }
      ((={Glob.mem} /\ inv_ptr output1{2} plain1{2} (to_uint len1{2})) /\
          t{1} = (output1{2}, plain1{2}, len1{2}, st_5{2}) /\  (to_uint len1{2}) < 64 * 4 ==>  ={Glob.mem})
      (={st_5, Glob.mem, output1, plain1, len1} ==> ={Glob.mem}).
    + smt(). + done.
    + call pref_pavx2_between_128_255; skip => |> /#.
    by inline ChaCha20_avx2_pv.M.chacha20_between_128_255; sim.
  rcondf{2} 24. 
  + by move=> &m; wp; conseq (_:true) => // /> *; rewrite W32.uleE. 
  transitivity{1} { ChaCha20_avx2_pv.M.chacha20_ref_loop(t.`1, t.`2, t.`3, t.`4); }
       (={t,Glob.mem} /\ to_uint t{2}.`3 = n{1} - i{1} ==> ={Glob.mem}) 
       ((={Glob.mem} /\ inv_ptr output{2} plain{2} (to_uint len{2})) /\
          t{1} = (output{2}, plain{2}, len{2}, st_1{2}) /\ (to_uint len{2}) < 64 * 4 ==>  ={Glob.mem}).
  + smt(). + done. 
  + inline ChaCha20_avx2_pv.M.chacha20_ref_loop. 
    while (={Glob.mem} /\ t{1} = (output0,plain0,len0,st0){2} /\
             to_uint len0{2} = (if i < n then n - i else 0){1}).
    + inline Body.body; wp.
      ecall (pref_store len0{1}).
      call (_: true); 1:by sim.
      wp; skip => /> &1 &2 h ? + ?.
      by rewrite !ultE h /#.
    by wp; skip => /> &1 &2; rewrite !ultE /=; smt(W32.to_uint_cmp).
   transitivity{2} { ChaCha20_avx2_pv.M.chacha20_between_128_255(output, plain, len, st_1); }
      ((={Glob.mem} /\ inv_ptr output{2} plain{2} (to_uint len{2})) /\
          t{1} = (output{2}, plain{2}, len{2}, st_1{2}) /\  (to_uint len{2}) < 64 * 4 ==>  ={Glob.mem})
      (={st_1, Glob.mem, output, plain, len} ==> ={Glob.mem}).
    + smt(). + done.
    + call pref_pavx2_between_128_255; skip => |> /#.
  inline ChaCha20_avx2_pv.M.chacha20_between_128_255; sim.
  do 4! call{2} chacha20_body_ll; sim.
qed.

equiv avx2_ref_pavx2 : ChaCha20_avx2_pv.M.chacha20_ref ~ ChaCha20_avx2_pv.M.chacha20_avx2 : 
  ={output, plain, len, key, nonce,counter, Glob.mem} /\
  (inv_ptr output plain (to_uint len)){1}
  ==>
  ={Glob.mem}.
proof.
  proc.
  if{2}.
  + transitivity{1} { ChaCha20_avx2_pv.M.chacha20_ref (output, plain, len, key, nonce, counter); }
       (={output, plain, len, key, nonce,counter, Glob.mem} ==> ={Glob.mem})
       (={output, plain, len, key, nonce,counter, Glob.mem} /\ 
        (inv_ptr output plain (to_uint len)){1} /\ W32.to_uint len{2}  <= 256
        ==>
        ={Glob.mem}).
    + move=> |> &2; rewrite W32.ultE W32.to_uint_small 1:// => *.
      by exists Glob.mem{2} counter{2} key{2} len{2} nonce{2} output{2} plain{2} => /> /#.
    + by move=> />.
    + by inline ChaCha20_avx2_pv.M.chacha20_ref; sim.
    call pref_pavx2_less_than_257; skip => />.

  transitivity{1} { ChaCha20_avx2_pv.M.chacha20_ref (output, plain, len, key, nonce, counter); }
       (={output, plain, len, key, nonce,counter, Glob.mem} ==> ={Glob.mem})
       (={output, plain, len, key, nonce,counter, Glob.mem} /\ 
        (inv_ptr output plain (to_uint len)){1} /\ 256 < W32.to_uint len{2}
        ==>
        ={Glob.mem}).
  + move=> /> &2; rewrite W32.ultE W32.to_uint_small 1:// => *.
    by exists Glob.mem{2} counter{2} key{2} len{2} nonce{2} output{2} plain{2} => /> /#.
  + by move=> />.
  + by inline ChaCha20_avx2_pv.M.chacha20_ref; sim.
  by call pref_pavx2_more_than_256; skip.
qed.

equiv pref_pavx2 : ChaCha20_pref.M.chacha20_ref ~ ChaCha20_avx2_pv.M.chacha20_avx2 :
  ={output, plain, len, key, nonce,counter, Glob.mem} /\
  (inv_ptr output plain (to_uint len)){1}
  ==>
  ={Glob.mem}.
proof.
 transitivity ChaCha20_avx2_pv.M.chacha20_ref
   (={output, plain, len, key, nonce, counter, Glob.mem} 
      ==>
      ={Glob.mem})
    (={output, plain, len, key, nonce, counter, Glob.mem} /\
       inv_ptr output{1} plain{1} (to_uint len{1})
      ==>
      ={Glob.mem}) => //.
  + smt(). 
  + proc => /=;inline ChaCha20_avx2_pv.M.chacha20_ref_loop.
    while (={Glob.mem} /\ st{1} = st0{2} /\
           len{1} = len0{2} /\ output{1} = output0{2} /\ plain{1} = plain0{2}).
    + inline ChaCha20_avx2_pv.M.chacha20_body.
      swap{1} -1.
      call (_: ={Glob.mem}); 1:by sim.
      wp; call (_: true); 1: by auto.
      conseq (_: st{1} = st1{2} /\ k{1} = k1{2}) => //.
      inline{1} ChaCha20_pref.M.copy_state.
      by sim (_:true). 
    by wp; sim />.
  by apply avx2_ref_pavx2.
qed.

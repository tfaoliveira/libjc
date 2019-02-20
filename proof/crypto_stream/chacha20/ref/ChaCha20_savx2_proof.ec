require import AllCore List Jasmin_model Int IntDiv CoreMap.
require import Array2 Array4 Array8 Array16.
require import WArray64.
require import ChaCha20_pref ChaCha20_pref_proof ChaCha20_sref_proof ChaCha20_pavx2 ChaCha20_savx2.

op x8 (k1 k2 k3 k4 k5 k6 k7 k8: W32.t Array16.t) =
  Array16.init (fun i => W8u32.pack8 [k1.[i]; k2.[i]; k3.[i]; k4.[i]; k5.[i]; k6.[i]; k7.[i]; k8.[i]]).
(*
  Array16.of_list W256.zero [
     W8u32.pack8 [k1.[0 ]; k2.[0 ]; k3.[0 ]; k4.[0 ]; k5.[0 ]; k6.[0 ]; k7.[0 ]; k8.[0 ]];
     W8u32.pack8 [k1.[1 ]; k2.[1 ]; k3.[1 ]; k4.[1 ]; k5.[1 ]; k6.[1 ]; k7.[1 ]; k8.[1 ]];
     W8u32.pack8 [k1.[2 ]; k2.[2 ]; k3.[2 ]; k4.[2 ]; k5.[2 ]; k6.[2 ]; k7.[2 ]; k8.[2 ]];
     W8u32.pack8 [k1.[3 ]; k2.[3 ]; k3.[3 ]; k4.[3 ]; k5.[3 ]; k6.[3 ]; k7.[3 ]; k8.[3 ]];
     W8u32.pack8 [k1.[4 ]; k2.[4 ]; k3.[4 ]; k4.[4 ]; k5.[4 ]; k6.[4 ]; k7.[4 ]; k8.[4 ]];
     W8u32.pack8 [k1.[5 ]; k2.[5 ]; k3.[5 ]; k4.[5 ]; k5.[5 ]; k6.[5 ]; k7.[5 ]; k8.[5 ]];
     W8u32.pack8 [k1.[6 ]; k2.[6 ]; k3.[6 ]; k4.[6 ]; k5.[6 ]; k6.[6 ]; k7.[6 ]; k8.[6 ]];
     W8u32.pack8 [k1.[7 ]; k2.[7 ]; k3.[7 ]; k4.[7 ]; k5.[7 ]; k6.[7 ]; k7.[7 ]; k8.[7 ]];
     W8u32.pack8 [k1.[8 ]; k2.[8 ]; k3.[8 ]; k4.[8 ]; k5.[8 ]; k6.[8 ]; k7.[8 ]; k8.[8 ]];
     W8u32.pack8 [k1.[9 ]; k2.[9 ]; k3.[9 ]; k4.[9 ]; k5.[9 ]; k6.[9 ]; k7.[9 ]; k8.[9 ]];
     W8u32.pack8 [k1.[10]; k2.[10]; k3.[10]; k4.[10]; k5.[10]; k6.[10]; k7.[10]; k8.[10]];
     W8u32.pack8 [k1.[11]; k2.[11]; k3.[11]; k4.[11]; k5.[11]; k6.[11]; k7.[11]; k8.[11]];
     W8u32.pack8 [k1.[12]; k2.[12]; k3.[12]; k4.[12]; k5.[12]; k6.[12]; k7.[12]; k8.[12]];
     W8u32.pack8 [k1.[13]; k2.[13]; k3.[13]; k4.[13]; k5.[13]; k6.[13]; k7.[13]; k8.[13]];
     W8u32.pack8 [k1.[14]; k2.[14]; k3.[14]; k4.[14]; k5.[14]; k6.[14]; k7.[14]; k8.[14]];
     W8u32.pack8 [k1.[15]; k2.[15]; k3.[15]; k4.[15]; k5.[15]; k6.[15]; k7.[15]; k8.[15]]
  ].
*)

lemma get_x8 (k1 k2 k3 k4 k5 k6 k7 k8: W32.t Array16.t) i: 
  0 <= i < 16 => 
  (x8 k1 k2 k3 k4 k5 k6 k7 k8).[i] = 
     W8u32.pack8 [k1.[i]; k2.[i]; k3.[i]; k4.[i]; k5.[i]; k6.[i]; k7.[i]; k8.[i]].
proof.
  by move => h; rewrite /x8 initE h.
qed.

lemma set_x8 (k1 k2 k3 k4 k5 k6 k7 k8: W32.t Array16.t) i w1 w2 w3 w4 w5 w6 w7 w8: 
  0 <= i < 16 =>
  (x8 k1 k2 k3 k4 k5 k6 k7 k8).[i <- W8u32.pack8 [w1;w2;w3;w4;w5;w6;w7;w8]] =
  x8 k1.[i<-w1] k2.[i<-w2] k3.[i<-w3] k4.[i<-w4] k5.[i<-w5] k6.[i<-w6] k7.[i<-w7] k8.[i<-w8].
proof.
  move=> hi; apply Array16.ext_eq => j hj.  
  rewrite /x8 setE 2!initE hj /= initE hj /= !Array16.get_set_if hi /=.
  by case: (j = i).
qed.

(* Move this *)
lemma x86_8u32_rol_xor r w : 0 < r < 32 => 
  x86_VPSLL_8u32 w (W8.of_int r) `^` x86_VPSRL_8u32 w (W8.of_int (32 - r))  =
  map (transpose W32.rol r) w.
proof.
  move=> hr;rewrite /x86_VPSRL_8u32 /x86_VPSLL_8u32 /(`>>`) /(`<<`).
  rewrite !W8.to_uint_small /= 1,2:/# /=.
  rewrite /map; congr; apply W8u32.Pack.ext_eq => j hj.
  by rewrite map2iE 1:// 3!initE hj /= W32.rol_xor 1:/# 2?modz_small 1,2:/#.
qed.

phoare rotate_x8_s k0 i0 r0 : 
  [M.rotate_x8_s : 
    k = k0 /\ i = i0 /\ r = r0 /\ 0 <= i < 16 /\ 0 < r < 32 /\ r16 = g_r16 /\ r8 = g_r8 
    ==>
    res = k0.[i0 <- W8u32.pack8_t (W8u32.Pack.map (fun (x:W32.t) => rol x r0) (W8u32.unpack32 k0.[i0]))]] = 1%r.
proof.
  proc => /=.
  if; 1: by wp;skip.  
  if; 1: by wp;skip.
  wp;skip => /> &m hi1 hi2 hr1 hr2 _ _; congr.
  by rewrite W256.xorwC get_setE 1:// /= x86_8u32_rol_xor.
qed.

equiv eq_line_x8_v_ a_ c_ k_ : ChaCha20_pavx2.M.line_x1_8 ~ M._line_x8_v :
  ={a,b,c,r} /\ k{2} = k_ /\ a{1} = a_ /\ c{1} = c_ /\
   k{2} = (x8 k1 k2 k3 k4 k5 k6 k7 k8){1} /\ 
   0 <= a{1} < 16 /\ 0 <= b{1} < 16 /\ 0 <= c{1} < 16 /\ 0 < r{1} < 32 /\
   r16{2} = g_r16 /\ r8{2} = g_r8 
  ==> 
  res{2} = x8 res{1}.`1 res{1}.`2 res{1}.`3 res{1}.`4 res{1}.`5 res{1}.`6 res{1}.`7 res{1}.`8 /\
  forall i, 0 <= i < 16 => i <> a_ => i <> c_ => res{2}.[i] = k_.[i].
proof.
  proc => /=.
  inline{1} ChaCha20_pref.M.line.
  interleave{1} [2:4] [11:4] [20:4] [29:4] [38:4] [47:4] [56:4] [65:4] 1.
  swap{1} 1 32.
  interleave{1} [33:1] [38:1] [43:1] [48:1] [53:1] [58:1] [63:1] [68:1] 5.
  sp 32 0.
  seq 16 1 : (#{/~k{2}}pre /\ k{2} = (x8 k k0 k9 k10 k11 k12 k13 k14){1} /\
                forall i, 0 <= i < 16 => i <> a_ => i <> c_ => k{2}.[i] = k_.[i]).
  + wp;skip => /> &1 &2 ha1 ha2 hb1 hb2 hc1 hc2 hr1 hr2.
    split; 1: by rewrite /x86_VPADD_8u32 !get_x8 1,2:// -set_x8.
    by move=> ??? h ?;rewrite Array16.get_setE // h.
  seq 8 1 : (#pre). 
  + wp;skip => /> &1 &2 ha1 ha2 hb1 hb2 hc1 hc2 hr1 hr2 hi.
    split; 1: by rewrite !get_x8 1,2:// -set_x8.
    by move=> ???? h;rewrite Array16.get_setE // h /= hi.
  wp;ecall{2} (rotate_x8_s k{2} c{2} r{2}); skip => /> &1 &2 ha1 ha2 hb1 hb2 hc1 hc2 hr1 hr2 hi.
  split; 1: by rewrite !get_x8 1,2:// -set_x8.
  by move=> ???? h;rewrite Array16.get_setE // h /= hi.
qed.

equiv eq_line_2 a0_ c0_ a1_ c1_ k_ :  ChaCha20_pavx2.M.line_2_x1_8 ~ M.line_x8_v : 
  ={a0,b0,c0,r0,a1,b1,c1,r1} /\ k{2} = k_ /\ a0{1} = a0_ /\ c0{1} = c0_ /\ a1{1} = a1_ /\ c1{1} = c1_ /\
   k{2} = (x8 k1 k2 k3 k4 k5 k6 k7 k8){1} /\ 
   0 <= a0{1} < 16 /\ 0 <= b0{1} < 16 /\ 0 <= c0{1} < 16 /\ 0 < r0{1} < 32 /\
   0 <= a1{1} < 16 /\ 0 <= b1{1} < 16 /\ 0 <= c1{1} < 16 /\ 0 < r1{1} < 32 /\
   r16{2} = g_r16 /\ r8{2} = g_r8 
  ==> 
  res{2} = x8 res{1}.`1 res{1}.`2 res{1}.`3 res{1}.`4 res{1}.`5 res{1}.`6 res{1}.`7 res{1}.`8 /\
  forall i, 0 <= i < 16 => i <> a0_ => i <> c0_ => i <> a1_ => i <> c1_ => res{2}.[i] = k_.[i].
proof.
  proc => /=.
  inline{1} ChaCha20_pavx2.M.line_2.
  interleave{1} [2:8] [18:8] [34:8] [50:8] [66:8] [82:8] [98:8] [114:8] 1.
  swap{1} 1 64.
  interleave{1} [65:1] [73:1] [81:1] [89:1] [97:1] [105:1] [113:1] [121:1] 8.
  sp 64 0.
  seq 16 1 : (#{/~k{2}}pre /\ k{2} = (x8 k k0 k9 k10 k11 k12 k13 k14){1} /\
     forall i, 0 <= i < 16 => i <> a0_ => i <> c0_ => i <> a1_ => i <> c1_ => k{2}.[i] = k_.[i]).
  + wp;skip => /> &1 &2 ha1 ha2 hb1 hb2 hc1 hc2 hd1 hd2 ha1' ha2' hb1' hb2' hc1' hc2' hd1' hd2'.
    split; 1: by rewrite /x86_VPADD_8u32 !get_x8 1,2:// -set_x8.
    by move=> ??? h *;rewrite Array16.get_setE // h.
  seq 8 1 : (#pre).
  + wp;skip => /> &1 &2 ha1 ha2 hb1 hb2 hc1 hc2 hd1 hd2 ha1' ha2' hb1' hb2' hc1' hc2' hd1' hd2' hi.
    split; 1: by rewrite /x86_VPADD_8u32 !get_x8 1,2:// -set_x8. 
    by move=> ????? h *;rewrite Array16.get_setE // h /= hi.
  seq 8 1 : (#pre). 
  + wp;skip => /> &1 &2 ha1 ha2 hb1 hb2 hc1 hc2 hd1 hd2 ha1' ha2' hb1' hb2' hc1' hc2' hd1' hd2' hi.
    split; 1: by rewrite !get_x8 1,2:// -set_x8.
    by move=> ???? h *;rewrite Array16.get_setE // h /= hi.
  seq 8 1 : (#pre). 
  + wp;skip => /> &1 &2 ha1 ha2 hb1 hb2 hc1 hc2 hd1 hd2 ha1' ha2' hb1' hb2' hc1' hc2' hd1' hd2' hi.
    split; 1: by rewrite !get_x8 1,2:// -set_x8.
    by move=> ?????? h;rewrite Array16.get_setE // h /= hi.
  seq 8 1 : (#pre).
  + wp; ecall{2} (rotate_x8_s k{2} c0{2} r0{2}); skip => /> 
      &1 &2 ha1 ha2 hb1 hb2 hc1 hc2 hd1 hd2 ha1' ha2' hb1' hb2' hc1' hc2' hd1' hd2' hi.
    split; 1: by rewrite !get_x8 1,2:// -set_x8.
    by move=> ???? h *;rewrite Array16.get_setE // h /= hi.
  wp; ecall{2} (rotate_x8_s k{2} c1{2} r1{2}); skip => /> 
    &1 &2 ha1 ha2 hb1 hb2 hc1 hc2 hd1 hd2 ha1' ha2' hb1' hb2' hc1' hc2' hd1' hd2' hi.
  split; 1: by rewrite !get_x8 1,2:// -set_x8.
  by move=> ?????? h;rewrite Array16.get_setE // h /= hi.
qed.

equiv eq_double_quarter_round_x8 a0_ b0_ c0_ d0_ a1_ b1_ c1_ d1_ k_ : 
    ChaCha20_pavx2.M.double_quarter_round_x8 ~ 
    ChaCha20_savx2.M.double_quarter_round_x8: 
    ={a0,b0,c0,d0,a1,b1,c1,d1} /\
     k{2} = k_ /\ a0{1} = a0_ /\ b0{1} = b0_ /\ c0{1} = c0_ /\ d0{1} = d0_ /\
                  a1{1} = a1_ /\ b1{1} = b1_ /\ c1{1} = c1_ /\ d1{1} = d1_ /\ 
     k{2} = (x8 k1 k2 k3 k4 k5 k6 k7 k8){1}  /\ 
     0 <= a0{1} < 16 /\ 0 <= b0{1} < 16 /\ 0 <= c0{1} < 16 /\ 0 <= d0{1} < 16  /\
     0 <= a1{1} < 16 /\ 0 <= b1{1} < 16 /\ 0 <= c1{1} < 16 /\ 0 <= d1{1} < 16  /\
     r16{2} = g_r16 /\ r8{2} = g_r8 
    ==> 
    res{2} = x8 res{1}.`1 res{1}.`2 res{1}.`3 res{1}.`4 res{1}.`5 res{1}.`6 res{1}.`7 res{1}.`8 /\
     forall i, 0 <= i < 16 => i <> a0_ => i <> b0_ => i <> c0_ => i <> d0_ =>
                             i <> a1_ => i <> b1_ => i <> c1_ => i <> d1_ =>
               res{2}.[i] = k_.[i].
proof.
  proc => /=; wp.
  ecall (eq_line_x8_v_ c1_ b1_ k{2})=> /=.
  ecall (eq_line_2 c0_ b0_ a1_ d1_ k{2})=> /=.
  ecall (eq_line_2 a0_ d0_ c1_ b1_ k{2})=> /=.
  ecall (eq_line_2 c0_ b0_ a1_ d1_ k{2})=> /=.
  ecall (eq_line_x8_v_ a0_ d0_ k{2})=> /=; skip => /> /#.
qed.

equiv eq_column_round_x8 : ChaCha20_pavx2.M.column_round_x8 ~ ChaCha20_savx2.M.column_round_x8 : 
  k{2} = (x8 k1 k2 k3 k4 k5 k6 k7 k8){1}  /\
   k15{2} = k{2}.[15] /\ s_r16{2} = g_r16 /\ s_r8{2} = g_r8 
  ==> 
  res{2}.`1 = x8 res{1}.`1 res{1}.`2 res{1}.`3 res{1}.`4 res{1}.`5 res{1}.`6 res{1}.`7 res{1}.`8 /\
   res{2}.`2 = res{2}.`1.[14].
proof.
  proc => /=; wp.
  ecall (eq_double_quarter_round_x8 1 5 9 13 3 7 11 15 k{2}); wp => /=.
  ecall (eq_double_quarter_round_x8 0 4 8 12 2 6 10 14 k{2}); wp => /=.
  skip => /> &1 r1 hi.
  by rewrite -(hi 15) // Array16.set_notmod /= => r2 ->. 
qed.

equiv eq_diagonal_round_x8 : ChaCha20_pavx2.M.diagonal_round_x8 ~ ChaCha20_savx2.M.diagonal_round_x8 : 
  k{2} = (x8 k1 k2 k3 k4 k5 k6 k7 k8){1}  /\
   k14{2} = k{2}.[14] /\ s_r16{2} = g_r16 /\ s_r8{2} = g_r8 
  ==> 
  res{2}.`1 = x8 res{1}.`1 res{1}.`2 res{1}.`3 res{1}.`4 res{1}.`5 res{1}.`6 res{1}.`7 res{1}.`8 /\
   res{2}.`2 = res{2}.`1.[15].
proof.
  proc => /=; wp.
  ecall (eq_double_quarter_round_x8 2 7 8 13 3 4 9 14 k{2}); wp => /=.
  ecall (eq_double_quarter_round_x8 1 6 11 12 0 5 10 15 k{2}); wp => /=.
  skip => /> &1 r1 hi.
  by rewrite -(hi 14) // Array16.set_notmod /= => r2 ->. 
qed.

equiv eq_rounds_x8 : ChaCha20_pavx2.M.rounds_x8 ~ ChaCha20_savx2.M.rounds_x8 :
  k{2} = (x8 k1 k2 k3 k4 k5 k6 k7 k8){1} /\ s_r16{2} = g_r16 /\ s_r8{2} = g_r8 
  ==> 
  res{2} = x8 res{1}.`1 res{1}.`2 res{1}.`3 res{1}.`4 res{1}.`5 res{1}.`6 res{1}.`7 res{1}.`8.
proof.
  proc => /=; wp.
  while (#pre /\ c{1} = W64.to_uint c{2} /\ (k15 = k.[15]){2}).
  + wp; call eq_diagonal_round_x8; call eq_column_round_x8; skip => /> *.
    rewrite ultE /=;rewrite to_uintD_small //= 1:/#.
  by wp; skip => /> *;rewrite Array16.set_notmod.
qed.
 
equiv eq_init_x8 : ChaCha20_pavx2.M.init_x8 ~ M.init_x8 : 
  key{1} = to_uint key{2} /\ nonce{1} = to_uint nonce{2} /\ ={counter,Glob.mem} /\
  (key + 32 < W64.modulus /\ nonce + 12 < W64.modulus){1} 
  ==>
  res{2} = x8 res{1}.`1 res{1}.`2 res{1}.`3 res{1}.`4 res{1}.`5 res{1}.`6 res{1}.`7 res{1}.`8.
proof.
  proc => /=.
  inline ChaCha20_pref.M.init.
  do 2! unroll for{1} ^while; do 2! unroll for{2} ^while.
  conseq (_ : Array16.all_eq st_{2} (x8 st1{1} st2{1} st3{1} st4{1} st5{1} st6{1} st7{1} st8{1})).
  + by move=> *; apply Array16.all_eq_eq.
  wp; skip; cbv delta => /> &2 h1 h2.
  have -> /= : to_uint (key{2} + W64.of_int 4) = to_uint key{2} + 4.
  + by rewrite W64.to_uintD_small //= /#.
  have -> /= : to_uint (key{2} + W64.of_int 8) = to_uint key{2} + 8.  
  + by rewrite W64.to_uintD_small //= /#.
  have -> /= : to_uint (key{2} + W64.of_int 12) = to_uint key{2} + 12.  
  + by rewrite W64.to_uintD_small //= /#.
  have -> /= : to_uint (key{2} + W64.of_int 16) = to_uint key{2} + 16.  
  + by rewrite W64.to_uintD_small //= /#.
  have -> /= : to_uint (key{2} + W64.of_int 20) = to_uint key{2} + 20.  
  + by rewrite W64.to_uintD_small //= /#.
  have -> /= : to_uint (key{2} + W64.of_int 24) = to_uint key{2} + 24.  
  + by rewrite W64.to_uintD_small //= /#.
  have -> /= : to_uint (key{2} + W64.of_int 28) = to_uint key{2} + 28.  
  + by rewrite W64.to_uintD_small //= /#.
  have -> /= : to_uint (nonce{2} + W64.of_int 4) = to_uint nonce{2} + 4.
  + by rewrite W64.to_uintD_small //= /#.
  have -> /= : to_uint (nonce{2} + W64.of_int 8) = to_uint nonce{2} + 8.  
  + by rewrite W64.to_uintD_small //= /#.
  congr;apply W8u32.Pack.all_eq_eq => /=.
  rewrite /W8u32.Pack.all_eq /= !W8u32.bits32_div //.
  by rewrite /(%/) /=; do !rewrite -W32.of_int_mod /(%%) /=.
qed.
  
equiv eq_increment_counter_x8 : ChaCha20_pavx2.M.increment_counter_x8 ~ M.increment_counter_x8 : 
  s{2} = (x8 st1 st2 st3 st4 st5 st6 st7 st8){1} 
  ==> 
  res{2} = x8 res{1}.`1 res{1}.`2 res{1}.`3 res{1}.`4 res{1}.`5 res{1}.`6 res{1}.`7 res{1}.`8.
proof.
  proc => /=; wp; skip => /> &1.
  rewrite -set_x8 1:// get_x8 1://; congr.
  rewrite /x86_VPADD_8u32 /= /unpack32 /map2 /=; congr; apply W8u32.Pack.all_eq_eq => /=.
  rewrite /W8u32.Pack.all_eq /= !W8u32.bits32_div //.
  rewrite 8!(W32.WRingA.addrC _ (W32.of_int 8)).
  by rewrite /(%/) /=; do !rewrite -W32.of_int_mod /(%%) /=.
qed.

equiv eq_store_x8 : ChaCha20_pavx2_cf.M.store_x8 ~  M.store_x8 :
  k{2} = (x8 k_1 k_2 k_3 k_4 k_5 k_6 k_7 k_8){1} /\
  output{1} = to_uint output{2} /\ plain{1} = to_uint plain{2} /\ len{1} = to_uint len{2} /\
  (good_ptr output plain len){1} /\ ={Glob.mem} 
  ==>
  res{1}.`1 = to_uint res{2}.`1 /\ res{1}.`2 = to_uint res{2}.`2 /\ res{1}.`3 = to_uint res{2}.`3 /\ 
  (good_ptr res{1}.`1 res{1}.`2 res{1}.`3){1} /\ ={Glob.mem}.
proof.
admitted.

equiv eq_store_x8_last : ChaCha20_pavx2_cf.M.store_x8_last ~  M.store_x8_last :
  k{2} = (x8 k_1 k_2 k_3 k_4 k_5 k_6 k_7 k_8){1} /\
  output{1} = to_uint output{2} /\ plain{1} = to_uint plain{2} /\ len{1} = to_uint len{2} /\
  (good_ptr output plain len){1} /\ ={Glob.mem} 
  ==>
  ={Glob.mem}.
proof.
admitted.

equiv eq_sum_states_x8 : ChaCha20_pavx2.M.sum_states_x8 ~ M.sum_states_x8 :
  k{2} = (x8 k1 k2 k3 k4 k5 k6 k7 k8){1} /\
  st{2} = (x8 st1 st2 st3 st4 st5 st6 st7 st8){1} 
  ==>
  res{2} = x8 res{1}.`1 res{1}.`2 res{1}.`3 res{1}.`4 res{1}.`5 res{1}.`6 res{1}.`7 res{1}.`8.
proof.
  proc => /=.
  inline *.
  transitivity*{1} { 
    i <- 0;
    while (i < 16) {
      k1.[i] <- k1.[i] + st1.[i];
      k2.[i] <- k2.[i] + st2.[i];
      k3.[i] <- k3.[i] + st3.[i];
      k4.[i] <- k4.[i] + st4.[i];
      k5.[i] <- k5.[i] + st5.[i];
      k6.[i] <- k6.[i] + st6.[i];
      k7.[i] <- k7.[i] + st7.[i];
      k8.[i] <- k8.[i] + st8.[i];
      i <- i + 1;
    }
  }. + smt(). + done.
  + by do 8! unroll for{1} ^while; unroll for{2} ^while; wp; skip => />.
  while (={i} /\ #pre /\ 0 <= i{1}); 2: by auto.
  wp; skip => /> &1 &2 ??; split; 2:smt().
  by rewrite !get_x8 1,2:// -set_x8 1:// /x86_VPADD_8u32.
qed.

equiv eq_chacha20_more_than_256 : 
  ChaCha20_pavx2.M.chacha20_more_than_256 ~ ChaCha20_savx2.M.chacha20_more_than_256 : 
  output{1} = to_uint output{2} /\ plain{1} = to_uint plain{2} /\ len{1} = to_uint len{2} /\
  key{1} = to_uint key{2} /\ nonce{1} = to_uint nonce{2} /\ ={counter,Glob.mem} /\
  (key + 32 < W64.modulus /\ nonce + 12 < W64.modulus){1} /\
  (good_ptr output plain len){1}
  ==>
  ={Glob.mem}.
proof.
  proc => /=.
  seq 1 4 : (s_r16{2} = g_r16 /\ s_r8{2} = g_r8 /\ st{2} = (x8 st1 st2 st3 st4 st5 st6 st7 st8){1} /\
            output{1} = to_uint output{2} /\ plain{1} = to_uint plain{2} /\ len{1} = to_uint len{2} /\
            (good_ptr output plain len){1} /\ ={Glob.mem}).
  + call eq_init_x8; inline{2} M.load_shufb_cmd; wp; skip => />.
  seq 1 1 : (#pre).
  + while (#pre). 
    + call eq_increment_counter_x8 => /=.
      call eq_store_x8 => /=.
      call eq_sum_states_x8 => /=.   
      call eq_rounds_x8 => /=. 
      by inline M.copy_state_x8; wp; skip => |> &2 ?? _ r1 r2 _ _ h _; rewrite uleE /= -h.
    by skip => |> *; rewrite uleE.
  if; last by done.
  + by move=> /> *; rewrite ultE.
  call eq_store_x8_last.
  call eq_sum_states_x8 => /=.   
  call eq_rounds_x8 => /=. 
  by inline M.copy_state_x8; wp; skip.
qed.

(* --------------------------------------------------------------------- *)
(*  chach20_less_than_257                                                *)

op x2 (k1 k2:W32.t Array16.t) = 
  Array4.init (fun i => 
    let i = 4*i in
    W8u32.pack8 [k1.[i]; k1.[i+1]; k1.[i+2]; k1.[i+3]; k2.[i]; k2.[i+1]; k2.[i+2]; k2.[i+3]]).

op x2_ (k1 k2:W32.t Array16.t) = 
  Array4.of_list witness [
    W8u32.pack8 [k1.[0]; k1.[1]; k1.[2]; k1.[3]; k1.[4]; k1.[5]; k1.[6]; k1.[7]];
    W8u32.pack8 [k1.[8]; k1.[9]; k1.[10]; k1.[11]; k1.[12]; k1.[13]; k1.[14]; k1.[15]];
    W8u32.pack8 [k2.[0]; k2.[1]; k2.[2]; k2.[3]; k2.[4]; k2.[5]; k2.[6]; k2.[7]];
    W8u32.pack8 [k2.[8]; k2.[9]; k2.[10]; k2.[11]; k2.[12]; k2.[13]; k2.[14]; k2.[15]] ].

op x_ (k1:W32.t Array16.t) = 
  Array2.of_list witness [
    W8u32.pack8 [k1.[0]; k1.[1]; k1.[2]; k1.[3]; k1.[4]; k1.[5]; k1.[6]; k1.[7]];
    W8u32.pack8 [k1.[8]; k1.[9]; k1.[10]; k1.[11]; k1.[12]; k1.[13]; k1.[14]; k1.[15]] ].

(* FIXME need more lemmas *)
lemma g_sigma_pack : g_sigma = pack4 [g_sigma0; g_sigma1; g_sigma2; g_sigma3].
proof.
  rewrite -(W4u32.unpack32K g_sigma); congr.
  apply W4u32.Pack.all_eq_eq; rewrite /all_eq /= !W4u32.bits32_div //; cbv delta.
  by do !(rewrite -W32.of_int_mod; cbv delta).
qed.

lemma g_p0_pack : g_p0 = W4u32.pack4 [W32.zero; W32.zero; W32.zero; W32.zero].
proof.
  rewrite -(W4u32.unpack32K g_p0); congr.
  apply W4u32.Pack.all_eq_eq; rewrite /all_eq /= !W4u32.bits32_div //; cbv delta.
qed.

lemma g_p1_pack : 
  g_p1 = W8u32.pack8 [W32.zero; W32.zero; W32.zero; W32.zero; W32.one; W32.zero; W32.zero; W32.zero].
proof.
  rewrite -(W8u32.unpack32K g_p1); congr.
  apply W8u32.Pack.all_eq_eq; rewrite /all_eq /= !W8u32.bits32_div //; cbv delta.
  by do !(rewrite -W32.of_int_mod; cbv delta).
qed.

lemma g_p2_pack :
  g_p2 = pack8[W32.of_int 2; W32.zero; W32.zero; W32.zero; W32.of_int 2; W32.zero; W32.zero; W32.zero].
proof.
  rewrite -(W8u32.unpack32K g_p2); congr.
  apply W8u32.Pack.all_eq_eq; rewrite /all_eq /= !W8u32.bits32_div //; cbv delta.
  by do !(rewrite -W32.of_int_mod; cbv delta).
qed.

lemma pack2_2u32_4u32 (w0 w1 w2 w3 : W32.t):
  pack2 [pack2 [w0; w1]; pack2 [w2; w3]] = pack4 [w0; w1; w2; w3].
proof. by apply W128.all_eq_eq;cbv W128.all_eq (%/) (%%). qed.

lemma loadW64_bits32 m p i : 0 <= i < 2 =>
  loadW64 m p \bits32 i = loadW32 m (p + i * 4).
proof. 
  move=> hi; rewrite /loadW64 /loadW32.
  apply W32.wordP => j hj.
  rewrite bits32iE // pack4wE // initiE; 1:by apply divz_cmp.
  rewrite pack8wE; 1:by apply W2u32.in_bound. 
  rewrite initiE /=; 1:by apply divz_cmp => //=;apply W2u32.in_bound.
  have -> : i * 32 = (i * 4) * 8 by ring. 
  by rewrite modzMDl divzMDl // -addzA. 
qed.

lemma load2u32 mem p : 
  pack2 [loadW32 mem p; loadW32 mem (p + 4)] = loadW64 mem p.
proof.
  have -> : W2u32.Pack.of_list [loadW32 mem p; loadW32 mem (p + 4)] =
            W2u32.Pack.init (fun i => loadW32 mem (p + i * 4)).
  + by apply W2u32.Pack.all_eqP; rewrite /all_eq.
  apply (can_inj _ _ W2u32.unpack32K); apply W2u32.Pack.packP => i hi.
  by rewrite pack2K initiE //= get_unpack32 // loadW64_bits32.
qed.

equiv eq_init_x2 :
  ChaCha20_pavx2.M.init_x2 ~ ChaCha20_savx2.M.init_x2 : 
  key{1} = to_uint key{2} /\ nonce{1} = to_uint nonce{2} /\ ={counter,Glob.mem} /\
  (key + 32 < W64.modulus /\ nonce + 12 < W64.modulus){1}
  ==>
  res{2} = x2 res{1}.`1 res{1}.`2.
proof.
  proc => /=; inline *.
  conseq (_: Array4.all_eq st{2} (x2 st_1 st_2){1}).
  + by move=> *; apply Array4.all_eq_eq.
  do 2! unroll for{1} ^while; wp; skip => /> *.
  rewrite /x2 /= /x86_VPBROADCAST_2u128 /= -!load4u32 -!pack2_4u32_8u32 /=.
  rewrite !W64.to_uintD_small /= 1,2:/# g_sigma_pack g_p0_pack/=.
  rewrite pack2_4u32_8u32 /=.
  rewrite /x86_VPINSR_4u32 /(%%) /= -pack2_2u32_4u32 -load2u32 /x86_VPINSR_2u64 /(%%) /=.
  by rewrite pack2_2u32_4u32 pack2_4u32_8u32 g_p1_pack /x86_VPADD_8u32.
qed.

lemma get_storeW256E m p w j: 
    (storeW256 m p w).[j] = if p <= j < p + 32 then w \bits8 j - p else m.[j].
proof. rewrite storeW256E /= get_storesE /= /#. qed.

lemma get8_pack8u32 f j: 
  pack8_t (W8u32.Pack.init f) \bits8 j = 
    if 0 <= j < 32 then f (j %/ 4) \bits8 (j %% 4) else W8.zero.
proof.
  rewrite pack8E W8.wordP => i hi.
  rewrite bits8E /= initE hi /= initE.
  have -> /= : (0 <= j * 8 + i < 256) <=> (0 <= j < 32) by smt().
  case : (0 <= j < 32) => hj //=.
  rewrite bits8E /= initE.
  have -> : (j * 8 + i) %/ 32 = j %/4.
  + rewrite {1}(divz_eq j 4) mulzDl mulzA /= -addzA divzMDl //.
    by rewrite (divz_small _ 32) //; smt (modz_cmp).
  rewrite initE hi /= divz_cmp //=; congr.
  rewrite {1}(divz_eq j 4) mulzDl mulzA /= -addzA modzMDl modz_small //; smt (modz_cmp).
qed.

lemma pack8_init_shift8 (k:W32.t Array16.t) : 
  pack8 [k.[8]; k.[9]; k.[10]; k.[11]; k.[12]; k.[13]; k.[14]; k.[15]] = 
  pack8_t (W8u32.Pack.init (fun i => k.[8 + i])).
proof. by congr; apply W8u32.Pack.all_eq_eq; cbv delta. qed.

lemma pack8_init (k:W32.t Array16.t) : 
  pack8 [k.[0]; k.[1]; k.[2]; k.[3]; k.[4]; k.[5]; k.[6]; k.[7]] = 
  pack8_t (W8u32.Pack.init (fun i => k.[i])).
proof. by congr; apply W8u32.Pack.all_eq_eq; cbv delta. qed.

lemma store_256_xor_spec output (k1:W32.t Array16.t) mem plain j:
  (if output + 32 <= j < output + 64 then
     (pack8 [k1.[8]; k1.[9]; k1.[10]; k1.[11]; k1.[12]; k1.[13]; k1.[14]; k1.[15]] \bits8 j - (output + 32)) `^`
     (loadW256 mem (plain + 32) \bits8 j - (output + 32))
   else if output <= j < output + 32 then
     (pack8 [k1.[0]; k1.[1]; k1.[2]; k1.[3]; k1.[4]; k1.[5]; k1.[6]; k1.[7]] \bits8 j - output) `^`
     (loadW256 mem plain \bits8 j - output)
   else mem.[j]) =
   if in_range output 64 j then (init32 ("_.[_]" k1)).[j - output] `^` mem.[plain + (j - output)]
   else mem.[j].
proof.
  case: (output + 32 <= j < output + 64) => hin2.
  + have -> /= : in_range output 64 j by smt().
    rewrite /init32 /loadW256 /= initiE; 1: smt (W64.to_uint_cmp).
    have h1 : 0 <= j - (output + 32) < 32 by smt().
    rewrite /= pack32bE 1:// initiE 1:// /=. 
    have -> : plain + 32 + (j - (output + 32)) = plain + (j - output) by ring.
    congr; rewrite pack8_init_shift8 get8_pack8u32 h1 /=.    
    by rewrite Ring.IntID.opprD addzA divzDr 1:// dvdz_modzDr 1://;congr.
  case:(output <= j < output + 32) => hin3.  
  + have -> /= : in_range output 64 j by smt().
    rewrite /init32 /loadW256 /= initiE; 1: smt (W64.to_uint_cmp).
    have h1 : 0 <= j - output < 32 by smt().
    rewrite /= pack8_init get8_pack8u32 h1 /=. 
    by rewrite pack32bE 1:// initiE.
  have -> // : !(in_range output 64 j) by smt().
qed.

phoare store_x2_spec output0 plain0 len0 k1 k2 mem0 : [ChaCha20_savx2.M.store_x2 : 
  to_uint output = output0 /\ to_uint plain = plain0 /\ to_uint len = len0 /\ k = x2_ k1 k2 /\ Glob.mem = mem0 /\ 
  128 <= to_uint len /\ (good_ptr output0 plain0 len0) 
  ==>
  to_uint res.`1 = output0 + 128 /\
  to_uint res.`2 = plain0 + 128 /\
  to_uint res.`3 = len0 - 128 /\
  forall j, 
    Glob.mem.[j] =
      if in_range output0 64 j then
        let j = j - output0 in
        (init32 (fun (i0 : int) => k1.[i0])).[j] `^` mem0.[plain0 + j]
      else if in_range (output0 + 64) 64 j then
        let j = j - (output0 + 64) in
        (init32 (fun (i0 : int) => k2.[i0])).[j] `^` mem0.[plain0 + 64 + j]
      else mem0.[j]]= 1%r.
proof.
  proc => /=.
  inline M.update_ptr; wp.
  do 2! unroll for ^while.
  wp; skip => &hr /> hlen hout hplain.
  rewrite !W64.to_uintD_small /= 1..-2:/#.
  rewrite W32.to_uintB 1:uleE /= 1:/# => j.
  rewrite !get_storeW256E /x2_ /=.
  case: (in_range (to_uint output{hr}) 64 j) => hin.
  + have -> : !(to_uint output{hr} + 96 <= j < to_uint output{hr} + 128) by smt().
    have -> /= : !(to_uint output{hr} + 64 <= j < to_uint output{hr} + 96) by smt().
    by rewrite store_256_xor_spec hin.
  have -> : !(to_uint output{hr} + 32 <= j < to_uint output{hr} + 64) by smt().
  have -> /= : !(to_uint output{hr} <= j < to_uint output{hr} + 32) by smt().
  by rewrite -store_256_xor_spec.
qed.

equiv eq_store_x2 : ChaCha20_pavx2_cf.M.store_x2 ~ M.store_x2 :
  output{1} = to_uint output{2} /\ plain{1} = to_uint plain{2} /\ len{1} = to_uint len{2} /\ ={Glob.mem} /\
  (good_ptr output plain len){1} /\ (inv_ptr output plain len){1} /\ 128 <= len{1} /\
  k{2} = (x2_ k_1 k_2){1} 
  ==>
  res{1}.`1 = to_uint res{2}.`1 /\ res{1}.`2 = to_uint res{2}.`2 /\ res{1}.`3 = to_uint res{2}.`3 /\ 
  (good_ptr res{1}.`1 res{1}.`2 res{1}.`3){1} /\ (inv_ptr res{1}.`1 res{1}.`2 res{1}.`3){1} /\ ={Glob.mem}.
proof.
  proc *.
  ecall{2} (store_x2_spec output{1} plain{1} len{1} k_1{1} k_2{1} Glob.mem{2}).
  inline{1} ChaCha20_pavx2_cf.M.store_x2; wp.
  ecall{1} (store_pref_spec output0{1} plain0{1} len0{1} k_2{1} Glob.mem{1}).
  ecall{1} (store_pref_spec output0{1} plain0{1} len0{1} k_1{1} Glob.mem{1}). 
  wp; skip => |>.
  move=> &1 &2 3! -> hgood hinv hlen ?; split; 1: smt().
  move=> _ mem1.
  have -> : min 64 (to_uint len{2}) = 64 by smt().
  move=> hinv1 hmem1; split; 1: smt().
  move=> _ mem2.
  have -> /= :  min 64 (to_uint len{2} - 64) = 64 by smt().
  rewrite hlen /= => hinv2 hmem2 r mem 3!-> hmem /=; split; 1: smt().
  apply mem_eq_ext => j; smt().
qed.

phoare store_last_spec output0 plain0 len0 k0 mem0 : 
   [ M.store_last :
      output0 = to_uint output /\ plain0 = to_uint plain /\ len0 = to_uint len /\ mem0 = Glob.mem /\
      k = x_ k0 /\ (good_ptr output0 plain0 len0) /\ (inv_ptr output0 plain0 len0) /\ len0 < 64 
      ==> 
      forall (j : address),
        Glob.mem.[j] =
          if in_range output0 len0 j then
            let j0 = j - output0 in (init32 (fun (i0 : int) => k0.[i0])).[j0] `^` mem0.[plain0 + j0]
          else mem0.[j] ] = 1%r.
proof.
  proc => /=.

equiv eq_store_last : ChaCha20_pref.M.store ~ M.store_last :
  output{1} = to_uint output{2} /\ plain{1} = to_uint plain{2} /\ len{1} = to_uint len{2} /\ ={Glob.mem} /\
  (good_ptr output plain len){1} /\ (inv_ptr output plain len){1} /\ len{1} < 64 /\
  k{2} = x_ k{1} 
  ==>
  ={Glob.mem}.
proof.
  proc *.
  ecall{1} (store_pref_spec output{1} plain{1} len{1} k{1} Glob.mem{1}).

print store_pref_spec.


                   forall (j : address),
                   Glob.mem.[j]m.[j] =
      if in_range output{1} (min 64 len{1}) j then
        let j0 = j - output{1} in (init32 (fun (i0 : int) => k{1}.[i0])).[j0] `^` Glob.mem{1}.[plain{1} + j0]
      else Glob.mem{1}.[j]
 





equiv eq_store_x2_last : ChaCha20_pavx2_cf.M.store_x2_last ~ M.store_x2_last :
  output{1} = to_uint output{2} /\ plain{1} = to_uint plain{2} /\ len{1} = to_uint len{2} /\ ={Glob.mem} /\
  (good_ptr output plain len){1} /\ (inv_ptr output plain len){1} /\ len{1} < 128 /\
  k{2} = (x2_ k_1 k_2){1} 
  ==>
  ={Glob.mem}.
proof.
  proc => /=.
  sp 1 3.

equiv eq_store_last : ChaCha20_pavx2_cf.M.store ~ M.store_last :
  output{1} = to_uint output{2} /\ plain{1} = to_uint plain{2} /\ len{1} = to_uint len{2} /\ ={Glob.mem} /\
  (good_ptr output plain len){1} /\ (inv_ptr output plain len){1} /\ len{1} < 64 /\
  k{2} = (x2_ k_1 k_2){1} 
  ==>
  ={Glob.mem}.
proof.
  proc => /=.
  sp 1 3.

admitted.

phoare perm_x2_spec k1 k2 : [M.perm_x2 : k = x2 k1 k2 ==> res = x2_ k1 k2] = 1%r.
proof.
  proc; conseq (_: Array4.all_eq pk (x2_ k1 k2)).
  + by move=>*; rewrite Array4.ext_eq_all.
  wp; skip => />; rewrite /Array4.all_eq /(%%) /= /x86_VPERM2I128 /x2_ /x2 /=.
  by rewrite !W8.of_intwE /int_bit /= /(%%) /(%/) /b2i /= -!pack2_4u32_8u32 /=. 
qed.

equiv eq_sum_states_x2 : ChaCha20_pavx2.M.sum_states_x2 ~ M.sum_states_x2 :
  k{2} = (x2 k1_1 k1_2){1} /\ st{2} = (x2 st_1 st_2){1} 
  ==>
  res{2} = x2 res{1}.`1 res{1}.`2.
proof.
  proc => /=.
  conseq (_: Array4.all_eq k{2} (x2 k1{1} k2{1})).
  + by move=> *; apply Array4.all_eq_eq.
  rewrite /x2 /Array4.all_eq.
  inline *; do 2! unroll for{1} ^while; unroll for{2} ^while.
  by wp; skip => />; rewrite /x86_VPADD_8u32 /=.
qed.

equiv eq_sum_states_x4 : ChaCha20_pavx2.M.sum_states_x4 ~ M.sum_states_x4 :
  k1{2} = (x2 k1_1 k1_2){1} /\ k2{2} = (x2 k2_1 k2_2){1} /\ st{2} = (x2 st_1 st_2){1} 
  ==>
  res{2}.`1 = x2 res{1}.`1 res{1}.`2 /\
  res{2}.`2 = x2 res{1}.`3 res{1}.`4.
proof.
  proc => /=; wp.
  do 2!call eq_sum_states_x2; wp; skip => />.
  by move=> [k3 k4]; apply Array4.all_eq_eq; rewrite /x2 /Array4.all_eq /x86_VPADD_8u32 /= g_p2_pack.
qed.

module M' = {
  proc rotate_x8 (k:W256.t Array4.t, a r:int) = {
    k.[a] <-  W8u32.pack8_t (W8u32.Pack.map (fun (x:W32.t) => rol x r) (W8u32.unpack32 k.[a]));
    return k; 
  }

  proc line_x8 (k:W256.t Array4.t, a:int, b:int, c:int, r:int) : W256.t Array4.t = {
    k.[a %/ 4] <- k.[a %/ 4] \vadd32u256 k.[b %/ 4];
    k.[c %/ 4] <- k.[c %/ 4] `^` k.[a %/ 4];
    k <@ rotate_x8 (k, c %/ 4, r);
    return k;
  }
  
  proc round_x2 (k:W256.t Array4.t) : W256.t Array4.t = {
    k <@ line_x8 (k, 0, 4, 12, 16);
    k <@ line_x8 (k, 8, 12, 4, 12);
    k <@ line_x8 (k, 0, 4, 12, 8);
    k <@ line_x8 (k, 8, 12, 4, 7);
    return k;
  }
}.

op eq_x2 (k: W256.t Array4.t, k1 k2 : W32.t Array16.t) =
  List.all (fun i =>
     W8u32.Pack.all_eq 
       (unpack32 k.[i])
       (let i = 4*i in
         W8u32.Pack.of_list [k1.[i]; k1.[i+1]; k1.[i+2]; k1.[i+3]; k2.[i]; k2.[i+1]; k2.[i+2]; k2.[i+3]]))
       (iota_ 0 4).

lemma eq_x2P k1 k2 k : eq_x2 k k1 k2 => k = x2 k1 k2.
proof.
  move=> /List.allP hall; apply Array4.ext_eq => i hi.
  rewrite /x2 Array4.initiE 1:// /= -(W8u32.unpack32K k.[i]); congr.
  by apply W8u32.Pack.all_eq_eq; apply (hall i); apply mema_iota.
qed.

phoare rotate_x8 k0 i0 r0 : 
  [M.rotate_x8 : 
    k = k0 /\ i = i0 /\ r = r0 /\ 0 <= i < 4 /\ 0 < r < 32 /\ r16 = g_r16 /\ r8 = g_r8 
    ==>
    res = k0.[i0 <- W8u32.pack8_t (W8u32.Pack.map (fun (x:W32.t) => rol x r0) (W8u32.unpack32 k0.[i0]))]] = 1%r.
proof.
  proc => /=.
  if; 1: by wp;skip.  
  if; 1: by wp;skip.
  wp;skip => /> &m hi1 hi2 hr1 hr2 _ _; congr.
  by rewrite W256.xorwC get_setE 1:// /= x86_8u32_rol_xor.
qed.

equiv eq_line_x2 :  M'.line_x8 ~ M.line_x8 : 
  ={k, a, b, c, r} /\ 0 < r{1} < 32 /\ 0 <= c{1} < 16 /\ r16{2} = g_r16 /\ r8{2} = g_r8
  ==>
  ={res}.
proof.
  proc.
  ecall{2} (rotate_x8 k{2} (c %/ 4){2} r{2}).
  inline *;wp;skip => /> &2 *.
  by rewrite lez_divRL 1:// /= ltz_divLR.
qed.

equiv eq_round_x2 :  M'.round_x2 ~ M.round_x2 : 
  ={k} /\ r16{2} = g_r16 /\ r8{2} = g_r8
  ==>
  ={res}.
proof. proc;do 4! call eq_line_x2; skip => />. qed.

equiv eq_column_round_x2_aux : ChaCha20_pavx2.M.column_round_x2 ~ M.round_x2 : 
  k{2} = (x2 k1 k2){1} /\ (r16 = g_r16 /\ r8 = g_r8){2} 
  ==>
  res{2} = x2 res{1}.`1 res{1}.`2.
proof.
  transitivity M'.round_x2 
    ( k{2} = (x2 k1 k2){1} ==> res{2} = x2 res{1}.`1 res{1}.`2 )
    ( ={k} /\ (r16 = g_r16 /\ r8 = g_r8){2} ==> ={res} ).
  + smt(). + done.
  + proc => /=.
    conseq (_: eq_x2 k{2} k1{1} k2{1}).
    + by move=> *; apply eq_x2P.
    by inline *; wp; skip; cbv delta => &1 &2 -> /=.
  by apply eq_round_x2.
qed.

equiv eq_column_round_x2 : ChaCha20_pavx2.M.column_round_x2 ~ M.column_round_x2 : 
  k{2} = (x2 k1 k2){1} /\ (r16 = g_r16 /\ r8 = g_r8){2} 
  ==>
  res{2} = x2 res{1}.`1 res{1}.`2.
proof.
  proc *; inline M.column_round_x2;wp;call eq_column_round_x2_aux;wp; skip => />.
qed.

equiv eq_shuffle_state : ChaCha20_pavx2.M.shuffle_state ~ M.shuffle_state :
  k{2} = (x2 k1 k2){1} 
  ==>
  res{2} = x2 res{1}.`1 res{1}.`2.
proof.
  proc => /=.
  inline *; wp; skip => /> &1.
  rewrite /x2 /x86_VPSHUFD_256 /(%%) /(%/) /= -3!pack2_4u32_8u32 /=; cbv delta; rewrite !pack2_4u32_8u32.
  by apply Array4.all_eq_eq; rewrite /Array4.all_eq.
qed.

equiv eq_reverse_shuffle_state : ChaCha20_pavx2.M.reverse_shuffle_state ~ M.reverse_shuffle_state :
  k{2} = (x2 k1 k2){1} 
  ==>
  res{2} = x2 res{1}.`1 res{1}.`2.
proof.
  proc => /=.
  inline *; wp; skip => /> &1.
  rewrite /x2 /x86_VPSHUFD_256 /(%%) /(%/) /= -3!pack2_4u32_8u32 /=; cbv delta; rewrite !pack2_4u32_8u32.
  by apply Array4.all_eq_eq; rewrite /Array4.all_eq.
qed.

equiv eq_diagonal_round_x2 : ChaCha20_pavx2.M.diagonal_round_x2 ~ M.diagonal_round_x2 : 
  k{2} = (x2 k1 k2){1} /\ (r16 = g_r16 /\ r8 = g_r8){2} 
  ==>
  res{2} = x2 res{1}.`1 res{1}.`2.
proof.
  proc => /=.
  call eq_reverse_shuffle_state. 
  call eq_column_round_x2_aux.
  by call eq_shuffle_state; skip.
qed.

equiv eq_rounds_x2 : ChaCha20_pavx2.M.rounds_x2 ~ M.rounds_x2 :
  k{2} = (x2 k1_1 k1_2){1}
  ==>
  res{2} = x2 res{1}.`1 res{1}.`2.
proof.
  proc => /=.
  while (#pre /\ (r16 = g_r16 /\ r8 = g_r8){2} /\ c{1} = to_uint c{2} /\ 0 <= c{1} ); last by auto.
  wp; call eq_diagonal_round_x2; call eq_column_round_x2; skip => /> *.
  by rewrite ultE /= W64.to_uintD_small /= /#.
qed.

equiv eq_rounds_x4 : ChaCha20_pavx2.M.rounds_x4 ~ M.rounds_x4 :
  k1{2} = (x2 k1_1 k1_2){1} /\ k2{2} = (x2 k2_1 k2_2){1}
  ==>
  res{2}.`1 = x2 res{1}.`1 res{1}.`2 /\
  res{2}.`2 = x2 res{1}.`3 res{1}.`4.
proof.
  proc => /=.
  while (#pre /\ (r16 = g_r16 /\ r8 = g_r8){2} /\ c{1} = to_uint c{2} /\ 0 <= c{1} ); last by auto.
  inline ChaCha20_pavx2.M.column_round_x4 ChaCha20_pavx2.M.diagonal_round_x4 
     M.column_round_x4 M.diagonal_round_x4 M.round_x4 
     M.shuffle_state_x2 ChaCha20_pavx2.M.shuffle_state_x2
     M.reverse_shuffle_state_x2 ChaCha20_pavx2.M.reverse_shuffle_state_x2.
  wp.
  do 2! call eq_reverse_shuffle_state; wp.
  do 2! call eq_column_round_x2_aux; wp => /=.
  do 2! call eq_shuffle_state; wp.
  do 2!  call eq_column_round_x2_aux; wp; skip => /> *.
  by rewrite ultE /= W64.to_uintD_small /= /#.
qed.

equiv eq_chacha20_less_than_257 :
  ChaCha20_pavx2.M.chacha20_less_than_257 ~ ChaCha20_savx2.M.chacha20_less_than_257 : 
  output{1} = to_uint output{2} /\ plain{1} = to_uint plain{2} /\ len{1} = to_uint len{2} /\
  key{1} = to_uint key{2} /\ nonce{1} = to_uint nonce{2} /\ ={counter,Glob.mem} /\
  (key + 32 < W64.modulus /\ nonce + 12 < W64.modulus){1} /\
  (good_ptr output plain len){1} /\ (inv_ptr output plain len){1} 
  ==>
  ={Glob.mem}.
proof. 
  proc => /=.
  seq 1 4 : (output{1} = to_uint output{2} /\ plain{1} = to_uint plain{2} /\ len{1} = to_uint len{2} /\
            st{2} = (x2 st_1 st_2) {1} /\ (good_ptr output plain len){1} /\ (inv_ptr output plain len){1} /\ ={Glob.mem}).
  + call eq_init_x2; wp; skip => />.
  if; 1: by move=> /> *; rewrite ultE.
  + call eq_store_x2_last => /=. 
    call eq_store_x2 => /=.
    inline M.perm_x4; wp.
    ecall{2} (perm_x2_spec k2_1{1} k2_2{1}).
    ecall{2} (perm_x2_spec k1_1{1} k1_2{1}); wp => /=.
    call eq_sum_states_x4; call eq_rounds_x4 => /=.
    inline ChaCha20_pavx2.M.copy_state_x4 M.copy_state_x4; wp; skip => /> *.
    split; 2: smt().
    by apply Array4.all_eq_eq; rewrite /x86_VPADD_8u32 /Array4.all_eq /x2 /= g_p2_pack.
  call eq_store_x2_last => /=.  
  ecall{2} (perm_x2_spec k1_1{1} k1_2{1}).
  call eq_sum_states_x2.
  call eq_rounds_x2.
  by inline M.copy_state_x2; auto.
qed.


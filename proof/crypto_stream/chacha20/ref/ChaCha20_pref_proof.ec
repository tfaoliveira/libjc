require import List Jasmin_model Int IntDiv IntExtra CoreMap.
import IterOp.
require import ChaCha20_Spec ChaCha20_pref.
require import Array3 Array8 Array16.
require import WArray64.

lemma line_diff a b d s st i:
  i <> a => i <> d => (line a b d s st).[i] = st.[i].
proof.
  by move=> ha hd; rewrite /line /= !Array16.get_set_if ha hd /=.
qed.

lemma line_morph a b d s (st1 st2: state) i:
  i = a || i = d => 
  st1.[a] = st2.[a] => st1.[b] = st2.[b] => st1.[d] = st2.[d] =>
  (line a b d s st1).[i] = (line a b d s st2).[i].
proof.
  by rewrite /line => hi ha hb hd /=; rewrite !Array16.get_set_if /#.
qed.

lemma quarter_round_diff st a b c d i:
   i <> a => i <> b => i <> c => i <> d => 
   (quarter_round a b c d st).[i] = st.[i].
proof.
  by move=> ha hb hc hd; rewrite /quarter_round /(\oo) !line_diff.
qed.

lemma quarter_round_morph a b c d (st1 st2:state) i:
  i = a || i = b || i = c || i = d => 
  a <> b => a <> c => a <> d =>
  b <> c => b <> d => c <> d =>
  st1.[a] = st2.[a] => st1.[b] = st2.[b] => st1.[c] = st2.[c] => st1.[d] = st2.[d] =>
  (quarter_round a b c d st1).[i] = (quarter_round a b c d st2).[i].
proof.
  move=> hor ha hb hc hd hab hac had hbc hbd hcd; rewrite /quarter_round /(\oo).
  smt (line_morph line_diff).
qed.

op column_round'  : state -> state  =
  quarter_round 0 4 8 12 \oo quarter_round 2 6 10 14 \oo 
  quarter_round 1 5 9 13 \oo  quarter_round 3 7 11 15.

lemma column_round'_spec st: column_round st = column_round' st.
proof.
  delta column_round' column_round (\oo) => /=.
  congr; move: (quarter_round 0 4 8 12 st) => {st} st.
  apply Array16.ext_eq => i hi_bound; smt (quarter_round_morph quarter_round_diff). 
qed.

op diagonal_round' : state -> state =
  quarter_round 1 6 11 12 \oo quarter_round 0 5 10 15 \oo quarter_round 2 7 8 13 \oo quarter_round 3 4 9 14.

lemma diagonal_round'_spec st: diagonal_round st = diagonal_round' st.
proof.
  delta diagonal_round' diagonal_round (\oo) => /=.
  do 2! congr.
  apply Array16.ext_eq => i hi_bound; smt (quarter_round_morph quarter_round_diff). 
qed.

hoare copy_state_spec st0: M.copy_state : 
  st = st0 
  ==> res = st0.
proof. by proc; auto. qed.

hoare line_spec (st0:state) a0 b0 c0 r0 : M.line : 
  k = st0 /\ (a,b,c,r) = (a0,b0,c0,r0) /\ 
  0 <= a0 < 16 /\ 0 <= b0 < 16 /\ 0 <= c0 < 16 /\ 
  a0 <> c0 /\ 0 <= r0 <= 16 
  ==>
  res = line a0 b0 c0 r0 st0.
proof.
  proc;auto => /> &m h0a ha h0b hb h0c hc;rewrite eq_sym => hac h0r hr. 
  apply Array16.ext_eq => i hi.
  rewrite /line /= !Array16.get_set_if /= x86_ROL_32_E /= pmod_small /#.
qed.

hoare quarter_round_spec (st0:state) a0 b0 c0 d0 : M.quarter_round : 
  k = st0 /\ (a,b,c,d) = (a0,b0,c0,d0) /\ 
  a0 <> d0 /\ c0 <> b0 /\ 
  0 <= a0 < 16 /\ 0 <= b0 < 16 /\ 0 <= c0 < 16 /\ 0 <= d0 < 16
  ==>
  res = quarter_round a0 b0 c0 d0 st0.
proof.
  proc => /=.
  ecall (line_spec (line a0 b0 d0 8 (line c0 d0 b0 12 (line a0 b0 d0 16 st0))) c0 d0 b0 7).
  ecall (line_spec (line c0 d0 b0 12 (line a0 b0 d0 16 st0)) a0 b0 d0 8).
  ecall (line_spec (line a0 b0 d0 16 st0) c0 d0 b0 12).
  ecall (line_spec st0 a0 b0 d0 16); auto.
qed.

hoare column_round_spec (st0:state) : M.column_round : 
  k = st0 ==> res = column_round st0.
proof.
  conseq (_: res = column_round' st0).
  + by move=> &m _ r ->; rewrite column_round'_spec.
  proc; delta column_round' (\oo) => /=.
  ecall (quarter_round_spec (quarter_round 1 5 9 13 
             (quarter_round 2 6 10 14 (quarter_round 0 4 8 12 st0))) 3 7 11 15).
  ecall (quarter_round_spec (quarter_round 2 6 10 14 (quarter_round 0 4 8 12 st0)) 1 5 9 13).
  ecall (quarter_round_spec (quarter_round 0 4 8 12 st0) 2 6 10 14).  
  ecall (quarter_round_spec st0 0 4 8 12);auto.
qed.

hoare diagonal_round_spec (st0:state) : M.diagonal_round : 
  k = st0 ==> res = diagonal_round st0.
proof.
  conseq (_: res = diagonal_round' st0).
  + by move=> &m _ r ->; rewrite diagonal_round'_spec.
  proc; delta diagonal_round' (\oo) => /=.
  ecall (quarter_round_spec (quarter_round 2 7 8 13 (quarter_round 0 5 10 15 
                            (quarter_round 1 6 11 12 st0))) 3 4 9 14).
  ecall (quarter_round_spec (quarter_round 0 5 10 15 (quarter_round 1 6 11 12 st0)) 2 7 8 13).
  ecall (quarter_round_spec (quarter_round 1 6 11 12 st0) 0 5 10 15).
  ecall (quarter_round_spec st0 1 6 11 12);auto.
qed.

hoare round_spec (st0:state) : M.round : 
  k = st0 ==> res = double_round st0.
proof.
  proc.
  ecall (diagonal_round_spec (column_round st0)).
  by ecall (column_round_spec st0);skip;delta double_round (\oo).
qed.

hoare rounds_spec (st0:state) : M.rounds :
  k = st0 ==> res = rounds st0.
proof.
  proc.
  while (W32.to_uint c <= 10 /\ k = iter (W32.to_uint c) double_round st0).
  + wp; ecall (round_spec (iter (to_uint c) double_round st0)); skip => />.
    move=> &m hc; rewrite W32.ultE /= => hc10.
    have [h0c _] := W32.to_uint_cmp c{m}.
    have -> : to_uint (c{m} + W32.one) = W32.to_uint c{m} + 1.
    + by rewrite W32.to_uintD pmod_small //= /#.
    by split => [/# | ]; rewrite iterS.  
  wp;skip => /= &m;rewrite iter0 1:// => h;split => // c k.
  by rewrite W32.ultE /= /rounds /#.
qed.

op loads_8 (mem : global_mem_t) (from : W64.t) (len: int) = 
  map (fun i => loadW8 mem (from + W64.of_int i)) (iota_ 0 len).

op loads_32 (mem: global_mem_t) (from : W64.t) (len : int) = 
  map (fun i => loadW32 mem (from + W64.of_int (4 * i))) (iota_ 0 len).

(*
lemma storesE m (a1 a2:W64.t) (l:W8.t list) :
   W64.to_uint a1 + size l <= W64.modulus =>
   loadW8 (stores m a1 l) a2 = 
      if W64.to_uint a1 <= W64.to_uint a2 < W64.to_uint a1 +  size l then 
        l.[W64.to_uint a2 - W64.to_uint a1]
      else loadW8 m a2.
proof.
  rewrite /stores /= => ha1.
  have -> //: forall p, p <= size l => 
     loadW8 (foldl (fun (m0 : global_mem_t) (i : int) => m0.[a1 + (of_int i)%W64 <- l.[i]]) m 
       (iota_ 0 p)) a2 =
     if to_uint a1 <= to_uint a2 < to_uint a1 + p then 
       l.[to_uint a2 - to_uint a1] 
     else loadW8 m a2.
  elim /natind => /=.
  + by move=> n hn0 _; rewrite iota0 1:// /#.
  move=> p hp hrec hp1.
  rewrite iotaSr 1:// -cats1 foldl_cat /= get_setE.
  have /= a1_cmp := W64.to_uint_cmp a1; have ge0l := size_ge0 l.
  have top : to_uint ((W64.of_int p)) = p.
  + rewrite to_uint_small 2:// /#. 
  have -> /#: a2 = a1 + (of_int p)%W64 <=> W64.to_uint a2 = W64.to_uint a1 + p.
  split => [-> | heq].
  + by rewrite W64.to_uintD_small /#. 
  by apply (Core.can_inj _ _ (W64.to_uintK));rewrite heq  W64.to_uintD_small /#.
qed.   

lemma loadW8_storeW32 m (a1 a2:W64.t) w: 
   to_uint a1 + 4 <= W64.modulus =>
   loadW8 (storeW32 m a1 w) a2 = 
     if W64.to_uint a1 <=  W64.to_uint a2 < W64.to_uint a1 + 4 then 
       w \bits8 (W64.to_uint a2 - W64.to_uint a1)
     else loadW8 m a2.
proof. move=> ha1;rewrite storeW32E storesE 1:// /= /#. qed.
*)
lemma loads_8D m p (n1 n2:int) : 0 <= n1 => 0 <= n2 =>
  loads_8 m p (n1 + n2) = 
  loads_8 m p n1 ++ loads_8 m (p + W64.of_int n1) n2.
proof.
  move=> hn1 hn2; rewrite /loads_8 iota_add //.
  by rewrite map_cat addzC iota_addl /= -map_comp.
qed.

lemma loads_8_eq mem1 mem2 p n: 
  W64.to_uint p + n <= W64.modulus  => 
  (forall i, W64.to_uint p <= i <  W64.to_uint p + n => 
     loadW8 mem1 (W64.of_int i) = loadW8 mem2 (W64.of_int i)) =>
  loads_8 mem1 p n = loads_8 mem2 p n. 
proof.
  move=> /= hp hmem;apply eq_in_map => /= i /mema_iota hi.
  have toi : to_uint (W64.of_int i) = i.
  + apply W64.to_uint_small; smt (W64.to_uint_cmp).
  have := hmem (W64.to_uint (p + W64.of_int i)) _.
  + by rewrite W64.to_uintD_small toi /#. 
  by rewrite W64.to_uintK.
qed.

lemma map2_cat (f:'a -> 'b -> 'c) (l1 l2:'a list) (l1' l2':'b list):
  size l1 = size l1' =>
  map2 f (l1 ++ l2) (l1' ++ l2') = map2 f l1 l1' ++ map2 f l2 l2'.
proof. by move=> hs;rewrite !map2_zip zip_cat // map_cat. qed.

lemma size_loads_8 mem p s : size (loads_8 mem p s) = max 0 s.
proof. by rewrite /loads_8 size_map size_iota. qed.

(* move this *)
lemma to_uint_eq (x y:W64.t) :  (x = y) <=> (to_uint x = to_uint y).
proof. by rewrite Core.inj_eq // (Core.can_inj _ _  W64.to_uintK). qed.

lemma size_bytes_of_block st : size (bytes_of_block st) = 64.
proof. by rewrite /bytes_of_block WArray64.size_to_list. qed.

lemma map2C (f: 'a -> 'a -> 'b) (l1 l2:'a list) : 
  (forall a1 a2, f a1 a2 = f a2 a1) =>
  map2 f l1 l2 = map2 f l2 l1.
proof.
  move=> hf; elim: l1 l2=> [ | a1 l1 hrec] [ | a2 l2] //=.
  by rewrite hf hrec.
qed.

lemma map2_take1 (f: 'a -> 'b -> 'c) (l1: 'a list) (l2: 'b list) :
  map2 f l1 l2 = map2 f (take (size l2) l1) l2. 
proof.
  elim: l1 l2 => [ | a1 l1 hrec] [ | a2 l2] //=.
  smt (size_ge0).
qed.

lemma map2_take2 (f: 'a -> 'b -> 'c) (l1: 'a list) (l2: 'b list) :
  map2 f l1 l2 = map2 f l1 (take (size l1) l2).
proof.
  elim: l1 l2 => [ | a1 l1 hrec] [ | a2 l2] //=.
  smt (size_ge0).
qed.

hoare store_spec output0 plain0 len0 k0 mem0 : M.store :
  output = output0 /\ plain = plain0 /\ to_uint len = len0 /\ k = k0 /\ Glob.mem = mem0 /\ 0 <= len0 /\
  W64.to_uint output0 + min 64 len0 < W64.modulus /\
  W64.to_uint plain0 + min 64 len0 < W64.modulus /\
  (to_uint plain + min 64 len0  < to_uint output || to_uint output <= to_uint plain)
  ==>
  loads_8 Glob.mem output0 (min 64 len0) = map2 W8.(+^) (bytes_of_block k0) (loads_8 mem0 plain0 (min 64 len0)) /\
  (forall i, 0 <= i < W64.modulus => !(to_uint output0 <= i < to_uint output0 + (min 64 len0)) => 
     loadW8 Glob.mem (W64.of_int i) = loadW8 mem0 (W64.of_int i)) /\
  res.`1 = output0 + W64.of_int (min 64 len0) /\
  res.`2 = plain0 + W64.of_int (min 64 len0) /\
  res.`3 = W32.of_int len0 - W32.of_int (min 64 len0).
proof.
  proc; inline *; wp => /=.
  pose len1 := min 64 len0.
  while (0 <= i <= len1 /\
         output = output0 /\ plain = plain0 /\ k0 = k /\ len = W32.of_int len0 /\ 0 <= len0 /\
         W64.to_uint output0 + len1 < W64.modulus /\
         W64.to_uint plain0 + len1 < W64.modulus /\
         (to_uint plain + len1 < to_uint output || to_uint output <= to_uint plain) /\
         loads_8 Glob.mem output0 i = 
           map2 W8.(+^) (take i (bytes_of_block k0))
(*             (map (fun i => WArray64."_.[_]" k0 i) (iota_ 0 i)) *)
             (loads_8 mem0 plain0 i) /\
         (forall j, 0 <= j < W64.modulus => !(to_uint output0 <= j < to_uint output0 + i) => 
            loadW8 Glob.mem (W64.of_int j) = loadW8 mem0 (W64.of_int j))).
  + wp; skip => /> &m h0i _ hlen0 hob hpb hdisj hloads hdiff + hi64.
    have ismall : to_uint (W32.of_int i{m}) = i{m}.
    + by rewrite W32.to_uint_small 1:/#.
    rewrite W32.ultE ismall => hilen.
    split; 1:smt().
    have hpi : to_uint (plain{m} + W64.of_int i{m}) = to_uint plain{m} + i{m}.
    + by rewrite  W64.to_uintD_small W64.to_uint_small /#.
    have hoi : to_uint (output{m} + W64.of_int i{m}) = to_uint output{m} + i{m}.
    + by rewrite  W64.to_uintD_small W64.to_uint_small /#. 
    split.
    + rewrite !loads_8D // (take_nth W8.zero) 1:size_bytes_of_block 1:// -cats1 map2_cat. 
      + rewrite size_take // size_bytes_of_block hi64 size_loads_8 /#.
      congr.
      + rewrite -hloads;apply loads_8_eq; 1:smt().
        move=> j hj.        
        rewrite  /loadW8 storeW8E get_set_neqE_s //.
        by rewrite to_uint_eq W64.to_uint_small; smt (W64.to_uint_cmp). 
      rewrite /loads_8 /= /loadW8 storeW8E /=;congr.
      + by rewrite /bytes_of_block -WArray64.get_to_list.
      rewrite (hdiff (to_uint (plain{m} + W64.of_int i{m}))).
      + by rewrite hpi; smt (W64.to_uint_cmp).
      + by rewrite hpi /#.
      by rewrite W64.to_uintK.
    move=> j h0j hjb hj.
    rewrite -hdiff 1:// 1:/# /loadW8 storeW8E get_set_neqE_s //.
    by rewrite to_uint_eq W64.to_uint_small 1:// hoi /#.
  wp;skip => &hr /> *. 
  split; 1:split.
  + smt().
  + by rewrite /loads_8 iota0 // take0.
  move=> mem i0; rewrite W32.ultE => + h2 h3.
  have ismall : to_uint (W32.of_int i0) = i0.
  + by rewrite W32.to_uint_small 1:/#.
  rewrite ismall => h1 /=.
  have ->> /> ??? -> hdiff: i0 = len1 by smt(). 
  split.
  + have {1}-> : len1 = size (loads_8 Glob.mem{hr} plain{hr} len1).
    + by rewrite size_loads_8 /#.
    by rewrite -map2_take1.
  split; 1: by move=> *;apply hdiff.
  by rewrite W32.of_intS /=.
qed.

hoare sum_states_spec k0 st0 : M.sum_states : 
  k = k0 /\ st = st0
  ==>
  res = Array16.map2 (fun (x y: W32.t) => x + y) k0 st0.
proof.
  proc.
  rewrite /is_state. 
  unroll for 2;wp;skip => /> &hr.
  by apply Array16.all_eq_eq;rewrite /all_eq.
qed.

lemma take_loads_8 mem p (n1 n2:int) : n1 <= n2 =>
  take n1 (loads_8 mem p n2) = loads_8 mem p n1.
proof. by move=> hn;rewrite /loads_8 -map_take take_iota /#. qed.

hoare chacha20_ref_spec output0 plain0 key0 nonce0 counter0 : M.chacha20_ref :
  output = output0 /\ 
  (to_uint plain{hr} + W32.to_uint len < to_uint output{hr} || to_uint output{hr} <= to_uint plain{hr}) /\
  to_uint output{hr} + to_uint len < W64.modulus /\
  to_uint plain{hr} + to_uint len < W64.modulus /\
  plain0 = loads_8 Glob.mem plain (W32.to_uint len) /\
  key0 = Array8.of_list W32.zero (loads_32 Glob.mem key 8) /\
  nonce0 = Array3.of_list W32.zero (loads_32 Glob.mem nonce 3) /\
  counter0 = counter 
  ==> 
  (chacha20_CTR_encrypt_bytes key0 nonce0 counter0 plain0).`1 = 
  loads_8 Glob.mem output0 (size plain0).
proof.
  proc; rewrite /chacha20_CTR_encrypt_bytes /=.
  seq 1: 
    ((to_uint plain{hr} + W32.to_uint len < to_uint output{hr} || to_uint output{hr} <= to_uint plain{hr}) /\
    to_uint output{hr} + to_uint len < W64.modulus /\
    to_uint plain{hr} + to_uint len < W64.modulus /\
    exists plain1 c, 
      let ilen = W32.to_uint len in
      let splain1 = size plain1 in
      to_uint output0 = to_uint output{hr} - size plain1 /\
      plain0 = plain1 ++ loads_8 Glob.mem plain ilen /\
      st = setup key0 nonce0 c /\
      (0 < ilen => splain1 %% 64 = 0) /\
      iter (splain1 %/ 64 + b2i (splain1 %% 64 <> 0) ) (ctr_round key0 nonce0) ([], plain0, counter0) = 
         (loads_8 Glob.mem output0 splain1, loads_8 Glob.mem plain ilen, c)).
  + inline M.init.
    unroll for 12; unroll for 9; wp; skip => &m /> ???.
    exists [] counter{m} => /=.
    rewrite iter0 // /loads_8 /=.
    rewrite /setup /loads_32 /=.
    rewrite Array8.of_listK 1:// Array3.of_listK 1:// /=.
    split;2: done.
    by apply Array16.all_eq_eq; rewrite /Array16.all_eq.
  + while (#pre) => //.
    elim * => plain1 counter1 /=.
    inline M.increment_counter; wp.
    pose st0 := (setup key0 nonce0 counter1).
    ecall (store_spec output plain (W32.to_uint len) k Glob.mem); last first.
    + move=> &hr /> ???? h result mem h1 h2 h3 h4 h5. 
      apply (h result mem _). 
      by rewrite h1 /= h3 h4 h5 W32.of_intS /= => *;apply h2.
    ecall (sum_states_spec (rounds st0) st0).
    ecall (rounds_spec st0).
    ecall (copy_state_spec st).
    skip => /> &hr hnot hout hplain hout0 hmod hiter. 
    rewrite W32.ultE /= => hult.
    pose len1 := min 64 (to_uint len{hr}). 
    have hlen1 : to_uint (W32.of_int len1) = len1 by rewrite W32.to_uint_small /#.
    have hlen1' : to_uint (W64.of_int len1) = len1 by rewrite W64.to_uint_small /#.
    split; 1: smt().
    move=> hlen ho64 hp64 hop [output' plain' len'] mem hload hdiff /= 3!->>.
    rewrite W32.to_uintB. 
    + by rewrite W32.uleE hlen1 /#.
    rewrite !W64.to_uintD_small hlen1' //.
    split; 1:smt().
    split;[smt() | split;1:smt()].
    exists (plain1 ++ loads_8 Glob.mem{hr} plain{hr} len1) (counter1 + W32.of_int 1).
    split. 
    + by rewrite size_cat size_loads_8 /#.  
    split.
    + rewrite -catA; congr.
      rewrite hlen1.     
      have -> : loads_8 mem (plain{hr} + W64.of_int len1) (to_uint len{hr} - len1) = 
                loads_8 Glob.mem{hr} (plain{hr} + W64.of_int len1) (to_uint len{hr} - len1).
      + apply loads_8_eq. 
        + by rewrite W64.to_uintD_small hlen1' // /#.
        by move=> i; rewrite W64.to_uintD_small hlen1' 1://; smt (W64.to_uint_cmp).
      by rewrite -loads_8D 1:// /#. 
    split.
    + rewrite /setup /=; apply Array16.all_eq_eq. 
      rewrite -!catA /Array16.all_eq /=.
      by rewrite !nth_cat; rewrite Array8.size_to_list /=.
    split.
    + rewrite hlen1 size_cat size_loads_8 /max => h.
      have -> /= : len1 = 64 by smt().
      rewrite modzDr;apply hmod => /#.
    pose plain2 := plain1 ++ loads_8 Glob.mem{hr} plain{hr} len1.
    have -> : size plain2 %/ 64 + b2i (size plain2 %% 64 <> 0) = 
              ((size plain1 %/ 64 + b2i (size plain1 %% 64 <> 0))) + 1.
    + rewrite /plain2 size_cat size_loads_8 (_ : max 0 len1 = len1) 1:/# hmod 1:// /b2i /=.
      have ?: 64 %| size plain1 by rewrite /(%|) hmod. 
      rewrite dvdz_modzDl 1:// divzDl 1://.
      case: (64 <= to_uint len{hr}) => hlt.
      + smt (modzz divzz).
      smt (divz_small modz_small W32.to_uint_cmp). 
    rewrite iterS. 
    + smt (modz_ge0 divz_ge0 size_ge0).
    rewrite hiter /ctr_round /=;split.
    + rewrite /plain2 size_cat size_loads_8 /max (_: 0 < len1) 1:/# /=.
      rewrite loads_8D 1:size_ge0 1:/#;congr.
      + apply loads_8_eq;1:by rewrite hout0 /#.
        by move=> i hi;rewrite hdiff 3://; smt (W64.to_uint_cmp).
      have -> : output0 + W64.of_int (size plain1) = output{hr}.
      + have hplain1 : to_uint (W64.of_int (size plain1)) = size plain1.
        + rewrite W64.to_uint_small; smt (W64.to_uint_cmp size_ge0).
        by apply to_uint_eq; rewrite W64.to_uintD_small hplain1 /#. 
      rewrite hload /chacha20_block /chacha20_core /=.
      rewrite map2C; 1:by apply W8.xorwC.
      case : (to_uint len{hr} < 64) => hlt; 1:smt().
      have -> : len1 = 64 by smt().
      by rewrite map2_take2 size_bytes_of_block take_loads_8 1:/#.
    case : (64 < to_uint len{hr}) => hlt;last first.
    + by rewrite drop_oversize 1:size_loads_8 1:/# /len1 /min hlt /= /loads_8.
    have {1} -> : to_uint len{hr} = len1 + (to_uint len{hr} - len1) by ring.
    rewrite loads_8D 1,2:/#.
    have -> : len1 = 64 by rewrite /len1 /min hlt.
    rewrite drop_size_cat 1:size_loads_8 1:// /=.
    have h : to_uint (plain{hr} + W64.of_int 64) + (to_uint len{hr} - 64) = to_uint plain{hr} + to_uint len{hr}. 
    + by rewrite W64.to_uintD_small /= 1:/#; ring.
    apply loads_8_eq; smt(W64.to_uint_cmp).
  skip => &hr /> h1 h2 h3 plain1 c ??? mem len0 output1 plain2.
  rewrite W32.ultE /= => hlen0.
  have -> /= : to_uint len0 = 0 by smt (W32.to_uint_cmp).
  move=> ??? plain3 c2 h4.
  have -> : loads_8 mem plain2 0 = [] by rewrite /loads_8.
  by rewrite cats0 => -> ->.
qed.

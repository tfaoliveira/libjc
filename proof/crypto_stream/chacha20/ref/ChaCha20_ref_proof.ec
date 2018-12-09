require import List Jasmin_model Int IntDiv IntExtra CoreMap.
import IterOp.
require import ChaCha20_Spec ChaCha20_ref.

lemma line_diff a b d s st i:
  i <> a => i <> d => (line a b d s st).[i] = st.[i].
proof.
  by move=> ha hd; rewrite /line /= !Array16.get_set_if ha hd /=.
qed.

lemma line_morph a b d s (st1 st2:W32.t Array16.t) i:
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

lemma quarter_round_morph a b c d (st1 st2:W32.t Array16.t) i:
  i = a || i = b || i = c || i = d => 
  a <> b => a <> c => a <> d =>
  b <> c => b <> d => c <> d =>
  st1.[a] = st2.[a] => st1.[b] = st2.[b] => st1.[c] = st2.[c] => st1.[d] = st2.[d] =>
  (quarter_round a b c d st1).[i] = (quarter_round a b c d st2).[i].
proof.
  move=> hor ha hb hc hd hab hac had hbc hbd hcd; rewrite /quarter_round /(\oo).
  smt (line_morph line_diff).
qed.

op column_round'  : state -> W32.t Array16.t =
  quarter_round 0 4 8 12 \oo quarter_round 2 6 10 14 \oo 
  quarter_round 1 5 9 13 \oo  quarter_round 3 7 11 15.

lemma column_round'_spec st: column_round st = column_round' st.
proof.
  delta column_round' column_round (\oo) => /=.
  congr; move: (quarter_round 0 4 8 12 st) => {st} st.
  apply Array16.ext_eq => i hi_bound; smt (quarter_round_morph quarter_round_diff). 
qed.

op diagonal_round' : state -> W32.t Array16.t =
  quarter_round 1 6 11 12 \oo quarter_round 0 5 10 15 \oo quarter_round 2 7 8 13 \oo quarter_round 3 4 9 14.

lemma diagonal_round'_spec st: diagonal_round st = diagonal_round' st.
proof.
  delta diagonal_round' diagonal_round (\oo) => /=.
  do 2! congr.
  apply Array16.ext_eq => i hi_bound; smt (quarter_round_morph quarter_round_diff). 
qed.

hoare copy_state_spec (st0: WArray64.t) : M.copy_state : 
  st = st0 
  ==> res = st0.
proof. by proc; auto. qed.

op is_state (st0:W32.t Array16.t) (k:WArray64.t) = 
  st0 = Array16.init (fun i => WArray64.get32 k i).
(*  forall i, 0 <= i < 16 => st0.[i] = . *)

hoare line_spec (st0:W32.t Array16.t) a0 b0 c0 r0 : M.line : 
  is_state st0 k /\ (a,b,c,r) = (a0,b0,c0,r0) /\ 
  0 <= a0 < 16 /\ 0 <= b0 < 16 /\ 0 <= c0 < 16 /\ 
  a0 <> c0 /\ 0 <= r0 <= 16 
  ==>
  is_state (line a0 b0 c0 r0 st0) res.
proof.
  proc;auto => /> &m his h0a ha h0b hb h0c hc; rewrite eq_sym => hac h0r hr. 
  have ? : 4 * (c{m} + 1) <= 64 by smt().
  have ? : 4 * (a{m} + 1) <= 64 by smt().
  rewrite /is_state his;apply Array16.ext_eq => i hi.
  rewrite /line /= !Array16.get_set_if !Array16.initiE //.
  rewrite !WArray64.get_set32E // h0a ha hac /= h0c hc /=.
  case: (i=c{m}) => //=.
  by rewrite x86_ROL_32_E /= pmod_small 1:/# .
qed.

hoare quarter_round_spec (st0:W32.t Array16.t) a0 b0 c0 d0 : M.quarter_round : 
  is_state st0 k /\ (a,b,c,d) = (a0,b0,c0,d0) /\ 
  a0 <> d0 /\ c0 <> b0 /\ 
  0 <= a0 < 16 /\ 0 <= b0 < 16 /\ 0 <= c0 < 16 /\ 0 <= d0 < 16
  ==>
  is_state (quarter_round a0 b0 c0 d0 st0) res.
proof.
  proc => /=.
  ecall (line_spec (line a0 b0 d0 8 (line c0 d0 b0 12 (line a0 b0 d0 16 st0))) c0 d0 b0 7).
  ecall (line_spec (line c0 d0 b0 12 (line a0 b0 d0 16 st0)) a0 b0 d0 8).
  ecall (line_spec (line a0 b0 d0 16 st0) c0 d0 b0 12).
  ecall (line_spec st0 a0 b0 d0 16); auto.
qed.

hoare column_round_spec (st0:W32.t Array16.t) : M.column_round : 
  is_state st0 k ==> is_state (column_round st0) res.
proof.
  conseq (_: is_state (column_round' st0) res).
  + rewrite /is_state => &m _ r <-;apply column_round'_spec.
  proc; delta column_round' (\oo) => /=.
  ecall (quarter_round_spec (quarter_round 1 5 9 13 
             (quarter_round 2 6 10 14 (quarter_round 0 4 8 12 st0))) 3 7 11 15).
  ecall (quarter_round_spec (quarter_round 2 6 10 14 (quarter_round 0 4 8 12 st0)) 1 5 9 13).
  ecall (quarter_round_spec (quarter_round 0 4 8 12 st0) 2 6 10 14).  
  ecall (quarter_round_spec st0 0 4 8 12);auto.
qed.

hoare diagonal_round_spec (st0:W32.t Array16.t) : M.diagonal_round : 
  is_state st0 k ==> is_state (diagonal_round st0) res.
proof.
  conseq (_: is_state (diagonal_round' st0) res).
  + by rewrite /is_state => &m _ r <-; apply diagonal_round'_spec.
  proc; delta diagonal_round' (\oo) => /=.
  ecall (quarter_round_spec (quarter_round 2 7 8 13 (quarter_round 0 5 10 15 
                            (quarter_round 1 6 11 12 st0))) 3 4 9 14).
  ecall (quarter_round_spec (quarter_round 0 5 10 15 (quarter_round 1 6 11 12 st0)) 2 7 8 13).
  ecall (quarter_round_spec (quarter_round 1 6 11 12 st0) 0 5 10 15).
  ecall (quarter_round_spec st0 1 6 11 12);auto.
qed.

hoare round_spec (st0:W32.t Array16.t) : M.round : 
  is_state st0 k ==> is_state (double_round st0) res.
proof.
  proc.
  ecall (diagonal_round_spec (column_round st0)).
  by ecall (column_round_spec st0);skip;delta double_round (\oo).
qed.

hoare rounds_spec (st0: W32.t Array16.t) : M.rounds :
  is_state st0 k ==> is_state (rounds st0) res.
proof.
  proc.
  while (W32.to_uint c <= 10 /\ is_state (iter (W32.to_uint c) double_round st0) k).
  + wp; ecall (round_spec (iter (to_uint c) double_round st0)); skip => />.
    move=> &m hc hst;rewrite W32.ultE /= => hc10 r hr.
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

hoare store_spec output0 plain0 len0 k0 mem0 : M.store :
  output = output0 /\ plain = plain0 /\ len = len0 /\ k = k0 /\ Glob.mem = mem0 /\
  W64.to_uint output0 + 64 < W64.modulus /\
  W64.to_uint plain0 + 64 < W64.modulus /\
  (to_uint plain + 64 < to_uint output || to_uint output <= to_uint plain)
  ==>
  loads_8 Glob.mem output0 64 = map2 W8.(+^) (WArray64.to_list k0) (loads_8 mem0 plain0 64) /\
  (forall i, 0 <= i < W64.modulus => !(to_uint output0 <= i < to_uint output0 + 64) => 
     loadW8 Glob.mem (W64.of_int i) = loadW8 mem0 (W64.of_int i)) /\
  res.`1 = output0 + W64.of_int 64 /\
  res.`2 = plain0 + W64.of_int 64 /\
  res.`3 = len0 - W32.of_int 64.
proof.
  proc; inline *; wp => /=.
  while (0 <= i <= 64 /\
         output = output0 /\ plain = plain0 /\ k0 = k /\ 
         W64.to_uint output0 + 64 < W64.modulus /\
         W64.to_uint plain0 + 64 < W64.modulus /\
         (to_uint plain + 64 < to_uint output || to_uint output <= to_uint plain) /\
         loads_8 Glob.mem output0 i = 
           map2 W8.(+^) 
             (map (fun i => WArray64."_.[_]" k0 i) (iota_ 0 i))
             (loads_8 mem0 plain0 i) /\
         (forall j, 0 <= j < W64.modulus => !(to_uint output0 <= j < to_uint output0 + i) => 
            loadW8 Glob.mem (W64.of_int j) = loadW8 mem0 (W64.of_int j))).
  + wp; skip => /> &m h0i _ hob hpb hdisj hloads hdiff hi16;split; 1:smt().
    have hpi : to_uint (plain{m} + W64.of_int i{m}) = to_uint plain{m} + i{m}.
    + by rewrite  W64.to_uintD_small W64.to_uint_small /#.
    have hoi : to_uint (output{m} + W64.of_int i{m}) = to_uint output{m} + i{m}.
    + by rewrite  W64.to_uintD_small W64.to_uint_small /#. 
    split.
    + rewrite !loads_8D // iota_add // map_cat map2_cat.
      + by rewrite size_map size_iota size_loads_8.
      congr.
      + rewrite -hloads;apply loads_8_eq; 1:smt().
        move=> j hj.        
        rewrite  /loadW8 storeW8E get_set_neqE_s //.
        by rewrite to_uint_eq W64.to_uint_small; smt (W64.to_uint_cmp). 
      rewrite /loads_8 /= /loadW8 storeW8E /=;congr => //.
      rewrite (hdiff (to_uint (plain{m} + W64.of_int i{m}))).
      + by rewrite hpi; smt (W64.to_uint_cmp).
      + by rewrite hpi /#.
      by rewrite W64.to_uintK.
    move=> j h0j hjb hj.
    rewrite -hdiff 1:// 1:/# /loadW8 storeW8E get_set_neqE_s //.
    by rewrite to_uint_eq W64.to_uint_small 1:// hoi /#.
  wp;skip => /> *;split.
  + by rewrite /loads_8 iota0.
  move=> mem i0 h1 h2 h3.
  have ->> -> /> : i0 = 64 by smt(). 
  by move=> h *;apply h.
qed.

hoare sum_states_spec k0 st0 : M.sum_states : 
  is_state k0 k /\ is_state st0 st
  ==>
  is_state (Array16.map2 (fun (x y: W32.t) => x + y) k0 st0) res.
proof.
  proc.
  rewrite /is_state. 
  unroll for 2;wp;skip => /> &hr.
  by apply Array16.all_eq_eq;rewrite /all_eq.
qed.
  
lemma init16_set12 t w : 
  Array16.init (WArray64.get32 (WArray64.set32 t 12 w)) = 
  (Array16.init (WArray64.get32 t)).[12 <- w].
proof. by apply Array16.all_eq_eq;rewrite /Array16.all_eq /=. qed.

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
  seq 3: 
    ((to_uint plain{hr} + W32.to_uint len < to_uint output{hr} || to_uint output{hr} <= to_uint plain{hr}) /\
    to_uint output{hr} + to_uint len < W64.modulus /\
    to_uint plain{hr} + to_uint len < W64.modulus /\
    exists plain1 c, 
      let ilen = W32.to_uint len in
      let splain1 = size plain1 in
      to_uint output0 = to_uint output{hr} - size plain1 /\
      plain0 = plain1 ++ loads_8 Glob.mem plain ilen /\
      is_state (setup key0 nonce0 c) st /\
      iter (splain1 %/ 64) (ctr_round key0 nonce0) ([], plain0, counter0) = 
         (loads_8 Glob.mem output0 splain1, loads_8 Glob.mem plain ilen, c)).
  + conseq />;inline M.init.
    unroll for 15; unroll for 12; wp; skip => &m /> ???.
    exists [] counter{m} => /=.
    rewrite /is_state;split; 2: by rewrite /= div0z iter0.
    rewrite /setup /loads_32 /=.
    rewrite Array8.of_listK 1:// Array3.of_listK 1:// /=.
    pose l1 := (c0::_). pose l2 := (Array16.init _).
    (* why did we need the pose l1, l2 ? *)
    apply: (Core.canLR _ _ l1 l2 (Array16.to_listK witness)).
    by rewrite /l1 /l2 /c0 /c1 /c2 /c3 /Array16.to_list /mkseq.
  seq 1 : (#pre).
  + while (#pre) => //.
    elim * => plain1 counter1 /=.
    inline M.increment_counter; wp.
    pose st0 := (setup key0 nonce0 counter1).
    ecall (store_spec output plain len k Glob.mem).
    ecall (sum_states_spec (rounds st0) st0).
    ecall (rounds_spec st0).
    ecall (copy_state_spec st).
    skip => /> &hr hnot hout hplain hout0 hst hiter ^ hule.
    have h64 : to_uint (W32.of_int 64) = 64 by rewrite W32.to_uint_small.
    have h64' : to_uint (W64.of_int 64) = 64 by rewrite W64.to_uint_small.
    rewrite W32.uleE h64 => hlen hst0 res0 hres0 res1 hres1.
    split; 1:smt().
    move=> ho64 hp64 hop [output' plain' len'] mem hload hdiff /= 3!->>.
    rewrite W32.to_uintB 1:// h64.
    rewrite !W64.to_uintD_small h64' //;split; 1:smt().
    split;[smt() | split;1:smt()].
    exists (plain1 ++ loads_8 Glob.mem{hr} plain{hr} 64) (counter1 + W32.of_int 1).
    split. 
    + by rewrite size_cat size_loads_8 /#.  
    split.
    + rewrite -catA; congr.
      have -> : loads_8 mem (plain{hr} + W64.of_int 64) (to_uint len{hr} - 64) = 
                loads_8 Glob.mem{hr} (plain{hr} + W64.of_int 64) (to_uint len{hr} - 64).
      + apply loads_8_eq. 
        + by rewrite W64.to_uintD_small h64' // /#.
        by move=> i; rewrite W64.to_uintD_small h64' 1://; smt (W64.to_uint_cmp).
      by rewrite -loads_8D 1:// /#. 
    split.
    + move: hst; rewrite /setup /is_state init16_set12 => hst.
      rewrite -hst -!catA;apply Array16.all_eq_eq;rewrite /Array16.all_eq /=.
      rewrite !nth_cat; rewrite Array8.size_to_list /=.
      have -> : WArray64.get32 st{hr} 12 = (Array16.init (WArray64.get32 st{hr})).[12] by done.
      by rewrite -hst /= -catA nth_cat Array8.size_to_list.
    rewrite size_cat size_loads_8 /max /= -{1}(mul1z 64) divzMDr 1:// addzC iterS.
    + by apply divz_ge0 => //; apply List.size_ge0.
    rewrite hiter /ctr_round /=;split.
    + rewrite loads_8D 1:List.size_ge0 1://;congr.
      apply loads_8_eq;1:by rewrite hout0 /#.
      move=> i hi;rewrite hdiff 3://; smt (W64.to_uint_cmp).
    have -> : output0 + W64.of_int (size plain1) = output{hr}.
    + have hplain1 : to_uint (W64.of_int (size plain1)) = size plain1.
      + rewrite W64.to_uint_small; smt (W64.to_uint_cmp size_ge0).
      by apply to_uint_eq; rewrite W64.to_uintD_small hplain1 /#. 
    rewrite hload.
rewrite /bytes_of_block /chacha20_block hst /= /chacha20_core.

 hst0.
print is_state.
smt().
W64.to_uintD_small. admit.
;  smt().
      have := W64.to_uintK.
      

admit.
    admit.
   
print ge0_size.

search (0 <= _ %/ _).
search iter.
iterS
search Int.(+) (%/).
((_ + _) %% _).
      done. 
ext_eq => x hx.
      rewrite Array16.get_setE 1://;case: (x=12) => [->> | hne].
      + rewrite -catA /= nth_cat Array8.size_to_list /=.
        admit.

      search nth.
Array8.size
search nth (++).
all_eq_eq; apply Array

rewrite /Array16.all_eq. 
print Array16.allP.
 apply Array16.allP.

print
rewrite /Array16.all_eq /=.

(init ((get32 ((set32 st{hr} 12 ((get32 st{hr} 12)%WArray64 + W32.one)))%WArray64))%WArray64)%Array16
1:/#.

search W64.to_uint W64.(+).
    have : to_uint (len{hr} - (of_int 64)%W32) = to_uint len{hr} - 64.
W32.to_uintB
search W32.to_uint W32.([-]).

 split. smt(). split. smt(). smt().
search W64.to_uint W64.of_int.
 W64.to_uint_small.
search W32.(\ule).
    to_uint output{hr} + to_uint len < W64.modulus.
    to_uint plain{hr} + to_uint len < W64.modulus.
print rounds_spec.
    



 proc store (output:W64.t, plain:W64.t, len:W32.t, k:WArray64.t) : W64.t *
                                                                    W64.t *
                                                                    W32.t = {
    var aux: int;
    
    var i:int;
    
    i <- 0;
    while (i < 16) {
      k = set32 k i ((get32 k i) `^` (loadW32 Glob.mem (plain + (W64.of_int (4 * i)))));
      Glob.mem <-
      storeW32 Glob.mem (output + (W64.of_int (4 * i))) (get32 k i);
      i <- i + 1;
    }
    (output, plain, len) <@ update_ptr (output, plain, len, 64);
    return (output, plain, len);
  }
  
    print ctr_round.
print c0.
search Array16.of_list.

    rewrite /all_eq => />.
search Array8.to_list Array8.of_list.
 /all_eq => />.

   (iter (if ilen %% 64 = 0 then ilen %/ 64 else ilen %/ 64 + 1) 
     (ctr_round key0 nonce0)
     (loads_8 Glob.mem output0 (size plain1), loads_8 Glob.mem ilen, get32 st 12)) 
print ctr_round.

is_state (setup key0 nonce0 counter) st.


search IterOp.iter Int.(+).

  seq 3 : 

 proc init (key:W64.t, nonce:W64.t, counter:W32.t) : WArray64.t = {
    var aux: int;
    
    var st:WArray64.t;
    var i:int;
    st <- WArray64.create W8.zero;
    st = set32 st 0 (W32.of_int 1634760805);
    st = set32 st 1 (W32.of_int 857760878);
    st = set32 st 2 (W32.of_int 2036477234);
    st = set32 st 3 (W32.of_int 1797285236);
    i <- 0;
    while (i < 8) {
      st = set32 st (4 + i) (loadW32 Glob.mem (key + (W64.of_int (4 * i))));
      i <- i + 1;
    }
    st = set32 st 12 counter;
    i <- 0;
    while (i < 3) {
      st = set32 st (13 + i) (loadW32 Glob.mem (nonce + (W64.of_int (4 * i))));
      i <- i + 1;
    }
    return (st);
  }

  proc chacha20_ref (output:W64.t, plain:W64.t, len:W32.t, key:W64.t,
                     nonce:W64.t, counter:W32.t) : unit = {

proc chacha20_ref (output:W64.t, plain:W64.t, len:W32.t, key:W64.t,
                     nonce:W64.t, counter:W32.t)
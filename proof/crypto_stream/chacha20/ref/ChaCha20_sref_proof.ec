require import AllCore List Jasmin_model Int IntDiv IntExtra CoreMap.
import IterOp.
require import ChaCha20_Spec ChaCha20_pref ChaCha20_pref_proof ChaCha20_sref.
require import Array3 Array8 Array16.
require import WArray64.

equiv init : ChaCha20_pref.M.init ~ ChaCha20_sref.M.init :
  ={key, nonce, counter, Glob.mem} ==>
  ={res}.
proof.
  proc.
  while (={i,st, nonce, Glob.mem} /\ 0 <= i{1}).
  + wp. skip => /> &1 ??.
    by rewrite Array3.get_setE //= /#.
  wp;while(={i,st,key, Glob.mem} /\ 0 <= i{1}).
  + wp;skip => /> &1 ??.
    by rewrite Array8.get_setE //= /#.
  wp;skip => />.
qed.

equiv copy_state : ChaCha20_pref.M.copy_state ~ ChaCha20_sref.M.copy_state :
  ={st} ==> res{1} = res{2}.`1.[15 <- res{2}.`2].
proof.
  proc => /=.
  conseq (_: Array16.all_eq k{1} k{2}.[15 <- s_k15{2}]). 
  + by move=> *;apply Array16.all_eq_eq.
  by unroll for {2} 5; wp; skip => />.
qed.

equiv line_spec i ki: ChaCha20_pref.M.line ~ ChaCha20_sref.M.line : 
    (0 <= i < 16 /\ ={a,b,c,r} /\ k{1} = k{2}.[i <- ki] /\ (a <> i /\ b <> i /\ c <> i){1}) ==>
    res{1} = res{2}.[i <- ki].
proof.
  proc;wp;skip => /> &2 h0i hi ha hb hc.
  rewrite !(Array16.get_setE _ i) // ha hb /=.
  rewrite (Array16.set_set_if _ i) (eq_sym i) ha /=.
  rewrite (Array16.set_set_if _ i) (eq_sym i) hc /=.
  congr; congr.
  rewrite (Array16.set_set_if _ i) (eq_sym i) hc /=.
  by rewrite !(Array16.get_setE _ i) // hc ha.
qed.

equiv quarter_round_spec i ki: ChaCha20_pref.M.quarter_round ~ ChaCha20_sref.M.quarter_round : 
    (0 <= i < 16 /\ ={a,b,c,d} /\ k{1} = k{2}.[i <- ki] /\ (a <> i /\ b <> i /\ c <> i /\ d<>i){1}) ==>
    res{1} = res{2}.[i <- ki].
proof.
  proc; do 4! call (line_spec i ki);skip => />.
qed.

equiv rounds : ChaCha20_pref.M.rounds ~ ChaCha20_sref.M.rounds :
  k{1} = k{2}.[15 <- k15{2}] ==>
  res{1} = res{2}.`1.[15 <- res{2}.`2].
proof.
  proc => /=.
  while ( ={c} /\ k{1} = k{2}.[15 <- k15{2}]);last by by wp;skip.
  inline{1} ChaCha20_pref.M.round ChaCha20_pref.M.column_round ChaCha20_pref.M.diagonal_round.
  wp. 
  ecall (quarter_round_spec 15 k15{2}) => /=.
  ecall (quarter_round_spec 15 k15{2}) => /=.
  wp.
  ecall (quarter_round_spec 14 k14{2}) => /=.
  ecall (quarter_round_spec 14 k14{2}) => /=.
  wp;ecall (quarter_round_spec 14 k14{2}) => /=.
  wp;ecall (quarter_round_spec 14 k14{2}) => /=.
  wp.
  ecall (quarter_round_spec 15 k15{2}) => /=.
  ecall (quarter_round_spec 15 k15{2}) => /=.
  by wp;skip => /> *;split => *; rewrite Array16.set_set_if /= Array16.set_notmod.
qed.

equiv sum_states : ChaCha20_pref.M.sum_states ~ ChaCha20_sref.M.sum_states :
  ={st} /\ k{1} = k{2}.[15 <- k15{2}] ==>
  res{1} = res{2}.`1.[15 <- res{2}.`2].
proof.
  proc => /=.  
  unroll for{1} 2; unroll for{2} 2.
  conseq (_: all_eq k{1} k{2}.[15 <- k15{2}]).
  + by move=> &1 &2 _ k1 k2 k15 /Array16.all_eq_eq. 
  wp; skip => />.
qed.

require import Real.


theory Loop.

type t.
op c : int.

module type AdvLoop = {
  proc body(t:t, i:int) : t
}.


module Loop(B:AdvLoop) = {
  proc loop1 (t:t, n:int) = {
    var i;
    i = 0;
    while (i < n) {
      t <@ B.body(t,i);
      i <- i + 1;
    }
    return t;
  }

  proc loopk (t:t, n:int, k:int) = {
    var i, j;
    i = 0;
    while (i < n) {
      j = 0;
      while (j < k) {
        t <@ B.body(t, k * i + j);
        j <- j + 1;
      }
      i <- i + 1;
    }
    return t;
  }

  proc loopc (t:t, n:int) = {
    var i, j;
    i = 0;
    while (i < n) {
      j = 0;
      while (j < c) {
        t <@ B.body(t, c * i + j);
        j <- j + 1;
      }
      i <- i + 1;
    }
    return t;
  }

}.

section.
declare module B:AdvLoop.

axiom B_ll : islossless B.body.

equiv loop1_loopk : Loop(B).loop1 ~ Loop(B).loopk : ={t, glob B} /\ n{1} = (k * n){2} /\ 0 < k{2}==> ={res, glob B}.
proof.
  proc.
  async while [ (fun r => i%r < r), (i{1}+k{2})%r ] 
              [ (fun r => i%r < r), (i{2} + 1)%r ]
  
              ( (i < n){1} /\ (i < n){2}) 
              (!(i < n){2}) : 
              (={t, glob B} /\ (0 <= i <= n){2} /\ 0 < k{2} /\ n{1} = (k * n){2} /\ i{1} = k{2} * i{2}).
  + smt(). + smt (). + smt().
  + move=> &m2;exfalso;smt().
  + move=> &m1;exfalso;smt().
  + move=> v1 v2.
    rcondt{2} 1; 1: by auto => /> /#.
    rcondf{2} 4; 1: by auto; conseq (_: true);auto.
    exlim i{2} => i2.
    wp;while (={t,glob B} /\ i{1} = k{2}*i{2} + j{2} /\ 0 <= i{2} < n{2} /\ 
              0 <= j{2} <= k{2} /\ v1 = (k{2} * i2 + k{2})%r /\ i{2} = i2 /\ n{1} = (k * n){2}).
    + wp;call (_: true);skip => /> &2 h0i hin h0j hjk.
      rewrite !RealExtra.lt_fromint => h1 h2 h3.
      have := StdOrder.IntOrder.ler_wpmul2l k{2} _ i{2} (n{2} - 1); smt(). 
    by wp;skip => /> /#.
  + by while (true) (n - i);auto;1:call B_ll;auto => /> /#.
  + while (true) (n-i);2: by auto=>/#.
    by move=> z;wp; while (true) (k - j);auto;1:call B_ll;auto => /> /#.
  by auto.
qed.

equiv loopk_loopc : Loop(B).loopk ~ Loop(B).loopc : ={n,t, glob B} /\ k{1} = c ==> ={res, glob B}.
proof.
  proc => /=.
  while (={glob B, i, t, n} /\ k{1} = c);2: by auto.
  wp;while (={glob B, i, j, t, n} /\ k{1} = c);2: by auto.
  by wp;call (_:true);skip.
qed.

lemma loop1_loopc : 0 < c =>
  equiv [Loop(B).loop1 ~ Loop(B).loopc : ={t, glob B} /\ n{1} = (c * n){2} ==> ={res, glob B}].
proof.
  move=> hc.
  transitivity Loop(B).loopk
    (={t, glob B} /\ n{1} = c * n{2} /\ k{2} = c ==> ={res, glob B})
    (={n,t, glob B} /\ k{1} = c ==> ={res, glob B}).
  + by move=> /> &1 &2 *; exists (glob B){2} (t{1},n{2}, c).
  + by move=> />.
  + by conseq loop1_loopk => /> /#. 
  by conseq loopk_loopc.  
qed.

end section.

end Loop.

clone import Loop as Loop0 with
   type t <- W64.t * W64.t * W32.t Array16.t,
   op c <- 4.

op inv_ptr (output plain:W64.t) (len:W32.t) = 
  (to_uint plain + to_uint len < to_uint output || to_uint output <= to_uint plain) /\
   to_uint output + to_uint len < W64.modulus /\
   to_uint plain + to_uint len < W64.modulus.

lemma inv_ptr_disj len output plain i1 i2:
  inv_ptr output plain len =>
  0 <= i1 <= to_uint len =>
  0 <= i2 <= to_uint len =>
  i1 < i2 => 
  plain + W64.of_int i2 <> output + W64.of_int i1.
proof.
  rewrite /inv_ptr /= => [#] h1 h2 h3 hi1 hi2 hlti.
  rewrite eq_sym -W64.WRingA.eqr_sub W64.WRingA.subr_eq -W64.WRingA.addrA
     (W64.WRingA.addrC _ (W64.of_int i2)) /=; apply /negP => ->>.
  have hii: to_uint (W64.of_int (i2 - i1)) = i2 - i1.
  + by rewrite W64.to_uint_small //=;have /= /#:= W32.to_uint_cmp len.
  have /# :  to_uint (plain + (W64.of_int (i2 - i1))) = to_uint plain + (i2 - i1).
  by rewrite W64.to_uintD_small hii /#.
qed.

module Body = {
  proc body (t: W64.t * W64.t * W32.t Array16.t, i:int) = {
    var output, plain, k;
    (output, plain, k) <- t;
    Glob.mem <-                
       storeW8 Glob.mem (output + (of_int i)%W64)       
          (get8 ((init32 (fun (i0 : int) => k.[i0])))%WArray64 i `^` loadW8 Glob.mem (plain + (of_int i)%W64));
    return t;
  }
}.

lemma load_storeW8 m p1 p2 w: 
  loadW8 (storeW8 m p1 w) p2 = if p2 = p1 then w else loadW8 m p2.
proof. by rewrite /loadW8 storeW8E Jasmin_memory.get_setE. qed.

equiv store_store32 len0 : ChaCha20_pref.M.store ~ ChaCha20_pref.M.store32 : 
  ={Glob.mem, k, output, plain, len} /\ W32.of_int 64 \ule len{1} /\
  (inv_ptr output plain len){1} /\ len{1} = len0
  ==>
  ={Glob.mem, res} /\ (inv_ptr res.`1 res.`2 res.`3){1} /\ res{1}.`3 = len0 - W32.of_int 64.
proof.
  proc.
  inline ChaCha20_pref.M.update_ptr;wp => /=.
  transitivity{1} { Loop(Body).loop1((output, plain, k), 64);}
       (={Glob.mem, output, plain, len, k} /\ (of_int 64)%W32 \ule len{1} ==> ={Glob.mem, output, plain, len, k} /\ i{1} = 64)
       (={Glob.mem, k, output, plain, len} /\
         ((of_int 64)%W32 \ule len{1}) /\ inv_ptr output{1} plain{1} len{1} /\ len{1} = len0 ==>
        ={Glob.mem, output, plain, len} /\ inv_ptr (output{1} + (of_int 64)%W64) (plain{1} + (of_int 64)%W64) (len{1} - (of_int 64)%W32) /\
        len{1} = len0).
  + by move=> /> &2 *;exists Glob.mem{2} k{2} len{2} output{2} plain{2}. 
  + by move=> />.
  + inline *.
    while ( ={Glob.mem, output, plain, len, k} /\ i{1} = i0{2} /\ 0 <= i{1} <= 64 /\ (t = (output, plain, k)){2} /\ 64 <= to_uint len{1} /\ n0{2} = 64).
    + by auto => /> &2 h1 h2 h3;rewrite !W32.ultE !W32.to_uint_small /= /#.
    by auto => /> &2;rewrite W32.uleE W32.ultE /= /#.
  transitivity{1} { Loop(Body).loopc((output, plain, k), 16);}
       (={Glob.mem, output, plain, len, k} ==> ={Glob.mem, output, plain, len, k})
       (={Glob.mem, k, output, plain, len} /\
         ((of_int 64)%W32 \ule len{1}) /\ inv_ptr output{1} plain{1} len{1} /\ len{1} = len0 ==>
        ={Glob.mem, output, plain, len} /\ inv_ptr (output{1} + (of_int 64)%W64) (plain{1} + (of_int 64)%W64) (len{1} - (of_int 64)%W32) /\
        len{1} = len0).
  + by move=> /> &2 *;exists Glob.mem{2} k{2} len{2} output{2} plain{2}. 
  + by move=> />.
  + by call (loop1_loopc Body _ _);[islossless | | skip].
  inline *;wp.
  while ( ={Glob.mem, k, output, plain, len} /\ inv_ptr output{1} plain{1} len{1} /\ 64 <= to_uint len{1} /\
          n0{1} = 16 /\ i0{1} = i{2} /\  0 <= i{2} /\ (t = (output, plain, k)){1}).
  + unroll for {1} 2;wp;skip => |> &2 h1 h2 h3 h4. 
    pose ini := WArray64.init32 (fun (i0 : int) => k{2}.[i0]).
    split; 2: smt().
    have b0 : 0 <= 4 * i{2} <= to_uint len{2} by smt().
    have b1 : 0 <= 4 * i{2} + 1 <= to_uint len{2} by smt().
    have b2 : 0 <= 4 * i{2} + 2 <= to_uint len{2} by smt().
    have b3 : 0 <= 4 * i{2} + 3 <= to_uint len{2} by smt().
    do 6!rewrite load_storeW8 (inv_ptr_disj len{2}) // 1:-StdOrder.IntOrder.ltr_subl_addl 1:/# /=. 
    rewrite -load4u8.
    have -> : k{2}.[i{2}] = pack4 [get8 ini (4 * i{2}); get8 ini (4 * i{2} + 1);
                                get8 ini (4 * i{2} + 2); get8 ini (4 * i{2} + 3)].
    + have <- := W4u8.unpack8K k{2}.[i{2}].
      congr; apply W4u8.Pack.all_eq_eq.
      rewrite /all_eq /get8 /ini /init32 /= !WArray64.initiE 1..4:/# /=.
      by rewrite mulzC !modzMDl /= modzMl mulzK 1:// !divzMDl. 
    by rewrite /= store4u8.    
  wp;skip => /> &2 ^ h0;rewrite W32.uleE /= => /> h1 h2 h3 h4 i ??. 
  rewrite W32.to_uintB 1:// /=.
  by rewrite W64.to_uintD_small 1:/# W64.to_uintD_small 1:/# /= /#. 
qed.

equiv store len0 : ChaCha20_pref.M.store ~ ChaCha20_sref.M.store :
  ={Glob.mem} /\ output{1} = s_output{2} /\ plain{1} = s_plain{2} /\ len{1} = s_len{2} /\
  W32.of_int 64 \ule len{1} /\ (inv_ptr output plain len){1} /\ len{1} = len0 /\
  k{1} = k{2}.[15 <- k15{2}] 
  ==>
  ={Glob.mem, res} /\ (inv_ptr res.`1 res.`2 res.`3){1} /\ res{2}.`3 = len0 - W32.of_int 64.
proof.
  transitivity ChaCha20_pref.M.store32
    (={Glob.mem, k, output, plain, len} /\ W32.of_int 64 \ule len{1} /\
     (inv_ptr output plain len){1} /\ len{1} = len0
     ==>
     ={Glob.mem, res} /\ (inv_ptr res.`1 res.`2 res.`3){1} /\ res{1}.`3 = len0 - W32.of_int 64)
    (={Glob.mem} /\ output{1} = s_output{2} /\ plain{1} = s_plain{2} /\ len{1} = s_len{2} /\ k{1} = k{2}.[15 <- k15{2}]
     ==> 
     ={Glob.mem, res}).
  + move=> /> *; by exists Glob.mem{2} (s_output, s_plain, s_len, k.[15 <- k15]){2}.
  + by move=> />.
  + by apply (store_store32 len0).
  proc => /=.  
  sim.
  seq 0 3 : (#pre /\ (s_k.[0] = k.[12] /\ s_k.[1] = k.[13] /\ s_k.[2] = k.[14]){2}).
  + by unroll for{2} 3; wp;skip => />.
  sp 0 3.
  splitwhile {1} 2 : (i < 12).
  seq 2 2: (={Glob.mem, output, plain, len} /\ k{1}.[12] = s_k{2}.[0] /\ 
             k{1}.[13] = s_k{2}.[1] /\ k{1}.[14] = s_k{2}.[2] /\ k{1}.[15] = k15{2} /\ i{1} = 12).
  + by while (={i} /\ #{/~i{1}}post /\ (0 <= i{1} <= 12) /\ (forall j, i{1} <= j < 12 => k{1}.[j] = k{2}.[j]));
     wp;skip; smt(Array16.get_setE).
  rcondt{1} 1; 1:by auto. 
  rcondt{1} 3; 1:by auto. 
  rcondt{1} 5; 1:by auto. 
  rcondt{1} 7; 1:by auto. 
  rcondf{1} 9; 1:by auto. 
  by unroll for{2} 5; unroll for{2} 2; wp;skip => /> &1 &2 -> -> ->.
qed.

equiv store_last : ChaCha20_pref.M.store ~ ChaCha20_sref.M.store_last :
  ={Glob.mem} /\ output{1} = s_output{2} /\ plain{1} = s_plain{2} /\ len{1} = s_len{2} /\
  (len{1} \ult W32.of_int 64) /\ k{1} = k{2}.[15 <- k15{2}] 
  ==>
  ={Glob.mem} /\ res{1}.`3 = W32.of_int 0.
proof.
  proc => /=.
  inline *;wp.
  seq 0 8 :  (={Glob.mem, output, plain, len} /\ W32.to_uint len{1} < 64 /\ k{1} = s_k{2}).
  + conseq (_ : ={Glob.mem, output, plain, len} /\ W32.to_uint len{1} < 64 /\ Array16.all_eq k{1} s_k{2} ).
    + by move=> |> &2 ???; apply Array16.all_eq_eq.
    by unroll for{2} 3;wp;skip => /> &2;rewrite W32.ultE.
  while (#pre /\ j{2} = W64.of_int i{1} /\ 0 <= i{1} <= W32.to_uint len{1}).
  + wp;skip => /> &1 &2 ???; rewrite !W32.ultE W32.to_uint_small /= 1:/#.
    rewrite W8.xorwC /=.
    rewrite W64.to_uint_small //= 1:/# !W2u32.to_uint_truncateu32.
    rewrite !W64.to_uint_small //= 1,2:/#.
    by rewrite W32.to_uint_small //= 1:/#; smt(modz_small).
  wp;skip => /> &2 ?.
  case: (W32.to_uint_cmp len{2}) => /> ?? i; rewrite W32.ultE => + *. 
  rewrite W32.to_uint_small /= 1:/# => ?.
  by rewrite (canRL _ _ len{2} i W32.to_uintK) 1:/#.
qed.

equiv increment_counter: ChaCha20_pref.M.increment_counter ~ ChaCha20_sref.M.increment_counter :
  ={st} ==> ={res}.
proof.
  by proc;auto => /> &2;rewrite W32.WRingA.addrC.
qed.

equiv pref_sref : ChaCha20_pref.M.chacha20_ref ~ ChaCha20_sref.M.chacha20_ref : 
  ={output, plain, len, key, nonce,counter, Glob.mem} /\
  (inv_ptr output plain len){1}
  ==>
  ={Glob.mem}.
proof.
proc => /=.
sp; seq 1 1 : (#{/~(_ = witness)}pre /\ ={st}).
+ by call init;skip => />.
splitwhile{1} 1 : (W32.of_int 64 \ule len).
seq 1 1 : (={st, Glob.mem} /\ 
           output{1} = s_output{2} /\ plain{1} = s_plain{2} /\ len{1} = s_len{2} /\
           len{1} \ult W32.of_int 64). 
+ while (={st, Glob.mem} /\ 
          output{1} = s_output{2} /\ plain{1} = s_plain{2} /\ len{1} = s_len{2} /\
          (inv_ptr output plain len){1}). 
  + call increment_counter;ecall (store len{1}); call sum_states; call rounds; call copy_state.
    skip => /> &m; rewrite W32.ultE W32.uleE /= => ????????? ->.
    by rewrite W32.uleE W32.ultE /= W32.to_uintB 1:W32.uleE //= /#.
  skip => /> &m;rewrite W32.uleE W32.ultE /= => *;split => [/# | s_len_R out pla].
  by rewrite !W32.uleE !W32.ultE /= /#.
unroll{1} 1.
seq 1 1 : (={Glob.mem} /\ len{1} = W32.of_int 0);last first.
+ by rcondf{1} 1; move=> *;skip => />.
if => //;last first.
+ skip => /> &m;rewrite !W32.ultE /= => ??.
  apply W32.to_uintRL => /=;rewrite modz_small 1://; smt (W32.to_uint_cmp).
inline{1}ChaCha20_pref.M.increment_counter;wp.
call store_last; call sum_states; call rounds; call copy_state;skip => />.
qed.

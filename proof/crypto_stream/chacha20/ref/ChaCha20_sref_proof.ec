require import AllCore List Jasmin_model Int IntDiv IntExtra CoreMap LoopTransform.
import IterOp.
require import ChaCha20_Spec ChaCha20_pref ChaCha20_pref_proof ChaCha20_sref.
require import Array3 Array8 Array16.
require import WArray64.

(* ------------------------------------------------------------------------------- *)
(* We start by cloning ChaCha20_sref but using "int" instead of W64.t for pointer. *)
(* Compare to ChaCha20_pref we change the way of writting into memory              *)
theory ChaCha20_srefi.

module M = {
  include ChaCha20_pref.M [init, line, quarter_round, column_round, diagonal_round, round, rounds, sum_states, update_ptr, increment_counter]

  proc store (output plain:address, len: int, k:W32.t Array16.t) : int * int * int = {
    var i:int;
    
    i <- 0;
    while ((i < 16)) {
      Glob.mem <- storeW32 Glob.mem (output + 4 * i) (k.[i] `^` loadW32 Glob.mem (plain + 4 * i));
      i <- (i + 1);
    }
    (output, plain, len) <@ update_ptr (output, plain, len, 64);
    return (output, plain, len);
  }

  proc store_last (output plain:address, len: int, k:W32.t Array16.t) = {
    var j:int;
    j <- 0;
    while (j < len) {
      Glob.mem <- storeW8 Glob.mem (output + j) 
       (loadW8 Glob.mem (plain + j) `^` (get8 (WArray64.init32 (fun i => k.[i])) j));
      j <- j + 1;
    }
  }

  proc chacha20_ref (output plain:address, len:int, key nonce: address, counter:W32.t) : unit = {
    
    var st:W32.t Array16.t;
    var k:W32.t Array16.t;

    st <@ init (key, nonce, counter);    
    while (64 <= len) {
      k <@ rounds (st);
      k <@ sum_states (k, st);
      (output, plain, len) <@ store (output, plain, len, k);
      st <@ increment_counter (st);
    }
    if (0 < len) {
      k <@ rounds (st);
      k <@ sum_states (k, st);
      store_last (output, plain, len, k);
    }
  }   
}.

end ChaCha20_srefi.

phoare store_srefi_spec output0 plain0 len0 k0 mem0 : [ChaCha20_srefi.M.store : 
  output = output0 /\ plain = plain0 /\ len = len0 /\ k = k0 /\ Glob.mem = mem0 /\ 
  64 <= len /\ inv_ptr output plain len 
  ==>
  res = (output0 + 64, plain0 + 64, len0 - 64) /\ 
  forall j, 
    Glob.mem.[j] =
      if in_range output0 64 j then
        let j = j - output0 in
        (init32 (fun (i0 : int) => k0.[i0])).[j] `^` mem0.[plain0 + j]
      else mem0.[j]]= 1%r.
proof.
  proc; inline *; wp.
  while (0 <= i <= 16 /\ inv_ptr output plain 64 /\ 
    forall j, 
      Glob.mem.[j] = 
      if in_range output (4 * i) j then 
        let j = j - output in
        (init32 (fun (i0 : int) => k.[i0])).[j] `^` mem0.[plain + j]
      else mem0.[j]) (16 - i).
  + move=> z;wp; skip=> /> &hr _ hi16 hinv hj h0i; split; 2: smt().
    split; 1: smt().
    move=> j. rewrite get_storeW32E.
    have hhi: 0 <= 4 * i{hr} /\ 4 * i{hr} + 4 <= 64 by smt(). 
    case: (output{hr} + 4 * i{hr} <= j < output{hr} + 4 * i{hr} + 4)=> [ h1 | /#].
    rewrite (_: in_range output{hr} (4 * (i{hr} +1)) j) 1:/# /=. 
    rewrite xorb8E 1:/# /init32 WArray64.initE /= (_:0 <= j - output{hr} < 64) 1:/# /=.
    rewrite loadW32_bits8 1:/# /loadW8 hj.
    rewrite (_: !in_range output{hr} (4 * i{hr}) (plain{hr} + 4 * i{hr} + (j - (output{hr} + 4 * i{hr})))) 1:/#.
    by have [h2 h3] /# := euclideUl 4 i{hr} ((j - output{hr}) - 4*i{hr}) (j-output{hr}) _ _;
        [rewrite -divz_eq; ring |  smt()].
  wp; skip => /> &hr hlen hinv;split; 1:smt().
  move=> mem i0; split; 1: smt().
  move=> ???; have ->> /= : i0 = 16; smt().
qed.

phoare store_last_srefi_spec output0 plain0 len0 k0 mem0 : [ChaCha20_srefi.M.store_last : 
  output = output0 /\ plain = plain0 /\ len = len0 /\ k = k0 /\ Glob.mem = mem0 /\ 
  0 <= len < 64 /\ inv_ptr output plain len 
  ==>
  forall j, 
    Glob.mem.[j] =
      if in_range output0 len0 j then
        let j = j - output0 in
        (init32 (fun (i0 : int) => k0.[i0])).[j] `^` mem0.[plain0 + j]
      else mem0.[j]]= 1%r.
proof.
  proc; inline *; wp.
  while (0 <= j <= len /\ inv_ptr output plain len /\ 
    forall i, 
      Glob.mem.[i] = 
      if in_range output j i then 
        let i = i - output in
        (init32 (fun (i0 : int) => k.[i0])).[i] `^` mem0.[plain + i]
      else mem0.[i]) (len - j).
  + move=> z;wp; skip=> /> &hr _ hi16 hinv hj h0i; split; 2: smt().
    split; 1: smt().
    move=> i. 
    rewrite storeW8E get_setE W8.xorwC /get8 /loadW8.
    case: (i = output{hr} + j{hr}) => [-> | hne]. smt().
    rewrite hj.
    have -> // : in_range output{hr} j{hr} i = in_range output{hr} (j{hr} + 1) i. smt().
  wp; skip => /> &hr h0len hlen hinv;split; 1: smt().
  move=> mem j0; split; 1: smt().
  move=> ???; have ->> /= : j0 = len{hr}; smt().
qed.

equiv eq_store32_pref_srefi len0 : ChaCha20_pref.M.store ~ ChaCha20_srefi.M.store :
  ={output, plain, len, k, Glob.mem} /\ len{1} = len0 /\ (inv_ptr output plain len){1} /\ 64 <= len{1} ==> 
  ={res, Glob.mem} /\ res{1}.`3 = len0 - 64 /\ (inv_ptr res.`1 res.`2 res.`3){1}.
proof.
  proc *.
  ecall{1}(store_pref_spec output{1} plain{1} len{1} k{1} Glob.mem{1}).
  ecall{2}(store_srefi_spec output{1} plain{1} len{1} k{1} Glob.mem{1}).
  skip => /> &1 &2 4!<- /= h hlen. rewrite h hlen /= => m2 hm2.
  have -> : min 64 len{1} = 64 by smt().
  rewrite  /= (_: 0 <= len{1}) 1:/# /= => m1 hinv hm1.
  by apply mem_eq_ext => j;rewrite hm1 hm2.
qed.

equiv eq_store_last_pref_srefi : ChaCha20_pref.M.store ~ ChaCha20_srefi.M.store_last :
  ={output, plain, len, k, Glob.mem} /\ (inv_ptr output plain len){1} /\ 0 <= len{1} < 64 ==> 
  ={Glob.mem}.
proof.
  proc *.
  ecall{1}(store_pref_spec output{1} plain{1} len{1} k{1} Glob.mem{1}).
  ecall{2}(store_last_srefi_spec output{1} plain{1} len{1} k{1} Glob.mem{1}).
  skip => /> &1 &2 4!<- /= h h0len hlen; rewrite h h0len hlen /= => m2 hm2 m1 _ hm1.
  by apply mem_eq_ext => j;rewrite hm1 hm2 /#.
qed.

equiv eq_chacha20_pref_srefi : ChaCha20_pref.M.chacha20_ref ~ ChaCha20_srefi.M.chacha20_ref : 
   ={output, plain, len, key, nonce, counter, Glob.mem} /\ (inv_ptr output plain len){1} ==>
   ={Glob.mem}.
proof.
  proc => /=.
  splitwhile{1} 2 : (64 <= len).
  seq 2 2 : (={st, output, plain, len, Glob.mem} /\ (inv_ptr output plain len){1} /\ len{1} < 64).
  + while (={st, output, plain, len, Glob.mem} /\ (inv_ptr output plain len){1}).
    + call (_:true); 1: sim.
      ecall (eq_store32_pref_srefi len{1}) => /=.
      conseq (_: ={k,st}); 1: by move=> /> /#.
      by sim.
    conseq (_: ={st}); 1: by move=> /> /#.
    by sim.  
  if{2}; last by rcondf{1} 1; auto.
  rcondt{1} 1; 1: by auto.
  rcondf{1} 5.
  + move=> &m2. 
    swap -1; inline ChaCha20_pref.M.store ChaCha20_pref.M.update_ptr; wp.
    swap 6 -5; sp.  
    while (i <= min 64 len0); 1: by wp;skip => /#.
    by wp; conseq (_: true) => //; smt().
  call{1} (_:true ==> true); 1:islossless.
  call eq_store_last_pref_srefi => /=.
  conseq (_: ={output, plain, len, k, Glob.mem}); 1:smt().
  by sim.
qed.

(* ------------------------------------------------------------------------------- *)
(* We now prove that ChaCha20_srefi, is equivalent to the concret implementation   *)
(* ChaCha20_sref                                                                   *)

op good_ptr (output plain len : int) =  
  output + len < W64.modulus /\
  plain + len < W64.modulus.

equiv eq_init_srefi_sref : ChaCha20_srefi.M.init ~ ChaCha20_sref.M.init :
  key{1} = to_uint key{2} /\ nonce{1} = to_uint nonce{2} /\  (key + 32 < W64.modulus /\ nonce + 12 < W64.modulus){1} /\
    ={Glob.mem, counter} 
  ==>
  ={res}.
proof.
  proc.
  while (={i,st, Glob.mem} /\ nonce{1} = to_uint nonce{2} /\ (nonce + 12 < W64.modulus /\ 0 <= i){1}).
  + wp; skip => /> &2 3?.
    have heq : to_uint (W64.of_int (4 * i{2})) = 4 * i{2}.
    + by rewrite to_uint_small /= /#. 
    by rewrite Array3.get_setE //= to_uintD_small heq /= /#. 
  wp;while(={i,st, Glob.mem} /\ key{1} = to_uint key{2} /\ (key + 32 < W64.modulus /\ 0 <= i){1}).
  + wp;skip => /> &2 3?.
    have heq : to_uint (W64.of_int (4 * i{2})) = 4 * i{2}.
    + by rewrite to_uint_small /= /#.
    by rewrite Array8.get_setE //= to_uintD_small heq /= /#.
  wp;skip => />.
qed.

phoare copy_state_sref_spec st0 : [ChaCha20_sref.M.copy_state : st0 = st ==> st0 = res.`1.[15 <- res.`2]] = 1%r. 
proof.
  proc.
  conseq (_: Array16.all_eq st0 k.[15 <- s_k15]). 
  + by move=> ? -> /= ??; rewrite Array16.ext_eq_all.
  by unroll for ^while; wp; skip => />.
qed.

equiv line_spec i ki: ChaCha20_srefi.M.line ~ ChaCha20_sref.M.line : 
    (0 <= i < 16 /\ ={a,b,c,r} /\ k{1} = k{2}.[i <- ki] /\ (a <> i /\ b <> i /\ c <> i /\ 0 <=r < 256){1}) ==>
    res{1} = res{2}.[i <- ki].
proof.
  proc;wp;skip => /> &2 h0i hi ha hb hc h0r hr2_8.
  rewrite !(Array16.get_setE _ i) // ha hb /=.
  rewrite (Array16.set_set_if _ i) (eq_sym i) ha /=.
  rewrite (Array16.set_set_if _ i) (eq_sym i) hc /=.
  congr; congr.
  rewrite (Array16.set_set_if _ i) (eq_sym i) hc /=.
  rewrite x86_ROL_32_E /= !(Array16.get_setE _ i) // hc ha /= modz_small //.
qed.

equiv quarter_round_spec i ki: ChaCha20_srefi.M.quarter_round ~ ChaCha20_sref.M.quarter_round : 
    (0 <= i < 16 /\ ={a,b,c,d} /\ k{1} = k{2}.[i <- ki] /\ (a <> i /\ b <> i /\ c <> i /\ d<>i){1}) ==>
    res{1} = res{2}.[i <- ki].
proof.
  proc; do 4! call (line_spec i ki);skip => />.
qed.

equiv eq_rounds_srefi_sref : ChaCha20_srefi.M.rounds ~ ChaCha20_sref.M.rounds :
  k{1} = k{2}.[15 <- k15{2}] ==>
  res{1} = res{2}.`1.[15 <- res{2}.`2].
proof.
  proc => /=.
  while ( c{1} = to_uint c{2} /\ 0 <= c{1} /\ k{1} = k{2}.[15 <- k15{2}]);last by wp;skip.
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
  wp;skip => /> *; split => *; rewrite Array16.set_set_if /= Array16.set_notmod //=.
  rewrite ultE /=.
  have -> /= /#: to_uint (c{2} + W32.one) = to_uint c{2} + 1.
  by rewrite to_uintD_small //= /#.
qed.

equiv eq_sum_states_srefi_sref : ChaCha20_pref.M.sum_states ~ ChaCha20_sref.M.sum_states :
  ={st} /\ k{1} = k{2}.[15 <- k15{2}] ==>
  res{1} = res{2}.`1.[15 <- res{2}.`2].
proof.
  proc => /=.  
  unroll for{1} ^while; unroll for{2} ^while.
  conseq (_: all_eq k{1} k{2}.[15 <- k15{2}]).
  + by move=> &1 &2 _ k1 k2 k15 /Array16.all_eq_eq. 
  wp; skip => />.
qed.

equiv eq_store_srefi_sref : ChaCha20_srefi.M.store ~ ChaCha20_sref.M.store :
  ={Glob.mem} /\ output{1} = to_uint s_output{2} /\ plain{1} = to_uint s_plain{2} /\ len{1} = to_uint s_len{2} /\
  k{1} = k{2}.[15 <- k15{2}] /\
  (64 <= len /\ good_ptr output plain len){1} ==>
  ={Glob.mem} /\ (good_ptr res.`1 res.`2 res.`3){1} /\
  res{1} = (to_uint res{2}.`1, to_uint res{2}.`2, to_uint res{2}.`3).
proof.
  proc => /=.
  inline *;wp.
  splitwhile{1} ^while : (i < 12).
  while (={i, Glob.mem} /\ (forall j, i{1} <= j <= 15 => k{1}.[j] = k{2}.[j]) /\ 12 <= i{1} /\
          output{1} = to_uint output{2} /\ plain{1} = to_uint plain{2} /\ (64 <= len /\ good_ptr output plain len){1}).
  + wp; skip => /> &1 &2 hj hi hlen hgo hgp hi'.
    have heq : to_uint (W64.of_int (4 * i{2})) = 4* i{2} by rewrite W64.to_uint_small /= /#.
    have heq1 : to_uint (output{2} + W64.of_int (4 * i{2})) = to_uint output{2} + 4 * i{2}.
    + by rewrite W64.to_uintD_small heq // /#. 
    have heq2 : to_uint (plain{2} + W64.of_int (4 * i{2})) = to_uint plain{2} + 4 * i{2}.
    + by rewrite W64.to_uintD_small heq // /#. 
    smt(Array16.get_setE).
  wp.
  while{2} (0 <= i <= 3 /\ forall j, 0 <= j < i => k.[12 + j] = s_k.[j]){2} (3 - i{2}).
  + move=> _ z; wp; skip => />; smt(Array16.get_setE).
  wp.
  while (={Glob.mem, i} /\ 0 <= i{1} <= 12 /\ (forall j, i{1} <= j < 15 => k{1}.[j] = k{2}.[j]) /\
         output{1} = to_uint output{2} /\ plain{1} = to_uint plain{2} /\ (64 <= len /\ good_ptr output plain len){1}).
  + wp; skip => /> &1 &2 ? hj 4?. 
    have heq : to_uint (W64.of_int (4 * i{2})) = 4* i{2} by rewrite W64.to_uint_small /= /#.
    have heq1 : to_uint (output{2} + W64.of_int (4 * i{2})) = to_uint output{2} + 4 * i{2}.
    + by rewrite W64.to_uintD_small heq // /#. 
    have heq2 : to_uint (plain{2} + W64.of_int (4 * i{2})) = to_uint plain{2} + 4 * i{2}.
    + by rewrite W64.to_uintD_small heq // /#. 
    smt(Array16.get_setE).
  wp.
  while{2}(0 <= i <= 3 /\ forall j, 0 <= j < i => k.[12 + j] = s_k.[j]){2} (3 - i{2}).
  + move=> _ z; wp; skip => /> *; smt(Array3.get_setE).
  wp; skip => /> *.
  have heq1 : to_uint (s_output{2} + W64.of_int 64) = to_uint s_output{2} + 64.
  + by rewrite W64.to_uintD_small // /#. 
  have heq2 : to_uint (s_plain{2} + W64.of_int 64) = to_uint s_plain{2} + 64.
  + by rewrite W64.to_uintD_small // /#.
  have heq3 : to_uint (s_len{2} - W32.of_int 64) = to_uint s_len{2} - 64.
  + by rewrite W32.to_uintB // uleE. 
  rewrite heq1 heq2 heq3 /=; smt(Array16.get_setE).
qed.

equiv eq_store_last_srefi_sref : ChaCha20_srefi.M.store_last ~ ChaCha20_sref.M.store_last :
  ={Glob.mem} /\ output{1} = to_uint s_output{2} /\ plain{1} = to_uint s_plain{2} /\ len{1} = to_uint s_len{2} /\
  k{1} = k{2}.[15 <- k15{2}] /\
  (len < 64 /\ good_ptr output plain len){1} ==>
  ={Glob.mem}.
proof.
  proc => /=.
  while (={Glob.mem} /\ k{1} = s_k{2} /\ len{1} < 64 /\
         j{1} = to_uint j{2} /\ output{1} = to_uint output{2} /\ plain{1} = to_uint plain{2} /\ len{1} = to_uint len{2} /\
         (good_ptr output plain len){1}).
  + wp; skip => /> &2 ???; rewrite !ultE => ?. 
    rewrite !W2u32.to_uint_truncateu32.
    have heq1 : to_uint (output{2} +  j{2}) = to_uint output{2} + to_uint j{2}.
    + by rewrite W64.to_uintD_small // /#. 
    have heq2 : to_uint (plain{2} +  j{2}) = to_uint plain{2} + to_uint j{2}.
    + by rewrite W64.to_uintD_small // /#. 
    have heq3 : to_uint (j{2} + W64.one) = to_uint j{2} + 1.
    + rewrite W64.to_uintD_small //= /#.
    rewrite heq1 heq2 heq3 /= !modz_small; smt(W64.to_uint_cmp).
  wp.
  while{2} (0 <= i <= 15 /\ forall j, 0 <= j < i => s_k.[j] = k.[j]){2} (15-i{2}).
  + move=> ? z;wp; skip; smt(Array16.get_setE).    
  wp; skip => /> &2 ???.
  rewrite ultE /= W2u32.to_uint_truncateu32 /(%%) /=; split; 1: smt().
  move=> i1 ?; split;1 : smt().
  move=> ????.
  have ->> : i1 = 15 by smt().
  apply Array16.ext_eq=> j; rewrite !Array16.get_setE // /#.
qed.

equiv eq_increment_counter_srefi_sref: ChaCha20_srefi.M.increment_counter ~ ChaCha20_sref.M.increment_counter :
  ={st} ==> ={res}.
proof.
  by proc;auto => /> &2;rewrite W32.WRingA.addrC.
qed.

equiv eq_chacha20_srefi_sref : ChaCha20_srefi.M.chacha20_ref ~ ChaCha20_sref.M.chacha20_ref : 
  key{1} = to_uint key{2} /\ nonce{1} = to_uint nonce{2} /\  (key + 32 < W64.modulus /\ nonce + 12 < W64.modulus){1} /\
  output{1} = to_uint output{2} /\ plain{1} = to_uint plain{2} /\ len{1} = to_uint len{2} /\
  (good_ptr output plain len){1} /\
  ={Glob.mem, counter} 
  ==>
  ={Glob.mem}.
proof.
proc => /=.
sp; seq 1 1 : (#{/~(_ = witness)}pre /\ ={st}).
+ by call eq_init_srefi_sref;skip => />.
seq 1 1 : (={st, Glob.mem} /\ 
           output{1} = to_uint s_output{2} /\ plain{1} = to_uint s_plain{2} /\ len{1} = to_uint s_len{2} /\
           (good_ptr output plain len){1} /\
           len{1} < 64). 
+ while (#{/~ len{1} < _}post).
  + call eq_increment_counter_srefi_sref.
    call eq_store_srefi_sref.
    call eq_sum_states_srefi_sref.
    call eq_rounds_srefi_sref.
    by ecall{2} (copy_state_sref_spec st{2});skip => /> *; rewrite uleE.
  skip => /> *; rewrite uleE /= => ??; rewrite uleE => /#.
if=> //.
+ by move=> /> *;rewrite ultE.
call eq_store_last_srefi_sref.
call eq_sum_states_srefi_sref.
call eq_rounds_srefi_sref.
by ecall{2} (copy_state_sref_spec st{2});skip.
qed.


hoare chacha20_sref_spec mem0 output0 plain0 key0 len0 nonce0 counter0 : ChaCha20_sref.M.chacha20_ref :
  mem0 = Glob.mem /\ output0 = to_uint output /\ len0 = to_uint len /\
  plain0 = loads_8 Glob.mem (to_uint plain) (to_uint len) /\
  key0 = Array8.of_list W32.zero (loads_32 Glob.mem (to_uint key) 8) /\
  nonce0 = Array3.of_list W32.zero (loads_32 Glob.mem (to_uint nonce) 3) /\
  counter0 = counter /\
  inv_ptr (to_uint output) (to_uint plain) (to_uint len) /\
  to_uint key + 32 < W64.modulus /\ 
  to_uint nonce + 12 < W64.modulus /\
  to_uint output + to_uint len < W64.modulus /\ 
  to_uint plain + to_uint len < W64.modulus 
  ==> 
  (chacha20_CTR_encrypt_bytes key0 nonce0 counter0 plain0).`1 = 
     loads_8 Glob.mem output0 len0 /\
  mem_eq_except (in_range output0 len0) Glob.mem mem0.
proof.
  bypr.
  move=> &m [#] h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12. 
  have <-: 
   Pr[ChaCha20_srefi.M.chacha20_ref(output0, to_uint plain{m}, len0, to_uint key{m}, 
                                   to_uint nonce{m}, counter{m}) @ &m :
       !((chacha20_CTR_encrypt_bytes key0 nonce0 counter0 plain0).`1 =loads_8 Glob.mem output0 len0 /\
        mem_eq_on (predC (in_range output0 len0)) Glob.mem mem0)] =
   Pr[ChaCha20_sref.M.chacha20_ref(output{m}, plain{m}, len{m}, key{m}, nonce{m}, counter{m}) @ &m :
       !((chacha20_CTR_encrypt_bytes key0 nonce0 counter0 plain0).`1 = loads_8 Glob.mem output0 len0 /\
          mem_eq_on (predC (in_range output0 len0)) Glob.mem mem0)].
  + by byequiv eq_chacha20_srefi_sref => />; rewrite h2 h3.
  have <-: 
   Pr[ChaCha20_pref.M.chacha20_ref(output0, to_uint plain{m}, len0, to_uint key{m}, 
                                   to_uint nonce{m}, counter{m}) @ &m :
       !((chacha20_CTR_encrypt_bytes key0 nonce0 counter0 plain0).`1 =loads_8 Glob.mem output0 len0 /\
        mem_eq_on (predC (in_range output0 len0)) Glob.mem mem0)] =
   Pr[ChaCha20_srefi.M.chacha20_ref(output0, to_uint plain{m}, len0, to_uint key{m}, 
                                    to_uint nonce{m}, counter{m}) @ &m :
       !((chacha20_CTR_encrypt_bytes key0 nonce0 counter0 plain0).`1 = loads_8 Glob.mem output0 len0 /\
          mem_eq_on (predC (in_range output0 len0)) Glob.mem mem0)].
  + by byequiv eq_chacha20_pref_srefi => />; rewrite h2 h3.
  pose plain1 := to_uint plain{m}; 
  pose key1 := to_uint key{m};
  pose nonce1 := to_uint nonce{m}.
  byphoare (_: mem0 = Glob.mem /\
   0 <= len /\
   output = output0 /\ plain = plain1 /\ len = len0 /\ key = key1 /\ nonce = nonce1 /\
   inv_ptr output0 plain1 len0 /\
   plain0 = loads_8 mem0 plain1 len0 /\
   key0 = Array8.of_list W32.zero (loads_32 mem0 key1 8) /\
   nonce0 = Array3.of_list W32.zero (loads_32 mem0 nonce1 3) /\
   counter0 = counter 
   ==> 
   !((chacha20_CTR_encrypt_bytes key0 nonce0 counter0 plain0).`1 = loads_8 Glob.mem output0 len0 /\
     mem_eq_except (in_range output0 len0) Glob.mem mem0)) => //; last first.
  + move=> />; rewrite h1 h2 h3 h4 /plain1 /key1 /nonce1 h8 h5 h6 /=;
     case: (W32.to_uint_cmp len{m}) => -> //.
  hoare => //.
  conseq (chacha20_ref_spec mem0 output0 plain0 key0 nonce0 counter0) => //.
  move: h1 h2 h3 h4 h5 h6 h7; rewrite /plain1 /key1 /nonce1 => /> &hr 7? mem1.
  rewrite size_loads_8 max_ler => />; case: (W32.to_uint_cmp len{m}) => -> //.
qed.



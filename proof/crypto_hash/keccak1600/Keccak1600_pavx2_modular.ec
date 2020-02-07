require import AllCore List Int IntExtra IntDiv CoreMap.
from Jasmin require import JModel.

require import Array7 Array9 Array25 Array28.
require import WArray224 WArray288.
require import Keccakf1600_pavx2_prevec.
require import Keccakf1600_savx2.
require import Keccakf1600_savx2_proof.

abbrev g_zero = W64.of_int 0.

module Mmod = {
  include Keccakf1600_savx2.M
  
  proc keccak_init () : W256.t Array7.t = {
    var aux: int;
    
    var state:W256.t Array7.t;
    var i:int;
    state <- witness;
    state.[0] <- VPBROADCAST_4u64 g_zero;
    i <- 1;
    while (i < 7) {
      state.[i] <- state.[0];
      i <- i + 1;
    }
    return (state);
  }
  
  proc init_s_state () : W64.t Array28.t = {
    var aux: int;
    
    var s_state:W64.t Array28.t;
    var zero:W256.t;
    var i:int;
    s_state <- witness;
    zero <- VPBROADCAST_4u64 g_zero;
    i <- 0;
    while (i < 7) {
      s_state =
      Array28.init
      (WArray224.get64 (WArray224.set256 (WArray224.init64 (fun i => s_state.[i])) i zero));
      i <- i + 1;
    }
    return (s_state);
  }
  
  proc add_full_block (state:W256.t Array7.t, s_state:W64.t Array28.t,
                       a_jagged:W64.t, in_0:W64.t, inlen:W64.t, rate:W64.t) : 
  W256.t Array7.t * W64.t Array28.t * W64.t * W64.t = {
    var aux: int;
    
    var rate8:W64.t;
    var j:W64.t;
    var t:W64.t;
    var l:W64.t;
    var i:int;
    
    rate8 <- rate;
    rate8 <- (rate8 `>>` (W8.of_int 3));
    j <- (W64.of_int 0);
    
    while ((j \ult rate8)) {
      t <- (loadW64 Glob.mem (W64.to_uint (in_0 + ((W64.of_int 8) * j))));
      l <-
      (loadW64 Glob.mem (W64.to_uint (a_jagged + ((W64.of_int 8) * j))));
      s_state.[(W64.to_uint l)] <- t;
      j <- (j + (W64.of_int 1));
    }
    t <- s_state.[0];
    s_state.[1] <- t;
    s_state.[2] <- t;
    s_state.[3] <- t;
    i <- 0;
    while (i < 7) {
      state.[i] <-
      (state.[i] `^` (get256 (WArray224.init64 (fun i => s_state.[i])) i));
      i <- i + 1;
    }
    in_0 <- (in_0 + rate);
    inlen <- (inlen - rate);
    return (state, s_state, in_0, inlen);
  }
  
  proc add_final_block (state:W256.t Array7.t, s_state:W64.t Array28.t,
                        a_jagged:W64.t, in_0:W64.t, inlen:W64.t,
                        trail_byte:W8.t, rate:W64.t) : W256.t Array7.t = {
    var aux: int;
    
    var inlen8:W64.t;
    var j:W64.t;
    var t:W64.t;
    var l:W64.t;
    var c:W8.t;
    var i:int;
    
    s_state <@ init_s_state ();
    inlen8 <- inlen;
    inlen8 <- (inlen8 `>>` (W8.of_int 3));
    j <- (W64.of_int 0);
    
    while ((j \ult inlen8)) {
      t <- (loadW64 Glob.mem (W64.to_uint (in_0 + ((W64.of_int 8) * j))));
      l <-
      (loadW64 Glob.mem (W64.to_uint (a_jagged + ((W64.of_int 8) * j))));
      s_state.[(W64.to_uint l)] <- t;
      j <- (j + (W64.of_int 1));
    }
    l <- (loadW64 Glob.mem (W64.to_uint (a_jagged + ((W64.of_int 8) * j))));
    l <- (l `<<` (W8.of_int 3));
    j <- (j `<<` (W8.of_int 3));
    
    while ((j \ult inlen)) {
      c <- (loadW8 Glob.mem (W64.to_uint (in_0 + j)));
      s_state =
      Array28.init
      (WArray224.get64 (WArray224.set8 (WArray224.init64 (fun i => s_state.[i])) (W64.to_uint l) c));
      j <- (j + (W64.of_int 1));
      l <- (l + (W64.of_int 1));
    }
    s_state =
    Array28.init
    (WArray224.get64 (WArray224.set8 (WArray224.init64 (fun i => s_state.[i])) (W64.to_uint l) trail_byte));
    j <- rate;
    j <- (j - (W64.of_int 1));
    j <- (j `>>` (W8.of_int 3));
    l <- (loadW64 Glob.mem (W64.to_uint (a_jagged + ((W64.of_int 8) * j))));
    l <- (l `<<` (W8.of_int 3));
    j <- rate;
    j <- (j - (W64.of_int 1));
    j <- (j `&` (W64.of_int 7));
    l <- (l + j);
    s_state =
    Array28.init
    (WArray224.get64 (WArray224.set8 (WArray224.init64 (fun i => s_state.[i])) (W64.to_uint l) (
    (get8 (WArray224.init64 (fun i => s_state.[i])) (W64.to_uint l)) `^` (W8.of_int 128))));
    t <- s_state.[0];
    s_state.[1] <- t;
    s_state.[2] <- t;
    s_state.[3] <- t;
    i <- 0;
    while (i < 7) {
      state.[i] <-
      (state.[i] `^` (get256 (WArray224.init64 (fun i => s_state.[i])) i));
      i <- i + 1;
    }
    return (state);
  }
  
  proc xtr_full_block (state:W256.t Array7.t, a_jagged:W64.t, out:W64.t,
                       len:W64.t) : W64.t = {
    var aux: int;
    
    var i:int;
    var s_state:W64.t Array28.t;
    var len8:W64.t;
    var j:W64.t;
    var l:W64.t;
    var t:W64.t;
    s_state <- witness;
    i <- 0;
    while (i < 7) {
      s_state =
      Array28.init
      (WArray224.get64 (WArray224.set256 (WArray224.init64 (fun i => s_state.[i])) i 
      state.[i]));
      i <- i + 1;
    }
    len8 <- len;
    len8 <- (len8 `>>` (W8.of_int 3));
    j <- (W64.of_int 0);
    
    while ((j \ult len8)) {
      l <-
      (loadW64 Glob.mem (W64.to_uint (a_jagged + ((W64.of_int 8) * j))));
      t <- s_state.[(W64.to_uint l)];
      Glob.mem <-
      storeW64 Glob.mem (W64.to_uint (out + ((W64.of_int 8) * j))) t;
      j <- (j + (W64.of_int 1));
    }
    out <- (out + len);
    return (out);
  }
  
  proc xtr_bytes (state:W256.t Array7.t, a_jagged:W64.t, out:W64.t, len:W64.t) : 
  W64.t = {
    var aux: int;
    
    var i:int;
    var s_state:W64.t Array28.t;
    var len8:W64.t;
    var j:W64.t;
    var l:W64.t;
    var t:W64.t;
    var c:W8.t;
    s_state <- witness;
    i <- 0;
    while (i < 7) {
      s_state =
      Array28.init
      (WArray224.get64 (WArray224.set256 (WArray224.init64 (fun i => s_state.[i])) i 
      state.[i]));
      i <- i + 1;
    }
    len8 <- len;
    len8 <- (len8 `>>` (W8.of_int 3));
    j <- (W64.of_int 0);
    
    while ((j \ult len8)) {
      l <-
      (loadW64 Glob.mem (W64.to_uint (a_jagged + ((W64.of_int 8) * j))));
      t <- s_state.[(W64.to_uint l)];
      Glob.mem <-
      storeW64 Glob.mem (W64.to_uint (out + ((W64.of_int 8) * j))) t;
      j <- (j + (W64.of_int 1));
    }
    l <- (loadW64 Glob.mem (W64.to_uint (a_jagged + ((W64.of_int 8) * j))));
    j <- (j `<<` (W8.of_int 3));
    l <- (l `<<` (W8.of_int 3));
    
    while ((j \ult len)) {
      c <- (get8 (WArray224.init64 (fun i => s_state.[i])) (W64.to_uint l));
      Glob.mem <- storeW8 Glob.mem (W64.to_uint (out + j)) c;
      j <- (j + (W64.of_int 1));
      l <- (l + (W64.of_int 1));
    }
    out <- (out + len);
    return (out);
  }
  
  proc absorb (state:W256.t Array7.t, rhotates_left:W64.t,
               rhotates_right:W64.t, iotas:W64.t, a_jagged:W64.t, in_0:W64.t,
               inlen:W64.t, trail_byte:W8.t, rate:W64.t) : W256.t Array7.t = {
    
    var s_state:W64.t Array28.t;
    s_state <- witness;
    s_state <@ init_s_state ();
    
    while ((rate \ule inlen)) {
      (state, s_state, in_0, inlen) <@ add_full_block (state, s_state,
      a_jagged, in_0, inlen, rate);
      state <@ __keccakf1600_avx2 (state, rhotates_left, rhotates_right,
      iotas);
    }
    state <@ add_final_block (state, s_state, a_jagged, in_0, inlen,
    trail_byte, rate);
    return (state);
  }
  
  proc squeeze (state:W256.t Array7.t, rhotates_left:W64.t,
                rhotates_right:W64.t, iotas:W64.t, a_jagged:W64.t, out:W64.t,
                outlen:W64.t, rate:W64.t) : unit = {
    
    
    
    
    while ((rate \ult outlen)) {
      state <@ __keccakf1600_avx2 (state, rhotates_left, rhotates_right,
      iotas);
      out <@ xtr_full_block (state, a_jagged, out, rate);
      outlen <- (outlen - rate);
    }
    state <@ __keccakf1600_avx2 (state, rhotates_left, rhotates_right,
    iotas);
    out <@ xtr_bytes (state, a_jagged, out, outlen);
    return ();
  }
  
  proc __keccak1600_avx2 (out:W64.t, outlen:W64.t, rhotates_left:W64.t,
                      rhotates_right:W64.t, iotas:W64.t, a_jagged:W64.t,
                      in_0:W64.t, inlen:W64.t, trail_byte:W8.t, rate:W64.t) : unit = {
    
    var state:W256.t Array7.t;
    state <- witness;
    state <@ keccak_init ();
    state <@ absorb (state, rhotates_left, rhotates_right, iotas, a_jagged,
    in_0, inlen, trail_byte, rate);
    squeeze (state, rhotates_left, rhotates_right, iotas, a_jagged, out,
    outlen, rate);
    return ();
  }
}.

require import Keccak1600_savx2.

equiv modfgood :
  Mmod.__keccakf1600_avx2 ~ M.__keccakf1600_avx2:
   ={Glob.mem,arg} ==> ={Glob.mem,res}. 
proof. by sim. qed.

equiv modgood :
  Mmod.__keccak1600_avx2 ~ M.__keccak1600_avx2 :
   ={Glob.mem,arg} ==> ={Glob.mem,res}.
proof. by sim. qed.

require Keccak1600_pref_modular.

lemma set_get_def (v : W64.t Array28.t) (w : W256.t) i j :
  0 <= i < 7 => 0 <= j < 28 => 
  WArray224.get64
     (WArray224.set256 (WArray224.init64 ("_.[_]" v)) i w) j = 
    if 4 * i <= j < 4 * i + 4 then w \bits64 (j %% 4)
    else v.[j].
proof.
  move=> hx hs; rewrite set256E !get64E.
  rewrite -(W8u8.unpack8K (if 4 * i <= j < 4 * i + 4 then w \bits64 j %% 4 else v.[j]));congr.
  apply W8u8.Pack.ext_eq => k hk.
  rewrite W8u8.get_unpack8 //= W8u8.Pack.initiE //= initiE 1:/# /=.
  have -> : (32 * i <= 8 * j + k < 32 * (i + 1)) = (4 * i <= j < 4 * i + 4) by smt().
  case : (4 * i <= j < 4 * i + 4) => h.
  + by rewrite W256_bits64_bits8 1:// /#.
  by rewrite /init64 initiE /#.
qed.

lemma set_get_eq (v : W64.t Array28.t) (w : W256.t) i j :
  0 <= i < 7 => 0 <= j < 28 => 4 * i <= j < 4 * i + 4 =>
  WArray224.get64
     (WArray224.set256 (WArray224.init64 ("_.[_]" v)) i w) j = w \bits64 (j %% 4).
proof. by move=> h1 h2 h3; rewrite set_get_def // h3. qed.

lemma set_get_diff (v : W64.t Array28.t) (w : W256.t) i j :
   0 <= i < 7 => 0 <= j < 28 => !(4 * i <= j < 4 * i + 4 ) =>
  WArray224.get64
     (WArray224.set256 (WArray224.init64 ("_.[_]" v)) i w) j = v.[j].
proof. by move=> h1 h2 h3; rewrite set_get_def // h3. qed.

(* my @A_jagged = ([0,0], [1,0], [1,1], [1,2], [1,3],	# [0][0..4]
		[2,2], [6,0], [3,1], [4,2], [5,3],	# [1][0..4]
		[2,0], [4,0], [6,1], [5,2], [3,3],	# [2][0..4]
		[2,3], [3,0], [5,1], [6,2], [4,3],	# [3][0..4]
		[2,1], [5,0], [4,1], [3,2], [6,3]);	# [4][0..4]
   @A_jagged = map(8*($$_[0]*4+$$_[1]), @A_jagged);	# ... and now linear *)

op A_jagged = (witness
       .[0 <- 0    %/ 8]    
       .[1 <- 32   %/ 8]  
       .[2 <- 40   %/ 8]  
       .[3 <- 48   %/ 8]  
       .[4 <- 56   %/ 8]  
       .[5 <- 80   %/ 8]  
       .[6 <- 192  %/ 8]  
       .[7 <- 104  %/ 8]  
       .[8 <- 144  %/ 8]  
       .[9 <- 184  %/ 8]  
       .[10 <- 64  %/ 8] 
       .[11 <- 128 %/ 8] 
       .[12 <- 200 %/ 8] 
       .[13 <- 176 %/ 8] 
       .[14 <- 120 %/ 8] 
       .[15 <- 88  %/ 8] 
       .[16 <- 96  %/ 8] 
       .[17 <- 168 %/ 8] 
       .[18 <- 208 %/ 8] 
       .[19 <- 152 %/ 8] 
       .[20 <- 72  %/ 8] 
       .[21 <- 160 %/ 8] 
       .[22 <- 136 %/ 8] 
       .[23 <- 112 %/ 8] 
       .[24 <- 216 %/ 8]   
       )%Array25.

op good_jag (mem : global_mem_t, _jag : int) =
    forall off, 0 <= off < 25 => 
      loadW64 mem (_jag + (8 * off)) = W64.of_int A_jagged.[off].

lemma jagged_bound k :  0 <= k < 25 => 0 <= A_jagged.[k] < 28.
proof.
  by move: k; apply (Array25.allP A_jagged (fun i => 0 <= i < 28)); cbv delta.
qed.

lemma to_uintK_jagged k : 0 <= k < 25 => to_uint (W64.of_int A_jagged.[k]) = A_jagged.[k].
proof.
  move=> hk; rewrite to_uint_small //; smt (jagged_bound).
qed.

op A_jagged_inv = 
   (witness  
       .[A_jagged.[0 ] <- 0 ]    
       .[A_jagged.[1 ] <- 1 ]  
       .[A_jagged.[2 ] <- 2 ]  
       .[A_jagged.[3 ] <- 3 ]  
       .[A_jagged.[4 ] <- 4 ]  
       .[A_jagged.[5 ] <- 5 ]  
       .[A_jagged.[6 ] <- 6 ]  
       .[A_jagged.[7 ] <- 7 ]  
       .[A_jagged.[8 ] <- 8 ]  
       .[A_jagged.[9 ] <- 9 ]  
       .[A_jagged.[10] <- 10] 
       .[A_jagged.[11] <- 11] 
       .[A_jagged.[12] <- 12] 
       .[A_jagged.[13] <- 13] 
       .[A_jagged.[14] <- 14] 
       .[A_jagged.[15] <- 15] 
       .[A_jagged.[16] <- 16] 
       .[A_jagged.[17] <- 17] 
       .[A_jagged.[18] <- 18] 
       .[A_jagged.[19] <- 19] 
       .[A_jagged.[20] <- 20] 
       .[A_jagged.[21] <- 21] 
       .[A_jagged.[22] <- 22] 
       .[A_jagged.[23] <- 23] 
       .[A_jagged.[24] <- 24])%Array28.

lemma jagged_inj i j : 0 <= i < 25 => 0 <= j < 25 => A_jagged.[i] = A_jagged.[j] => i = j.
proof.
  have : forall k, 0 <= k < 25 => k = A_jagged_inv.[A_jagged.[k]].
  + move=> k; have <- := mema_iota 0 25 k; move: k.
    by rewrite -(List.allP (fun k => k = A_jagged_inv.[A_jagged.[k]])); cbv delta.
  by move=> hk hi hj heq;rewrite (hk i) // (hk j) // heq.
qed.

lemma jagged_diff off: 0 <= off < 25 => ! A_jagged.[off] \in [1;2;3].
proof.
  by move: off; apply (Array25.allP A_jagged (fun i => ! i \in [1;2;3])); cbv delta.
qed.

lemma get256_64 (t : WArray224.t) i : 0 <= i < 7 => get256 t i = 
   W4u64.pack4 [ get64 t (4*i); get64 t (4*i+1); get64 t (4*i+2); get64 t (4*i+3)].
proof.
  move=> hi.
  apply W4u64.wordP => k hk.
  have -> : pack4 [get64 t (4 * i); get64 t (4 * i + 1); get64 t (4 * i + 2); get64 t (4 * i + 3)] =
             W4u64.pack4_t (W4u64.Pack.init (fun k => get64 t (4 * i + k))).
  + apply W4u64.wordP => *; rewrite !pack4bE // of_listE !initiE //= /#.
  rewrite WArray224.get256E bits64_W32u8 hk /= pack4bE // initiE //=.
  do 8! rewrite initiE 1:/# /=.
  rewrite  WArray224.get64E; apply W8u8.wordP => j hj.
  rewrite of_listE !W8u8.pack8bE // !initiE //= /#.
qed.

lemma get64_init64 (t:W64.t Array28.t) k : 0 <= k < 28 => get64 (WArray224.init64 ("_.[_]" t)) k = t.[k].
proof.
  move=> hk.
  rewrite /init64 WArray224.get64E; apply W8u8.wordP => i hi.
  rewrite W8u8.pack8bE // initiE //= initiE 1:/# /= /#.
qed.

op jagged_zeros_W64_p (sts : W64.t Array28.t, P: int -> bool)  =
    forall off, 0 <= off < 25 => 
      P off => sts.[A_jagged.[off]] =  W64.zero.

op jagged_zeros_W64 (sts : W64.t Array28.t, rate : int)  = jagged_zeros_W64_p sts (fun off => rate <= off < 25).

lemma state_xor_jagged (state0 state1:W64.t Array25.t) s_state2 P :
   jagged_zeros_W64_p s_state2 P =>
   (forall (k : int),
      0 <= k < 25 =>
      state1.[k] = if !P k then state0.[k] `^` s_state2.[A_jagged.[k]] else state0.[k]) => 
pack4 [state0.[0]; state0.[0]; state0.[0]; state0.[0]] `^`
get256 ((init64 ("_.[_]" s_state2.[1 <- s_state2.[0]].[2 <- s_state2.[0]].[3 <- s_state2.[0]])))%WArray224 0 =
pack4 [state1.[0]; state1.[0]; state1.[0]; state1.[0]] /\
pack4 [state0.[1]; state0.[2]; state0.[3]; state0.[4]] `^`
get256 ((init64 ("_.[_]" s_state2.[1 <- s_state2.[0]].[2 <- s_state2.[0]].[3 <- s_state2.[0]])))%WArray224 1 =
pack4 [state1.[1]; state1.[2]; state1.[3]; state1.[4]] /\
pack4 [state0.[10]; state0.[20]; state0.[5]; state0.[15]] `^`
get256 ((init64 ("_.[_]" s_state2.[1 <- s_state2.[0]].[2 <- s_state2.[0]].[3 <- s_state2.[0]])))%WArray224 2 =
pack4 [state1.[10]; state1.[20]; state1.[5]; state1.[15]] /\
pack4 [state0.[16]; state0.[7]; state0.[23]; state0.[14]] `^`
get256 ((init64 ("_.[_]" s_state2.[1 <- s_state2.[0]].[2 <- s_state2.[0]].[3 <- s_state2.[0]])))%WArray224 3 =
pack4 [state1.[16]; state1.[7]; state1.[23]; state1.[14]] /\
pack4 [state0.[11]; state0.[22]; state0.[8]; state0.[19]] `^`
get256 ((init64 ("_.[_]" s_state2.[1 <- s_state2.[0]].[2 <- s_state2.[0]].[3 <- s_state2.[0]])))%WArray224 4 =
pack4 [state1.[11]; state1.[22]; state1.[8]; state1.[19]] /\
pack4 [state0.[21]; state0.[17]; state0.[13]; state0.[9]] `^`
get256 ((init64 ("_.[_]" s_state2.[1 <- s_state2.[0]].[2 <- s_state2.[0]].[3 <- s_state2.[0]])))%WArray224 5 =
pack4 [state1.[21]; state1.[17]; state1.[13]; state1.[9]] /\
pack4 [state0.[6]; state0.[12]; state0.[18]; state0.[24]] `^`
get256 ((init64 ("_.[_]" s_state2.[1 <- s_state2.[0]].[2 <- s_state2.[0]].[3 <- s_state2.[0]])))%WArray224 6 =
pack4 [state1.[6]; state1.[12]; state1.[18]; state1.[24]].
proof.
  move=> H2 H4.
  rewrite !get256_64 // !get64_init64 //=. 
  rewrite /rev /=.
  have -> /= : state0.[0] `^` s_state2.[0] = state1.[0].
  + rewrite H4 //; case: (!P 0) => h /=.
    + by rewrite /A_jagged.
    by have := H2 0; rewrite /A_jagged /= => ->.
  split.
  + do !congr; rewrite H4 //.
    + case: (!P 1) => h; first by rewrite /A_jagged.
    by have := H2 1; rewrite /A_jagged /= => ->.
    + case: (!P 2) => h; first by rewrite /A_jagged.
    by have := H2 2; rewrite /A_jagged /= => ->.
    + case: (!P 3) => h; first by rewrite /A_jagged.
    by have := H2 3; rewrite /A_jagged /= => ->.
    case: (!P 4) => h; first by rewrite /A_jagged.
    by have := H2 4; rewrite /A_jagged /= => ->.
  split. 
  + do !congr; rewrite H4 //.
    + case: (!P 10) => h; first by rewrite /A_jagged.
    by have := H2 10; rewrite /A_jagged /= => ->.
    + case: (!P 20) => h; first by rewrite /A_jagged.
    by have := H2 20; rewrite /A_jagged /= => ->.
    + case: (!P 5) => h; first by rewrite /A_jagged.
    by have := H2 5; rewrite /A_jagged /= => ->.
    case: (!P 15) => h; first by rewrite /A_jagged.
    by have := H2 15; rewrite /A_jagged /= => ->.
  split. 
  + do !congr; rewrite H4 //.
    + case: (!P 16) => h; first by rewrite /A_jagged.
    by have := H2 16; rewrite /A_jagged /= => ->.
    + case: (!P 7) => h; first by rewrite /A_jagged.
    by have := H2 7; rewrite /A_jagged /= => ->.
    + case: (!P 23) => h; first by rewrite /A_jagged.
    by have := H2 23; rewrite /A_jagged /= => ->.
    case: (!P 14) => h; first by rewrite /A_jagged.
    by have := H2 14; rewrite /A_jagged /= => ->.
  split. 
  + do !congr; rewrite H4 //.
    + case: (!P 11) => h; first by rewrite /A_jagged.
    by have := H2 11; rewrite /A_jagged /= => ->.
    + case: (!P 22) => h; first by rewrite /A_jagged.
    by have := H2 22; rewrite /A_jagged /= => ->.
    + case: (!P 8) => h; first by rewrite /A_jagged.
    by have := H2 8; rewrite /A_jagged /= => ->.
    case: (!P 19) => h; first by rewrite /A_jagged.
    by have := H2 19; rewrite /A_jagged /= => ->.
  split.
  + do !congr; rewrite H4 //.
    + case: (!P 21) => h; first by rewrite /A_jagged.
    by have := H2 21; rewrite /A_jagged /= => ->.
    + case: (!P 17) => h; first by rewrite /A_jagged.
    by have := H2 17; rewrite /A_jagged /= => ->.
    + case: (!P 13) => h; first by rewrite /A_jagged.
    by have := H2 13; rewrite /A_jagged /= => ->.
    case: (!P 9) => h; first by rewrite /A_jagged.
    by have := H2 9; rewrite /A_jagged /= => ->.
  do !congr; rewrite H4 //.
  + case: (!P 6) => h; first by rewrite /A_jagged.
  by have := H2 6; rewrite /A_jagged /= => ->.
  + case: (!P 12) => h; first by rewrite /A_jagged.
  by have := H2 12; rewrite /A_jagged /= => ->.
  + case: (!P 18) => h; first by rewrite /A_jagged.
  by have := H2 18; rewrite /A_jagged /= => ->.
  case: (!P 24) => h; first by rewrite /A_jagged.
  by have := H2 24; rewrite /A_jagged /= => ->.
qed.

(* probably should be Jasmin semantics lemmas *)
lemma aux (v : W64.t): pack8_t ((init (fun (j : int) => v \bits8 j)))%W8u8.Pack = v  
          by move => *; rewrite (_: v = pack8_t (unpack8 v));  [apply W8u8.unpack8K | congr].

equiv add_full_block_corr rr :
  Keccak1600_pref_modular.Mmod.add_full_block ~  Mmod.add_full_block :
    to_uint rate{2} < 200 /\ to_uint a_jagged{2} + 200 < W64.modulus /\ to_uint in_0{2} + to_uint inlen{2} < W64.modulus /\
    jagged_zeros_W64 s_state{2} (to_uint rate{2} %/ 8)  /\ to_uint rate{2} = rr /\ 
    good_jag Glob.mem{2} (to_uint a_jagged{2}) /\ to_uint rate{2} <= to_uint inlen{2} /\
    ={Glob.mem} /\ em_states state{2} state{1} /\ ={in_0,inlen,rate} 
    ==> 
    jagged_zeros_W64 res{2}.`2 (rr %/ 8) /\ 
    em_states res{2}.`1 res{1}.`1  /\ 
    res{1}.`2 = res{2}.`3 /\ res{1}.`3 = res{2}.`4 /\
    to_uint res{2}.`3 + to_uint res{2}.`4 < W64.modulus.
proof.
  proc => /=.
  exlim state{1} => state0.
  seq 4 4 :
   ( to_uint rate{2} < 200 /\ to_uint a_jagged{2} + 200 < W64.modulus /\ to_uint in_0{2} + to_uint inlen{2} < W64.modulus /\
     jagged_zeros_W64 s_state{2} (to_uint rate{2} %/ 8) /\
     to_uint rate{2} = rr /\
     good_jag Glob.mem{2} (to_uint a_jagged{2}) /\ to_uint rate{2} <= to_uint inlen{2} /\
     (em_states state{2} state0) /\ ={Glob.mem, in_0, inlen, rate} /\ 
     forall k, 0 <= k < 25 =>
       state{1}.[k] = if k < to_uint rate{2} %/ 8 then state0.[k] `^` s_state{2}.[A_jagged.[k]]
                      else state0.[k]).
  + while (
     to_uint rate{2} < 200 /\ to_uint a_jagged{2} + 200 < W64.modulus /\ to_uint in_0{2} + to_uint inlen{2} < W64.modulus /\
     jagged_zeros_W64 s_state{2} (to_uint rate{2} %/ 8) /\
     to_uint rate{2} = rr /\
     good_jag Glob.mem{2} (to_uint a_jagged{2}) /\ to_uint rate{2} <= to_uint inlen{2} /\
     (em_states state{2} state0) /\ ={Glob.mem, in_0, inlen, rate} /\ i{1} = j{2} /\
     rate64{1} = rate8{2} /\ to_uint rate8{2} = to_uint rate{2} %/ 8 /\ to_uint i{1} <= to_uint rate8{2} /\
     forall k, 0 <= k < 25 =>
       state{1}.[k] = if k < to_uint j{2} then state0.[k] `^` s_state{2}.[A_jagged.[k]]
                      else state0.[k]).
    + wp; skip => /> &1 &2 hr200 hj200 hin0 hj0 hgj hle hem; rewrite !W64.ultE => hr8 hjr8 hs hjr. 
      have heq : to_uint (W64.of_int 8 * j{2}) = 8 * to_uint j{2}.
      + by rewrite W64.to_uintM_small //= /#.
      rewrite to_uintD_small heq /= 1:/#.       
      rewrite to_uintD_small heq /= 1:/#.       
      rewrite to_uintD_small /=; 1: smt(W64.to_uint_cmp).
      have ? : 0 <= to_uint j{2} < 25 by smt (W64.to_uint_cmp).
      split.
      + move=> k hk1 hk2.
        rewrite hgj 1:// to_uintK_jagged 1:// Array28.set_neqiE 1:jagged_bound 1://; smt (jagged_inj).
      split; 1: smt().
      move=> k hk1 hk2; rewrite hgj 1:// to_uintK_jagged 1://.
      rewrite hs 1:// /=.
      case (k < to_uint j{2} + 1) => hh.
      + case (k = to_uint j{2}) => [->> | hne].
        + by rewrite Array25.set_eqiE 1,2:// Array28.set_eqiE 1:jagged_bound.
        rewrite Array25.set_neqiE 1,2:// Array28.set_neqiE 1:jagged_bound //; smt (jagged_inj).
      rewrite Array25.set_neqiE 1:// 1:/# hs 1:// /#.
    wp; skip => |> &1 &2 *; split.
    + by rewrite /(`>>`) /= to_uint_shr //=; smt (W64.to_uint_cmp). 
    by move=> state_ j_ s_state_; rewrite !W64.ultE => /#.
  unroll for{2} ^while; wp; skip => |> &1 &2.
  rewrite /em_states => /> /= *; split.
  + rewrite /jagged_zeros_W64 => off h1 h2. 
    by rewrite !Array28.set_neqiE //; 1..3: smt (jagged_diff); rewrite H2.
  split.
  + apply Array7.all_eq_eq; rewrite /Array7.all_eq /index /=.
    apply (state_xor_jagged _ _ _ (fun (off : int) => to_uint rate{2} %/ 8 <= off < 25)) => //= /#.
  rewrite W64.to_uintD_small 1:/#. 
  rewrite W64.to_uintB 1:W64.uleE // /#.
qed.

phoare init_s_stateP : [Mmod.init_s_state : true ==> forall ofs, 0 <= ofs < 28 => res.[ofs] = W64.of_int 0] = 1%r.
proof.
  proc => /=.
  unroll for ^while; wp; skip => /> ofs h1 h2.
  do 7!(rewrite Array28.initiE 1:// set_get_def 1,2://).
  rewrite /VPBROADCAST_4u64 /= pack4bE 1:/# /= W4u64.Pack.get_of_list 1:/# /= /#.
qed.

lemma get64_set8 (t: W64.t Array28.t) i k w : 
   0 <= i < 224 => 0 <= k < 28 =>
   get64 (set8 (init64 ("_.[_]" t))%WArray224 i w) k = 
   if 8 * k <= i < 8 * k + 8 then 
      W8u8.pack8_t (W8u8.Pack.init (fun j => if j = i%%8 then w else t.[k] \bits8 j))
   else t.[k].
proof.
  move=> hi hk; apply W8u8.wordP => j hj.
  rewrite get64E W8u8.pack8bE 1:// initiE 1:// /= /set8.
  case: (8 * k <= i < 8 * k + 8) => h.
  + rewrite W8u8.pack8bE 1:// initiE 1:// /= /init64. 
    rewrite WArray224.get_setE 1://.
    case: (8 * k + j = i) => [<<- /#| hne].
    rewrite initiE 1:/# /=; smt().
  rewrite set_neqiE 1:// 1:/# /init64 initiE /= /#. 
qed.

lemma get64_set8_200 (t: W64.t Array25.t) i k w : 
   0 <= i < 200 => 0 <= k < 25 =>
   WArray200.WArray200.get64 (WArray200.WArray200.set8 (WArray200.WArray200.init64 ("_.[_]" t)) i w) k = 
   if 8 * k <= i < 8 * k + 8 then 
      W8u8.pack8_t (W8u8.Pack.init (fun j => if j = i%%8 then w else t.[k] \bits8 j))
   else t.[k].
proof.
  move=> hi hk; apply W8u8.wordP => j hj.
  rewrite WArray200.WArray200.get64E W8u8.pack8bE 1:// initiE 1:// /= /set8.
  case: (8 * k <= i < 8 * k + 8) => h.
  + rewrite W8u8.pack8bE 1:// initiE 1:// /= /init64. 
    rewrite WArray200.WArray200.get_setE 1://.
    case: (8 * k + j = i) => [<<- /#| hne].
    rewrite WArray200.WArray200.initiE 1:/# /=; smt().
  rewrite WArray200.WArray200.set_neqiE 1:// 1:/# /init64 WArray200.WArray200.initiE /= /#. 
qed.

equiv add_final_block_corr :
  Keccak1600_pref_modular.Mmod.add_final_block ~  Mmod.add_final_block :
   to_uint rate{2} < 200 /\ 
   to_uint a_jagged{2} + 200 < W64.modulus /\ 
   to_uint in_0{2} + to_uint inlen{2} < W64.modulus /\ 
   good_jag Glob.mem{2} (to_uint a_jagged{2}) /\
   ={Glob.mem, trail_byte} /\ em_states state{2} state{1} /\ ={in_0,inlen} /\ to_uint inlen{2} < to_uint rate{2} /\ r8{1} = rate{2} 
   ==> 
   em_states res{2} res{1}.
proof.
  proc => /=.
  exlim state{1} => state0.
  seq 4 5 :
   ( to_uint rate{2} < 200 /\ to_uint a_jagged{2} + 200 < W64.modulus /\ to_uint in_0{2} + to_uint inlen{2} < W64.modulus /\
     jagged_zeros_W64 s_state{2} (to_uint inlen{2} %/8) /\
     good_jag Glob.mem{2} (to_uint a_jagged{2}) /\
     (em_states state{2} state0) /\ ={Glob.mem, trail_byte, in_0, inlen} /\ to_uint inlen{2} < to_uint rate{2} /\ r8{1} = rate{2} /\
     i{1} = j{2} /\ to_uint j{2} = to_uint inlen{2} %/ 8 /\
     forall k, 0 <= k < 25 =>
       state{1}.[k] = if k < to_uint inlen{2} %/ 8 then state0.[k] `^` s_state{2}.[A_jagged.[k]]
                      else state0.[k]).
  + while (
     to_uint rate{2} < 200 /\ to_uint a_jagged{2} + 200 < W64.modulus /\ to_uint in_0{2} + to_uint inlen{2} < W64.modulus /\
     jagged_zeros_W64 s_state{2} (to_uint inlen{2} %/8) /\
     good_jag Glob.mem{2} (to_uint a_jagged{2}) /\
     (em_states state{2} state0) /\ ={Glob.mem, trail_byte, in_0, inlen, inlen8} /\ i{1} = j{2} /\ to_uint inlen{2} < to_uint rate{2} /\ r8{1} = rate{2} /\
     to_uint inlen8{2} = to_uint inlen{2} %/ 8 /\ to_uint i{1} <= to_uint inlen8{2} /\
     forall k, 0 <= k < 25 =>
       state{1}.[k] = if k < to_uint j{2} then state0.[k] `^` s_state{2}.[A_jagged.[k]]
                      else state0.[k]).
    + wp; skip => /> &1 &2 hr200 hj200 hin0 hj0 hgj hem; rewrite !W64.ultE => hr8 hjr8 hjr hs _hh. 
      have heq : to_uint (W64.of_int 8 * j{2}) = 8 * to_uint j{2}.
      + by rewrite W64.to_uintM_small //= /#.
      rewrite to_uintD_small heq /= 1:/#.       
      rewrite to_uintD_small heq /= 1:/#.       
      rewrite to_uintD_small /=; 1: smt(W64.to_uint_cmp).
      have ? : 0 <= to_uint j{2} < 25 by smt (W64.to_uint_cmp).
      split.
      + move=> k hk1 hk2.
        rewrite hgj 1:// to_uintK_jagged 1:// Array28.set_neqiE 1:jagged_bound 1://; smt (jagged_inj).
      split; 1: smt().
      rewrite hgj 1:// to_uintK_jagged 1:// => k hk1 hk2.
      rewrite hs 1:// /=.
      case (k < to_uint j{2} + 1) => hh.
      + case (k = to_uint j{2}) => [->> | hne].
        + by rewrite Array25.set_eqiE 1,2:// Array28.set_eqiE 1:jagged_bound.
        rewrite Array25.set_neqiE 1,2:// Array28.set_neqiE 1:jagged_bound //; smt (jagged_inj).
      rewrite Array25.set_neqiE 1:// 1:/# hs 1:// /#.
    wp; call{2} init_s_stateP; skip => |> &1 &2 *; split.
    + split.
      + by move=> off ??; rewrite H5 2://; apply jagged_bound.
      rewrite /(`>>`) /= to_uint_shr //=.
      split; 1: smt (W64.to_uint_cmp).
      move=> k hk1 hk2; rewrite H5; 1: by apply jagged_bound.
      by rewrite W64.xorw0.
    by move=> state_ j_ s_state_; rewrite !W64.ultE => /#.
  seq 6 15 : 
     (to_uint rate{2} < 200 /\ 
      jagged_zeros_W64_p s_state{2} 
         (fun (off : int) => (to_uint inlen{2} %/8 + 1) <= off < 25 /\ off <> (to_uint rate{2} - 1) %/ 8) /\
     (em_states state{2} state0) /\ 
     forall k, 0 <= k < 25 =>
       state{1}.[k] = if k < to_uint inlen{2} %/ 8 + 1 \/ k = (to_uint rate{2} - 1) %/ 8 then state0.[k] `^` s_state{2}.[A_jagged.[k]]
                      else state0.[k]); last first.
  + unroll for{2} ^while; wp; skip => |> &1 &2.
    rewrite /em_states => /> /= *.
    apply Array7.all_eq_eq; rewrite /Array7.all_eq /index /=.
    apply (state_xor_jagged _ _ _ _ H0); smt().
  wp.
  seq 0 2: (#pre /\ to_uint l{2} = 8 * A_jagged.[to_uint inlen{2} %/ 8]).
  + wp; skip => /> &1 &2 *.
    have heq : to_uint (W64.of_int 8 * j{2}) = 8 * to_uint j{2}.
    + by rewrite W64.to_uintM_small //= /#.
    have ?: 0 <= to_uint j{2} < 25 by smt(W64.to_uint_cmp).
    rewrite to_uintD_small heq /= 1:/# H3 1://.
    rewrite /(`<<`) /= W64.shlMP 1:// /= -W64.of_intM W64.to_uintM_small to_uintK_jagged //=; 1: smt(jagged_bound).
    by rewrite H6; ring.  
  while (
     to_uint rate{2} < 200 /\
     to_uint a_jagged{2} + 200 < W64.modulus /\
     to_uint in_0{2} + to_uint inlen{2} < W64.modulus /\
     jagged_zeros_W64 s_state{2} (to_uint inlen{2} %/8 + 1) /\
     (forall k, to_uint l{2} <= k < 8 * A_jagged.[to_uint inlen{2} %/ 8] + 8 => 
        s_state{2}.[k %/ 8] \bits8 (k %% 8) = W8.zero) /\
     ={Glob.mem, trail_byte, in_0, inlen} /\
     to_uint inlen{2} < to_uint rate{2} /\
     i{1} = j{2} /\
     to_uint l{2} = 8 * A_jagged.[to_uint inlen{2} %/ 8] + (to_uint j{2} - 8 * (to_uint inlen{2} %/ 8)) /\
     8 * (to_uint inlen{2} %/ 8) <= to_uint j{2} <= to_uint inlen{2} /\
     forall (k : int),
       0 <= k < 25 =>
       state{1}.[k] = if k < to_uint inlen{2} %/ 8 + 1 then state0.[k] `^` s_state{2}.[A_jagged.[k]] else state0.[k]).
  + wp; skip => /> &1 &2; rewrite W64.ultE => *.
    rewrite !W64.to_uintD_small /=. 
    + smt(). + smt(W64.to_uint_cmp jagged_bound). + smt().
    split.
    + move=> k hk1 hk2.
      rewrite initiE; 1: by apply jagged_bound.
      rewrite get64_set8; 1,2: smt(W64.to_uint_cmp jagged_bound).
      smt(W64.to_uint_cmp jagged_inj).
    split.
    + move=> k hk1 hk2;rewrite initiE; 1: smt(W64.to_uint_cmp jagged_bound).
      rewrite get64_set8; 1, 2: smt(W64.to_uint_cmp jagged_bound).
      case: (8 * (k %/ 8) <= to_uint l{2} < 8 * (k %/ 8) + 8); last by smt().
      move=> ?; rewrite W8u8.pack8bE 1:/# initiE /= /#.
    split; 1:ring H5.
    split; 1: smt().
    move=> k hk1 hk2.    
    rewrite initiE; 1: by apply jagged_bound.
    rewrite initiE 1:// get64_set8.
    + smt(W64.to_uint_cmp jagged_bound). + by apply jagged_bound.
    rewrite get64_set8_200 //. 
    + smt(W64.to_uint_cmp). 
    case: (8 * k <= to_uint j{2} < 8 * k + 8) => h; last first.
    have -> : (! 8 * A_jagged.[k] <= to_uint l{2} < 8 * A_jagged.[k] + 8);
        [ by rewrite H5; smt(jagged_inj @W64) | by smt() ].
    have -> /= : k < to_uint inlen{2} %/ 8 + 1 by smt().
    case: (8 * A_jagged.[k] <= to_uint l{2} < 8 * A_jagged.[k] + 8) => h1.
    + apply W8u8.wordP => i hi.
      rewrite /= !W8u8.pack8bE 1,2:// !initiE 1,2:// /=.
      have -> : to_uint j{2} %% 8 = to_uint l{2} %% 8 by smt().
      case: (i = to_uint l{2} %% 8) => [->> | hne]; last first.
        rewrite (H8 k); first by smt().
        by have -> : (k < to_uint inlen{2} %/ 8 + 1); smt(jagged_inj @W64). 
      rewrite /WArray200.WArray200.get8 /WArray200.WArray200.init64 WArray200.WArray200.initiE /=; first by smt (). 
        rewrite xorwC xorwC;congr.
        rewrite  (H8 (to_uint j{2} %/ 8)); first by smt().
        have -> : (to_uint j{2} %/ 8 < to_uint inlen{2} %/ 8 + 1); first by smt(@W64 jagged_inj).      
        simplify. 
        rewrite (_: to_uint j{2} %% 8 = to_uint l{2} %% 8); first by smt().
        rewrite (_: to_uint j{2} %/ 8 = k). smt(@W64). 
        rewrite (_: (s_state{2}.[A_jagged.[k]] \bits8 to_uint l{2} %% 8) = W8.zero); last by smt(). 
        rewrite (_: A_jagged.[k] = to_uint l{2} %/ 8); first by smt(@W64).
        by apply (H3 (to_uint l{2})); smt().
    apply W8u8.wordP => i hi.
    rewrite /= !W8u8.pack8bE 1,2:// !initiE 1,2:// /=.
    case: (i = to_uint j{2} %% 8) => [->> | hne]; last by smt (@W64).
    rewrite /WArray200.WArray200.get8 /WArray200.WArray200.init64 WArray200.WArray200.initiE /=; smt (@W64).
  wp; skip => /> &1 &2 *.
  split.
  + rewrite /(`<<`) /= W64.to_uint_shl 1:// /=.
    rewrite modz_small; 1: smt(W64.to_uint_cmp).
    split; first by smt().
    split. 
    move => k kb1 kb2.
    move : H2; rewrite /jagged_zeros_W64 /jagged_zeros_W64_p => *.
    rewrite (_: s_state{2}.[k %/ 8] = W64.zero); first by smt(@W64).
    by rewrite get_zero //=.
    split; first by smt().
    split; first by smt().
    move => k kb1 kb2.
    case (k < to_uint inlen{2} %/ 8 + 1); last by smt().
    rewrite (H7 k); first by smt().
    move => kb.
    case (k = to_uint inlen{2} %/ 8); last by smt(@W64).
    move => Ke.
    rewrite (_: k < to_uint inlen{2} %/ 8  = false); first by smt().   
    simplify.
    rewrite (_: s_state{2}.[A_jagged.[k]] = W64.zero); last by smt().
    move : H2; rewrite /jagged_zeros_W64 /jagged_zeros_W64_p => *.
    by apply (H2 k); smt().
  move=> ????; rewrite W64.ultE => *.
  have heq: to_uint (rate{2} - W64.one `>>` W8.of_int 3) = (to_uint rate{2} - 1) %/ 8.
  + rewrite /(`>>`) W64.to_uint_shr /= 1://.
    rewrite W64.to_uintB 1:uleE //=; smt(W64.to_uint_cmp).
  have heq1 : to_uint (W64.of_int 8 * (rate{2} - W64.one `>>` W8.of_int 3)) = 
              8 * ((to_uint rate{2} - 1) %/ 8).
  + rewrite to_uintM_small /= heq //; smt(W64.to_uint_cmp).
  have -> : loadW64 Glob.mem{2} (to_uint (a_jagged{2} + (of_int 8)%W64 * (rate{2} - W64.one `>>` (of_int 3)%W8))) =
         W64.of_int (A_jagged.[(to_uint rate{2} - 1) %/ 8]).
  + rewrite W64.to_uintD_small /= heq1. smt(W64.to_uint_cmp).
    rewrite H3 //; smt(W64.to_uint_cmp).
  have heq2: to_uint  ((rate{2} - W64.one) `&` W64.of_int 7) = (to_uint rate{2} - 1) %% 8.
  + rewrite (W64.to_uint_and_mod 3) //=.
    rewrite W64.to_uintB 1:uleE //=; smt(W64.to_uint_cmp).
  have heq3 : to_uint ((W64.of_int A_jagged.[(to_uint rate{2} - 1) %/ 8]) `<<` W8.of_int 3) = 
              8 * A_jagged.[(to_uint rate{2} - 1) %/ 8].
  + rewrite /(`<<`) /= W64.to_uint_shl 1:// /=.
    smt (modz_small to_uintK_jagged W64.to_uint_cmp jagged_bound).
  have heq4: to_uint (((W64.of_int A_jagged.[(to_uint rate{2} - 1) %/ 8]) `<<` W8.of_int 3) + (rate{2} - W64.one) `&` W64.of_int 7) =
             8 * A_jagged.[(to_uint rate{2} - 1) %/ 8] + (to_uint rate{2} - 1) %% 8.
  + rewrite W64.to_uintD_small heq2 heq3 //; smt(W64.to_uint_cmp jagged_bound).
  split.
  + move=> k hk1 hk2.
    rewrite Array28.initiE; 1: by apply jagged_bound.
    rewrite heq4 get64_set8; 1,2: smt(W64.to_uint_cmp jagged_bound).
    rewrite (_: 8 * A_jagged.[k] <=
    8 * A_jagged.[(to_uint rate{2} - 1) %/ 8] + (to_uint rate{2} - 1) %% 8 <
    8 * A_jagged.[k] + 8 = false) //=; first by smt(@W64 jagged_bound jagged_inj).
    rewrite Array28.initiE; 1: by apply jagged_bound.
    rewrite  get64_set8; 1,2: smt(W64.to_uint_cmp jagged_bound).
    case (8 * A_jagged.[k] <= to_uint l_R < 8 * A_jagged.[k] + 8) => [ht | hf]; first by smt(@W64 jagged_bound jagged_inj). 
    by apply (H11 k); smt (@W64 jagged_bound jagged_inj). 
  move=> k hk1 hk2.
  have -> : to_uint (rate{2} - W64.one) = to_uint rate{2} - 1.
  + rewrite W64.to_uintB 1:uleE /=; smt(W64.to_uint_cmp).
  rewrite Array28.initiE; 1: by apply jagged_bound.
  rewrite heq4 get64_set8; 1,2: smt(W64.to_uint_cmp jagged_bound).
  rewrite Array25.initiE 1:// get64_set8_200. 
  + smt(W64.to_uint_cmp).
  + done.
  case (k < to_uint inlen{2} %/ 8 + 1 \/ k = (to_uint rate{2} - 1) %/ 8) => [ht | hf].
  + case (k = (to_uint rate{2} - 1) %/ 8) => [hht | hhf].
    rewrite (_: 8 * k <= to_uint rate{2} - 1 < 8 * k + 8 = true); first
      by smt (@W64 jagged_bound jagged_inj). 
    rewrite (_: 8 * A_jagged.[k] <=
   8 * A_jagged.[(to_uint rate{2} - 1) %/ 8] + (to_uint rate{2} - 1) %% 8 <
   8 * A_jagged.[k] + 8 = true); first by smt (@W64 jagged_bound jagged_inj). 
    simplify.
    rewrite (_: state0.[k] = state_L.[k] `^` s_state_R.[A_jagged.[k]]).
       rewrite H16; first by smt (@W64 jagged_bound jagged_inj). 
       case (k < to_uint inlen{2} %/ 8 + 1) => [hhhht | hhhhf].
             rewrite  -(W64.xorwA); smt (@W64 jagged_bound jagged_inj).
          rewrite (_ : s_state_R.[A_jagged.[k]] = W64.zero). 
            by apply (H11 k); smt (@W64 jagged_bound jagged_inj).
            by smt (@W64 jagged_bound jagged_inj).
       rewrite (_: 
          state_L.[k] `^` s_state_R.[A_jagged.[k]] =
          pack8_t 
            ((init
               (fun (j : int) =>
                 (state_L.[k] `^` s_state_R.[A_jagged.[k]]) \bits8 j)))%W8u8.Pack).  
             apply W8u8.wordP => i hi. 
             rewrite (_: 
               (pack8_t
                ((init
                    (fun (j : int) => state_L.[k] `^` 
                       s_state_R.[A_jagged.[k]] \bits8 j)))%W8u8.Pack \bits8 i) = 
                     state_L.[k] `^` s_state_R.[A_jagged.[k]] \bits8 i); last by congr. 
          by rewrite aux.
      rewrite xorb8u8E map2E.
       congr. congr. apply fun_ext => ii.
       case (! 0 <= ii < 8) => [hti | hfi].
       + rewrite (_: (ii = (to_uint rate{2} - 1) %% 8) = false); first by smt().
         simplify.
         rewrite (W8u8.get_out _ ii); first by apply hti.
         rewrite (W8u8.Pack.get_out _ ii); first by  apply hti. 
         by rewrite (W8u8.Pack.get_out _ ii); first by  apply hti. 
       + case (ii = (to_uint rate{2} - 1) %% 8) => [hhit | hhif].
         rewrite (W8u8.Pack.initiE); first by apply hfi.
         rewrite (W8u8.Pack.initiE); first by apply hfi.
         rewrite (WArray200.WArray200.initiE); first by smt().
         simplify.
         rewrite (WArray200.WArray200.initiE); first by smt(@W64 jagged_bound jagged_inj).
         have -> : (ii =
   (8 * A_jagged.[(to_uint rate{2} - 1) %/ 8] + (to_uint rate{2} - 1) %% 8) %%
   8); first by smt (@W64 jagged_bound jagged_inj).
         rewrite /get8 /init64.  
         rewrite (WArray224.initiE); first by smt(@W64 jagged_bound jagged_inj).
         simplify.
         rewrite W8.xorwA. congr.
         rewrite -(xorb8E).
         rewrite -(xorb8E).
         have -> : ((8 * A_jagged.[(to_uint rate{2} - 1) %/ 8] + (to_uint rate{2} - 1) %% 8) %%
 8 = (to_uint rate{2} - 1) %% 8); first by smt(@W64 jagged_bound jagged_inj).
         congr.
         rewrite Array25.initiE; first by smt().
         rewrite Array28.initiE; first by smt(jagged_bound).
         rewrite get64_set8_200; first 2 by smt(@W64 jagged_bound jagged_inj).
         rewrite get64_set8; first 2 by smt(@W64 jagged_bound jagged_inj).
         case : (8 * ((to_uint rate{2} - 1) %/ 8) <= to_uint j_R <
    8 * ((to_uint rate{2} - 1) %/ 8) + 8) => [ hjt | hjf].
         + have -> : (8 *
   ((8 * A_jagged.[(to_uint rate{2} - 1) %/ 8] + (to_uint rate{2} - 1) %% 8) %/
    8) <=
   to_uint l_R <
   8 *
   ((8 * A_jagged.[(to_uint rate{2} - 1) %/ 8] + (to_uint rate{2} - 1) %% 8) %/
    8) +
   8 ); first  by smt(@W64 jagged_bound jagged_inj).
           simplify. 
           rewrite -(aux (state_L.[k] `^` s_state_R.[A_jagged.[k]])).
           rewrite xorb8u8E map2E.
           congr. congr. apply fun_ext => iii.
           case (! 0 <= iii < 8) => [hiiit | hiiif].
           + rewrite !W8u8.Pack.get_out; first 2 by apply hiiit.
             have -> : (! iii = to_uint j_R %% 8); first by smt().
             simplify. by rewrite W8u8.get_out; first by  apply hiiit.
           + rewrite !initiE; first 2 by apply hiiif. simplify.
             case (iii = to_uint j_R %% 8) => [hhjt | hhjf].
             + have -> : (iii = to_uint l_R %% 8); first by smt(@W64 jagged_bound jagged_inj).
               simplify. congr. 
               rewrite (_: (s_state_R.[A_jagged.[k]] \bits8 to_uint l_R %% 8) = W8.zero).
                  rewrite (_: A_jagged.[k] = to_uint l_R %/ 8); first by smt(@W64 jagged_bound jagged_inj). apply H12; by smt(@W64 jagged_bound jagged_inj).
                  by smt(@W8 @W64 jagged_bound jagged_inj).
             + have -> : (iii <> to_uint l_R %% 8); first by smt(@W64 jagged_bound jagged_inj).
               simplify. rewrite -hht. 
               rewrite (_: (8 * A_jagged.[k] + (to_uint rate{2} - 1) %% 8) %/ 8 = A_jagged.[k]); first by smt(@W64 jagged_bound jagged_inj). by rewrite -(W8.xorwA);  smt(@W64).

         + have -> : (! 8 *
   ((8 * A_jagged.[(to_uint rate{2} - 1) %/ 8] + (to_uint rate{2} - 1) %% 8) %/
    8) <=
   to_uint l_R <
   8 *
   ((8 * A_jagged.[(to_uint rate{2} - 1) %/ 8] + (to_uint rate{2} - 1) %% 8) %/
    8) +
   8); first  by smt(@W64 jagged_bound jagged_inj).
           simplify. rewrite -hht.
           rewrite (_: (8 * A_jagged.[k] + (to_uint rate{2} - 1) %% 8) %/ 8 = A_jagged.[k]); 
             first by smt(). 
           by rewrite -(W64.xorwA); smt(@W64).

       + rewrite (W8u8.Pack.initiE); first by apply hfi.
         rewrite (W8u8.Pack.initiE); first by apply hfi.
         rewrite (WArray200.WArray200.initiE); first by smt(@W64).
         simplify.
         have -> : (ii <>
   (8 * A_jagged.[(to_uint rate{2} - 1) %/ 8] + (to_uint rate{2} - 1) %% 8) %%
   8); first by smt (@W64 jagged_bound jagged_inj).
         rewrite /get8 /init64.  
         rewrite (WArray224.initiE); first by smt(@W64 jagged_bound jagged_inj).
         simplify.
         rewrite -(xorb8E).
         rewrite -(xorb8E).
         rewrite Array25.initiE; first by smt().
         rewrite Array28.initiE; first by smt(jagged_bound).
         rewrite get64_set8_200; first 2 by smt(@W64 jagged_bound jagged_inj).
         rewrite get64_set8; first 2 by smt(@W64 jagged_bound jagged_inj).
         case : (8 * k <= to_uint j_R < 8 * k + 8) => [ hjt | hjf].
         + have -> : (8 * A_jagged.[k] <= to_uint l_R < 8 * A_jagged.[k] + 8); first  by smt(@W64 jagged_bound jagged_inj).
           simplify. 
           rewrite -xorb8E.
           rewrite -(aux (state_L.[k] `^` s_state_R.[A_jagged.[k]])).
           rewrite -xorb8E xorb8u8E map2E.
           congr. congr. congr. apply fun_ext => iii.
           case (! 0 <= iii < 8) => [hiiit | hiiif].
           + rewrite !W8u8.Pack.get_out; first 2 by apply hiiit.
             have -> : (! iii = to_uint j_R %% 8); first by smt().
             simplify. by rewrite W8u8.get_out; first by  apply hiiit.
           + rewrite !initiE; first 2 by apply hiiif. simplify.
             case (iii = to_uint j_R %% 8) => [hhjt | hhjf].
             + have -> : (iii = to_uint l_R %% 8); first by smt(@W64 jagged_bound jagged_inj).
               simplify. congr. 
               rewrite (_: (s_state_R.[A_jagged.[k]] \bits8 to_uint l_R %% 8) = W8.zero).
                  rewrite (_: A_jagged.[k] = to_uint l_R %/ 8); first by smt(@W64 jagged_bound jagged_inj). apply H12; by smt(@W64 jagged_bound jagged_inj).
                  by smt(@W8 @W64 jagged_bound jagged_inj).
             + have -> : (iii <> to_uint l_R %% 8); first by smt(@W64 jagged_bound jagged_inj).
               simplify.
               by rewrite -(W8.xorwA);  smt(@W64).
         + have -> : (! 8 * A_jagged.[k] <= to_uint l_R < 8 * A_jagged.[k] + 8); first  by smt(@W64 jagged_bound jagged_inj).
           simplify. 
           rewrite -(xorb8E).
           rewrite -(xorb8E).
           congr.
           by rewrite -(W64.xorwA); smt(@W64).
   rewrite (_: 8 * k <= to_uint rate{2} - 1 < 8 * k + 8 = false); first
      by smt (@W64 jagged_bound jagged_inj). 
    rewrite (_: 8 * A_jagged.[k] <=
       8 * A_jagged.[(to_uint rate{2} - 1) %/ 8] + (to_uint rate{2} - 1) %% 8 <
        8 * A_jagged.[k] + 8 = false); first by smt (@W64 jagged_bound jagged_inj). 
         simplify. 
         rewrite (_: state0.[k] = state_L.[k] `^` s_state_R.[A_jagged.[k]]).
           rewrite H16; first by smt (@W64 jagged_bound jagged_inj). 
         case (k < to_uint inlen{2} %/ 8 + 1); last by smt (@W64 jagged_bound jagged_inj). 
           by rewrite -(W64.xorwA); smt (@W64 jagged_bound jagged_inj). 
      rewrite !initiE; first 2 by smt (@W64 jagged_bound jagged_inj). 
      rewrite get64_set8_200; first 2 by smt(W64.to_uint_cmp jagged_bound).
      rewrite get64_set8; first 2 by smt(W64.to_uint_cmp jagged_bound).
       rewrite (_: 
          state_L.[k] `^` s_state_R.[A_jagged.[k]] =
          pack8_t 
            ((init
               (fun (j : int) =>
                 (state_L.[k] `^` s_state_R.[A_jagged.[k]]) \bits8 j)))%W8u8.Pack).  
             apply W8u8.wordP => i hi. 
             rewrite (_: 
               (pack8_t
                ((init
                    (fun (j : int) => state_L.[k] `^` 
                       s_state_R.[A_jagged.[k]] \bits8 j)))%W8u8.Pack \bits8 i) = 
                     state_L.[k] `^` s_state_R.[A_jagged.[k]] \bits8 i); last by congr. 
          by rewrite aux.
      case (k < to_uint inlen{2} %/ 8) => [kht | khf].
      rewrite (_: 8 * k <= to_uint j_R < 8 * k + 8 = false); first by smt (@W64 jagged_bound jagged_inj).
      rewrite (_: 8 * A_jagged.[k] <= to_uint l_R < 8 * A_jagged.[k] + 8 = false); first by smt (@W64 jagged_bound jagged_inj). simplify. 
           rewrite (aux (state_L.[k] `^` s_state_R.[A_jagged.[k]])). 
             by rewrite -W64.xorwA; smt(@W64).
        rewrite (_: k = to_uint inlen{2} %/ 8); first by smt().
      rewrite   (_:8 * (to_uint inlen{2} %/ 8) <= to_uint j_R <
    8 * (to_uint inlen{2} %/ 8) + 8 = true); first by  smt (@W64 jagged_bound jagged_inj). 
         rewrite (_: 8* A_jagged.[to_uint inlen{2} %/ 8] <= to_uint l_R <
   8 * A_jagged.[to_uint inlen{2} %/ 8] + 8 = true);
           first by smt (@W64 jagged_bound jagged_inj). 
      simplify. 
          (******)
              apply W8u8.wordP => i hi.
                case (i = 0) => />.
                rewrite /get8 bits8E.
                case (0 = to_uint j_R %% 8) => [hhhhht | hhhhhtf].
                rewrite (_:to_uint l_R %% 8 = 0); first by  smt (@W64 jagged_bound jagged_inj).
                simplify. congr. rewrite (_: A_jagged.[to_uint inlen{2} %/  8] = to_uint l_R %/8). rewrite H13.
                rewrite (_: to_uint j_R = 8 *  to_uint inlen{2} %/ 8); first by smt(). by smt().
                move : (H12 (to_uint l_R)).
                rewrite (_:to_uint l_R %% 8 = 0); first by  smt (@W64 jagged_bound jagged_inj).
                move => *. rewrite H17.
 by  smt (@W8 @W64 jagged_bound jagged_inj). 
                   rewrite /init64 WArray200.WArray200.initiE; first by smt().  auto => />. rewrite bits8E. smt(@W8).
                rewrite (_:(0 = to_uint l_R %% 8) = false); first by  smt (@W64 jagged_bound jagged_inj). simplify.
                   by rewrite -W8.xorwA W8.xorwK; smt(@W8).
                case (i = 1) => />.
                rewrite /get8 bits8E.
                case (1 = to_uint j_R %% 8) => [hhhhht | hhhhhtf].
                rewrite (_:to_uint l_R %% 8 = 1); first by  smt (@W64 jagged_bound jagged_inj).
                simplify. congr. rewrite (_: A_jagged.[to_uint inlen{2} %/  8] = to_uint l_R %/8). rewrite H13.
                rewrite (_: to_uint j_R = 8 *  to_uint inlen{2} %/ 8); first by smt(). by smt().
                move : (H12 (to_uint l_R)).
                rewrite (_:to_uint l_R %% 8 = 1); first by  smt (@W64 jagged_bound jagged_inj).
                move => *. rewrite H17.
 by  smt (@W8 @W64 jagged_bound jagged_inj). 
                   rewrite /init64 WArray200.WArray200.initiE; first by smt().  auto => />. rewrite bits8E. smt(@W8).
                rewrite (_:(1 = to_uint l_R %% 8) = false); first by  smt (@W64 jagged_bound jagged_inj). simplify.
                   by rewrite -W8.xorwA W8.xorwK; smt(@W8).
                case (i = 2) => />.
                rewrite /get8 bits8E.
                case (2 = to_uint j_R %% 8) => [hhhhht | hhhhhtf].
                rewrite (_:to_uint l_R %% 8 = 2); first by  smt (@W64 jagged_bound jagged_inj).
                simplify. congr. rewrite (_: A_jagged.[to_uint inlen{2} %/  8] = to_uint l_R %/8). rewrite H13.
                rewrite (_: to_uint j_R = 8 *  to_uint inlen{2} %/ 8); first by smt(). by smt().
                move : (H12 (to_uint l_R)).
                rewrite (_:to_uint l_R %% 8 = 2); first by  smt (@W64 jagged_bound jagged_inj).
                move => *. rewrite H17.
 by  smt (@W8 @W64 jagged_bound jagged_inj). 
                   rewrite /init64 WArray200.WArray200.initiE; first by smt().  auto => />. rewrite bits8E. smt(@W8).
                rewrite (_:(2 = to_uint l_R %% 8) = false); first by  smt (@W64 jagged_bound jagged_inj). simplify.
                   by rewrite -W8.xorwA W8.xorwK; smt(@W8).
                case (i = 3) => />.
                rewrite /get8 bits8E.
                case (3 = to_uint j_R %% 8) => [hhhhht | hhhhhtf].
                rewrite (_:to_uint l_R %% 8 = 3); first by  smt (@W64 jagged_bound jagged_inj).
                simplify. congr. rewrite (_: A_jagged.[to_uint inlen{2} %/  8] = to_uint l_R %/8). rewrite H13.
                rewrite (_: to_uint j_R = 8 *  to_uint inlen{2} %/ 8); first by smt(). by smt().
                move : (H12 (to_uint l_R)).
                rewrite (_:to_uint l_R %% 8 = 3); first by  smt (@W64 jagged_bound jagged_inj).
                move => *. rewrite H17.
 by  smt (@W8 @W64 jagged_bound jagged_inj). 
                   rewrite /init64 WArray200.WArray200.initiE; first by smt().  auto => />. rewrite bits8E. smt(@W8).
                rewrite (_:(3 = to_uint l_R %% 8) = false); first by  smt (@W64 jagged_bound jagged_inj). simplify.
                   by rewrite -W8.xorwA W8.xorwK; smt(@W8).
                case (i = 4) => />.
                rewrite /get8 bits8E.
                case (4 = to_uint j_R %% 8) => [hhhhht | hhhhhtf].
                rewrite (_:to_uint l_R %% 8 = 4); first by  smt (@W64 jagged_bound jagged_inj).
                simplify. congr. rewrite (_: A_jagged.[to_uint inlen{2} %/  8] = to_uint l_R %/8). rewrite H13.
                rewrite (_: to_uint j_R = 8 *  to_uint inlen{2} %/ 8); first by smt(). by smt().
                move : (H12 (to_uint l_R)).
                rewrite (_:to_uint l_R %% 8 = 4); first by  smt (@W64 jagged_bound jagged_inj).
                move => *. rewrite H17.
 by  smt (@W8 @W64 jagged_bound jagged_inj). 
                   rewrite /init64 WArray200.WArray200.initiE; first by smt().  auto => />. rewrite bits8E. smt(@W8).
                rewrite (_:(4 = to_uint l_R %% 8) = false); first by  smt (@W64 jagged_bound jagged_inj). simplify.
                   by rewrite -W8.xorwA W8.xorwK; smt(@W8).
                case (i = 5) => />.
                rewrite /get8 bits8E.
                case (5 = to_uint j_R %% 8) => [hhhhht | hhhhhtf].
                rewrite (_:to_uint l_R %% 8 = 5); first by  smt (@W64 jagged_bound jagged_inj).
                simplify. congr. rewrite (_: A_jagged.[to_uint inlen{2} %/  8] = to_uint l_R %/8). rewrite H13.
                rewrite (_: to_uint j_R = 8 *  to_uint inlen{2} %/ 8); first by smt(). by smt().
                move : (H12 (to_uint l_R)).
                rewrite (_:to_uint l_R %% 8 = 5); first by  smt (@W64 jagged_bound jagged_inj).
                move => *. rewrite H17.
 by  smt (@W8 @W64 jagged_bound jagged_inj). 
                   rewrite /init64 WArray200.WArray200.initiE; first by smt().  auto => />. rewrite bits8E. smt(@W8).
                rewrite (_:(5 = to_uint l_R %% 8) = false); first by  smt (@W64 jagged_bound jagged_inj). simplify.
                   by rewrite -W8.xorwA W8.xorwK; smt(@W8).
                case (i = 6) => />.
                rewrite /get8 bits8E.
                case (6 = to_uint j_R %% 8) => [hhhhht | hhhhhtf].
                rewrite (_:to_uint l_R %% 8 = 6); first by  smt (@W64 jagged_bound jagged_inj).
                simplify. congr. rewrite (_: A_jagged.[to_uint inlen{2} %/  8] = to_uint l_R %/8). rewrite H13.
                rewrite (_: to_uint j_R = 8 *  to_uint inlen{2} %/ 8); first by smt(). by smt().
                move : (H12 (to_uint l_R)).
                rewrite (_:to_uint l_R %% 8 = 6); first by  smt (@W64 jagged_bound jagged_inj).
                move => *. rewrite H17.
 by  smt (@W8 @W64 jagged_bound jagged_inj). 
                   rewrite /init64 WArray200.WArray200.initiE; first by smt().  auto => />. rewrite bits8E. smt(@W8).
                rewrite (_:(6 = to_uint l_R %% 8) = false); first by  smt (@W64 jagged_bound jagged_inj). simplify.
                   by rewrite -W8.xorwA W8.xorwK; smt(@W8).
                case (i = 7) => />.
                rewrite /get8 bits8E.
                case (7 = to_uint j_R %% 8) => [hhhhht | hhhhhtf].
                rewrite (_:to_uint l_R %% 8 = 7); first by  smt (@W64 jagged_bound jagged_inj).
                simplify. congr. rewrite (_: A_jagged.[to_uint inlen{2} %/  8] = to_uint l_R %/8). rewrite H13.
                rewrite (_: to_uint j_R = 8 *  to_uint inlen{2} %/ 8); first by smt(). by smt().
                move : (H12 (to_uint l_R)).
                rewrite (_:to_uint l_R %% 8 = 7); first by  smt (@W64 jagged_bound jagged_inj).
                move => *. rewrite H17.
 by  smt (@W8 @W64 jagged_bound jagged_inj). 
                   rewrite /init64 WArray200.WArray200.initiE; first by smt().  auto => />. rewrite bits8E. smt(@W8).
                rewrite (_:(7 = to_uint l_R %% 8) = false); first by  smt (@W64 jagged_bound jagged_inj). simplify.
                   by rewrite -W8.xorwA W8.xorwK; smt(@W8).
                 by smt().
          (*****)
    rewrite (_: 8 * k <= to_uint rate{2} - 1 < 8 * k + 8 = false); first
      by smt (@W64 jagged_bound jagged_inj). 
    simplify.
      rewrite initiE; first by smt().
    rewrite get64_set8_200; first 2 by smt(W64.to_uint_cmp jagged_bound).
    by smt(W64.to_uint_cmp jagged_bound).
qed.

require import Keccakf1600_pscalar_table.

op disj_ptr (p1 : address) (len1:int) (p2: address) ( len2:int) = 
  p1 + len1 <= p2 \/ p2 + len2 <= p1.

op good_ptr (p : address) (len:int) = p + len < W64.modulus.

lemma loadW64_storeW64_diff mem i j w: 
  j + 8 <= i \/ i + 8 <= j =>
  loadW64 (storeW64 mem i w) j = loadW64 mem j.
proof.
  move=> hij; apply W8u8.wordP => k hk.
  rewrite /loadW64 !W8u8.pack8bE 1,2:// !initiE 1,2:// /= storeW64E get_storesE /= /#.
qed.


lemma get_em_states state1 state2 j:
   0 <= j < 25 =>
   em_states state2 state1 =>
   state1.[j] = (state2.[A_jagged.[j] %/ 4] \bits64 A_jagged.[j] %% 4).
proof.
  rewrite /em_states => hj ->.
  rewrite get_of_list; 1:smt (jagged_bound).
  rewrite /index /= /A_jagged /=.
  rewrite -(mema_iota 0 25 j) in hj.
  move: j hj.
  by apply List.allP; cbv delta.
qed.

equiv extr_full_block_corr _outlen _rate _out _iotas rl rr jag :
 Keccak1600_pref_modular.Mmod.xtr_full_block  ~ Mmod.xtr_full_block :
        disj_ptr jag 200 _out _outlen /\ 
        disj_ptr _iotas 800 _out _outlen /\ 
        disj_ptr rl 200 _out _outlen /\
        disj_ptr rr 200 _out _outlen /\
        to_uint len{2} < 200 /\ to_uint a_jagged{2} + 200 < W64.modulus /\ 
        _out + _outlen < W64.modulus /\ _rate <= _outlen /\
        good_jag Glob.mem{2} jag /\
        good_io4x Glob.mem{2} _iotas /\
        good_rhol Glob.mem{2} rl /\ good_rhor Glob.mem{2} rr /\
        to_uint rate{1} = _rate /\ to_uint outlen{1} = _outlen /\ to_uint out{1} = _out /\ jag = to_uint a_jagged{2} /\
       em_states state{2} state{1} /\ ={Glob.mem,out} /\ rate{1} = len{2}  ==>
       good_io4x Glob.mem{2} _iotas /\
       good_rhol Glob.mem{2} rl /\ good_rhor Glob.mem{2} rr /\
       good_jag Glob.mem{2} jag /\
       to_uint res{1}.`1 = _out + _rate /\ 
       to_uint res{1}.`2 = _outlen - _rate /\ ={Glob.mem} /\ res{1}.`1 = res{2}.
proof.
  proc.
  seq 0 3 : (#pre /\
      s_state{2} = Array28.init (fun i => state{2}.[i %/ 4] \bits64 i %%4)).
  + unroll for{2} ^while; wp; skip => /> *.
    apply Array28.tP => i hi /=.
    rewrite !initiE //.
    do 6! (rewrite set_get_def 1,2:// initiE 1://).
    by rewrite set_get_def 1,2:// /= /#.
  wp.  
  while (#pre /\ rate64{1} = len8{2} /\ i{1} = j{2} /\ to_uint rate64{1} = to_uint rate{1} %/8).
  + wp; skip => /> *.
    rewrite ultE in H13.
    have heq1 :  to_uint (W64.of_int 8 * j{2}) = 8 * to_uint j{2}.
    + rewrite W64.to_uintM_small //= 1:/#.
    have -> : to_uint (out{2} + (of_int 8)%W64 * j{2}) =  to_uint out{2} + 8 * to_uint j{2}.
    + rewrite W64.to_uintD_small heq1 /=; smt (W64.to_uint_cmp).
    have -> : to_uint (a_jagged{2} + W64.of_int 8 * j{2}) = to_uint a_jagged{2} + 8 * to_uint j{2}.
    + rewrite W64.to_uintD_small heq1 /=; smt (W64.to_uint_cmp).
    split; 1: smt (loadW64_storeW64_diff W64.to_uint_cmp).
    split; 1: smt (loadW64_storeW64_diff W64.to_uint_cmp).
    split; 1: smt (loadW64_storeW64_diff W64.to_uint_cmp).
    split; 1: smt (loadW64_storeW64_diff W64.to_uint_cmp).
    congr.    
    have ? : 0 <= to_uint j{2} < 25 by smt(W64.to_uint_cmp).
    rewrite H7 1:// to_uintK_jagged 1:// initiE /=; 1: by apply jagged_bound.
    by apply get_em_states.
  wp; skip => /> *.
  rewrite /(`>>`) /= W64.to_uint_shr 1:// /= => *.
  by rewrite W64.to_uintD_small 1:/# W64.to_uintB 1:W64.uleE.
qed.

require import IntExtra.

equiv extr_bytes_corr  :
  Keccak1600_pref_modular.Mmod.xtr_bytes  ~ Mmod.xtr_bytes :
    disj_ptr (to_uint a_jagged{2}) 200 (to_uint out{1}) (to_uint outlen{1}) /\ 
    to_uint a_jagged{2} + 200 < W64.modulus /\ to_uint outlen{1} < 200 /\
    good_jag Glob.mem{2} (to_uint a_jagged{2})  /\
    to_uint out{1} + to_uint outlen{1} < W64.modulus /\
    em_states state{2} state{1} /\ ={Glob.mem,out} /\ outlen{1} = len{2}  ==>
          ={Glob.mem}.
proof.
  proc => /=.
  seq 0 3 : (#pre /\
      s_state{2} = Array28.init (fun i => state{2}.[i %/ 4] \bits64 i %%4)).
  + unroll for{2} ^while; wp; skip => /> *.
    apply Array28.tP => i hi /=.
    rewrite !initiE //.
    do 6! (rewrite set_get_def 1,2:// initiE 1://).
    by rewrite set_get_def 1,2:// /= /#.
  wp. 
  seq 4 4: (#pre /\ i{1} = j{2} /\ to_uint j{2} = to_uint len{2} %/ 8).
  + while (#pre /\ i{1} = j{2} /\ to_uint outlen8{1} = to_uint outlen{1} %/ 8 /\ outlen8{1} = len8{2} /\
            to_uint j{2} <= to_uint len8{2}).
    + wp; skip => |> &1 &2; rewrite !W64.ultE => *.
      have heq1 :  to_uint (W64.of_int 8 * j{2}) = 8 * to_uint j{2}.
      + rewrite W64.to_uintM_small //= 1:/#.
      have -> : to_uint (out{2} + (of_int 8)%W64 * j{2}) =  to_uint out{2} + 8 * to_uint j{2}.
      + rewrite W64.to_uintD_small heq1 /=; smt (W64.to_uint_cmp).
      have -> : to_uint (a_jagged{2} + W64.of_int 8 * j{2}) = to_uint a_jagged{2} + 8 * to_uint j{2}.
      + rewrite W64.to_uintD_small heq1 /=; smt (W64.to_uint_cmp).
      split. 
      + split; 1: smt (loadW64_storeW64_diff W64.to_uint_cmp).
        congr.    
        have ? : 0 <= to_uint j{2} < 25 by smt(W64.to_uint_cmp).
        rewrite H2 1:// to_uintK_jagged 1:// initiE /=; 1: by apply jagged_bound.
        by apply get_em_states.
      by rewrite W64.to_uintD_small /= /#.
    wp; skip => /> *.
    rewrite /(`>>`) /= W64.to_uint_shr 1:// /=.
    split; 1: smt(W64.to_uint_cmp).
    by move => ??; rewrite ultE /(`>>`) /= W64.to_uint_shr 1:// /= /#. 
  while (
    to_uint outlen{1} < 200 /\
    em_states state{2} state{1} /\ ={Glob.mem, out} /\ outlen{1} = len{2} /\
    s_state{2} = Array28.init (fun (i0 : int) => state{2}.[i0 %/ 4] \bits64 i0 %% 4) /\
    i{1} = j{2} /\ 8 * (to_uint len{2} %/8) <= to_uint j{2} /\
    to_uint l{2} = 8 * A_jagged.[to_uint len{2} %/ 8] + (to_uint j{2} - 8 * (to_uint len{2} %/8))).
  + wp; skip => /> &1 &2; rewrite W64.ultE => *.
    split; last first. 
    + rewrite W64.to_uintD_small /=; 1: smt(jagged_bound W64.to_uint_cmp).
      rewrite W64.to_uintD_small /=; smt(jagged_bound W64.to_uint_cmp).
    congr.
    have hj : 0 <= to_uint j{2} < 200 by smt(W64.to_uint_cmp).
    rewrite /get8 /init64 WArray200.WArray200.initiE 1:// initiE /=; 1: smt(jagged_bound W64.to_uint_cmp).
    rewrite initiE /=; 1: smt(jagged_bound W64.to_uint_cmp).
    rewrite (get_em_states _ _ _ _ H0); 1: smt(W64.to_uint_cmp).
    smt(W64.to_uint_cmp).
  wp; skip => />.
   rewrite /disj_ptr /good_jag /em_states. move => *.
    rewrite !to_uint_shl; first 2 by smt(@W64).
    split; first by smt(@W64). 
    rewrite to_uintD_small; first by smt(@W64). 
    rewrite -H5.
    rewrite (_: to_uint ((of_int 8)%W64 * j{2}) = 8 * to_uint j{2}); first by smt(@W64). 
    rewrite H2; first  by smt(@W64).
    rewrite of_uintK. auto => />. 
    by smt(@W64 jagged_bound).
qed.

equiv modcorrect :
  Keccak1600_pref_modular.Mmod.__keccak1600_ref ~ Mmod.__keccak1600_avx2 :
    disj_ptr (to_uint a_jagged{2}) 200 (to_uint out{2}) (to_uint outlen{2}) /\ 
    disj_ptr (to_uint iotas{2}) 800 (to_uint out{2}) (to_uint outlen{2}) /\ 
    disj_ptr (to_uint rhotates_left{2}) 200 (to_uint out{2}) (to_uint outlen{2}) /\
    disj_ptr (to_uint rhotates_right{2}) 200 (to_uint out{2}) (to_uint outlen{2}) /\
    to_uint rate{2} < 200 /\
    to_uint a_jagged{2} + 200 < W64.modulus /\
    to_uint in_0{1} + to_uint inlen{1} < W64.modulus /\
    to_uint rhotates_left{2} + 192 < W64.modulus /\
    to_uint rhotates_right{2} + 192 <  W64.modulus /\
    to_uint iotas{2} + 768 < W64.modulus /\
    to_uint out{2} + to_uint outlen{2} < W64.modulus /\
    good_jag Glob.mem{2} (to_uint a_jagged{2}) /\
    good_io4x Glob.mem{2} (to_uint iotas{2}) /\ 
    good_rhol Glob.mem{2} (to_uint rhotates_left{2}) /\ 
    good_rhor Glob.mem{2} (to_uint rhotates_right{2}) /\
    in_0{1} = in_0{2} /\ inlen{1} = inlen{2} /\ s_out{1} = out{2} /\ s_outlen{1} = outlen{2} /\ rate{1} = rate{2} /\ truncateu8 s_trail_byte{1} = trail_byte{2} /\
    ={Glob.mem}
    ==> 
    ={Glob.mem}.
proof.
  proc => /=.
  seq 2 2 : (#pre /\ em_states state{2} state{1}). 
  + inline *. unroll for {1} 4. unroll for {2} 5.
     wp;skip;auto => />.
     move => *; rewrite /VPBROADCAST_4u64 /is4u6 /is4u64 => />.
     by rewrite /em_states; apply Array7.all_eq_eq.
  inline Mmod.absorb.
  swap {2} [6..7] -5.
  seq 0 3 : (#pre /\ in_00{2} = in_0{1} /\ inlen0{2} = inlen{1} /\ em_states state0{2} state{1}); first by auto => />.
  sp 0 6.
  seq 0 2 : (#pre /\ forall i, 0 <= i < 28 => s_state{2}.[i] = W64.zero).
  + inline *.
    unroll for {2} 5.
    wp; skip => /> *.
    do 7! (rewrite initiE // set_get_def //).
    rewrite /VPBROADCAST_4u64 /= W4u64.pack4bE 1:/#.
    by rewrite W4u64.Pack.get_of_list 1:/# /= /#.
  seq 1 1 : (#{/~em_states state{2} state{1}}{~in_0{1} = in_0{2}}{~inlen{1} = inlen{2}}
             {~s_state{2}}
             {~forall (i : int), 0 <= i < 28 => s_state{2}.[i] = Keccak1600_savx2.g_zero}
             {~to_uint in_0{2} + to_uint inlen{2} < 18446744073709551616}pre /\
             to_uint inlen{1} < to_uint rate{1}).
  + while (#{/~to_uint inlen{1} < to_uint rate{1}} post /\ 
           jagged_zeros_W64 s_state{2} (to_uint rate0{2} %/ 8)); last first.
    + skip => />; smt(jagged_bound W64.uleE).
    wp.
    ecall (avx2corr state{1} Glob.mem{2}). 
    wp.
    ecall (add_full_block_corr (to_uint rate0{2})).
    skip => |> &1 &2.
    rewrite W64.uleE => * /#.
  seq 3 2 : (#{/~em_states state0{2} state{1}}pre /\
               em_states state{2} state{1}).
  + wp; call add_final_block_corr; auto => />.
  inline Mmod.squeeze.
  swap {2} [2..5] -1; swap {2} 8 -7.
  sp 0 5. 
  seq 1 3 : (#{/~em_states state{2} state{1}}{~out{2}}
            {~s_outlen{1} = outlen{2}}pre /\ 
            disj_ptr (to_uint a_jagged{2}) 200 (to_uint out0{2}) (to_uint outlen0{2}) /\
            disj_ptr (to_uint iotas{2}) 800 (to_uint out0{2}) (to_uint outlen0{2}) /\
            disj_ptr (to_uint rhotates_left{2}) 200 (to_uint out0{2}) (to_uint outlen0{2}) /\
            disj_ptr (to_uint rhotates_right{2}) 200 (to_uint out0{2}) (to_uint outlen0{2}) /\
            to_uint out0{2} + to_uint outlen0{2} < 18446744073709551616 /\
            out0{2} = s_out{1} /\ outlen0{2} = outlen{1} /\ 
            em_states state1{2} state{1} /\
            good_io4x Glob.mem{2} (to_uint iotas{2}) /\
            good_rhol Glob.mem{2} (to_uint rhotates_left{2}) /\
            good_rhor Glob.mem{2} (to_uint rhotates_right{2}));
            first by  auto => />.
  call extr_bytes_corr; wp.
  ecall (avx2corr state{1} Glob.mem{2}); wp.
  while #pre.
  + swap {1} 4 2.
    wp.
    ecall (extr_full_block_corr (to_uint outlen0{2}) (to_uint rate{2}) (to_uint out0{2}) (to_uint iotas{2})
              (to_uint rhotates_left{2}) (to_uint rhotates_right{2}) (to_uint a_jagged{2})).
    wp; ecall (avx2corr state{1} Glob.mem{2}); auto => /> &1 &2 *.
    split; 1: smt (W64.ultE).
    move=> ? [o l] /> ?;rewrite !W64.ultE => *.
    rewrite W64.to_uint_eq W64.to_uintB 1:uleE 1://; smt(W64.to_uint_cmp).
  skip => /> &1 &2 *. smt(W64.ultE).
qed.

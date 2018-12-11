require import List Jasmin_model Int IntDiv IntExtra CoreMap.
import IterOp.
require import ChaCha20_Spec ChaCha20_pref ChaCha20_pref_proof ChaCha20_sref.
require import Array3 Array8 Array16.
require import WArray64.

(*
equiv init : ChaCha20_pref.M.init ~ ChaCha20_sref.M.init :
  ={key, nonce, counter, Glob.mem} ==>
  ={res}.
  proof.
  proc.
    seq 5 7 : (#pre /\ ={st}). wp. skip. progress.
  while (={i, st, nonce, Glob.mem} /\ 0 <= i{1}). wp. skip. progress. rewrite Array3.get_setE. smt(). smt(). smt().
    wp.
  while (={i, key, st, Glob.mem} /\ 0 <= i{1}). wp. skip. progress. rewrite Array8.get_setE. smt(). smt(). smt().
    wp. skip. progress.
  qed.
*)

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
  ={st} ==>
    res{1} = res{2}.`1.[15 <- res{2}.`2].
    (*res{1}.[0]  = res{2}.`1.[0] /\
    res{1}.[1]  = res{2}.`1.[1] /\
    res{1}.[2]  = res{2}.`1.[2] /\
    res{1}.[3]  = res{2}.`1.[3] /\
    res{1}.[4]  = res{2}.`1.[4] /\
    res{1}.[5]  = res{2}.`1.[5] /\
    res{1}.[6]  = res{2}.`1.[6] /\
    res{1}.[7]  = res{2}.`1.[7] /\
    res{1}.[8]  = res{2}.`1.[8] /\
    res{1}.[9]  = res{2}.`1.[9] /\
    res{1}.[10] = res{2}.`1.[10] /\
    res{1}.[11] = res{2}.`1.[11] /\
    res{1}.[12] = res{2}.`1.[12] /\
    res{1}.[13] = res{2}.`1.[13] /\
    res{1}.[14] = res{2}.`1.[14] /\
    res{1}.[15] = res{2}.`1.[15 <- res{2}.`2].[15].*)
  
  proof.
  proc => /=.
  seq 2 3 : (#pre /\ st{1} = k{1} /\ k.[15]{1} = s_k15{2}). wp. skip. progress.
    unroll for {2} 2. wp. skip. progress.
  (* ?? *)
qed.


equiv rounds : ChaCha20_pref.M.rounds ~ ChaCha20_sref.M.rounds :
  k{1} = k{2}.[15 <- k15{2}] ==>
  res{1} = res{2}.`1.[15 <- res{2}.`2].
proof.
  proc => /=.  
  admit.
qed.

equiv sum_states : ChaCha20_pref.M.sum_states ~ ChaCha20_sref.M.sum_states :
  ={st} /\ k{1} = k{2}.[15 <- k15{2}] ==>
  res{1} = res{2}.`1.[15 <- res{2}.`2].
proof.
  proc => /=.  
  admit.
qed.

equiv store len0 : ChaCha20_pref.M.store ~ ChaCha20_sref.M.store :
  ={Glob.mem} /\ output{1} = s_output{2} /\ plain{1} = s_plain{2} /\ len{1} = s_len{2} /\
  len{1} = len0 /\ k{1} = k{2}.[15 <- k15{2}] 
  ==>
  ={Glob.mem, res} /\ res{2}.`3 = len0 - W32.of_int 64.
proof.
  admit.
qed.

equiv store_last : ChaCha20_pref.M.store ~ ChaCha20_sref.M.store_last :
  ={Glob.mem} /\ output{1} = s_output{2} /\ plain{1} = s_plain{2} /\ len{1} = s_len{2} /\
  (len{1} \ult W32.of_int 64) /\ k{1} = k{2}.[15 <- k15{2}] 
  ==>
  ={Glob.mem} /\ res{1}.`3 = W32.of_int 0.
proof.
  admit.
qed.

equiv increment_counter: ChaCha20_pref.M.increment_counter ~ ChaCha20_sref.M.increment_counter :
  ={st} ==> ={res}.
proof.
  by proc;auto => /> &2;rewrite W32.WRingA.addrC.
qed.

equiv pref_sref : ChaCha20_pref.M.chacha20_ref ~ ChaCha20_sref.M.chacha20_ref : 
  ={output, plain, len, key, nonce,counter, Glob.mem} 
  ==>
  ={Glob.mem}.
proof.
proc => /=.
sp; seq 1 1 : (#pre /\ ={st}).
+ call init;skip => />.
splitwhile{1} 1 : (W32.of_int 64 \ule len).
seq 1 1 : (={st, Glob.mem} /\ 
           output{1} = s_output{2} /\ plain{1} = s_plain{2} /\ len{1} = s_len{2} /\
           len{1} \ult W32.of_int 64). 
+ while (={st, Glob.mem} /\ 
          output{1} = s_output{2} /\ plain{1} = s_plain{2} /\ len{1} = s_len{2}).
  + call increment_counter;ecall (store len{1}); call sum_states; call rounds; call copy_state.
    skip => /> &m; rewrite W32.ultE W32.uleE /= => h1 h2 [/=] />.
    by rewrite W32.uleE W32.ultE /= W32.to_uintB 1:W32.uleE //= /#.
  skip => /> &m;rewrite W32.uleE W32.ultE /=;split => [/# | s_len_R].
  rewrite !W32.uleE !W32.ultE /= /#.
unroll{1} 1.
seq 1 1 : (={Glob.mem} /\ len{1} = W32.of_int 0);last first.
+ by rcondf{1} 1; move=> *;skip => />.
if => //;last first.
+ skip => /> &m;rewrite !W32.ultE /= => ??.
  apply W32.to_uintRL => /=;rewrite modz_small 1://; smt (W32.to_uint_cmp).
inline{1}ChaCha20_pref.M.increment_counter;wp.
call store_last; call sum_states; call rounds; call copy_state;skip => />.
qed.

require import List Int IntExtra IntDiv CoreMap.
from Jasmin require import JModel.

require import Array5 Array24 Array25.
require import WArray40 WArray200.

require import Keccak1600_sscalar.
require Keccakf1600_sscalar.
require Keccak1600_pref_modular.
require Keccakf1600_pref_op.

module Mmod = {
  include Keccakf1600_sscalar.M

 proc spill_2 (a:W64.t, b:W64.t) : W64.t * W64.t = {
    
    var sa:W64.t;
    var sb:W64.t;
    
    sa <- a;
    sb <- b;
    return (sa, sb);
  }
  
  proc spill_3 (a:W64.t, b:W64.t, c:W64.t) : W64.t * W64.t * W64.t = {
    
    var sa:W64.t;
    var sb:W64.t;
    var sc:W64.t;
    
    sa <- a;
    sb <- b;
    sc <- c;
    return (sa, sb, sc);
  }
  
  proc load_2 (sa:W64.t, sb:W64.t) : W64.t * W64.t = {
    
    var a:W64.t;
    var b:W64.t;
    
    a <- sa;
    b <- sb;
    return (a, b);
  }
  
  proc load_3 (sa:W64.t, sb:W64.t, sc:W64.t) : W64.t * W64.t * W64.t = {
    
    var a:W64.t;
    var b:W64.t;
    var c:W64.t;
    
    a <- sa;
    b <- sb;
    c <- sc;
    return (a, b, c);
  }
  
  proc keccak_init () : W64.t Array25.t = {
    
    var state:W64.t Array25.t;
    var t:W64.t;
    var i:W64.t;
    var  _0:bool;
    var  _1:bool;
    var  _2:bool;
    var  _3:bool;
    var  _4:bool;
    state <- witness;
    ( _0,  _1,  _2,  _3,  _4, t) <- set0_64 ;
    i <- (W64.of_int 0);
    
    while ((i \ult (W64.of_int 25))) {
      state.[(W64.to_uint i)] <- t;
      i <- (i + (W64.of_int 1));
    }
    return (state);
  }
  
  proc add_full_block (state:W64.t Array25.t, in_0:W64.t, inlen:W64.t,
                       rate:W64.t) : W64.t Array25.t * W64.t * W64.t = {
    
    var rate64:W64.t;
    var i:W64.t;
    var t:W64.t;
    
    rate64 <- rate;
    rate64 <- (rate64 `>>` (W8.of_int 3));
    i <- (W64.of_int 0);
    
    while ((i \ult rate64)) {
      t <- (loadW64 Glob.mem (W64.to_uint (in_0 + ((W64.of_int 8) * i))));
      state.[(W64.to_uint i)] <- (state.[(W64.to_uint i)] `^` t);
      i <- (i + (W64.of_int 1));
    }
    in_0 <- (in_0 + rate);
    inlen <- (inlen - rate);
    return (state, in_0, inlen);
  }
  
  proc add_final_block (state:W64.t Array25.t, in_0:W64.t, inlen:W64.t,
                        trail_byte:W8.t, rate:W64.t) : W64.t Array25.t = {
    
    var inlen8:W64.t;
    var i:W64.t;
    var t:W64.t;
    var c:W8.t;
    
    inlen8 <- inlen;
    inlen8 <- (inlen8 `>>` (W8.of_int 3));
    i <- (W64.of_int 0);
    
    while ((i \ult inlen8)) {
      t <- (loadW64 Glob.mem (W64.to_uint (in_0 + ((W64.of_int 8) * i))));
      state.[(W64.to_uint i)] <- (state.[(W64.to_uint i)] `^` t);
      i <- (i + (W64.of_int 1));
    }
    i <- (i `<<` (W8.of_int 3));
    
    while ((i \ult inlen)) {
      c <- (loadW8 Glob.mem (W64.to_uint (in_0 + i)));
      state =
      Array25.init
      (WArray200.get64 (WArray200.set8 (WArray200.init64 (fun i => state.[i])) (W64.to_uint i) (
      (get8 (WArray200.init64 (fun i => state.[i])) (W64.to_uint i)) `^` c)));
      i <- (i + (W64.of_int 1));
    }
    state =
    Array25.init
    (WArray200.get64 (WArray200.set8 (WArray200.init64 (fun i => state.[i])) (W64.to_uint i) (
    (get8 (WArray200.init64 (fun i => state.[i])) (W64.to_uint i)) `^` trail_byte)));
    i <- rate;
    i <- (i - (W64.of_int 1));
    state =
    Array25.init
    (WArray200.get64 (WArray200.set8 (WArray200.init64 (fun i => state.[i])) (W64.to_uint i) (
    (get8 (WArray200.init64 (fun i => state.[i])) (W64.to_uint i)) `^` (W8.of_int 128))));
    return (state);
  }
  
  proc absorb (state:W64.t Array25.t, iotas:W64.t, in_0:W64.t, inlen:W64.t,
               s_trail_byte:W64.t, rate:W64.t) : W64.t Array25.t * W64.t *
                                                 W64.t = {
    
    var s_in:W64.t;
    var s_inlen:W64.t;
    var s_rate:W64.t;
    var t:W64.t;
    var trail_byte:W8.t;
    
    
    while ((rate \ule inlen)) {
      (state, in_0, inlen) <@ add_full_block (state, in_0, inlen, rate);
      (s_in, s_inlen, s_rate) <@ spill_3 (in_0, inlen, rate);
      (state, iotas) <@ __keccakf1600_scalar (state, iotas);
      (in_0, inlen, rate) <@ load_3 (s_in, s_inlen, s_rate);
    }
    t <- s_trail_byte;
    trail_byte <- (truncateu8 t);
    state <@ add_final_block (state, in_0, inlen, trail_byte, rate);
    return (state, iotas, rate);
  }
  
  proc xtr_full_block (state:W64.t Array25.t, out:W64.t, outlen:W64.t,
                       rate:W64.t) : W64.t * W64.t = {
    
    var rate64:W64.t;
    var i:W64.t;
    var t:W64.t;
    
    rate64 <- rate;
    rate64 <- (rate64 `>>` (W8.of_int 3));
    i <- (W64.of_int 0);
    
    while ((i \ult rate64)) {
      t <- state.[(W64.to_uint i)];
      Glob.mem <-
      storeW64 Glob.mem (W64.to_uint (out + ((W64.of_int 8) * i))) t;
      i <- (i + (W64.of_int 1));
    }
    out <- (out + rate);
    outlen <- (outlen - rate);
    return (out, outlen);
  }
  
  proc xtr_bytes (state:W64.t Array25.t, out:W64.t, outlen:W64.t) : W64.t = {
    
    var outlen8:W64.t;
    var i:W64.t;
    var t:W64.t;
    var c:W8.t;
    
    outlen8 <- outlen;
    outlen8 <- (outlen8 `>>` (W8.of_int 3));
    i <- (W64.of_int 0);
    
    while ((i \ult outlen8)) {
      t <- state.[(W64.to_uint i)];
      Glob.mem <-
      storeW64 Glob.mem (W64.to_uint (out + ((W64.of_int 8) * i))) t;
      i <- (i + (W64.of_int 1));
    }
    i <- (i `<<` (W8.of_int 3));
    
    while ((i \ult outlen)) {
      c <- (get8 (WArray200.init64 (fun i => state.[i])) (W64.to_uint i));
      Glob.mem <- storeW8 Glob.mem (W64.to_uint (out + i)) c;
      i <- (i + (W64.of_int 1));
    }
    out <- (out + outlen);
    return (out);
  }
  
  proc squeeze (state:W64.t Array25.t, iotas:W64.t, s_out:W64.t,
                outlen:W64.t, rate:W64.t) : unit = {
    
    var s_outlen:W64.t;
    var s_rate:W64.t;
    var out:W64.t;
    
    
    while ((rate \ult outlen)) {
      (s_outlen, s_rate) <@ spill_2 (outlen, rate);
      (state, iotas) <@ __keccakf1600_scalar (state, iotas);
      (out, outlen, rate) <@ load_3 (s_out, s_outlen, s_rate);
      (out, outlen) <@ xtr_full_block (state, out, outlen, rate);
      s_out <- out;
    }
    s_outlen <- outlen;
    (state, iotas) <@ __keccakf1600_scalar (state, iotas);
    (out, outlen) <@ load_2 (s_out, s_outlen);
    out <@ xtr_bytes (state, out, outlen);
    return ();
  }
  
  proc __keccak1600_scalar (s_out:W64.t, s_outlen:W64.t, iotas:W64.t, in_0:W64.t,
                      inlen:W64.t, s_trail_byte:W64.t, rate:W64.t) : unit = {
    
    var state:W64.t Array25.t;
    var outlen:W64.t;
    state <- witness;
    state <@ keccak_init ();
    (state, iotas, rate) <@ absorb (state, iotas, in_0, inlen, s_trail_byte,
    rate);
    outlen <- s_outlen;
    squeeze (state, iotas, s_out, outlen, rate);
    return ();
  }

}.

equiv modgood :
  Mmod.__keccak1600_scalar ~ M.__keccak1600_scalar :
   ={Glob.mem,arg} ==> ={Glob.mem,res}.
proc.
by sim.
qed.

require Keccakf1600_pscalar_table.

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

equiv eq_xtr_full_block iotas0: 
  Keccak1600_pref_modular.Mmod.xtr_full_block ~ Mmod.xtr_full_block :
     ={Glob.mem, state, out, outlen, rate} /\ 
     disj_ptr (to_uint out{1}) (to_uint outlen{1}) iotas0 224 /\ 
     good_ptr (to_uint out{1}) (to_uint outlen{1}) /\ rate{1} \ult outlen{1} /\
     Keccakf1600_pscalar_table.good_iotas Glob.mem{1} iotas0 
   ==>
     ={Glob.mem, res} /\ 
     disj_ptr (to_uint res{1}.`1) (to_uint res{2}.`2) iotas0 224 /\ 
     good_ptr (to_uint res{1}.`1) (to_uint res{2}.`2) /\ 
     Keccakf1600_pscalar_table.good_iotas Glob.mem{1} iotas0.
proof.
  proc; wp => /=.
  while (#pre /\ ={i,rate64} /\ 0 <= to_uint i{1} /\ 0 <= 8 * to_uint rate64{1} <= to_uint rate{1}).
  + wp; skip => /> &2.
    rewrite !ultE /good_ptr /disj_ptr /= => h1 h2 h3 h4 h5 h6 h7 h8; split.
    + move=> x hx; rewrite loadW64_storeW64_diff; last by rewrite h4.
      have h : to_uint (W64.of_int 8 * i{2}) = 8 * to_uint i{2}.
      + rewrite W64.to_uintM_small /=; smt (W64.to_uint_cmp). 
      rewrite W64.to_uintD_small h /=; smt().
    rewrite W64.to_uintD_small /=; smt (W64.to_uint_cmp).
  wp; skip => /> &2.
  rewrite /W64.(`>>`) /= W64.to_uint_shr 1:// /good_ptr /disj_ptr /= !ultE => h1 h2 h3 h4.
  split; 1: smt(W64.to_uint_cmp).
  by move=> mem *; rewrite W64.to_uintD_small /= 1:/# W64.to_uintB 1:uleE /#.
qed.

equiv modcorrect :
  Keccak1600_pref_modular.Mmod.__keccak1600_ref ~ Mmod.__keccak1600_scalar :
     Keccakf1600_pscalar_table.good_iotas Glob.mem{1} (to_uint iotas{2}) /\ 
     0 <= to_uint iotas{2} < W64.modulus - 24 * 8 /\
     (to_uint iotas{2} - 8 * 8) %% 256 = 0 /\
     disj_ptr (to_uint s_out{1}) (to_uint s_outlen{1}) (to_uint iotas{2}) 224 /\ 
     good_ptr (to_uint s_out{1}) (to_uint s_outlen{1}) /\
     in_0{1} = in_0{2} /\ inlen{1} = inlen{2} /\ s_out{1} = s_out{2} /\ s_outlen{1} = s_outlen{2} /\ rate{1} = rate{2} /\
            s_trail_byte{1} = s_trail_byte{2} /\ ={Glob.mem}  ==> ={Glob.mem}.
proof.
proc => /=.
seq 2 2 : (#pre /\ ={state}).
  call(_:true); last by auto.
+ while (#post /\ to_uint i{2} = i{1} /\ i{2} \ule W64.of_int 25 /\ t{2} = W64.zero).
  + auto => /> &2; rewrite !ultE !uleE/= => *.
    rewrite W64.to_uintD_small /= 1,2:/#.
  by auto => />; rewrite set0_64E => />.
seq 4 1 : #{/~in_0{1} = in_0{2}}{~inlen{1} = inlen{2}}pre.
+ inline Mmod.absorb.
  swap {2} [5..6] -2; swap {2} [2..4] -1; sp 0 3.
  seq 0 3 : (#{/~state{1} = state{2}}{/~in_0{1} = in_0{2}}{~inlen{1} = inlen{2}}pre /\ state0{2} = state{1} /\ inlen0{2} = inlen{1} /\ in_00{2} = in_0{1}); first by auto => />.
  seq 1 1 : #pre.
  + while (#post); last by auto.
    inline Mmod.load_3 Mmod.spill_3; wp.
    exlim Glob.mem{2}, iotas0{2} => memm _iotas.
    call (Keccakf1600_pscalar_table.scalarcorr_op (to_uint _iotas) memm).
    wp; call (_: ={Glob.mem}); first by sim.
    by auto => />; smt(@W64).
  wp; call (_: ={Glob.mem}); first by sim.
  by auto => />.
inline Mmod.squeeze.
swap {2} 6 -2; swap {2} [3..4] -2; sp 0 2.
seq 1 4 : (#{/~state{1} = state{2}}{~s_out{1} = s_out{2}}{~s_outlen{1} = s_outlen{2}}{~disj_ptr _ _ _ _}{~good_ptr _ _} pre /\ 
             state0{2} = state{1} /\ outlen0{2} = outlen{1} /\ s_out0{2} = s_out{1} /\
             disj_ptr (to_uint s_out{1}) (to_uint outlen{1}) (to_uint iotas{2}) 224 /\
            good_ptr (to_uint s_out{1}) (to_uint outlen{1}) /\
             Keccakf1600_pscalar_table.good_iotas Glob.mem{1} (to_uint iotas{2})); first by auto => />.
seq 1 1 : #pre.
+ while (#post); last by auto.
  inline Mmod.load_3 Mmod.spill_2.
  wp; ecall (eq_xtr_full_block (to_uint iotas{2})).
  wp; ecall (Keccakf1600_pscalar_table.scalarcorr_op (to_uint iotas{2}) Glob.mem{1}).
  by wp;skip => /> *; rewrite W64.to_uint_eq.
seq 2 2 : (#pre /\ s_outlen{1} = s_outlen0{2}).
+ ecall (Keccakf1600_pscalar_table.scalarcorr_op (to_uint iotas0{2}) Glob.mem{2}).
  by wp;skip=> />; smt(@W64). 
inline *.
sim.
qed.

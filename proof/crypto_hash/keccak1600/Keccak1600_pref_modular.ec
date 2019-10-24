require import List Int IntExtra IntDiv CoreMap.
from Jasmin require import JModel.

require import Array5 Array24 Array25.
require import WArray40 WArray192 WArray200.

require import Keccakf1600_sref.

module Mmod = {
  include  Keccakf1600_sref.M

  proc st0 () : W64.t Array25.t = {
    var aux: int;
    
    var state:W64.t Array25.t;
    var i:int;
    state <- witness;
    i <- 0;
    while (i < 25) {
      state.[i] <- (W64.of_int 0);
      i <- i + 1;
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
                        trail_byte:W8.t, r8:W64.t) : W64.t Array25.t = {
    
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
    i <- r8;
    i <- (i - (W64.of_int 1));
    state =
    Array25.init
    (WArray200.get64 (WArray200.set8 (WArray200.init64 (fun i => state.[i])) (W64.to_uint i) (
    (get8 (WArray200.init64 (fun i => state.[i])) (W64.to_uint i)) `^` (W8.of_int 128))));
    return (state);
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
  
  proc xtr_bytes (state:W64.t Array25.t, out:W64.t, outlen:W64.t) : unit = {
    
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
    return ();
  }
  
  proc __keccak1600_ref (s_out:W64.t, s_outlen:W64.t, in_0:W64.t, inlen:W64.t,
                          s_trail_byte:W64.t, rate:W64.t) : unit = {
    
    var state:W64.t Array25.t;
    var s_in:W64.t;
    var s_inlen:W64.t;
    var s_rate:W64.t;
    var t:W64.t;
    var trail_byte:W8.t;
    var outlen:W64.t;
    var out:W64.t;
    state <- witness;
    state <@ st0 ();
    
    while ((rate \ule inlen)) {
      (state, in_0, inlen) <@ add_full_block (state, in_0, inlen, rate);
      s_in <- in_0;
      s_inlen <- inlen;
      s_rate <- rate;
      state <@ __keccakf1600_ref (state);
      inlen <- s_inlen;
      in_0 <- s_in;
      rate <- s_rate;
    }
    t <- s_trail_byte;
    trail_byte <- (truncateu8 t);
    state <@ add_final_block (state, in_0, inlen, trail_byte, rate);
    outlen <- s_outlen;
    
    while ((rate \ult outlen)) {
      s_outlen <- outlen;
      s_rate <- rate;
      state <@ __keccakf1600_ref (state);
      out <- s_out;
      outlen <- s_outlen;
      rate <- s_rate;
      (out, outlen) <@ xtr_full_block (state, out, outlen, rate);
      s_out <- out;
    }
    s_outlen <- outlen;
    state <@ __keccakf1600_ref (state);
    out <- s_out;
    outlen <- s_outlen;
    xtr_bytes (state, out, outlen);
    return ();
  }

}.


require import Keccak1600_sref.

equiv modfgood :
  Mmod.__keccakf1600_ref ~ M.__keccakf1600_ref:
   ={Glob.mem,arg} ==> ={Glob.mem,res}.
proc.
by sim.
qed.

(* TODO: CHECKME: Is this really necessary? Maybe I'm missing something...
while (#post /\ ={constants,round}).
wp.
call(_: ={Glob.mem}).
call(_: ={Glob.mem}); first by sim.
call(_: ={Glob.mem}); first by sim.
call(_: ={Glob.mem}); first by sim.
call(_: ={Glob.mem}); first by sim.
call(_: ={Glob.mem}).
seq 4 4 : (#pre /\ ={c}); first by sim.
seq 2 2 : (#pre /\ ={d}).
unroll for {1} 2.
unroll for {2} 2.
auto => />. move => &1 &2. apply Array5.ext_eq. smt(@Array5).
by sim.
by auto => />.
by auto => />.
by inline *; auto => />.
qed. 
*)

equiv modgood :
  Mmod.__keccak1600_ref ~ M.__keccak1600_ref :
   ={Glob.mem,arg} ==> ={Glob.mem,res}.
proc.
by sim.
qed.

(** TODO CHECKME: (Same as above)
call(_: ={Glob.mem}); first by sim.
wp;call(modfgood).
wp.
while(#post /\ ={rate,s_out,outlen,rate}).
wp;call(_: ={Glob.mem}); first by sim.
wp;call(modfgood).
by wp;skip;auto => />. 
wp;call(_: ={Glob.mem}); first by sim.
wp.
while(#post /\ ={rate,in_0,inlen,s_outlen,s_out,rate}).
wp.
call(modfgood).
wp;call(_: ={Glob.mem}); first by sim.
by wp;skip;auto => />. 
by inline *;auto => />;sim.
qed.
**)


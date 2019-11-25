require import List Int IntExtra IntDiv CoreMap.
from Jasmin require import JModel.

 require import Array5 Array24 Array25.
require import WArray40 WArray192 WArray200. 

require import Keccakf1600_pref_table.
import Keccakf1600_pref_op.
import Ops.

module Mrefloop2 = {
  include Mreftable [-__keccakf1600_ref]

  proc __keccakf1600_ref (state:W64.t Array25.t) : W64.t Array25.t = {
    var aux: int;
    
    var constants:W64.t Array24.t;
    var round:int;
    constants <- witness;
    constants <@ keccakRoundConstants ();
    round <- 0;
    state <@ keccakP1600_round (state, constants.[round]);
    round <- round + 1;
    state <@ keccakP1600_round (state, constants.[round]);
    round <- round + 1;
    while (round < 24) {
      state <@ keccakP1600_round (state, constants.[round]);
      state <@ keccakP1600_round (state, constants.[round + 1]);
      round <- round + 2;
    }
    return (state);
  }
}.

require import LoopTransform.

clone import ExactIter with
   type t = (W64.t Array25.t * W64.t Array24.t).

module ExplBody : AdvLoop = {
   include Mreftable [-__keccakf1600_ref]
   proc body(st : t,i : int) = {
       var rst;
       rst <@ keccakP1600_round(st.`1,st.`2.[i]);
       return (rst,st.`2);
   }
}.

module Mrefloop = {
   include ExplBody
   include Loop(ExplBody) [loop1]

  proc __keccakf1600_ref (state:W64.t Array25.t) : W64.t Array25.t = {
    var aux: int;
    
    var constants:W64.t Array24.t;
    var round:int;
    constants <- witness;
    constants <@ keccakRoundConstants ();
    (state,constants) <@ loop1((state,constants),24);
    return (state);
  }

}.

module Mrefloopk = {
   include ExplBody
   include Loop(ExplBody) [loopk]

  proc __keccakf1600_ref (state:W64.t Array25.t) : W64.t Array25.t = {
    var aux: int;
    
    var constants:W64.t Array24.t;
    var round:int;
    constants <- witness;
    constants <@ keccakRoundConstants ();
    (state,constants) <@ loopk((state,constants),12,2);
    return (state);
  }
}.

lemma reftable_refloop : 
  equiv   [ Mreftable.__keccakf1600_ref ~ Mrefloop.__keccakf1600_ref :
          ={arg,Glob.mem} ==> ={res,Glob.mem} ].
proc.
inline Mrefloop.loop1.
inline ExplBody.body.
wp. 
while (={Glob.mem} /\ (state{1},constants{1}) = t{2} /\ round{1} = i{2} /\ n{2} = 24). 
wp; call(_:true); first by sim.
by auto => />.
wp; call(_:true); first by sim.
by auto => />.
qed.

lemma refloop_refloopk : 
  equiv   [ Mrefloop.__keccakf1600_ref ~ Mrefloopk.__keccakf1600_ref :
          ={arg,Glob.mem} ==> ={res,Glob.mem} ].
proc.
call (loop1_loopk ExplBody).
 call(_:true); first by sim.
by auto => />.
qed.


lemma refloopk_refloop2 : 
  equiv   [ Mrefloopk.__keccakf1600_ref ~ Mrefloop2.__keccakf1600_ref :
          ={arg,Glob.mem} ==> ={res,Glob.mem} ].

proc.
seq 2 2 : (#pre /\ ={constants}); first by sim.
inline  Mrefloopk.loopk.

unroll {1} 5.
rcondt {1} 5; first by move => *; auto => />.

unroll {1} 6.
rcondt {1} 6; first by move => *; auto => />.

seq 7 3 : (#{/~state{1}}pre /\ (state{2},constants{2}) = t{1} /\ k{1} = 2 /\ n{1} = 12 /\ j{1} = 1 /\ i{1} = 0 /\ round{2} = 1).
inline ExplBody.body.
wp; call(_:true); first by sim.
by auto => />.


unroll {1} 1.
rcondt {1} 1; first by move => *; auto => />.

seq 2 2 : (#{/~j{1} = 1}{~round{2}=1}pre /\ j{1} = 2 /\ round{2} = 2).
inline ExplBody.body.
wp; call(_:true); first by sim.
by auto => />. 

seq 1 0 : #pre. while {1} (j{1} = 2 /\ k{1} = 2 /\ (state{2},constants{2}) = t{1} ) 1. move => *. exfalso.  smt(). 
by auto => />.

seq 1 0 : (#{/~j{1}}{~i{1}}pre /\ i{1} = 1); first by auto => />.
wp.
while (={Glob.mem} /\
       ={constants} /\
      (state{2}, constants{2}) = t{1} /\ 
       k{1} = 2 /\ n{1} = 12 /\ 
       round{2} = 2*i{1}). 

unroll {1} 2.
rcondt {1} 2; first by move => *; auto => />.

seq 3 1 : (#pre /\ j{1} = 1).
inline ExplBody.body.
wp; call(_:true); first by sim.
by auto => />. 

unroll {1} 1.
rcondt {1} 1; first by move => *; auto => />.

seq 2 1 : (#{/~ j{1} = 1}pre /\ j{1} = 2).
inline ExplBody.body.
wp; call(_:true); first by sim.
by auto => />. 

seq 1 0 : #pre. while {1} (j{1} = 2 /\ k{1} = 2 /\ (state{2},constants{2}) = t{1} ) 1. move => *. exfalso.  smt(). 
by auto => />.

by auto => />; smt().

by auto => />.

qed.


require import List Int IntExtra IntDiv CoreMap.
from Jasmin require import JModel.

require import Array24 Array25.
require import Keccakf1600_pref_op.
import Ops.

op rhotates(i : int) : int = ((
  witness
     .[0  <- 0 ]
     .[1  <- 1 ]
     .[2  <- 62]
     .[3  <- 28]
     .[4  <- 27]
     .[5  <- 36]
     .[6  <- 44]
     .[7  <- 6 ]
     .[8  <- 55]
     .[9  <- 20]
     .[10 <- 3 ]
     .[11 <- 10]
     .[12 <- 43]
     .[13 <- 25]
     .[14 <- 39]
     .[15 <- 41]
     .[16 <- 45]
     .[17 <- 15]
     .[18 <- 21]
     .[19 <- 8 ]
     .[20 <- 18]
     .[21 <- 2 ]
     .[22 <- 61]
     .[23 <- 56]
     .[24 <- 14])%Array25).[i].

module RhotatesAlgo = {
  include Mrefop [keccakRhoOffsets]
}.

module RhotatesTable = {
  proc keccakRhoOffsets (i:int) : int = {
    return rhotates(i);
  }
}.

equiv rhotates_table_corr :
  RhotatesAlgo.keccakRhoOffsets ~ RhotatesTable.keccakRhoOffsets :
       ={arg} /\ 0 <= i{1} < 25 ==> ={res} .
proc.
unroll for {1} 5.

case (i{1} = 0).
do !((rcondt {1} ^if; first by move => *; auto => />) ||
    (rcondf {1} ^if; first by move => *; auto => />)); auto => />.

case (i{1} = 1).
do !((rcondt {1} ^if; first by move => *; auto => />) ||
    (rcondf {1} ^if; first by move => *; auto => />)); auto => />.

case (i{1} = 2).
do !((rcondt {1} ^if; first by move => *; auto => />) ||
    (rcondf {1} ^if; first by move => *; auto => />)); auto => />.

case (i{1} = 3).
do !((rcondt {1} ^if; first by move => *; auto => />) ||
    (rcondf {1} ^if; first by move => *; auto => />)); auto => />.

case (i{1} = 4).
do !((rcondt {1} ^if; first by move => *; auto => />) ||
    (rcondf {1} ^if; first by move => *; auto => />)); auto => />.

case (i{1} = 5).
do !((rcondt {1} ^if; first by move => *; auto => />) ||
    (rcondf {1} ^if; first by move => *; auto => />)); auto => />.

case (i{1} = 6).
do !((rcondt {1} ^if; first by move => *; auto => />) ||
    (rcondf {1} ^if; first by move => *; auto => />)); auto => />.

case (i{1} = 7).
do !((rcondt {1} ^if; first by move => *; auto => />) ||
    (rcondf {1} ^if; first by move => *; auto => />)); auto => />.

case (i{1} = 8).
do !((rcondt {1} ^if; first by move => *; auto => />) ||
    (rcondf {1} ^if; first by move => *; auto => />)); auto => />.

case (i{1} = 9).
do !((rcondt {1} ^if; first by move => *; auto => />) ||
    (rcondf {1} ^if; first by move => *; auto => />)); auto => />.

case (i{1} = 10).
do !((rcondt {1} ^if; first by move => *; auto => />) ||
    (rcondf {1} ^if; first by move => *; auto => />)); auto => />.

case (i{1} = 11).
do !((rcondt {1} ^if; first by move => *; auto => />) ||
    (rcondf {1} ^if; first by move => *; auto => />)); auto => />.

case (i{1} = 12).
do !((rcondt {1} ^if; first by move => *; auto => />) ||
    (rcondf {1} ^if; first by move => *; auto => />)); auto => />.

case (i{1} = 13).
do !((rcondt {1} ^if; first by move => *; auto => />) ||
    (rcondf {1} ^if; first by move => *; auto => />)); auto => />.

case (i{1} = 14).
do !((rcondt {1} ^if; first by move => *; auto => />) ||
    (rcondf {1} ^if; first by move => *; auto => />)); auto => />.

case (i{1} = 15).
do !((rcondt {1} ^if; first by move => *; auto => />) ||
    (rcondf {1} ^if; first by move => *; auto => />)); auto => />.

case (i{1} = 16).
do !((rcondt {1} ^if; first by move => *; auto => />) ||
    (rcondf {1} ^if; first by move => *; auto => />)); auto => />.

case (i{1} = 17).
do !((rcondt {1} ^if; first by move => *; auto => />) ||
    (rcondf {1} ^if; first by move => *; auto => />)); auto => />.

case (i{1} = 18).
do !((rcondt {1} ^if; first by move => *; auto => />) ||
    (rcondf {1} ^if; first by move => *; auto => />)); auto => />.

case (i{1} = 19).
do !((rcondt {1} ^if; first by move => *; auto => />) ||
    (rcondf {1} ^if; first by move => *; auto => />)); auto => />.

case (i{1} = 20).
do !((rcondt {1} ^if; first by move => *; auto => />) ||
    (rcondf {1} ^if; first by move => *; auto => />)); auto => />.

case (i{1} = 21).
do !((rcondt {1} ^if; first by move => *; auto => />) ||
    (rcondf {1} ^if; first by move => *; auto => />)); auto => />.

case (i{1} = 22).
do !((rcondt {1} ^if; first by move => *; auto => />) ||
    (rcondf {1} ^if; first by move => *; auto => />)); auto => />.

case (i{1} = 23).
do !((rcondt {1} ^if; first by move => *; auto => />) ||
    (rcondf {1} ^if; first by move => *; auto => />)); auto => />.

case (i{1} = 24).
do !((rcondt {1} ^if; first by move => *; auto => />) ||
    (rcondf {1} ^if; first by move => *; auto => />)); auto => />.

by exfalso; smt().
qed.

module Mreftable = {
  include Mrefop [-keccakRhoOffsets,rho,keccakP1600_round,__keccakf1600_ref]
  include RhotatesTable
  
  proc rho (a:W64.t Array25.t) : W64.t Array25.t = {
    var aux_1: bool;
    var aux_0: bool;
    var aux: int;
    var aux_2: W64.t;
    
    var x:int;
    var y:int;
    var i:int;
    var z:int;
    var  _0:bool;
    var  _1:bool;
    
    x <- 0;
    while (x < 5) {
      y <- 0;
      while (y < 5) {
        i <@ index (x, y);
        z <@ keccakRhoOffsets (i);
        (aux_1, aux_0, aux_2) <- x86_ROL_64 a.[i] (W8.of_int z);
         _0 <- aux_1;
         _1 <- aux_0;
        a.[i] <- aux_2;
        y <- y + 1;
      }
      x <- x + 1;
    }
    return (a);
  }
 
  proc keccakP1600_round (state:W64.t Array25.t, c:W64.t) : W64.t Array25.t = {
    state <@ theta (state);
    state <@ rho (state);
    state <@ pi (state);
    state <@ chi (state);
    state <@ iota_0 (state, c);
    return (state);
  }

  proc __keccakf1600_ref (state:W64.t Array25.t) : W64.t Array25.t = {
    var aux: int;
    
    var constants:W64.t Array24.t;
    var round:int;
    round <- 0;
    constants <@ keccakRoundConstants ();
    while (round < 24) {
      state <@ keccakP1600_round (state, constants.[round]);
      round <- round + 1;
    }
    return (state);
  } 

}.

lemma ref_reftable : 
  equiv   [ Mrefop.__keccakf1600_ref ~ Mreftable.__keccakf1600_ref :
          ={arg,Glob.mem} ==> ={res,Glob.mem} ].
proc.

seq 3 2 : (#pre /\ ={constants} /\ ={round}); first by inline*; auto => />.

while (#post /\ ={round,constants}); last by inline *; auto => />.

wp.
call (_: true).
call (_: true); first by sim.
call (_: true); first by sim.
call (_: true); first by sim.
call (_: true).
while (#post /\ ={a,x} /\ 0 <= x{1} <= 5).
wp.
while (#post /\ ={a,x,y} /\ 0 <= x{1} <5 /\ 0 <=y{1} <= 5).
wp.
call (rhotates_table_corr).

call(_: ={arg} /\ 0<=x{1} <5 /\  0<=y{1} <5  ==> ={res} /\ 0 <= res{1} < 25).
by proc; inline *; auto => />;smt().

by auto => />;smt(). 
by auto => />;smt().
by auto => />;smt().

call(_:true); first by sim.
by auto => />.
by auto => />.

qed.

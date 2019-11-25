require import List Int IntExtra IntDiv CoreMap.
from Jasmin require import JModel.

require import Array5 Array24 Array25.
require import WArray40 WArray192 WArray200.
require import Ops.
require import Keccakf1600_sref.

op iotas : W64.t Array24.t = ((
  witness
     .[0 <-  W64.one]
     .[1 <-  W64.of_int 32898]
     .[2 <-  W64.of_int 9223372036854808714]
     .[3 <-  W64.of_int 9223372039002292224]
     .[4 <-  W64.of_int 32907]
     .[5 <-  W64.of_int 2147483649]
     .[6 <-  W64.of_int 9223372039002292353]
     .[7 <-  W64.of_int 9223372036854808585]
     .[8 <-  W64.of_int 138]
     .[9 <-  W64.of_int 136]
     .[10 <- W64.of_int 2147516425]
     .[11 <- W64.of_int 2147483658]
     .[12 <- W64.of_int 2147516555]
     .[13 <- W64.of_int 9223372036854775947]
     .[14 <- W64.of_int 9223372036854808713]
     .[15 <- W64.of_int 9223372036854808579]
     .[16 <- W64.of_int 9223372036854808578]
     .[17 <- W64.of_int 9223372036854775936]
     .[18 <- W64.of_int 32778]
     .[19 <- W64.of_int 9223372039002259466]
     .[20 <- W64.of_int 9223372039002292353]
     .[21 <- W64.of_int 9223372036854808704]
     .[22 <- W64.of_int 2147483649]
     .[23 <- W64.of_int 9223372039002292232])%Array24).

module Mrefop = {
  include M [-keccakRoundConstants,__keccakf1600_ref]
  
  proc keccakRoundConstants () : W64.t Array24.t = {
    return iotas;
  }
  
  proc __keccakf1600_ref (state:W64.t Array25.t) : W64.t Array25.t = {
    var aux: int;
    
    var constants:W64.t Array24.t;
    var round:int;
    constants <- witness;
    constants <@ keccakRoundConstants ();
    round <- 0;
    while (round < 24) {
      state <@ keccakP1600_round (state, constants.[round]);
      round <- round + 1;
    }
    return (state);
  }
}.

equiv ref_refop : 
   M.__keccakf1600_ref ~ Mrefop.__keccakf1600_ref :
     ={Glob.mem,arg} ==> ={Glob.mem,res}.
proc.
seq 3 3 : (#pre /\ ={round, constants}).
by inline *;auto => />.
by sim.
qed.

require import AllCore List Int IntDiv IntExtra StdOrder Distr SmtMap FSet.

require import Common Sponge. import BIRO.
require (*--*) SLCommon Gconcl_list BlockSponge.
require import SHA3Indiff.

(* FIX: would be nicer to define limit at top-level and then clone
   BlockSponge with it - so BlockSponge would then clone lower-level
   theories with it

op limit : {int | 0 < limit} as gt0_max_limit.
*)

require (****) OptionIndifferentiability.

clone import OptionIndifferentiability as OIndif with
  type p <- state,
  type f_out <- bool list,
  type f_in <- bool list * int
proof *.


module FSome (F : FUNCTIONALITY) : OFUNCTIONALITY = {
  proc init = F.init
  proc f (x: bool list * int) : bool list option = {
    var z;
    z <@ F.f(x);
    return Some z;
  }
}.

module PSome (P : PRIMITIVE) : OPRIMITIVE = {
  proc init = P.init
  proc f (x : state) : state option = {
    var z;
    z <@ P.f(x);
    return Some z;
  }
  proc fi (x: state) : state option = {
    var z;
    z <@ P.fi(x);
    return Some z;
  }
}.

module Poget (P : ODPRIMITIVE) : DPRIMITIVE = {
  proc f (x : state) : state = {
    var z;
    z <@ P.f(x);
    return oget z;
  }
  proc fi (x: state) : state = {
    var z;
    z <@ P.fi(x);
    return oget z;
  }
}.

module (CSome (C : CONSTRUCTION) : OCONSTRUCTION) (P : ODPRIMITIVE) = FSome(C(Poget(P))).

module OSimulator (F : ODFUNCTIONALITY) = {
  proc init() = {
    Simulator.m <- empty;
    Simulator.mi <- empty;
    Simulator.paths <- empty.[c0 <- ([],b0)];
    Gconcl_list.BIRO2.IRO.init();
  }
  proc f (x : state) : state option = {
    var p,v,z,q,k,cs,y,y1,y2,o;
    if (x \notin Simulator.m) {
      if (x.`2 \in Simulator.paths) {
        (p,v) <- oget Simulator.paths.[x.`2];
        z <- [];
        (q,k) <- parse (rcons p (v +^ x.`1));
        if (valid q) {
          o <@ F.f(oget (unpad_blocks q), k * r);
          cs <- oget o;
          z <- bits2blocks cs;
        } else {
          z <- Gconcl_list.BIRO2.IRO.f(q,k);
        }
        y1 <- last b0 z;
      } else {
        y1 <$ bdistr;
      }
      y2 <$ cdistr;
      y <- (y1,y2);
      Simulator.m.[x]  <- y;
      Simulator.mi.[y] <- x;
      if (x.`2 \in Simulator.paths) {
        (p,v) <-oget Simulator.paths.[x.`2];
        Simulator.paths.[y2] <- (rcons p (v +^ x.`1),y.`1);
      }
    } else {
      y <- oget Simulator.m.[x];
    }
    return Some y;
  }
  proc fi (x : state) : state option = {
    var y,y1,y2;
    if (! x \in Simulator.mi) {
      y1 <$ bdistr;
      y2 <$ cdistr;
      y <- (y1,y2);
      Simulator.mi.[x] <- y;
      Simulator.m.[y]  <- x;
    } else {
      y <- oget Simulator.mi.[x];
    }
    return Some y;
  }
}.


module Counter = {
  var c : int
  proc init () = {
    c <- 0;
  }
}.

op increase_counter c (l : 'a list) n = 
  c + ((size l + 1) %/ r + 1) + max ((n + r - 1) %/ r - 1) 0.


module OFC (F : ODFUNCTIONALITY) = {
  proc init () = {
    Counter.init();
  }
  proc f (l : bool list, k : int) : bool list option = {
    var o <- None;
    if (increase_counter Counter.c l k <= limit) {
      o <@ F.f(l,k);
      Counter.c <- increase_counter Counter.c l k;
    }
    return o;
  }
}.

module OPC (P : ODPRIMITIVE) = {
  proc init () = {}
  proc f (x : state) : state option = {
    var o <- None;
    if (Counter.c + 1 <= limit) {
      o <@ P.f(x);
      Counter.c <- Counter.c + 1;
    }
    return o;
  }
  proc fi (x : state) : state option = {
    var o <- None;
    if (Counter.c + 1 <= limit) {
      o <@ P.fi(x);
      Counter.c <- Counter.c + 1;
    }
    return o;
  }
}.


module ODRestr (D : ODISTINGUISHER) (F : ODFUNCTIONALITY) (P : ODPRIMITIVE) = {
  proc distinguish () = {
    var b;
    Counter.init();
    b <@ D(OFC(F),OPC(P)).distinguish();
    return b;
  }
}.

section.
declare module Dist :
  ODISTINGUISHER{Perm, Gconcl_list.SimLast, IRO, Cntr, BlockSponge.BIRO.IRO,
                Simulator, BlockSponge.C, Gconcl.S,
                SLCommon.F.RO, SLCommon.F.RRO, SLCommon.Redo, SLCommon.C,
                Gconcl_list.BIRO2.IRO, Gconcl_list.F2.RO, Gconcl_list.F2.RRO,
                Gconcl_list.Simulator}.


local module DFSome (F : DFUNCTIONALITY) : ODFUNCTIONALITY = {
  proc f (x: bool list * int) : bool list option = {
    var z;
    z <@ F.f(x);
    return Some z;
  }
}.

module DPSome (P : DPRIMITIVE) : ODPRIMITIVE = {
  proc f (x : state) : state option = {
    var z;
    z <@ P.f(x);
    return Some z;
  }
  proc fi (x: state) : state option = {
    var z;
    z <@ P.fi(x);
    return Some z;
  }
}.

local module (OD (D : ODISTINGUISHER) : DISTINGUISHER) (F : DFUNCTIONALITY) (P : DPRIMITIVE) = {
  proc distinguish () = {
    var b;
    Counter.init();
    b <@ D(OFC(DFSome(F)),OPC(DPSome(P))).distinguish();
    return b;
  }
}.

lemma SHA3OIndiff
      (Dist <: ODISTINGUISHER{
                 Counter, Perm, IRO, BlockSponge.BIRO.IRO, Cntr, Simulator,
                 Gconcl_list.SimLast(Gconcl.S), BlockSponge.C, Gconcl.S,
                 SLCommon.F.RO, SLCommon.F.RRO, SLCommon.Redo, SLCommon.C,
                 Gconcl_list.BIRO2.IRO, Gconcl_list.F2.RO, Gconcl_list.F2.RRO,
                 Gconcl_list.Simulator, OSimulator})
        &m :
      (forall (F <: ODFUNCTIONALITY) (P <: ODPRIMITIVE),
        islossless P.f => 
        islossless P.fi => 
        islossless F.f =>
        islossless Dist(F,P).distinguish) =>
  `|Pr[OGReal(CSome(Sponge), PSome(Perm), ODRestr(Dist)).main() @ &m : res] -
    Pr[OGIdeal(FSome(IRO), OSimulator, ODRestr(Dist)).main() @ &m : res]| <=
  (limit ^ 2 - limit)%r / (2 ^ (r + c + 1))%r + (4 * limit ^ 2)%r / (2 ^ c)%r.
proof. 
move=>h.
cut->: Pr[OGReal(CSome(Sponge), PSome(Perm), ODRestr(Dist)).main() @ &m : res] =
       Pr[RealIndif(Sponge, Perm, DRestr(OD(Dist))).main() @ &m : res].
+ byequiv=>//=; proc; inline*; sim; sp.
  call(: ={glob Perm, glob Counter} /\ ={c}(Counter,Cntr))=>/>; auto.
  - proc; inline*; sp; auto; if; 1, 3: auto; sp. 
    by rcondt{2} 1; 1: auto; sp; if; auto.
  - proc; inline*; sp; auto; if; auto; sp.
    by rcondt{2} 1; 1: auto; sp; if; auto.
  proc; inline*; sp; auto; sp; if; auto; sp.
  rcondt{2} 1; auto; sp=>/>.
  conseq(:_==> ={glob Perm} /\ n{1} = n0{2} /\ z0{1} = z1{2})=> />; sim.
  while(={glob Perm, sa, sc, i} /\ (n,z0){1} = (n0,z1){2}); auto.
  - by sp; if; auto; sp; if; auto.
  conseq(:_==> ={glob Perm, sa, sc})=> />; sim.
  by while(={glob Perm, sa, sc, xs}); auto; sp; if; auto=> />.
cut->: Pr[OGIdeal(FSome(IRO), OSimulator, ODRestr(Dist)).main() @ &m : res] =
        Pr[IdealIndif(IRO, Simulator, DRestr(OD(Dist))).main() @ &m : res].
+ byequiv=>//=; proc; inline*; sim; sp.
  call(: ={glob IRO, glob Simulator, glob Counter} /\ ={c}(Counter,Cntr)); auto.
  - proc; inline*; auto; sp; if; auto; sp.
    rcondt{2} 1; auto; sp; if; 1, 3: auto; sim; if; 1, 3: auto; sp; sim.
    if; 1, 3: auto; 1: smt(); sp.
    * if; auto=> />. 
      by conseq(:_==> ={IRO.mp} /\ bs0{1} = bs{2})=> />; sim=> />; smt().
    by if; auto=> />; sim; smt().
  - proc; inline*; sp; auto; if; auto; sp.
    by rcondt{2} 1; auto; sp; if; auto.
  proc; inline*; sp; auto; if; auto; sp.
  rcondt{2} 1; auto; sp; if; auto=> />.
  by conseq(:_==> bs{1} = bs0{2} /\ ={IRO.mp, glob Simulator})=> />; sim.
apply (security (OD(Dist)) _ &m). 
move=> F P hp hpi hf; proc; inline*; sp.
call (h (OFC(DFSome(F))) (OPC(DPSome(P))) _ _ _); auto.
+ by proc; inline*; sp; if; auto; call hp; auto.
+ by proc; inline*; sp; if; auto; call hpi; auto.
by proc; inline*; sp; if; auto; call hf; auto.
qed.


      
end section.

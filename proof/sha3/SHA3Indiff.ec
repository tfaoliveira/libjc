require import AllCore List IntDiv StdOrder Distr SmtMap FSet.

require import Common Sponge. import BIRO.
require (*--*) SLCommon Gconcl_list BlockSponge.

(* FIX: would be nicer to define limit at top-level and then clone
   BlockSponge with it - so BlockSponge would then clone lower-level
   theories with it

op limit : {int | 0 < limit} as gt0_max_limit.
*)
op limit : int = SLCommon.max_size.



(* The last inlined simulator *)
type state = SLCommon.state.
op parse = BlockSponge.parse.
op valid = Gconcl_list.valid.


module Simulator (F : DFUNCTIONALITY) = {
  var m  : (state, state) fmap
  var mi : (state, state) fmap
  var paths : (capacity, block list * block) fmap
  proc init() = {
    m <- empty;
    mi <- empty;
    paths <- empty.[c0 <- ([],b0)];
    Gconcl_list.BIRO2.IRO.init();
  }
  proc f (x : state) : state = {
    var p,v,z,q,k,cs,y,y1,y2;
    if (x \notin m) {
      if (x.`2 \in paths) {
        (p,v) <- oget paths.[x.`2];
        z <- [];
        (q,k) <- parse (rcons p (v +^ x.`1));
        if (valid q) {
          cs <@ F.f(oget (unpad_blocks q), k * r);
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
      m.[x]  <- y;
      mi.[y] <- x;
      if (x.`2 \in paths) {
        (p,v) <-oget paths.[x.`2];
        paths.[y2] <- (rcons p (v +^ x.`1),y.`1);
      }
    } else {
      y <- oget m.[x];
    }
    return y;
  }
  proc fi (x : state) : state = {
    var y,y1,y2;
    if (! x \in mi) {
      y1 <$ bdistr;
      y2 <$ cdistr;
      y <- (y1,y2);
      mi.[x] <- y;
      m.[y]  <- x;
    } else {
      y <- oget mi.[x];
    }
    return y;
  }
}.

      

(*---------------------------- Restrictions ----------------------------*)

(** The counter for the functionality counts the number of times the
    underlying primitive is called inside the functionality. This
    number is equal to the sum of the number of blocks in the padding
    of the input, plus the number of additional blocks the squeezing
    phase has to output.
  *)

module Cntr = {
  var c : int

  proc init() = {
    c <- 0;
  }
}.

module FC (F : DFUNCTIONALITY) = {
  proc init () : unit = {}

  (* ((size bs + 1) %/ r + 1) = size (pad2blocks bs): *)

  proc f (bs : bool list, n : int) : bool list = {
    var z : bool list <- [];
    if (Cntr.c +
        ((size bs + 1) %/ r + 1) +
        (max ((n + r - 1) %/ r - 1) 0) <= limit) {
      Cntr.c <-
        Cntr.c +
        ((size bs + 1) %/ r + 1) +
        (max ((n + r - 1) %/ r - 1) 0);
      z <@ F.f(bs, n);
    }
    return z;
  }
}.

module PC (P : DPRIMITIVE) = {
  proc init() = {}

  proc f (a : block * capacity) = {
    var z : block * capacity <- (b0, c0);
    if (Cntr.c + 1 <= limit) {
      z <@ P.f(a);
      Cntr.c <- Cntr.c + 1;
    }
    return z;
  }
  proc fi (a : block * capacity) = {
    var z : block * capacity <- (b0, c0);
    if (Cntr.c + 1 <= limit) {
      z <@ P.fi(a);
      Cntr.c <- Cntr.c + 1;
    }
    return z;
  }
}.

module DRestr (D : DISTINGUISHER) (F : DFUNCTIONALITY) (P : DPRIMITIVE) = {
  proc distinguish () : bool = {
    var b : bool;
    Cntr.init();
    b <@ D(FC(F),PC(P)).distinguish();
    return b;
  }
}.

section.

declare module Dist :
  DISTINGUISHER{Perm, Gconcl_list.SimLast, IRO, Cntr, BlockSponge.BIRO.IRO,
                Simulator, BlockSponge.C, Gconcl.S,
                SLCommon.F.RO, SLCommon.F.RRO, SLCommon.Redo, SLCommon.C,
                Gconcl_list.BIRO2.IRO, Gconcl_list.F2.RO, Gconcl_list.F2.RRO,
                Gconcl_list.Simulator}.

axiom Dist_lossless (F <: DFUNCTIONALITY { Dist }) (P <: DPRIMITIVE { Dist }) :
  islossless P.f => islossless P.fi => islossless F.f =>
  islossless Dist(F,P).distinguish.

lemma drestr_commute1 &m :
  Pr[BlockSponge.RealIndif
     (BlockSponge.Sponge, Perm,
      LowerDist(DRestr(Dist))).main() @ &m : res] =
  Pr[BlockSponge.RealIndif
     (BlockSponge.Sponge, Perm,
      BlockSponge.DRestr(LowerDist(Dist))).main() @ &m : res].
proof.
byequiv=> //; proc.
seq 2 2 : (={glob Dist} /\ ={Perm.m, Perm.mi} ); first sim.
inline*; wp; sp.
call (_ : ={c}(Cntr, BlockSponge.C) /\ ={Perm.m, Perm.mi}) => //.
+ by proc; sp; if=> //; sp; sim.
+ by proc; sp; if=> //; sp; sim.
proc=> /=.
inline BlockSponge.FC(BlockSponge.Sponge(Perm)).f.
wp; sp.
if=> //.
progress; smt(size_pad2blocks).
seq 1 1 :
  (={n} /\ nb{2} = (n{2} + r - 1) %/ r /\ bl{2} = pad2blocks bs{1} /\
   Cntr.c{1} = BlockSponge.C.c{2} /\ ={Perm.m, Perm.mi}).
auto; progress; by rewrite size_pad2blocks.
inline RaiseFun(BlockSponge.Sponge(Perm)).f.
wp; sp.
call (_ : ={Perm.m, Perm.mi}); first by sim.
auto.
qed.

lemma drestr_commute2 &m :
  Pr[BlockSponge.IdealIndif
     (BlockSponge.BIRO.IRO, Gconcl_list.SimLast(Gconcl.S),
      LowerDist(DRestr(Dist))).main() @ &m : res] =
  Pr[BlockSponge.IdealIndif
     (BlockSponge.BIRO.IRO, Gconcl_list.SimLast(Gconcl.S),
      BlockSponge.DRestr(LowerDist(Dist))).main() @ &m : res].
proof.
byequiv=> //; proc.
seq 2 2 :
  (={glob Dist, BlockSponge.BIRO.IRO.mp,
     glob Gconcl_list.SimLast(Gconcl.S)}); first sim.
inline*; wp; sp.
call
  (_ :  ={BlockSponge.BIRO.IRO.mp,Gconcl_list.BIRO2.IRO.mp} /\
   ={c}(Cntr, BlockSponge.C) /\
   ={glob Gconcl_list.SimLast(Gconcl.S)}).
proc; sp; if=> //; sim.
proc; sp; if=> //; sim.
proc=> /=.
inline BlockSponge.FC(BlockSponge.BIRO.IRO).f.
sp; wp.
if=> //.
progress; smt(size_pad2blocks).
seq 1 1 :
  (={n} /\ nb{2} = (n{2} + r - 1) %/ r /\ bl{2} = pad2blocks bs{1} /\
   Cntr.c{1} = BlockSponge.C.c{2} /\
   ={BlockSponge.BIRO.IRO.mp, Gconcl_list.BIRO2.IRO.mp,
     Gconcl.S.paths, Gconcl.S.mi, Gconcl.S.m}).
auto; progress.
rewrite size_pad2blocks //.
inline RaiseFun(BlockSponge.BIRO.IRO).f.
wp; sp.
call (_ : ={BlockSponge.BIRO.IRO.mp}); first sim.
auto.
auto.
qed.

op wit_pair : block * capacity = witness.

local equiv equiv_sim_f (F <: DFUNCTIONALITY{Gconcl.S, Simulator}) :
  RaiseSim(Gconcl_list.SimLast(Gconcl.S),F).f
  ~
  Simulator(F).f
  :
  ={arg, glob F, glob Gconcl_list.BIRO2.IRO} /\ ={m, mi, paths}(Gconcl.S,Simulator)
  ==>
  ={res, glob F, glob Gconcl_list.BIRO2.IRO} /\ ={m, mi, paths}(Gconcl.S,Simulator).
proof.
proc;inline*;if;1,3:auto=>/#.
wp;conseq(:_==> ={y1, y2, glob F, glob Gconcl_list.BIRO2.IRO}
  /\ ={m, mi, paths}(Gconcl.S,Simulator));progress;sim.
if;1,3:auto=>/#;wp;sp;if;1:(auto;smt(BlockSponge.parseK BlockSponge.formatK));
  last sim;smt(BlockSponge.parseK BlockSponge.formatK).
by sp;wp;rcondt{1}1;auto;call(: true);auto;smt(BlockSponge.parseK BlockSponge.formatK).
qed.


local equiv equiv_sim_fi (F <: DFUNCTIONALITY{Gconcl.S, Simulator}) :
  RaiseSim(Gconcl_list.SimLast(Gconcl.S),F).fi
  ~
  Simulator(F).fi
  :
  ={arg, glob F, glob Gconcl_list.BIRO2.IRO} /\ ={m, mi, paths}(Gconcl.S,Simulator)
  ==>
  ={res, glob F, glob Gconcl_list.BIRO2.IRO} /\ ={m, mi, paths}(Gconcl.S,Simulator).
proof. by proc;inline*;if;auto=>/#. qed.

local lemma replace_simulator &m :
    Pr[IdealIndif(IRO, RaiseSim(Gconcl_list.SimLast(Gconcl.S)),
      DRestr(Dist)).main() @ &m : res] =
    Pr[IdealIndif(IRO, Simulator, DRestr(Dist)).main() @ &m : res].
proof.
byequiv=>//=;proc;inline*;sp;wp.
call(: ={glob IRO, glob DRestr, glob Gconcl_list.BIRO2.IRO}
  /\ ={m, mi, paths}(Gconcl.S,Simulator));auto.
+ by proc;sp;if;auto;call(equiv_sim_f IRO);auto.
+ by proc;sp;if;auto;call(equiv_sim_fi IRO);auto.
by proc;sim.
qed.
    


lemma security &m :
  `|Pr[RealIndif(Sponge, Perm, DRestr(Dist)).main() @ &m : res] -
    Pr[IdealIndif(IRO, Simulator, DRestr(Dist)).main() @ &m : res]| <=
  (limit ^ 2 - limit)%r / (2 ^ (r + c + 1))%r + (4 * limit ^ 2)%r / (2 ^ c)%r.
proof.
rewrite -(replace_simulator &m).
rewrite powS 1:addz_ge0 1:ge0_r 1:ge0_c -pow_add 1:ge0_r 1:ge0_c.
have -> :
  (limit ^ 2 - limit)%r / (2 * (2 ^ r * 2 ^ c))%r =
  ((limit ^ 2 - limit)%r / 2%r) * (1%r / (2 ^ r)%r) * (1%r / (2 ^ c)%r).
  by rewrite (fromintM 2); smt().
rewrite/=.
have -> :
  (4 * limit ^ 2)%r / (2 ^ c)%r =
  limit%r * ((2 * limit)%r / (2 ^ c)%r) + limit%r * ((2 * limit)%r / (2 ^ c)%r).
  have -> : 4 = 2 * 2 by trivial.
  have {3}-> : 2 = 1 + 1 by trivial.
  rewrite powS // pow1 /#.
rewrite -/SLCommon.dstate /limit.
cut->:=conclusion (Gconcl_list.SimLast(Gconcl.S)) (DRestr(Dist)) &m.
cut//=:=(Gconcl_list.Real_Ideal (LowerDist(Dist))  _ &m).
+ move=>F P hp hpi hf'//=.
  cut hf:islossless RaiseFun(F).f.
  - proc;call hf';auto.
  exact(Dist_lossless (RaiseFun(F)) P hp hpi hf).
rewrite(drestr_commute1 &m) (drestr_commute2 &m).
cut->:=Gconcl_list.Simplify_simulator (LowerDist(Dist)) _ &m.
+ move=>F P hp hpi hf'//=.
  cut hf:islossless RaiseFun(F).f.
  - proc;call hf';auto.
  exact(Dist_lossless (RaiseFun(F)) P hp hpi hf).
smt().
qed.




end section.

lemma SHA3Indiff
      (Dist <: DISTINGUISHER{
                 Perm, IRO, BlockSponge.BIRO.IRO, Cntr, Simulator,
                 Gconcl_list.SimLast(Gconcl.S), BlockSponge.C, Gconcl.S,
                 SLCommon.F.RO, SLCommon.F.RRO, SLCommon.Redo, SLCommon.C,
                 Gconcl_list.BIRO2.IRO, Gconcl_list.F2.RO, Gconcl_list.F2.RRO,
                 Gconcl_list.Simulator})
        &m :
      (forall (F <: DFUNCTIONALITY { Dist }) (P <: DPRIMITIVE { Dist }),
        islossless P.f => 
        islossless P.fi => 
        islossless F.f =>
        islossless Dist(F,P).distinguish) =>
  `|Pr[RealIndif(Sponge, Perm, DRestr(Dist)).main() @ &m : res] -
    Pr[IdealIndif(IRO, Simulator, DRestr(Dist)).main() @ &m : res]| <=
  (limit ^ 2 - limit)%r / (2 ^ (r + c + 1))%r + (4 * limit ^ 2)%r / (2 ^ c)%r.
proof. move=>h;apply (security Dist h &m). qed.


(*------------------------- Sponge Construction ------------------------*)
require import Core Int IntDiv Real List FSet SmtMap.
(*---*) import IntExtra.
require import Distr DBool DList.
require import StdBigop StdOrder. import IntOrder.
require import Common.
require (*--*) IRO BlockSponge PROM.

(*------------------------- Indifferentiability ------------------------*)

clone include Indifferentiability with
  type p     <- block * capacity,
  type f_in  <- bool list * int,
  type f_out <- bool list

  rename
    [module] "Indif"  as "Experiment"
    [module] "GReal"  as "RealIndif"
    [module] "GIdeal" as "IdealIndif".

(*------------------------- Ideal Functionality ------------------------*)

clone import IRO as BIRO with
  type from <- bool list,
  type to   <- bool,
  op valid  <- valid_toplevel,
  op dto    <- dbool.

(*------------------------- Sponge Construction ------------------------*)

module StdSponge (P : DPRIMITIVE) = {
  proc init() : unit = {}

  proc f(bs : bool list, n : int) : bool list = {
    var z        <- [];
    var (sa, sc) <- (b0, Capacity.c0);
    var finished <- false;
    var xs       <- pad2blocks bs;

    (* absorption *)
    while (xs <> []) {
      (sa, sc) <@ P.f(sa +^ head b0 xs, sc);
      xs       <- behead xs;
    }
    (* squeezing *)
    while (!finished) {
      z        <- z ++ ofblock sa;
      if (size z < n) {
        (sa, sc) <@ P.f(sa, sc);
      } else {
        finished <- true;
      }
    }

    return take n z;
  }
}.

module (Sponge : CONSTRUCTION) (P : DPRIMITIVE) : FUNCTIONALITY = {
  proc init() : unit = {}

  proc f(bs : bool list, n : int) : bool list = {
    var z        <- [];
    var (sa, sc) <- (b0, Capacity.c0);
    var i        <- 0;
    var xs       <- pad2blocks bs;

    (* absorption *)
    while (xs <> []) {
      (sa, sc) <@ P.f(sa +^ head b0 xs, sc);
      xs       <- behead xs;
    }
    (* squeezing *)
    while (i < (n + r - 1) %/ r) {
      z        <- z ++ ofblock sa;
      i        <- i + 1;
      if (i < (n + r - 1) %/ r) {
        (sa, sc) <@ P.f(sa, sc);
      }
    }

    return take n z;
  }
}.

lemma loop_cond i n: 0 <= i => 0 <= n => r * i < n <=> i < (n + r - 1) %/ r.
proof.
move=> ge0_i; elim: i ge0_i n=> /= [|i ge0_i ih n ge0_n].
+ smt(gt0_n).
case: (r %| n).
+ move=> ^/dvdzE n_mod_r /needed_blocks_eq_div_r <-.
  by rewrite -(ltr_pmul2r r gt0_r (i + 1)) divzE n_mod_r /#.
move=> r_ndvd_n. rewrite -ltr_subr_addr -(addzC (-1)).
rewrite -divzMDr 1:[smt(gt0_r)] Ring.IntID.mulN1r.
have ->: n + r - 1 - r = (n - r) + r - 1 by smt().
case: (0 <= n - r)=> [n_ge_r|/ltzNge n_lt_r /#].
by rewrite -ih /#.
qed.

equiv Sponge_is_StdSponge (P <: DPRIMITIVE):
  StdSponge(P).f ~ Sponge(P).f: ={glob P, bs, n} ==> ={glob P, res}.
proof.
proc; seq  5  5: (={glob P, z, sa, sc, xs, n} /\ !finished{1} /\ i{2} = 0 /\ z{1} = []).
+ while (={glob P, xs, sa, sc}); 2:by auto.
  by auto; call (: true).
case: (n{1} <= 0).
+ rcondt{1} 1=> //=; rcondf{1} 2.
  + by auto; smt(size_ge0).
  rcondf{1} 3; 1:by auto.
  rcondf{2} 1.
  + by auto=> /> &hr _ /needed_blocks_non_pos /#.
  by auto=> /> &1 &2 _ n_le0; rewrite !take_le0.
while (   ={glob P, z, n, sa, sc}
       /\ (finished{1} <=> n{1} <= size z{1})
       /\ size z{1} = r * i{2}
       /\ 0 < n{1}
       /\ 0 <= i{2}).
+ sp; if=> />.
  + move=> &2 i z; rewrite size_cat size_block=> -> gt0_n ge0_i /ltzNge gt_ri_n gt_i_nbl.
    by rewrite -(mulzDr r i 1) loop_cond /#.
  + call (: true); auto=> /> &2 i z; rewrite size_cat size_block=> -> gt0_n ge0_i /ltzNge gt_ri_n gt_i_nbl.
    move=> ^ + /ltzNge -> /=; rewrite mulzDr /=.
    by rewrite -(mulzDr r i 1) loop_cond /#.
  + auto=> /> &2 i z; rewrite size_cat size_block=> -> gt0_n ge0_i /ltzNge gt_ri_n gt_i_nbl.
    move=> ^ + /lezNgt -> /=; rewrite mulzDr /=.
    by rewrite -(mulzDr r i 1) loop_cond /#.
by auto=> /> &1 &2 _ /ltrNge gt0_n; smt(gt0_r).
qed.

(*------------- Simulator and Distinguisher Constructions --------------*)

module LowerFun (F : DFUNCTIONALITY) : BlockSponge.DFUNCTIONALITY = {
  proc f(xs : block list, n : int) = {
    var cs, ds : bool list;
    var obs : bool list option;
    var ys : block list <- [];

    obs <- unpad_blocks xs;
    if (obs <> None) {
      cs <@ F.f(oget obs, n * r);  (* size cs = n * r *)
      ys <- bits2blocks cs;        (* size ys = n *)
    }
    return ys;
  }
}.

module RaiseFun (F : BlockSponge.DFUNCTIONALITY) : DFUNCTIONALITY = {
  proc f(bs : bool list, n : int) = {
    var xs;

    xs <@ F.f(pad2blocks bs, (n + r - 1) %/ r);
    return take n (blocks2bits xs);
  }
}.

module LowerDist (D : DISTINGUISHER, F : BlockSponge.DFUNCTIONALITY) =
  D(RaiseFun(F)).

module RaiseSim (S : BlockSponge.SIMULATOR, F : DFUNCTIONALITY) =
  S(LowerFun(F)).

(* Our main result will be:

   lemma conclusion
         (BlockSim <: BlockSponge.SIMULATOR{IRO, BlockSponge.BIRO.IRO})
         (Dist <: DISTINGUISHER{Perm, BlockSim, IRO, BlockSponge.BIRO.IRO})
         &m :
     `|Pr[RealIndif(Sponge, Perm, Dist).main() @ &m : res] -
       Pr[IdealIndif(IRO, RaiseSim(BlockSim), Dist).main() @ &m : res]| =
     `|Pr[BlockSponge.RealIndif
          (BlockSponge.Sponge, Perm, LowerDist(Dist)).main() @ &m : res] -
       Pr[BlockSponge.IdealIndif
          (BlockSponge.BIRO.IRO, BlockSim, LowerDist(Dist)).main() @ &m : res]|
*)

(*------------------------------- Proof --------------------------------*)

(* Proving the Real side

     Pr[RealIndif(Sponge, Perm, Dist).main() @ &m : res] =
     Pr[BlockSponge.RealIndif
        (BlockSponge.Sponge, Perm, LowerDist(Dist)).main() @ &m : res]

   is easy (see lemma RealIndif_Sponge_BlockSponge)

   And we split the proof of the Ideal side (IdealIndif_IRO_BlockIRO)

     Pr[IdealIndif(IRO, RaiseSim(BlockSim), Dist).main() @ &m : res] =
     Pr[BlockSponge.IdealIndif
        (BlockSponge.BIRO.IRO, BlockSim, LowerDist(Dist)).main () @ &m : res].

   into three steps, involving Hybrid IROs, which, in addition to
   an init procedure, have the procedure

     (* hashing block lists, giving n bits *)
     proc f(x : block list, n : int) : bool list

   We have lazy (HybridIROLazy) and eager (HybridIROEager) Hybrid
   IROs, both of which work with a finite map from block list * int to
   bool. In both versions, as in BlockSponge.BIRO.IRO, f returns [] if
   x isn't a valid block list.

   In the lazy version, f consults/randomly updates just those
   elements of the map's domain needed to produce the needed bits. But
   the eager version goes further, consulting/randomly updating enough
   extra domain elements so that a multiple of r domain elements are
   consulted/randomly updated (those extra bits are discarded)

   We have a parameterized module RaiseHybridIRO for turning a Hybrid
   IRO into a FUNCTIONALITY in the obvious way, and we have a
   parameterized module LowerHybridIRO for turning a Hybrid IRO into a
   DFUNCTIONALITY in the obivous way. We split the proof of the Ideal
   side into three steps:

   Step 1:

     Pr[IdealIndif(IRO, RaiseSim(BlockSim), Dist).main() @ &m : res] =
     Pr[Experiment
        (RaiseHybridIRO(HybridIROLazy),
         BlockSim(LowerHybridIRO(HybridIROLazy)),
         Dist).main() @ &m : res]

   This step is proved using a lazy invariant relating the
   maps of the bit-based IRO and HybridIROLazy

   Step 2:

     Pr[Experiment
        (RaiseHybridIRO(HybridIROLazy),
         BlockSim(LowerHybridIRO(HybridIROLazy)),
         Dist).main() @ &m : res] =
     Pr[Experiment
        (RaiseHybridIRO(HybridIROEager),
         BlockSim(LowerHybridIRO(HybridIROEager)),
         Dist).main() @ &m : res]

   This step is proved using the eager sampling lemma provided by
   PROM.

   Step 3:

     Pr[Experiment
        (RaiseHybridIRO(HybridIROEager),
         BlockSim(LowerHybridIRO(HybridIROEager)),
         Dist).main() @ &m : res] =
     Pr[BlockSponge.IdealIndif
        (BlockSponge.BIRO.IRO, BlockSim, LowerDist(Dist)).main () @ &m : res]

   This step is proved using an invariant relating the maps of
   HybridIROEager and the block-based IRO. Its proof is the most
   involved, and uses the Program abstract theory of DList to show the
   equivalence of randomly choosing a block and forming a block out
   of r randomly chosen bits *)

(*------------------- abstract theory of Hybrid IROs -------------------*)

abstract theory HybridIRO.

module type HYBRID_IRO = {
  (* initialization *)
  proc init() : unit

  (* hashing block lists, giving n bits *)
  proc f(x : block list, n : int) : bool list
}.

(* distinguisher for Hybrid IROs *)

module type HYBRID_IRO_DIST(HI : HYBRID_IRO) = {
  proc distinguish() : bool {HI.f}
}.

(* experiments for Hybrid IROs *)

module HybridIROExper(HI : HYBRID_IRO, D : HYBRID_IRO_DIST) = {
  proc main() : bool = {
    var b : bool;
    HI.init();
    b <@ D(HI).distinguish();
    return b;
  }
}.

(* lazy implementation of Hybrid IROs *)

module HybridIROLazy : HYBRID_IRO = {
  var mp : (block list * int, bool) fmap

  proc init() : unit = {
    mp <- empty;
  }

  proc fill_in(xs : block list, i : int) = {
    if (! dom mp (xs, i)) {
      mp.[(xs, i)] <$ dbool;
    }
    return oget mp.[(xs, i)];
  }

  proc f(xs : block list, n : int) = {
    var b, bs;
    var i <- 0;

    bs <- [];
    if (valid_block xs) {
      while (i < n) {
        b <@ fill_in(xs, i);
        bs <- rcons bs b;
        i <- i + 1;
      }
    }
    return bs;
  }
}.

(* eager implementation of Hybrid IROs *)

module HybridIROEager : HYBRID_IRO = {
  (* same as lazy implementation, except for indicated part *)
  var mp : (block list * int, bool) fmap

  proc init() : unit = {
    mp <- empty;
  }

  proc fill_in(xs : block list, i : int) = {
    if (! dom mp (xs, i)) {
      mp.[(xs, i)] <$ dbool;
    }
    return oget mp.[(xs, i)];
  }

  proc f(xs : block list, n : int) = {
    var b, bs;
    var m <- ((n + r - 1) %/ r) * r;  (* eager part *)
    var i <- 0;

    bs <- [];
    if (valid_block xs) {
      while (i < n) {
        b <@ fill_in(xs, i);
        bs <- rcons bs b;
        i <- i + 1;
      }
      while (i < m) {  (* eager part *)
        fill_in(xs, i);
        i <- i + 1;
      }
    }
    return bs;
  }
}.

(* we are going to use PROM.GenEager to prove:

lemma HybridIROExper_Lazy_Eager
      (D <: HYBRID_IRO_DIST{HybridIROEager, HybridIROLazy}) &m :
  Pr[HybridIROExper(HybridIROLazy, D).main() @ &m : res] =
  Pr[HybridIROExper(HybridIROEager, D).main() @ &m : res].
*)

section.

declare module D : HYBRID_IRO_DIST{HybridIROEager, HybridIROLazy}.

local clone PROM.GenEager as ERO with
  type from   <- block list * int,
  type to     <- bool,
  op sampleto <- fun _ => dbool,
  type input  <- unit,
  type output <- bool
  proof sampleto_ll by apply dbool_ll.

local module EROExper(O : ERO.RO, D : ERO.RO_Distinguisher) = {
  proc main() : bool = {
    var b : bool;
    O.init();
    b <@ D(O).distinguish();
    return b;
  }
}.

local lemma LRO_RO (D <: ERO.RO_Distinguisher{ERO.RO, ERO.FRO}) &m :
  Pr[EROExper(ERO.LRO, D).main() @ &m : res] =
  Pr[EROExper(ERO.RO, D).main() @ &m : res].
proof.
byequiv=> //; proc.
seq 1 1 : (={glob D, ERO.RO.m}); first sim.
symmetry; call (ERO.RO_LRO_D D); auto.
qed.

(* make a Hybrid IRO out of a random oracle *)

local module HIRO(RO : ERO.RO) : HYBRID_IRO = {
  proc init() : unit = {
    RO.init();
  }

  proc f(xs, n) = {
    var b, bs;
    var m <- ((n + r - 1) %/ r) * r;
    var i <- 0;

    bs <- [];
    if (valid_block xs) {
      while (i < n) {
        b <@ RO.get(xs, i);
        bs <- rcons bs b;
        i <- i + 1;
      }
      while (i < m) {
        RO.sample(xs, i);
        i <- i + 1;
      }
    }
    return bs;
  }
}.

local lemma HybridIROLazy_HIRO_LRO_init :
  equiv[HybridIROLazy.init ~ HIRO(ERO.LRO).init :
        true ==> HybridIROLazy.mp{1} = ERO.RO.m{2}].
proof. proc; inline*; auto. qed.

local lemma HybridIROLazy_fill_in_LRO_get :
  equiv[HybridIROLazy.fill_in ~ ERO.LRO.get :
        (xs, i){1} = x{2} /\ HybridIROLazy.mp{1} = ERO.RO.m{2} ==>
        ={res} /\ HybridIROLazy.mp{1} = ERO.RO.m{2}].
proof.
proc=> /=.
case ((dom HybridIROLazy.mp{1}) (xs{1}, i{1})).
rcondf{1} 1; first auto. rcondf{2} 2; first auto.
rnd{2}; auto; progress; apply dbool_ll.
rcondt{1} 1; first auto. rcondt{2} 2; first auto.
wp; rnd; auto.
qed.

local lemma HybridIROLazy_HIRO_LRO_f :
  equiv[HybridIROLazy.f ~ HIRO(ERO.LRO).f :
        ={xs, n} /\ HybridIROLazy.mp{1} = ERO.RO.m{2} ==>
        ={res} /\ HybridIROLazy.mp{1} = ERO.RO.m{2}].
proof.
proc; inline ERO.LRO.sample; sp=> /=.
if=> //.
while{2} (true) (m{2} - i{2}).
progress; auto; progress; smt().
while (={xs, n, i, bs} /\ HybridIROLazy.mp{1} = ERO.RO.m{2}).
wp; call HybridIROLazy_fill_in_LRO_get; auto.
auto; progress; smt().
qed.

local lemma HIRO_RO_HybridIROEager_init :
  equiv[HIRO(ERO.RO).init ~ HybridIROEager.init :
        true ==> ={res} /\ ERO.RO.m{1} = HybridIROEager.mp{2}].
proof. proc; inline*; auto. qed.

local lemma RO_get_HybridIROEager_fill_in :
  equiv[ERO.RO.get ~ HybridIROEager.fill_in :
        x{1} = (xs, i){2} /\ ERO.RO.m{1} = HybridIROEager.mp{2} ==>
        ={res} /\ ERO.RO.m{1} = HybridIROEager.mp{2}].
proof.
proc=> /=.
case (dom HybridIROEager.mp{2} (xs{2}, i{2})).
rcondf{1} 2; first auto. rcondf{2} 1; first auto.
rnd{1}; auto; progress; apply dbool_ll.
rcondt{1} 2; first auto. rcondt{2} 1; first auto.
wp; rnd; auto.
qed.

local lemma RO_sample_HybridIROEager_fill_in :
  equiv[ERO.RO.sample ~ HybridIROEager.fill_in :
        x{1} = (xs, i){2} /\ ERO.RO.m{1} = HybridIROEager.mp{2} ==>
         ERO.RO.m{1} = HybridIROEager.mp{2}].
proof.
proc=> /=; inline ERO.RO.get; sp.
case (dom HybridIROEager.mp{2} (xs{2}, i{2})).
rcondf{1} 2; first auto. rcondf{2} 1; first auto.
rnd{1}; auto; progress; apply dbool_ll.
rcondt{1} 2; first auto. rcondt{2} 1; first auto.
wp; rnd; auto.
qed.

local lemma HIRO_RO_HybridIROEager_f :
  equiv[HIRO(ERO.RO).f ~ HybridIROEager.f :
        ={xs, n} /\ ERO.RO.m{1} = HybridIROEager.mp{2} ==>
        ={res} /\ ERO.RO.m{1} = HybridIROEager.mp{2}].
proof.
proc; first sp=> /=.
if=> //.
while (={i, m, xs} /\ ERO.RO.m{1} = HybridIROEager.mp{2}).
wp; call RO_sample_HybridIROEager_fill_in; auto.
while (={i, n, xs, bs} /\ ERO.RO.m{1} = HybridIROEager.mp{2}).
wp; call RO_get_HybridIROEager_fill_in; auto.
auto.
qed.

(* make distinguisher for random oracles out of HIRO and D *)

local module RODist(RO : ERO.RO) = {
  proc distinguish() : bool = {
    var b : bool;
    b <@ D(HIRO(RO)).distinguish();
    return b;
  }
}.

local lemma Exper_HybridIROLazy_LRO &m :
  Pr[HybridIROExper(HybridIROLazy, D).main() @ &m : res] =
  Pr[EROExper(ERO.LRO, RODist).main() @ &m : res].
proof.
byequiv=> //; proc; inline*; wp.
seq 1 1 : (={glob D} /\ HybridIROLazy.mp{1} = ERO.RO.m{2}); first auto.
call (_ : HybridIROLazy.mp{1} = ERO.RO.m{2}).
conseq HybridIROLazy_HIRO_LRO_f.
auto.
qed.

local lemma Exper_RO_HybridIROEager &m :
  Pr[EROExper(ERO.RO, RODist).main() @ &m : res] =
  Pr[HybridIROExper(HybridIROEager, D).main() @ &m : res].
proof.
byequiv=> //; proc; inline*; wp.
seq 1 1 : (={glob D} /\ ERO.RO.m{1} = HybridIROEager.mp{2}); first auto.
call (_ : ERO.RO.m{1} = HybridIROEager.mp{2}).
conseq HIRO_RO_HybridIROEager_f.
auto.
qed.

lemma HybridIROExper_Lazy_Eager' &m :
  Pr[HybridIROExper(HybridIROLazy, D).main() @ &m : res] =
  Pr[HybridIROExper(HybridIROEager, D).main() @ &m : res].
proof.
by rewrite (Exper_HybridIROLazy_LRO &m)
           (LRO_RO RODist &m)
           (Exper_RO_HybridIROEager &m).
qed.

end section.

lemma HybridIROExper_Lazy_Eager
      (D <: HYBRID_IRO_DIST{HybridIROEager, HybridIROLazy}) &m :
  Pr[HybridIROExper(HybridIROLazy, D).main() @ &m : res] =
  Pr[HybridIROExper(HybridIROEager, D).main() @ &m : res].
proof. by apply (HybridIROExper_Lazy_Eager' D &m). qed.

(* turn a Hybrid IRO implementation (lazy or eager) into top-level
   ideal functionality *)

module RaiseHybridIRO (HI : HYBRID_IRO) : FUNCTIONALITY = {
  proc init() = {
    HI.init();
  }

  proc f(bs : bool list, n : int) = {
    var cs;
    cs <@ HI.f(pad2blocks bs, n);
    return cs;
  }
}.

(* turn a Hybrid IRO implementation (lazy or eager) into lower-level
   ideal distinguisher functionality *)

module LowerHybridIRO (HI : HYBRID_IRO) : BlockSponge.DFUNCTIONALITY = {
  proc f(xs : block list, n : int) = {
    var bs, ys;
    bs <@ HI.f(xs, n * r);
    ys <- bits2blocks bs;
    return ys;
  }
}.

(* invariant relating maps of BIRO.IRO and HybridIROLazy *)

pred lazy_invar
     (mp1 : (bool list * int, bool) fmap,
      mp2 : (block list * int, bool) fmap) =
  (forall (bs : bool list, n : int),
   dom mp1 (bs, n) <=> dom mp2 (pad2blocks bs, n)) /\
  (forall (xs : block list, n),
   dom mp2 (xs, n) => valid_block xs) /\
  (forall (bs : bool list, n : int),
   dom mp1 (bs, n) =>
   oget mp1.[(bs, n)] = oget mp2.[(pad2blocks bs, n)]).

lemma lazy_invar0 : lazy_invar empty empty.
proof.
split; first smt(mem_empty).
split; first smt(mem_empty).
smt(mem_empty).
qed.

lemma lazy_invar_mem_pad2blocks_l2r
      (mp1 : (bool list * int, bool) fmap,
       mp2 : (block list * int, bool) fmap,
       bs : bool list, i : int) :
  lazy_invar mp1 mp2 => dom mp1 (bs, i) =>
  dom mp2 (pad2blocks bs, i).
proof. smt(). qed.

lemma lazy_invar_mem_pad2blocks_r2l
      (mp1 : (bool list * int, bool) fmap,
       mp2 : (block list * int, bool) fmap,
       bs : bool list, i : int) :
  lazy_invar mp1 mp2 => dom mp2 (pad2blocks bs, i) =>
  dom mp1 (bs, i).
proof. smt(). qed.

lemma lazy_invar_vb
      (mp1 : (bool list * int, bool) fmap,
       mp2 : (block list * int, bool) fmap,
       xs : block list, n : int) :
  lazy_invar mp1 mp2 => dom mp2 (xs, n) =>
  valid_block xs.
proof. smt(). qed.

lemma lazy_invar_lookup_eq
      (mp1 : (bool list * int, bool) fmap,
       mp2 : (block list * int, bool) fmap,
       bs : bool list, n : int) :
  lazy_invar mp1 mp2 => dom mp1 (bs, n) =>
  oget mp1.[(bs, n)] = oget mp2.[(pad2blocks bs, n)].
proof. smt(). qed.

lemma lazy_invar_upd_mem_dom_iff
      (mp1 : (bool list * int, bool) fmap,
       mp2 : (block list * int, bool) fmap,
       bs cs : bool list, n m : int, b : bool) :
  lazy_invar mp1 mp2 =>
  dom mp1.[(bs, n) <- b] (cs, m) <=>
  dom mp2.[(pad2blocks bs, n) <- b] (pad2blocks cs, m).
proof.
move=> li; split=> [mem_upd_mp1 | mem_upd_mp2].
rewrite mem_set; rewrite mem_set in mem_upd_mp1.
case: ((cs, m) = (bs, n))=> [cs_m_eq_bs_n | cs_m_neq_bs_n].
right; by elim cs_m_eq_bs_n=> -> ->.
left; smt().
rewrite mem_set; rewrite mem_set in mem_upd_mp2.
case: ((cs, m) = (bs, n))=> [// | cs_m_neq_bs_n].
elim mem_upd_mp2=> [/# | [p2b_cs_p2b_bs eq_mn]].
have /# : cs = bs by apply pad2blocks_inj.
qed.

lemma lazy_invar_upd2_vb
      (mp1 : (bool list * int, bool) fmap,
       mp2 : (block list * int, bool) fmap,
       bs : bool list, xs : block list, n m : int, b : bool) :
  lazy_invar mp1 mp2 =>
  dom mp2.[(pad2blocks bs, n) <- b] (xs, m) =>
  valid_block xs.
proof.
move=> li mem_upd_mp2.
rewrite mem_set in mem_upd_mp2.
elim mem_upd_mp2=> [/# | [-> _]].
apply valid_pad2blocks.
qed.

lemma lazy_invar_upd_lu_eq
      (mp1 : (bool list * int, bool) fmap,
       mp2 : (block list * int, bool) fmap,
       bs cs : bool list, n m : int, b : bool) :
  lazy_invar mp1 mp2 =>
  dom mp1.[(bs, n) <- b] (cs, m) =>
  oget mp1.[(bs, n) <- b].[(cs, m)] =
  oget mp2.[(pad2blocks bs, n) <- b].[(pad2blocks cs, m)].
proof.
move=> li mem_upd_mp1.
case: ((cs, m) = (bs, n))=> [[-> ->] | cs_m_neq_bs_n].
+ by rewrite !get_set_sameE.
rewrite mem_set in mem_upd_mp1.
elim mem_upd_mp1=> [mem_mp1 | [-> ->]].
+ case: ((pad2blocks bs, n) = (pad2blocks cs, m))=>
    [[p2b_bs_p2b_cs ->>] | p2b_bs_n_neq_p2b_cs_m].
  + move: (pad2blocks_inj _ _ p2b_bs_p2b_cs)=> ->>.
    by move: cs_m_neq_bs_n=> //=.
  rewrite !get_set_neqE 1:// 1:eq_sym //.
  by move: li=> [] _ [] _ /(_ _ _ mem_mp1).
by rewrite !get_set_sameE.
qed.

lemma LowerFun_IRO_HybridIROLazy_f :
  equiv[LowerFun(IRO).f ~ LowerHybridIRO(HybridIROLazy).f :
        ={xs, n} /\ lazy_invar IRO.mp{1} HybridIROLazy.mp{2} ==>
        ={res} /\ lazy_invar IRO.mp{1} HybridIROLazy.mp{2}].
proof.
proc=> /=; inline HybridIROLazy.f.
seq 0 1 :
  (={n} /\ xs{1} = xs0{2} /\
   lazy_invar IRO.mp{1} HybridIROLazy.mp{2}); first auto.
case (valid_block xs{1}).
rcondt{1} 3; first auto. rcondt{2} 4; first auto.
inline*. rcondt{1} 7; first auto.
seq 6 3 : 
  (={i, n0} /\ bs{1} = bs0{2} /\
   lazy_invar IRO.mp{1} HybridIROLazy.mp{2} /\
   pad2blocks x{1} = xs0{2}).
auto; progress.
  have {2}<- := unpadBlocksK xs0{2}; first
    by rewrite (some_oget (unpad_blocks xs0{2})).
wp.
while
  (={i, n0} /\ bs{1} = bs0{2} /\
   lazy_invar IRO.mp{1} HybridIROLazy.mp{2} /\
   pad2blocks x{1} = xs0{2}).
sp; auto.
if.
progress;
  [by apply (lazy_invar_mem_pad2blocks_l2r IRO.mp{1}
             HybridIROLazy.mp{2} x{1} i{2}) |
   by apply (lazy_invar_mem_pad2blocks_r2l IRO.mp{1}
             HybridIROLazy.mp{2} x{1} i{2})].
rnd; auto; progress;
  [by rewrite !get_setE |
   by rewrite -(lazy_invar_upd_mem_dom_iff IRO.mp{1}) |
   by rewrite (lazy_invar_upd_mem_dom_iff IRO.mp{1} HybridIROLazy.mp{2}) |
   by rewrite (lazy_invar_upd2_vb IRO.mp{1} HybridIROLazy.mp{2}
               x{1} xs2 i{2} n2 mpL) |
   by rewrite (lazy_invar_upd_lu_eq IRO.mp{1} HybridIROLazy.mp{2})].
auto; progress [-delta].
by rewrite (lazy_invar_lookup_eq IRO.mp{1} HybridIROLazy.mp{2} x{1} i{2}).
auto.
rcondf{1} 3; first auto. rcondf{2} 4; first auto.
auto; progress; by rewrite bits2blocks_nil.
qed.

lemma IRO_RaiseHybridIRO_HybridIROLazy_f :
  equiv[IRO.f ~ RaiseHybridIRO(HybridIROLazy).f :
        ={n} /\ x{1} = bs{2} /\
        lazy_invar IRO.mp{1} HybridIROLazy.mp{2} ==>
        ={res} /\ lazy_invar IRO.mp{1} HybridIROLazy.mp{2}].
proof.
proc=> /=; inline*.
rcondt{1} 3; first auto.
rcondt{2} 5; first auto; progress; apply valid_pad2blocks.
seq 2 4 :
  (={i, n} /\ n{1} = n0{2} /\ xs{2} = pad2blocks x{1} /\ bs{1} = bs0{2} /\
   lazy_invar IRO.mp{1} HybridIROLazy.mp{2}); first auto.
wp.
while
  (={i, n} /\ n{1} = n0{2} /\ xs{2} = pad2blocks x{1} /\ bs{1} = bs0{2} /\
   lazy_invar IRO.mp{1} HybridIROLazy.mp{2}).
wp; sp.
if.
progress;
  [by apply (lazy_invar_mem_pad2blocks_l2r IRO.mp{1}
             HybridIROLazy.mp{2} x{1} i{2}) |
   by apply (lazy_invar_mem_pad2blocks_r2l IRO.mp{1}
             HybridIROLazy.mp{2} x{1} i{2})].
rnd; auto; progress;
  [by rewrite !get_setE |
   by rewrite -(lazy_invar_upd_mem_dom_iff IRO.mp{1}) |
   by rewrite (lazy_invar_upd_mem_dom_iff IRO.mp{1} HybridIROLazy.mp{2}) |
   by rewrite (lazy_invar_upd2_vb IRO.mp{1} HybridIROLazy.mp{2}
               x{1} xs1 i{2} n1 mpL) |
   by rewrite (lazy_invar_upd_lu_eq IRO.mp{1} HybridIROLazy.mp{2})].
auto; progress [-delta];
  by rewrite (lazy_invar_lookup_eq IRO.mp{1} HybridIROLazy.mp{2} x{1} i{2}).
auto.
qed.

(* invariant relating maps of BlockSponge.BIRO.IRO and HybridIROEager *)

pred eager_invar
     (mp1 : (block list * int, block) fmap,
      mp2 : (block list * int, bool) fmap) =
  (forall (xs : block list, i : int),
   dom mp1 (xs, i) =>
   0 <= i /\
   (forall (j : int), i * r <= j < (i + 1) * r =>
    mp2.[(xs, j)] =
    Some(nth false (ofblock (oget mp1.[(xs, i)])) (j - i * r)))) /\
  (forall (xs : block list, j : int),
   dom mp2 (xs, j) => dom mp1 (xs, j %/ r)).

pred block_bits_all_in_dom
     (xs : block list, i : int, mp : (block list * int, bool) fmap) =
  forall (j : int), i <= j < i + r => dom mp (xs, j).

pred block_bits_all_out_dom
     (xs : block list, i : int, mp : (block list * int, bool) fmap) =
  forall (j : int), i <= j < i + r => ! dom mp (xs, j).

pred block_bits_dom_all_in_or_out
     (xs : block list, i : int, mp : (block list * int, bool) fmap) =
  block_bits_all_in_dom xs i mp \/ block_bits_all_out_dom xs i mp.

lemma eager_inv_mem_mp1_ge0
      (mp1 : (block list * int, block) fmap,
       mp2 : (block list * int, bool) fmap,
       xs : block list, i : int) :
  eager_invar mp1 mp2 => dom mp1 (xs, i) => 0 <= i.
proof. move=> [ei1 ei2] mem_mp1_i; smt(). qed.

lemma eager_inv_mem_mp2_ge0
      (mp1 : (block list * int, block) fmap,
       mp2 : (block list * int, bool) fmap,
       xs : block list, j : int) :
  eager_invar mp1 mp2 => dom mp2 (xs, j) => 0 <= j.
proof.
move=> [ei1 ei2] mem_mp2_j.
have mem_mp1_j_div_r : dom mp1 (xs, j %/ r) by smt().
have ge0_j_div_r : 0 <= j %/ r by smt().
smt(divz_ge0 gt0_r).
qed.

lemma eager_invar0 : eager_invar empty empty.
proof. split; smt(mem_empty). qed.

lemma eager_inv_imp_block_bits_dom
      (mp1 : (block list * int, block) fmap,
       mp2 : (block list * int, bool) fmap,
       xs : block list, i : int) :
  0 <= i => r %| i => eager_invar mp1 mp2 =>
  block_bits_dom_all_in_or_out xs i mp2.
proof.
move=> ge0_i r_dvd_i [ei1 ei2].
case: (dom mp1 (xs, i %/ r))=> [mem_mp1 | not_mem_mp1].
have ei1_xs_i_div_r := ei1 xs (i %/ r).
have [_ mp2_eq_block_bits] := ei1_xs_i_div_r mem_mp1.
left=> j j_rng.
have mp2_eq_block_bits_j := mp2_eq_block_bits j _.
  by rewrite divzK // mulzDl /= divzK.
rewrite domE /#.
right=> j j_rng.
case: (dom mp2 (xs, j))=> // mem_mp2 /=.
have mem_mp1 := ei2 xs j mem_mp2.
have [k] [k_ran j_eq_i_plus_k] : exists k, 0 <= k < r /\ j = i + k
  by exists (j - i); smt().
have /# : (i + k) %/r = i %/ r
  by rewrite divzDl // (divz_small k r) 1:ger0_norm 1:ge0_r.
qed.

lemma eager_inv_mem_dom1
      (mp1 : (block list * int, block) fmap,
       mp2 : (block list * int, bool) fmap,
       xs : block list, i : int) :
   eager_invar mp1 mp2 => dom mp1 (xs, i) =>
   block_bits_all_in_dom xs (i * r) mp2.
proof.
move=> [ei1 _] mem j j_ran.
have [ge0_i eq_mp2_block_i] := ei1 xs i mem.
rewrite domE.
have /# := eq_mp2_block_i j _; smt().
qed.

lemma eager_inv_not_mem_dom1
      (mp1 : (block list * int, block) fmap,
       mp2 : (block list * int, bool) fmap,
       xs : block list, i : int) :
   eager_invar mp1 mp2 => 0 <= i => ! dom mp1 (xs, i) =>
   block_bits_all_out_dom xs (i * r) mp2.
proof.
move=> [_ ei2] ge0_i not_mem_mp1_i j j_ran.
case (dom mp2 (xs, j))=> // mem_mp2_j.
have mem_mp1_j_div_r := ei2 xs j mem_mp2_j.
have /# : j %/ r = i.
have [k] [k_ran ->] : exists k, 0 <= k < r /\ j = i * r + k
  by exists (j - i * r); smt().
by rewrite divzDl 1:dvdz_mull 1:dvdzz (divz_small k r)
           1:ger0_norm 1:ge0_r //= mulzK 1:gtr_eqF 1:gt0_r.
qed.

lemma block_bits_dom_first_in_imp_all_in
      (xs : block list, i : int, mp : (block list * int, bool) fmap) :
  block_bits_dom_all_in_or_out xs i mp => dom mp (xs, i) =>
  block_bits_all_in_dom xs i mp.
proof. smt(). qed.

lemma block_bits_dom_first_out_imp_all_out
      (xs : block list, i : int, mp : (block list * int, bool) fmap) :
  block_bits_dom_all_in_or_out xs i mp => ! dom mp (xs, i) =>
  block_bits_all_out_dom xs i mp.
proof. smt(). qed.

lemma Lower_HybridIROEager_f :
  equiv[LowerHybridIRO(HybridIROEager).f ~ HybridIROEager.f :
        ={xs, HybridIROEager.mp} /\ n{1} * r = n{2} ==>
        res{1} = bits2blocks res{2} /\ ={HybridIROEager.mp}].
proof.
proc=> /=; inline*.
seq 5 3 :
  (={i, HybridIROEager.mp} /\ xs0{1} = xs{2} /\
   bs0{1} = bs{2} /\ n0{1} = n{2} /\ m{1} = n0{1} /\ m{2} = n{2}).
auto; progress; first 2 by rewrite needed_blocks_prod_r.
if=> //; wp.
while
  (={i, HybridIROEager.mp} /\ xs0{1} = xs{2} /\
   bs0{1} = bs{2} /\ n0{1} = n{2} /\ m{1} = n0{1} /\
   m{2} = n{2}).
sp; wp; if=> //; rnd; auto.
while
  (={i, HybridIROEager.mp} /\ xs0{1} = xs{2} /\
   bs0{1} = bs{2} /\ n0{1} = n{2} /\ m{1} = n0{1} /\
   m{2} = n{2})=> //.
sp; wp; if=> //; rnd; auto.
auto.
qed.

(* module needed for applying transitivity tactic in connection
   with HybridIROEager *)

module HybridIROEagerTrans = {
  (* getting next block of bits; assuming m = i + r and size bs = i *)

  proc next_block(xs, i, m : int, bs) = {
    var b;

    while (i < m) {
      b <@ HybridIROEager.fill_in(xs, i);
      bs <- rcons bs b;
      i <- i + 1;
    }
    return (bs, i);
  }

  (* version of next_block split into cases; assuming m = i + r,
     size bs = i and block_bits_dom_all_in_or_out xs i HybridIROEager.mp *)

  proc next_block_split(xs, i, m : int, bs) = {
    var b, j, cs;

    if (dom HybridIROEager.mp (xs, i)) {
      while (i < m) {
        b <- oget HybridIROEager.mp.[(xs, i)];
        bs <- rcons bs b;
        i <- i + 1;
      }
    } else {
      j <- 0; cs <- [];
      while (j < r) {
        b <$ dbool;
        cs <- rcons cs b;
        j <- j + 1;
      }
      bs <- bs ++ cs;
      while (i < m) {
        HybridIROEager.mp.[(xs, i)] <- nth true bs i;
        i <- i + 1;
      }
    }
    return (bs, i);
  }

  (* loop getting n * r bits of hash *)

  proc loop(n : int, xs : block list) : int * bool list = {
    var b : bool; var i <- 0; var bs <- [];
    while (i < n * r) {
      b <@ HybridIROEager.fill_in(xs, i);
      bs <- rcons bs b;
      i <- i + 1;
    }
    return (i, bs);
  }
}.

(* predicate saying two (block list * int, bool) maps are the same
   except (perhaps) on a range of bits for a single block list *)

pred eager_eq_except
     (xs : block list, i j : int,
      mp1 mp2 : (block list * int, bool) fmap) =
  forall (ys : block list, k : int),
  ys <> xs \/ k < i \/ j <= k => mp1.[(ys, k)] = mp2.[(ys, k)].

lemma eager_eq_except_mem_iff
      (xs ys : block list, i j k : int,
       mp1 mp2 : (block list * int, bool) fmap) :
  eager_eq_except xs i j mp1 mp2 =>
  ys <> xs \/ k < i \/ j <= k =>
  dom mp1 (ys, k) <=> dom mp2 (ys, k).
proof. smt(domE). qed.

lemma eager_eq_except_upd1_eq_in
      (xs : block list, i j k : int, y : bool,
       mp1 mp2 : (block list * int, bool) fmap) :
  eager_eq_except xs i j mp1 mp2 => i <= k => k < j =>
  eager_eq_except xs i j mp1.[(xs, k) <- y] mp2.
proof.
move=> eee le_ik lt_kj ys l disj.
have ne : (xs, k) <> (ys, l) by smt().
smt(get_setE).
qed.

lemma eager_eq_except_upd2_eq_in
      (xs : block list, i j k : int, y : bool,
       mp1 mp2 : (block list * int, bool) fmap) :
  eager_eq_except xs i j mp1 mp2 => i <= k => k < j =>
  eager_eq_except xs i j mp1 mp2.[(xs, k) <- y].
proof.
move=> eee le_ik lt_kj ys l disj.
have ne : (xs, k) <> (ys, l) by smt().
smt(get_setE).
qed.

lemma eager_eq_except_maps_eq
      (xs : block list, i j : int, y : bool,
       mp1 mp2 : (block list * int, bool) fmap) :
  i <= j => eager_eq_except xs i j mp1 mp2 =>
  (forall (k : int),
   i <= k < j => mp1.[(xs, k)] = mp2.[(xs, k)]) =>
  mp1 = mp2.
proof.
move=> lt_ij eee ran_k.
apply fmap_eqP=> p.
have [ys k] -> /# : exists ys k, p = (ys, k)
  by exists p.`1 p.`2; smt().
qed.

lemma eager_invar_eq_except_upd1
      (mp1 : (block list * int, block) fmap,
       mp2 : (block list * int, bool) fmap,
       mp2' : (block list * int, bool) fmap,
       xs : block list, i : int, y : block) :
  0 <= i => eager_invar mp1 mp2 =>
  eager_eq_except xs (i * r) ((i + 1) * r) mp2 mp2' =>
  (forall (j : int),
   i * r <= j < (i + 1) * r =>
   mp2'.[(xs, j)] = Some (nth false (ofblock y) (j - i * r))) =>
  eager_invar mp1.[(xs, i) <- y] mp2'.
proof.
move=> ge0_i [ei1 ei2] ee mp2'_ran_eq.
split=> [ys k mem_mp1_upd_xs_i_y_ys_k | ys k mem_dom_mp2'_ys_k].
case: (xs = ys)=> [eq_xs_ys | ne_xs_ys].
case: (k = i)=> [eq_k_i | ne_k_i].
split; first smt().
move=> j j_ran.
by rewrite -eq_xs_ys eq_k_i get_set_sameE mp2'_ran_eq -eq_k_i.
rewrite domE in mem_mp1_upd_xs_i_y_ys_k.
have xs_i_ne_ys_k : (xs, i) <> (ys, k) by smt().
have mem_mp1_ys_k : dom mp1 (ys, k) by smt(get_setE).
split; first smt(eager_inv_mem_mp2_ge0).
move=> j j_ran; rewrite get_setE.
have -> /= : (ys, k) <> (xs, i) by smt().
have [_ ei1_ys_k_snd] := ei1 ys k mem_mp1_ys_k.
have <- :
  mp2.[(ys, j)] =
  Some (nth false (ofblock (oget mp1.[(ys, k)])) (j - k * r))
  by rewrite ei1_ys_k_snd.
have /# : j < i * r \/ (i + 1) * r <= j.
  have [lt_ki | lt_ik] : k < i \/ i < k by smt().
  left.
  have le_k_add1_i : k + 1 <= i
    by rewrite addzC lez_add1r.
  by rewrite (ltr_le_trans ((k + 1) * r)) 1:/# ler_pmul2r 1:gt0_r.
  right.
  have le_i_add1_k : i + 1 <= k
    by rewrite addzC lez_add1r.
  rewrite (lez_trans (k * r)) 1:ler_pmul2r 1:gt0_r // /#.
rewrite domE in mem_mp1_upd_xs_i_y_ys_k.
have xs_i_ne_ys_k : (xs, i) <> (ys, k) by smt().
have mem_mp1_ys_k : dom mp1 (ys, k) by smt(get_setE).
split; first smt(eager_inv_mem_mp2_ge0).
move=> j j_ran; rewrite get_setE.
have -> /= : (ys, k) <> (xs, i) by smt().
have [_ ei1_ys_k_snd] := ei1 ys k mem_mp1_ys_k.
have <- /# :
  mp2.[(ys, j)] =
  Some (nth false (ofblock (oget mp1.[(ys, k)])) (j - k * r))
  by rewrite ei1_ys_k_snd.
rewrite domE.
case: (xs = ys)=> [-> | ne_xs_ys].
case: (k < i * r)=> [lt_k_i_tim_r | not_lt_k_i_tim_r].
smt(get_setE eager_eq_except_mem_iff).
case: ((i + 1) * r <= k)=> [i_add1_tim_r_le_k | not_i_add1_tim_r_le_k].
smt(get_setE eager_eq_except_mem_iff).
have le_i_tim_r_k : i * r <= k by smt().
have lt_k_i_add1_tim_r : k < (i + 1) * r by smt().
have -> // : i = k %/ r.
  apply eqz_leq; split.
  by rewrite lez_divRL 1:gt0_r.
  by rewrite -ltzS ltz_divLR 1:gt0_r.
smt(get_setE eager_eq_except_mem_iff).
smt(get_setE eager_eq_except_mem_iff).
qed.

lemma HybridIROEagerTrans_next_block_split :
  equiv
  [HybridIROEagerTrans.next_block ~ HybridIROEagerTrans.next_block_split :
   ={i, m, xs, bs, HybridIROEager.mp} /\ m{1} = i{1} + r /\
   size bs{1} = i{1} /\
   block_bits_dom_all_in_or_out xs{1} i{1} HybridIROEager.mp{1} ==>
   ={res, HybridIROEager.mp}].
proof.
proc=> /=.
case (dom HybridIROEager.mp{2} (xs{2}, i{2})).
(* dom HybridIROEager.mp{2} (xs{2}, i{2}) *)
rcondt{2} 1; first auto.
conseq
  (_ :
   ={i, m, xs, bs, HybridIROEager.mp} /\ i{1} <= m{1} /\
   (forall (j : int),
    i{1} <= j < m{1} =>
    dom HybridIROEager.mp{1} (xs{1}, j)) ==>
   _).
progress; smt(gt0_r).
while 
  (={i, m, xs, bs, HybridIROEager.mp} /\ i{1} <= m{1} /\
   (forall (j : int),
    i{1} <= j < m{1} =>
    dom HybridIROEager.mp{1} (xs{1}, j))).
wp; inline*.
rcondf{1} 3; first auto; smt().
auto; smt().
auto.
(* ! dom HybridIROEager.mp{2} (xs{2}, i{2}) *)
rcondf{2} 1; first auto.
sp; exists* i{1}; elim*=> i'.
conseq
  (_ :
   ={i, m, xs, bs, HybridIROEager.mp} /\ i{1} = i' /\
   i' + r = m{1} /\ size bs{1} = i' /\ cs{2} = [] /\ j{2} = 0 /\
   (forall (j : int),
    i' <= j < i' + r =>
    ! dom HybridIROEager.mp{1} (xs{1}, j)) ==>
   _).
progress; smt(gt0_r).
seq 1 2 :
  (={m, xs} /\ i{2} = i' /\ i{1} = i' + r /\ bs{1} = bs{2} /\
   size bs{1} = i' + r /\ m{1} = i' + r /\
   (forall (k : int),
    i' <= k < i' + r =>
    HybridIROEager.mp{1}.[(xs{1}, k)] = Some(nth true bs{1} k)) /\
   eager_eq_except xs{1} i' (i' + r) HybridIROEager.mp{1} HybridIROEager.mp{2}).
wp.
while
  (={m, xs} /\ i{2} = i' /\ m{1} = i' + r /\ i' <= i{1} <= i' + r /\
   0 <= j{2} <= r /\ i{1} - i' = j{2} /\
   size bs{1} = i{1} /\ bs{1} = bs{2} ++ cs{2} /\
   (forall (k : int),
    i' <= k < i{1} =>
    HybridIROEager.mp{1}.[(xs{1}, k)] = Some(nth true bs{1} k)) /\
   (forall (k : int),
    i{1} <= k < i' + r =>
    ! dom HybridIROEager.mp{1} (xs{1}, k)) /\
   eager_eq_except xs{1} i' (i' + r) HybridIROEager.mp{1} HybridIROEager.mp{2}).
inline*; rcondt{1} 3; first auto; smt().
sp; wp; rnd; skip; progress.
smt(size_cat). smt(size_cat). smt(size_cat).
smt(size_rcons size_cat). smt(size_cat).
rewrite -cats1; smt(size_cat).
rewrite -2!cats1 catA; congr; congr.
by rewrite get_set_sameE oget_some.
rewrite nth_rcons /=.
case: (k = size (bs{2} ++ cs{2}))=> [-> /= | ne_k_size_bs_cat_cs].
by rewrite get_set_sameE oget_some.
have -> /= : k < size(bs{2} ++ cs{2}) by smt().
rewrite get_setE ne_k_size_bs_cat_cs /= /#.
rewrite -mem_fdom fdom_set in_fsetU1 mem_fdom negb_or.
have lt_sz_k : size (bs{2} ++ cs{2}) < k; smt().
by apply eager_eq_except_upd1_eq_in.
smt(size_cat). smt(size_cat).
skip; progress; smt(gt0_r cats0 size_cat).
conseq
  (_ :
   ={xs, bs, m} /\ i{2} = i' /\ i{1} = i' + r /\ m{1} = i' + r /\
   size bs{1} = i' + r /\
   (forall (k : int),
    i' <= k < i' + r =>
    HybridIROEager.mp{1}.[(xs{1}, k)] = Some (nth true bs{1} k)) /\
   eager_eq_except xs{1} i' (i' + r)
                   HybridIROEager.mp{1} HybridIROEager.mp{2} ==>
   _)=> //.
while{2}
  (={xs, bs, m} /\ i' <= i{2} <= i' + r /\ i{1} = i' + r /\
   m{1} = i' + r /\ size bs{1} = i' + r /\
   (forall (k : int),
    i' <= k < i{2} =>
    HybridIROEager.mp{1}.[(xs{1}, k)] = HybridIROEager.mp{2}.[(xs{1}, k)]) /\
   (forall (k : int),
    i{2} <= k < i' + r =>
    HybridIROEager.mp{1}.[(xs{1}, k)] = Some (nth true bs{1} k)) /\
   eager_eq_except xs{1} i' (i' + r)
                   HybridIROEager.mp{1} HybridIROEager.mp{2})
  (m{2} - i{2}).
progress; auto; progress;
  [smt() | smt(gt0_r) | smt(get_setE) | smt() |
   by apply eager_eq_except_upd2_eq_in | smt()].
skip; progress;
  [smt(gt0_r) | smt() | smt() | smt() | smt(eager_eq_except_maps_eq)].
qed.

(* module needed for applying transitivity tactic in connection
   with BlockSponge.BIRO.IRO *)

module BlockSpongeTrans = {
  (* getting next block; assumes size bs = i *)

  proc next_block(x, i, bs) = {
    var b;

    b <@ BlockSponge.BIRO.IRO.fill_in(x, i);
    bs <- rcons bs b;
    i <- i + 1;
    return (bs, i);
  }

  (* loop getting n blocks *)

  proc loop(n : int, xs : block list) : int * block list = {
    var b : block; var i <- 0; var bs <- [];
    while (i < n) {
      b <@ BlockSponge.BIRO.IRO.fill_in(xs, i);
      bs <- rcons bs b;
      i <- i + 1;
    }
    return (i, bs);
  }
}.

(* use Program abstract theory of DList *)

clone Program as Prog with
  type t = bool,
  op d = {0,1}
proof *.
(* nothing to be proved *)

lemma PrLoopSnoc_sample &m (bs : bool list) :
  Pr[Prog.LoopSnoc.sample(r) @ &m : res = bs] =
  mu (dlist {0,1} r) (pred1 bs).
proof.
have -> :
  Pr[Prog.LoopSnoc.sample(r) @ &m : res = bs] =
  Pr[Prog.Sample.sample(r) @ &m : res = bs].
  byequiv=> //.
  symmetry.
  conseq (_ : ={n} ==> ={res})=> //.
  apply Prog.Sample_LoopSnoc_eq.
apply (Prog.pr_Sample r &m bs).
qed.

lemma iter_mul_one_half_pos (n : int) :
  0 < n => iter n (( * ) (1%r / 2%r)) 1%r = inv(2 ^ n)%r.
proof.
move=> gt0_n.
have -> /# // :
  forall (n : int),
  0 <= n => 0 < n => iter n (( * ) (1%r / 2%r)) 1%r = inv (2 ^ n)%r.
elim=> [// | i ge0_i IH _].
case: (i = 0)=> [-> /= | ne_i0].
rewrite iter1 pow1 /#.
by rewrite iterS // IH 1:/# powS // RealExtra.fromintM
           StdRing.RField.invfM.
qed.

(* module for adapting PrLoopSnoc_sample to block generation *)

module BlockGen = {
  proc loop() : block = {
    var b : bool; var j : int; var cs : bool list;
    j <- 0; cs <- [];
    while (j < r) {
      b <$ {0,1};
      cs <- rcons cs b;
      j <- j + 1;
    }
    return mkblock cs;
  }

  proc direct() : block = {
    var w : block;
    w <$ bdistr;
    return w;
  }
}.

lemma BlockGen_loop_direct :
  equiv[BlockGen.loop ~ BlockGen.direct : true ==> ={res}].
proof.
bypr res{1} res{2}=> // &1 &2 w.
have -> : Pr[BlockGen.direct() @ &2 : res = w] = 1%r / (2 ^ r)%r.
  byphoare=> //.
  proc; rnd; skip; progress.
  rewrite DBlock.dunifinE.
  have -> : (transpose (=) w) = (pred1 w) by rewrite /pred1.
  by rewrite DBlock.Support.enum_spec block_card.
have -> :
  Pr[BlockGen.loop() @ &1 : res = w] =
  Pr[Prog.LoopSnoc.sample(r) @ &1 : res = ofblock w].
  byequiv=> //; proc.
  seq 2 2 :
    (r = n{2} /\ j{1} = i{2} /\ j{1} = 0 /\
     cs{1} = l{2} /\ cs{1} = []);
    first auto.
  while
    (r = n{2} /\ j{1} = i{2} /\ cs{1} = l{2} /\ j{1} <= r /\
     size cs{1} = j{1}).
  wp; rnd; skip.
  progress; smt(cats1 gt0_r size_rcons).
  skip=> &m1 &m2 [# <- <- -> <- ->].
  split; first smt(gt0_r).
  move=> cs j i ds not_lt_jr not_lt_ir [# _ eq_ji -> le_jr sz_cs_eq_j].
  have sz_ds_eq_r : size ds = r by smt().
  progress; [by rewrite ofblockK | by rewrite mkblockK].
rewrite (PrLoopSnoc_sample &1 (ofblock w)).
rewrite dlist1E 1:ge0_r size_block /=.
have -> :
  (fun (x : bool) => mu1 {0,1} x) =
  (fun (x : bool) => 1%r / 2%r).
apply fun_ext=> x; by rewrite dbool1E.
by rewrite Bigreal.BRM.big_const count_predT size_block
           iter_mul_one_half_pos 1:gt0_r.
qed.

lemma HybridIROEagerTrans_BlockSpongeTrans_next_block (i2 : int) :
  equiv
  [HybridIROEagerTrans.next_block ~ BlockSpongeTrans.next_block :
   i2 = i{2} /\ 0 <= i{2} /\ xs{1} = x{2} /\ i{1} = i{2} * r /\
   m{1} - i{1} = r /\ bs{1} = blocks2bits bs{2} /\ size bs{2} = i{2} /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1} ==>
   res{1}.`1 = blocks2bits res{2}.`1 /\
   res{1}.`2 = res{2}.`2 * r /\ res{2}.`2 = i2 + 1 /\
   size res{2}.`1 = i2 + 1 /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1}].
proof.
transitivity
  HybridIROEagerTrans.next_block_split
  (={i, m, xs, bs, HybridIROEager.mp} /\ m{1} = i{1} + r /\
   size bs{1} = i{1} /\
   block_bits_dom_all_in_or_out xs{1} i{1} HybridIROEager.mp{1} ==>
   ={res, HybridIROEager.mp})
  (i2 = i{2} /\ 0 <= i{2} /\ xs{1} = x{2} /\ i{1} = i{2} * r /\
   m{1} - i{1} = r /\ size bs{2} = i2 /\ bs{1} = blocks2bits bs{2} /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1} ==>
   res{1}.`1 = blocks2bits res{2}.`1 /\
   res{1}.`2 = res{2}.`2 * r /\ res{2}.`2 = i2 + 1 /\
   size res{2}.`1 = i2 + 1 /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1})=> //.
move=> |> &1 &2 ge0_i2 -> i1_eq_i2_tim_r m_min_i1_eq_r -> sz_bs_eq_i2 ei.
exists HybridIROEager.mp{1} (x{2}, i{1}, m{1}, blocks2bits bs{2})=> |>.
split; first smt().
split; first smt(size_blocks2bits).
apply
  (eager_inv_imp_block_bits_dom BlockSponge.BIRO.IRO.mp{2}
   HybridIROEager.mp{1} x{2} i{1})=> //.
rewrite i1_eq_i2_tim_r mulr_ge0 // ge0_r.
rewrite i1_eq_i2_tim_r dvdz_mull dvdzz.
apply HybridIROEagerTrans_next_block_split.
proc=> /=; inline*; sp; wp.
case (dom BlockSponge.BIRO.IRO.mp{2} (x0{2}, n{2})).
(* dom BlockSponge.BIRO.IRO.mp{2} (x0{2}, n{2}) *)
rcondf{2} 1; first auto.
rcondt{1} 1; first auto; progress [-delta].
have bb_all_in :
  block_bits_all_in_dom x{m} (size bs{m} * r) HybridIROEager.mp{hr}
  by apply (eager_inv_mem_dom1 BlockSponge.BIRO.IRO.mp{m}).
smt(gt0_r).
simplify; exists* i{1}; elim*=> i1; exists* bs{1}; elim*=> bs1.
conseq
  (_ :
   i1 = i{1} /\ 0 <= i2 /\ i1 = i2 * r /\ m{1} - i1 = r /\
   bs1 = bs{1} /\ size bs{2} = i2 /\ size bs1 = i1 /\
   bs1 = blocks2bits bs{2} /\
   dom BlockSponge.BIRO.IRO.mp{2} (xs{1}, i2) /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1} ==>
   bs{1} =
   blocks2bits (rcons bs{2} (oget BlockSponge.BIRO.IRO.mp{2}.[(xs{1}, i2)])) /\
   i{1} = (i2 + 1) * r /\ size bs{2} = i2 /\ size bs{1} = (i2 + 1) * r /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1});
  [progress; smt(size_blocks2bits) | progress; by rewrite size_rcons | idtac].
while{1}
  (i1 <= i{1} <= m{1} /\ i1 = i2 * r /\ size bs{1} = i{1} /\ m{1} - i1 = r /\
   bs{1} =
   bs1 ++
   take (i{1} - i1)
        (ofblock (oget(BlockSponge.BIRO.IRO.mp{2}.[(xs{1}, i2)]))) /\
   dom BlockSponge.BIRO.IRO.mp{2} (xs{1}, i2) /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1})
  (m{1} - i{1}).
move=> &m z.
auto=>
  |> &hr i2_tim_r_le_sz_bs sz_bs_le_m m_min_i2_tim_r_eq_r bs_eq
  mem_blk_mp_xs_i2 ei sz_bs_lt_m.
split. split. split=> [| _]; smt(). split; first by rewrite -cats1 size_cat.
rewrite -cats1 {1}bs_eq -catA; congr.
have -> : size bs{hr} + 1 - i2 * r = size bs{hr} - i2 * r + 1 by algebra.
rewrite (take_nth false) 1:size_block; first smt(size_ge0).
rewrite -cats1; congr; congr.
have some_form_mp_hr_lookup_eq :
  HybridIROEager.mp{hr}.[(xs{hr}, size bs{hr})] =
  Some (nth false (ofblock (oget BlockSponge.BIRO.IRO.mp{m}.[(xs{hr}, i2)]))
                  (size bs{hr} - i2 * r)).
  have [ei1 _] := ei.
  have [_ ei1_xs_i2] := ei1 xs{hr} i2 mem_blk_mp_xs_i2.
  by rewrite ei1_xs_i2 1:/#.
by rewrite some_form_mp_hr_lookup_eq oget_some.
smt().
skip=>
  &1 &2
  [# <- ge0_i2 i1_eq_i2_tim_r m_min_i1_eq_r <- sz_bs2_eq_i2
   sz_b2b_bs2_eq_i1 ->> mem_dom_mp2_xs_i2 ei].
split. split. split=> [// | _]; rewrite i1_eq_i2_tim_r; smt(ge0_r).
split=> //. split; first smt(). split=> //.
split; first by rewrite /= take0 cats0. split=> //.
move=> bs1 i1'.
split=> [| not_i1'_lt_m]; first smt().
move=> [# i1_le_i1' i1'_le_m _ sz_bs1_eq_i1' _ bs1_eq mem_mp2_xs_i2 _].
split.
have i1'_eq_m : i1' = m{1} by smt().
rewrite bs1_eq -cats1 blocks2bits_cat i1'_eq_m m_min_i1_eq_r blocks2bits_sing.
pose blk := (oget BlockSponge.BIRO.IRO.mp{2}.[(xs{1}, i2)]).
have -> : r = size (ofblock blk) by rewrite size_block.
by rewrite take_size.
split; smt().
(* ! dom BlockSponge.BIRO.IRO.mp{2} (x0{2}, n{2}) *)
rcondt{2} 1; first auto. rcondf{1} 1; first auto; progress [-delta].
have bb_all_not_in :
  block_bits_all_out_dom x{m} (size bs{m} * r) HybridIROEager.mp{hr}
  by apply (eager_inv_not_mem_dom1 BlockSponge.BIRO.IRO.mp{m}).
smt(gt0_r).
simplify.
conseq
  (_ :
   x0{2} = x{2} /\ n{2} = i{2} /\ i2 = i{2} /\ 0 <= i{2} /\ xs{1} = x{2} /\
   i{1} = i{2} * r /\ m{1} - i{1} = r /\ size bs{2} = i2 /\
   bs{1} = blocks2bits bs{2} /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1} ==>
   _)=> //.
alias{2} 1 with w.
seq 3 1 :
  (xs{1} = x0{2} /\ n{2} = i2 /\ i{2} = i2 /\ 0 <= i2 /\
   i{1} = i2 * r /\ m{1} - i{1} = r /\ size bs{2} = i2 /\
   size cs{1} = r /\ mkblock cs{1} = w{2} /\ bs{1} = blocks2bits bs{2} /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1}).
conseq (_ : true ==> cs{1} = ofblock w{2}); first
  progress; [by rewrite size_block | by rewrite mkblockK].
transitivity{2}
  { w <@ BlockGen.loop(); }
  (true ==> cs{1} = ofblock w{2})
  (true ==> ={w})=> //.
inline BlockGen.loop; sp; wp.
while (={j, cs} /\ 0 <= j{1} <= r /\ size cs{1} = j{1}).
wp; rnd; skip; progress; smt(size_ge0 size_rcons).
skip; progress.
smt(gt0_r).
have sz_cs_R_eq_r : size cs_R = r by smt().
by rewrite ofblockK.
transitivity{2}
  { w <@ BlockGen.direct(); }
  (true ==> ={w})
  (true ==> ={w})=> //.
call BlockGen_loop_direct; auto.
inline BlockGen.direct; sim.
wp; simplify; sp; elim*=> bs_l.
exists* HybridIROEager.mp{1}; elim*=> mp1; exists* i{1}; elim*=> i1.
conseq
  (_ :
   xs{1} = x0{2} /\ 0 <= i2 /\ i{1} = i1 /\ i1 = i2 * r /\
   m{1} - i1 = r /\
   bs{1} = blocks2bits bs{2} ++ ofblock w{2} /\ size bs{2} = i2 /\
   size bs{1} = i1 + r /\ mp1 = HybridIROEager.mp{1} /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1} ==>
   bs{1} = blocks2bits bs{2} ++ ofblock w{2} /\
   i{1} = (i2 + 1) * r /\
   eager_invar BlockSponge.BIRO.IRO.mp{2}.[(x0{2}, i2) <- w{2}]
               HybridIROEager.mp{1}).
progress;
  [by rewrite ofblockK | rewrite size_cat size_blocks2bits /#].
progress;
  [by rewrite -cats1 blocks2bits_cat blocks2bits_sing get_set_sameE
              oget_some ofblockK |
   by rewrite size_rcons].
while{1}
  (0 <= i1 /\ m{1} - i1 = r /\ size bs{1} = i1 + r /\
   i1 <= i{1} <= m{1} /\
   eager_eq_except xs{1} i1 (i1 + r) mp1 HybridIROEager.mp{1} /\
   (forall (j : int),
    i1 <= j < i{1} =>
    HybridIROEager.mp{1}.[(xs{1}, j)] = Some(nth false bs{1} j)))
  (m{1} - i{1}).
progress; auto.
move=>
  |> &hr ge0_i1 m_min_i1_eq_r sz_bs_eq_i1_plus_r il_le_i _ ee
  mp_ran_eq lt_im.
split. split; first smt().
split; first smt(eager_eq_except_upd2_eq_in).
move=> j i1_le_j j_lt_i_add1.
case: (i{hr} = j)=> [-> | ne_ij].
rewrite get_setE /=; smt(nth_onth onth_nth).
rewrite get_setE.
have -> /= : (xs{hr}, j) <> (xs{hr}, i{hr}) by smt().
rewrite mp_ran_eq /#.
smt().
skip=>
  &1 &2 [# -> ge0_i2 -> i1_eq_i2_tim_r m_min_i1_eq_r
  bs1_eq sz_bs2_eq_i2 sz_bs1_eq_i1_add_r -> ei].
have ge0_i1 : 0 <= i1 by rewrite i1_eq_i2_tim_r divr_ge0 // ge0_r.
split. split=> //. split; first smt(ge0_r).
split; first smt(). split; smt(ge0_r).
move=> mp_L i_L.
split; first smt().
move=> not_i_L_lt_m [# _ _ _ i1_le_i_L i_L_le_m ee mp_L_ran_eq].
split; first smt().
split; first smt().
apply (eager_invar_eq_except_upd1 BlockSponge.BIRO.IRO.mp{2}
       HybridIROEager.mp{1} mp_L x0{2} i2 w{2})=> //.
by rewrite mulzDl /= -i1_eq_i2_tim_r.
move=> j j_ran.
rewrite mp_L_ran_eq 1:/#; congr; rewrite bs1_eq nth_cat.
have -> : size(blocks2bits bs{2}) = i2 * r
  by rewrite size_blocks2bits /#.
have -> // : j < i2 * r = false by smt().
qed.

lemma HybridIROEagerTrans_BlockSpongeTrans_loop (n' : int) :
  equiv
  [HybridIROEagerTrans.loop ~ BlockSpongeTrans.loop :
   ={xs, n} /\ n' = n{1} /\ 0 <= n' /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1} ==>
   res{1}.`1 = n' * r /\ res{2}.`1 = n' /\
   size res{2}.`2 = n' /\ res{1}.`2 = blocks2bits res{2}.`2 /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1}].
proof.
case (0 <= n'); last first=> [not_ge0_n' | ge0_n'].
proc=> /=; exfalso.
proc=> /=.
move: ge0_n'; elim n'=> [| n' ge0_n' IH].
sp. rcondf{1} 1; auto. rcondf{2} 1; auto.
splitwhile{1} 3 : (i < (n - 1) * r); splitwhile{2} 3 : (i < n - 1).
seq 3 3 :
  (={xs, n} /\ n{1} = n' + 1 /\ i{1} = n' * r /\ i{2} = n' /\
   size bs{2} = n' /\ bs{1} = blocks2bits bs{2} /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1}).
conseq
  (_ :
   ={xs, n} /\ n' + 1 = n{1} /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1} ==>
   i{1} = n' * r /\ i{2} = n' /\ size bs{2} = n' /\
   bs{1} = blocks2bits bs{2} /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1})=> //.
transitivity{1}
  { i <- 0; bs <- [];
    while (i < n * r) {
      b <@ HybridIROEager.fill_in(xs, i);
      bs <- rcons bs b;
      i <- i + 1;
    }
  }
  (={xs, HybridIROEager.mp} /\ n{1} = n' + 1 /\ n{2} = n' ==>
   ={bs, i, HybridIROEager.mp})
  (={xs} /\ n{1} = n' /\ n{2} = n' + 1 /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1} ==>
   i{1} = n' * r /\ i{2} = n' /\ size bs{2} = n' /\
   bs{1} = blocks2bits bs{2} /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1})=> //.
progress; exists HybridIROEager.mp{1} n' xs{2}=> //.
while (={xs, i, bs, HybridIROEager.mp} /\ n{1} = n' + 1 /\ n{2} = n').
wp. call (_ : ={HybridIROEager.mp}). if=> //; rnd; auto.
skip; progress; smt(ge0_r).
auto; smt().
transitivity{2}
  { i <- 0; bs <- [];
    while (i < n) {
      b <@ BlockSponge.BIRO.IRO.fill_in(xs, i);
      bs <- rcons bs b;
      i <- i + 1;
    }
  }
  (={xs, n} /\ n{1} = n' /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1} ==>
   i{1} = n' * r /\ i{2} = n' /\ size bs{2} = n' /\
   bs{1} = blocks2bits bs{2} /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1})
  (={xs,BlockSponge.BIRO.IRO.mp} /\ n{1} = n' /\ n{2} = n' + 1 ==>
   ={i, bs, BlockSponge.BIRO.IRO.mp})=> //.
progress; exists BlockSponge.BIRO.IRO.mp{2} n{1} xs{2}=> //.
conseq IH=> //.
while
  (={xs, bs, i, BlockSponge.BIRO.IRO.mp} /\ n{1} = n' /\ n{2} = n' + 1).
wp. call (_ : ={BlockSponge.BIRO.IRO.mp}). if=> //; rnd; auto.
auto; smt().
auto; smt().
unroll{2} 1. rcondt{2} 1; first auto; progress; smt().
rcondf{2} 4. auto. call (_ : true). if=> //. auto.
transitivity{1}
  { (bs, i) <@ HybridIROEagerTrans.next_block(xs, i, (n' + 1) * r, bs); }
  (={xs, i, bs, HybridIROEager.mp} /\ n{1} = n' + 1 ==>
   ={i, bs, HybridIROEager.mp})
  (={xs} /\ i{1} = n' * r /\ i{2} = n' /\
   size bs{2} = n' /\ bs{1} = blocks2bits bs{2} /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1} ==>
   i{1} = (n' + 1) * r /\ i{2} = n' + 1 /\ size bs{2} = n' + 1 /\
   bs{1} = blocks2bits bs{2} /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1})=> //.
progress;
  exists HybridIROEager.mp{1} (blocks2bits bs{2}) (size bs{2} * r) xs{2}=> //.
inline HybridIROEagerTrans.next_block; sp; wp.
while
  (xs{1} = xs0{2} /\ i{1} = i0{2} /\ n{1} = n' + 1 /\
   m{2} = (n' + 1) * r /\ bs{1} = bs0{2} /\
   ={HybridIROEager.mp}).
wp. call (_ : ={HybridIROEager.mp}). if=> //; rnd; auto.
auto. auto.
transitivity{2}
  { (bs, i) <@ BlockSpongeTrans.next_block(xs, i, bs); }
  (={xs} /\ i{1} = n' * r /\ i{2} = n' /\
  size bs{2} = n' /\ bs{1} = blocks2bits bs{2} /\
  eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1} ==>
  i{1} = (n' + 1) * r /\ i{2} = n' + 1 /\ size bs{2} = n' + 1 /\
  bs{1} = blocks2bits bs{2} /\
  eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1})
  (={xs, bs, i, BlockSponge.BIRO.IRO.mp} ==>
   ={xs, bs, i, BlockSponge.BIRO.IRO.mp})=> //.
progress; exists BlockSponge.BIRO.IRO.mp{2} bs{2} (size bs{2}) xs{2}=> //.
call (HybridIROEagerTrans_BlockSpongeTrans_next_block n').
skip; progress; smt().
inline BlockSpongeTrans.next_block.
wp; sp. call (_ : ={BlockSponge.BIRO.IRO.mp}). if=> //; rnd; skip; smt().
auto.
qed.

lemma HybridIROEager_f_BlockIRO_f (n1 : int) (x2 : block list) :
  equiv[HybridIROEager.f ~ BlockSponge.BIRO.IRO.f :
        n1 = n{1} /\ x2 = x{2} /\ xs{1} = x{2} /\ 
        n{2} = (n{1} + r - 1) %/ r /\
        eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1} ==>
        eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1} /\
        (valid_block x2 =>
           (n1 <= 0 => res{1} = [] /\ res{2} = []) /\
           (0 < n1 =>
              res{1} = take n1 (blocks2bits res{2}) /\
              size res{2} = (n1 + r - 1) %/ r)) /\
        (! valid_block x2 => res{1} = [] /\ res{2} = [])].
proof.
proc=> /=.
seq 3 2 :
  (n1 = n{1} /\ xs{1} = x{2} /\ x2 = x{2} /\
   n{2} = (n{1} + r - 1) %/ r /\ n{2} * r = m{1} /\
   i{1} = 0 /\ i{2} = 0 /\ bs{1} = [] /\ bs{2} = [] /\
  eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1}).
auto; progress.
if=> //.
case (n1 < 0).
rcondf{1} 1; first auto; progress; smt().
rcondf{2} 1; first auto; progress;
  by rewrite -lezNgt needed_blocks_non_pos ltzW.
rcondf{1} 1; first auto; progress;
  by rewrite -lezNgt pmulr_lle0 1:gt0_r needed_blocks_non_pos ltzW.
auto; progress;
  [by rewrite blocks2bits_nil | by smt(needed_blocks0)].
(* 0 <= n1 *)
conseq
  (_ :
   xs{1} = x{2} /\ n1 = n{1} /\ 0 <= n1 /\ n{2} = (n{1} + r - 1) %/ r /\
   n{2} * r = m{1} /\ n{1} <= m{1} /\
   i{1} = 0 /\ i{2} = 0 /\ bs{1} = [] /\ bs{2} = [] /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1} ==>
   bs{1} = take n1 (blocks2bits bs{2}) /\
   size bs{2} = (n1 + r - 1) %/ r /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1}).
progress; [smt() | apply/needed_blocks_suff].
move=> |> &1 &2 ? ? ? mp1 mp2 bs ? ? ?;
  smt(size_eq0 needed_blocks0 take0).
splitwhile{1} 1 : i < (n1 %/ r) * r. splitwhile{2} 1 : i < n1 %/ r.
seq 1 1 :
  (xs{1} = x{2} /\ n1 = n{1} /\ 0 <= n1 /\ n{2} = (n1 + r - 1) %/ r /\
   n{2} * r = m{1} /\ n{1} <= m{1} /\ i{1} = n1 %/ r * r /\
   i{2} = n1 %/ r /\ size bs{2} = i{2} /\ bs{1} = blocks2bits bs{2} /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1}).
(* we have zero or more blocks to add on the right, and
   r times that number of bits to add on the left;
   we will work up to applying HybridIROEagerTrans_BlockSpongeTrans_loop *)
conseq
  (_ :
   xs{1} = x{2} /\ n1 = n{1} /\ 0 <= n1 /\ n{2} = (n1 + r - 1) %/ r /\
   i{1} = 0 /\ i{2} = 0 /\ bs{1} = [] /\ bs{2} = [] /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1} ==>
   i{1} = n1 %/ r * r /\ i{2} = n1 %/ r /\
   size bs{2} = i{2} /\ bs{1} = blocks2bits bs{2} /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1})=> //.
transitivity{1}
  { while (i < n1 %/ r * r) {
      b <@ HybridIROEager.fill_in(xs, i);
      bs <- rcons bs b;
      i <- i + 1;
    }
  }
  (={i, bs, xs, HybridIROEager.mp} /\ n1 = n{1} /\ 0 <= n1 ==>
   ={i, bs, xs, HybridIROEager.mp})
  (xs{1} = x{2} /\ n1 = n{1} /\ 0 <= n1 /\ n{2} = (n1 + r - 1) %/ r /\
   i{1} = 0 /\ i{2} = 0 /\ bs{1} = [] /\ bs{2} = [] /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1} ==>
   i{1} = n1 %/ r * r /\ i{2} = n1 %/ r /\
   size bs{2} = i{2} /\ bs{1} = blocks2bits bs{2} /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1})=> //.
progress; exists HybridIROEager.mp{1} [] 0 n{1} x{2}=> //.
while (={i, bs, xs, HybridIROEager.mp} /\ n1 = n{1} /\ 0 <= n1).
wp. call (_ : ={HybridIROEager.mp}). if=> //; auto.
auto; progress; smt(leq_trunc_div ge0_r).
auto; progress; smt(leq_trunc_div ge0_r).
(transitivity{2}
   { while (i < n1 %/ r) {
       b <@ BlockSponge.BIRO.IRO.fill_in(x, i);
       bs <- rcons bs b;
       i <- i + 1;
     }
   }
   (xs{1} = x{2} /\ n1 = n{1} /\ 0 <= n1 /\ n{2} = (n1 + r - 1) %/ r /\
    i{1} = 0 /\ i{2} = 0 /\ bs{1} = [] /\ bs{2} = [] /\
    eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1} ==>
    i{1} = n1 %/ r * r /\ i{2} = n1 %/ r /\ size bs{2} = i{2} /\
    bs{1} = blocks2bits bs{2} /\
    eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1})
   (={i, x, bs, BlockSponge.BIRO.IRO.mp} /\ n{2} = (n1 + r - 1) %/ r ==>
    ={i, x, bs, BlockSponge.BIRO.IRO.mp})=> //;
   first progress;
     exists BlockSponge.BIRO.IRO.mp{2} [] 0 ((n{1} + r - 1) %/ r) x{2}=> //);
  first last.
while
  (={i, x, bs, BlockSponge.BIRO.IRO.mp} /\ n{2} = (n1 + r - 1) %/ r).
wp. call (_ : ={BlockSponge.BIRO.IRO.mp}). if=> //; auto.
auto; progress;
  have /# : n1 %/ r <= (n1 + r - 1) %/ r
    by rewrite leq_div2r; smt(gt0_r).
auto; progress;
  have /# : n1 %/ r <= (n1 + r - 1) %/ r
    by rewrite leq_div2r; smt(gt0_r).
conseq
  (_ :
   xs{1} = x{2} /\ 0 <= n1 /\
   i{1} = 0 /\ i{2} = 0 /\ bs{1} = [] /\ bs{2} = [] /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1} ==>
   i{1} = n1 %/ r * r /\ i{2} = n1 %/ r /\
   size bs{2} = n1 %/ r /\ bs{1} = blocks2bits bs{2} /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1})=> //.
transitivity{1}
  { (i, bs) <@ HybridIROEagerTrans.loop(n1 %/ r, xs); }
  (={xs, HybridIROEager.mp} /\ n{2} = n1 %/ r /\ i{1} = 0 /\ bs{1} = [] ==>
   ={i, xs, bs, HybridIROEager.mp})
  (xs{1} = x{2} /\ 0 <= n1 /\ i{2} = 0 /\ bs{2} = [] /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1} ==>
   i{1} = n1 %/ r * r /\ i{2} = n1 %/ r /\
   size bs{2} = n1 %/ r /\ bs{1} = blocks2bits bs{2} /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1})=> //.
progress; exists HybridIROEager.mp{1} (n1 %/ r) x{2}=> //.
inline HybridIROEagerTrans.loop; sp; wp.
while
  (={HybridIROEager.mp} /\ i{1} = i0{2} /\ bs{1} = bs0{2} /\
   xs{1} = xs0{2} /\ n0{2} = n1 %/ r).
wp. call (_ : ={HybridIROEager.mp}). if=> //; rnd; auto.
auto. auto.
(transitivity{2}
   { (i, bs) <@ BlockSpongeTrans.loop(n1 %/ r, x); }
   (xs{1} = x{2} /\ 0 <= n1 /\
    eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1} ==>
    i{1} = n1 %/ r * r /\ i{2} = n1 %/ r /\
    size bs{2} = n1 %/ r /\ bs{1} = blocks2bits bs{2} /\
    eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1})
   (={x, BlockSponge.BIRO.IRO.mp} /\ i{2} = 0 /\ bs{2} = [] ==>
    ={i, x, bs, BlockSponge.BIRO.IRO.mp})=> //;
   first progress; exists BlockSponge.BIRO.IRO.mp{2} x{2}=> //);
  last first.
inline BlockSpongeTrans.loop; sp; wp.
while
  (={BlockSponge.BIRO.IRO.mp} /\ i0{1} = i{2} /\ n0{1} = n1 %/ r /\
   xs{1} = x{2} /\ bs0{1} = bs{2}).
wp. call (_ : ={BlockSponge.BIRO.IRO.mp}). if=> //; rnd; auto.
auto. auto.
call (HybridIROEagerTrans_BlockSpongeTrans_loop (n1 %/ r)).
skip; progress; smt(divz_ge0 gt0_r).
(* either nothing more to do on either side, or a single block to add
   on the right side, and less than r bits to add on the left side *)
conseq
  (_ :
   n1 = n{1} /\ 0 <= n1 /\ xs{1} = x{2} /\ n{2} = (n1 + r - 1) %/ r /\
   n{2} * r = m{1} /\ n{1} <= m{1} /\ i{1} = n1 %/ r * r /\
   i{2} = n1 %/ r /\ size bs{2} = i{2} /\ bs{1} = blocks2bits bs{2} /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1} /\
   (i{2} = n{2} \/ i{2} + 1 = n{2}) ==>
   bs{1} = take n1 (blocks2bits bs{2}) /\ size bs{2} = n{2} /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1}) => //.
progress; by apply/needed_blocks_rel_div_r.
case (i{2} = n{2}).  (* so i{1} = n{1} and i{1} = m{1} *)
rcondf{2} 1; first auto; progress; smt().
rcondf{1} 1; first auto; progress; smt().
rcondf{1} 1; first auto; progress; smt().
auto=> |> &1 &2 ? ? sz_eq ? ? need_blks_eq.
split.
have -> : n{1} = size (blocks2bits bs{2})
  by rewrite size_blocks2bits sz_eq -mulzC divzK 1:needed_blocks_eq_div_r.
by rewrite take_size.
by rewrite sz_eq need_blks_eq.
(* i{2} <> n{2}, so i{2} + 1 = n{2}, m{1} - i{1} = r and i{1} <= m{1} *)
rcondt{2} 1; first auto; progress; smt().
rcondf{2} 4.
auto; call (_ : true); [if=> //; auto; progress; smt() | auto; smt()].
conseq
  (_ :
   n1 = n{1} /\ 0 <= n1 /\ xs{1} = x{2} /\ 0 <= i{2} /\ i{1} = i{2} * r /\
   n{1} <= m{1} /\ m{1} - i{1} = r /\ i{1} <= n{1} /\
   bs{1} = blocks2bits bs{2} /\ size bs{1} = i{1} /\ size bs{2} = i{2} /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1} ==>
   bs{1} = take n1 (blocks2bits bs{2}) /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1})
  _
  (_ : size bs = n - 1 ==> size bs = n)=> //.
progress; smt(divz_ge0 gt0_r lez_floor size_blocks2bits).
wp. call (_ : true). auto. skip; smt(size_rcons).
transitivity{1}
  { while (i < m) {
      b <@ HybridIROEager.fill_in(xs, i);
      bs <- rcons bs b;
      i <- i + 1;
    }
  }
  (={bs, m, i, xs, HybridIROEager.mp} /\ n1 = n{1} /\ i{1} <= n1 /\
   n1 <= m{1} /\ size bs{1} = i{1} ==>
   ={HybridIROEager.mp} /\ bs{1} = take n1 bs{2})
  (xs{1} = x{2} /\ 0 <= i{2} /\ i{1} = i{2} * r /\ m{1} - i{1} = r /\
   size bs{2} = i{2} /\ bs{1} = blocks2bits bs{2} /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1} ==>
   bs{1} = blocks2bits bs{2} /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1}).
progress;
  exists HybridIROEager.mp{1} (blocks2bits bs{2})
         (size bs{2} * r) m{1} x{2}=> //.
progress; smt(take_cat).
splitwhile{2} 1 : i < n1.
seq 1 1 :
  (={HybridIROEager.mp, xs, bs, i, m} /\ i{1} = n1 /\ n1 <= m{1} /\
   size bs{1} = n1).
while
  (={HybridIROEager.mp, xs, bs, i, m} /\ n{1} = n1 /\ n1 <= m{1} /\
   i{1} <= n1 /\ size bs{1} = i{1}).
wp; call (_ : ={HybridIROEager.mp}); first if => //; rnd; auto.
skip; smt(size_rcons).
skip; smt().
while
  (={HybridIROEager.mp, xs, i, m} /\ n1 <= m{1} /\
   n1 <= i{1} <= m{1} /\ n1 <= size bs{2} /\
   bs{1} = take n1 bs{2}).
wp; call (_ : ={HybridIROEager.mp}); first if => //; rnd; auto.
skip; progress;
  [smt() | smt() | smt(size_rcons) |
   rewrite -cats1 take_cat;
   smt(size_rcons take_oversize cats1 cats0)].
skip; smt(take_size).
(* now we can use HybridIROEagerTrans_BlockSpongeTrans_next_block *)
transitivity{1}
  { (bs, i) <@ HybridIROEagerTrans.next_block(xs, i, m, bs);
  }
  (={i, m, xs, bs, HybridIROEager.mp} ==>
   ={i, m, xs, bs, HybridIROEager.mp})
  (xs{1} = x{2} /\ 0 <= i{2} /\ i{1} = i{2} * r /\ m{1} - i{1} = r /\
  size bs{2} = i{2} /\ bs{1} = blocks2bits bs{2} /\
  eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1} ==>
  bs{1} = blocks2bits bs{2} /\
  eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1})=> //.
progress [-delta];
  exists HybridIROEager.mp{1} (blocks2bits bs{2}) (size bs{2} * r)
         m{1} x{2}=> //.
inline HybridIROEagerTrans.next_block; sim.
(transitivity{2}
   { (bs, i) <@ BlockSpongeTrans.next_block(x, i, bs);
   }
   (xs{1} = x{2} /\ 0 <= i{2} /\ i{1} = i{2} * r /\ m{1} - i{1} = r /\
    size bs{2} = i{2} /\ bs{1} = blocks2bits bs{2} /\
    eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1} ==>
    bs{1} = blocks2bits bs{2} /\
    eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1})
   (={bs, i, x, BlockSponge.BIRO.IRO.mp} ==>
    ={bs, i, x, BlockSponge.BIRO.IRO.mp})=> //;
   first progress [-delta];
           exists BlockSponge.BIRO.IRO.mp{2} bs{2} (size bs{2}) x{2}=> //);
  last first.
inline BlockSpongeTrans.next_block; sim.
exists* i{2}; elim*=> i2.
call (HybridIROEagerTrans_BlockSpongeTrans_next_block i2).
auto.
qed.

lemma HybridIROEager_BlockIRO_f :
  equiv[LowerHybridIRO(HybridIROEager).f ~ BlockSponge.BIRO.IRO.f :
        xs{1} = x{2} /\ ={n} /\
        eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1} ==>
        ={res} /\ eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1}].
proof.
transitivity
  HybridIROEager.f
  (={xs, HybridIROEager.mp} /\ n{2} = n{1} * r /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1} ==>
   res{1} = bits2blocks res{2} /\ ={HybridIROEager.mp})
  (xs{1} = x{2} /\ n{1} = n{2} * r /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1} ==>
   res{1} = (blocks2bits res{2}) /\
   eager_invar BlockSponge.BIRO.IRO.mp{2} HybridIROEager.mp{1}).
move=> |> &1 &2 ? n_eq inv.
exists HybridIROEager.mp{1} BlockSponge.BIRO.IRO.mp{2} (xs{1}, n{1} * r).
move=> |>; by rewrite n_eq.
progress; apply blocks2bitsK.
by conseq Lower_HybridIROEager_f=> |> &1 &2 ? -> ?.
exists* n{1}; elim*=> n1; exists* xs{1}; elim*=> xs'.
conseq (HybridIROEager_f_BlockIRO_f n1 xs')=> //.
move=> |> &1 &2 ? -> inv; by rewrite needed_blocks_prod_r.
move=> |> &1 &2 ? n1_eq ? res1 res2 ? ? ? vb_imp not_vb_imp.
case: (valid_block xs{1})=> [vb_xs1 | not_vb_xs1].
have [le0_n1_imp gt0_n1_imp] := vb_imp vb_xs1.
case: (n{1} <= 0)=> [le0_n1 /# | not_le0_n1].
have gt0_n1 : 0 < n{1} by smt().
have [-> sz_res2] := gt0_n1_imp gt0_n1.
have -> : n{1} = size(blocks2bits res2)
   by rewrite size_blocks2bits sz_res2 n1_eq
              needed_blocks_prod_r mulzC.
by rewrite take_size.
by have [-> ->] := not_vb_imp not_vb_xs1.
qed.

end HybridIRO.

(* now we use HybridIRO to prove the main result *)

section.

declare module BlockSim : BlockSponge.SIMULATOR{IRO, BlockSponge.BIRO.IRO}.
declare module Dist : DISTINGUISHER{Perm, BlockSim, IRO, BlockSponge.BIRO.IRO}.

local clone HybridIRO as HIRO.

(* working toward the Real side of the main result *)

local lemma Sponge_Raise_BlockSponge_f :
  equiv[Sponge(Perm).f ~ RaiseFun(BlockSponge.Sponge(Perm)).f :
        ={bs, n, glob Perm} ==> ={res, glob Perm}].
proof.
proc; inline BlockSponge.Sponge(Perm).f.
conseq (_ : ={bs, n, glob Perm} ==> _)=> //.
swap{2} [3..5] -2.
seq 4 4 :
  (={n, glob Perm, sa, sc, i} /\ xs{1} = xs0{2} /\ z{1} = [] /\ z{2} = [] /\
   valid_block xs0{2}).
auto; progress; apply valid_pad2blocks.
rcondt{2} 2; auto. swap{2} 1 1.
seq 1 1 : 
  (={n, glob Perm, sa, sc, i} /\ xs{1} = xs0{2} /\ z{1} = [] /\ z{2} = []).
while (={glob Perm, sa, sc, i} /\ xs{1} = xs0{2} /\ z{1} = [] /\ z{2} = []).
wp. call (_ : ={glob Perm}). sim. auto. auto.
seq 0 1 : 
  (={n, glob Perm, sa, sc, i} /\ blocks2bits z{2} = z{1} /\
   n0{2} = (n{1} + r - 1) %/ r); first auto.
while (={n, glob Perm, i, sa, sc} /\ blocks2bits z{2} = z{1} /\
       n0{2} = (n{1} + r - 1) %/ r).
case (i{1} + 1 < (n{1} + r - 1) %/ r).
rcondt{1} 3; first auto. rcondt{2} 3; first auto.
call (_ : ={glob Perm}); first sim.
auto; progress; by rewrite -cats1 blocks2bits_cat blocks2bits_sing.
rcondf{1} 3; first auto. rcondf{2} 3; first auto.
auto; progress; by rewrite -cats1 blocks2bits_cat blocks2bits_sing.
auto.
qed.

(* the Real side of main result *)

local lemma RealIndif_Sponge_BlockSponge &m :
  Pr[RealIndif(Sponge, Perm, Dist).main() @ &m : res] =
  Pr[BlockSponge.RealIndif
     (BlockSponge.Sponge, Perm, LowerDist(Dist)).main() @ &m : res].
proof.
byequiv=> //; proc.
seq 2 2 : (={glob Dist, glob Perm}); first sim.
call (_ : ={glob Perm}); first 2 sim.
conseq Sponge_Raise_BlockSponge_f=> //.
auto.
qed.

(* working toward the Ideal side of the main result *)

(* first step of Ideal side: express in terms of Experiment and
   HIRO.HybridIROLazy *)

local lemma Ideal_IRO_Experiment_HybridLazy &m :
  Pr[IdealIndif(IRO, RaiseSim(BlockSim), Dist).main() @ &m : res] =
  Pr[Experiment
     (HIRO.RaiseHybridIRO(HIRO.HybridIROLazy),
      BlockSim(HIRO.LowerHybridIRO(HIRO.HybridIROLazy)),
      Dist).main() @ &m : res].
proof.
byequiv=> //; proc.
seq 2 2 :
  (={glob Dist, glob BlockSim} /\ IRO.mp{1} = empty /\
   HIRO.HybridIROLazy.mp{2} = empty).
inline*; wp; call (_ : true); auto.
call
  (_ :
   ={glob Dist, glob BlockSim} /\
   IRO.mp{1} = empty /\ HIRO.HybridIROLazy.mp{2} = empty ==>
   ={res}).
proc
  (={glob BlockSim} /\
   HIRO.lazy_invar IRO.mp{1} HIRO.HybridIROLazy.mp{2})=> //.
progress [-delta]; apply HIRO.lazy_invar0.
proc (HIRO.lazy_invar IRO.mp{1} HIRO.HybridIROLazy.mp{2})=> //;
  apply HIRO.LowerFun_IRO_HybridIROLazy_f.
proc (HIRO.lazy_invar IRO.mp{1} HIRO.HybridIROLazy.mp{2})=> //;
  apply HIRO.LowerFun_IRO_HybridIROLazy_f.
by conseq HIRO.IRO_RaiseHybridIRO_HybridIROLazy_f.
auto.
qed.

(* working toward middle step of Ideal side: using Experiment, and
   taking HIRO.HybridIROLazy to HIRO.HybridIROEager

   we will employ HIRO.HybridIROExper_Lazy_Eager *)

(* make a Hybrid IRO distinguisher from BlockSim and Dist (HI.f is
   used by BlockSim, and HI.g is used by HIRO.RaiseHybridIRO;
   HI.init is unused -- see the SIMULATOR module type) *)

local module (HybridIRODist : HIRO.HYBRID_IRO_DIST) (HI : HIRO.HYBRID_IRO) = {
  proc distinguish() : bool = {
    var b : bool;
    BlockSim(HIRO.LowerHybridIRO(HI)).init();
    b <@
      Dist(HIRO.RaiseHybridIRO(HI),
           BlockSim(HIRO.LowerHybridIRO(HI))).distinguish();
    return b;
  }
}.

(* initial bridging step *)

local lemma Experiment_HybridIROExper_Lazy &m :
  Pr[Experiment
     (HIRO.RaiseHybridIRO(HIRO.HybridIROLazy),
      BlockSim(HIRO.LowerHybridIRO(HIRO.HybridIROLazy)),
      Dist).main() @ &m : res] =
  Pr[HIRO.HybridIROExper(HIRO.HybridIROLazy, HybridIRODist).main() @ &m : res].
proof.
byequiv=> //; proc; inline*.
seq 2 2 : (={glob Dist, glob BlockSim, HIRO.HybridIROLazy.mp}).
swap{2} 1 1; wp; call (_ : true); auto.
sim.
qed.

(* final bridging step *)

local lemma HybridIROExper_Experiment_Eager &m :
  Pr[HIRO.HybridIROExper(HIRO.HybridIROEager, HybridIRODist).main() @
     &m : res] =
  Pr[Experiment
     (HIRO.RaiseHybridIRO(HIRO.HybridIROEager),
      BlockSim(HIRO.LowerHybridIRO(HIRO.HybridIROEager)),
      Dist).main() @ &m : res].
proof.
byequiv=> //; proc; inline*.
seq 2 2 : (={glob Dist, glob BlockSim, HIRO.HybridIROEager.mp}).
swap{2} 1 1; wp; call (_ : true); auto.
sim.
qed.

(* middle step of Ideal side: using Experiment, and taking HIRO.HybridIROLazy
   to HIRO.HybridIROEager *)

local lemma Experiment_Hybrid_Lazy_Eager &m :
  Pr[Experiment
     (HIRO.RaiseHybridIRO(HIRO.HybridIROLazy),
      BlockSim(HIRO.LowerHybridIRO(HIRO.HybridIROLazy)),
      Dist).main() @ &m : res] =
  Pr[Experiment
     (HIRO.RaiseHybridIRO(HIRO.HybridIROEager),
      BlockSim(HIRO.LowerHybridIRO(HIRO.HybridIROEager)),
      Dist).main() @ &m : res].
proof.
by rewrite (Experiment_HybridIROExper_Lazy &m)
           (HIRO.HybridIROExper_Lazy_Eager HybridIRODist &m)
           (HybridIROExper_Experiment_Eager &m).
qed.

(* working toward last step of Ideal side *)

local lemma RaiseHybridIRO_HybridIROEager_RaiseFun_BlockIRO_f :
  equiv[HIRO.RaiseHybridIRO(HIRO.HybridIROEager).f ~
        RaiseFun(BlockSponge.BIRO.IRO).f :
  ={bs, n} /\ ={glob BlockSim} /\
  HIRO.eager_invar BlockSponge.BIRO.IRO.mp{2} HIRO.HybridIROEager.mp{1} ==>
  ={res} /\ ={glob BlockSim} /\
  HIRO.eager_invar BlockSponge.BIRO.IRO.mp{2} HIRO.HybridIROEager.mp{1}].
proof.
proc=> /=.
exists* n{1}; elim*=> n'.
exists* (pad2blocks bs{2}); elim*=> xs2.
call (HIRO.HybridIROEager_f_BlockIRO_f n' xs2).
skip=> |> &1 &2 ? res1 res2 mp1 mp2 ? vb_imp not_vb_imp.
case: (valid_block (pad2blocks bs{2}))=> [vb | not_vb].
have [le0_n2_imp gt0_n2_imp] := vb_imp vb.
case: (n{2} <= 0)=> [le0_n2 /# | not_le0_n2].
have gt0_n2 : 0 < n{2} by smt().
by have [-> _] := gt0_n2_imp gt0_n2.
have [-> ->] := not_vb_imp not_vb; by rewrite blocks2bits_nil.
qed.

(* last step of Ideal side: express in terms of Experiment and
   HIRO.HybridIROEager *)

local lemma Experiment_HybridEager_Ideal_BlockIRO &m :
  Pr[Experiment
     (HIRO.RaiseHybridIRO(HIRO.HybridIROEager),
      BlockSim(HIRO.LowerHybridIRO(HIRO.HybridIROEager)),
      Dist).main() @ &m : res] =
  Pr[BlockSponge.IdealIndif
     (BlockSponge.BIRO.IRO, BlockSim, LowerDist(Dist)).main () @ &m : res].
proof.
byequiv=> //; proc.
seq 2 2 :
  (={glob Dist, glob BlockSim} /\ HIRO.HybridIROEager.mp{1} = empty /\
   BlockSponge.BIRO.IRO.mp{2} = empty).
inline*; wp; call (_ : true); auto.
call
  (_ :
  ={glob Dist, glob BlockSim} /\
  HIRO.HybridIROEager.mp{1} = empty /\ BlockSponge.BIRO.IRO.mp{2} = empty ==>
  ={res}).
proc
   (={glob BlockSim} /\
    HIRO.eager_invar BlockSponge.BIRO.IRO.mp{2} HIRO.HybridIROEager.mp{1})=> //.
progress [-delta]; apply HIRO.eager_invar0.
proc (HIRO.eager_invar BlockSponge.BIRO.IRO.mp{2}
                       HIRO.HybridIROEager.mp{1})=> //;
  conseq HIRO.HybridIROEager_BlockIRO_f=> //.
proc (HIRO.eager_invar BlockSponge.BIRO.IRO.mp{2}
                       HIRO.HybridIROEager.mp{1})=> //;
  conseq HIRO.HybridIROEager_BlockIRO_f=> //.
conseq RaiseHybridIRO_HybridIROEager_RaiseFun_BlockIRO_f=> //.
auto.
qed.

(* the Ideal side of main result *)

local lemma IdealIndif_IRO_BlockIRO &m :
  Pr[IdealIndif(IRO, RaiseSim(BlockSim), Dist).main() @ &m : res] =
  Pr[BlockSponge.IdealIndif
     (BlockSponge.BIRO.IRO, BlockSim, LowerDist(Dist)).main () @ &m : res].
proof.
by rewrite (Ideal_IRO_Experiment_HybridLazy &m)
           (Experiment_Hybrid_Lazy_Eager &m)
           (Experiment_HybridEager_Ideal_BlockIRO &m).
qed.

lemma conclu &m :
  `|Pr[RealIndif(Sponge, Perm, Dist).main() @ &m : res] -
    Pr[IdealIndif(IRO, RaiseSim(BlockSim), Dist).main() @ &m : res]| =
  `|Pr[BlockSponge.RealIndif
       (BlockSponge.Sponge, Perm, LowerDist(Dist)).main() @ &m : res] -
    Pr[BlockSponge.IdealIndif
       (BlockSponge.BIRO.IRO, BlockSim, LowerDist(Dist)).main() @ &m : res]|.
proof.
by rewrite (RealIndif_Sponge_BlockSponge &m) (IdealIndif_IRO_BlockIRO &m).
qed.

end section.

(*----------------------------- Conclusion -----------------------------*)

lemma conclusion
      (BlockSim <: BlockSponge.SIMULATOR{IRO, BlockSponge.BIRO.IRO})
      (Dist <: DISTINGUISHER{Perm, BlockSim, IRO, BlockSponge.BIRO.IRO})
      &m :
  `|Pr[RealIndif(Sponge, Perm, Dist).main() @ &m : res] -
    Pr[IdealIndif(IRO, RaiseSim(BlockSim), Dist).main() @ &m : res]| =
  `|Pr[BlockSponge.RealIndif
       (BlockSponge.Sponge, Perm, LowerDist(Dist)).main() @ &m : res] -
    Pr[BlockSponge.IdealIndif
       (BlockSponge.BIRO.IRO, BlockSim, LowerDist(Dist)).main() @ &m : res]|.
proof. by apply (conclu BlockSim Dist &m). qed.

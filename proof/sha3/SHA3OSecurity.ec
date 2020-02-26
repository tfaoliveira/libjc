(* Top-level Proof of SHA-3 Security *)

require import AllCore Distr DList DBool List IntExtra IntDiv Dexcepted DProd SmtMap FSet.
require import Common SLCommon Sponge SHA3_OIndiff.
require (****) SecureORO SecureHash.
(*****) import OIndif.

require import PROM.


(* module SHA3 (P : DPRIMITIVE) = { *)
(*   proc init() : unit = {} *)
(*   proc f (bl : bool list, n : int) : bool list = { *)
(*     var r : bool list; *)
(*     r <@ Sponge(P).f(bl ++ [false; true], n); *)
(*     return r; *)
(*   } *)
(* }. *)

op    size_out     : int.
axiom size_out_gt0 : 0 < size_out.

op    sigma     : int = SHA3Indiff.limit.
axiom sigma_ge0 : 0 <= sigma.

op limit : int = sigma.

type  f_out.

op    dout      : f_out distr.
axiom dout_ll   : is_lossless dout.
axiom dout_fu   : is_funiform dout.
axiom dout_full : is_full dout.


op    to_list : f_out -> bool list.
op    of_list : bool list -> f_out option.
axiom spec_dout (l : f_out) : size (to_list l) = size_out.
axiom spec2_dout (l : bool list) : size l = size_out => of_list l <> None.
axiom to_list_inj : injective to_list.
axiom to_listK e l : to_list e = l <=> of_list l = Some e.

axiom dout_equal_dlist : dmap dout to_list = dlist dbool size_out.

lemma doutE1 x : mu1 dout x = inv (2%r ^ size_out).
proof.
cut->:inv (2%r ^ size_out) = mu1 (dlist dbool size_out) (to_list x). 
+ rewrite dlist1E.
  - smt(size_out_gt0).
  rewrite spec_dout/=.
  pose p:= StdBigop.Bigreal.BRM.big _ _ _.
  cut->: p = StdBigop.Bigreal.BRM.big predT (fun _ => inv 2%r) (to_list x).
  - rewrite /p =>{p}. 
    apply StdBigop.Bigreal.BRM.eq_bigr.
    by move=> i; rewrite//= dbool1E.
  rewrite StdBigop.Bigreal.BRM.big_const count_predT spec_dout=> {p}. 
  have:=size_out_gt0; move/ltzW.
  move:size_out;apply intind=> //=. 
  - by rewrite powr0 iter0 //= fromint1.
  move=> i hi0 rec.
  by rewrite powrS//iterS// -rec; smt().
rewrite -dout_equal_dlist dmap1E.
apply mu_eq.
by move=> l; rewrite /pred1/(\o); smt(to_listK).
qed.


(* module CSetSize (F : OCONSTRUCTION) (P : ODPRIMITIVE) = { *)
(*   proc init = F(P).init *)
(*   proc f (x : bool list) = { *)
(*     var r, l; *)
(*     r <@ F(P).f(x,size_out); *)
(*     l <- (r <> None) ? of_list (oget r) : None; *)
(*     return l; *)
(*   } *)
(* }. *)

(* module FSetSize (F : OFUNCTIONALITY) = { *)
(*   proc init = F.init *)
(*   proc f (x : bool list) = { *)
(*     var r, l; *)
(*     r <@ F.f(x,size_out); *)
(*     l <- (r <> None) ? of_list (oget r) : None; *)
(*     return l; *)
(*   } *)
(* }. *)

clone import SecureORO as SORO with
  type from   <- bool list,
  type to     <- f_out,

  op sampleto <- dout,
  op bound    <- sigma,
  op increase_counter <- fun c m => c + ((size m + 1) %/ r + 1) +
        max ((size_out + r - 1) %/ r - 1) 0

  proof *. 
realize bound_ge0             by exact(sigma_ge0).
realize sampleto_ll           by exact(dout_ll).
realize sampleto_fu           by exact(dout_fu).
realize sampleto_full         by exact(dout_full).
realize increase_counter_spec by smt(List.size_ge0 divz_ge0 gt0_r).


clone import SecureHash as SH with
  type from   <- bool list,
  type to     <- f_out,
  type block  <- state,
  op sampleto <- dout,
  op bound    <- sigma,
  op increase_counter <- fun c m => c + ((size m + 1) %/ r + 1) +
        max ((size_out + r - 1) %/ r - 1) 0
proof *. 
realize sampleto_ll           by exact(dout_ll).
realize sampleto_fu           by exact(dout_fu).
realize sampleto_full         by exact(dout_full).
realize bound_ge0             by exact(sigma_ge0).
realize increase_counter_spec by smt(List.size_ge0 divz_ge0 gt0_r).


(* module FGetSize (F : ODFUNCTIONALITY) = { *)
(*   proc f (x : bool list, i : int) = { *)
(*     var r; *)
(*     r <@ F.f(x); *)
(*     return to_list r; *)
(*   } *)
(* }. *)

(* module SimSetSize (S : SIMULATOR) (F : Indiff0.DFUNCTIONALITY) = S(FGetSize(F)). *)

(* module DFSetSize (F : DFUNCTIONALITY) = { *)
(*   proc f (x : bool list) = { *)
(*     var r; *)
(*     r <@ F.f(x,size_out); *)
(*     return oget (of_list r); *)
(*   } *)
(* }. *)

(* module (DSetSize (D : Indiff0.DISTINGUISHER) : DISTINGUISHER) *)
(*   (F : DFUNCTIONALITY) (P : DPRIMITIVE) = D(DFSetSize(F),P). *)


module FSetSize (F : OFUNCTIONALITY) : OIndif.OFUNCTIONALITY = {
  proc init = F.init
  proc f (x : bool list) = {
    var y, r;
    y <@ F.f(x,size_out);
    r <- (y <> None) ? of_list (oget y) : None;
    return r;
  }
  proc get = f
}.

module DFSetSize (F : ODFUNCTIONALITY) : OIndif.OFUNCTIONALITY = {
  proc init () = {}
  proc f (x : bool list) = {
    var y, r;
    y <@ F.f(x,size_out);
    r <- (y <> None) ? of_list (oget y) : None;
    return r;
  }
}.

module FIgnoreSize (F : OIndif.ODFUNCTIONALITY) : OFUNCTIONALITY = {
  proc init () = {}
  proc f (x : bool list, i : int) = {
    var y, r;
    y <@ F.f(x);
    return omap to_list r;
  }
}.

module (OSponge : OIndif.OCONSTRUCTION) (P : OIndif.ODPRIMITIVE) = 
  FSetSize(CSome(Sponge,P)).


clone import Program as PBool with
  type t <- bool,
  op d <- dbool
proof *.

clone import GenEager as Eager with
  type from <- bool list * int,
  type to <- bool,
  op sampleto <- fun _ => dbool,
  type input <- unit,
  type output <- bool
proof * by smt(dbool_ll).

section Preimage.

  declare module A : SH.AdvPreimage { Perm, Counter, Bounder, F.RO, F.FRO, 
    Redo, C, Gconcl.S, BlockSponge.BIRO.IRO, BlockSponge.C, BIRO.IRO, 
    Gconcl_list.BIRO2.IRO, Gconcl_list.F2.RO, Gconcl_list.F2.FRO, 
    Gconcl_list.Simulator, SHA3Indiff.Simulator, SHA3Indiff.Cntr, 
    SORO.Bounder, SORO.RO.RO, RO, FRO }.

  local module FInit (F : OIndif.ODFUNCTIONALITY) : OIndif.OFUNCTIONALITY = {
    proc init () = {}
    proc f = F.f
  }.

  local module PInit (P : ODPRIMITIVE) : OPRIMITIVE = {
    proc init () = {}
    proc f  = P.f
    proc fi = P.fi
  }.


local module OF (F : Oracle) : OIndif.ODFUNCTIONALITY = {
  proc f = F.get
}.


local module Log = {
  var m : (bool list * int, bool) fmap
}.

local module ExtendOutputSize (F : Oracle) : ODFUNCTIONALITY = {
  proc f (x : bool list, k : int) = {
    var o, l, suffix, prefix, i;
    l <- None;
    prefix <- [];
    suffix <- [];
    o <@ F.get(x);
    prefix <- take k (to_list (oget o));
    i <- size_out;
    while (i < k) {
      if ((x,i) \notin Log.m) {
        Log.m.[(x,i)] <$ {0,1};
      }
      suffix <- rcons suffix (oget Log.m.[(x,i)]);
      i <- i + 1;
    }
    l <- Some (prefix ++ suffix);
    return l;
  }
}.

local module OFC2 (F : Oracle) = OFC(ExtendOutputSize(F)).

local module ExtendOutput (F : RF) = {
  proc init () = {
    Log.m <- empty;
    F.init();
  }
  proc f = ExtendOutputSize(F).f
  proc get = f
}.

  local module (Dist_of_P1Adv (A : SH.AdvPreimage) : ODISTINGUISHER) (F : ODFUNCTIONALITY) (P : ODPRIMITIVE) = {
    proc distinguish () = {
      var hash, hash', m;
      Log.m <- empty;
      hash <$ dout;
      m <@ A(DFSetSize(F),P).guess(hash);
      hash' <@ DFSetSize(F).f(m);
      return hash' = Some hash;
    }
  }.
  

local module (SORO_P1 (A : SH.AdvPreimage) : SORO.AdvPreimage) (F : Oracle) = {
  proc guess (h : f_out) : bool list = {
    var mi;
    Log.m <- empty;
    Counter.c <- 0;
    OSimulator(ExtendOutputSize(F)).init();
    mi <@ A(DFSetSize(OFC2(F)),OPC(OSimulator(ExtendOutputSize(F)))).guess(h);
    return mi;
  }
}.

local module RFList = {
  var m : (bool list, f_out) fmap
  proc init () = {
    m <- empty;
  }
  proc get (x : bool list) : f_out option = {
    var z;
    if (x \notin m) {
      z <$ dlist dbool size_out;
      m.[x] <- oget (of_list z);
    }
    return m.[x];
  }
  proc sample (x: bool list) = {}
}.

local module RFWhile = {
  proc init () = {
    RFList.m <- empty;
  }
  proc get (x : bool list) : f_out option = {
    var l, i, b;
    if (x \notin RFList.m) {
      i <- 0;
      l <- [];
      while (i < size_out) {
        b <$ dbool;
        l <- rcons l b;
        i <- i + 1;
      }
      RFList.m.[x] <- oget (of_list l);
    }
    return RFList.m.[x];
  }
  proc sample (x: bool list) = {}
}.

local equiv rw_RF_List_While :
    RFList.get ~ RFWhile.get : 
    ={arg, glob RFList} ==> ={res, glob RFWhile}.
proof.
proc; if; 1, 3: auto; wp.
conseq(:_==> z{1} = l{2})=> />.
transitivity{1} {
    z <@ Sample.sample(size_out);
  }
  (true ==> ={z})
  (true ==> z{1} = l{2})=>/>.
+ by inline*; auto.
transitivity{1} {
    z <@ LoopSnoc.sample(size_out);
  }
  (true ==> ={z})
  (true ==> z{1} = l{2})=>/>; last first.
+ inline*; auto; sim.
  by while(={l, i} /\ n{1} = size_out); auto; smt(cats1).
by call(Sample_LoopSnoc_eq); auto.
qed.


op inv (m1 : (bool list * int, bool) fmap) (m2 : (bool list, f_out) fmap) =
  (forall l i, (l,i) \in m1 => 0 <= i < size_out) /\
  (forall l i, (l,i) \in m1 => l \in m2) /\ 
  (forall l, l \in m2 => forall i, 0 <= i < size_out => (l,i) \in m1) /\ 
  (forall l i, (l,i) \in m1 => m1.[(l,i)] = Some (nth witness (to_list (oget m2.[l])) i)).

local equiv eq_IRO_RFWhile :
  BIRO.IRO.f ~ RFWhile.get :
  arg{1} = (x{2}, size_out) /\ inv BIRO.IRO.mp{1} RFList.m{2}
  ==>
  res{2} = of_list res{1} /\ size res{1} = size_out /\ inv BIRO.IRO.mp{1} RFList.m{2}.
proof.
proc; inline*; sp.
rcondt{1} 1; 1: by auto.
if{2}; sp; last first.
+ alias{1} 1 mp = BIRO.IRO.mp.
  conseq(:_==> BIRO.IRO.mp{1} = mp{1} /\ size bs{1} = i{1} /\ i{1} = size_out /\
        inv mp{1} RFList.m{2} /\
        bs{1} = take i{1} (to_list (oget RFList.m{2}.[x{1}])))=> />.
  - move=> &l &r 12?.
    rewrite take_oversize 1:spec_dout 1:H4 //.
    rewrite eq_sym to_listK => ->.
    by have:=H3; rewrite domE; smt().
  - smt(take_oversize spec_dout).
  while{1}(BIRO.IRO.mp{1} = mp{1} /\ size bs{1} = i{1} /\ 
        0 <= i{1} <= size_out /\ n{1} = size_out /\
        inv mp{1} RFList.m{2} /\ x{1} \in RFList.m{2} /\
        bs{1} = take i{1} (to_list (oget RFList.m{2}.[x{1}])))(size_out - i{1});
      auto=> />.
  + sp; rcondf 1; auto=> />; 1: smt().
    move=> &h 9?.
    rewrite size_rcons //=; do!split; 1, 2, 4: smt(size_ge0).
    rewrite (take_nth witness) 1:spec_dout 1:size_ge0//=. 
    rewrite - H6; congr; rewrite H4=> //=.
    by apply H3=> //=.
  smt(size_out_gt0 size_ge0 take0).
auto=> //=.
conseq(:_==> l{2} = bs{1} /\ size bs{1} = i{1} /\ i{1} = n{1} /\ n{1} = size_out /\
  inv BIRO.IRO.mp{1} RFList.m{2}.[x{2} <- oget (of_list l{2})])=> />. 
+ smt(get_setE spec2_dout).
+ smt(get_setE spec2_dout).
alias{1} 1 m = BIRO.IRO.mp; sp.
conseq(:_==> l{2} = bs{1} /\ size bs{1} = i{1} /\ i{1} = n{1} /\ 
  n{1} = size_out /\ inv m{1} RFList.m{2} /\
  (forall j, (x{1}, j) \in BIRO.IRO.mp{1} => 0 <= j < i{1}) /\
  (forall l j, l <> x{1} => m{1}.[(l,j)] = BIRO.IRO.mp{1}.[(l,j)]) /\
  (forall j, 0 <= j < i{1} => (x{1}, j) \in BIRO.IRO.mp{1}) /\
  (forall j, 0 <= j < i{1} => BIRO.IRO.mp{1}.[(x{1},j)] = Some (nth witness bs{1} j))).
+ move=> /> &l &r 12?; do!split; ..-2 : smt(domE mem_set).
  move=> l j Hin.
  rewrite get_setE/=.
  case: (l = x{r}) => [<<-|].
  - rewrite oget_some H8; 1:smt(); congr; congr.
    by rewrite eq_sym to_listK; smt(spec2_dout).
  move=> Hneq.
  by rewrite -(H6 _ _ Hneq) H2; smt(domE).
while(l{2} = bs{1} /\ size bs{1} = i{1} /\ 0 <= i{1} <= n{1} /\ ={i} /\
  n{1} = size_out /\ inv m{1} RFList.m{2} /\
  (forall j, (x{1}, j) \in BIRO.IRO.mp{1} => 0 <= j < i{1}) /\
  (forall l j, l <> x{1} => m{1}.[(l,j)] = BIRO.IRO.mp{1}.[(l,j)]) /\
  (forall j, 0 <= j < i{1} => (x{1}, j) \in BIRO.IRO.mp{1}) /\
  (forall j, 0 <= j < i{1} => BIRO.IRO.mp{1}.[(x{1},j)] = Some (nth witness bs{1} j))).
+ sp; rcondt{1} 1; auto=> />.
  - smt().
  move=> &l &r *.
  rewrite get_setE /= size_rcons /=; do!split; 1,2: smt(size_ge0).
  - smt(mem_set).
  - smt(get_setE).
  - smt(mem_set).
  - move=>j Hj0 Hjsize; rewrite get_setE/=nth_rcons.
    case: (j = size bs{l})=>[->>//=|h].
    have/=Hjs:j < size bs{l} by smt().
    by rewrite Hjs/=H8//=.
by auto; smt(size_out_gt0).
qed.

op eq_extend_size (m1 : (bool list * int, bool) fmap) (m2 : (bool list * int, bool) fmap)
  (m3 : (bool list * int, bool) fmap) =
  (* (forall x j, (x,j) \in m2 => 0 <= j < size_out) /\ *)
  (* (forall x j, (x,j) \in m2 => forall k, 0 <= k < size_out => (x, k) \in m2) /\ *)  
  (forall x j, 0 <= j < size_out => m1.[(x,j)] = m2.[(x,j)]) /\
  (forall x j, size_out <= j => m1.[(x,j)] = m3.[(x,j)]) /\
  (forall x j, (x,j) \in m1 => 0 <= j).

local module ExtendSample (F : OFUNCTIONALITY) = {
  proc init = F.init
  proc f (x : bool list, k : int) = {
    var y;
    if (k <= size_out) {
      y <@ F.f(x,size_out);
      y <- omap (take k) y;
    } else {
      y <@ F.f(x,k);
    }
    return y;
  }
}.


local equiv eq_extend :
  ExtendSample(FSome(BIRO.IRO)).f ~ ExtendOutputSize(FSetSize(FSome(BIRO.IRO))).f :
  ={arg} /\ eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2} ==>
  ={res} /\ eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2}.
proof.
proc; inline*; auto; sp.
rcondt{2} 1; 1: auto.
if{1}; sp.
- rcondt{1} 1; auto.
  rcondf{2} 8; 1: auto.
  - conseq(:_==> true); 1: smt(). 
    by while(true); auto.
  auto=> /=.
  conseq(:_==> ={bs, k} /\ size bs{1} = size_out /\
    eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2})=> //=.
  - smt(cats0 to_listK spec2_dout).
  while(={k, bs, n, x2} /\ i{1} = i0{2} /\ n{1} = size_out /\
      0 <= i{1} <= n{1} /\ size bs{1} = i{1} /\
      eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2}).
  - by sp; if; auto; smt(domE get_setE size_rcons).
  by auto; smt(size_eq0 size_out_gt0).
rcondt{1} 1; 1: auto.
splitwhile{1} 1 : i0 < size_out; auto=> /=.
while( (i0, n0, x3){1} = (i, k, x){2} /\ bs0{1} = prefix{2} ++ suffix{2} /\
    size_out <= i{2} <= k{2} /\ eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2}).
+ by sp; if; auto; smt(domE get_setE size_out_gt0 rcons_cat).
auto=> //=.
conseq(:_==> ={i0} /\ size bs{2} = i0{1} /\ (i0, x3){1} = (n, x2){2} /\
    bs0{1} = bs{2} /\ size bs{2} = size_out /\
    eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2}). 
+ smt(cats0 take_oversize spec_dout to_listK spec2_dout).
while(={i0} /\ x3{1} = x2{2} /\ 0 <= i0{1} <= n{2} /\ n{2} = size_out /\
    bs0{1} = bs{2} /\ size bs{2} = i0{1} /\ size_out <= n0{1} /\
    eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2}).
+ by sp; if; auto; smt(size_rcons domE get_setE size_rcons mem_set).
by auto; smt(size_out_gt0).
qed.


local lemma of_listK l : of_list (to_list l) = Some l.
proof.
by rewrite -to_listK.
qed.

local module Fill_In (F : RO) = {
  proc init = F.init
  proc f (x : bool list, n : int) = {
    var l, b, i;
    i <- 0;
    l <- [];
    while (i < n) {
      b <@ F.get((x,i));
      l <- rcons l b;
      i <- i + 1;
    }
    while (i < size_out) {
      F.sample((x,i));
      i <- i + 1;
    }
    return l;
  }
}.


local equiv eq_eager_ideal :
  BIRO.IRO.f ~ Fill_In(LRO).f :
  ={arg} /\ BIRO.IRO.mp{1} = RO.m{2} ==>
  ={res} /\ BIRO.IRO.mp{1} = RO.m{2}.
proof.
proc; inline*; sp; rcondt{1} 1; auto.
while{2}(bs{1} = l{2} /\ BIRO.IRO.mp{1} = RO.m{2})(size_out - i{2}).
+ by auto=> />; smt().
conseq(:_==> bs{1} = l{2} /\ BIRO.IRO.mp{1} = RO.m{2}); 1: smt().
while(={i, n, x} /\ bs{1} = l{2} /\ BIRO.IRO.mp{1} = RO.m{2}).
+ sp; if{1}.
  - by rcondt{2} 2; auto=> />.
  by rcondf{2} 2; auto=> />; smt(dbool_ll).
by auto.
qed.

local equiv eq_eager_ideal2 :
  ExtendSample(FSome(BIRO.IRO)).f ~ FSome(Fill_In(RO)).f :
  ={arg} /\ BIRO.IRO.mp{1} = RO.m{2} ==>
  ={res} /\ BIRO.IRO.mp{1} = RO.m{2}.
proof.
proc; inline*; sp.
if{1}; sp.
+ rcondt{1} 1; auto=> /=/>.
  conseq(:_==> take k{1} bs{1} = l{2} /\ BIRO.IRO.mp{1} = RO.m{2}).
  * smt().
  case: (0 <= n{2}); last first.
  + rcondf{2} 1; 1: by auto; smt(). 
    conseq(:_==> BIRO.IRO.mp{1} = RO.m{2} /\ ={i} /\ n{1} = size_out /\ x2{1} = x0{2})=> />.
    - smt(take_le0).
    while(={i} /\ x2{1} = x0{2} /\ n{1} = size_out /\ BIRO.IRO.mp{1} = RO.m{2}).
    - sp; if{1}.
      - by rcondt{2} 2; auto=> />.
      by rcondf{2} 2; auto=> />; smt(dbool_ll).
    by auto=> />.
  splitwhile{1} 1 : i < k.
  while(={i} /\ n{1} = size_out /\ x2{1} = x0{2} /\  BIRO.IRO.mp{1} = RO.m{2} /\
      take k{1} bs{1} = l{2} /\ size bs{1} = i{1} /\ k{1} <= i{1} <= size_out).
  * sp; if{1}.
    - by rcondt{2} 2; auto; smt(dbool_ll cats1 take_cat cats0 take_size size_rcons).
    by rcondf{2} 2; auto; smt(dbool_ll cats1 take_cat cats0 take_size size_rcons).
  conseq(:_==> ={i} /\ n{1} = size_out /\ x2{1} = x0{2} /\  BIRO.IRO.mp{1} = RO.m{2} /\
      bs{1} = l{2} /\ size bs{1} = i{1} /\ k{1} = i{1}).
  + smt(take_size).
  while(={i} /\ x2{1} = x0{2} /\ n{1} = size_out /\ k{1} = n{2} /\
      0 <= i{1} <= k{1} <= size_out /\ bs{1} = l{2} /\ size bs{1} = i{1} /\
      BIRO.IRO.mp{1} = RO.m{2}).
  + sp; if{1}.
    - by rcondt{2} 2; auto; smt(size_rcons).
    by rcondf{2} 2; auto; smt(size_rcons dbool_ll).
  by auto; smt(size_ge0 size_out_gt0).
rcondt{1} 1; auto.
rcondf{2} 2; 1: auto.
+ conseq(:_==> i = n); 1: smt().
  by while(i <= n); auto=> />; smt(size_out_gt0).
while(i0{1} = i{2} /\ x3{1} = x0{2} /\ n0{1} = n{2} /\ bs0{1} = l{2} /\ 
    BIRO.IRO.mp{1} = RO.m{2}).
+ sp; if{1}.
  - by rcondt{2} 2; auto=> />.
  by rcondf{2} 2; auto; smt(dbool_ll).
by auto=> />.
qed.

local module Dist (F : RO) = {
  proc distinguish = SHA3_OIndiff.OIndif.OIndif(FSome(Fill_In(F)),
      OSimulator(FSome(Fill_In(F))), ODRestr(Dist_of_P1Adv(A))).main
}.

local module Game (F : RO) = {
  proc distinguish () = {
    var bo;
    OSimulator(FSome(Fill_In(F))).init();
    Counter.c <- 0;
    Log.m <- empty;
    F.init();
    bo <@ Dist(F).distinguish();
    return bo;
  }
}.

local lemma eager_ideal &m :
    Pr[SHA3_OIndiff.OIndif.OIndif(FSome(BIRO.IRO),
      OSimulator(FSome(BIRO.IRO)),
      ODRestr(Dist_of_P1Adv(A))).main() @ &m : res] =
    Pr[SHA3_OIndiff.OIndif.OIndif(ExtendSample(FSome(BIRO.IRO)),
      OSimulator(ExtendSample(FSome(BIRO.IRO))),
      ODRestr(Dist_of_P1Adv(A))).main() @ &m : res].
proof.
cut->: 
  Pr[SHA3_OIndiff.OIndif.OIndif(FSome(BIRO.IRO),
    OSimulator(FSome(BIRO.IRO)),
    ODRestr(Dist_of_P1Adv(A))).main() @ &m : res] =
  Pr[Game(LRO).distinguish() @ &m : res].
+ byequiv=> //=; proc.
  inline{2} 1; sp; inline{2} 1; sp; inline{2} 1; sp; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp; sim.
  seq 2 2 : (={hash, m, glob OFC} /\ BIRO.IRO.mp{1} = RO.m{2}); last first.
  - inline{1} 1; inline{2} 1; sp; sim.
    inline{1} 1; inline{2} 1; sp; sim; if; auto.
    inline{1} 1; inline{2} 1; sp; sim.
    by call eq_eager_ideal; auto.
  call(: ={glob OFC, glob OSimulator} /\ BIRO.IRO.mp{1} = RO.m{2}); auto.
  - proc; sp; if; auto.
    inline{1} 1; inline{2} 1; sp; sim; if; 1: auto; sim.
    if; 1: auto; sim; sp.
    if; 1: auto; 1: smt(); sim.
    * inline{1} 1; inline{2} 1; sp; sim.
      by call eq_eager_ideal; auto; smt().
    smt().
  - by proc; inline*; sim.
  proc; sim.
  inline{1} 1; inline{2} 1; sp; sim; if; 1: auto; sim.
  inline{1} 1; inline{2} 1; sp; sim.
  by call eq_eager_ideal; auto.
cut->: 
  Pr[SHA3_OIndiff.OIndif.OIndif(ExtendSample(FSome(BIRO.IRO)),
    OSimulator(ExtendSample(FSome(BIRO.IRO))),
    ODRestr(Dist_of_P1Adv(A))).main() @ &m : res] =
  Pr[Game(RO).distinguish() @ &m : res].
+ byequiv=>//=; proc.
  inline{2} 1; sp; inline{2} 1; sp; inline{2} 1; sp; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp; sim.
  seq 2 2 : (={hash, m, glob OFC} /\ BIRO.IRO.mp{1} = RO.m{2}); last first.
  - inline{1} 1; inline{2} 1; sp; sim.
    inline{1} 1; inline{2} 1; sp; sim; if; auto.
    by call eq_eager_ideal2; auto.
  call(: ={glob OFC, glob OSimulator} /\ BIRO.IRO.mp{1} = RO.m{2}); auto.
  - proc; sp; if; auto.
    inline{1} 1; inline{2} 1; sp; sim; if; 1: auto; sim.
    if; 1: auto; sim; sp.
    if; 1: auto; 1: smt(); sim.
    * by call eq_eager_ideal2; auto; smt().
    smt().
  - by proc; inline*; sim.
  proc; sim.
  inline{1} 1; inline{2} 1; sp; sim; if; 1: auto; sim.
  by call eq_eager_ideal2; auto.
rewrite eq_sym; byequiv=> //=; proc. 
call(RO_LRO_D Dist); inline*; auto=> />.
qed.

local lemma rw_ideal_2 &m:
    Pr[SHA3_OIndiff.OIndif.OIndif(FSome(BIRO.IRO), OSimulator(FSome(BIRO.IRO)), 
      ODRestr(Dist_of_P1Adv(A))).main() @ &m : res] <=
    Pr[SORO.Preimage(SORO_P1(A), RFList).main() @ &m : res].
proof.
have->:Pr[SORO.Preimage(SORO_P1(A), RFList).main() @ &m : res] =
       Pr[SORO.Preimage(SORO_P1(A), RFWhile).main() @ &m : res].
+ byequiv(: ={glob A} ==> _)=>//=; proc.
  swap 1.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 2; inline{2} 2; sp.
  swap[1..2] 3; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 5; inline{2} 5; wp.
  seq 3 3 : (={mi, h, hash, glob A, glob SORO.Bounder, glob RFList}); last first.
  - sp; if; auto; call(rw_RF_List_While); auto.
  call(: ={glob SORO.Bounder, glob RFList, glob OSimulator, glob OPC, glob Log}); auto.
  - proc; sp; if; auto.
    inline{1} 1; inline{2} 1; sp; if; 1, 3: auto; sim.
    if; 1: auto; sim; sp; sim; if; auto=> />; 1: smt(); sim.
    + inline{1} 1; inline{2} 1; sp; sim.
      inline{1} 1; inline{2} 1; sp; if; auto=> />.
      - by call(rw_RF_List_While); auto; smt(). 
      smt().
    smt().
  - by sim. 
  proc; sim; inline{1} 1; inline{2} 1; sp; if; auto.
  inline{1} 1; inline{2} 1; sp; sim.
  inline{1} 1; inline{2} 1; sp; if; auto; sim.
  by call(rw_RF_List_While); auto.
rewrite (eager_ideal &m).
have->:Pr[SHA3_OIndiff.OIndif.OIndif(ExtendSample(FSome(BIRO.IRO)),
         OSimulator(ExtendSample(FSome(BIRO.IRO))),
          ODRestr(Dist_of_P1Adv(A))).main() @ &m : res] =
       Pr[SHA3_OIndiff.OIndif.OIndif(ExtendSample(FSome(BIRO.IRO)),
         OSimulator(ExtendOutputSize(FSetSize(FSome(BIRO.IRO)))),
         ODRestr(Dist_of_P1Adv(A))).main() @ &m : res].
+ byequiv=> //=; proc; inline*; sp.
  seq 2 2 : (={m, hash, glob OSimulator, glob OFC} /\
         eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2}); last first.
  - sp; if; auto; sp; if; auto; sp; rcondt{1}1; 1: auto. 
    * rcondt{2} 1; 1: auto.
      while(={i, n, bs, x3} /\ size bs{1} = i{1} /\
           eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2} /\
           n{1} = size_out /\ 0 <= i{1} <= n{1}); auto.
      * by sp; if; auto; smt(domE get_setE size_rcons).
      smt(size_out_gt0 take_oversize size_out_gt0).
    * by auto; rcondf{1} 1; auto.
    * rcondt{2} 1; 1: auto; move=> />; auto.
      by while(={i0, n0}); auto; sp; if{1}; if{2}; auto; smt(dbool_ll).
  call(: ={glob OSimulator, glob OFC} /\
         eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2}); last first; auto.
  + smt(mem_empty).
  + proc; sp; if; auto. 
    inline{1} 1; inline{2} 1; sp; if; 1, 3: auto.
    if; 1, 3: auto; sp.
    if; 1: auto; 1: smt(); last first.
    - by conseq=> />; sim; smt().
    wp=> />; 1: smt().
    rnd; auto=> />. 
    call(eq_extend); last by auto; smt().
  + by proc; sp; if; auto; inline{1} 1; inline{2} 1; sp; if; auto.
  proc; sp; inline{1} 1; inline{2} 1; sp; if; auto.
  inline*; sp.
  rcondt{1} 1; 1: auto; rcondt{2} 1; 1: auto; sp.
  rcondt{1} 1; 1: auto; rcondt{2} 1; 1: auto; sp; auto.
  conseq(:_==> ={bs} /\ eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2}); 
    1: by auto.
  while(={i, n, x3, bs} /\ 0 <= i{1} <= size_out /\ n{1} = size_out /\ 
      eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2}).
  - by sp; if; auto; smt(domE get_setE size_rcons).
  by auto; smt(size_out_gt0).
byequiv=> //=; proc.
inline{1} 1; inline{2} 2; sp.
inline{1} 1; inline{2} 3; swap{2}[1..2]1; sp.
inline{1} 1; inline{2} 3; sp.
inline{1} 1; sp.
inline{1} 1; sp.
swap{2} 1 1; sp; swap{2}[1..2]3; sp.
inline{1} 1; sp; auto. 
seq 2 5 : (={glob A, glob OSimulator, glob Counter, glob Log, hash, m} /\
         inv BIRO.IRO.mp{1} RFList.m{2} /\
         SORO.Bounder.bounder{2} <= Counter.c{1}); last first.
+ inline{1} 1; inline{2} 1; sp; inline{1} 1; sp; auto.
  if{1}; sp; last first.
  - conseq(:_==> true)=> />.
    inline*; if{2}; auto; sp; if{2}; auto.
    by while{2}(true)(size_out - i{2}); auto=>/>; smt(dbool_ll).
  rcondt{2} 1; 1: by auto=> />; smt(divz_ge0 gt0_r size_ge0).
  inline{1} 1; sp; auto.
  rcondt{1} 1; auto=> /=. 
  inline{1} 1; sp; auto.
  by call(eq_IRO_RFWhile); auto; smt(take_oversize).
auto; call(: ={glob OSimulator, glob Counter, glob Log} /\ 
    inv BIRO.IRO.mp{1} RFList.m{2} /\
    SORO.Bounder.bounder{2} <= Counter.c{1}); auto; last first.
+ by inline*; auto; smt(mem_empty).
+ proc; sp; if; auto=> />; 1: smt(). 
  inline{1} 1; inline{2} 1; sp; auto.
  if; 1, 3: auto; -1: smt().
  if; 1, 3: auto; -1: smt().
  sp; if; 1: auto; 1: smt(); last first.
  - by conseq(:_==> ={y, glob OSimulator}); 1: smt(); sim; smt().
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  rcondt{2} 1; 1: by auto; smt().
  sp.
  seq 3 2 : (={x0, x1, o1, k0, Log.m, suffix, glob OSimulator} /\
      inv BIRO.IRO.mp{1} RFList.m{2} /\ 
      SORO.Bounder.bounder{2} <= Counter.c{2} + 1); last first.
  - by conseq(:_==> ={y, x1, glob OSimulator, Log.m}); 1: smt(); sim=> />.
  inline{1} 1; auto.
  by call(eq_IRO_RFWhile); auto; smt().
+ by proc; inline*; sp; if; auto; sp; if; auto=> />; smt().
proc.
inline{1} 1; inline{2} 1; sp; if; auto=> /=.
inline{1} 1; inline{2} 1; sp.
rcondt{1} 1; 1: auto.
inline{1} 1; auto.
rcondf{2} 4; 1: auto. 
+ inline*; auto; sp; if; auto; sp; if; auto=> />; conseq(:_==> true); 1: smt().
  by while(true); auto.
inline{2} 1; sp.
rcondt{2} 1; 1: by auto; smt(divz_ge0 gt0_r size_ge0).
auto; call eq_IRO_RFWhile; auto=> />.
move=> &l &r 14?; split; 2: smt(divz_ge0 gt0_r size_ge0).
rewrite cats0 take_oversize 1:/# take_oversize 1:spec_dout //=.
have h:=spec2_dout result_L H5.
have-> := some_oget _ h.
by rewrite /= eq_sym -to_listK.
qed.

local lemma rw_ideal &m:
    Pr[SHA3_OIndiff.OIndif.OIndif(FSome(BIRO.IRO), OSimulator(FSome(BIRO.IRO)), 
      ODRestr(Dist_of_P1Adv(A))).main() @ &m : res] <=
    Pr[SORO.Preimage(SORO_P1(A),RF(SORO.RO.RO)).main() @ &m : res].
proof.
rewrite (StdOrder.RealOrder.ler_trans _ _ _ (rw_ideal_2 &m)).
byequiv(: ={glob A} ==> _) => //=; proc; inline*; sp; wp.
swap{2} 2; sp; swap{2}[1..2] 6; sp.
swap{1} 2; sp; swap{1}[1..2] 6; sp.
seq 2 2 : (
  Log.m{1} = empty /\
  SHA3Indiff.Simulator.m{1} = empty /\
  SHA3Indiff.Simulator.mi{1} = empty /\
  SHA3Indiff.Simulator.paths{1} = empty.[c0 <- ([], b0)] /\
  Gconcl_list.BIRO2.IRO.mp{1} = empty /\
  SORO.Bounder.bounder{1} = 0 /\
  RFList.m{1} = empty /\
  Counter.c{2} = 0 /\
  ={Log.m, glob SHA3Indiff.Simulator, glob SORO.Bounder, glob Counter} /\
  SORO.RO.RO.m{2} = empty /\ ={glob A, h, hash}); 1: auto=> />. 
seq 1 1 : (={glob A, glob SHA3Indiff.Simulator, glob SORO.Bounder, glob Counter, 
    glob Log, mi, h, hash} /\ RFList.m{1} = SORO.RO.RO.m{2}).
+ call(: ={glob SHA3Indiff.Simulator, glob SORO.Bounder, glob Counter, glob Log} /\ 
    RFList.m{1} = SORO.RO.RO.m{2}); auto.
  - proc; sp; if; 1, 3: auto; sp.
    inline *; sp; sim.
    if; 1: auto; sim. 
    if; 1: auto; sim.
    sp; if; 1: (auto; smt()); sim; 2: smt(). 
    sp; if; 1: auto; sim; -1: smt().
    sp; if{1}.
    * rcondt{2} 2; auto; 1: smt(BlockSponge.parse_valid).
      rnd (fun l => oget (of_list l)) to_list; auto=> />.
      move=> &l &r 11?; split; 1: smt(of_listK).
      rewrite -dout_equal_dlist=> ?; split=> ?.
      + by rewrite dmapE=> h{h}; apply mu_eq=> x; smt(to_list_inj).
      move=> sample.
      rewrite !get_setE/=dout_full/= => h; split; 2: smt(). 
      rewrite eq_sym to_listK; apply some_oget.
      apply spec2_dout.
      by move:h; rewrite supp_dmap; smt(spec_dout).
    by auto; smt(dout_ll).
  - by proc; inline*; sp; if; auto; sp; if; auto.
  - proc; inline*; sp; if; auto; sp; if; auto; sp; sim.
    if{1}.
    * rcondt{2} 2; auto.
      rnd (fun l => oget (of_list l)) to_list; auto=> />.
      move=> &l *; split=> ?; 1: smt(of_listK).
      rewrite -dout_equal_dlist; split=> ?.
      * by rewrite dmapE=> h{h}; apply mu_eq=> x; smt(to_list_inj).
      move=> sample.
      rewrite supp_dmap dout_full/= =>/> a.
      by rewrite get_setE/= dout_full/=; congr; rewrite of_listK oget_some.
  by auto; smt(dout_ll).
sp; if; 1, 3: auto; sp; wp 1 2.
if{1}.
+ wp=> />.
  rnd (fun x => oget (of_list x)) to_list; auto=> />.
  move=> &l c Hc Hnin; split.
  - move=> ret Hret. 
    by have/= ->:= (to_listK ret (to_list ret)).
  move=> h{h}; split.
  - move=> ret Hret; rewrite -dout_equal_dlist.
    rewrite dmapE /=; apply mu_eq=> //= x /=.
    by rewrite /(\o) /pred1/=; smt(to_list_inj).
  move=> h{h} l Hl. 
  rewrite dout_full /=.
  have:= spec2_dout l.
  have:=supp_dlist dbool size_out l _; 1: smt(size_out_gt0).
  rewrite Hl/==> [#] -> h{h} /= H.
  have H1:=some_oget _ H.
  have:=to_listK (oget (of_list l)) l; rewrite {2}H1/= => -> /= {H H1}.
  by rewrite get_setE/=.
by auto=> />; smt(dout_ll).
qed.

local lemma leq_ideal &m :
    Pr[SHA3_OIndiff.OIndif.OIndif(FSome(BIRO.IRO), OSimulator(FSome(BIRO.IRO)), 
      ODRestr(Dist_of_P1Adv(A))).main() @ &m : res] <= (sigma + 1)%r / 2%r ^ size_out.
proof.
rewrite (StdOrder.RealOrder.ler_trans _ _ _ (rw_ideal &m)).
rewrite (StdOrder.RealOrder.ler_trans _ _ _ (RO_is_preimage_resistant (SORO_P1(A)) &m)).
by rewrite doutE1.
qed.



  local lemma rw_real &m : 
      Pr[Preimage(A, OSponge, PSome(Perm)).main() @ &m : res] =
      Pr[SHA3_OIndiff.OIndif.OIndif(FSome(Sponge(Poget(PSome(Perm)))), PSome(Perm), 
        ODRestr(Dist_of_P1Adv(A))).main() @ &m : res].
  proof.
  byequiv=>//=; proc; inline*; sp; wp=> />.
  swap{1} 4; sp. 
  seq 2 2 : (={glob A, glob Perm, hash, m} /\ Bounder.bounder{1} = Counter.c{2}).
  + call(: ={glob Perm} /\ Bounder.bounder{1} = Counter.c{2})=> //=.
    - by proc; inline*; sp; if; auto; 2:sim=> />; 1: smt().
    - by proc; inline*; sp; if; auto; 2:sim=> />; 1: smt().
    - proc; inline*; sp; if; auto; sp=> />.
      by conseq(:_==> ={z0, glob Perm})=> />; sim.
    by auto. 
  by sp; if; auto=>/=; sim; auto.
  qed.

lemma Sponge_preimage_resistant &m:
    (forall (F <: OIndif.ODFUNCTIONALITY) (P <: OIndif.ODPRIMITIVE),
      islossless F.f => islossless P.f => islossless P.fi => islossless A(F,P).guess) =>
    Pr[Preimage(A, OSponge, PSome(Perm)).main() @ &m : res] <=
    (limit ^ 2 - limit)%r / (2 ^ (r + c + 1))%r +
    (4 * limit ^ 2)%r / (2 ^ c)%r +
    (sigma + 1)%r / (2%r ^ size_out).
proof.
move=> A_ll.
rewrite (rw_real &m).
have := SHA3OIndiff (Dist_of_P1Adv(A)) &m _.
+ move=> F P Hp Hpi Hf; proc; inline*; sp; auto; call Hf; auto. 
  call(A_ll (DFSetSize(F)) P _ Hp Hpi); auto.
  - proc; inline*; auto; call Hf; auto.
  smt(dout_ll).
by have/#:=leq_ideal &m.
qed.

end section Preimage.



section SecondPreimage.


  declare module A : SH.AdvSecondPreimage { Perm, Counter, Bounder, F.RO,
    F.FRO, Redo, C, Gconcl.S, BlockSponge.BIRO.IRO, BlockSponge.C, BIRO.IRO,
    Gconcl_list.BIRO2.IRO, Gconcl_list.F2.RO, Gconcl_list.F2.FRO,
    Gconcl_list.Simulator, SHA3Indiff.Simulator, SHA3Indiff.Cntr,
    SORO.Bounder, SORO.RO.RO, SORO.RO.FRO, RO, FRO }.

  local module FInit (F : OIndif.ODFUNCTIONALITY) : OIndif.OFUNCTIONALITY = {
    proc init () = {}
    proc f = F.f
  }.

  local module PInit (P : ODPRIMITIVE) : OPRIMITIVE = {
    proc init () = {}
    proc f  = P.f
    proc fi = P.fi
  }.


local module OF (F : Oracle) : OIndif.ODFUNCTIONALITY = {
  proc f = F.get
}.


local module Log = {
  var m : (bool list * int, bool) fmap
}.

local module ExtendOutputSize (F : Oracle) : ODFUNCTIONALITY = {
  proc f (x : bool list, k : int) = {
    var o, l, suffix, prefix, i;
    l <- None;
    prefix <- [];
    suffix <- [];
    o <@ F.get(x);
    prefix <- take k (to_list (oget o));
    i <- size_out;
    while (i < k) {
      if ((x,i) \notin Log.m) {
        Log.m.[(x,i)] <$ {0,1};
      }
      suffix <- rcons suffix (oget Log.m.[(x,i)]);
      i <- i + 1;
    }
    l <- Some (prefix ++ suffix);
    return l;
  }
}.

local module OFC2 (F : Oracle) = OFC(ExtendOutputSize(F)).

local module ExtendOutput (F : RF) = {
  proc init () = {
    Log.m <- empty;
    F.init();
  }
  proc f = ExtendOutputSize(F).f
  proc get = f
}.

  local module (Dist_of_P2Adv (A : SH.AdvSecondPreimage) : ODISTINGUISHER) (F : ODFUNCTIONALITY) (P : ODPRIMITIVE) = {
    var m : bool list
    proc distinguish () = {
      var hash, hash', m';
      Log.m <- empty;
      m' <@ A(DFSetSize(F),P).guess(m);
      hash  <@ DFSetSize(F).f(m);
      hash' <@ DFSetSize(F).f(m');
      return m <> m' /\ exists y, hash' = Some y /\ hash = Some y;
    }
  }.
  

local module (SORO_P2 (A : SH.AdvSecondPreimage) : SORO.AdvSecondPreimage) (F : Oracle) = {
  proc guess (m : bool list) : bool list = {
    var mi;
    Log.m <- empty;
    Counter.c <- 0;
    Dist_of_P2Adv.m <- m;
    OSimulator(ExtendOutputSize(F)).init();
    mi <@ A(DFSetSize(OFC2(F)),OPC(OSimulator(ExtendOutputSize(F)))).guess(m);
    return mi;
  }
}.

local module RFList = {
  var m : (bool list, f_out) fmap
  proc init () = {
    m <- empty;
  }
  proc get (x : bool list) : f_out option = {
    var z;
    if (x \notin m) {
      z <$ dlist dbool size_out;
      m.[x] <- oget (of_list z);
    }
    return m.[x];
  }
  proc sample (x: bool list) = {}
}.

local module RFWhile = {
  proc init () = {
    RFList.m <- empty;
  }
  proc get (x : bool list) : f_out option = {
    var l, i, b;
    if (x \notin RFList.m) {
      i <- 0;
      l <- [];
      while (i < size_out) {
        b <$ dbool;
        l <- rcons l b;
        i <- i + 1;
      }
      RFList.m.[x] <- oget (of_list l);
    }
    return RFList.m.[x];
  }
  proc sample (x: bool list) = {}
}.


local equiv rw_RF_List_While :
    RFList.get ~ RFWhile.get : 
    ={arg, glob RFList} ==> ={res, glob RFWhile}.
proof.
proc; if; 1, 3: auto; wp.
conseq(:_==> z{1} = l{2})=> />.
transitivity{1} {
    z <@ PBool.Sample.sample(size_out);
  }
  (true ==> ={z})
  (true ==> z{1} = l{2})=>/>.
+ by inline*; auto.
transitivity{1} {
    z <@ LoopSnoc.sample(size_out);
  }
  (true ==> ={z})
  (true ==> z{1} = l{2})=>/>; last first.
+ inline*; auto; sim.
  by while(={l, i} /\ n{1} = size_out); auto; smt(cats1).
by call(Sample_LoopSnoc_eq); auto.
qed.


local equiv eq_IRO_RFWhile :
  BIRO.IRO.f ~ RFWhile.get :
  arg{1} = (x{2}, size_out) /\ inv BIRO.IRO.mp{1} RFList.m{2}
  ==>
  res{2} = of_list res{1} /\ size res{1} = size_out /\ inv BIRO.IRO.mp{1} RFList.m{2}.
proof.
proc; inline*; sp.
rcondt{1} 1; 1: by auto.
if{2}; sp; last first.
+ alias{1} 1 mp = BIRO.IRO.mp.
  conseq(:_==> BIRO.IRO.mp{1} = mp{1} /\ size bs{1} = i{1} /\ i{1} = size_out /\
        inv mp{1} RFList.m{2} /\
        bs{1} = take i{1} (to_list (oget RFList.m{2}.[x{1}])))=> />.
  - move=> &l &r 12?.
    rewrite take_oversize 1:spec_dout 1:H4 //.
    rewrite eq_sym to_listK => ->.
    by have:=H3; rewrite domE; smt().
  - smt(take_oversize spec_dout).
  while{1}(BIRO.IRO.mp{1} = mp{1} /\ size bs{1} = i{1} /\ 
        0 <= i{1} <= size_out /\ n{1} = size_out /\
        inv mp{1} RFList.m{2} /\ x{1} \in RFList.m{2} /\
        bs{1} = take i{1} (to_list (oget RFList.m{2}.[x{1}])))(size_out - i{1});
      auto=> />.
  + sp; rcondf 1; auto=> />; 1: smt().
    move=> &h 9?.
    rewrite size_rcons //=; do!split; 1, 2, 4: smt(size_ge0).
    rewrite (take_nth witness) 1:spec_dout 1:size_ge0//=. 
    rewrite - H6; congr; rewrite H4=> //=.
    by apply H3=> //=.
  smt(size_out_gt0 size_ge0 take0).
auto=> //=.
conseq(:_==> l{2} = bs{1} /\ size bs{1} = i{1} /\ i{1} = n{1} /\ n{1} = size_out /\
  inv BIRO.IRO.mp{1} RFList.m{2}.[x{2} <- oget (of_list l{2})])=> />. 
+ smt(get_setE spec2_dout).
+ smt(get_setE spec2_dout).
alias{1} 1 m = BIRO.IRO.mp; sp.
conseq(:_==> l{2} = bs{1} /\ size bs{1} = i{1} /\ i{1} = n{1} /\ 
  n{1} = size_out /\ inv m{1} RFList.m{2} /\
  (forall j, (x{1}, j) \in BIRO.IRO.mp{1} => 0 <= j < i{1}) /\
  (forall l j, l <> x{1} => m{1}.[(l,j)] = BIRO.IRO.mp{1}.[(l,j)]) /\
  (forall j, 0 <= j < i{1} => (x{1}, j) \in BIRO.IRO.mp{1}) /\
  (forall j, 0 <= j < i{1} => BIRO.IRO.mp{1}.[(x{1},j)] = Some (nth witness bs{1} j))).
+ move=> /> &l &r 12?; do!split; ..-2 : smt(domE mem_set).
  move=> l j Hin.
  rewrite get_setE/=.
  case: (l = x{r}) => [<<-|].
  - rewrite oget_some H8; 1:smt(); congr; congr.
    by rewrite eq_sym to_listK; smt(spec2_dout).
  move=> Hneq.
  by rewrite -(H6 _ _ Hneq) H2; smt(domE).
while(l{2} = bs{1} /\ size bs{1} = i{1} /\ 0 <= i{1} <= n{1} /\ ={i} /\
  n{1} = size_out /\ inv m{1} RFList.m{2} /\
  (forall j, (x{1}, j) \in BIRO.IRO.mp{1} => 0 <= j < i{1}) /\
  (forall l j, l <> x{1} => m{1}.[(l,j)] = BIRO.IRO.mp{1}.[(l,j)]) /\
  (forall j, 0 <= j < i{1} => (x{1}, j) \in BIRO.IRO.mp{1}) /\
  (forall j, 0 <= j < i{1} => BIRO.IRO.mp{1}.[(x{1},j)] = Some (nth witness bs{1} j))).
+ sp; rcondt{1} 1; auto=> />.
  - smt().
  move=> &l &r 13?.
  rewrite get_setE/=size_rcons/=; do!split; 1,2: smt(size_ge0).
  - smt(mem_set).
  - smt(get_setE).
  - smt(mem_set).
  - move=>j Hj0 Hjsize; rewrite get_setE/=nth_rcons.
    case: (j = size bs{l})=>[->>//=|h].
    have/=Hjs:j < size bs{l} by smt().
    by rewrite Hjs/=H8//=.
by auto; smt(size_out_gt0).
qed.


local module ExtendSample (F : OFUNCTIONALITY) = {
  proc init = F.init
  proc f (x : bool list, k : int) = {
    var y;
    if (k <= size_out) {
      y <@ F.f(x,size_out);
      y <- omap (take k) y;
    } else {
      y <@ F.f(x,k);
    }
    return y;
  }
}.


local equiv eq_extend :
  ExtendSample(FSome(BIRO.IRO)).f ~ ExtendOutputSize(FSetSize(FSome(BIRO.IRO))).f :
  ={arg} /\ eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2} ==>
  ={res} /\ eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2}.
proof.
proc; inline*; auto; sp.
rcondt{2} 1; 1: auto.
if{1}; sp.
- rcondt{1} 1; auto.
  rcondf{2} 8; 1: auto.
  - conseq(:_==> true); 1: smt(). 
    by while(true); auto.
  auto=> /=.
  conseq(:_==> ={bs, k} /\ size bs{1} = size_out /\
    eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2})=> //=.
  - smt(cats0 to_listK spec2_dout).
  while(={k, bs, n, x2} /\ i{1} = i0{2} /\ n{1} = size_out /\
      0 <= i{1} <= n{1} /\ size bs{1} = i{1} /\
      eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2}).
  - by sp; if; auto; smt(domE get_setE size_rcons).
  by auto; smt(size_eq0 size_out_gt0).
rcondt{1} 1; 1: auto.
splitwhile{1} 1 : i0 < size_out; auto=> /=.
while( (i0, n0, x3){1} = (i, k, x){2} /\ bs0{1} = prefix{2} ++ suffix{2} /\
    size_out <= i{2} <= k{2} /\ eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2}).
+ by sp; if; auto; smt(domE get_setE size_out_gt0 rcons_cat).
auto=> //=.
conseq(:_==> ={i0} /\ size bs{2} = i0{1} /\ (i0, x3){1} = (n, x2){2} /\
    bs0{1} = bs{2} /\ size bs{2} = size_out /\
    eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2}). 
+ smt(cats0 take_oversize spec_dout to_listK spec2_dout).
while(={i0} /\ x3{1} = x2{2} /\ 0 <= i0{1} <= n{2} /\ n{2} = size_out /\
    bs0{1} = bs{2} /\ size bs{2} = i0{1} /\ size_out <= n0{1} /\
    eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2}).
+ by sp; if; auto; smt(size_rcons domE get_setE size_rcons mem_set).
by auto; smt(size_out_gt0).
qed.


local lemma of_listK l : of_list (to_list l) = Some l.
proof.
by rewrite -to_listK.
qed.

local module Fill_In (F : RO) = {
  proc init = F.init
  proc f (x : bool list, n : int) = {
    var l, b, i;
    i <- 0;
    l <- [];
    while (i < n) {
      b <@ F.get((x,i));
      l <- rcons l b;
      i <- i + 1;
    }
    while (i < size_out) {
      F.sample((x,i));
      i <- i + 1;
    }
    return l;
  }
}.


local equiv eq_eager_ideal :
  BIRO.IRO.f ~ Fill_In(LRO).f :
  ={arg} /\ BIRO.IRO.mp{1} = RO.m{2} ==>
  ={res} /\ BIRO.IRO.mp{1} = RO.m{2}.
proof.
proc; inline*; sp; rcondt{1} 1; auto.
while{2}(bs{1} = l{2} /\ BIRO.IRO.mp{1} = RO.m{2})(size_out - i{2}).
+ by auto=> />; smt().
conseq(:_==> bs{1} = l{2} /\ BIRO.IRO.mp{1} = RO.m{2}); 1: smt().
while(={i, n, x} /\ bs{1} = l{2} /\ BIRO.IRO.mp{1} = RO.m{2}).
+ sp; if{1}.
  - by rcondt{2} 2; auto=> />.
  by rcondf{2} 2; auto=> />; smt(dbool_ll).
by auto.
qed.

local equiv eq_eager_ideal2 :
  ExtendSample(FSome(BIRO.IRO)).f ~ FSome(Fill_In(RO)).f :
  ={arg} /\ BIRO.IRO.mp{1} = RO.m{2} ==>
  ={res} /\ BIRO.IRO.mp{1} = RO.m{2}.
proof.
proc; inline*; sp.
if{1}; sp.
+ rcondt{1} 1; auto=> /=/>.
  conseq(:_==> take k{1} bs{1} = l{2} /\ BIRO.IRO.mp{1} = RO.m{2}).
  * smt().
  case: (0 <= n{2}); last first.
  + rcondf{2} 1; 1: by auto; smt(). 
    conseq(:_==> BIRO.IRO.mp{1} = RO.m{2} /\ ={i} /\ n{1} = size_out /\ x2{1} = x0{2})=> />.
    - smt(take_le0).
    while(={i} /\ x2{1} = x0{2} /\ n{1} = size_out /\ BIRO.IRO.mp{1} = RO.m{2}).
    - sp; if{1}.
      - by rcondt{2} 2; auto=> />.
      by rcondf{2} 2; auto=> />; smt(dbool_ll).
    by auto=> />.
  splitwhile{1} 1 : i < k.
  while(={i} /\ n{1} = size_out /\ x2{1} = x0{2} /\  BIRO.IRO.mp{1} = RO.m{2} /\
      take k{1} bs{1} = l{2} /\ size bs{1} = i{1} /\ k{1} <= i{1} <= size_out).
  * sp; if{1}.
    - by rcondt{2} 2; auto; smt(dbool_ll cats1 take_cat cats0 take_size size_rcons).
    by rcondf{2} 2; auto; smt(dbool_ll cats1 take_cat cats0 take_size size_rcons).
  conseq(:_==> ={i} /\ n{1} = size_out /\ x2{1} = x0{2} /\  BIRO.IRO.mp{1} = RO.m{2} /\
      bs{1} = l{2} /\ size bs{1} = i{1} /\ k{1} = i{1}).
  + smt(take_size).
  while(={i} /\ x2{1} = x0{2} /\ n{1} = size_out /\ k{1} = n{2} /\
      0 <= i{1} <= k{1} <= size_out /\ bs{1} = l{2} /\ size bs{1} = i{1} /\
      BIRO.IRO.mp{1} = RO.m{2}).
  + sp; if{1}.
    - by rcondt{2} 2; auto; smt(size_rcons).
    by rcondf{2} 2; auto; smt(size_rcons dbool_ll).
  by auto; smt(size_ge0 size_out_gt0).
rcondt{1} 1; auto.
rcondf{2} 2; 1: auto.
+ conseq(:_==> i = n); 1: smt().
  by while(i <= n); auto=> />; smt(size_out_gt0).
while(i0{1} = i{2} /\ x3{1} = x0{2} /\ n0{1} = n{2} /\ bs0{1} = l{2} /\ 
    BIRO.IRO.mp{1} = RO.m{2}).
+ sp; if{1}.
  - by rcondt{2} 2; auto=> />.
  by rcondf{2} 2; auto; smt(dbool_ll).
by auto=> />.
qed.

local module Dist (F : RO) = {
  proc distinguish = SHA3_OIndiff.OIndif.OIndif(FSome(Fill_In(F)),
      OSimulator(FSome(Fill_In(F))), ODRestr(Dist_of_P2Adv(A))).main
}.

local module Game (F : RO) = {
  proc distinguish () = {
    var bo;
    OSimulator(FSome(Fill_In(F))).init();
    Counter.c <- 0;
    Log.m <- empty;
    F.init();
    bo <@ Dist(F).distinguish();
    return bo;
  }
}.

local lemma eager_ideal &m :
    Pr[SHA3_OIndiff.OIndif.OIndif(FSome(BIRO.IRO),
      OSimulator(FSome(BIRO.IRO)),
      ODRestr(Dist_of_P2Adv(A))).main() @ &m : res] =
    Pr[SHA3_OIndiff.OIndif.OIndif(ExtendSample(FSome(BIRO.IRO)),
      OSimulator(ExtendSample(FSome(BIRO.IRO))),
      ODRestr(Dist_of_P2Adv(A))).main() @ &m : res].
proof.
cut->: 
  Pr[SHA3_OIndiff.OIndif.OIndif(FSome(BIRO.IRO),
    OSimulator(FSome(BIRO.IRO)),
    ODRestr(Dist_of_P2Adv(A))).main() @ &m : res] =
  Pr[Game(LRO).distinguish() @ &m : res].
+ byequiv=> //=; proc.
  inline{2} 1; sp; inline{2} 1; sp; inline{2} 1; sp; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp; sim.
  seq 1 1 : (={m', glob Dist_of_P2Adv, glob OFC} /\ BIRO.IRO.mp{1} = RO.m{2}); last first.
  - inline{1} 1; inline{2} 1; sp; sim.
    inline{1} 1; inline{2} 1; sp; sim; if; auto.
    * inline{1} 1; inline{2} 1; sp; sim.
      inline{1} 7; inline{2} 7; sim.
      inline{1} 8; inline{2} 8; sim.
      swap 3 -2; sp.
      case: (increase_counter Counter.c{1} m'{1} size_out <= SHA3Indiff.limit). 
      + rcondt{1} 10; 1: auto.
        - inline*; auto.
          by sp; rcondt 1; auto; conseq(:_==> true); auto.
        rcondt{2} 10; 1: auto.
        - inline*; auto.
          by conseq(:_==> true); auto.
        sim.
        inline{1} 10; inline{2} 10; sim.
        call eq_eager_ideal; auto.
        by call eq_eager_ideal; auto.
      rcondf{1} 10; 1: auto.
      - inline*; auto.
        by sp; rcondt 1; auto; conseq(:_==> true); auto.
      rcondf{2} 10; 1: auto.
      - inline*; auto.
        by conseq(:_==> true); auto.
      by auto; call eq_eager_ideal; auto.
    sp; inline{1} 1; inline{2} 1; sp; sim.
    inline{1} 1; inline{2} 1; sp; sim.
    if; auto.
    inline{1} 1; inline{2} 1; sp; sim.
    by auto; call eq_eager_ideal; auto.
  call(: ={glob OFC, glob OSimulator, glob Dist_of_P2Adv} /\ 
      BIRO.IRO.mp{1} = RO.m{2}); auto.
  - proc; sp; if; auto.
    inline{1} 1; inline{2} 1; sp; sim; if; 1: auto; sim.
    if; 1: auto; sim; sp.
    if; 1: auto; 1: smt(); sim.
    * inline{1} 1; inline{2} 1; sp; sim.
      by call eq_eager_ideal; auto; smt().
    smt().
  - by proc; inline*; sim.
  proc; sim.
  inline{1} 1; inline{2} 1; sp; sim; if; 1: auto; sim.
  inline{1} 1; inline{2} 1; sp; sim.
  by call eq_eager_ideal; auto.
cut->: 
  Pr[SHA3_OIndiff.OIndif.OIndif(ExtendSample(FSome(BIRO.IRO)),
    OSimulator(ExtendSample(FSome(BIRO.IRO))),
    ODRestr(Dist_of_P2Adv(A))).main() @ &m : res] =
  Pr[Game(RO).distinguish() @ &m : res].
+ byequiv=> //=; proc.
  inline{2} 1; sp; inline{2} 1; sp; inline{2} 1; sp; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp; sim.
  seq 1 1 : (={m', glob Dist_of_P2Adv, glob OFC} /\ BIRO.IRO.mp{1} = RO.m{2}); last first.
  - inline{1} 1; inline{2} 1; sp; sim.
    inline{1} 1; inline{2} 1; sp; sim; if; auto.
    * inline{1} 6; inline{2} 6; sim.
      inline{1} 7; inline{2} 7; sim.
      swap 2 -1; sp.
      case: (increase_counter Counter.c{1} m'{1} size_out <= SHA3Indiff.limit). 
      + rcondt{1} 9; 1: auto.
        - inline*; auto.
          by sp; rcondt 1; auto; conseq(:_==> true); auto.
        rcondt{2} 9; 1: auto.
        - inline*; auto.
          by conseq(:_==> true); auto.
        sim.
        call eq_eager_ideal2; auto.
        by call eq_eager_ideal2; auto.
      rcondf{1} 9; 1: auto.
      - inline*; auto.
        by sp; rcondt 1; auto; conseq(:_==> true); auto.
      rcondf{2} 9; 1: auto.
      - inline*; auto.
        by conseq(:_==> true); auto.
      by auto; call eq_eager_ideal2; auto.
    sp; inline{1} 1; inline{2} 1; sp; sim.
    inline{1} 1; inline{2} 1; sp; sim.
    if; auto.
    by auto; call eq_eager_ideal2; auto.
  call(: ={glob OFC, glob OSimulator, glob Dist_of_P2Adv} /\ 
      BIRO.IRO.mp{1} = RO.m{2}); auto.
  - proc; sp; if; auto.
    inline{1} 1; inline{2} 1; sp; sim; if; 1: auto; sim.
    if; 1: auto; sim; sp.
    if; 1: auto; 1: smt(); sim.
    * by call eq_eager_ideal2; auto; smt().
    smt().
  - by proc; inline*; sim.
  proc; sim.
  inline{1} 1; inline{2} 1; sp; sim; if; 1: auto; sim.
  by call eq_eager_ideal2; auto.
rewrite eq_sym; byequiv=> //=; proc. 
by call(RO_LRO_D Dist); inline*; auto=> />.
qed.


local equiv toto :
  DFSetSize(OFC(ExtendSample(FSome(BIRO.IRO)))).f ~
  DFSetSize(OFC(ExtendSample(FSome(BIRO.IRO)))).f :
  ={glob OFC, arg} /\ eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2} ==>
  ={glob OFC, res} /\ eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2}.
proof.
proc; inline*; sp; if; auto; sp; if; auto; sp; (rcondt{1} 1; 1: auto; rcondt{2} 1; 1: auto)=>/=.
+ conseq(:_==> ={bs} /\ eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2}); auto.
  while(={i, bs, n, x3} /\ 0 <= i{1} <= size_out /\ n{1} = size_out /\ 
      eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2}).
  - by sp; if; auto; smt(domE get_setE size_out_gt0).
  by auto; smt(size_out_gt0).
by conseq(:_==> true); auto; sim.
qed.

local equiv titi mess c:
  DFSetSize(OFC(ExtendSample(FSome(BIRO.IRO)))).f
  ~
  SORO.Bounder(RFWhile).get
  :
  ={arg} /\ arg{1} = mess /\ Counter.c{1} = c /\
    SORO.Bounder.bounder{2} <= Counter.c{1} /\ 
    inv BIRO.IRO.mp{1} RFList.m{2}
  ==>
    if (increase_counter c mess size_out <= sigma) then
    (exists y, res{1} = Some y /\ res{2} = Some y /\
      SORO.Bounder.bounder{2} <= Counter.c{1} /\
      Counter.c{1} = increase_counter c mess size_out /\
      inv BIRO.IRO.mp{1} RFList.m{2})
    else (res{1} = None).
proof.
proc; sp.
inline{1} 1; sp; auto.
if{1}.
- rcondt{2} 1; first by auto; smt(divz_ge0 gt0_r size_ge0).
  sp; auto. 
  inline{1} 1; sp; auto.
  sp; rcondt{1} 1; auto.
  inline{1} 1; sp; auto.
  call(eq_IRO_RFWhile); auto=> /> 15?. 
  rewrite take_oversize 1:/# /=. 
  have:=spec2_dout _ H5.
  move=>/(some_oget)-> /=; smt(divz_ge0 gt0_r size_ge0 spec2_dout).
move=>/=.
conseq(:_==> true); auto.
inline*; if{2}; auto; sp; if{2}; auto; sp.
by while{2}(true)(size_out - i{2}); auto; smt(dbool_ll).
qed.

local lemma rw_ideal_2 &m (mess : bool list):
    Dist_of_P2Adv.m{m} = mess =>
    Pr[SHA3_OIndiff.OIndif.OIndif(FSome(BIRO.IRO), OSimulator(FSome(BIRO.IRO)), 
      ODRestr(Dist_of_P2Adv(A))).main() @ &m : res] <=
    Pr[SORO.SecondPreimage(SORO_P2(A), RFList).main(mess) @ &m : res].
proof.
move=> Heq.
have->:Pr[SORO.SecondPreimage(SORO_P2(A), RFList).main(mess) @ &m : res] =
       Pr[SORO.SecondPreimage(SORO_P2(A), RFWhile).main(mess) @ &m : res].
+ byequiv(: ={glob A, arg} /\ arg{1} = mess ==> _)=>//=; proc.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  seq 1 1 : (={mi, m1, glob A, glob SORO.Bounder, glob RFList, glob Dist_of_P2Adv}); last first.
  - sp; inline{1} 2; inline{2} 2; inline{1} 1; inline{2} 1; sp; sim.
    if; auto.
    - sp; case: (SORO.Bounder.bounder{1} < sigma).
      * rcondt{1} 5; 1: auto.
        + by inline*; auto; conseq(:_==> true); auto.
        rcondt{2} 5; 1: auto.
        + by inline*; auto; conseq(:_==> true); auto.
        call(rw_RF_List_While); auto.
        by call(rw_RF_List_While); auto=> />.
      rcondf{1} 5; 1: auto.
      + by inline*; auto; conseq(:_==> true); auto.
      rcondf{2} 5; 1: auto.
      + by inline*; auto; conseq(:_==> true); auto.
      by auto; call(rw_RF_List_While); auto.
    by sp; if; auto; call(rw_RF_List_While); auto.
  call(: ={glob SORO.Bounder, glob RFList, glob OSimulator, glob OPC, glob Log,
         glob Dist_of_P2Adv}); auto.
  - proc; sp; if; auto.
    inline{1} 1; inline{2} 1; sp; if; 1, 3: auto; sim.
    if; 1: auto; sim; sp; sim; if; auto=> />; 1: smt(); sim.
    + inline{1} 1; inline{2} 1; sp; sim.
      inline{1} 1; inline{2} 1; sp; if; auto=> />.
      - by call(rw_RF_List_While); auto; smt(). 
      smt().
    smt().
  - by sim. 
  proc; sim; inline{1} 1; inline{2} 1; sp; if; auto.
  inline{1} 1; inline{2} 1; sp; sim.
  inline{1} 1; inline{2} 1; sp; if; auto; sim.
  by call(rw_RF_List_While); auto.
rewrite (eager_ideal &m).
have->:Pr[SHA3_OIndiff.OIndif.OIndif(ExtendSample(FSome(BIRO.IRO)),
         OSimulator(ExtendSample(FSome(BIRO.IRO))),
          ODRestr(Dist_of_P2Adv(A))).main() @ &m : res] =
       Pr[SHA3_OIndiff.OIndif.OIndif(ExtendSample(FSome(BIRO.IRO)),
         OSimulator(ExtendOutputSize(FSetSize(FSome(BIRO.IRO)))),
         ODRestr(Dist_of_P2Adv(A))).main() @ &m : res].
+ byequiv=> //=; proc.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp; auto=> />.
  call(toto); call(toto); auto.
  conseq(:_==> ={m', glob Counter, Dist_of_P2Adv.m} /\
      eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2}); 1: smt().
  call(: ={glob OSimulator, glob OFC, Dist_of_P2Adv.m} /\
         eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2}); last first; auto.
  + smt(mem_empty).
  + proc; sp; if; auto.
    inline{1} 1; inline{2} 1; sp; if; 1, 3: auto.
    if; 1, 3: auto; sp.
    if; 1: auto; 1: smt(); last first.
    - by conseq=> />; sim; smt().
    wp=> />; 1: smt().
    rnd; auto.
    call(eq_extend); by auto; smt().
  + by proc; sp; if; auto; inline{1} 1; inline{2} 1; sp; if; auto.
  proc; sp; inline{1} 1; inline{2} 1; sp; if; auto.
  inline*; sp.
  rcondt{1} 1; 1: auto; rcondt{2} 1; 1: auto; sp.
  rcondt{1} 1; 1: auto; rcondt{2} 1; 1: auto; sp; auto.
  conseq(:_==> ={bs} /\ eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2}); 
    1: by auto.
  while(={i, n, x3, bs} /\ 0 <= i{1} <= size_out /\ n{1} = size_out /\ 
      eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2}).
  - by sp; if; auto; smt(domE get_setE size_rcons).
  by auto; smt(size_out_gt0).
byequiv=> //=; proc.
inline{1} 1; inline{2} 1; sp.
inline{1} 1; inline{2} 1; sp.
inline{1} 1; inline{2} 1; sp.
inline{1} 1; inline{2} 1; sp.
inline{1} 1; inline{2} 1; sp.
inline{1} 1; sp; auto.
seq 1 1 : (={glob A, glob OFC, glob OSimulator, Log.m} /\
         m'{1} = mi{2} /\ m1{2} = Dist_of_P2Adv.m{1} /\
         inv BIRO.IRO.mp{1} RFList.m{2} /\
         SORO.Bounder.bounder{2} <= Counter.c{1}); last first.
+ sp; case: (increase_counter Counter.c{1} Dist_of_P2Adv.m{1} size_out <= SHA3Indiff.limit).
  - exists * mi{2}, Dist_of_P2Adv.m{1}, Counter.c{1}; elim* => mess2 mess1 c.
    call(titi mess2 (increase_counter c mess1 size_out))=> /= />.
    by call(titi mess1 c)=> />; auto; smt().
  inline*; sp.
  rcondf{1} 1; 1: auto; sp.
  conseq(:_==> true); auto.
  seq 1 0 : true.
  - if{1}; auto; sp; 1: if{1}; auto; sp.
    - rcondt{1} 1; auto.
      while{1}(true)(n1{1}-i1{1}); auto; -1: smt().
      by sp; if; auto; smt(dbool_ll).
    rcondt{1} 1; 1: auto.
    while{1}(true)(n2{1}-i2{1}); auto.
    by sp; if; auto; smt(dbool_ll).
  seq 0 1 : true.
  - if{2}; auto; sp; if{2}; auto; sp.
    by while{2}(true)(size_out-i{2}); auto; smt(dbool_ll).
  sp; if{2}; auto; sp; if{2}; auto; sp.
  by while{2}(true)(size_out-i0{2}); auto; smt(dbool_ll).
conseq(:_==> ={glob A, glob OFC, glob OSimulator, Log.m} /\
  m'{1} = mi{2} /\
  inv BIRO.IRO.mp{1} RFList.m{2} /\ SORO.Bounder.bounder{2} <= Counter.c{1}).
+ smt().
auto; call(: ={glob OSimulator, glob Counter, glob Log} /\ 
    inv BIRO.IRO.mp{1} RFList.m{2} /\
    SORO.Bounder.bounder{2} <= Counter.c{1}); auto; last first.
+ by smt(mem_empty).
+ proc; sp; if; auto=> />; 1: smt(). 
  inline{1} 1; inline{2} 1; sp; auto.
  if; 1, 3: auto; -1: smt().
  if; 1, 3: auto; -1: smt().
  sp; if; 1: auto; 1: smt(); last first.
  - by conseq(:_==> ={y, glob OSimulator}); 1: smt(); sim; smt().
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  rcondt{2} 1; 1: by auto; smt().
  sp.
  seq 3 2 : (={x0, x1, o1, k0, Log.m, suffix, glob OSimulator} /\
      inv BIRO.IRO.mp{1} RFList.m{2} /\ 
      SORO.Bounder.bounder{2} <= Counter.c{2} + 1); last first.
  - by conseq(:_==> ={y, x1, glob OSimulator, Log.m}); 1: smt(); sim=> />.
  inline{1} 1; auto.
  by call(eq_IRO_RFWhile); auto; smt().
+ by proc; inline*; sp; if; auto; sp; if; auto=> />; smt().
proc.
inline{1} 1; inline{2} 1; sp; if; auto=> /=.
inline{1} 1; inline{2} 1; sp.
rcondt{1} 1; 1: auto.
inline{1} 1; auto.
rcondf{2} 4; 1: auto. 
+ inline*; auto; sp; if; auto; sp; if; auto=> />; conseq(:_==> true); 1: smt().
  by while(true); auto.
inline{2} 1; sp.
rcondt{2} 1; 1: by auto; smt(divz_ge0 gt0_r size_ge0).
auto; call eq_IRO_RFWhile; auto=> />.
move=> &l &r 14?; split; 2: smt(divz_ge0 gt0_r size_ge0).
rewrite cats0 take_oversize 1:/# take_oversize 1:spec_dout //=.
have h:=spec2_dout result_L H5.
have-> := some_oget _ h.
by rewrite eq_sym -to_listK; congr.
qed.

local lemma rw_ideal &m (mess : bool list):
    Dist_of_P2Adv.m{m} = mess =>
    Pr[SHA3_OIndiff.OIndif.OIndif(FSome(BIRO.IRO), OSimulator(FSome(BIRO.IRO)), 
      ODRestr(Dist_of_P2Adv(A))).main() @ &m : res] <=
    Pr[SORO.SecondPreimage(SORO_P2(A),RF(SORO.RO.RO)).main(mess) @ &m : res].
proof.
move=> Heq.
rewrite (StdOrder.RealOrder.ler_trans _ _ _ (rw_ideal_2 &m mess Heq)).
byequiv(: ={glob A} /\ ={arg} /\ arg{1} = mess ==> _) => //=; proc; inline*; sp; wp.
seq 1 1 : (={glob A, glob SHA3Indiff.Simulator, glob SORO.Bounder, glob Counter, 
    glob Log, mi, m1} /\ RFList.m{1} = SORO.RO.RO.m{2}).
+ call(: ={glob SHA3Indiff.Simulator, glob SORO.Bounder, glob Counter, glob Log} /\ 
    RFList.m{1} = SORO.RO.RO.m{2}); auto.
  - proc; sp; if; 1, 3: auto; sp.
    inline *; sp; sim.
    if; 1: auto; sim. 
    if; 1: auto; sim.
    sp; if; 1: (auto; smt()); sim; 2: smt(). 
    sp; if; 1: auto; sim; -1: smt().
    sp; if{1}.
    * rcondt{2} 2; auto; 1: smt(BlockSponge.parse_valid).
      rnd (fun l => oget (of_list l)) to_list; auto=> />.
      move=> &l &r 11?; split; 1: smt(of_listK).
      rewrite -dout_equal_dlist=> ?; split=> ?.
      + by rewrite dmapE=> h{h}; apply mu_eq=> x; smt(to_list_inj).
      move=> sample.
      rewrite !get_setE/=dout_full/= => h; split; 2: smt(). 
      rewrite eq_sym to_listK; apply some_oget.
      apply spec2_dout.
      by move:h; rewrite supp_dmap; smt(spec_dout).
    by auto; smt(dout_ll).
  - by proc; inline*; sp; if; auto; sp; if; auto.
  - proc; inline*; sp; if; auto; sp; if; auto; sp; sim.
    if{1}.
    * rcondt{2} 2; auto.
      rnd (fun l => oget (of_list l)) to_list; auto=> />.
      move=> &l 4?; split=> ?; 1: smt(of_listK).
      rewrite -dout_equal_dlist; split=> ?.
      * by rewrite dmapE=> h{h}; apply mu_eq=> x; smt(to_list_inj).
      move=> sample.
      rewrite supp_dmap dout_full/= =>/> a.
      by rewrite get_setE/= dout_full/=; congr; rewrite of_listK oget_some.
  by auto; smt(dout_ll).
sp.
seq 4 4 : (={SORO.Bounder.bounder, x0, m1, m2, hash1, y0} /\ y0{1} = None /\
  RFList.m{1} = SORO.RO.RO.m{2}); last first.
+ if; 1, 3: auto; sp.
  if{1}.
  - rcondt{2} 2; 1: auto.
    auto; rnd (fun t => oget (of_list t)) to_list; auto=> />.
    move=> &l c Hc Hnin; split.
    - move=> ret Hret. 
      by have/= ->:= (to_listK ret (to_list ret)).
    move=> h{h}; split.
    - move=> ret Hret; rewrite -dout_equal_dlist.
      rewrite dmapE /=; apply mu_eq=> //= x /=.
      by rewrite /(\o) /pred1/=; smt(to_list_inj).
    move=> h{h} l Hl. 
    rewrite dout_full /=.
    have:= spec2_dout l.
    have:=supp_dlist dbool size_out l _; 1: smt(size_out_gt0).
    rewrite Hl/==> [#] -> h{h} /= H.
    have H1:=some_oget _ H.
    have:=to_listK (oget (of_list l)) l; rewrite {2}H1/= => -> /= {H H1}.
    by rewrite get_setE/=; smt().
  by auto=> />; smt(dout_ll).
if; 1, 3: auto; sp.
if{1}.
- rcondt{2} 2; 1: auto.
  auto; rnd (fun t => oget (of_list t)) to_list; auto=> />.
  move=> &l c Hc Hnin; split.
  - move=> ret Hret. 
    by have/= ->:= (to_listK ret (to_list ret)).
  move=> h{h}; split.
  - move=> ret Hret; rewrite -dout_equal_dlist.
    rewrite dmapE /=; apply mu_eq=> //= x /=.
    by rewrite /(\o) /pred1/=; smt(to_list_inj).
  move=> h{h} l Hl. 
  rewrite dout_full /=.
  have:= spec2_dout l.
  have:=supp_dlist dbool size_out l _; 1: smt(size_out_gt0).
  rewrite Hl/==> [#] -> h{h} /= H.
  have H1:=some_oget _ H.
  have:=to_listK (oget (of_list l)) l; rewrite {2}H1/= => -> /= {H H1}.
  by rewrite get_setE/=; smt().
by auto=> />; smt(dout_ll).
qed.


local lemma leq_ideal &m mess:
    Dist_of_P2Adv.m{m} = mess =>
    Pr[SHA3_OIndiff.OIndif.OIndif(FSome(BIRO.IRO), OSimulator(FSome(BIRO.IRO)), 
      ODRestr(Dist_of_P2Adv(A))).main() @ &m : res] <= (sigma + 1)%r / 2%r ^ size_out.
proof.
move=> Heq.
rewrite (StdOrder.RealOrder.ler_trans _ _ _ (rw_ideal &m mess Heq)).
rewrite (StdOrder.RealOrder.ler_trans _ _ _ (RO_is_second_preimage_resistant (SORO_P2(A)) &m mess)).
by rewrite doutE1.
qed.

local lemma rw_real &m mess : 
  Dist_of_P2Adv.m{m} = mess =>
    Pr[SecondPreimage(A, OSponge, PSome(Perm)).main(mess) @ &m : res] =
    Pr[SHA3_OIndiff.OIndif.OIndif(FSome(Sponge(Poget(PSome(Perm)))), PSome(Perm), 
      ODRestr(Dist_of_P2Adv(A))).main() @ &m : res].
proof.
move=> Heq.
byequiv=>//=; proc.
inline{1} 1; inline{2} 1; sp.
inline{1} 1; inline{2} 1; sp.
inline{1} 1; inline{2} 1; sp.
inline{1} 1; inline{2} 1; sp.
inline{1} 1; inline{2} 1; sp.
inline{1} 1; sp; wp=> />.
seq 1 1 : (={glob A, glob Perm} /\ m1{1} = Dist_of_P2Adv.m{2} /\
  m2{1} = m'{2} /\ Bounder.bounder{1} = Counter.c{2}).
+ auto; call(: ={glob Perm} /\ Bounder.bounder{1} = Counter.c{2})=> //=.
  - by proc; inline*; sp; if; auto; 2:sim=> />; 1: smt().
  - by proc; inline*; sp; if; auto; 2:sim=> />; 1: smt().
  - proc; inline*; sp; if; auto; sp=> />.
    by conseq(:_==> ={z0, glob Perm})=> />; sim.
  by auto; smt().
conseq(:_==> m1{1} = Dist_of_P2Adv.m{2} /\ m2{1} = m'{2} /\ 
  hash1{1} = hash{2} /\ hash2{1} = hash'{2})=> //=; 1: smt().
seq 1 1 : (m1{1} = Dist_of_P2Adv.m{2} /\ m2{1} = m'{2} /\
  hash1{1} = hash{2} /\ ={glob Perm} /\ Bounder.bounder{1} = Counter.c{2}); last first.
+ inline*; sp; if; auto; sp=> /=; sim.
inline*; sp; if; auto; swap{1} 9; auto; sp=> /=.
by conseq(:_==>  m1{1} = Dist_of_P2Adv.m{2} /\ m2{1} = m'{2} /\
  of_list (oget (Some (take n{1} z0{1}))) =
  of_list (oget (Some (take n{2} z0{2}))) /\ ={Perm.mi, Perm.m})=> //=; sim.
qed.

local module TOTO = {
  proc main (m : bool list) = {
    var b;
    Dist_of_P2Adv.m <- m;
    b <@ SecondPreimage(A, OSponge, PSome(Perm)).main(m);
    return b;
  }
}.

lemma Sponge_second_preimage_resistant &m mess:
    (forall (F <: OIndif.ODFUNCTIONALITY) (P <: OIndif.ODPRIMITIVE),
      islossless F.f => islossless P.f => islossless P.fi => islossless A(F,P).guess) =>
    Pr[SecondPreimage(A, OSponge, PSome(Perm)).main(mess) @ &m : res] <=
    (limit ^ 2 - limit)%r / (2 ^ (r + c + 1))%r +
    (4 * limit ^ 2)%r / (2 ^ c)%r +
    (sigma + 1)%r / (2%r ^ size_out).
proof.
move=> A_ll.
have->:Pr[SecondPreimage(A, OSponge, PSome(Perm)).main(mess) @ &m : res] =
       Pr[TOTO.main(mess) @ &m : res].
+ by byequiv=> //=; proc; inline*; auto; sim.
byphoare(: arg = mess ==>_)=>//=; proc; sp.
call(: arg = mess /\ mess = Dist_of_P2Adv.m ==> res); auto.
bypr=> {&m} &m [#]->; rewrite eq_sym=> Heq.
rewrite (rw_real &m mess Heq).
have := SHA3OIndiff (Dist_of_P2Adv(A)) &m _.
+ move=> F P Hp Hpi Hf; proc; inline*; sp; auto; call Hf; auto; call Hf; auto. 
  call(A_ll (DFSetSize(F)) P _ Hp Hpi); auto.
  proc; inline*; auto; call Hf; auto.
by have/#:=leq_ideal &m.
qed.

end section SecondPreimage.




section Collision.


  declare module A : SH.AdvCollision { Perm, Counter, Bounder, F.RO,
    F.FRO, Redo, C, Gconcl.S, BlockSponge.BIRO.IRO, BlockSponge.C, BIRO.IRO,
    Gconcl_list.BIRO2.IRO, Gconcl_list.F2.RO, Gconcl_list.F2.FRO,
    Gconcl_list.Simulator, SHA3Indiff.Simulator, SHA3Indiff.Cntr,
    SORO.Bounder, SORO.RO.RO, SORO.RO.FRO, RO, FRO }.

  local module FInit (F : OIndif.ODFUNCTIONALITY) : OIndif.OFUNCTIONALITY = {
    proc init () = {}
    proc f = F.f
  }.

  local module PInit (P : ODPRIMITIVE) : OPRIMITIVE = {
    proc init () = {}
    proc f  = P.f
    proc fi = P.fi
  }.


local module OF (F : Oracle) : OIndif.ODFUNCTIONALITY = {
  proc f = F.get
}.


local module Log = {
  var m : (bool list * int, bool) fmap
}.

local module ExtendOutputSize (F : Oracle) : ODFUNCTIONALITY = {
  proc f (x : bool list, k : int) = {
    var o, l, suffix, prefix, i;
    l <- None;
    prefix <- [];
    suffix <- [];
    o <@ F.get(x);
    prefix <- take k (to_list (oget o));
    i <- size_out;
    while (i < k) {
      if ((x,i) \notin Log.m) {
        Log.m.[(x,i)] <$ {0,1};
      }
      suffix <- rcons suffix (oget Log.m.[(x,i)]);
      i <- i + 1;
    }
    l <- Some (prefix ++ suffix);
    return l;
  }
}.

local module OFC2 (F : Oracle) = OFC(ExtendOutputSize(F)).

local module ExtendOutput (F : RF) = {
  proc init () = {
    Log.m <- empty;
    F.init();
  }
  proc f = ExtendOutputSize(F).f
  proc get = f
}.

  local module (Dist_of_CollAdv (A : SH.AdvCollision) : ODISTINGUISHER) (F : ODFUNCTIONALITY) (P : ODPRIMITIVE) = {
    var m : bool list
    proc distinguish () = {
      var hash1, hash2, m1, m2;
      Log.m <- empty;
      (m1, m2) <@ A(DFSetSize(F),P).guess();
      hash1 <@ DFSetSize(F).f(m1);
      hash2 <@ DFSetSize(F).f(m2);
      return m1 <> m2 /\ exists y, hash1 = Some y /\ hash2 = Some y;
    }
  }.
  

local module (SORO_Coll (A : SH.AdvCollision) : SORO.AdvCollision) (F : Oracle) = {
  proc guess ()  = {
    var mi;
    Log.m <- empty;
    Counter.c <- 0;
    OSimulator(ExtendOutputSize(F)).init();
    mi <@ A(DFSetSize(OFC2(F)),OPC(OSimulator(ExtendOutputSize(F)))).guess();
    return mi;
  }
}.

local module RFList = {
  var m : (bool list, f_out) fmap
  proc init () = {
    m <- empty;
  }
  proc get (x : bool list) : f_out option = {
    var z;
    if (x \notin m) {
      z <$ dlist dbool size_out;
      m.[x] <- oget (of_list z);
    }
    return m.[x];
  }
  proc sample (x: bool list) = {}
}.

local module RFWhile = {
  proc init () = {
    RFList.m <- empty;
  }
  proc get (x : bool list) : f_out option = {
    var l, i, b;
    if (x \notin RFList.m) {
      i <- 0;
      l <- [];
      while (i < size_out) {
        b <$ dbool;
        l <- rcons l b;
        i <- i + 1;
      }
      RFList.m.[x] <- oget (of_list l);
    }
    return RFList.m.[x];
  }
  proc sample (x: bool list) = {}
}.


local equiv rw_RF_List_While :
    RFList.get ~ RFWhile.get : 
    ={arg, glob RFList} ==> ={res, glob RFWhile}.
proof.
proc; if; 1, 3: auto; wp.
conseq(:_==> z{1} = l{2})=> />.
transitivity{1} {
    z <@ PBool.Sample.sample(size_out);
  }
  (true ==> ={z})
  (true ==> z{1} = l{2})=>/>.
+ by inline*; auto.
transitivity{1} {
    z <@ LoopSnoc.sample(size_out);
  }
  (true ==> ={z})
  (true ==> z{1} = l{2})=>/>; last first.
+ inline*; auto; sim.
  by while(={l, i} /\ n{1} = size_out); auto; smt(cats1).
by call(Sample_LoopSnoc_eq); auto.
qed.


local equiv eq_IRO_RFWhile :
  BIRO.IRO.f ~ RFWhile.get :
  arg{1} = (x{2}, size_out) /\ inv BIRO.IRO.mp{1} RFList.m{2}
  ==>
  res{2} = of_list res{1} /\ size res{1} = size_out /\ inv BIRO.IRO.mp{1} RFList.m{2}.
proof.
proc; inline*; sp.
rcondt{1} 1; 1: by auto.
if{2}; sp; last first.
+ alias{1} 1 mp = BIRO.IRO.mp.
  conseq(:_==> BIRO.IRO.mp{1} = mp{1} /\ size bs{1} = i{1} /\ i{1} = size_out /\
        inv mp{1} RFList.m{2} /\
        bs{1} = take i{1} (to_list (oget RFList.m{2}.[x{1}])))=> />.
  - move=> &l &r 12?.
    rewrite take_oversize 1:spec_dout 1:H4 //.
    rewrite eq_sym to_listK => ->.
    by have:=H3; rewrite domE; smt().
  - smt(take_oversize spec_dout).
  while{1}(BIRO.IRO.mp{1} = mp{1} /\ size bs{1} = i{1} /\ 
        0 <= i{1} <= size_out /\ n{1} = size_out /\
        inv mp{1} RFList.m{2} /\ x{1} \in RFList.m{2} /\
        bs{1} = take i{1} (to_list (oget RFList.m{2}.[x{1}])))(size_out - i{1});
      auto=> />.
  + sp; rcondf 1; auto=> />; 1: smt().
    move=> &h 9?.
    rewrite size_rcons //=; do!split; 1, 2, 4: smt(size_ge0).
    rewrite (take_nth witness) 1:spec_dout 1:size_ge0//=. 
    rewrite - H6; congr; rewrite H4=> //=.
    by apply H3=> //=.
  smt(size_out_gt0 size_ge0 take0).
auto=> //=.
conseq(:_==> l{2} = bs{1} /\ size bs{1} = i{1} /\ i{1} = n{1} /\ n{1} = size_out /\
  inv BIRO.IRO.mp{1} RFList.m{2}.[x{2} <- oget (of_list l{2})])=> />. 
+ smt(get_setE spec2_dout).
+ smt(get_setE spec2_dout).
alias{1} 1 m = BIRO.IRO.mp; sp.
conseq(:_==> l{2} = bs{1} /\ size bs{1} = i{1} /\ i{1} = n{1} /\ 
  n{1} = size_out /\ inv m{1} RFList.m{2} /\
  (forall j, (x{1}, j) \in BIRO.IRO.mp{1} => 0 <= j < i{1}) /\
  (forall l j, l <> x{1} => m{1}.[(l,j)] = BIRO.IRO.mp{1}.[(l,j)]) /\
  (forall j, 0 <= j < i{1} => (x{1}, j) \in BIRO.IRO.mp{1}) /\
  (forall j, 0 <= j < i{1} => BIRO.IRO.mp{1}.[(x{1},j)] = Some (nth witness bs{1} j))).
+ move=> /> &l &r 12?; do!split; ..-2 : smt(domE mem_set).
  move=> l j Hin.
  rewrite get_setE/=.
  case: (l = x{r}) => [<<-|].
  - rewrite oget_some H8; 1:smt(); congr; congr.
    by rewrite eq_sym to_listK; smt(spec2_dout).
  move=> Hneq.
  by rewrite -(H6 _ _ Hneq) H2; smt(domE).
while(l{2} = bs{1} /\ size bs{1} = i{1} /\ 0 <= i{1} <= n{1} /\ ={i} /\
  n{1} = size_out /\ inv m{1} RFList.m{2} /\
  (forall j, (x{1}, j) \in BIRO.IRO.mp{1} => 0 <= j < i{1}) /\
  (forall l j, l <> x{1} => m{1}.[(l,j)] = BIRO.IRO.mp{1}.[(l,j)]) /\
  (forall j, 0 <= j < i{1} => (x{1}, j) \in BIRO.IRO.mp{1}) /\
  (forall j, 0 <= j < i{1} => BIRO.IRO.mp{1}.[(x{1},j)] = Some (nth witness bs{1} j))).
+ sp; rcondt{1} 1; auto=> />.
  - smt().
  move=> &l &r 13?.
  rewrite get_setE/=size_rcons/=; do!split; 1,2: smt(size_ge0).
  - smt(mem_set).
  - smt(get_setE).
  - smt(mem_set).
  - move=>j Hj0 Hjsize; rewrite get_setE/=nth_rcons.
    case: (j = size bs{l})=>[->>//=|h].
    have/=Hjs:j < size bs{l} by smt().
    by rewrite Hjs/=H8//=.
by auto; smt(size_out_gt0).
qed.


local module ExtendSample (F : OFUNCTIONALITY) = {
  proc init = F.init
  proc f (x : bool list, k : int) = {
    var y;
    if (k <= size_out) {
      y <@ F.f(x,size_out);
      y <- omap (take k) y;
    } else {
      y <@ F.f(x,k);
    }
    return y;
  }
}.


local equiv eq_extend :
  ExtendSample(FSome(BIRO.IRO)).f ~ ExtendOutputSize(FSetSize(FSome(BIRO.IRO))).f :
  ={arg} /\ eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2} ==>
  ={res} /\ eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2}.
proof.
proc; inline*; auto; sp.
rcondt{2} 1; 1: auto.
if{1}; sp.
- rcondt{1} 1; auto.
  rcondf{2} 8; 1: auto.
  - conseq(:_==> true); 1: smt(). 
    by while(true); auto.
  auto=> /=.
  conseq(:_==> ={bs, k} /\ size bs{1} = size_out /\
    eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2})=> //=.
  - smt(cats0 to_listK spec2_dout).
  while(={k, bs, n, x2} /\ i{1} = i0{2} /\ n{1} = size_out /\
      0 <= i{1} <= n{1} /\ size bs{1} = i{1} /\
      eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2}).
  - by sp; if; auto; smt(domE get_setE size_rcons).
  by auto; smt(size_eq0 size_out_gt0).
rcondt{1} 1; 1: auto.
splitwhile{1} 1 : i0 < size_out; auto=> /=.
while( (i0, n0, x3){1} = (i, k, x){2} /\ bs0{1} = prefix{2} ++ suffix{2} /\
    size_out <= i{2} <= k{2} /\ eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2}).
+ by sp; if; auto; smt(domE get_setE size_out_gt0 rcons_cat).
auto=> //=.
conseq(:_==> ={i0} /\ size bs{2} = i0{1} /\ (i0, x3){1} = (n, x2){2} /\
    bs0{1} = bs{2} /\ size bs{2} = size_out /\
    eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2}). 
+ smt(cats0 take_oversize spec_dout to_listK spec2_dout).
while(={i0} /\ x3{1} = x2{2} /\ 0 <= i0{1} <= n{2} /\ n{2} = size_out /\
    bs0{1} = bs{2} /\ size bs{2} = i0{1} /\ size_out <= n0{1} /\
    eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2}).
+ by sp; if; auto; smt(size_rcons domE get_setE size_rcons mem_set).
by auto; smt(size_out_gt0).
qed.


local lemma of_listK l : of_list (to_list l) = Some l.
proof.
by rewrite -to_listK.
qed.

local module Fill_In (F : RO) = {
  proc init = F.init
  proc f (x : bool list, n : int) = {
    var l, b, i;
    i <- 0;
    l <- [];
    while (i < n) {
      b <@ F.get((x,i));
      l <- rcons l b;
      i <- i + 1;
    }
    while (i < size_out) {
      F.sample((x,i));
      i <- i + 1;
    }
    return l;
  }
}.


local equiv eq_eager_ideal :
  BIRO.IRO.f ~ Fill_In(LRO).f :
  ={arg} /\ BIRO.IRO.mp{1} = RO.m{2} ==>
  ={res} /\ BIRO.IRO.mp{1} = RO.m{2}.
proof.
proc; inline*; sp; rcondt{1} 1; auto.
while{2}(bs{1} = l{2} /\ BIRO.IRO.mp{1} = RO.m{2})(size_out - i{2}).
+ by auto=> />; smt().
conseq(:_==> bs{1} = l{2} /\ BIRO.IRO.mp{1} = RO.m{2}); 1: smt().
while(={i, n, x} /\ bs{1} = l{2} /\ BIRO.IRO.mp{1} = RO.m{2}).
+ sp; if{1}.
  - by rcondt{2} 2; auto=> />.
  by rcondf{2} 2; auto=> />; smt(dbool_ll).
by auto.
qed.

local equiv eq_eager_ideal2 :
  ExtendSample(FSome(BIRO.IRO)).f ~ FSome(Fill_In(RO)).f :
  ={arg} /\ BIRO.IRO.mp{1} = RO.m{2} ==>
  ={res} /\ BIRO.IRO.mp{1} = RO.m{2}.
proof.
proc; inline*; sp.
if{1}; sp.
+ rcondt{1} 1; auto=> /=/>.
  conseq(:_==> take k{1} bs{1} = l{2} /\ BIRO.IRO.mp{1} = RO.m{2}).
  * smt().
  case: (0 <= n{2}); last first.
  + rcondf{2} 1; 1: by auto; smt(). 
    conseq(:_==> BIRO.IRO.mp{1} = RO.m{2} /\ ={i} /\ n{1} = size_out /\ x2{1} = x0{2})=> />.
    - smt(take_le0).
    while(={i} /\ x2{1} = x0{2} /\ n{1} = size_out /\ BIRO.IRO.mp{1} = RO.m{2}).
    - sp; if{1}.
      - by rcondt{2} 2; auto=> />.
      by rcondf{2} 2; auto=> />; smt(dbool_ll).
    by auto=> />.
  splitwhile{1} 1 : i < k.
  while(={i} /\ n{1} = size_out /\ x2{1} = x0{2} /\  BIRO.IRO.mp{1} = RO.m{2} /\
      take k{1} bs{1} = l{2} /\ size bs{1} = i{1} /\ k{1} <= i{1} <= size_out).
  * sp; if{1}.
    - by rcondt{2} 2; auto; smt(dbool_ll cats1 take_cat cats0 take_size size_rcons).
    by rcondf{2} 2; auto; smt(dbool_ll cats1 take_cat cats0 take_size size_rcons).
  conseq(:_==> ={i} /\ n{1} = size_out /\ x2{1} = x0{2} /\  BIRO.IRO.mp{1} = RO.m{2} /\
      bs{1} = l{2} /\ size bs{1} = i{1} /\ k{1} = i{1}).
  + smt(take_size).
  while(={i} /\ x2{1} = x0{2} /\ n{1} = size_out /\ k{1} = n{2} /\
      0 <= i{1} <= k{1} <= size_out /\ bs{1} = l{2} /\ size bs{1} = i{1} /\
      BIRO.IRO.mp{1} = RO.m{2}).
  + sp; if{1}.
    - by rcondt{2} 2; auto; smt(size_rcons).
    by rcondf{2} 2; auto; smt(size_rcons dbool_ll).
  by auto; smt(size_ge0 size_out_gt0).
rcondt{1} 1; auto.
rcondf{2} 2; 1: auto.
+ conseq(:_==> i = n); 1: smt().
  by while(i <= n); auto=> />; smt(size_out_gt0).
while(i0{1} = i{2} /\ x3{1} = x0{2} /\ n0{1} = n{2} /\ bs0{1} = l{2} /\ 
    BIRO.IRO.mp{1} = RO.m{2}).
+ sp; if{1}.
  - by rcondt{2} 2; auto=> />.
  by rcondf{2} 2; auto; smt(dbool_ll).
by auto=> />.
qed.

local module Dist (F : RO) = {
  proc distinguish = SHA3_OIndiff.OIndif.OIndif(FSome(Fill_In(F)),
      OSimulator(FSome(Fill_In(F))), ODRestr(Dist_of_CollAdv(A))).main
}.

local module Game (F : RO) = {
  proc distinguish () = {
    var bo;
    OSimulator(FSome(Fill_In(F))).init();
    Counter.c <- 0;
    Log.m <- empty;
    F.init();
    bo <@ Dist(F).distinguish();
    return bo;
  }
}.

local lemma eager_ideal &m :
    Pr[SHA3_OIndiff.OIndif.OIndif(FSome(BIRO.IRO),
      OSimulator(FSome(BIRO.IRO)),
      ODRestr(Dist_of_CollAdv(A))).main() @ &m : res] =
    Pr[SHA3_OIndiff.OIndif.OIndif(ExtendSample(FSome(BIRO.IRO)),
      OSimulator(ExtendSample(FSome(BIRO.IRO))),
      ODRestr(Dist_of_CollAdv(A))).main() @ &m : res].
proof.
cut->: 
  Pr[SHA3_OIndiff.OIndif.OIndif(FSome(BIRO.IRO),
    OSimulator(FSome(BIRO.IRO)),
    ODRestr(Dist_of_CollAdv(A))).main() @ &m : res] =
  Pr[Game(LRO).distinguish() @ &m : res].
+ byequiv=> //=; proc.
  inline{2} 1; sp; inline{2} 1; sp; inline{2} 1; sp; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp; sim.
  seq 1 1 : (={m1, m2, glob OFC} /\ BIRO.IRO.mp{1} = RO.m{2}); last first.
  - inline{1} 1; inline{2} 1; sp; sim.
    inline{1} 1; inline{2} 1; sp; sim; if; auto.
    * inline{1} 1; inline{2} 1; sp; sim.
      inline{1} 7; inline{2} 7; sim.
      inline{1} 8; inline{2} 8; sim.
      swap 3 -2; sp.
      case: (increase_counter Counter.c{1} m2{1} size_out <= SHA3Indiff.limit). 
      + rcondt{1} 10; 1: auto.
        - inline*; auto.
          by sp; rcondt 1; auto; conseq(:_==> true); auto.
        rcondt{2} 10; 1: auto.
        - inline*; auto.
          by conseq(:_==> true); auto.
        sim.
        inline{1} 10; inline{2} 10; sim.
        call eq_eager_ideal; auto.
        by call eq_eager_ideal; auto.
      rcondf{1} 10; 1: auto.
      - inline*; auto.
        by sp; rcondt 1; auto; conseq(:_==> true); auto.
      rcondf{2} 10; 1: auto.
      - inline*; auto.
        by conseq(:_==> true); auto.
      by auto; call eq_eager_ideal; auto.
    sp; inline{1} 1; inline{2} 1; sp; sim.
    inline{1} 1; inline{2} 1; sp; sim.
    if; auto.
    inline{1} 1; inline{2} 1; sp; sim.
    by auto; call eq_eager_ideal; auto.
  call(: ={glob OFC, glob OSimulator} /\ 
      BIRO.IRO.mp{1} = RO.m{2}); auto.
  - proc; sp; if; auto.
    inline{1} 1; inline{2} 1; sp; sim; if; 1: auto; sim.
    if; 1: auto; sim; sp.
    if; 1: auto; 1: smt(); sim.
    * inline{1} 1; inline{2} 1; sp; sim.
      by call eq_eager_ideal; auto; smt().
    smt().
  - by proc; inline*; sim.
  proc; sim.
  inline{1} 1; inline{2} 1; sp; sim; if; 1: auto; sim.
  inline{1} 1; inline{2} 1; sp; sim.
  by call eq_eager_ideal; auto.
cut->: 
  Pr[SHA3_OIndiff.OIndif.OIndif(ExtendSample(FSome(BIRO.IRO)),
    OSimulator(ExtendSample(FSome(BIRO.IRO))),
    ODRestr(Dist_of_CollAdv(A))).main() @ &m : res] =
  Pr[Game(RO).distinguish() @ &m : res].
+ byequiv=> //=; proc.
  inline{2} 1; sp; inline{2} 1; sp; inline{2} 1; sp; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp; sim.
  seq 1 1 : (={m1, m2, glob OFC} /\ BIRO.IRO.mp{1} = RO.m{2}); last first.
  - inline{1} 1; inline{2} 1; sp; sim.
    inline{1} 1; inline{2} 1; sp; sim; if; auto.
    * inline{1} 6; inline{2} 6; sim.
      inline{1} 7; inline{2} 7; sim.
      swap 2 -1; sp.
      case: (increase_counter Counter.c{1} m2{1} size_out <= SHA3Indiff.limit). 
      + rcondt{1} 9; 1: auto.
        - inline*; auto.
          by sp; rcondt 1; auto; conseq(:_==> true); auto.
        rcondt{2} 9; 1: auto.
        - inline*; auto.
          by conseq(:_==> true); auto.
        sim.
        call eq_eager_ideal2; auto.
        by call eq_eager_ideal2; auto.
      rcondf{1} 9; 1: auto.
      - inline*; auto.
        by sp; rcondt 1; auto; conseq(:_==> true); auto.
      rcondf{2} 9; 1: auto.
      - inline*; auto.
        by conseq(:_==> true); auto.
      by auto; call eq_eager_ideal2; auto.
    sp; inline{1} 1; inline{2} 1; sp; sim.
    inline{1} 1; inline{2} 1; sp; sim.
    if; auto.
    by auto; call eq_eager_ideal2; auto.
  call(: ={glob OFC, glob OSimulator} /\ 
      BIRO.IRO.mp{1} = RO.m{2}); auto.
  - proc; sp; if; auto.
    inline{1} 1; inline{2} 1; sp; sim; if; 1: auto; sim.
    if; 1: auto; sim; sp.
    if; 1: auto; 1: smt(); sim.
    * by call eq_eager_ideal2; auto; smt().
    smt().
  - by proc; inline*; sim.
  proc; sim.
  inline{1} 1; inline{2} 1; sp; sim; if; 1: auto; sim.
  by call eq_eager_ideal2; auto.
rewrite eq_sym; byequiv=> //=; proc. 
by call(RO_LRO_D Dist); inline*; auto=> />.
qed.

local equiv toto :
  DFSetSize(OFC(ExtendSample(FSome(BIRO.IRO)))).f ~
  DFSetSize(OFC(ExtendSample(FSome(BIRO.IRO)))).f :
  ={glob OFC, arg} /\ eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2} ==>
  ={glob OFC, res} /\ eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2}.
proof.
proc; inline*; sp; if; auto; sp; if; auto; sp; (rcondt{1} 1; 1: auto; rcondt{2} 1; 1: auto)=>/=.
+ conseq(:_==> ={bs} /\ eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2}); auto.
  while(={i, bs, n, x3} /\ 0 <= i{1} <= size_out /\ n{1} = size_out /\ 
      eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2}).
  - by sp; if; auto; smt(domE get_setE size_out_gt0).
  by auto; smt(size_out_gt0).
by conseq(:_==> true); auto; sim.
qed.

local equiv titi mess c:
  DFSetSize(OFC(ExtendSample(FSome(BIRO.IRO)))).f
  ~
  SORO.Bounder(RFWhile).get
  :
  ={arg} /\ arg{1} = mess /\ Counter.c{1} = c /\
    SORO.Bounder.bounder{2} <= Counter.c{1} /\ 
    inv BIRO.IRO.mp{1} RFList.m{2}
  ==>
    if (increase_counter c mess size_out <= sigma) then
    (exists y, res{1} = Some y /\ res{2} = Some y /\
      SORO.Bounder.bounder{2} <= Counter.c{1} /\
      Counter.c{1} = increase_counter c mess size_out /\
      inv BIRO.IRO.mp{1} RFList.m{2})
    else (res{1} = None).
proof.
proc; sp.
inline{1} 1; sp; auto.
if{1}.
- rcondt{2} 1; first by auto; smt(divz_ge0 gt0_r size_ge0).
  sp; auto. 
  inline{1} 1; sp; auto.
  sp; rcondt{1} 1; auto.
  inline{1} 1; sp; auto.
  call(eq_IRO_RFWhile); auto=> /> 15?. 
  rewrite take_oversize 1:/# /=. 
  have:=spec2_dout _ H5.
  move=>/(some_oget)-> /=; smt(divz_ge0 gt0_r size_ge0 spec2_dout).
move=>/=.
conseq(:_==> true); auto.
inline*; if{2}; auto; sp; if{2}; auto; sp.
by while{2}(true)(size_out - i{2}); auto; smt(dbool_ll).
qed.

local lemma rw_ideal_2 &m :
    Pr[SHA3_OIndiff.OIndif.OIndif(FSome(BIRO.IRO), OSimulator(FSome(BIRO.IRO)), 
      ODRestr(Dist_of_CollAdv(A))).main() @ &m : res] <=
    Pr[SORO.Collision(SORO_Coll(A), RFList).main() @ &m : res].
proof.
have->:Pr[SORO.Collision(SORO_Coll(A), RFList).main() @ &m : res] =
       Pr[SORO.Collision(SORO_Coll(A), RFWhile).main() @ &m : res].
+ byequiv(: ={glob A, arg} ==> _)=>//=; proc.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  seq 1 1 : (={mi, glob A, glob SORO.Bounder, glob RFList}); last first.
  - sp; inline{1} 2; inline{2} 2; inline{1} 1; inline{2} 1; sp; sim.
    if; auto.
    - sp; case: (SORO.Bounder.bounder{1} < sigma).
      * rcondt{1} 5; 1: auto.
        + by inline*; auto; conseq(:_==> true); auto.
        rcondt{2} 5; 1: auto.
        + by inline*; auto; conseq(:_==> true); auto.
        call(rw_RF_List_While); auto.
        by call(rw_RF_List_While); auto=> />.
      rcondf{1} 5; 1: auto.
      + by inline*; auto; conseq(:_==> true); auto.
      rcondf{2} 5; 1: auto.
      + by inline*; auto; conseq(:_==> true); auto.
      by auto; call(rw_RF_List_While); auto.
    by sp; if; auto; call(rw_RF_List_While); auto.
  call(: ={glob SORO.Bounder, glob RFList, glob OSimulator, glob OPC, glob Log}); auto.
  - proc; sp; if; auto.
    inline{1} 1; inline{2} 1; sp; if; 1, 3: auto; sim.
    if; 1: auto; sim; sp; sim; if; auto=> />; 1: smt(); sim.
    + inline{1} 1; inline{2} 1; sp; sim.
      inline{1} 1; inline{2} 1; sp; if; auto=> />.
      - by call(rw_RF_List_While); auto; smt(). 
      smt().
    smt().
  - by sim. 
  proc; sim; inline{1} 1; inline{2} 1; sp; if; auto.
  inline{1} 1; inline{2} 1; sp; sim.
  inline{1} 1; inline{2} 1; sp; if; auto; sim.
  by call(rw_RF_List_While); auto.
rewrite (eager_ideal &m).
have->:Pr[SHA3_OIndiff.OIndif.OIndif(ExtendSample(FSome(BIRO.IRO)),
         OSimulator(ExtendSample(FSome(BIRO.IRO))),
          ODRestr(Dist_of_CollAdv(A))).main() @ &m : res] =
       Pr[SHA3_OIndiff.OIndif.OIndif(ExtendSample(FSome(BIRO.IRO)),
         OSimulator(ExtendOutputSize(FSetSize(FSome(BIRO.IRO)))),
         ODRestr(Dist_of_CollAdv(A))).main() @ &m : res].
+ byequiv=> //=; proc.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp; auto=> />.
  call(toto); call(toto); auto.
  conseq(:_==> ={m1, m2, glob Counter} /\
      eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2}); 1: smt().
  call(: ={glob OSimulator, glob OFC} /\
         eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2}); last first; auto.
  + smt(mem_empty).
  + proc; sp; if; auto.
    inline{1} 1; inline{2} 1; sp; if; 1, 3: auto.
    if; 1, 3: auto; sp.
    if; 1: auto; 1: smt(); last first.
    - by conseq=> />; sim; smt().
    wp=> />; 1: smt().
    rnd; auto.
    call(eq_extend); by auto; smt().
  + by proc; sp; if; auto; inline{1} 1; inline{2} 1; sp; if; auto.
  proc; sp; inline{1} 1; inline{2} 1; sp; if; auto.
  inline*; sp.
  rcondt{1} 1; 1: auto; rcondt{2} 1; 1: auto; sp.
  rcondt{1} 1; 1: auto; rcondt{2} 1; 1: auto; sp; auto.
  conseq(:_==> ={bs} /\ eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2}); 
    1: by auto.
  while(={i, n, x3, bs} /\ 0 <= i{1} <= size_out /\ n{1} = size_out /\ 
      eq_extend_size BIRO.IRO.mp{1} BIRO.IRO.mp{2} Log.m{2}).
  - by sp; if; auto; smt(domE get_setE size_rcons).
  by auto; smt(size_out_gt0).
byequiv=> //=; proc.
inline{1} 1; inline{2} 1; sp.
inline{1} 1; inline{2} 1; sp.
inline{1} 1; inline{2} 1; sp.
inline{1} 1; inline{2} 1; sp.
inline{1} 1; inline{2} 1; sp.
inline{1} 1; sp; auto.
seq 1 2 : (={glob A, glob OFC, glob OSimulator, Log.m, m1, m2} /\
         inv BIRO.IRO.mp{1} RFList.m{2} /\
         SORO.Bounder.bounder{2} <= Counter.c{1}); last first.
+ sp; case: (increase_counter Counter.c{1} m1{1} size_out <= SHA3Indiff.limit).
  - exists * m2{2}, m1{1}, Counter.c{1}; elim* => mess2 mess1 c.
    call(titi mess2 (increase_counter c mess1 size_out))=> /= />.
    by call(titi mess1 c)=> />; auto; smt().
  inline*; sp.
  rcondf{1} 1; 1: auto; sp.
  conseq(:_==> true); auto.
  seq 1 0 : true.
  - if{1}; auto; sp; 1: if{1}; auto; sp.
    - rcondt{1} 1; auto.
      while{1}(true)(n1{1}-i1{1}); auto; -1: smt().
      by sp; if; auto; smt(dbool_ll).
    rcondt{1} 1; 1: auto.
    while{1}(true)(n2{1}-i2{1}); auto.
    by sp; if; auto; smt(dbool_ll).
  seq 0 1 : true.
  - if{2}; auto; sp; if{2}; auto; sp.
    by while{2}(true)(size_out-i{2}); auto; smt(dbool_ll).
  sp; if{2}; auto; sp; if{2}; auto; sp.
  by while{2}(true)(size_out-i0{2}); auto; smt(dbool_ll).
conseq(:_==> ={glob A, glob OFC, glob OSimulator, Log.m, m1, m2} /\
  inv BIRO.IRO.mp{1} RFList.m{2} /\ SORO.Bounder.bounder{2} <= Counter.c{1}).
auto; call(: ={glob OSimulator, glob Counter, glob Log} /\ 
    inv BIRO.IRO.mp{1} RFList.m{2} /\
    SORO.Bounder.bounder{2} <= Counter.c{1}); auto; last first.
+ by smt(mem_empty).
+ proc; sp; if; auto=> />; 1: smt(). 
  inline{1} 1; inline{2} 1; sp; auto.
  if; 1, 3: auto; -1: smt().
  if; 1, 3: auto; -1: smt().
  sp; if; 1: auto; 1: smt(); last first.
  - by conseq(:_==> ={y, glob OSimulator}); 1: smt(); sim; smt().
  inline{1} 1; inline{2} 1; sp.
  inline{1} 1; inline{2} 1; sp.
  rcondt{2} 1; 1: by auto; smt().
  sp.
  seq 3 2 : (={x0, x1, o1, k0, Log.m, suffix, glob OSimulator} /\
      inv BIRO.IRO.mp{1} RFList.m{2} /\ 
      SORO.Bounder.bounder{2} <= Counter.c{2} + 1); last first.
  - by conseq(:_==> ={y, x1, glob OSimulator, Log.m}); 1: smt(); sim=> />.
  inline{1} 1; auto.
  by call(eq_IRO_RFWhile); auto; smt().
+ by proc; inline*; sp; if; auto; sp; if; auto=> />; smt().
proc.
inline{1} 1; inline{2} 1; sp; if; auto=> /=.
inline{1} 1; inline{2} 1; sp.
rcondt{1} 1; 1: auto.
inline{1} 1; auto.
rcondf{2} 4; 1: auto. 
+ inline*; auto; sp; if; auto; sp; if; auto=> />; conseq(:_==> true); 1: smt().
  by while(true); auto.
inline{2} 1; sp.
rcondt{2} 1; 1: by auto; smt(divz_ge0 gt0_r size_ge0).
auto; call eq_IRO_RFWhile; auto=> />.
move=> &l &r 14?; split; 2: smt(divz_ge0 gt0_r size_ge0).
rewrite cats0 take_oversize 1:/# take_oversize 1:spec_dout //=.
have h:=spec2_dout result_L H5.
have-> := some_oget _ h.
by rewrite eq_sym -to_listK; congr.
qed.

local lemma rw_ideal &m :
    Pr[SHA3_OIndiff.OIndif.OIndif(FSome(BIRO.IRO), OSimulator(FSome(BIRO.IRO)), 
      ODRestr(Dist_of_CollAdv(A))).main() @ &m : res] <=
    Pr[SORO.Collision(SORO_Coll(A),RF(SORO.RO.RO)).main() @ &m : res].
proof.
rewrite (StdOrder.RealOrder.ler_trans _ _ _ (rw_ideal_2 &m)).
byequiv(: ={glob A} ==> _) => //=; proc; inline*; sp; wp.
seq 1 1 : (={glob A, glob SHA3Indiff.Simulator, glob SORO.Bounder, glob Counter, 
    glob Log, mi} /\ RFList.m{1} = SORO.RO.RO.m{2}).
+ call(: ={glob SHA3Indiff.Simulator, glob SORO.Bounder, glob Counter, glob Log} /\ 
    RFList.m{1} = SORO.RO.RO.m{2}); auto.
  - proc; sp; if; 1, 3: auto; sp.
    inline *; sp; sim.
    if; 1: auto; sim. 
    if; 1: auto; sim.
    sp; if; 1: (auto; smt()); sim; 2: smt(). 
    sp; if; 1: auto; sim; -1: smt().
    sp; if{1}.
    * rcondt{2} 2; auto; 1: smt(BlockSponge.parse_valid).
      rnd (fun l => oget (of_list l)) to_list; auto=> />.
      move=> &l &r 11?; split; 1: smt(of_listK).
      rewrite -dout_equal_dlist=> ?; split=> ?.
      + by rewrite dmapE=> h{h}; apply mu_eq=> x; smt(to_list_inj).
      move=> sample.
      rewrite !get_setE/= dout_full/= => h; split; 2: smt(). 
      rewrite eq_sym to_listK; apply some_oget.
      apply spec2_dout.
      by move:h; rewrite supp_dmap; smt(spec_dout).
    by auto; smt(dout_ll).
  - by proc; inline*; sp; if; auto; sp; if; auto.
  - proc; inline*; sp; if; auto; sp; if; auto; sp; sim.
    if{1}.
    * rcondt{2} 2; auto.
      rnd (fun l => oget (of_list l)) to_list; auto=> />.
      move=> &l 4?; split=> ?; 1: smt(of_listK).
      rewrite -dout_equal_dlist; split=> ?.
      * by rewrite dmapE=> h{h}; apply mu_eq=> x; smt(to_list_inj).
      move=> sample.
      rewrite supp_dmap dout_full/= =>/> a.
      by rewrite get_setE/= dout_full/=; congr; rewrite of_listK oget_some.
  by auto; smt(dout_ll). 
sp.
seq 4 4 : (={SORO.Bounder.bounder, x0, m1, m2, hash1, y0} /\ y0{1} = None /\
  RFList.m{1} = SORO.RO.RO.m{2}); last first.
+ if; 1, 3: auto; sp.
  if{1}.
  - rcondt{2} 2; 1: auto.
    auto; rnd (fun t => oget (of_list t)) to_list; auto=> />.
    move=> &l c Hc Hnin; split.
    - move=> ret Hret. 
      by have/= ->:= (to_listK ret (to_list ret)).
    move=> h{h}; split.
    - move=> ret Hret; rewrite -dout_equal_dlist.
      rewrite dmapE /=; apply mu_eq=> //= x /=.
      by rewrite /(\o) /pred1/=; smt(to_list_inj).
    move=> h{h} l Hl. 
    rewrite dout_full /=.
    have:= spec2_dout l.
    have:=supp_dlist dbool size_out l _; 1: smt(size_out_gt0).
    rewrite Hl/==> [#] -> h{h} /= H.
    have H1:=some_oget _ H.
    have:=to_listK (oget (of_list l)) l; rewrite {2}H1/= => -> /= {H H1}.
    by rewrite get_setE/=; smt().
  by auto=> />; smt(dout_ll).
if; 1, 3: auto; sp.
if{1}.
- rcondt{2} 2; 1: auto.
  auto; rnd (fun t => oget (of_list t)) to_list; auto=> />.
  move=> &l c Hc Hnin; split.
  - move=> ret Hret. 
    by have/= ->:= (to_listK ret (to_list ret)).
  move=> h{h}; split.
  - move=> ret Hret; rewrite -dout_equal_dlist.
    rewrite dmapE /=; apply mu_eq=> //= x /=.
    by rewrite /(\o) /pred1/=; smt(to_list_inj).
  move=> h{h} l Hl. 
  rewrite dout_full /=.
  have:= spec2_dout l.
  have:=supp_dlist dbool size_out l _; 1: smt(size_out_gt0).
  rewrite Hl/==> [#] -> h{h} /= H.
  have H1:=some_oget _ H.
  have:=to_listK (oget (of_list l)) l; rewrite {2}H1/= => -> /= {H H1}.
  by rewrite get_setE/=; smt().
by auto=> />; smt(dout_ll).
qed.

local lemma leq_ideal &m :
    Pr[SHA3_OIndiff.OIndif.OIndif(FSome(BIRO.IRO), OSimulator(FSome(BIRO.IRO)), 
      ODRestr(Dist_of_CollAdv(A))).main() @ &m : res] <=
    (sigma * (sigma - 1) + 2)%r / 2%r / 2%r ^ size_out.
proof.
rewrite (StdOrder.RealOrder.ler_trans _ _ _ (rw_ideal &m)).
rewrite (StdOrder.RealOrder.ler_trans _ _ _ (RO_is_collision_resistant (SORO_Coll(A)) &m)).
by rewrite doutE1.
qed.

local lemma rw_real &m : 
    Pr[Collision(A, OSponge, PSome(Perm)).main() @ &m : res] =
    Pr[SHA3_OIndiff.OIndif.OIndif(FSome(Sponge(Poget(PSome(Perm)))), PSome(Perm), 
      ODRestr(Dist_of_CollAdv(A))).main() @ &m : res].
proof.
byequiv=>//=; proc.
inline{1} 1; inline{2} 1; sp.
inline{1} 1; inline{2} 1; sp.
inline{1} 1; inline{2} 1; sp.
inline{1} 1; inline{2} 1; sp.
inline{1} 1; inline{2} 1; sp.
inline{1} 1; sp; wp=> />.
seq 1 1 : (={glob A, glob Perm, m1, m2} /\ Bounder.bounder{1} = Counter.c{2}).
+ auto; call(: ={glob Perm} /\ Bounder.bounder{1} = Counter.c{2})=> //=.
  - by proc; inline*; sp; if; auto; 2:sim=> />; 1: smt().
  - by proc; inline*; sp; if; auto; 2:sim=> />; 1: smt().
  - proc; inline*; sp; if; auto; sp=> />.
  by conseq(:_==> ={z0, glob Perm})=> />; sim.
conseq(:_==> ={hash1, hash2, m1, m2})=> //=; 1: smt(); sim.
seq 1 1 : (={m1, m2, hash1, glob Perm} /\ Bounder.bounder{1} = Counter.c{2}); last first.
+ inline*; sp; if; auto; sp=> /=; sim.
inline*; sp; if; auto; swap{1} 9; auto; sp=> /=.
by conseq(:_==>  ={m1, m2} /\ of_list (oget (Some (take n{1} z0{1}))) =
  of_list (oget (Some (take n{2} z0{2}))) /\ ={Perm.mi, Perm.m})=> //=; sim.
qed.

lemma Sponge_collision_resistant &m :
    (forall (F <: OIndif.ODFUNCTIONALITY) (P <: OIndif.ODPRIMITIVE),
      islossless F.f => islossless P.f => islossless P.fi => islossless A(F,P).guess) =>
    Pr[Collision(A, OSponge, PSome(Perm)).main() @ &m : res] <=
    (limit ^ 2 - limit)%r / (2 ^ (r + c + 1))%r +
    (4 * limit ^ 2)%r / (2 ^ c)%r +
    (sigma * (sigma - 1) + 2)%r / 2%r / 2%r ^ size_out.
proof.
move=> A_ll.
rewrite (rw_real &m).
have := SHA3OIndiff (Dist_of_CollAdv(A)) &m _.
+ move=> F P Hp Hpi Hf; proc; inline*; sp; auto; call Hf; auto; call Hf; auto. 
  call(A_ll (DFSetSize(F)) P _ Hp Hpi); auto.
  proc; inline*; auto; call Hf; auto.
by have/#:=leq_ideal &m.
qed.

end section Collision.



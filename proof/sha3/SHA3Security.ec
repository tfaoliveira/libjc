(* Top-level Proof of SHA-3 Security *)

require import AllCore Distr DList DBool List IntExtra IntDiv Dexcepted DProd SmtMap FSet.
require import Common SLCommon Sponge SHA3Indiff.
require (****) IndifRO_is_secure.

module SHA3 (P : DPRIMITIVE) = {
  proc init() : unit = {}
  proc f (bl : bool list, n : int) : bool list = {
    var r : bool list;
    r <@ Sponge(P).f(bl ++ [false; true], n);
    return r;
  }
}.

op    size_out     : int.
axiom size_out_gt0 : 0 < size_out.

op    sigma     : int.
axiom sigma_gt0 : 0 < sigma.

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

module CSetSize (F : CONSTRUCTION) (P : DPRIMITIVE) = {
  proc init = F(P).init
  proc f (x : bool list) = {
    var r;
    r <@ F(P).f(x,size_out);
    return oget (of_list r);
  }
}.

module FSetSize (F : FUNCTIONALITY) = {
  proc init = F.init
  proc f (x : bool list) = {
    var r;
    r <@ F.f(x,size_out);
    return oget (of_list r);
  }
}.

clone import IndifRO_is_secure as S with
  type block  <- block * capacity,
  type f_in   <- bool list,
  type f_out  <- f_out,

  op sampleto <- dout,
  op bound    <- (limit ^ 2 - limit)%r / (2 ^ (r + c + 1))%r
                 + (4 * limit ^ 2)%r / (2 ^ c)%r,
  op limit    <- sigma,
  op bound_counter <- limit,
  op increase_counter <- fun c m => c + ((size m + 1) %/ r + 1) +
        max ((size_out + r - 1) %/ r - 1) 0

  proof *. 


realize bound_counter_ge0     by exact(SLCommon.max_ge0).
realize limit_gt0             by exact(sigma_gt0). 
realize sampleto_ll           by exact(dout_ll).
realize sampleto_fu           by exact(dout_fu).
realize sampleto_full         by exact(dout_full).
realize increase_counter_spec by smt(List.size_ge0 divz_ge0 gt0_r).

module FGetSize (F : Indiff0.DFUNCTIONALITY) = {
  proc f (x : bool list, i : int) = {
    var r;
    r <@ F.f(x);
    return to_list r;
  }
}.

module SimSetSize (S : SIMULATOR) (F : Indiff0.DFUNCTIONALITY) = S(FGetSize(F)).

module DFSetSize (F : DFUNCTIONALITY) = {
  proc f (x : bool list) = {
    var r;
    r <@ F.f(x,size_out);
    return oget (of_list r);
  }
}.

module (DSetSize (D : Indiff0.DISTINGUISHER) : DISTINGUISHER)
  (F : DFUNCTIONALITY) (P : DPRIMITIVE) = D(DFSetSize(F),P).


section Preimage.

  declare module A : SRO.AdvPreimage{SRO.RO.RO, SRO.RO.FRO, SRO.Bounder, Perm, 
    Gconcl_list.BIRO2.IRO, Simulator, Cntr, BIRO.IRO, F.RO, F.FRO, Redo, C, 
    Gconcl.S, BlockSponge.BIRO.IRO, BlockSponge.C, Gconcl_list.F2.RO,
    Gconcl_list.F2.FRO, Gconcl_list.Simulator, DPre}.

  axiom A_ll (F <: SRO.Oracle { A }) : islossless F.get => islossless A(F).guess.

  local lemma invm_dom_rng (m mi : (state, state) fmap) :
      invm m mi => dom m = rng mi.
  proof. 
  move=>h; rewrite fun_ext=> x; rewrite domE rngE /= eq_iff; have h2 := h x; split.
  + move=> m_x_not_None; exists (oget m.[x]); rewrite -h2; move: m_x_not_None.
    by case: (m.[x]).
  by move=> [] a; rewrite -h2 => ->.
  qed.

  local lemma invmC' (m mi : (state, state) fmap) :
      invm m mi => invm mi m.
  proof. by rewrite /#. qed.

  local lemma invmC (m mi : (state, state) fmap) :
      invm m mi <=> invm mi m.
  proof. by split;exact invmC'. qed.

  local lemma useful m mi a :
      invm m mi => ! a \in m => Distr.is_lossless ((bdistr `*` cdistr) \ rng m).
  proof.
  move=>hinvm nin_dom.
  cut prod_ll:Distr.is_lossless (bdistr `*` cdistr).
  + by rewrite dprod_ll DBlock.dunifin_ll DCapacity.dunifin_ll. 
  apply dexcepted_ll=>//=;rewrite-prod_ll.
  cut->:predT = predU (predC (rng m)) (rng m);1:rewrite predCU//=.
  rewrite Distr.mu_disjoint 1:predCI//=StdRing.RField.addrC. 
  cut/=->:=StdOrder.RealOrder.ltr_add2l (mu (bdistr `*` cdistr) (rng m)) 0%r.
  rewrite Distr.witness_support/predC.
  move:nin_dom;apply absurd=>//=;rewrite negb_exists/==>hyp. 
  cut{hyp}hyp:forall x, rng m x by smt(supp_dprod DBlock.supp_dunifin DCapacity.supp_dunifin). 
  move:a. 
  cut:=eqEcard (fdom m) (frng m);rewrite leq_card_rng_dom/=. 
  cut->//=:fdom m \subset frng m. 
  + by move=> x; rewrite mem_fdom mem_frng hyp.
  smt(mem_fdom mem_frng).
  qed.


  local equiv equiv_sponge_perm c m :
      FInit(CSetSize(Sponge, Perm)).get ~ FInit(DFSetSize(FC(Sponge(Perm)))).get :
    ={arg, glob Perm} /\ invm Perm.m{1} Perm.mi{1} /\ 
      Cntr.c{2} = c /\ arg{2} = m /\
      (Cntr.c + ((size arg + 1) %/ Common.r + 1) + 
      max ((size_out + Common.r - 1) %/ Common.r - 1) 0 <= limit){2} ==>
    ={res, glob Perm} /\ invm Perm.m{1} Perm.mi{1} /\ 
      Cntr.c{2} = c + ((size m + 1) %/ Common.r + 1) + 
      max ((size_out + Common.r - 1) %/ Common.r - 1) 0.
  proof.
  proc; inline FC(Sponge(Perm)).f; sp.
  rcondt{2} 1; auto; sp.
  call(: ={glob Perm} /\ invm Perm.m{1} Perm.mi{1})=>/=; auto; inline*.
  while(={i, n, sa, sc, z, glob Perm} /\ invm Perm.m{1} Perm.mi{1}); auto.
  + sp; if; auto; sp; if; auto; progress.
    rewrite invm_set //=.
    by move:H4; rewrite supp_dexcepted.
  sp; conseq(:_==> ={i, n, sa, sc, glob Perm} /\ invm Perm.m{1} Perm.mi{1}); auto.
  while(={xs, sa, sc, glob Perm} /\ invm Perm.m{1} Perm.mi{1}); auto.
  sp; if; auto; progress. 
  rewrite invm_set=>//=.
  by move:H4; rewrite supp_dexcepted.
  qed.


  op same_ro (m1 : (bool list, f_out) fmap) (m2 : (bool list * int, bool) fmap) =
      (forall m, m \in m1 => forall i, 0 <= i < size_out => (m,i) \in m2)
    && (forall m, (exists i, 0 <= i < size_out /\ (m,i) \in m2) => m \in m1)
    && (forall m, m \in m1 => to_list (oget m1.[m]) = map (fun i => oget m2.[(m,i)]) (range 0 size_out)).

  op same_ro2 (m1 : (bool list, bool list) fmap) (m2 : (bool list * int, bool) fmap) =
      (forall m, m \in m1 => forall i, 0 <= i < size_out => (m,i) \in m2)
    && (forall m, (exists i, 0 <= i < size_out /\ (m,i) \in m2) => m \in m1)
    && (forall m, m \in m1 => oget m1.[m] = map (fun i => oget m2.[(m,i)]) (range 0 size_out)).

  clone import Program as Prog with
    type t <- bool,
    op d <- dbool
    proof *.

  local equiv equiv_ro_iro c m :
    FInit(RO).get ~ FInit(DFSetSize(FC(BIRO.IRO))).get :
    ={arg} /\ same_ro SRO.RO.RO.m{1} BIRO.IRO.mp{2} /\
    arg{2} = m /\ Cntr.c{2} = c /\
    (Cntr.c + ((size arg + 1) %/ Common.r + 1) + 
      max ((size_out + Common.r - 1) %/ Common.r - 1) 0 <= limit){2}
    ==> ={res} /\ same_ro SRO.RO.RO.m{1} BIRO.IRO.mp{2} /\ 
      Cntr.c{2} = c + ((size m + 1) %/ Common.r + 1) + 
      max ((size_out + Common.r - 1) %/ Common.r - 1) 0.
  proof.
  proc; inline *; sp; rcondt{2} 1; 1: auto.
  swap{2} 1 5; sp; wp 2 1.
  conseq(:_==> oget SRO.RO.RO.m{1}.[x{1}] = oget (of_list bs0{2}) /\
    same_ro SRO.RO.RO.m{1} BIRO.IRO.mp{2}); 1:by auto.
  rcondt{2} 1; 1: auto.
  case: (x{1} \in SRO.RO.RO.m{1}).
  + rcondf{1} 2; auto.
    exists* BIRO.IRO.mp{2}; elim* => mp.
    while{2}(bs0{2} = map (fun j => oget BIRO.IRO.mp{2}.[(x0{2},j)]) (range 0 i{2})
        /\ n0{2} = size_out /\ x0{2} \in SRO.RO.RO.m{1} /\ 0 <= i{2} <= size_out
        /\ same_ro SRO.RO.RO.m{1} BIRO.IRO.mp{2} /\ BIRO.IRO.mp{2} = mp)
      (size_out - i{2}); auto.
    - sp; rcondf 1; auto; 1: smt().
      progress. 
      * have/=<-:= map_rcons (fun (j : int) => oget BIRO.IRO.mp{hr}.[(x0{hr}, j)]) (range 0 i{hr}) i{hr}.
        by rewrite !rangeSr //=.
      * smt().
      * smt().
      * smt().
    progress. 
    - by rewrite range_geq.
    - smt(size_out_gt0).
    - smt().
    - exact(dout_ll).
    - have[] h[#] h1 h2 := H.
      cut->:i_R = size_out by smt().
      cut<-:=h2 _ H3.
      smt(to_listK).
  rcondt{1} 2; 1: auto; wp =>/=.
  exists* BIRO.IRO.mp{2}; elim* => mp.
  conseq(:_==> 
        same_ro SRO.RO.RO.m{1} mp /\ i{2} = size_out /\
        (forall (l,j),  (l,j) \in mp => (l,j) \in BIRO.IRO.mp{2}) /\
        (forall (l,j),  (l,j) \in mp => BIRO.IRO.mp{2}.[(l,j)] = mp.[(l,j)]) /\
        (forall (l,j), (l,j) \in BIRO.IRO.mp{2} => (l,j) \in mp \/ (l = x0{2} /\ 0 <= j < i{2})) /\
        (forall j, 0 <= j < i{2} => (x0{2},j) \in BIRO.IRO.mp{2}) /\
        take i{2} (to_list r{1}) = bs0{2} /\
        take i{2} (to_list r{1}) = map (fun (j : int) => oget BIRO.IRO.mp{2}.[(x0{2}, j)]) (range 0 i{2})); progress=>//=.
  + by rewrite get_set_sameE /=; smt(to_listK take_oversize spec_dout).
  + move:H8; rewrite mem_set=>[][]//=h; 1:rewrite H3=>//=.
    - by have []h1 []h2 h3:= H2; have->//:=h1 _ h.
    by move:h => <<-; rewrite H6 //=.
  + rewrite mem_set//=; have[]//=h:= H5 _ _ H11; left.
    have []h1 []->//=:= H2.
    by exists i0=>//=.
  + move:H7; rewrite take_oversize 1:spec_dout//= => H7.
    move:H10; rewrite mem_set. 
    case(m \in SRO.RO.RO.m{1})=>//=h.
    - rewrite get_set_neqE; 1:smt().
      have []h1 []h2 ->//=:= H2. 
      by apply eq_in_map=> j;rewrite mem_range=>[][]hj1 hj2/=; rewrite H4//=h1//=.
    by move=><<-; rewrite get_set_eqE//=.
  alias{1} 1 l = [<:bool>].
  transitivity{1} {
      l <@ Sample.sample(size_out);
      r <- oget (of_list l);
    }
    (={glob SRO.RO.RO, x} ==> ={glob SRO.RO.RO, r})
    (x{1} = x0{2} /\ i{2} = 0 /\ n0{2} = size_out /\ mp = BIRO.IRO.mp{2} /\
      same_ro SRO.RO.RO.m{1} BIRO.IRO.mp{2} /\ x{1} \notin SRO.RO.RO.m{1} /\
      bs0{2} = []
      ==>
      same_ro SRO.RO.RO.m{1} mp /\ i{2} = size_out /\
      (forall (l,j),  (l,j) \in mp => (l,j) \in BIRO.IRO.mp{2}) /\
      (forall (l,j),  (l,j) \in mp => BIRO.IRO.mp{2}.[(l,j)] = mp.[(l,j)]) /\
      (forall (l,j), (l,j) \in BIRO.IRO.mp{2} => (l,j) \in mp \/ (l = x0{2} /\ 0 <= j < i{2})) /\
      (forall j, 0 <= j < i{2} => (x0{2},j) \in BIRO.IRO.mp{2}) /\
      take i{2} (to_list r{1}) = bs0{2} /\
      take i{2} (to_list r{1}) = 
        map (fun (j : int) => oget BIRO.IRO.mp{2}.[(x0{2}, j)]) (range 0 i{2})); 
    progress.
  + smt().
  + inline*; sp; wp. 
    rnd to_list (fun x => oget (of_list x)); auto; progress. 
    - smt(spec_dout supp_dlist to_listK spec2_dout size_out_gt0). 
    - rewrite -dout_equal_dlist dmap1E; apply mu_eq=> x/=. 
      smt(to_listK).
    - rewrite-dout_equal_dlist supp_dmap; smt(dout_full).
    smt(to_listK).
  wp=>/=.
  conseq(:_==> i{2} = size_out /\ size l{1} = size_out /\
      (forall (l0 : bool list) (j : int),
        (l0, j) \in mp => (l0, j) \in BIRO.IRO.mp{2}) /\
      (forall (l0 : bool list) (j : int),
        (l0, j) \in mp => BIRO.IRO.mp{2}.[(l0, j)] = mp.[(l0, j)]) /\
      (forall (l0 : bool list) (j : int),
        (l0, j) \in BIRO.IRO.mp{2} => ((l0, j) \in mp) \/ (l0 = x0{2} /\ 0 <= j < i{2})) /\
      (forall (j : int), 0 <= j < i{2} => (x0{2}, j) \in BIRO.IRO.mp{2}) /\
      take i{2} l{1} = bs0{2} /\
      take i{2} l{1} =
        map (fun (j : int) => oget BIRO.IRO.mp{2}.[(x0{2}, j)]) (range 0 i{2}));
    progress.
  + have[]//=h h1:=to_listK (oget (of_list l_L)) l_L; rewrite h1//==> {h1 h}.
    smt(spec2_dout).
  + have[]//=h h1:=to_listK (oget (of_list l_L)) l_L; rewrite h1//==> {h1 h}.
    smt(spec2_dout). 
  transitivity{1} {
      l <@ LoopSnoc.sample(size_out);
    }
    (={glob SRO.RO.RO} ==> ={glob SRO.RO.RO, l})
    (x{1} = x0{2} /\ i{2} = 0 /\ n0{2} = size_out /\ mp = BIRO.IRO.mp{2} /\
      same_ro SRO.RO.RO.m{1} BIRO.IRO.mp{2} /\ x0{2} \notin SRO.RO.RO.m{1} /\
      bs0{2} = []
      ==>
      i{2} = size_out /\ size l{1} = size_out /\
      (forall (l,j),  (l,j) \in mp => (l,j) \in BIRO.IRO.mp{2}) /\
      (forall (l,j),  (l,j) \in mp => BIRO.IRO.mp{2}.[(l,j)] = mp.[(l,j)]) /\
      (forall (l,j), (l,j) \in BIRO.IRO.mp{2} => (l,j) \in mp \/ (l = x0{2} /\ 0 <= j < i{2})) /\
      (forall j, 0 <= j < i{2} => (x0{2},j) \in BIRO.IRO.mp{2}) /\
      take i{2} l{1} = bs0{2} /\
      take i{2} l{1} = 
        map (fun (j : int) => oget BIRO.IRO.mp{2}.[(x0{2}, j)]) (range 0 i{2})); 
    progress.
  + smt(). 
  + by call Sample_LoopSnoc_eq; auto.
  inline*; sp; wp.
  conseq(:_==> i{2} = size_out /\ size l0{1} = i{2} /\ 
      same_ro SRO.RO.RO.m{1} mp /\ x0{2} \notin SRO.RO.RO.m{1} /\
      (forall l j, (l,j) \in mp => (l,j) \in BIRO.IRO.mp{2}) /\
      (forall l j, (l,j) \in mp => BIRO.IRO.mp{2}.[(l, j)] = mp.[(l, j)]) /\
      (forall l j, (l, j) \in BIRO.IRO.mp{2} => ((l, j) \in mp) \/ (l = x0{2} /\ 0 <= j < i{2})) /\
      (forall j, 0 <= j < i{2} => (x0{2}, j) \in BIRO.IRO.mp{2}) /\
      l0{1} = bs0{2} /\ bs0{2} = 
        map (fun (j : int) => oget BIRO.IRO.mp{2}.[(x0{2}, j)]) (range 0 i{2})); progress.
  + smt(take_oversize).
  + smt(take_oversize).
  while(0 <= i{2} <= size_out /\ size l0{1} = i{2} /\ n0{2} = size_out /\
      ={i} /\ n{1} = n0{2} /\
      same_ro SRO.RO.RO.m{1} mp /\ x0{2} \notin SRO.RO.RO.m{1} /\
      (forall l j, (l,j) \in mp => (l,j) \in BIRO.IRO.mp{2}) /\
      (forall l j, (l,j) \in mp => BIRO.IRO.mp{2}.[(l, j)] = mp.[(l, j)]) /\
      (forall l j, (l, j) \in BIRO.IRO.mp{2} => ((l, j) \in mp) \/ (l = x0{2} /\ 0 <= j < i{2})) /\
      (forall j, 0 <= j < i{2} => (x0{2}, j) \in BIRO.IRO.mp{2}) /\
      l0{1} = bs0{2} /\ bs0{2} = 
        map (fun (j : int) => oget BIRO.IRO.mp{2}.[(x0{2}, j)]) (range 0 i{2})).
  + sp; wp=> //=.
    rcondt{2} 1; 1:auto; progress.
    - have[]h1 [] h2 h3 := H1.
      have:=h2 x0{hr}; rewrite H2/= negb_exists/= =>/(_ (size bs0{hr})).
      rewrite size_ge0 H9/=; apply absurd =>/= h.
      by have //=:= H5 _ _ h.
    rnd; auto; progress.
    - smt(size_ge0).
    - smt().
    - by rewrite size_cat/=.
    - by rewrite mem_set; left; rewrite H3. 
    - rewrite get_setE (H4 _ _ H11).
      cut/#: !(l1, j) = (x0{2}, size bs0{2}).
      move:H2; apply absurd=> //=[#] <<- ->>.
      have[] h1 [] h2 h3 := H1.
      by apply h2; smt().
    - move:H11; rewrite mem_set.
      case((l1, j) \in BIRO.IRO.mp{2})=>//= h; 1: smt().
      by move=> [#] <<- ->> //=; rewrite size_ge0; smt().
    - rewrite mem_set.
      case(j = size bs0{2})=>//=.
      move=> h; rewrite h /=; have {H12} H13 {h} : j < size bs0{2} by smt().
      by apply H6. 
    - by rewrite cats1 get_set_sameE oget_some. 
    - rewrite get_set_sameE oget_some H7 rangeSr.
      rewrite !size_map 1:size_ge0. 
      rewrite (size_map _ (range 0 (size bs0{2}))) size_range /=.
      rewrite max_ler 1:size_ge0 map_rcons /=get_set_sameE oget_some; congr.
      apply eq_in_map=> j.
      rewrite mem_range /==> [] [] hj1 hj2.
      by rewrite get_set_neqE //=; smt().
  auto; progress.
  + smt(size_out_gt0).
  + smt().
  + smt(). 
  + by rewrite range_geq.
  smt().
  qed.

  lemma Sponge_preimage_resistant &m ha :
      (DPre.h{m} = ha) =>
      Pr[SRO.Preimage(A, FM(CSetSize(Sponge), Perm)).main(ha) @ &m : res] <=
      (limit ^ 2 - limit)%r / (2 ^ (r + c + 1))%r +
      (4 * limit ^ 2)%r / (2 ^ c)%r +
      (sigma + 1)%r / (2%r ^ size_out).
  proof.
  move=>init_ha.
  rewrite -(doutE1 ha).
  rewrite(preimage_resistant_if_indifferentiable A A_ll (CSetSize(Sponge)) Perm &m ha init_ha).
  exists (SimSetSize(Simulator))=>//=; split.
  + by move=> F _; proc; inline*; auto.
  cut->//:Pr[Indiff0.Indif(CSetSize(Sponge, Perm), Perm, DPre(A)).main() @ &m : res] =
        Pr[RealIndif(Sponge, Perm, DRestr(DSetSize(DPre(A)))).main() @ &m : res].
  + byequiv=>//=; proc. 
    inline DPre(A, CSetSize(Sponge, Perm), Perm).distinguish.
    inline SRO.Preimage(A, FInit(CSetSize(Sponge, Perm))).main.
    inline DRestr(DSetSize(DPre(A)), Sponge(Perm), Perm).distinguish 
          DSetSize(DPre(A), FC(Sponge(Perm)), PC(Perm)).distinguish 
          SRO.Preimage(A, FInit(DFSetSize(FC(Sponge(Perm))))).main.
    inline Perm.init CSetSize(Sponge, Perm).init Sponge(Perm).init 
          FC(Sponge(Perm)).init SRO.Counter.init Cntr.init 
          SRO.Bounder(FInit(CSetSize(Sponge, Perm))).init 
          SRO.Bounder(FInit(DFSetSize(FC(Sponge(Perm))))).init
          FInit(CSetSize(Sponge, Perm)).init 
          FInit(DFSetSize(FC(Sponge(Perm)))).init; sp. 
    wp; sp; sim.
    seq 1 1 : (={m, hash, glob DPre, glob SRO.Counter, glob Perm}
          /\ invm Perm.m{1} Perm.mi{1} /\ DPre.h{1} = ha
          /\ ={c}(SRO.Counter,Cntr)); last first.
    - if; auto; sp.
      exists* m{1}, SRO.Counter.c{1}; elim* => mess c.
      by call(equiv_sponge_perm c mess); auto; smt().
    call(: ={glob SRO.Counter, glob Perm, glob DPre, glob SRO.Bounder}
          /\ DPre.h{1} = ha
          /\ invm Perm.m{1} Perm.mi{1} /\ ={c}(SRO.Counter,Cntr)).
    + proc; sp; if; auto; sp; if; auto; sp.
      exists * x{1}; elim* => m c1 c2 b1 b2.
      by call(equiv_sponge_perm c1 m); auto; smt().
    auto; progress.
    by rewrite /invm=> x y; rewrite 2!emptyE.
  cut->//:Pr[Indiff0.Indif(RO, SimSetSize(Simulator, RO), DPre(A)).main() @ &m : res] =
        Pr[IdealIndif(BIRO.IRO, Simulator, DRestr(DSetSize(DPre(A)))).main() @ &m : res].
  + byequiv=>//=; proc.
    inline Simulator(FGetSize(RO)).init RO.init Simulator(BIRO.IRO).init 
          BIRO.IRO.init Gconcl_list.BIRO2.IRO.init; sp.
    inline DPre(A, RO, Simulator(FGetSize(RO))).distinguish.
    inline DRestr(DSetSize(DPre(A)), BIRO.IRO, Simulator(BIRO.IRO)).distinguish 
          DSetSize(DPre(A), FC(BIRO.IRO), PC(Simulator(BIRO.IRO))).distinguish; wp; sim.
    inline SRO.Bounder(FInit(DFSetSize(FC(BIRO.IRO)))).init 
          SRO.Bounder(FInit(RO)).init SRO.Counter.init FInit(RO).init
          FInit(DFSetSize(FC(BIRO.IRO))).init Cntr.init; sp.
    inline SRO.Preimage(A, FInit(RO)).main 
          SRO.Preimage(A, FInit(DFSetSize(FC(BIRO.IRO)))).main.
    inline SRO.Counter.init SRO.Bounder(FInit(RO)).init 
          SRO.Bounder(FInit(DFSetSize(FC(BIRO.IRO)))).init
          FInit(RO).init FInit(DFSetSize(FC(BIRO.IRO))).init ; sp; sim.
    seq 1 1 : (={m, glob SRO.Counter, glob DPre, hash}
          /\ ={c}(SRO.Counter,Cntr) /\ DPre.h{1} = hash{1}
          /\ same_ro SRO.RO.RO.m{1} BIRO.IRO.mp{2}); last first.
    - if; auto; sp.
      exists * m{1}, SRO.Counter.c{1}; elim* => mess c.
      by call(equiv_ro_iro c mess); auto; smt().
    conseq(:_==> ={m, glob SRO.Counter, glob SRO.Bounder, glob DPre}
          /\ ={c}(SRO.Counter,Cntr)
          /\ same_ro SRO.RO.RO.m{1} BIRO.IRO.mp{2}); progress.
    call(: ={glob SRO.Counter, glob SRO.Bounder, glob DPre}
          /\ ={c}(SRO.Counter,Cntr)
          /\ same_ro SRO.RO.RO.m{1} BIRO.IRO.mp{2}); auto.
    + proc; sp; if; auto; sp; if; auto; sp.
      exists* x{1}; elim* => a c1 c2 b1 b2.
      call(equiv_ro_iro c1 a); auto; smt().
    smt(mem_empty).
  have->//=:= SHA3Indiff (DSetSize(DPre(A))) &m _.
  move=> F P P_f_ll P_fi_ll F_ll; proc; inline*; auto; sp; auto.
  seq 1 : true; auto. 
  + call (A_ll (SRO.Bounder(FInit(DFSetSize(F)))) _); auto.
    by proc; inline*; sp; if; auto; sp; if; auto; sp; call F_ll; auto.
  if; auto; sp.
  by call F_ll; auto.
  qed.

end section Preimage.



section SecondPreimage.

  declare module A : SRO.AdvSecondPreimage{SRO.RO.RO, SRO.RO.FRO, SRO.Bounder, Perm, 
    Gconcl_list.BIRO2.IRO, Simulator, Cntr, BIRO.IRO, F.RO, F.FRO, Redo, C, 
    Gconcl.S, BlockSponge.BIRO.IRO, BlockSponge.C, Gconcl_list.F2.RO,
    Gconcl_list.F2.FRO, Gconcl_list.Simulator, D2Pre}.

  axiom A_ll (F <: SRO.Oracle { A }) : islossless F.get => islossless A(F).guess.

  local lemma invm_dom_rng (m mi : (state, state) fmap) :
      invm m mi => dom m = rng mi.
  proof. 
  move=>h; rewrite fun_ext=> x; rewrite domE rngE /= eq_iff; have h2 := h x; split.
  + move=> m_x_not_None; exists (oget m.[x]); rewrite -h2; move: m_x_not_None.
    by case: (m.[x]).
  by move=> [] a; rewrite -h2 => ->.
  qed.

  local lemma invmC' (m mi : (state, state) fmap) :
      invm m mi => invm mi m.
  proof. by rewrite /#. qed.

  local lemma invmC (m mi : (state, state) fmap) :
      invm m mi <=> invm mi m.
  proof. by split;exact invmC'. qed.

  local lemma useful m mi a :
      invm m mi => ! a \in m => Distr.is_lossless ((bdistr `*` cdistr) \ rng m).
  proof.
  move=>hinvm nin_dom.
  cut prod_ll:Distr.is_lossless (bdistr `*` cdistr).
  + by rewrite dprod_ll DBlock.dunifin_ll DCapacity.dunifin_ll. 
  apply dexcepted_ll=>//=;rewrite-prod_ll.
  cut->:predT = predU (predC (rng m)) (rng m);1:rewrite predCU//=.
  rewrite Distr.mu_disjoint 1:predCI//=StdRing.RField.addrC. 
  cut/=->:=StdOrder.RealOrder.ltr_add2l (mu (bdistr `*` cdistr) (rng m)) 0%r.
  rewrite Distr.witness_support/predC.
  move:nin_dom;apply absurd=>//=;rewrite negb_exists/==>hyp. 
  cut{hyp}hyp:forall x, rng m x by smt(supp_dprod DBlock.supp_dunifin DCapacity.supp_dunifin). 
  move:a. 
  cut:=eqEcard (fdom m) (frng m);rewrite leq_card_rng_dom/=. 
  cut->//=:fdom m \subset frng m. 
  + by move=> x; rewrite mem_fdom mem_frng hyp.
  smt(mem_fdom mem_frng).
  qed.


  local equiv equiv_sponge_perm c m :
      FInit(CSetSize(Sponge, Perm)).get ~ FInit(DFSetSize(FC(Sponge(Perm)))).get :
    ={arg, glob Perm} /\ invm Perm.m{1} Perm.mi{1} /\ 
      Cntr.c{2} = c /\ arg{2} = m /\
      (Cntr.c + ((size arg + 1) %/ Common.r + 1) + 
      max ((size_out + Common.r - 1) %/ Common.r - 1) 0 <= limit){2} ==>
    ={res, glob Perm} /\ invm Perm.m{1} Perm.mi{1} /\ 
      Cntr.c{2} = c + ((size m + 1) %/ Common.r + 1) + 
      max ((size_out + Common.r - 1) %/ Common.r - 1) 0.
  proof.
  proc; inline FC(Sponge(Perm)).f; sp.
  rcondt{2} 1; auto; sp.
  call(: ={glob Perm} /\ invm Perm.m{1} Perm.mi{1})=>/=; auto; inline*.
  while(={i, n, sa, sc, z, glob Perm} /\ invm Perm.m{1} Perm.mi{1}); auto.
  + sp; if; auto; sp; if; auto; progress.
    rewrite invm_set //=.
    by move:H4; rewrite supp_dexcepted.
  sp; conseq(:_==> ={i, n, sa, sc, glob Perm} /\ invm Perm.m{1} Perm.mi{1}); auto.
  while(={xs, sa, sc, glob Perm} /\ invm Perm.m{1} Perm.mi{1}); auto.
  sp; if; auto; progress. 
  rewrite invm_set=>//=.
  by move:H4; rewrite supp_dexcepted.
  qed.


  clone import Program as Prog2 with
    type t <- bool,
    op d <- dbool
    proof *.

  local equiv equiv_ro_iro c m :
    FInit(RO).get ~ FInit(DFSetSize(FC(BIRO.IRO))).get :
    ={arg} /\ same_ro SRO.RO.RO.m{1} BIRO.IRO.mp{2} /\
    arg{2} = m /\ Cntr.c{2} = c /\
    (Cntr.c + ((size arg + 1) %/ Common.r + 1) + 
      max ((size_out + Common.r - 1) %/ Common.r - 1) 0 <= limit){2}
    ==> ={res} /\ same_ro SRO.RO.RO.m{1} BIRO.IRO.mp{2} /\ 
      Cntr.c{2} = c + ((size m + 1) %/ Common.r + 1) + 
      max ((size_out + Common.r - 1) %/ Common.r - 1) 0.
  proof.
  proc; inline *; sp; rcondt{2} 1; 1: auto.
  swap{2} 1 5; sp; wp 2 1.
  conseq(:_==> oget SRO.RO.RO.m{1}.[x{1}] = oget (of_list bs0{2}) /\
    same_ro SRO.RO.RO.m{1} BIRO.IRO.mp{2}); 1:by auto.
  rcondt{2} 1; 1: auto.
  case: (x{1} \in SRO.RO.RO.m{1}).
  + rcondf{1} 2; auto.
    exists* BIRO.IRO.mp{2}; elim* => mp.
    while{2}(bs0{2} = map (fun j => oget BIRO.IRO.mp{2}.[(x0{2},j)]) (range 0 i{2})
        /\ n0{2} = size_out /\ x0{2} \in SRO.RO.RO.m{1} /\ 0 <= i{2} <= size_out
        /\ same_ro SRO.RO.RO.m{1} BIRO.IRO.mp{2} /\ BIRO.IRO.mp{2} = mp)
      (size_out - i{2}); auto.
    - sp; rcondf 1; auto; 1: smt().
      progress. 
      * have/=<-:= map_rcons (fun (j : int) => oget BIRO.IRO.mp{hr}.[(x0{hr}, j)]) (range 0 i{hr}) i{hr}.
        by rewrite !rangeSr //=.
      * smt().
      * smt().
      * smt().
    progress. 
    - by rewrite range_geq.
    - smt(size_out_gt0).
    - smt().
    - exact(dout_ll).
    - have[] h[#] h1 h2 := H.
      cut->:i_R = size_out by smt().
      cut<-:=h2 _ H3.
      smt(to_listK).
  rcondt{1} 2; 1: auto; wp =>/=.
  exists* BIRO.IRO.mp{2}; elim* => mp.
  conseq(:_==> 
        same_ro SRO.RO.RO.m{1} mp /\ i{2} = size_out /\
        (forall (l,j),  (l,j) \in mp => (l,j) \in BIRO.IRO.mp{2}) /\
        (forall (l,j),  (l,j) \in mp => BIRO.IRO.mp{2}.[(l,j)] = mp.[(l,j)]) /\
        (forall (l,j), (l,j) \in BIRO.IRO.mp{2} => (l,j) \in mp \/ (l = x0{2} /\ 0 <= j < i{2})) /\
        (forall j, 0 <= j < i{2} => (x0{2},j) \in BIRO.IRO.mp{2}) /\
        take i{2} (to_list r{1}) = bs0{2} /\
        take i{2} (to_list r{1}) = map (fun (j : int) => oget BIRO.IRO.mp{2}.[(x0{2}, j)]) (range 0 i{2})); progress=>//=.
  + by rewrite get_set_sameE /=; smt(to_listK take_oversize spec_dout).
  + move:H8; rewrite mem_set=>[][]//=h; 1:rewrite H3=>//=.
    - by have []h1 []h2 h3:= H2; have->//:=h1 _ h.
    by move:h => <<-; rewrite H6 //=.
  + rewrite mem_set//=; have[]//=h:= H5 _ _ H11; left.
    have []h1 []->//=:= H2.
    by exists i0=>//=.
  + move:H7; rewrite take_oversize 1:spec_dout//= => H7.
    move:H10; rewrite mem_set. 
    case(m \in SRO.RO.RO.m{1})=>//=h.
    - rewrite get_set_neqE; 1:smt().
      have []h1 []h2 ->//=:= H2. 
      by apply eq_in_map=> j;rewrite mem_range=>[][]hj1 hj2/=; rewrite H4//=h1//=.
    by move=><<-; rewrite get_set_eqE//=.
  alias{1} 1 l = [<:bool>].
  transitivity{1} {
      l <@ Sample.sample(size_out);
      r <- oget (of_list l);
    }
    (={glob SRO.RO.RO, x} ==> ={glob SRO.RO.RO, r})
    (x{1} = x0{2} /\ i{2} = 0 /\ n0{2} = size_out /\ mp = BIRO.IRO.mp{2} /\
      same_ro SRO.RO.RO.m{1} BIRO.IRO.mp{2} /\ x{1} \notin SRO.RO.RO.m{1} /\
      bs0{2} = []
      ==>
      same_ro SRO.RO.RO.m{1} mp /\ i{2} = size_out /\
      (forall (l,j),  (l,j) \in mp => (l,j) \in BIRO.IRO.mp{2}) /\
      (forall (l,j),  (l,j) \in mp => BIRO.IRO.mp{2}.[(l,j)] = mp.[(l,j)]) /\
      (forall (l,j), (l,j) \in BIRO.IRO.mp{2} => (l,j) \in mp \/ (l = x0{2} /\ 0 <= j < i{2})) /\
      (forall j, 0 <= j < i{2} => (x0{2},j) \in BIRO.IRO.mp{2}) /\
      take i{2} (to_list r{1}) = bs0{2} /\
      take i{2} (to_list r{1}) = 
        map (fun (j : int) => oget BIRO.IRO.mp{2}.[(x0{2}, j)]) (range 0 i{2})); 
    progress.
  + smt().
  + inline*; sp; wp. 
    rnd to_list (fun x => oget (of_list x)); auto; progress. 
    - smt(spec_dout supp_dlist to_listK spec2_dout size_out_gt0).
    - rewrite -dout_equal_dlist dmap1E; apply mu_eq=> x/=. 
      smt(to_listK).
    - rewrite-dout_equal_dlist supp_dmap; smt(dout_full).
    smt(to_listK).
  wp=>/=.
  conseq(:_==> i{2} = size_out /\ size l{1} = size_out /\
      (forall (l0 : bool list) (j : int),
        (l0, j) \in mp => (l0, j) \in BIRO.IRO.mp{2}) /\
      (forall (l0 : bool list) (j : int),
        (l0, j) \in mp => BIRO.IRO.mp{2}.[(l0, j)] = mp.[(l0, j)]) /\
      (forall (l0 : bool list) (j : int),
        (l0, j) \in BIRO.IRO.mp{2} => ((l0, j) \in mp) \/ (l0 = x0{2} /\ 0 <= j < i{2})) /\
      (forall (j : int), 0 <= j < i{2} => (x0{2}, j) \in BIRO.IRO.mp{2}) /\
      take i{2} l{1} = bs0{2} /\
      take i{2} l{1} =
        map (fun (j : int) => oget BIRO.IRO.mp{2}.[(x0{2}, j)]) (range 0 i{2}));
    progress.
  + have[]//=h h1:=to_listK (oget (of_list l_L)) l_L; rewrite h1//==> {h1 h}.
    smt(spec2_dout).
  + have[]//=h h1:=to_listK (oget (of_list l_L)) l_L; rewrite h1//==> {h1 h}.
    smt(spec2_dout).
  transitivity{1} {
      l <@ LoopSnoc.sample(size_out);
    }
    (={glob SRO.RO.RO} ==> ={glob SRO.RO.RO, l})
    (x{1} = x0{2} /\ i{2} = 0 /\ n0{2} = size_out /\ mp = BIRO.IRO.mp{2} /\
      same_ro SRO.RO.RO.m{1} BIRO.IRO.mp{2} /\ x0{2} \notin SRO.RO.RO.m{1} /\
      bs0{2} = []
      ==>
      i{2} = size_out /\ size l{1} = size_out /\
      (forall (l,j),  (l,j) \in mp => (l,j) \in BIRO.IRO.mp{2}) /\
      (forall (l,j),  (l,j) \in mp => BIRO.IRO.mp{2}.[(l,j)] = mp.[(l,j)]) /\
      (forall (l,j), (l,j) \in BIRO.IRO.mp{2} => (l,j) \in mp \/ (l = x0{2} /\ 0 <= j < i{2})) /\
      (forall j, 0 <= j < i{2} => (x0{2},j) \in BIRO.IRO.mp{2}) /\
      take i{2} l{1} = bs0{2} /\
      take i{2} l{1} = 
        map (fun (j : int) => oget BIRO.IRO.mp{2}.[(x0{2}, j)]) (range 0 i{2})); 
    progress.
  + smt(). 
  + by call Sample_LoopSnoc_eq; auto.
  inline*; sp; wp.
  conseq(:_==> i{2} = size_out /\ size l0{1} = i{2} /\ 
      same_ro SRO.RO.RO.m{1} mp /\ x0{2} \notin SRO.RO.RO.m{1} /\
      (forall l j, (l,j) \in mp => (l,j) \in BIRO.IRO.mp{2}) /\
      (forall l j, (l,j) \in mp => BIRO.IRO.mp{2}.[(l, j)] = mp.[(l, j)]) /\
      (forall l j, (l, j) \in BIRO.IRO.mp{2} => ((l, j) \in mp) \/ (l = x0{2} /\ 0 <= j < i{2})) /\
      (forall j, 0 <= j < i{2} => (x0{2}, j) \in BIRO.IRO.mp{2}) /\
      l0{1} = bs0{2} /\ bs0{2} = 
        map (fun (j : int) => oget BIRO.IRO.mp{2}.[(x0{2}, j)]) (range 0 i{2})); progress.
  + smt(take_oversize).
  + smt(take_oversize).
  while(0 <= i{2} <= size_out /\ size l0{1} = i{2} /\ n0{2} = size_out /\
      ={i} /\ n{1} = n0{2} /\
      same_ro SRO.RO.RO.m{1} mp /\ x0{2} \notin SRO.RO.RO.m{1} /\
      (forall l j, (l,j) \in mp => (l,j) \in BIRO.IRO.mp{2}) /\
      (forall l j, (l,j) \in mp => BIRO.IRO.mp{2}.[(l, j)] = mp.[(l, j)]) /\
      (forall l j, (l, j) \in BIRO.IRO.mp{2} => ((l, j) \in mp) \/ (l = x0{2} /\ 0 <= j < i{2})) /\
      (forall j, 0 <= j < i{2} => (x0{2}, j) \in BIRO.IRO.mp{2}) /\
      l0{1} = bs0{2} /\ bs0{2} = 
        map (fun (j : int) => oget BIRO.IRO.mp{2}.[(x0{2}, j)]) (range 0 i{2})).
  + sp; wp=> //=.
    rcondt{2} 1; 1:auto; progress.
    - have[]h1 [] h2 h3 := H1.
      have:=h2 x0{hr}; rewrite H2/= negb_exists/= =>/(_ (size bs0{hr})).
      rewrite size_ge0 H9/=; apply absurd =>/= h.
      by have //=:= H5 _ _ h.
    rnd; auto; progress.
    - smt(size_ge0).
    - smt().
    - by rewrite size_cat/=.
    - by rewrite mem_set; left; rewrite H3. 
    - rewrite get_setE (H4 _ _ H11).
      cut/#: !(l1, j) = (x0{2}, size bs0{2}).
      move:H2; apply absurd=> //=[#] <<- ->>.
      have[] h1 [] h2 h3 := H1.
      by apply h2; smt().
    - move:H11; rewrite mem_set.
      case((l1, j) \in BIRO.IRO.mp{2})=>//= h; 1: smt().
      by move=> [#] <<- ->> //=; rewrite size_ge0; smt().
    - rewrite mem_set.
      case(j = size bs0{2})=>//=.
      move=> h; rewrite h /=; have {H12} H12 {h} : j < size bs0{2} by smt().
      by apply H6. 
    - by rewrite cats1 get_set_sameE oget_some. 
    - rewrite get_set_sameE oget_some H7 rangeSr.
      rewrite !size_map 1:size_ge0. 
      rewrite (size_map _ (range 0 (size bs0{2}))) size_range /=.
      rewrite max_ler 1:size_ge0 map_rcons /=get_set_sameE oget_some; congr.
      apply eq_in_map=> j.
      rewrite mem_range /==> [] [] hj1 hj2.
      by rewrite get_set_neqE //=; smt().
  auto; progress.
  + smt(size_out_gt0).
  + smt().
  + smt(). 
  + by rewrite range_geq.
  smt().
  qed.

  lemma Sponge_second_preimage_resistant &m mess :
      (D2Pre.m2{m} = mess) =>
      Pr[SRO.SecondPreimage(A, FM(CSetSize(Sponge), Perm)).main(mess) @ &m : res] <=
      (limit ^ 2 - limit)%r / (2 ^ (r + c + 1))%r +
      (4 * limit ^ 2)%r / (2 ^ c)%r +
      (sigma + 1)%r / (2%r ^ size_out).
  proof.  
  move=> init_mess.
  rewrite -(doutE1 witness).
  rewrite(second_preimage_resistant_if_indifferentiable A A_ll (CSetSize(Sponge)) Perm &m mess init_mess).
  exists (SimSetSize(Simulator)); split.
  + by move=> F _; proc; inline*; auto.
  cut->:Pr[Indiff0.Indif(CSetSize(Sponge, Perm), Perm, D2Pre(A)).main() @ &m : res] =
        Pr[RealIndif(Sponge, Perm, DRestr(DSetSize(D2Pre(A)))).main() @ &m : res].
  + byequiv=>//=; proc. 
    inline Perm.init CSetSize(Sponge, Perm).init Sponge(Perm).init 
          FC(Sponge(Perm)).init; sp.
    inline D2Pre(A, CSetSize(Sponge, Perm), Perm).distinguish.
    inline DRestr(DSetSize(D2Pre(A)), Sponge(Perm), Perm).distinguish 
          DSetSize(D2Pre(A), FC(Sponge(Perm)), PC(Perm)).distinguish Cntr.init.
    inline SRO.SecondPreimage(A, FInit(CSetSize(Sponge, Perm))).main
        SRO.SecondPreimage(A, FInit(DFSetSize(FC(Sponge(Perm))))).main.
    inline SRO.Bounder(FInit(CSetSize(Sponge, Perm))).init
          SRO.Bounder(FInit(DFSetSize(FC(Sponge(Perm))))).init 
          SRO.Counter.init FInit(DFSetSize(FC(Sponge(Perm)))).init
          FInit(CSetSize(Sponge, Perm)).init.
    wp; sp; sim. 
    seq 1 1 : (={m1, m2, glob SRO.Counter, glob Perm}
          /\ invm Perm.m{1} Perm.mi{1}
          /\ ={c}(SRO.Counter,Cntr)); last first.
    - if; auto; sp.
      case(SRO.Counter.c{1} + ((size m2{1} + 1) %/ r + 1) + 
          max ((size_out + r - 1) %/ r - 1) 0 < limit); last first.
      * rcondf{1} 2; 1: by auto; inline*; auto; conseq(: _ ==> true); auto.
        rcondf{2} 2; 1: by auto; inline*; auto; conseq(: _ ==> true); auto.
        auto; inline*; auto; sp; conseq(: _ ==> true); auto.
        if{2}; sp; auto; sim.
        while{1}(invm Perm.m{1} Perm.mi{1}) (((size_out + r - 1) %/ r)-i{1}).
        + auto; sp; if; auto. 
          - sp; if ;auto; progress.
            * exact (useful _ _ _ H H2).
            * rewrite invm_set=>//=. 
              by move:H4; rewrite  supp_dexcepted.
            * smt().
            smt().
          smt().
        conseq(:_==> invm Perm.m{1} Perm.mi{1}); 1:smt().
        while{1}(invm Perm.m{1} Perm.mi{1})(size xs{1}).
        + move=> _ z; auto; sp; if; auto; progress.
          * exact (useful _ _ _ H H1).
          * rewrite invm_set=>//=.
            by move:H3; rewrite supp_dexcepted.
          * smt().
          smt().
        auto; smt(size_ge0 size_eq0).
      rcondt{1} 2; first by auto; inline*; auto; conseq(:_==> true); auto.
      rcondt{2} 2; first by auto; inline*; auto; conseq(:_==> true); auto.
      sim.
      exists* m1{1}, m2{1}; elim* => a1 a2 c1 c2.
      call (equiv_sponge_perm (c2 + ((size a1 + 1) %/ r + 1) + max ((size_out + r - 1) %/ r - 1) 0) a2).
      auto; call (equiv_sponge_perm c2 a1); auto; progress. 
      smt(List.size_ge0 divz_ge0 gt0_r).
      smt(List.size_ge0 divz_ge0 gt0_r).
    call(: ={glob SRO.Counter, glob Perm, glob SRO.Bounder}
          /\ invm Perm.m{1} Perm.mi{1} /\ ={c}(SRO.Counter,Cntr)).
    + proc; sp; if; auto; sp; if; auto; sp.
      exists * x{1}; elim* => m c1 c2 b1 b2.
      by call(equiv_sponge_perm c1 m); auto; smt().
    inline*; auto; progress.
    by rewrite /invm=> x y; rewrite 2!emptyE.
  cut->:Pr[Indiff0.Indif(RO, SimSetSize(Simulator, RO), D2Pre(A)).main() @ &m : res] =
        Pr[IdealIndif(BIRO.IRO, Simulator, DRestr(DSetSize(D2Pre(A)))).main() @ &m : res].
  + byequiv=>//=; proc.
    inline Simulator(FGetSize(RO)).init RO.init Simulator(BIRO.IRO).init 
          BIRO.IRO.init Gconcl_list.BIRO2.IRO.init; sp.
    inline D2Pre(A, RO, Simulator(FGetSize(RO))).distinguish.
    inline DRestr(DSetSize(D2Pre(A)), BIRO.IRO, Simulator(BIRO.IRO)).distinguish 
          DSetSize(D2Pre(A), FC(BIRO.IRO), PC(Simulator(BIRO.IRO))).distinguish; wp; sim.
    inline SRO.Bounder(FInit(DFSetSize(FC(BIRO.IRO)))).init 
          SRO.Bounder(FInit(RO)).init SRO.Counter.init FInit(RO).init
          FInit(DFSetSize(FC(BIRO.IRO))).init Cntr.init; sp.
    inline SRO.SecondPreimage(A, FInit(RO)).main 
          SRO.SecondPreimage(A, FInit(DFSetSize(FC(BIRO.IRO)))).main.
    inline SRO.Bounder(FInit(RO)).init 
          SRO.Bounder(FInit(DFSetSize(FC(BIRO.IRO)))).init SRO.Counter.init
          FInit(RO).init FInit(DFSetSize(FC(BIRO.IRO))).init.
    sp; sim.
    seq 1 1 : (={m1, m2, glob SRO.Counter}
          /\ ={c}(SRO.Counter,Cntr)
          /\ same_ro SRO.RO.RO.m{1} BIRO.IRO.mp{2}); last first.
    - if; auto; sp.
      case: (SRO.Counter.c{1} + ((size m2{1} + 1) %/ r + 1) + 
          max ((size_out + r - 1) %/ r - 1) 0 < limit); last first. 
      * rcondf{1} 2; first by auto; inline*; auto.
        rcondf{2} 2; first auto; inline*; auto; sp.
        + rcondt 1; first by auto; smt().
          by sp; rcondt 1; auto; conseq(:_==> true); auto.
        inline*;sp; auto.
        rcondt{2} 1; first by auto; smt().
        conseq(:_==> true); first smt(dout_ll).
        sp; rcondt{2} 1; auto; conseq(:_==> true); auto.
        by while{2}(true)(n0{2}-i{2}); auto; 1:(sp; if; auto); smt(dbool_ll).
      rcondt{1} 2; first by auto; inline*; auto.
      rcondt{2} 2; first auto; inline*; auto; sp.
      + rcondt 1; first by auto; smt().
        by sp; rcondt 1; auto; conseq(:_==> true); auto.
      sim.
      exists* m1{1}, m2{1}; elim*=> a1 a2 c1 c2.
      call(equiv_ro_iro (c2 + ((size a1 + 1) %/ r + 1) + 
          max ((size_out + r - 1) %/ r - 1) 0) a2).
      auto; call(equiv_ro_iro c2 a1); auto; smt().
    call(: ={glob SRO.Counter, glob SRO.Bounder} /\ ={c}(SRO.Counter,Cntr)
          /\ same_ro SRO.RO.RO.m{1} BIRO.IRO.mp{2}); auto.
    + proc; sp; if; auto; sp; if; auto; sp.
      exists* x{1}; elim* => a c1 c2 b1 b2.
      call(equiv_ro_iro c1 a); auto; smt().
    smt(mem_empty). 
  have->//=:= SHA3Indiff (DSetSize(D2Pre(A))) &m _.
  move=> F P P_f_ll P_fi_ll F_ll; proc; inline*; auto; sp.
  seq 1 : true; auto.
  + call (A_ll (SRO.Bounder(FInit(DFSetSize(F)))) _); auto.
    by proc; inline*; sp; if; auto; sp; if; auto; sp; call F_ll; auto.
  if; auto; sp.
  seq 1 : true; auto.
  + by call F_ll; auto.
  sp; if; auto; sp; call F_ll; auto.
  qed.

end section SecondPreimage.



section Collision.

  declare module A : SRO.AdvCollision{SRO.RO.RO, SRO.RO.FRO, SRO.Bounder, Perm, 
    Gconcl_list.BIRO2.IRO, Simulator, Cntr, BIRO.IRO, F.RO, F.FRO, Redo, C, 
    Gconcl.S, BlockSponge.BIRO.IRO, BlockSponge.C, Gconcl_list.F2.RO,
    Gconcl_list.F2.FRO, Gconcl_list.Simulator}.

  axiom A_ll (F <: SRO.Oracle { A }) : islossless F.get => islossless A(F).guess.

  local lemma invm_dom_rng (m mi : (state, state) fmap) :
      invm m mi => dom m = rng mi.
  proof. 
  move=>h; rewrite fun_ext=> x; rewrite domE rngE /= eq_iff; have h2 := h x; split.
  + move=> m_x_not_None; exists (oget m.[x]); rewrite -h2; move: m_x_not_None.
    by case: (m.[x]).
  by move=> [] a; rewrite -h2 => ->.
  qed.

  local lemma invmC' (m mi : (state, state) fmap) :
      invm m mi => invm mi m.
  proof. by rewrite /#. qed.

  local lemma invmC (m mi : (state, state) fmap) :
      invm m mi <=> invm mi m.
  proof. by split;exact invmC'. qed.

  local lemma useful m mi a :
      invm m mi => ! a \in m => Distr.is_lossless ((bdistr `*` cdistr) \ rng m).
  proof.
  move=>hinvm nin_dom.
  cut prod_ll:Distr.is_lossless (bdistr `*` cdistr).
  + by rewrite dprod_ll DBlock.dunifin_ll DCapacity.dunifin_ll. 
  apply dexcepted_ll=>//=;rewrite-prod_ll.
  cut->:predT = predU (predC (rng m)) (rng m);1:rewrite predCU//=.
  rewrite Distr.mu_disjoint 1:predCI//=StdRing.RField.addrC. 
  cut/=->:=StdOrder.RealOrder.ltr_add2l (mu (bdistr `*` cdistr) (rng m)) 0%r.
  rewrite Distr.witness_support/predC.
  move:nin_dom;apply absurd=>//=;rewrite negb_exists/==>hyp. 
  cut{hyp}hyp:forall x, rng m x by smt(supp_dprod DBlock.supp_dunifin DCapacity.supp_dunifin). 
  move:a. 
  cut:=eqEcard (fdom m) (frng m);rewrite leq_card_rng_dom/=. 
  cut->//=:fdom m \subset frng m. 
  + by move=> x; rewrite mem_fdom mem_frng hyp.
  smt(mem_fdom mem_frng).
  qed.


  local equiv equiv_sponge_perm c m :
      FInit(CSetSize(Sponge, Perm)).get ~ FInit(DFSetSize(FC(Sponge(Perm)))).get :
    ={arg, glob Perm} /\ invm Perm.m{1} Perm.mi{1} /\ 
      Cntr.c{2} = c /\ arg{2} = m /\
      (Cntr.c + ((size arg + 1) %/ Common.r + 1) + 
      max ((size_out + Common.r - 1) %/ Common.r - 1) 0 <= limit){2} ==>
    ={res, glob Perm} /\ invm Perm.m{1} Perm.mi{1} /\ 
      Cntr.c{2} = c + ((size m + 1) %/ Common.r + 1) + 
      max ((size_out + Common.r - 1) %/ Common.r - 1) 0.
  proof.
  proc; inline FC(Sponge(Perm)).f; sp.
  rcondt{2} 1; auto; sp.
  call(: ={glob Perm} /\ invm Perm.m{1} Perm.mi{1})=>/=; auto; inline*.
  while(={i, n, sa, sc, z, glob Perm} /\ invm Perm.m{1} Perm.mi{1}); auto.
  + sp; if; auto; sp; if; auto; progress.
    rewrite invm_set //=.
    by move:H4; rewrite supp_dexcepted.
  sp; conseq(:_==> ={i, n, sa, sc, glob Perm} /\ invm Perm.m{1} Perm.mi{1}); auto.
  while(={xs, sa, sc, glob Perm} /\ invm Perm.m{1} Perm.mi{1}); auto.
  sp; if; auto; progress. 
  rewrite invm_set=>//=.
  by move:H4; rewrite supp_dexcepted.
  qed.

  clone import Program as Prog3 with
    type t <- bool,
    op d <- dbool
    proof *.

  local equiv equiv_ro_iro c m :
    FInit(RO).get ~ FInit(DFSetSize(FC(BIRO.IRO))).get :
    ={arg} /\ same_ro SRO.RO.RO.m{1} BIRO.IRO.mp{2} /\
    arg{2} = m /\ Cntr.c{2} = c /\
    (Cntr.c + ((size arg + 1) %/ Common.r + 1) + 
      max ((size_out + Common.r - 1) %/ Common.r - 1) 0 <= limit){2}
    ==> ={res} /\ same_ro SRO.RO.RO.m{1} BIRO.IRO.mp{2} /\ 
      Cntr.c{2} = c + ((size m + 1) %/ Common.r + 1) + 
      max ((size_out + Common.r - 1) %/ Common.r - 1) 0.
  proof.
  proc; inline *; sp; rcondt{2} 1; 1: auto.
  swap{2} 1 5; sp; wp 2 1.
  conseq(:_==> oget SRO.RO.RO.m{1}.[x{1}] = oget (of_list bs0{2}) /\
    same_ro SRO.RO.RO.m{1} BIRO.IRO.mp{2}); 1:by auto.
  rcondt{2} 1; 1: auto.
  case: (x{1} \in SRO.RO.RO.m{1}).
  + rcondf{1} 2; auto.
    exists* BIRO.IRO.mp{2}; elim* => mp.
    while{2}(bs0{2} = map (fun j => oget BIRO.IRO.mp{2}.[(x0{2},j)]) (range 0 i{2})
        /\ n0{2} = size_out /\ x0{2} \in SRO.RO.RO.m{1} /\ 0 <= i{2} <= size_out
        /\ same_ro SRO.RO.RO.m{1} BIRO.IRO.mp{2} /\ BIRO.IRO.mp{2} = mp)
      (size_out - i{2}); auto.
    - sp; rcondf 1; auto; 1: smt().
      progress. 
      * have/=<-:= map_rcons (fun (j : int) => oget BIRO.IRO.mp{hr}.[(x0{hr}, j)]) (range 0 i{hr}) i{hr}.
        by rewrite !rangeSr //=.
      * smt().
      * smt().
      * smt().
    progress. 
    - by rewrite range_geq.
    - smt(size_out_gt0).
    - smt().
    - exact(dout_ll).
    - have[] h[#] h1 h2 := H.
      cut->:i_R = size_out by smt().
      cut<-:=h2 _ H3.
      smt(to_listK).
  rcondt{1} 2; 1: auto; wp =>/=.
  exists* BIRO.IRO.mp{2}; elim* => mp.
  conseq(:_==> 
        same_ro SRO.RO.RO.m{1} mp /\ i{2} = size_out /\
        (forall (l,j),  (l,j) \in mp => (l,j) \in BIRO.IRO.mp{2}) /\
        (forall (l,j),  (l,j) \in mp => BIRO.IRO.mp{2}.[(l,j)] = mp.[(l,j)]) /\
        (forall (l,j), (l,j) \in BIRO.IRO.mp{2} => (l,j) \in mp \/ (l = x0{2} /\ 0 <= j < i{2})) /\
        (forall j, 0 <= j < i{2} => (x0{2},j) \in BIRO.IRO.mp{2}) /\
        take i{2} (to_list r{1}) = bs0{2} /\
        take i{2} (to_list r{1}) = map (fun (j : int) => oget BIRO.IRO.mp{2}.[(x0{2}, j)]) (range 0 i{2})); progress=>//=.
  + by rewrite get_set_sameE /=; smt(to_listK take_oversize spec_dout).
  + move:H8; rewrite mem_set=>[][]//=h; 1:rewrite H3=>//=.
    - by have []h1 []h2 h3:= H2; have->//:=h1 _ h.
    by move:h => <<-; rewrite H6 //=.
  + rewrite mem_set //=; have [] //= h:= H5 _ _ H11; left.
    have []h1 []->//=:= H2.
    by exists i0=>//=.
  + move:H7; rewrite take_oversize 1:spec_dout//= => H7.
    move:H10; rewrite mem_set. 
    case(m \in SRO.RO.RO.m{1})=>//=h.
    - rewrite get_set_neqE; 1:smt().
      have []h1 []h2 ->//=:= H2. 
      by apply eq_in_map=> j;rewrite mem_range=>[][]hj1 hj2/=; rewrite H4//=h1//=.
    by move=><<-; rewrite get_set_eqE//=.
  alias{1} 1 l = [<:bool>].
  transitivity{1} {
      l <@ Sample.sample(size_out);
      r <- oget (of_list l);
    }
    (={glob SRO.RO.RO, x} ==> ={glob SRO.RO.RO, r})
    (x{1} = x0{2} /\ i{2} = 0 /\ n0{2} = size_out /\ mp = BIRO.IRO.mp{2} /\
      same_ro SRO.RO.RO.m{1} BIRO.IRO.mp{2} /\ x{1} \notin SRO.RO.RO.m{1} /\
      bs0{2} = []
      ==>
      same_ro SRO.RO.RO.m{1} mp /\ i{2} = size_out /\
      (forall (l,j),  (l,j) \in mp => (l,j) \in BIRO.IRO.mp{2}) /\
      (forall (l,j),  (l,j) \in mp => BIRO.IRO.mp{2}.[(l,j)] = mp.[(l,j)]) /\
      (forall (l,j), (l,j) \in BIRO.IRO.mp{2} => (l,j) \in mp \/ (l = x0{2} /\ 0 <= j < i{2})) /\
      (forall j, 0 <= j < i{2} => (x0{2},j) \in BIRO.IRO.mp{2}) /\
      take i{2} (to_list r{1}) = bs0{2} /\
      take i{2} (to_list r{1}) = 
        map (fun (j : int) => oget BIRO.IRO.mp{2}.[(x0{2}, j)]) (range 0 i{2})); 
    progress.
  + smt().
  + inline*; sp; wp. 
    rnd to_list (fun x => oget (of_list x)); auto; progress. 
    - smt(spec_dout supp_dlist to_listK spec2_dout size_out_gt0). 
    - rewrite -dout_equal_dlist dmap1E; apply mu_eq=> x/=. 
      smt(to_listK).
    - rewrite-dout_equal_dlist supp_dmap; smt(dout_full).
    smt(to_listK).
  wp=>/=.
  conseq(:_==> i{2} = size_out /\ size l{1} = size_out /\
      (forall (l0 : bool list) (j : int),
        (l0, j) \in mp => (l0, j) \in BIRO.IRO.mp{2}) /\
      (forall (l0 : bool list) (j : int),
        (l0, j) \in mp => BIRO.IRO.mp{2}.[(l0, j)] = mp.[(l0, j)]) /\
      (forall (l0 : bool list) (j : int),
        (l0, j) \in BIRO.IRO.mp{2} => ((l0, j) \in mp) \/ (l0 = x0{2} /\ 0 <= j < i{2})) /\
      (forall (j : int), 0 <= j < i{2} => (x0{2}, j) \in BIRO.IRO.mp{2}) /\
      take i{2} l{1} = bs0{2} /\
      take i{2} l{1} =
        map (fun (j : int) => oget BIRO.IRO.mp{2}.[(x0{2}, j)]) (range 0 i{2}));
    progress.
  + have[]//=h h1:=to_listK (oget (of_list l_L)) l_L; rewrite h1//==> {h1 h}.
    smt(spec2_dout).
  + have[]//=h h1:=to_listK (oget (of_list l_L)) l_L; rewrite h1//==> {h1 h}.
    smt(spec2_dout). 
  transitivity{1} {
      l <@ LoopSnoc.sample(size_out);
    }
    (={glob SRO.RO.RO} ==> ={glob SRO.RO.RO, l})
    (x{1} = x0{2} /\ i{2} = 0 /\ n0{2} = size_out /\ mp = BIRO.IRO.mp{2} /\
      same_ro SRO.RO.RO.m{1} BIRO.IRO.mp{2} /\ x0{2} \notin SRO.RO.RO.m{1} /\
      bs0{2} = []
      ==>
      i{2} = size_out /\ size l{1} = size_out /\
      (forall (l,j),  (l,j) \in mp => (l,j) \in BIRO.IRO.mp{2}) /\
      (forall (l,j),  (l,j) \in mp => BIRO.IRO.mp{2}.[(l,j)] = mp.[(l,j)]) /\
      (forall (l,j), (l,j) \in BIRO.IRO.mp{2} => (l,j) \in mp \/ (l = x0{2} /\ 0 <= j < i{2})) /\
      (forall j, 0 <= j < i{2} => (x0{2},j) \in BIRO.IRO.mp{2}) /\
      take i{2} l{1} = bs0{2} /\
      take i{2} l{1} = 
        map (fun (j : int) => oget BIRO.IRO.mp{2}.[(x0{2}, j)]) (range 0 i{2})); 
    progress.
  + smt(). 
  + by call Sample_LoopSnoc_eq; auto.
  inline*; sp; wp.
  conseq(:_==> i{2} = size_out /\ size l0{1} = i{2} /\ 
      same_ro SRO.RO.RO.m{1} mp /\ x0{2} \notin SRO.RO.RO.m{1} /\
      (forall l j, (l,j) \in mp => (l,j) \in BIRO.IRO.mp{2}) /\
      (forall l j, (l,j) \in mp => BIRO.IRO.mp{2}.[(l, j)] = mp.[(l, j)]) /\
      (forall l j, (l, j) \in BIRO.IRO.mp{2} => ((l, j) \in mp) \/ (l = x0{2} /\ 0 <= j < i{2})) /\
      (forall j, 0 <= j < i{2} => (x0{2}, j) \in BIRO.IRO.mp{2}) /\
      l0{1} = bs0{2} /\ bs0{2} = 
        map (fun (j : int) => oget BIRO.IRO.mp{2}.[(x0{2}, j)]) (range 0 i{2})); progress.
  + smt(take_oversize).
  + smt(take_oversize).
  while(0 <= i{2} <= size_out /\ size l0{1} = i{2} /\ n0{2} = size_out /\
      ={i} /\ n{1} = n0{2} /\
      same_ro SRO.RO.RO.m{1} mp /\ x0{2} \notin SRO.RO.RO.m{1} /\
      (forall l j, (l,j) \in mp => (l,j) \in BIRO.IRO.mp{2}) /\
      (forall l j, (l,j) \in mp => BIRO.IRO.mp{2}.[(l, j)] = mp.[(l, j)]) /\
      (forall l j, (l, j) \in BIRO.IRO.mp{2} => ((l, j) \in mp) \/ (l = x0{2} /\ 0 <= j < i{2})) /\
      (forall j, 0 <= j < i{2} => (x0{2}, j) \in BIRO.IRO.mp{2}) /\
      l0{1} = bs0{2} /\ bs0{2} = 
        map (fun (j : int) => oget BIRO.IRO.mp{2}.[(x0{2}, j)]) (range 0 i{2})).
  + sp; wp=> //=.
    rcondt{2} 1; 1:auto; progress.
    - have[]h1 [] h2 h3 := H1.
      have:=h2 x0{hr}; rewrite H2/= negb_exists/= =>/(_ (size bs0{hr})).
      rewrite size_ge0 H9/=; apply absurd =>/= h.
      by have //=:= H5 _ _ h.
    rnd; auto; progress.
    - smt(size_ge0).
    - smt().
    - by rewrite size_cat/=.
    - by rewrite mem_set; left; rewrite H3. 
    - rewrite get_setE (H4 _ _ H11).
      cut/#: !(l1, j) = (x0{2}, size bs0{2}).
      move:H2; apply absurd=> //=[#] <<- ->>.
      have[] h1 [] h2 h3 := H1.
      by apply h2; smt().
    - move:H11; rewrite mem_set.
      case((l1, j) \in BIRO.IRO.mp{2})=>//= h; 1: smt().
      by move=> [#] <<- ->> //=; rewrite size_ge0; smt().
    - rewrite mem_set.
      case(j = size bs0{2})=>//=.
      move=> h; rewrite h /=; have {H12} H12 {h} : j < size bs0{2} by smt().
      by apply H6. 
    - by rewrite cats1 get_set_sameE oget_some. 
    - rewrite get_set_sameE oget_some H7 rangeSr.
      rewrite !size_map 1:size_ge0. 
      rewrite (size_map _ (range 0 (size bs0{2}))) size_range /=.
      rewrite max_ler 1:size_ge0 map_rcons /=get_set_sameE oget_some; congr.
      apply eq_in_map=> j.
      rewrite mem_range /==> [] [] hj1 hj2.
      by rewrite get_set_neqE //=; smt().
  auto; progress.
  + smt(size_out_gt0).
  + smt().
  + smt(). 
  + by rewrite range_geq.
  smt().
  qed.

  lemma Sponge_coll_resistant &m :
      Pr[SRO.Collision(A, FM(CSetSize(Sponge), Perm)).main() @ &m : res] <=
      (limit ^ 2 - limit)%r / (2 ^ (r + c + 1))%r +
      (4 * limit ^ 2)%r / (2 ^ c)%r +
      (sigma * (sigma - 1) + 2)%r / 2%r / (2%r ^ size_out).
  proof. 
  rewrite -(doutE1 witness).
  rewrite (coll_resistant_if_indifferentiable A A_ll (CSetSize(Sponge)) Perm &m).
  exists (SimSetSize(Simulator)); split.
  + by move=> F _; proc; inline*; auto.
  cut->:Pr[Indiff0.Indif(CSetSize(Sponge, Perm), Perm, DColl(A)).main() @ &m : res] =
        Pr[RealIndif(Sponge, Perm, DRestr(DSetSize(DColl(A)))).main() @ &m : res].
  + byequiv=>//=; proc. 
    inline Perm.init CSetSize(Sponge, Perm).init Sponge(Perm).init 
          FC(Sponge(Perm)).init; sp.
    inline DColl(A, CSetSize(Sponge, Perm), Perm).distinguish.
    inline DRestr(DSetSize(DColl(A)), Sponge(Perm), Perm).distinguish 
          DSetSize(DColl(A), FC(Sponge(Perm)), PC(Perm)).distinguish Cntr.init; wp; sp; sim. 
    seq 2 2 : (={m1, m2, glob SRO.Counter, glob Perm}
          /\ invm Perm.m{1} Perm.mi{1}
          /\ ={c}(SRO.Counter,Cntr)); last first.
    - if; auto; sp.
      case(SRO.Counter.c{1} + ((size m2{1} + 1) %/ r + 1) + 
          max ((size_out + r - 1) %/ r - 1) 0 < limit); last first.
      * rcondf{1} 2; 1: by auto; inline*; auto; conseq(: _ ==> true); auto.
        rcondf{2} 2; 1: by auto; inline*; auto; conseq(: _ ==> true); auto.
        auto; inline*; auto; sp; conseq(: _ ==> true); auto.
        if{2}; sp; auto; sim.
        while{1}(invm Perm.m{1} Perm.mi{1}) (((size_out + r - 1) %/ r)-i{1}).
        + auto; sp; if; auto. 
          - sp; if ;auto; progress.
            * exact (useful _ _ _ H H2).
            * rewrite invm_set=>//=. 
              by move:H4; rewrite  supp_dexcepted.
            * smt().
            smt().
          smt().
        conseq(:_==> invm Perm.m{1} Perm.mi{1}); 1:smt().
        while{1}(invm Perm.m{1} Perm.mi{1})(size xs{1}).
        + move=> _ z; auto; sp; if; auto; progress.
          * exact (useful _ _ _ H H1).
          * rewrite invm_set=>//=.
            by move:H3; rewrite supp_dexcepted.
          * smt().
          smt().
        auto; smt(size_ge0 size_eq0).
      rcondt{1} 2; first by auto; inline*; auto; conseq(:_==> true); auto.
      rcondt{2} 2; first by auto; inline*; auto; conseq(:_==> true); auto.
      sim.
      exists* m1{1}, m2{1}; elim* => a1 a2 c1 c2.
      call (equiv_sponge_perm (c2 + ((size a1 + 1) %/ r + 1) + max ((size_out + r - 1) %/ r - 1) 0) a2).
      auto; call (equiv_sponge_perm c2 a1); auto; progress. 
      smt(List.size_ge0 divz_ge0 gt0_r).
      smt(List.size_ge0 divz_ge0 gt0_r).
    call(: ={glob SRO.Counter, glob Perm, glob SRO.Bounder}
          /\ invm Perm.m{1} Perm.mi{1} /\ ={c}(SRO.Counter,Cntr)).
    + proc; sp; if; auto; sp; if; auto; sp.
      exists * x{1}; elim* => m c1 c2 b1 b2.
      by call(equiv_sponge_perm c1 m); auto; smt().
    inline*; auto; progress.
    by rewrite /invm=> x y; rewrite 2!emptyE.
  cut->:Pr[Indiff0.Indif(RO, SimSetSize(Simulator, RO), DColl(A)).main() @ &m : res] =
        Pr[IdealIndif(BIRO.IRO, Simulator, DRestr(DSetSize(DColl(A)))).main() @ &m : res].
  + byequiv=>//=; proc.
    inline Simulator(FGetSize(RO)).init RO.init Simulator(BIRO.IRO).init 
          BIRO.IRO.init Gconcl_list.BIRO2.IRO.init; sp.
    inline DColl(A, RO, Simulator(FGetSize(RO))).distinguish.
    inline DRestr(DSetSize(DColl(A)), BIRO.IRO, Simulator(BIRO.IRO)).distinguish 
          DSetSize(DColl(A), FC(BIRO.IRO), PC(Simulator(BIRO.IRO))).distinguish; wp; sim.
    inline SRO.Bounder(FInit(DFSetSize(FC(BIRO.IRO)))).init 
          SRO.Bounder(FInit(RO)).init SRO.Counter.init FInit(RO).init
          FInit(DFSetSize(FC(BIRO.IRO))).init Cntr.init; sp.
    seq 1 1 : (={m1, m2, glob SRO.Counter}
          /\ ={c}(SRO.Counter,Cntr)
          /\ same_ro SRO.RO.RO.m{1} BIRO.IRO.mp{2}); last first.
    - if; auto; sp.
      case: (SRO.Counter.c{1} + ((size m2{1} + 1) %/ r + 1) + 
          max ((size_out + r - 1) %/ r - 1) 0 < limit); last first. 
      * rcondf{1} 2; first by auto; inline*; auto.
        rcondf{2} 2; first auto; inline*; auto; sp.
        + rcondt 1; first by auto; smt().
          by sp; rcondt 1; auto; conseq(:_==> true); auto.
        inline*;sp; auto.
        rcondt{2} 1; first by auto; smt().
        conseq(:_==> true); first smt(dout_ll).
        sp; rcondt{2} 1; auto; conseq(:_==> true); auto.
        by while{2}(true)(n0{2}-i{2}); auto; 1:(sp; if; auto); smt(dbool_ll).
      rcondt{1} 2; first by auto; inline*; auto.
      rcondt{2} 2; first auto; inline*; auto; sp.
      + rcondt 1; first by auto; smt().
        by sp; rcondt 1; auto; conseq(:_==> true); auto.
      sim.
      exists* m1{1}, m2{1}; elim*=> a1 a2 c1 c2.
      call(equiv_ro_iro (c2 + ((size a1 + 1) %/ r + 1) + 
          max ((size_out + r - 1) %/ r - 1) 0) a2).
      auto; call(equiv_ro_iro c2 a1); auto; smt().
    call(: ={glob SRO.Counter, glob SRO.Bounder} /\ ={c}(SRO.Counter,Cntr)
          /\ same_ro SRO.RO.RO.m{1} BIRO.IRO.mp{2}); auto.
    + proc; sp; if; auto; sp; if; auto; sp.
      exists* x{1}; elim* => a c1 c2 b1 b2.
      call(equiv_ro_iro c1 a); auto; smt().
    smt(mem_empty). 
  have->//=:= SHA3Indiff (DSetSize(DColl(A))) &m _.
  move=> F P P_f_ll P_fi_ll F_ll; proc; inline*; auto; sp.
  seq 1 : true; auto.
  + call (A_ll (SRO.Bounder(FInit(DFSetSize(F)))) _); auto.
    by proc; inline*; sp; if; auto; sp; if; auto; sp; call F_ll; auto.
  if; auto; sp.
  seq 1 : true; auto.
  + by call F_ll; auto.
  sp; if; auto; sp; call F_ll; auto.
  qed.

end section Collision.

module X (F : SRO.Oracle) = {
  proc get (bl : bool list) = {
  var r;
  r <@ F.get(bl ++ [ false ; true ]);
  return r;
  }
}.

module AdvCollisionSHA3 (A : SRO.AdvCollision) (F : SRO.Oracle) = {
  proc guess () = {
    var m1, m2;
    (m1, m2) <@ A(X(F)).guess();
    return (m1 ++ [ false ; true ], m2 ++ [ false ; true ]);
  }
}.

section SHA3_Collision.

  declare module A : SRO.AdvCollision{SRO.RO.RO, SRO.RO.FRO, SRO.Bounder, Perm, 
    Gconcl_list.BIRO2.IRO, Simulator, Cntr, BIRO.IRO, F.RO, F.FRO, Redo, C, 
    Gconcl.S, BlockSponge.BIRO.IRO, BlockSponge.C, Gconcl_list.F2.RO,
    Gconcl_list.F2.FRO, Gconcl_list.Simulator}.

  axiom A_ll (F <: SRO.Oracle { A }) : islossless F.get => islossless A(F).guess.

  lemma SHA3_coll_resistant &m :
      Pr[SRO.Collision(AdvCollisionSHA3(A), FM(CSetSize(Sponge), Perm)).main() @ &m : res] <=
      (limit ^ 2 - limit)%r / (2 ^ (r + c + 1))%r +
      (4 * limit ^ 2)%r / (2 ^ c)%r +
      (sigma * (sigma - 1) + 2)%r / 2%r / (2%r ^ size_out).
  proof.
  apply (Sponge_coll_resistant (AdvCollisionSHA3(A)) _ &m).
  by move=> F F_ll; proc; inline*; call(A_ll (X(F)) _); auto; proc; call F_ll; auto.
  qed.


end section SHA3_Collision.
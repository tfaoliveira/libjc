pragma -oldip.
require import Core Int Real RealExtra StdOrder Ring StdBigop IntExtra.
require import List FSet SmtMap Common SLCommon PROM FelTactic Mu_mem.
require import Distr DProd Dexcepted BlockSponge Gconcl.
(*...*) import Capacity IntOrder Bigreal RealOrder BRA.

require (*--*) Handle.

(*** THEORY PARAMETERS ***)
(** Validity of Functionality Queries **)
op valid: block list -> bool = valid_block.
axiom valid_spec p: valid p => p <> [].
axiom parse_gt0 x: 0 < (parse x).`2.
axiom parse_not_valid x :
  !valid (parse x).`1 => 
  forall i, ! valid (parse (format (parse x).`1 i)).`1.
axiom parse_twice p n x : 
  (p,n) = parse x => forall i, 0 < i <= n => parse (format p i) = (p,i).
axiom valid_uniq p1 p2 n1 n2 :
  valid p1 => valid p2 => format p1 n1 = format p2 n2 => p1 = p2 /\ n1 = n2.


clone export Handle as Handle0.

module DSqueeze (F : SLCommon.DFUNCTIONALITY) = {
  proc init () : unit = {} 
  proc f (p : block list, n : int) : block list = {
    var lres : block list <- [];
    var b : block <- b0;
    var i : int <- 0;
    if (valid p) {
      b <@ F.f(p);
      while (i < n) {
        i <- i + 1;
        lres <- rcons lres b;
        if (i < n) {
          b <@ F.f(format p (i+1));
        }
      }
    }
    return lres;
  }
}.


module (Squeeze (F : SLCommon.FUNCTIONALITY) : FUNCTIONALITY) = {
  proc init () : unit = {
    C.init();
    F.init();
  }
  proc f = DSqueeze(F).f
}.


module (A (D : DISTINGUISHER) : SLCommon.DISTINGUISHER)
  (F : SLCommon.DFUNCTIONALITY) (P : DPRIMITIVE) = {
  proc distinguish() : bool = {
    var b : bool;
    C.init();
    b <@ DRestr(D,DSqueeze(F),P).distinguish();
    return b;
  }
}.



module NIndif (F : FUNCTIONALITY, P : PRIMITIVE, D : DISTINGUISHER) = {
  proc main () : bool = {
    var b : bool;
    C.init();
    P.init();
    F.init();
    b <@ D(F,P).distinguish();
    return b;
  }
}.



module P = Perm.

clone IRO as BIRO2 with
  type from <- block list,
  type to   <- block,
  op valid  <- predT,
  op dto    <- bdistr.

module Valid (F : DFUNCTIONALITY) = {
  proc init () = {}
  proc f (q : block list, k : int) = {
    var re : block list <- [];
    (q,k) <- parse (format q k);
    if (valid q) {
      re <@ F.f(q,k);
    } else {
      re <@ BIRO2.IRO.f(q,k);
    }
    return re;
  }
}.

module SimLast (S : SLCommon.SIMULATOR) (F : DFUNCTIONALITY) = {
  proc init() = {
    BIRO2.IRO.init();
    S(Last(Valid(F))).init();
  }
  proc f  = S(Last(Valid(F))).f
  proc fi = S(Last(Valid(F))).fi
}.

clone F as F2.


section Ideal.

  op (<=) (m1 m2 : (block list, 'b) fmap) = 
    forall x, x <> [] => x \in m1 => m1.[x] = m2.[x].

  local lemma leq_add_nin (m1 m2 : (block list, 'b) fmap) (x : block list) (y : 'b):
      m1 <= m2 => 
      ! x \in m2 =>
      m1 <= m2.[x <- y].
  proof.
  move=>h_leq H_n_dom a H_a_dom;rewrite get_setE/=;smt(domE).
  qed.


  local lemma leq_add_in (m1 m2 : (block list, 'b) fmap) (x : block list) :
      m1 <= m2 => 
      x \in m2 =>
      m1.[x <- oget m2.[x]] <= m2.
  proof.
  move=>h_leq H_n_dom a H_a_dom;rewrite get_setE/=;smt(domE get_setE).
  qed.

  local lemma leq_nin_dom (m1 m2 : (block list, 'b) fmap) (x : block list) :
      m1 <= m2 =>
      x <> [] =>
      ! x \in m2 => ! x \in m1 by smt(domE).

  local lemma prefix_leq1 (l : block list) (m : (block list,block) fmap) i :
      0 <= i =>
      format l (i+1) \in m =>
      size (format l (i+1)) <= prefix (format l (i+1+1)) 
        (get_max_prefix (format l (i+1+1)) (elems (fdom m))) <= size (format l (i+1+1)).
  proof. 
  rewrite -mem_fdom memE;move=>hi0 H_dom. 
  cut->:(format l (i + 1 + 1)) = format l (i + 1) ++ [b0].
  + by rewrite/format//=nseqSr//-cats1 catA. 
  cut:=prefix_leq_prefix_cat_size (format l (i + 1))[b0](elems (fdom m)).
  rewrite (prefix_get_max_prefix_eq_size _ _ H_dom)//=.
  rewrite (size_cat _ [b0])/=;pose x:= format _ _.
  cut:=get_max_prefix_max (x ++ [b0]) _ _ H_dom.
  cut->:prefix (x ++ [b0]) (format l (i + 1)) = size x
    by rewrite prefixC-{1}(cats0 (format l (i+1)))/x prefix_cat//=. 
  smt(prefix_sizel size_cat prefix_ge0 ).
  qed.

  local lemma prefix_le1 (l : block list) (m : (block list,block) fmap) i :
      0 <= i =>
      format l (i+1) \in m =>
      size (format l (i+1+1)) - prefix (format l (i+1+1)) 
        (get_max_prefix (format l (i+1+1)) (elems (fdom m))) <= 1.
  proof. 
  move=> Hi0 H_liS_in_m.
  have:= prefix_leq1 _ _ _ Hi0 H_liS_in_m.
  rewrite /format /= nseqSr //-cats1 catA (size_cat(l ++ nseq i b0) [b0]) /=.
  smt(size_ge0). 
  qed.

  local lemma leq_add2  (m1 m2 : (block list, 'b) fmap) (x : block list) (y : 'b) :
      m1 <= m2 => 
      ! x \in m2 =>
      m1.[x <- y] <= m2.[x <- y] by smt(domE get_setE mem_set in_fsetU1).


  local equiv ideal_equiv (D <: DISTINGUISHER{SLCommon.C, C, IF, S}) :
      SLCommon.IdealIndif(IF, S, SLCommon.DRestr(A(D))).main
      ~
      SLCommon.IdealIndif(IF, S, A(D)).main
      :
      ={glob D} ==> ={glob D, res}.
  proof.
  proc;inline*;auto;sp.
  call(: ={glob IF, glob S, glob A} /\ SLCommon.C.c{1} <= C.c{1}
      /\ SLCommon.C.queries{1} <= F.RO.m{2});auto;last first.
  + progress.
    by move=>x;rewrite get_setE/=mem_set-mem_fdom fdom0 in_fset0//==>->.
  + proc;inline*;sp;if;auto;sp;rcondt{1}1;1:auto=>/#;sp;if=>//=;2:auto=>/#.
    wp 7 6;conseq(:_==> ={y} /\ ={F.RO.m} /\ ={S.paths, S.mi, S.m}
        /\ SLCommon.C.queries{1} <= F.RO.m{2});1:smt().
    if;auto;smt(leq_add_nin).
  + by proc;inline*;sp;if;auto;sp;rcondt{1}1;1:auto=>/#;sp;if;auto;smt().
  proc;inline*;sp;if;auto;swap 6;auto;sp;if;auto;2:smt(size_ge0).
  case(0 < n{1});last first.
  + sp;rcondf{1}3;2:rcondf{2}4;1,2:auto.
     - by if;auto;if;auto.
    by if{1};2:auto;1:if{1};auto;
     smt(prefix_ge0 leq_add_in DBlock.dunifin_ll domE size_ge0 get_setE leq_add2).
  splitwhile{1}5: i + 1 < n;splitwhile{2}5: i + 1 < n.
  rcondt{1}6;2:rcondt{2}6;auto.
  * by while(i < n);auto;sp;if;auto;sp;if;auto;if;auto.
  * by while(i < n);auto;sp;if;auto;sp;if;auto;if;auto.
  rcondf{1}8;2:rcondf{2}8;auto.
  * while(i < n);auto.
      by sp;if;auto;sp;if;auto;if;auto.
    sp;if;auto;2:smt();if;auto;smt().
  * while(i < n);auto;2:smt();sp;if;auto;sp;if;auto;if;auto.
  rcondf{1}8;2:rcondf{2}8;auto.
  * while(i < n);auto.
      by sp;if;auto;sp;if;auto;if;auto.
    sp;if;auto;2:smt();if;auto;smt().
  * by while(i < n);auto;2:smt();sp;if;auto;sp;if;auto;if;auto.
  conseq(:_==> ={b,lres,F.RO.m,S.paths,S.mi,S.m}
        /\ i{1} = n{1} - 1
        /\ SLCommon.C.c{1} <= C.c{1} + size bl{1} + i{1}
        /\ SLCommon.C.queries{1} <= F.RO.m{2});1:smt().
  while(={lres,F.RO.m,S.paths,S.mi,S.m,i,n,p,nb,b,bl}
        /\ 0 <= i{1} <= n{1} - 1
        /\ SLCommon.C.queries.[format p (i+1)]{1} = Some b{1}
        /\ p{1} = bs{1} /\ valid p{1} /\ p{1} = bl{1}
        /\ C.c{1} + size p{1} + n{1} - 1 <= max_size
        /\ SLCommon.C.c{1} <= C.c{1} + size bl{1} + i{1}
        /\ SLCommon.C.queries{1} <= F.RO.m{2});progress.
  sp;rcondt{1}1;2:rcondt{2}1;1,2:auto;sp.
  case((x0 \in F.RO.m){2});last first.
  * rcondt{2}2;1:auto;rcondt{1}1.
    + auto => /> &hr iR 9?; apply leq_nin_dom => //.
      smt (leq_nin_dom size_cat size_eq0 size_nseq valid_spec).
    rcondt{1}1;1:auto.
    - move=> /> &hr i [#] h1 h2 h3 h4 h5 h6 h7 h8 h9 h10.
      have//= /#:= prefix_le1 bl{m} SLCommon.C.queries{hr} i h1 _.
      by rewrite domE h3.
    sp;rcondt{1}2;auto;progress.
    - smt().
    - smt().
    - by rewrite!get_setE/=.
    - have//= /#:= prefix_le1 bl{2} SLCommon.C.queries{1} i_R H _.
      by rewrite domE H1. 
    - by rewrite!get_setE/= leq_add2//=.
  if{1}.
  * rcondt{1}1;1:auto.
    - move=> /> &hr i [#] h1 h2 h3 h4 h5 h6 h7 h8 h9 h10.
      have//= /#:= prefix_le1 bl{m} SLCommon.C.queries{hr} i h1 _.
      by rewrite domE h3.
    sp;rcondf{1}2;2:rcondf{2}2;auto;progress.
    - smt().
    - smt().
    - by rewrite!get_setE/=.
    - have//= /#:= prefix_le1 bl{2} SLCommon.C.queries{1} i_R H _.
      by rewrite domE H1. 
    - smt(leq_add_in domE).
  rcondf{2}2;auto;progress.
  - smt(size_cat size_nseq size_eq0 size_ge0).
  - smt().
  - smt(). 
  - by move: H11; rewrite domE; case: (SLCommon.C.queries{1}.[format bl{2} (i_R + 2)]).
  - smt().
  sp;conseq(:_==> ={F.RO.m,b}
        /\ SLCommon.C.queries.[p]{1} = Some b{1}
        /\ SLCommon.C.c{1} <= C.c{1} + size bl{1}
        /\ SLCommon.C.queries{1} <= F.RO.m{2});progress.
  - smt().
  - smt(nseq0 cats0).
  - smt(size_ge0).
  - smt().
  case(p{2} \in F.RO.m{2}).
  + rcondf{2}2;1:auto.
    sp;if{1}.
    - rcondt{1}1;1:auto;1:smt(prefix_ge0).
      sp;rcondf{1}2;auto;progress.
      * by rewrite!get_setE/=. 
      * smt(prefix_ge0).
      * smt(leq_add_in domE).
    auto;progress.
    - smt(domE).
    - smt(domE).
    - smt(size_ge0).
  rcondt{1}1;1:auto;1:smt(leq_nin_dom domE).
  rcondt{1}1;1:auto;1:smt(prefix_ge0).
  sp;auto;progress.
  + by rewrite!get_setE/=.
  + smt(prefix_ge0).
  + rewrite get_setE/= leq_add2//=.
  + by rewrite!get_setE/=.
  + smt(prefix_ge0).
  + exact leq_add_in.
  qed.


  local module IF'(F : F.RO) = {
    proc init = F.init
    proc f (x : block list) : block = {
      var b : block <- b0;
      var i : int <- 0;
      var p,n;
      (p,n) <- parse x;
      while (i < n) {
        i <- i + 1;
        F.sample(format p i);
      }
      b <@ F.get(x);
      return b;
    }
  }.




  local module (L (D : DISTINGUISHER) : F.RO_Distinguisher) (F : F.RO) = {
    proc distinguish = SLCommon.IdealIndif(IF'(F), S, A(D)).main
  }.

  local module Valid2 (F : F.RO) = {
    proc init = F.init
    proc f (q : block list) = {
      var r : block  <- b0;
      var s,t;
      (s,t) <- parse q;
      r <@ F.get(q);
      return r;
    }
  }.

  local module (L2 (D : DISTINGUISHER) : F.RO_Distinguisher) (F : F.RO) = {
    proc distinguish = SLCommon.IdealIndif(Valid2(F), S, A(D)).main
  }.

  local equiv Ideal_equiv_valid (D <: DISTINGUISHER{SLCommon.C, C, IF, S}) :
      L(D,F.LRO).distinguish
      ~
      L2(D,F.LRO).distinguish
      :
      ={glob D} ==> ={glob D, res}.
  proof.
  proc;inline*;sp;wp.
  call(: ={glob S, glob C, glob F.RO});auto.
  + proc;sp;if;auto.
    call(: ={glob S,glob F.RO});auto.
    sp;if;auto;if;auto;sp.
    call(: ={glob F.RO});2:auto;2:smt(). 
    inline F.LRO.sample;call(: ={glob IF});auto;progress.
    by while{1}(true)(n{1}-i{1});auto;smt().
  + by proc;sim.
  proc;sp;if;auto;sp;call(: ={glob IF,glob S});auto.
  sp;if;auto.
  while(={glob S,glob IF,lres,i,n,p,b}).
  + sp;if;auto.
    call(: ={glob IF});auto.
    call(: ={glob IF});auto.
    conseq(:_==> true);auto. 
    by inline*;while{1}(true)(n{1}-i{1});auto;smt().
  call(: ={glob IF});auto.
  call(: ={glob IF});auto. 
  conseq(:_==> true);auto. 
  by inline*;while{1}(true)(n{1}-i{1});auto;smt().
  qed.  


  local equiv ideal_equiv2 (D <: DISTINGUISHER{SLCommon.C, C, IF, S}) :
    L2(D,F.RO).distinguish ~ SLCommon.IdealIndif(IF,S,A(D)).main
    : ={glob D} ==> ={glob D, res}.
  proof.
  proc;inline*;sp;wp.
  call(: ={glob F.RO, glob S, glob C});auto.
  + proc;auto;sp;if;auto.
    call(: ={glob F.RO, glob S});auto.
    if;1,3:auto;sim;if;auto.
    call(: ={glob F.RO});2:auto. 
    by inline*;sp;wp 2 2;sim.
  + by proc;sim.
  proc;sp;if;auto;sp.
  call(: ={glob F.RO});auto;sp;if;auto;inline*;auto;sp.
  case(0 < n{1});last first.
  + by rcondf{2}4;1:auto;rcondf{1}5;auto.
  while(={lres,F.RO.m,i,n,p,b} /\ valid p{1} /\ 0 <= i{1} <= n{1}).
  + sp;if;1:auto.
    - by auto;smt(parse_valid parseK formatK).
    by auto;smt(parse_valid parseK formatK).
  by auto;smt(parse_valid parseK formatK).
  qed.

  inductive inv_L_L3 (m1 m2 m3 : (block list, block) fmap) =
  | INV of (m1 = m2 + m3)
         & (forall l, l \in m2 => valid (parse l).`1)
         & (forall l, l \in m3 => ! valid (parse l).`1).

  local module IF2(F : F.RO) (F2 : F2.RO) = {
    proc init () = {
      F.init();
      F2.init();
    }
    proc f (x : block list) : block = {
      var b : block <- b0;
      var i : int <- 0;
      var p,n;
      (p,n) <- parse x;
      if (valid p) {
        while (i < n) {
          i <- i + 1;
          F.sample(format p i);
        }
        b <@ F.get(x);
      } else {
        while (i < n) {
          i <- i + 1;
          F2.sample(format p i);
        }
        b <@ F2.get(x);
      }
      return b;
    }
  }.
  

  local module (L3 (D : DISTINGUISHER) : F.RO_Distinguisher) (F : F.RO) = {
    proc distinguish = SLCommon.IdealIndif(IF2(F,F2.RO), S, A(D)).main
  }.

  local lemma lemma1 m1 m2 m3 p i r:
      inv_L_L3 m1 m2 m3 =>
      valid p =>
      0 < i =>
      ! format p i \in m1 =>
      ! format p i \in m2 =>
      inv_L_L3 m1.[format p i <- r] m2.[format p i <- r] m3.
  proof.
  move=>INV0 p_valid i_gt0 nin_dom1 nin_dom2;split;cut[]add_maps valid_dom nvalid_dom:=INV0.
  + rewrite add_maps -fmap_eqP=>x.
    by rewrite get_setE !joinE get_setE;smt(parseK formatK).
  + smt(mem_set parseK formatK).
  + smt(mem_set parseK formatK).
  qed.

  local lemma lemma2 m1 m2 m3 p i:
      inv_L_L3 m1 m2 m3 =>
      valid p =>
      0 < i =>
      format p i \in m1 =>
      format p i \in m2.
  proof.
  move=>INV0 p_valid i_gt0 domE1;cut[]add_maps valid_dom nvalid_dom:=INV0.
  by have:= domE1; rewrite add_maps mem_join;smt(parseK formatK).
  qed.


  local lemma incl_dom m1 m2 m3 l :
      inv_L_L3 m1 m2 m3 =>
      l \in m1 <=> (l \in m2 \/ l \in m3).
  proof.
  move=>INV0;cut[]add_maps valid_dom nvalid_dom:=INV0.
  by rewrite add_maps mem_join.
  qed.


  local lemma lemma3 m1 m2 m3 x r:
      inv_L_L3 m1 m2 m3 =>
      ! valid (parse x).`1 =>
      ! x \in m1 =>
      inv_L_L3 m1.[x <- r] m2 m3.[x <- r].
  proof.
  move=>INV0 not_valid nin_dom1;cut[]add_maps h1 h2:=INV0.
  cut nin_dom3: ! x \in m3 by smt(incl_dom).
  split.
  + by apply/fmap_eqP=>y;rewrite add_maps !get_setE!joinE!get_setE mem_set/#.
  + exact h1.
  smt(mem_set).
  qed.


  local equiv Ideal_equiv3 (D <: DISTINGUISHER{SLCommon.C, C, IF, S, F2.RO}) :
      L(D,F.RO).distinguish ~ L3(D,F.RO).distinguish
      : ={glob D} ==> ={glob D, res}.
  proof.
  proc;inline*;auto;sp.
  call(: ={glob S, glob C} /\ inv_L_L3 F.RO.m{1} F.RO.m{2} F2.RO.m{2});auto;first last.
  + proc;sp;if;auto.
    by call(: ={glob S});auto;sim.
  + proc;sp;if;auto;call(: inv_L_L3 F.RO.m{1} F.RO.m{2} F2.RO.m{2});auto;sp.
    inline*;if;auto;sp.
    rcondt{1}1;1:auto;1:smt(parse_valid parseK formatK).
    rcondt{2}1;1:auto;1:smt(parse_valid parseK formatK).
    rcondt{2}1;1:auto;1:smt(parse_valid parseK formatK);sp.
    rcondf{1}3;1:auto;1:smt(parse_valid parseK formatK);sp.
    rcondf{2}3;1:auto;1:smt(parse_valid parseK formatK);sp.
    rcondf{1}5;2:rcondf{2}5;
      1,2:by auto;smt(mem_set nseq0 cats0 parse_valid).
    case(0 < n{1});auto;last first.
    - rcondf{1}7;1:auto;rcondf{2}7;1:auto. 
      by wp;rnd;auto;progress;smt(lemma1 nseq0 cats0 lemma2 incl_dom 
          parse_valid parseK formatK in_fsetU).
    while(={i,n,p,lres,b} /\ valid p{1} /\ 0 <= i{1} <= n{1}
      /\ inv_L_L3 F.RO.m{1} F.RO.m{2} F2.RO.m{2}).
    - sp;if;1,3:auto=>/#.
      sp;rcondt{2}1;1:auto;1:smt(parse_valid parseK formatK).
      conseq(:_==> ={b} /\ inv_L_L3 F.RO.m{1} F.RO.m{2} F2.RO.m{2});1:progress=>/#.
      auto=>/=.
      conseq(:_==> inv_L_L3 F.RO.m{1} F.RO.m{2} F2.RO.m{2});progress.
      * by rewrite!get_setE//=.
      * smt(lemma1 parse_valid).
      * smt(lemma2 parse_valid).
      * smt(lemma2 parse_valid).
      * smt(incl_dom).
      * smt(incl_dom).
      * case:H8;smt(joinE).
      while(={i1,n1,p1} /\ valid p1{1} /\ 0 <= i1{1} <= n1{1}
          /\ inv_L_L3 F.RO.m{1} F.RO.m{2} F2.RO.m{2}).
      * sp;conseq(:_==> inv_L_L3 F.RO.m{1} F.RO.m{2} F2.RO.m{2});1:smt().
        case(x6{1} \in F.RO.m{1}).
        + by rcondf{1}2;2:rcondf{2}2;auto;smt(incl_dom lemma2).
        by rcondt{1}2;2:rcondt{2}2;auto;smt(lemma2 incl_dom lemma1).
      by auto;smt(parseK).
    wp;rnd;wp 2 2.
    conseq(:_==> F.RO.m{1}.[p{1}] = F.RO.m{2}.[p{2}]
        /\ inv_L_L3 F.RO.m{1} F.RO.m{2} F2.RO.m{2});progress.
    + cut[]add_maps h1 h2:=H5;rewrite add_maps joinE//=. 
      by have:= h2 p{2}; rewrite parse_valid //= H2 /= => h; rewrite h.
    + smt().
    case(x5{1} \in F.RO.m{1}).
    - rcondf{1}2;2:rcondf{2}2;auto;progress. 
      * smt(lemma2 incl_dom parse_valid). 
      by cut[]add_maps h1 h2:=H1;rewrite add_maps joinE//=;smt(parse_valid).
    rcondt{1}2;2:rcondt{2}2;auto;progress.
    - move:H4;rewrite/format/=nseq0 !cats0 => p0_notin_ROm_m.
      case: H1 => joint _ _; move: p0_notin_ROm_m.
      by rewrite joint mem_join negb_or; smt(parse_valid).
    - cut[]add_maps h1 h2:=H1;rewrite add_maps !get_setE joinE//=;smt(parse_valid nseq0 cats0).
    - cut:=H;rewrite -H0=>//=[][]->>->>;apply lemma1=>//=;1:smt(parse_valid).
      cut[]add_maps h1 h2:=H1;smt(parse_valid formatK parseK incl_dom).
  + progress;split. 
    - by apply/fmap_eqP=>x;rewrite joinE mem_empty. 
    - smt(mem_empty).
    - smt(mem_empty).
  proc;sp;if;auto;call(: ={glob S} /\ inv_L_L3 F.RO.m{1} F.RO.m{2} F2.RO.m{2});auto.
  if;1,3:auto.
  seq 1 1 : (={x, y1, S.paths, S.mi, S.m} /\ inv_L_L3 F.RO.m{1} F.RO.m{2} F2.RO.m{2});last first.
  + by conseq(:_==> ={y, S.paths, S.mi, S.m});progress;sim.
  if;auto.
  call(: inv_L_L3 F.RO.m{1} F.RO.m{2} F2.RO.m{2});auto;sp;inline*. 
  if{2}.
  + seq 1 1 : (={x,p,n} /\ parse x{1} = (p,n){1} /\ valid p{1}
        /\ inv_L_L3 F.RO.m{1} F.RO.m{2} F2.RO.m{2});last first.
    - sp;case(x1{1} \in F.RO.m{1}).
      * rcondf{1}2;2:rcondf{2}2;auto;progress.
        + cut:=H2;rewrite -formatK H/=;smt(lemma2 incl_dom parse_gt0).
        cut[]add_maps h1 h2:=H1;rewrite add_maps joinE.
        cut:=H2;rewrite -formatK H/==>in_dom1.
        case(format p{2} n{2} \in F2.RO.m{2})=>//=in_dom3.
        by cut:=h2 _ in_dom3;rewrite parseK//=;smt(parse_gt0).
      rcondt{1}2;2:rcondt{2}2;auto;progress.
      + smt(incl_dom lemma2).
      + cut[]:=H1;smt(get_setE joinE).
      by cut:=H2;rewrite-formatK H/==>nin_dom1;rewrite lemma1//=;smt(parse_gt0 lemma2 incl_dom).
    conseq(:_==> inv_L_L3 F.RO.m{1} F.RO.m{2} F2.RO.m{2});1:smt().
    while(={i,n,p} /\ 0 <= i{1} /\ valid p{1} /\ inv_L_L3 F.RO.m{1} F.RO.m{2} F2.RO.m{2}).
    + sp;case(x2{1} \in F.RO.m{1}).
      - by rcondf{1}2;2:rcondf{2}2;auto;smt(lemma2).
      rcondt{1}2;2:rcondt{2}2;auto;progress. 
      - smt(incl_dom lemma1).
      - smt(incl_dom lemma1).
      apply/lemma1=> //=.
      - smt(). 
      smt(incl_dom mem_join).
    auto;smt().
  seq 1 1 : (={x,p,n} /\ parse x{1} = (p,n){1} /\ ! valid p{1}
        /\ inv_L_L3 F.RO.m{1} F.RO.m{2} F2.RO.m{2});last first.
  + sp;case(x1{1} \in F.RO.m{1}).
    - rcondf{1}2;2:rcondf{2}2;auto;progress.
      * cut[]:=H1;smt(incl_dom).
      cut[]:=H1;smt(joinE incl_dom).
    rcondt{1}2;2:rcondt{2}2;auto;progress.
    * cut[]:=H1;smt(incl_dom).
    * cut[]:=H1;smt(joinE incl_dom get_setE).
    by rewrite(lemma3 _ _ _ _ rL H1 _ H2)H//=.
  conseq(:_==> inv_L_L3 F.RO.m{1} F.RO.m{2} F2.RO.m{2});1:smt().
  while(={i,n,p,x} /\ 0 <= i{1} /\ ! valid p{1} /\ parse x{1} = (p,n){1}
    /\ inv_L_L3 F.RO.m{1} F.RO.m{2} F2.RO.m{2}).
  + sp;case(x2{1} \in F.RO.m{1}).
    - rcondf{1}2;2:rcondf{2}2;auto;progress. 
      * cut[]h_join h1 h2:=H2.
        have:= H5; rewrite h_join mem_join.
        have:= h1 (format p{hr} (i_R + 1)). 
        have:=parse_not_valid x{hr}; rewrite H1 /= H0 /= => h.
        by rewrite (h (i_R+1)) /= => ->. 
      smt().
    rcondt{1}2;2:rcondt{2}2;auto;progress. 
    * smt(incl_dom lemma1).
    * smt(). 
    * cut//=:=lemma3 _ _ _ _ r0L H2 _ H5. 
      by have:= parse_not_valid x{2}; rewrite H1 /= H0 /= => h; exact/(h (i_R+1)).
  auto;smt().
  qed.

  local module D2 (D : DISTINGUISHER) (F : F.RO) = {
    proc distinguish = D(FC(DSqueeze(Valid2(F))), PC(S(Valid2(F)))).distinguish
  }.

  local module D3 (D : DISTINGUISHER) (F : F.RO) = {
    proc distinguish = D(FC(DSqueeze(IF'(F))), PC(S(IF'(F)))).distinguish
  }.


  module DSqueeze2 (F : F.RO) (F2 : F2.RO) = {
    proc init () : unit = {
      F.init();
      F2.init();
    } 
    proc f (p : block list, n : int) : block list = {
      var lres : block list <- [];
      var b : block <- b0;
      var i : int <- 0;
      var pp, nn;
      (pp,nn) <- parse (format p n);
      if (valid p) {
        if (n <= 0) {
           F.sample(p);
        }
        while (i < n) {
          i <- i + 1;
          b <@ F.get(format p i);
          lres <- rcons lres b;
        }
      } else {
        if (nn <= 0) {
           F2.sample(pp);
        }
        while (i < nn - n) {
          i <- i + 1;
          F2.sample(format pp i);
        }
        while (i < n) {
          i <- i + 1;
          b <@ F2.get(format pp i);
          lres <- rcons lres b;
        }
      }
      return lres;
    }
  }.


  local module FValid (F : DFUNCTIONALITY) = {
    proc f (p : block list, n : int) = {
      var r : block list <- [];
      if (valid p) {
        r <@ F.f(p,n);
      }
      return r;
    }
  }.

  local module DValid (D : DISTINGUISHER) (F : DFUNCTIONALITY) (P : DPRIMITIVE) = D(FValid(F),P).

  local module S2 (F : DFUNCTIONALITY) = S(Last(F)).

  local module L4 (D : DISTINGUISHER) (F : F.RO) (F2 : F2.RO) = {
    proc distinguish = IdealIndif(DSqueeze2(F,F2),S2,DValid(DRestr(D))).main
  }.

  local equiv equiv_L3_L4 (D <: DISTINGUISHER{SLCommon.C, C, IF, S, F2.RO, BIRO.IRO, BIRO2.IRO}) :
      L3(D,F.RO).distinguish
      ~
      L4(D,F.RO,F2.RO).distinguish
      :
      ={glob D} ==> ={glob D, res}.
  proof.
  proc; inline*; auto; sp. 
  call(: ={glob S, glob C, glob F.RO, glob F2.RO}); auto;first last.
  + by proc; sim. 
  + proc; sp; if; auto; call(: ={glob F.RO, glob F2.RO}); auto; sp; if; auto; inline*; sp.
    rcondt{1}1; 1:(auto; smt(parse_valid parse_gt0)); sp.
    rcondt{1}1; 1:(auto; smt(parse_valid parse_gt0)); sp.
    (* rcondt{1}1; 1:(auto; smt(parse_valid parse_gt0)); sp. *)
    rcondf{1}3; 1:(auto; smt(parse_valid parse_gt0)); sp.
    rcondt{2}1; 1:(auto; smt(parse_valid parse_gt0 parseK formatK)); sp; wp.
    if{2};sp.
    - rcondf{2}3; 1:(auto; smt(parse_valid parse_gt0)); sp.
      rcondf{1}8; 1:(auto; smt(parse_valid parse_gt0)); sp.
      rcondf{1}5; 1:(auto; smt(parse_valid parse_gt0 mem_set nseq0 cats0)); sp.
      wp 4 2;rnd{1};wp 2 2.
      by conseq(:_==> ={F.RO.m} /\ r3{1} = r2{2} /\ x9{1} = x4{2});2:sim;
        smt(DBlock.dunifin_ll nseq0 cats0 parse_valid);progress.
    rcondt{2}1; 1:(auto; smt(parse_valid parse_gt0)); sp; wp.
    splitwhile{1} 8 : i + 1 < n.
    rcondt{1}9;1:auto.
    - by while(i < n);auto;2:smt();sp;if;auto;1:(sp;if;auto);while(i < n);auto. 
    rcondf{1}11;1:auto.
    - by while(i < n);auto;2:smt();sp;if;auto;1:(sp;if;auto);while(i < n);auto. 
    rcondf{1}11;1:auto.
    - by while(i < n);auto;2:smt();sp;if;auto;1:(sp;if;auto);while(i < n);auto. 
    wp.
    while((n,p){1} = (n0,p0){2} /\ i{1} + 1 = i{2} /\ valid p{1} /\ 0 < n{1}
        /\ 0 <= i{2} <= n{1}
        /\ (forall j, 1 <= j <= i{2} => format p{1} j \in F.RO.m{1})
        /\ rcons lres{1} b{1} = lres{2} /\ ={F.RO.m, F2.RO.m});last first.
    - rcondf{1}5;1:auto;1:smt(mem_set nseq0 cats0 parse_valid).
      wp 4 2;rnd{1};wp 2 2.
      conseq(:_==> ={F.RO.m} /\ r3{1} = r0{2} /\ x9{1} \in F.RO.m{1});
        1:smt(DBlock.dunifin_ll nseq0 cats0 parse_valid). 
      by auto;smt(parse_valid nseq0 cats0 mem_set).
    sp.
    rcondt{1}1;1:auto;sp.
    rcondt{1}1;1:(auto;smt(parse_valid parseK formatK)).
    (* rcondt{1}1;1:(auto;smt(parse_valid parseK formatK parse_gt0)). *)
    splitwhile{1} 1 : i1 + 1 < n1.
    rcondt{1}2;1:auto.
    - by while(i1 < n1);auto;smt(parse_gt0 parse_valid parseK formatK).
    rcondf{1}7;1:auto.
    - by while(i1 < n1);auto;smt(parse_gt0 parse_valid parseK formatK).
    rcondf{1}9;1:auto.
    - conseq(:_==> i1 + 1 = n1);1:smt(mem_set parseK parse_valid formatK).
      by while(i1 + 1 <= n1);auto;smt(parse_gt0 parse_valid parseK formatK).
    wp 8 2;rnd{1};wp 6 2.
    conseq(:_==> n1{1} = i{2} /\ ={F.RO.m} /\ i1{1} = n1{1}
        /\ (forall (j : int), 1 <= j <= i{2} =>
             format p1{1} j \in F.RO.m{1}));
    1:smt(parseK formatK parse_valid DBlock.dunifin_ll).
    seq 2 0 : (={F.RO.m,x0} /\ i1{1} = n1{1} /\ x0{2} = format p{1} i{2}
        /\ n1{1} = i{1} + 1 /\ p1{1} = p{1} /\ i{2} = i{1} + 1 /\ forall (j : int), 
          1 <= j <= i{1} => format p{1} j \in F.RO.m{1});last first.
    - auto;smt(mem_set).
    wp;conseq(:_==> ={F.RO.m} /\ i1{1} + 1 = n1{1} 
          /\ (forall (j : int), 1 <= j < n1{1} => 
              format p1{1} j \in F.RO.m{1}));1:smt(parseK).
    while{1}(={F.RO.m} /\ 0 <= i1{1} /\ i1{1} + 1 <= n1{1} /\ i{2} = n1{1} /\ i{2} = i{1} + 1
          /\ (forall (j : int), 1 <= j < n1{1} => 
              format p1{1} j \in F.RO.m{1}))(n1{1}-i1{1}-1);progress.
    + by sp;rcondf 2;auto;smt(DBlock.dunifin_ll). 
    by auto;smt(parse_gt0 parseK formatK parse_valid). 
  proc; sp; if; auto; call(: ={glob S, glob F.RO, glob F2.RO}); auto.
  if; 1,3:auto; sim; if; auto; sim; sp. 
  call(: ={glob F.RO, glob F2.RO});auto;last smt().
  inline*;auto;sp.
  if;1:auto;1:smt().
  + (* rcondt{1}1;1:(auto;smt(parse_valid parse_gt0)). *)
    rcondf{2}1;1:(auto;smt(parse_valid parse_gt0)).
    splitwhile{1} 1 : i + 1 < n;splitwhile{2} 1 : i + 1 < n.
    rcondt{1}2;1:auto.
    - by while(i<n);auto;smt(parse_valid parse_gt0).
    rcondt{2}2;1:auto.
    - by while(i<n);auto;smt(parse_valid parse_gt0).
    rcondf{1}7;1:auto.
    - by while(i<n);auto;smt(parse_valid parse_gt0).
    rcondf{2}8;1:auto.
    - by while(i<n);auto;smt(parse_valid parse_gt0).
    rcondf{1}9;1:auto.
    - by while(i+1<=n);auto;
      smt(parse_valid parse_gt0 parseK mem_set formatK).
    wp 8 5;rnd{1};wp 6 5.
    conseq(:_==> ={F.RO.m} /\ p{2} = x0{2});progress.
    + smt(last_rcons formatK parseK).
    seq 3 3 : (={F.RO.m,i,x0} /\ x0{1} = p{2});
      last by conseq(:_==> ={F.RO.m});progress;sim.
    auto;conseq(:_==> ={F.RO.m,i,n} /\ p{1} = p0{2} /\ i{1} + 1 = n{2});1:smt(formatK).
    by while(={F.RO.m,i,n} /\ p{1} = p0{2} /\ 0 <= i{1} /\ i{1} + 1 <= n{2});
      auto;smt(parse_gt0).
  sp;rcondf{2}1;1:(auto;smt(parse_gt0)).
  rcondf{2}1;1:auto;1:smt(parseK formatK).
  splitwhile{1} 1 : i + 1 < n;splitwhile{2} 1 : i + 1 < n.
  rcondt{1}2;1:auto.
  - by while(i<n);auto;smt(parse_valid parse_gt0).
  rcondt{2}2;1:auto.
  - while(i<n);auto;-1:smt(parse_valid parse_gt0).
  rcondf{1}7;1:auto.
  - by while(i<n);auto;smt(parse_valid parse_gt0).
  rcondf{2}8;1:auto.
  - by while(i<n);auto;smt(parse_valid parse_gt0).
  rcondf{1}9;1:auto.
  - by while(i+1<=n);auto;
    smt(parse_valid parse_gt0 parseK mem_set formatK).
  wp 8 5;rnd{1};wp 6 5.
  conseq(:_==> ={F2.RO.m} /\ format pp{2} n{2} = x3{2}).
  + move=> /> &1 &2 H H0 /= /> [#] H1 H2 m lres /= ?. 
    smt(last_rcons formatK parseK).
  seq 3 3 : (={F2.RO.m,i} /\ x2{1} = x3{2} /\ pp{2} = p{1} /\ format pp{2} n{2} = x3{2});
    last by conseq(:_==> ={F2.RO.m});progress;sim.
  auto;conseq(:_==> ={F2.RO.m,i,n} /\ i{1} + 1 = n{2});1:smt(formatK).
  by while(={F2.RO.m,i,n} /\ p{1} = pp{2} /\ 0 <= i{1} /\ i{1} + 1 <= n{2});
    auto;smt(parse_gt0 parseK formatK).
  qed.


  op inv_map (m1 : (block list, block) fmap) (m2 : (block list * int, block) fmap) =
      (forall p n x, parse x = (p,n+1) => (p,n) \in m2 <=> x \in m1)
      /\ (forall p n x, parse x = (p,n+1) => x \in m1 <=> (p,n) \in m2)
      /\ (forall p n x, parse x = (p,n+1) => m2.[(p,n)] = m1.[x])
      /\ (forall p n x, parse x = (p,n+1) => m1.[x] = m2.[(p,n)]).

  inductive INV_L4_ideal m1 m2 m3 m4 =
  | inv_maps of (inv_map m1 m2)
              & (inv_map m3 m4)
              & (forall p n, (p,n) \in m2 => valid p /\ 0 <= n)
              & (forall p n, (p,n) \in m4 => ! valid p /\ 0 <= n).


  local lemma lemma5 m1 m2 m3 m4 p i r :
      INV_L4_ideal m1 m2 m3 m4 =>
      ! (p,i) \in m2 =>
      0 <= i =>
      valid p =>
      INV_L4_ideal m1.[format p (i+1) <- r] m2.[(p,i) <- r] m3 m4.
  proof.
  move=>INV0 nin_dom1 i_gt0 valid_p;cut[]inv12 inv34 dom2 dom4:=INV0;cut[]h1[]h2[]h3 h4:=inv12;split=>//=.
  + progress.
    - move:H0;rewrite 2!mem_set=>[][/#|]/=[]->>->>;smt(parseK formatK).
    - move:H0;rewrite 2!mem_set=>[][/#|]/=;smt(parseK formatK).
    - move:H0;rewrite 2!mem_set=>[][/#|]/=;smt(parseK formatK).
    - move:H0;rewrite 2!mem_set=>[][/#|]/=;smt(parseK formatK).
    - smt(get_setE parseK formatK).
    smt(get_setE parseK formatK).
  smt(get_setE parseK formatK mem_set).
  qed.

  local lemma lemma5bis m1 m2 m3 m4 p i r :
      INV_L4_ideal m1 m2 m3 m4 =>
      ! (p,i) \in m4 =>
      0 <= i =>
      ! valid p =>
      parse (format p (i+1)) = (p,i+1) =>
      INV_L4_ideal m1 m2 m3.[format p (i+1) <- r] m4.[(p,i) <- r].
  proof.
  move=>INV0 nin_dom1 i_gt0 nvalid_p parseK_p_i;
    cut[]inv12 inv34 dom2 dom4:=INV0;
    cut[]h1[]h2[]h3 h4:=inv34;
  split=>//=.
  + progress.
    - move:H0;rewrite 2!mem_set=>[][/#|]/=[]->>->>;smt(parseK formatK).
    - move:H0;rewrite 2!mem_set=>[][/#|]/=;smt(parseK formatK).
    - move:H0;rewrite 2!mem_set=>[][/#|]/=;smt(parseK formatK).
    - move:H0;rewrite 2!mem_set=>[][/#|]/=;smt(parseK formatK).
    - smt(get_setE parseK formatK).
    smt(get_setE parseK formatK).
  smt(get_setE parseK formatK mem_set).
  qed.

  

  local equiv equiv_L4_ideal (D <: DISTINGUISHER{SLCommon.C, C, IF, S, F2.RO, BIRO.IRO, BIRO2.IRO}) :
      L4(D,F.LRO,F2.LRO).distinguish
      ~
      IdealIndif(BIRO.IRO,SimLast(S),DRestr(D)).main
      :
      ={glob D} ==> ={glob D, res}.
  proof.
  proc; inline*; auto; sp. 
  call(: ={glob S, glob C}
    /\ INV_L4_ideal F.RO.m{1} BIRO.IRO.mp{2} F2.RO.m{1} BIRO2.IRO.mp{2});
    auto; -1:(progress;split;smt(mem_empty in_fset0 emptyE)).
  + proc;sp;if;auto;call(: ={glob S}
      /\ INV_L4_ideal F.RO.m{1} BIRO.IRO.mp{2} F2.RO.m{1} BIRO2.IRO.mp{2}); auto.
    if;1,3:auto. seq 1 1 : (={y1, x, glob S}
      /\ INV_L4_ideal F.RO.m{1} BIRO.IRO.mp{2} F2.RO.m{1} BIRO2.IRO.mp{2});
    last by conseq(:_==> ={y, glob S});progress;sim.
    if;auto;call(: INV_L4_ideal F.RO.m{1} BIRO.IRO.mp{2} F2.RO.m{1} BIRO2.IRO.mp{2});auto.
    inline*;auto;sp;if;auto;1:smt(parseK parse_gt0 formatK);1:sp 0 4;2:sp 0 3.
    - rcondt{2}1;1:auto;1:smt(parseK parse_gt0 formatK).
      while(lres{1} = bs{2} /\ ={i,n} /\ x{2} = p0{1} /\ valid p0{1} /\ 0 <= i{1}
        /\ INV_L4_ideal F.RO.m{1} BIRO.IRO.mp{2} F2.RO.m{1} BIRO2.IRO.mp{2});progress.
      * sp;if{2}.
        + rcondt{1}2;auto;progress.
          - cut[]h1 _ _ _:=H1;cut[]h'1 _:=h1;smt(parseK).
          - smt(get_setE).
          - smt().
          - exact lemma5.
        rcondf{1}2;auto;progress.
        - cut[]h1 _ _ _:=H1;cut[]h'1 _:=h1;smt(parseK).
        - cut[]h1:=H1;cut[]:=h1;smt(parseK).
        smt().
      by if{1};auto;smt(parseK parse_gt0 formatK). 
    rcondf{1}1;1:auto;1:smt(parse_gt0);sp.
    rcondt{2}1;1:auto.
    while(lres{1} = bs0{2} /\ (i,n,pp){1} = (i0,n0,x0){2}
        /\ (x0{2}, n0{2}) = parse (format q{2} k{2}) /\ ! valid x0{2} /\ 0 <= i{1}
        /\ INV_L4_ideal F.RO.m{1} BIRO.IRO.mp{2} F2.RO.m{1} BIRO2.IRO.mp{2});progress.
    * sp;if{2}.
      + rcondt{1}2;auto;progress.
        - cut[]_ h1 _ _:=H2;cut[]:=h1;progress.
          cut:=H7 x0{m} i0{m} (format x0{m} (i0{m} + 1));rewrite H5/==>->//=.
          cut->/#:=parse_twice _ _ _ H.
        - smt(get_setE).
        - smt().
        - apply lemma5bis=>//=.
          rewrite(parse_twice _ _ _ H)/#.
      rcondf{1}2;auto;progress.
      - cut[]_ h1 _ _:=H2;cut[]:=h1;progress.
        cut:=H7 x0{m} i0{m} (format x0{m} (i0{m} + 1));rewrite H5/==>->//=.
        cut->/#:=parse_twice _ _ _ H.
      - cut[]_ h1 _ _:=H2;cut[]h'1 _:=h1;smt(parseK parse_twice).
      - smt().
    by rcondf{1}1;auto;smt(parseK formatK).
  + by proc;inline*;conseq(:_==> ={glob C, glob S, z});progress;sim.
  proc;sp;if;auto;call(: INV_L4_ideal F.RO.m{1} BIRO.IRO.mp{2} 
      F2.RO.m{1} BIRO2.IRO.mp{2});auto.
  inline*;sp;if;auto;sp.
  rcondt{1}1;1:auto;if{1};sp.
  - by rcondf{1}1;2:rcondf{2}1;auto;smt().
  while(lres{1} = bs{2} /\ ={i} /\ n0{1} = n{2} /\ x{2} = p0{1} /\ valid p0{1} /\ 0 <= i{1}
      /\ INV_L4_ideal F.RO.m{1} BIRO.IRO.mp{2} F2.RO.m{1} BIRO2.IRO.mp{2});progress.
  sp;if{2}.
  + rcondt{1}2;auto;progress.
    - cut[]h1 _ _ _:=H1;cut[]h'1 _:=h1;smt(parseK).
    - smt(get_setE).
    - smt().
    - exact lemma5.
  rcondf{1}2;auto;progress.
  - cut[]h1 _ _ _:=H1;cut[]h'1 _:=h1;smt(parseK).
  - cut[]h1:=H1;cut[]:=h1;smt(parseK).
  smt().
  qed.

  local module D5 (D : DISTINGUISHER) (F : F.RO) = 
    D(FC(FValid(DSqueeze2(F, F2.RO))), PC(S(Last(DSqueeze2(F, F2.RO))))).

  local module D6 (D : DISTINGUISHER) (F2 : F2.RO) = 
    D(FC(FValid(DSqueeze2(F.LRO, F2))), PC(S(Last(DSqueeze2(F.LRO, F2))))).

  lemma equiv_ideal (D <: DISTINGUISHER{SLCommon.C, C, IF, S, 
      F.FRO, F2.RO, F2.FRO, BIRO.IRO, BIRO2.IRO}) &m:
    Pr[SLCommon.IdealIndif(IF,S,SLCommon.DRestr(A(D))).main() @ &m : res] =
    Pr[IdealIndif(BIRO.IRO,SimLast(S),DRestr(D)).main() @ &m : res].
  proof.
  cut->:Pr[SLCommon.IdealIndif(IF, S, SLCommon.DRestr(A(D))).main() @ &m : res]
      = Pr[SLCommon.IdealIndif(IF, S, A(D)).main() @ &m : res].
  + by byequiv(ideal_equiv D)=>//=.
  cut<-:Pr[L2(D,F.RO).distinguish() @ &m : res] =
        Pr[SLCommon.IdealIndif(IF,S,A(D)).main() @ &m : res].
  + by byequiv(ideal_equiv2 D). 
  cut->:Pr[L2(D, F.RO).distinguish() @ &m : res] = 
        Pr[L2(D,F.LRO).distinguish() @ &m : res].
  + byequiv=>//=;proc;sp;inline*;sp;wp.
    by call(F.RO_LRO_D (D2(D)));auto.
  cut->:Pr[IdealIndif(BIRO.IRO, SimLast(S), DRestr(D)).main() @ &m : res] =
        Pr[L4(D,F.LRO,F2.LRO).distinguish() @ &m : res].
  + by rewrite eq_sym;byequiv(equiv_L4_ideal D)=>//=.
  cut<-:Pr[L4(D, F.RO, F2.RO).distinguish() @ &m : res] = 
        Pr[L4(D,F.LRO,F2.LRO).distinguish() @ &m : res].
  + cut->:Pr[L4(D, F.RO, F2.RO).distinguish() @ &m : res] = 
          Pr[L4(D,F.LRO, F2.RO).distinguish() @ &m : res].
    - byequiv=>//=;proc;sp;inline*;sp;wp.
      by call(F.RO_LRO_D (D5(D)));auto.
    byequiv=>//=;proc;sp;inline*;sp;wp.
    by call(F2.RO_LRO_D (D6(D)));auto.
  cut<-:Pr[L3(D, F.RO).distinguish() @ &m : res] =
        Pr[L4(D, F.RO, F2.RO).distinguish() @ &m : res].
  + by byequiv(equiv_L3_L4 D)=>//=.
  cut<-:Pr[L(D, F.RO).distinguish() @ &m : res] = 
        Pr[L3(D, F.RO).distinguish() @ &m : res].
  + by byequiv(Ideal_equiv3 D).
  cut->:Pr[L(D, F.RO).distinguish() @ &m : res] = 
        Pr[L(D,F.LRO).distinguish() @ &m : res].
  + byequiv=>//=;proc;sp;inline*;sp;wp.
    by call(F.RO_LRO_D (D3(D)));auto.
  rewrite eq_sym.
  by byequiv(Ideal_equiv_valid D).
  qed.

end section Ideal.


  (* Real part *)


section Real.

  inductive m_p (m : (state, state) fmap) (p : (block list, state) fmap) =
  | IND_M_P of (p.[[]] = Some (b0, c0))
        & (forall l, l \in p => forall i, 0 <= i < size l =>
            exists b c, p.[take i l] = Some (b,c) /\
            m.[(b +^ nth witness l i, c)] = p.[take (i+1) l]).

  inductive INV_Real
    (c1 c2 : int)
    (m mi : (state, state) fmap)
    (p : (block list, state) fmap) =
    | INV_real of (c1 <= c2)
                & (m_p m p)
                & (invm m mi).

  local lemma INV_Real_incr c1 c2 m mi p :
      INV_Real c1 c2 m mi p =>
      INV_Real (c1 + 1) (c2 + 1) m mi p.
  proof. by  case;progress;split=>//=/#. qed.

  local lemma INV_Real_addm_mi c1 c2 m mi p x y :
      INV_Real c1 c2 m mi p =>
      ! x \in m =>
      ! rng m y =>
      INV_Real c1 c2 m.[x <- y] mi.[y <- x] p.
  proof.
  case=> H_c1c2 H_m_p H_invm H_x_dom H_y_rng;split=>//=.
  + split;case:H_m_p=>//=;
    smt(get_setE domE oget_some take_oversize size_take take_take).
  exact/invm_set.
  qed.

  local lemma invmC' (m mi : (state, state) fmap) :
      invm m mi => invm mi m.
  proof. by rewrite /#. qed.

  local lemma invmC (m mi : (state, state) fmap) :
      invm m mi <=> invm mi m.
  proof. by split;exact invmC'. qed.

  local lemma invm_dom_rng (m mi : (state, state) fmap) :
      invm m mi => dom m = rng mi.
  proof. 
  move=>h; rewrite fun_ext=> x; rewrite domE rngE /= eq_iff; have h2 := h x; split.
  + move=> m_x_not_None; exists (oget m.[x]); rewrite -h2; move: m_x_not_None.
    by case: (m.[x]).
  by move=> [] a; rewrite -h2 => ->.
  qed.

  local lemma all_prefixes_of_INV_real c1 c2 m mi p:
      INV_Real c1 c2 m mi p =>
      all_prefixes p.
  proof.
  move=>[]_[]Hp0 Hmp1 _ l H_dom i.
  smt(take_le0 take_oversize size_take take_take take_size nth_take domE).
  qed.

  local lemma lemma2' c1 c2 m mi p bl i sa sc:
      INV_Real c1 c2 m mi p =>
      1 < i =>
      valid bl =>
      (sa,sc) \in m =>
      ! (format bl i) \in p =>
      p.[format bl (i-1)] = Some (sa,sc) =>
      INV_Real c1 c2 m mi p.[format bl i <- oget m.[(sa,sc)]].
  proof.
  move=>inv0 h1i h_valid H_dom_m H_dom_p H_p_val.
  split;cut[]//=_[] hmp0 hmp1 hinvm:=inv0;split=>//=.
  + by rewrite get_setE;smt(size_cat size_nseq size_ge0).
  + move=>l;rewrite mem_set;case;1:smt(all_prefixes_of_INV_real get_setE).
    move=>->>j[]hj0 hjsize;rewrite get_setE/=.
    cut:=hmp1 (format bl (i - 1));rewrite domE H_p_val/==>help.
    cut:=hjsize;rewrite !size_cat !size_nseq/=!max_ler 1:/#=>hjsizei.
    cut->/=:!take j (format bl i) = format bl i by smt(size_take).
    cut h:forall k, 0 <= k <= size bl + i - 2 => 
      take k (format bl (i - 1)) = take k (format bl i).
    * move=>k[]hk0 hkjS;rewrite !take_cat;case(k<size bl)=>//=hksize;congr. 
      apply (eq_from_nth witness);1:rewrite!size_take//=1,2:/#!size_nseq!max_ler/#.
      rewrite!size_take//=1:/#!size_nseq!max_ler 1:/#.
      pose o:=if _ then _ else _;cut->/={o}:o = k - size bl by smt().
      by progress;rewrite!nth_take//= 1,2:/# !nth_nseq//=/#.
    case(j < size bl + i - 2)=>hj. 
    - cut:=help j _;1:smt(size_cat size_nseq).
      move=>[]b c[].
      cut->:nth witness (format bl (i - 1)) j = nth witness (format bl i) j. 
      + by rewrite-(nth_take witness (j+1)) 1,2:/# eq_sym -(nth_take witness (j+1)) 1,2:/# !h//=/#.
      rewrite h 1:/# h 1:/# => -> h';exists b c=>//=;rewrite h'/=get_setE/=. 
      smt(size_take size_cat size_nseq).
    cut->>/=:j = size (format bl (i-1)) by smt(size_cat size_nseq).
    rewrite get_setE/=.
    cut h':size (format bl (i-1)) = size bl + i - 2 by smt(size_cat size_nseq).
    rewrite h'/=.
    cut h'':(size bl + i - 1) = size (format bl i) by smt(size_cat size_nseq).
    rewrite h'' take_size/=-h 1:/# -h' take_size.
    rewrite nth_cat h';cut->/=:! size bl + i - 2 < size bl by smt().
    by rewrite nth_nseq 1:/#; exists sa sc; smt(Block.WRing.AddMonoid.addm0 domE). 
  qed.

  local lemma take_nseq (a : 'a) i j :
      take j (nseq i a) = if j <= i then nseq j a else nseq i a.
  proof.
  case(0 <= j)=>hj0;last first.
  + rewrite take_le0 1:/#;smt(nseq0_le).
  case(j <= i)=>hij//=;last smt(take_oversize size_nseq). 
  apply(eq_from_nth witness).
  + smt(size_take size_nseq).
  smt(size_nseq size_take nth_take nth_nseq).
  qed.

  local lemma take_format (bl : block list) n i :
      0 < n =>
      0 <= i < size bl + n =>
      take i (format bl n) = 
      if i <= size bl then take i bl else format bl (i - size bl + 1).
  proof.
  move=>Hn0[]Hi0 Hisize;rewrite take_cat take_nseq.
  case(i < size bl)=>//=[/#|H_isize'].
  cut->/=:i - size bl <= n - 1 by smt().
  case(i = size bl)=>[->>|H_isize'']//=;1:by rewrite nseq0 take_size cats0.
  smt().
  qed.


  local lemma equiv_sponge (D <: DISTINGUISHER {P, Redo, C, SLCommon.C}) :
    equiv [ GReal(A(D)).main
      ~ NIndif(Squeeze(SqueezelessSponge(P)),P,DRestr(D)).main
      : ={glob D} ==> ={res, glob D, glob P, C.c} /\ SLCommon.C.c{1} <= C.c{2} <= max_size].
  proof.
  proc;inline*;sp;wp.
  call(: ={Redo.prefixes, glob P, C.c} /\ C.c{1} <= max_size /\
    INV_Real SLCommon.C.c{1} C.c{2} Perm.m{1} Perm.mi{1} Redo.prefixes{1});auto;last first.
  + progress. 
    + exact max_ge0.
    + by split=>//=;1:split;smt(mem_empty in_fset0 mem_set get_setE).
    by case:H2=>//=. 
  + by proc;inline*;auto;sp;if;auto;sp;if;auto;
      smt(INV_Real_addm_mi INV_Real_incr supp_dexcepted).
  + proc;inline*;auto;sp;if;auto;sp;if;auto;progress.
    + apply INV_Real_incr=>//=.
      apply INV_Real_addm_mi=>//=.
      + case:H0=>H_c H_m_p H_invm;rewrite (invm_dom_rng _ _ H_invm)//=. 
        by move:H3;rewrite supp_dexcepted.
      case:H0=>H_c H_m_p H_invm;cut<-//:=(invm_dom_rng Perm.mi{2} Perm.m{2}). 
      by rewrite invmC.
    + exact INV_Real_incr.
  + proc;inline*;sp;if;auto.
    swap 6;wp;sp=>/=;if;auto;last by progress;split;case:H0=>//=;smt(size_ge0).
    conseq(: p{2} = bl{2} /\ n{2} = nb{2} /\ lres{2} = [] /\ b{2} = b0 /\
    i{2} = 0 /\ p{1} = bl{1} /\ n{1} = nb{1} /\ lres{1} = [] /\ b{1} = b0 /\
    i{1} = 0 /\ z{2} = [] /\ z{1} = [] /\ ={bl, nb} /\ ={Redo.prefixes} /\
    ={Perm.mi, Perm.m} /\ ={C.c} /\
    INV_Real SLCommon.C.c{1} C.c{2} Perm.m{1} Perm.mi{1} Redo.prefixes{1} /\
    C.c{1} + size bl{1} + max (nb{1} - 1) 0 <= max_size /\ valid p{1}
  ==> ={lres} /\ ={Redo.prefixes} /\ ={Perm.mi, Perm.m} /\
    C.c{1} + size bl{1} + max (nb{1} - 1) 0 =
    C.c{2} + size bl{2} + max (nb{2} - 1) 0 /\
    INV_Real SLCommon.C.c{1} (C.c{2} + size bl{2} + max (nb{2} - 1) 0)
    Perm.m{1} Perm.mi{1} Redo.prefixes{1});progress.
    sp.
    seq 2 2:(={i,n,p,lres,nb,bl,b,glob P,glob C,glob Redo}
           /\  INV_Real SLCommon.C.c{1} (C.c{2} + size bl{2})
                 Perm.m{1} Perm.mi{1} Redo.prefixes{1}
           /\  (n,p){1} = (nb,bl){1} /\ lres{1} = [] /\ i{1} = 0
           /\  valid p{1}
           /\ Redo.prefixes.[p]{1} = Some (b,sc){1}).
    + exists* Redo.prefixes{1},SLCommon.C.c{1};elim* => pref count/=.
      wp;conseq(:_==> ={i0,p0,i,p,n,nb,bl,sa,lres,C.c,glob Redo,glob Perm}
            /\ n{1} = nb{1} /\ p{1} = bl{1} /\ p0{1} = p{1} /\ i0{1} = size p{1}
            /\ Redo.prefixes{1}.[take i0{1} p{1}] = Some (sa{1},sc{1})
            /\ INV_Real count C.c{1} Perm.m{1} Perm.mi{1} pref
            /\ (forall l, l \in Redo.prefixes{1} => 
                 l \in pref \/ (exists j, 0 < j <= i0{2} /\ l = take j p{1}))
            /\ (forall l, l \in pref => pref.[l] = Redo.prefixes{1}.[l])
            /\ SLCommon.C.c{1} <= count + i0{1} <= C.c{1} + i0{1}
            /\ (forall j, 0 <= j < i0{1} =>
                 exists b c, Redo.prefixes{1}.[take j p{1}] = Some (b,c) /\
                 Perm.m{1}.[(b +^ nth witness p{1} j, c)] = 
                 Redo.prefixes{1}.[take (j+1) p{1}]));
        progress. 
      - cut inv0:=H3;cut[]h_c1c2[]Hmp0 Hmp1 Hinvm:=inv0;split=>//=.
        - case:inv0;smt(size_ge0).
        split=>//=.
        - smt(domE).
        - move=>l H_dom_R i []Hi0 Hisize;cut:=H4 l H_dom_R.
          case(l \in Redo.prefixes{2})=>H_in_pref//=.
          * cut:=Hmp1 l H_in_pref i _;rewrite//=.
            rewrite ?H5//=;1:smt(domE).
            case(i+1 < size l)=>h;1:smt(domE).
            by rewrite take_oversize 1:/#.
          move=>[]j[][]hj0 hjsize ->>.
          cut:=Hisize;rewrite size_take 1:/#.
          pose k:=if _ then _ else _;cut->>Hij{k}:k=j by rewrite/#.
          by rewrite!take_take!min_lel 1,2:/# nth_take 1,2:/#;smt(domE).
        - smt(get_setE oget_some domE take_oversize).
      while( ={i0,p0,i,p,n,nb,bl,sa,sc,lres,C.c,glob Redo,glob Perm}
        /\ n{1} = nb{1} /\ p{1} = bl{1} /\ p0{1} = p{1} /\ 0 <= i0{1} <= size p{1}
        /\ Redo.prefixes{1}.[take i0{1} p{1}] = Some (sa{1},sc{1})
        /\ INV_Real count C.c{1} Perm.m{1} Perm.mi{1} pref
        /\ (forall l, l \in Redo.prefixes{1} => 
             l \in pref \/ (exists j, 0 < j <= i0{2} /\ l = take j p{1}))
        /\ (forall l, l \in pref => pref.[l] = Redo.prefixes{1}.[l])
        /\ SLCommon.C.c{1} <= count + i0{1} <= C.c{1} + i0{1}
        /\ (i0{1} < size p0{1} => 
             take (i0{1}+1) p{1} \in Redo.prefixes{1} =>
             Redo.prefixes{1} = pref)
        /\ all_prefixes Redo.prefixes{1}
        /\ (forall j, 0 <= j < i0{1} =>
             exists b c, Redo.prefixes{1}.[take j p{1}] = Some (b,c) /\
             Perm.m{1}.[(b +^ nth witness p{1} j, c)] = 
             Redo.prefixes{1}.[take (j+1) p{1}]));last first.
      + auto;progress.
        - exact size_ge0.
        - by rewrite take0;cut[]_[]->//=:=H.
        - smt().
        - by cut[]->//=:=H.
        - smt(all_prefixes_of_INV_real).
        - smt().
        - smt().
      if;auto;progress.
      - smt().
      - smt().
      - smt(domE).
      - smt(domE).
      - smt().
      - smt().
      - smt(all_prefixes_of_INV_real domE take_take size_take).
      - case(j < i0{2})=>hj;1:smt().
        cut<<-/=:j = i0{2} by smt().
        cut->>:=H7 H10 H12.
        cut[]_[]hmp0 hmp1 _:=H2.
        cut[]b3 c3:=hmp1 _ H12 j _;1:smt(size_take).
        smt(take_take nth_take size_take).
      sp;if;auto;progress. 
      - smt().
      - smt().
      - smt(get_setE domE).
      - rewrite INV_Real_addm_mi//=;smt(supp_dexcepted). 
      - smt(mem_set).
      - smt(get_setE domE).
      - smt().
      - smt().
      - move:H17;apply absurd=>//=_;rewrite mem_set.
        pose x:=_ = _;cut->/={x}:x=false by smt(size_take).
        move:H12;apply absurd=>//= hpref.
        have:= H8 _ hpref (i0{2}+1).
        smt(mem_set take_take size_take).
      - move=>l;rewrite!mem_set;case=>[H_dom i|->>]/=. 
        * by rewrite mem_set;smt().
        move=>j; case(0 <= j)=>hj0; rewrite mem_set.
        * case: (j <= i0{2}) => hjmax; 2:smt(take_oversize size_take).
          left; have-> : take j (take (i0{2}+1) bl{2}) = take j (take i0{2} bl{2}).
          * by rewrite 2!take_take min_lel 1:/# min_lel.
          by apply H8; rewrite domE H1.
        rewrite take_le0 1:/#; left.
        by rewrite-(take0 (take i0{2} bl{2})) H8 domE H1.
      - smt(get_setE domE mem_set).
      - smt(get_setE domE).
      - smt().
      - smt(get_setE domE).
      - smt(mem_set).
      - smt(get_setE domE).
      - smt().
      - smt().
      - move:H15;apply absurd=>//=_;rewrite mem_set.
        pose x:=_ = _;cut->/={x}:x=false by smt(size_take).
        move:H12;apply absurd=>//=.
        cut:=take_take bl{2}(i0{2} + 1)(i0{2} + 1 + 1);rewrite min_lel 1:/# =><-h. 
        by rewrite (H8 _ h).
      - move=>l;rewrite!mem_set;case=>[H_dom|->>]/=;1:smt(mem_set).
        move=>j;rewrite mem_set.
        case(0 <= j)=>hj0; last first. 
        * rewrite take_le0 1:/#; left.
          by rewrite-(take0 (take i0{2} bl{2})) H8 domE H1.
        case(j < i0{2} + 1)=>hjiS;2:smt(domE take_take).
        rewrite take_take/min hjiS//=;left.
        cut:=(take_take bl{2} j i0{2});rewrite min_lel 1:/#=><-.
        smt(all_prefixes_of_INV_real domE).
      - smt(get_setE domE mem_set).
  sp;case(0 < n{1});last first.
  - rcondf{1}1;2:rcondf{2}1;auto;1:smt().
    splitwhile{1} 1 : i + 1 < n;splitwhile{2} 1 : i + 1 < n.
    rcondt{1}2;2:rcondt{2}2;auto;progress.
    + while(i < n);auto.
      by sp;if;auto;sp;while(i < n);auto;if;auto;sp;if;auto.
    + while(i < n);auto.
      by sp;if;auto;sp;while(i < n);auto;if;auto;sp;if;auto.
    rcondf{1}4;2:rcondf{2}4;auto.
    + while(i < n);auto;2:smt().
      by sp;if;auto;sp;while(i < n);auto;if;auto;sp;if;auto.
    + while(i < n);auto;2:smt().
      by sp;if;auto;sp;while(i < n);auto;if;auto;sp;if;auto.
    rcondf{1}4;2:rcondf{2}4;1,2:auto.
    + while(i < n);auto;2:smt().
      by sp;if;auto;sp;while(i < n);auto;if;auto;sp;if;auto.
    + while(i < n);auto;2:smt().
      by sp;if;auto;sp;while(i < n);auto;if;auto;sp;if;auto.
    conseq(:_==> ={i,n,p,lres,nb,bl,b,glob P,glob C,glob Redo}
           /\  INV_Real SLCommon.C.c{1} (C.c{2} + size bl{2} + i{1} - 1)
                 Perm.m{1} Perm.mi{1} Redo.prefixes{1}
           /\  i{1} = n{1});1:smt();wp. 
    conseq(:_==> ={i,n,p,lres,nb,bl,b,glob P,glob C,glob Redo}
           /\  INV_Real SLCommon.C.c{1} (C.c{2} + size bl{2} + i{1})
                 Perm.m{1} Perm.mi{1} Redo.prefixes{1}
           /\  i{1}+1 = n{1});1:smt(). 
    while(={i,n,p,lres,nb,bl,b,glob P,glob C,glob Redo}
           /\  INV_Real SLCommon.C.c{1} (C.c{2} + size bl{2} + i{1})
                 Perm.m{1} Perm.mi{1} Redo.prefixes{1}
           /\  (n,p){1} = (nb,bl){1} /\ 0 < i{1}+1 <= n{1}
           /\  valid p{1}
           /\  (exists c2, Redo.prefixes.[format p (i+1)]{1} = Some (b,c2){1}));
    last by auto;smt(nseq0 cats0). 
  sp;rcondt{1}1;2:rcondt{2}1;auto.
  sp.
  splitwhile{1} 1 : i1 < size p1 - 1;splitwhile{2} 1 : i1 < size p1 - 1.
  rcondt{1}2;2:rcondt{2}2;1,2:by auto;
    while(i1 < size p1);auto;1:if;2:(sp;if);auto;smt(size_cat size_nseq size_ge0).
  rcondf{1}4;2:rcondf{2}4;1,2:by auto;
    seq 1 : (i1 = size p1 - 1);1:(auto;
      while(i1 < size p1);auto;1:if;2:(sp;if);auto;smt(size_cat size_nseq size_ge0));
    if;sp;2:if;auto;smt(size_cat size_nseq size_ge0).
  wp=>//=.
  wp;conseq(:_==> ={sa0,sc0,glob Redo,glob Perm}
          /\ INV_Real SLCommon.C.c{1} (C.c{1} + size bl{2} + i{1}) 
               Perm.m{1} Perm.mi{1} Redo.prefixes{1}
          /\ (format p{1} i{1} \in Redo.prefixes{1})
          /\ exists (c2 : capacity), Redo.prefixes{1}.[format p{1} (i{1}+1)] = Some (sa0{1}, c2));progress.
  + smt(size_ge0).
  + smt(size_ge0).
  + smt().
  seq 1 1 : (={nb,bl,n,p,p1,i,i1,lres,sa0,sc0,C.c,glob Redo,glob Perm}
          /\ n{1} = nb{1} /\ p{1} = bl{1} /\ p1{1} = format p{1} (i{1}+1)
          /\ 1 <= i{1} < n{1} /\ valid p{1} /\ i1{1} = size p1{1} - 1
          /\ Redo.prefixes{1}.[format p{1} i{1}] = Some (sa0{1},sc0{1})
          /\ INV_Real SLCommon.C.c{1} (C.c{1} + size bl{2} + i{1} - 1) Perm.m{1} Perm.mi{1}
               Redo.prefixes{1});last first.
  + if;auto;progress. 
    - by split;case:H3=>//=;smt().
    - by rewrite domE H2//=.
    - move:H4;rewrite take_size /= domE=> h.
      exists (oget Redo.prefixes{2}.[format bl{2} (i{2} + 1)]).`2; move: h.
      by case: (Redo.prefixes{2}.[format bl{2} (i{2} + 1)]); smt().
    sp;if;auto;progress.
    - move:H4 H5;rewrite!get_setE/= nth_last/=take_size.
      rewrite last_cat last_nseq 1:/# Block.WRing.addr0;progress. 
      cut//=:=lemma2'(SLCommon.C.c{1} + 1)(C.c{2} + size bl{2} + i{2})
        Perm.m{2}.[(sa0_R, sc0{2}) <- y2L] Perm.mi{2}.[y2L <- (sa0_R, sc0{2})]
        Redo.prefixes{2} bl{2} (i{2}+1) sa0_R sc0{2}.
      rewrite H1/=!mem_set/=H4/=H2/=get_setE/=.
      cut->->//=:y2L = (y2L.`1, y2L.`2);1,-1:smt().
      rewrite INV_Real_addm_mi//=;2:smt(supp_dexcepted). 
      by cut:=H3=>hinv0;split;case:hinv0=>//=/#.
    - by rewrite mem_set//=take_size domE H2.
    - by rewrite!get_setE take_size/=;smt().
    - move:H4 H5;rewrite nth_last take_size.
      rewrite last_cat last_nseq 1:/# Block.WRing.addr0;progress. 
      pose a:=(_, _);cut->/={a}:a = oget Perm.m{2}.[(sa0_R, sc0{2})] by smt().
      apply lemma2'=>//=;first cut:=H3=>hinv0;split;case:hinv0=>//=/#.
      smt().
    - by rewrite mem_set//=take_size;smt(domE).
    - by rewrite!get_setE/=take_size/=;smt().
  alias{1} 1 pref = Redo.prefixes;sp;alias{1} 1 count = SLCommon.C.c.
  alias{1} 1 pm = Perm.m;sp;alias{1} 1 pmi = Perm.mi;sp.
  conseq(:_==> ={nb,bl,n,p,p1,i,i1,lres,sa0,sc0,C.c,glob Redo,glob Perm}
        /\ pmi{1} = Perm.mi{1} /\ pm{1} = Perm.m{1}
        /\ pref{1} = Redo.prefixes{1} /\ SLCommon.C.c{1} = count{1}
        /\ n{1} = nb{1} /\ p{1} = bl{1} /\ p1{1} = format p{1} (i{1}+1)
        /\ i1{1} = size p1{1} - 1
        /\ Redo.prefixes{1}.[format p{1} (i1{1} - size p{1} + 1)] = 
             Some (sa0{1}, sc0{1}));progress. 
  + smt().
  + by move: H8; rewrite size_cat size_nseq /= max_ler /#.
  + move:H8;rewrite size_cat size_nseq/=/max H0/=;smt().
  splitwhile{1}1:i1 < size p;splitwhile{2}1:i1 < size p.
  while(={nb,bl,n,p,p1,i,i1,lres,sa0,sc0,C.c,glob Redo,glob Perm}
        /\ INV_Real SLCommon.C.c{1} (C.c{1} + size bl{2} + i{1} - 1)
             Perm.m{1} Perm.mi{1} Redo.prefixes{1}
        /\ pmi{1} = Perm.mi{1} /\ pm{1} = Perm.m{1}
        /\ pref{1} = Redo.prefixes{1} /\ SLCommon.C.c{1} = count{1}
        /\ n{1} = nb{1} /\ p{1} = bl{1} /\ p1{1} = format p{1} (i{1}+1)
        /\ (format p{1} i{1} \in Redo.prefixes{1})
        /\ size p{1} <= i1{1} <= size p1{1} - 1 /\ valid p{1}
        /\ Redo.prefixes{1}.[format p{1} (i1{1} - size p{1} + 1)] = 
             Some (sa0{1}, sc0{1})).
  + rcondt{1}1;2:rcondt{2}1;auto;progress.
    + cut->:take (i1{m} + 1) (format bl{m} (i{m} + 1)) = 
            take (i1{m} + 1) (format bl{m} i{m});2:smt(all_prefixes_of_INV_real).
      smt(take_format size_ge0 size_eq0 valid_spec size_cat size_nseq).
    + cut->:take (i1{hr} + 1) (format bl{hr} (i{hr} + 1)) = 
            take (i1{hr} + 1) (format bl{hr} i{hr});2:smt(all_prefixes_of_INV_real).
      smt(take_format size_ge0 size_eq0 valid_spec size_cat size_nseq).
    + smt().    
    + smt(size_cat size_nseq).
    + have->:take (i1{2} + 1) (format bl{2} (i{2} + 1)) = 
             take (i1{2} + 1) (format bl{2} i{2}).
      - smt(take_format size_ge0 size_eq0 valid_spec size_cat size_nseq).
      have->:format bl{2} (i1{2} + 1 - size bl{2} + 1) =
             take (i1{2} + 1) (format bl{2} i{2}).
      - smt(take_format size_ge0 size_eq0 valid_spec size_cat size_nseq).
      cut all_pref:=all_prefixes_of_INV_real _ _ _ _ _ H.
      by have:=all_pref _ H0 (i1{2}+1); rewrite domE; smt().
  conseq(:_==> ={nb,bl,n,p,p1,i,i1,lres,sa0,sc0,C.c,glob Redo,glob Perm}
        /\ INV_Real SLCommon.C.c{1} (C.c{1} + size bl{2} + i{1} - 1)
             Perm.m{1} Perm.mi{1} Redo.prefixes{1}
        /\ pmi{1} = Perm.mi{1} /\ pm{1} = Perm.m{1}
        /\ pref{1} = Redo.prefixes{1} /\ SLCommon.C.c{1} = count{1}
        /\ n{1} = nb{1} /\ p{1} = bl{1} /\ p1{1} = format p{1} (i{1}+1)
        /\ (format p{1} i{1} \in Redo.prefixes{1})
        /\ i1{1} = size p{1} /\ valid p{1}
        /\ Redo.prefixes{1}.[take i1{1} p{1}] = Some (sa0{1}, sc0{1}));
    1:smt(size_cat size_nseq nseq0 cats0 take_size).
  while(={nb,bl,n,p,p1,i,i1,lres,sa0,sc0,C.c,glob Redo,glob Perm}
        /\ INV_Real SLCommon.C.c{1} (C.c{1} + size bl{2} + i{1} - 1)
             Perm.m{1} Perm.mi{1} Redo.prefixes{1}
        /\ pmi{1} = Perm.mi{1} /\ pm{1} = Perm.m{1}
        /\ pref{1} = Redo.prefixes{1} /\ SLCommon.C.c{1} = count{1}
        /\ n{1} = nb{1} /\ p{1} = bl{1} /\ p1{1} = format p{1} (i{1}+1)
        /\ (format p{1} i{1} \in Redo.prefixes{1})
        /\ 0 <= i1{1} <= size p{1} /\ valid p{1}
        /\ Redo.prefixes{1}.[take i1{1} p{1}] = Some (sa0{1}, sc0{1}));last first.
  + auto;progress.
    - smt().
    - cut[]_[]:=H;smt(domE).
    - exact size_ge0.
    - cut[]_[]:=H;smt(domE take0).
    - smt(size_cat size_nseq).
  rcondt{1}1;2:rcondt{2}1;auto;progress.
  - cut->:take (i1{m} + 1) (format bl{m} (i{m} + 1)) = 
          take (i1{m} + 1) (format bl{m} i{m});2:smt(all_prefixes_of_INV_real).
    smt(take_format size_ge0 size_eq0 valid_spec size_cat size_nseq).
  - cut->:take (i1{hr} + 1) (format bl{hr} (i{hr} + 1)) = 
          take (i1{hr} + 1) (format bl{hr} i{hr});2:smt(all_prefixes_of_INV_real).
    smt(take_format size_ge0 size_eq0 valid_spec size_cat size_nseq).
  - smt().
  - smt().
  - cut->:take (i1{2} + 1) (format bl{2} (i{2} + 1)) = 
          take (i1{2} + 1) (format bl{2} i{2}) 
      by smt(take_format size_ge0 size_eq0 valid_spec size_cat size_nseq).
    cut->:take (i1{2} + 1) bl{2} = 
          take (i1{2} + 1) (format bl{2} i{2})
      by smt(take_cat take_le0 cats0).
    smt(all_prefixes_of_INV_real).
  qed.


  local lemma lemma4 c c' m mi p bl i sa sc:
      INV_Real c c' m mi p =>
      0 < i =>
      p.[format bl i] = Some (sa,sc) =>
      format bl (i+1) \in p =>
      p.[format bl (i+1)] = m.[(sa,sc)].
  proof.
  move=>inv0 H_i0 H_p_i H_dom_iS.
  cut[]_[]_ hmp1 _ :=inv0.
  cut:=hmp1 (format bl (i+1)) H_dom_iS=>help. 
  cut:=help (size (format bl i)) _;1:smt(size_ge0 size_cat size_nseq).
  move=>[]b3 c3;rewrite!take_format;..4:smt(size_ge0 size_cat size_nseq).
  cut->/=:!size (format bl i) + 1 <= size bl by smt(size_cat size_nseq size_ge0).
  rewrite nth_cat.
  cut->/=:!size (format bl i) < size bl by smt(size_cat size_ge0).
  rewrite nth_nseq 1:size_cat 1:size_nseq 1:/#.
  pose x:=if _ then _ else _;cut->/={x}:x = format bl i.
  + rewrite/x;case(i = 1)=>//=[->>|hi1].
    - by rewrite/format/=nseq0 cats0//=take_size.
    by rewrite size_cat size_nseq/#.
  pose x:=List.size _ + 1 - List.size _ + 1;cut->/={x}:x=i+1
    by rewrite/x size_cat size_nseq;smt().
  rewrite H_p_i=>[]/=[][]->>->>. 
  by rewrite Block.WRing.addr0=>H_pm;rewrite H_pm/=. 
  qed.

  local lemma lemma_3 c1 c2 m mi p bl b (sa:block) sc:
      INV_Real c1 c2 m mi p =>
      (sa +^ b,sc) \in m =>
      ! rcons bl b \in p =>
      p.[bl] = Some (sa,sc) =>
      INV_Real c1 c2 m mi p.[rcons bl b <- oget m.[(sa +^ b,sc)]].
  proof.
  move=>inv0 H_dom_m H_dom_p H_p_val.
  split;cut[]//=_[] hmp0 hmp1 hinvm:=inv0;split=>//=.
  + by rewrite get_setE;smt(size_cat size_nseq size_ge0).
  + move=>l;rewrite mem_set;case;1:smt(all_prefixes_of_INV_real get_setE).
    move=>->>j[]hj0 hjsize;rewrite get_setE/=.
    cut:=hmp1 bl;rewrite domE H_p_val/==>help.
    cut->/=:!take j (rcons bl b) = rcons bl b by smt(size_take).
    move:hjsize;rewrite size_rcons=>hjsize.
    rewrite-cats1 !take_cat.
    pose x := if _ then _ else _;cut->/={x}: x = take j bl by smt(take_le0 cats0 take_size).
    rewrite nth_cat.
    case(j < size bl)=>//=hj;last first.
    + cut->>/=:j = size bl by smt().
      by rewrite take_size H_p_val/=;exists sa sc=>//=;smt(get_setE).
    cut->/=:j + 1 - size bl <= 0 by smt().
    rewrite cats0.
    pose x := if _ then _ else _;cut->/={x}: x = take (j+1) bl by smt(take_le0 cats0 take_size).
    cut:=hmp1 bl;rewrite domE H_p_val/==>hep.
    cut:=hep j _;rewrite//=;smt(get_setE size_cat size_take).
  qed.



  local lemma squeeze_squeezeless (D <: DISTINGUISHER {P, Redo, C, SLCommon.C}) :
    equiv [ NIndif(Squeeze(SqueezelessSponge(P)),P,DRestr(D)).main
        ~ RealIndif(Sponge,P,DRestr(D)).main
        : ={glob D} ==> ={res, glob P, glob D, C.c} /\ C.c{1} <= max_size].
  proof.
  proc;inline*;sp;wp. 
  call(: ={glob Perm,C.c} /\ C.c{1} <= max_size
      /\ INV_Real 0 C.c{1} Perm.m{1} Perm.mi{1} Redo.prefixes{1});auto;last first.
  + progress.
    + exact max_ge0.
    split=>//=;1:split=>//=;smt(get_setE mem_empty emptyE in_fset0 mem_set). 
  + proc;inline*;auto;sp;if;auto;sp;if;auto;progress.
    - by rewrite INV_Real_addm_mi;2..:smt(supp_dexcepted);split;case:H0=>//=;smt().
    - by split;case:H0=>//=;smt().
  + proc;inline*;auto;sp;if;auto;sp;if;auto;progress.
    - rewrite INV_Real_addm_mi;1: by split;case:H0=>//=;smt().
      * case:H0;smt(invm_dom_rng invmC supp_dexcepted).
      case:H0;smt(invm_dom_rng invmC supp_dexcepted).
    - by split;case:H0=>//=;smt(). 
  proc;inline*;sp;auto;if;auto;sp;if;auto;
    last by progress;split;case:H0=>//=;smt(size_ge0).
  conseq(: (exists (c_R : int),
      C.c{2} = c_R + size bl{2} + max (nb{2} - 1) 0 /\ xs{2} = bl{2} /\
      n{2} = nb{2} /\ z0{2} = [] /\ sc{2} = c0 /\ sa{2} = b0 /\ i{2} = 0 /\
      exists (c_L : int), C.c{1} = c_L + size bl{1} + max (nb{1} - 1) 0 /\
      p{1} = bl{1} /\ n{1} = nb{1} /\ lres{1} = [] /\ b{1} = b0 /\
      i{1} = 0 /\ z{2} = [] /\ z{1} = [] /\ ={bl, nb} /\
      ={Perm.mi, Perm.m} /\ c_L = c_R /\
      INV_Real 0 c_L Perm.m{1} Perm.mi{1} Redo.prefixes{1} /\ valid p{1})
    ==> lres{1} = z0{2} /\ ={Perm.mi, Perm.m} /\ ={C.c} /\
      INV_Real 0 C.c{1} Perm.m{1} Perm.mi{1} Redo.prefixes{1});1,2:smt().
  sp.
  seq 2 1 : (={glob P, i, n, C.c,sa,sc}
    /\ b{1} = sa{2} /\ Redo.prefixes.[p]{1} = Some (sa,sc){2}
    /\ lres{1} = z0{2} /\ i{1} = 0 /\ valid p{1}
    /\ INV_Real 0 C.c{1} Perm.m{1} Perm.mi{1} Redo.prefixes{1}).
  + conseq(:_==> ={glob P, n, C.c,sa,sc} /\ b{1} = sa{2} /\ i0{1} = size p0{1}
        /\ Redo.prefixes{1}.[take i0{1} p0{1}] = Some (sa{1}, sc{1})
        /\ lres{1} = z0{2} /\ xs{2} = drop i0{1} p0{1}
        /\ INV_Real 0 C.c{1} Perm.m{1} Perm.mi{1} Redo.prefixes{1});1:smt(take_size drop_size).
    wp;while(={glob P, n, C.c,sa,sc} /\ sa{1} = sa{2} /\ sc{1} = sc{2}
        /\ 0 <= i0{1} <= size p0{1} 
        /\ Redo.prefixes{1}.[take i0{1} p0{1}] = Some (sa{1}, sc{1})
        /\ lres{1} = z0{2} /\ xs{2} = drop i0{1} p0{1}
        /\ INV_Real 0 C.c{1} Perm.m{1} Perm.mi{1} Redo.prefixes{1}).
    + if{1};auto.
      + sp;rcondf{2}1;auto;progress.
        + rewrite head_nth nth_drop//=.
          cut[]_[]_ hmp1 _ :=H2;cut:=hmp1 _ H5 i0{m} _;1:smt(size_take).
          move=>[]b3 c3;rewrite!take_take!nth_take 1,2:/# !min_lel//= 1:/#.
          rewrite H1=>//=[][][]->>->>.
          by rewrite nth_onth (onth_nth b0)//=;smt(domE).
        + rewrite head_nth nth_drop//=.
          cut[]_[]_ hmp1 _ :=H2;cut:=hmp1 _ H5 i0{1} _;1:smt(size_take).
          move=>[]b3 c3;rewrite!take_take!nth_take 1,2:/# !min_lel//= 1:/#.
          rewrite H1=>//=[][][]->>->>.
          by rewrite nth_onth (onth_nth b0)//=;smt(domE).
        + rewrite head_nth nth_drop//=.
          cut[]_[]_ hmp1 _ :=H2;cut:=hmp1 _ H5 i0{1} _;1:smt(size_take).
          move=>[]b3 c3;rewrite!take_take!nth_take 1,2:/# !min_lel//= 1:/#.
          rewrite H1=>//=[][][]->>->>.
          by rewrite nth_onth (onth_nth b0)//=;smt(domE).
        + rewrite head_nth nth_drop//=.
          cut[]_[]_ hmp1 _ :=H2;cut:=hmp1 _ H5 i0{1} _;1:smt(size_take).
          move=>[]b3 c3;rewrite!take_take!nth_take 1,2:/# !min_lel//= 1:/#.
          rewrite H1=>//=[][][]->>->>.
          by rewrite nth_onth (onth_nth b0)//=;smt(domE).
        + rewrite head_nth nth_drop//=.
          cut[]_[]_ hmp1 _ :=H2;cut:=hmp1 _ H5 i0{1} _;1:smt(size_take).
          move=>[]b3 c3;rewrite!take_take!nth_take 1,2:/# !min_lel//= 1:/#.
          rewrite H1=>//=[][][]->>->>.
          by rewrite nth_onth (onth_nth b0)//=;smt(domE).
        + smt().
        + smt().
        + smt().
        + smt(behead_drop drop_add).
        + smt(size_drop size_eq0).
        + smt(size_drop size_eq0).
      sp=>//=. 
      if;auto;progress.
      + by rewrite head_nth nth_drop //=nth_onth (onth_nth witness)//=.
      + by move:H6;rewrite head_nth nth_drop //=nth_onth (onth_nth witness)//=.
      + by rewrite head_nth nth_drop //=nth_onth (onth_nth b0)//=. 
      + by rewrite head_nth nth_drop //=nth_onth (onth_nth b0)//=. 
      + by rewrite head_nth nth_drop //=nth_onth (onth_nth b0)//=. 
      + by rewrite head_nth nth_drop //=nth_onth (onth_nth b0)//=. 
      + by rewrite head_nth nth_drop //=nth_onth (onth_nth b0)//=. 
      + by rewrite head_nth nth_drop //=nth_onth (onth_nth b0)//=. 
      + smt().
      + smt().
      + by rewrite get_setE/=.
      + by rewrite behead_drop drop_add. 
      + rewrite!get_setE/=.
        cut:=lemma_3 0 C.c{2}Perm.m{2}.[(sa{2} +^ nth witness p0{1} i0{1}, sc{2}) <- yL]
          Perm.mi{2}.[yL <- (sa{2} +^ nth witness p0{1} i0{1}, sc{2})] Redo.prefixes{1}
          (take i0{1} p0{1}) (nth witness p0{1} i0{1}) sa{2} sc{2}.
        rewrite!mem_set/=-take_nth//=H5/=H1/=get_setE/=.
        cut->->//=:(yL.`1, yL.`2) = yL by smt().
        rewrite INV_Real_addm_mi=>//=;smt(supp_dexcepted).
      + smt(size_drop size_eq0).
      + smt(size_drop size_eq0).
      + by rewrite head_nth nth_drop //=nth_onth (onth_nth b0)//=. 
      + by rewrite head_nth nth_drop //=nth_onth (onth_nth b0)//=. 
      + by rewrite head_nth nth_drop //=nth_onth (onth_nth b0)//=. 
      + by rewrite head_nth nth_drop //=nth_onth (onth_nth b0)//=. 
      + smt().
      + smt().
      + by rewrite get_setE.
      + by rewrite behead_drop drop_add.
      + rewrite(take_nth witness)//=. 
        cut:=lemma_3 0 C.c{2} Perm.m{2} Perm.mi{2} Redo.prefixes{1}
          (take i0{1} p0{1}) (nth witness p0{1} i0{1}) sa{2} sc{2}.
        by rewrite-take_nth//= H5/=H1/=H2/=H6/=;smt().
      + smt(size_drop size_eq0).
      + smt(size_drop size_eq0).
    auto;progress.
    + exact size_ge0.
    + by rewrite take0;cut[]_[]->:=H.
    + by rewrite drop0.
    + split;case:H=>//=;smt(size_ge0).
    + smt(size_ge0 size_eq0).
    + smt(size_ge0 size_eq0).
    + smt().
  case(0 < n{1});last by rcondf{1}1;2:rcondf{2}1;auto;progress.
  splitwhile{1} 1 : i + 1 < n;splitwhile{2} 1 : i + 1 < n.
  rcondt{1}2;2:rcondt{2}2;auto;progress.
  + by while(i<n);auto;sp;if;auto;sp;while(i<n);auto;if;auto;sp;if;auto.
  + by while(i<n);auto;sp;if;auto;sp;if;auto.
  rcondf{1}4;2:rcondf{2}4;auto;progress.
  + by while(i<n);auto;2:smt();sp;if;auto;sp;while(i<n);auto;if;auto;sp;if;auto.
  + by while(i<n);auto;2:smt();sp;if;auto;sp;if;auto.
  rcondf{1}4;2:rcondf{2}4;auto;progress.
  + by while(i<n);auto;2:smt();sp;if;auto;sp;while(i<n);auto;if;auto;sp;if;auto.
  + by while(i<n);auto;2:smt();sp;if;auto;sp;if;auto.
  conseq(:_==> ={i,n,glob P,C.c} /\ lres{1} = z0{2} /\ b{1} = sa{2}
      /\ INV_Real 0 C.c{1} Perm.m{1} Perm.mi{1} Redo.prefixes{1}
      /\ Redo.prefixes{1}.[format p{1} (i{1}+1)] = Some (sa,sc){2});progress.
  while(={i,n,glob P,C.c} /\ lres{1} = z0{2} /\ b{1} = sa{2} /\ 0 <= i{1} < n{1}
      /\ INV_Real 0 C.c{1} Perm.m{1} Perm.mi{1} Redo.prefixes{1} /\ valid p{1}
      /\ Redo.prefixes{1}.[format p{1} (i{1}+1)] = Some (sa,sc){2});last first.
  + auto;1:smt(nseq0 cats0).
  sp;if;auto;sp.
  splitwhile{1}1: i1 < size p1 - 1.
  rcondt{1}2;2:rcondf{1}4;1,2:auto.
  + while(i1 < size p1);auto;2:smt(size_cat size_nseq size_ge0 size_eq0 valid_spec).
    by if;auto;1:smt();sp;if;auto;progress;smt().
  + seq 1 : (i1 = size p1 - 1).
    - while(i1 < size p1);auto;2:smt(size_cat size_nseq size_ge0 size_eq0 valid_spec).
      by if;auto;1:smt();sp;if;auto;progress;smt().
    if;auto;sp;if;auto;smt().
  seq 1 0 : (={i,n,glob P,C.c} /\ x0{2} = (sa{2}, sc{2}) /\ 0 < i{1} < n{1}
          /\ p1{1} = format p{1} (i{1} + 1) /\ (sa0,sc0){1} = x0{2}
          /\ i1{1} = size p{1} + i{1} - 1 /\ lres{1} = z0{2} /\ valid p{1}
          /\ Redo.prefixes{1}.[format p{1} i{1}] = Some (sa{2}, sc{2})
          /\ INV_Real 0 C.c{1} Perm.m{1} Perm.mi{1} Redo.prefixes{1}
          /\ valid p{1});last first.
  + if{1};auto.
    + rcondf{2}1;auto;progress.
      + move:H5;rewrite take_oversize;1:rewrite size_cat size_nseq max_ler/#.
        move=>H_dom;rewrite domE. 
        by cut<-:=lemma4 _ _ _ _ _ _ _ _ _ H3 H H2 H_dom;rewrite-domE.
      + move:H5;rewrite take_oversize;1:rewrite size_cat size_nseq max_ler/#;move=>H_dom.
        by cut:=lemma4 _ _ _ _ _ _ _ _ _ H3 H H2 H_dom;smt(domE).
      + smt().
      + move:H5;rewrite take_oversize;1:rewrite size_cat size_nseq max_ler/#;move=>H_dom.
        by cut:=lemma4 _ _ _ _ _ _ _ _ _ H3 H H2 H_dom;smt(domE).
    sp;if;auto;progress.
    + move:H6;rewrite nth_cat nth_nseq;1:smt(size_ge0).
      cut->/=:!size p{1} + i{2} - 1 < size p{1} by smt().
      by rewrite Block.WRing.addr0.
    + move:H6;rewrite nth_cat nth_nseq;1:smt(size_ge0).
      cut->/=:!size p{1} + i{2} - 1 < size p{1} by smt().
      by rewrite Block.WRing.addr0.
    + move:H6;rewrite nth_cat nth_nseq;1:smt(size_ge0).
      cut->/=:!size p{1} + i{2} - 1 < size p{1} by smt().
      by rewrite Block.WRing.addr0.
    + move:H6;rewrite nth_cat nth_nseq;1:smt(size_ge0).
      cut->/=:!size p{1} + i{2} - 1 < size p{1} by smt().
      by rewrite Block.WRing.addr0.
    + move:H6;rewrite nth_cat nth_nseq;1:smt(size_ge0).
      cut->/=:!size p{1} + i{2} - 1 < size p{1} by smt().
      by rewrite Block.WRing.addr0.
    + smt().
    + move:H5 H6;rewrite nth_cat nth_nseq;1:smt(size_ge0).
      cut->/=:!size p{1} + i{2} - 1 < size p{1} by smt().
      rewrite Block.WRing.addr0 !get_setE/= take_oversize;1:rewrite size_cat size_nseq/#.
      move=>H_dom_iS H_dom_p.
      cut:=lemma2' 0 C.c{2} Perm.m{2}.[(sa{2}, sc{2}) <- y0L]
          Perm.mi{2}.[y0L <- (sa{2}, sc{2})] Redo.prefixes{1}
          p{1} (i{2}+1) sa{2} sc{2} _ _ H4 _ H_dom_iS.
      + by rewrite INV_Real_addm_mi//=;smt(supp_dexcepted).
      + smt().
      + by rewrite mem_set.
      by rewrite!get_setE/=H2/=;smt().
    + by rewrite!get_setE/=take_oversize//=size_cat size_nseq/#.
    + rewrite nth_cat;cut->/=:! size p{1} + i{2} - 1 < size p{1} by smt().
      by rewrite nth_nseq//=1:/# Block.WRing.addr0.
    + smt().
    + move:H5 H6;rewrite take_oversize 1:size_cat 1:size_nseq 1:/#.
      rewrite nth_cat;cut->/=:! size p{1} + i{2} - 1 < size p{1} by smt().
      rewrite nth_nseq//=1:/# Block.WRing.addr0 =>h1 h2.
      by cut:=lemma2' 0 C.c{2} Perm.m{2} Perm.mi{2} Redo.prefixes{1}
          p{1} (i{2}+1) sa{2} sc{2} H3 _ H1 h2 h1;smt().
    + move:H5 H6;rewrite take_oversize 1:size_cat 1:size_nseq 1:/#.
      rewrite nth_cat;cut->/=:! size p{1} + i{2} - 1 < size p{1} by smt().
      by rewrite nth_nseq//=1:/# Block.WRing.addr0 !get_setE//=. 
  alias{1} 1 pref = Redo.prefixes;sp.
  conseq(:_==> ={glob P}
        /\ p1{1} = format p{1} (i{1} + 1) /\ pref{1} = Redo.prefixes{1}
        /\ i1{1} = size p1{1} - 1 
        /\ Redo.prefixes{1}.[take i1{1} p1{1}] = Some (sa0{1}, sc0{1})
        /\ INV_Real 0 C.c{1} Perm.m{1} Perm.mi{1} Redo.prefixes{1});progress.
  + smt().
  + move:H9;rewrite take_format/=1:/#;1:smt(size_ge0 size_cat size_nseq).
    pose x := if _ then _ else _ ;cut->/={x}: x = format p{1} (i_R+1).
    + rewrite/x size_cat size_nseq/=!max_ler 1:/#-(addzA _ _ (-1))-(addzA _ _ (-1))/=.
      case(size p{1} + i_R <= size p{1})=>//=h;2:smt(size_ge0 size_cat size_nseq).
      cut->>/=:i_R = 0 by smt().
      by rewrite take_size/format nseq0 cats0.
    by rewrite H3/==>[][]->>->>.
  + move:H9;rewrite take_format/=1:/#;1:smt(size_ge0 size_cat size_nseq).
    pose x := if _ then _ else _ ;cut->/={x}: x = format p{1} (i_R+1).
    + rewrite/x size_cat size_nseq/=!max_ler 1:/#-(addzA _ _ (-1))-(addzA _ _ (-1))/=.
      case(size p{1} + i_R <= size p{1})=>//=h;2:smt(size_ge0 size_cat size_nseq).
      cut->>/=:i_R = 0 by smt().
      by rewrite take_size/format nseq0 cats0.
    by rewrite H3/=.
  + by rewrite size_cat size_nseq;smt().
  while{1}(={glob P} /\ 0 <= i1{1} <= size p1{1} - 1 /\ 0 < i{1} < n{1}
        /\ p1{1} = format p{1} (i{1} + 1) /\ pref{1} = Redo.prefixes{1}
        /\ format p{1} i{1} \in pref{1}
        /\ Redo.prefixes{1}.[take i1{1} p1{1}] = Some (sa0{1}, sc0{1})
        /\ INV_Real 0 C.c{1} Perm.m{1} Perm.mi{1} Redo.prefixes{1})
    (size p1{1}-i1{1}-1);auto;last first.
  + progress.
    + smt(size_cat size_nseq size_ge0 size_eq0 valid_spec).
    + smt().
    + by rewrite domE H3.
    + by rewrite take0;cut[]_[]:=H1.
    + smt().
    + smt().
  rcondt 1;auto;progress.
  + cut->:take (i1{hr} + 1) (format p{hr} (i{hr} + 1)) =
          take (i1{hr} + 1) (format p{hr} i{hr});2:smt(all_prefixes_of_INV_real domE).
    rewrite!take_format;smt(valid_spec size_ge0 size_eq0 size_cat size_nseq).
  + smt().
  + smt(valid_spec size_ge0 size_eq0 size_cat size_nseq).
  + cut->:take (i1{hr} + 1) (format p{hr} (i{hr} + 1)) =
          take (i1{hr} + 1) (format p{hr} i{hr});2:smt(all_prefixes_of_INV_real domE).
    rewrite!take_format;smt(valid_spec size_ge0 size_eq0 size_cat size_nseq).
  smt().
  qed. 



  lemma pr_real (D <: DISTINGUISHER{SLCommon.C, C, Perm, Redo}) &m :
      Pr [ GReal(A(D)).main() @ &m : res /\ SLCommon.C.c <= max_size] =
      Pr [ RealIndif(Sponge,P,DRestr(D)).main() @ &m : res].
  proof.
  cut->:Pr [ RealIndif(Sponge, P, DRestr(D)).main() @ &m : res ] =
        Pr [ NIndif(Squeeze(SqueezelessSponge(P)),P,DRestr(D)).main() @ &m : res /\ C.c <= max_size ].
  + by rewrite eq_sym;byequiv (squeeze_squeezeless D)=>//=.
  byequiv (equiv_sponge D)=>//=;progress;smt().
  qed.

end section Real.


section Real_Ideal.
  (* REAL & IDEAL *)
  declare module D : DISTINGUISHER{SLCommon.C, C, Perm, Redo, F.RO, F.RRO, S, BIRO.IRO, BIRO2.IRO, F2.RO, F2.FRO}.

  axiom D_lossless (F0 <: DFUNCTIONALITY{D}) (P0 <: DPRIMITIVE{D}) :
    islossless P0.f => islossless P0.fi => islossless F0.f => 
    islossless D(F0, P0).distinguish.


  lemma A_lossless (F <: SLCommon.DFUNCTIONALITY{A(D)})
                   (P0 <: SLCommon.DPRIMITIVE{A(D)}) :
      islossless P0.f =>
      islossless P0.fi => islossless F.f => islossless A(D, F, P0).distinguish.
  proof.
  progress;proc;inline*;sp;wp.
  call(:true);auto.
  + exact D_lossless.
  + proc;inline*;sp;if;auto;call H;auto.
  + proc;inline*;sp;if;auto;call H0;auto.
  proc;inline*;sp;if;auto;sp;if;auto.
  while(true)(n-i);auto.
  + by sp;if;auto;1:call H1;auto;smt().
  call H1;auto;smt().
  qed.

  lemma concl &m :
      Pr [ RealIndif(Sponge,P,DRestr(D)).main() @ &m : res ] <=
      Pr [ IdealIndif(BIRO.IRO, SimLast(S), DRestr(D)).main() @ &m : res ] +
      (max_size ^ 2 - max_size)%r / 2%r  / (2^r)%r  / (2^c)%r  + 
      max_size%r * ((2*max_size)%r / (2^c)%r) + 
      max_size%r * ((2*max_size)%r / (2^c)%r).
  proof.
  rewrite-(pr_real D &m). 
  rewrite-(equiv_ideal D &m).
  cut:=Real_Ideal (A(D)) A_lossless &m.
  pose x:=witness;elim:x=>a b.
  rewrite/dstate dprod1E DBlock.dunifin1E DCapacity.dunifin1E/=
    block_card capacity_card;smt(). 
  qed.


end section Real_Ideal.


require import AdvAbsVal.

section Real_Ideal_Abs.

  declare module D : DISTINGUISHER{SLCommon.C, C, Perm, Redo, F.RO, F.RRO, S, BIRO.IRO, BIRO2.IRO, F2.RO, F2.FRO}.

  axiom D_lossless (F0 <: DFUNCTIONALITY{D}) (P0 <: DPRIMITIVE{D}) :
    islossless P0.f => islossless P0.fi => islossless F0.f => 
    islossless D(F0, P0).distinguish.


  local module Neg_D (D : DISTINGUISHER) (F : DFUNCTIONALITY) (P : DPRIMITIVE) = {
    proc distinguish () : bool = {
      var b : bool;
      b <@ D(F,P).distinguish();
      return !b;
    }
  }.
 

  local lemma Neg_D_lossless (F <: DFUNCTIONALITY{Neg_D(D)}) (P <: DPRIMITIVE{Neg_D(D)}) :
       islossless P.f => islossless P.fi =>
       islossless F.f => islossless Neg_D(D, F, P).distinguish.
  proof.
  by progress;proc;inline*;call(D_lossless F P H H0 H1);auto.
  qed.


  local lemma useful m mi a :
      invm m mi => ! a \in m => Distr.is_lossless ((bdistr `*` cdistr) \ rng m).
  proof.
  move=>hinvm nin_dom.
  cut prod_ll:Distr.is_lossless (bdistr `*` cdistr).
  + by rewrite dprod_ll DBlock.dunifin_ll DCapacity.dunifin_ll. 
  apply dexcepted_ll=>//=;rewrite-prod_ll.
  cut->:predT = predU (predC (rng m)) (rng m);1:rewrite predCU//=.
  rewrite Distr.mu_disjoint 1:predCI//=StdRing.RField.addrC. 
  cut/=->:=ltr_add2l (mu (bdistr `*` cdistr) (rng m)) 0%r.
  rewrite Distr.witness_support/predC.
  move:nin_dom;apply absurd=>//=;rewrite negb_exists/==>hyp. 
  cut{hyp}hyp:forall x, rng m x by smt(supp_dprod DBlock.supp_dunifin DCapacity.supp_dunifin). 
  move:a. 
  cut:=eqEcard (fdom m) (frng m);rewrite leq_card_rng_dom/=. 
  cut->//=:fdom m \subset frng m. 
  + by move=> x; rewrite mem_fdom mem_frng hyp.
  smt(mem_fdom mem_frng).
  qed.

  local lemma invmC (m mi : (state, state) fmap) :
      invm m mi <=> invm mi m.
  proof. smt(). qed.


  local lemma Real_lossless :
    islossless RealIndif(Sponge, P, DRestr(Neg_D(D))).main.
  proof.
  proc;inline*;auto;call(: invm Perm.m Perm.mi);2..:auto.  
  + exact D_lossless. 
  + proc;inline*;sp;if;auto;sp;if;auto;progress. 
    - by cut:=useful _ _ _ H H1. 
    - smt(invm_set dexcepted1E).
  + proc;inline*;sp;if;auto;sp;if;auto;progress. 
    - cut:=H;rewrite invmC=>h;cut/#:=useful _ _ _ h H1. 
    - move:H;rewrite invmC=>H;rewrite invmC;smt(invm_set dexcepted1E domE rngE).
  + proc;inline*;sp;if;auto;sp;if;auto.
    while(invm Perm.m Perm.mi)(n-i);auto.
    - sp;if;auto;2:smt();sp;if;auto;2:smt();progress.
      * by cut:=useful _ _ _ H H2. 
      * smt(invm_set dexcepted1E).
      smt().
    conseq(:_==> invm Perm.m Perm.mi);1:smt().
    while(invm Perm.m Perm.mi)(size xs);auto.
    - sp;if;auto;progress.
      * by cut:=useful _ _ _ H H1.
      * smt(invm_set dexcepted1E).
      * smt(size_behead). 
      * smt(size_behead). 
    smt(size_ge0 size_eq0).
  smt(emptyE).
  qed.


  local lemma Ideal_lossless :
    islossless IdealIndif(BIRO.IRO, SimLast(S), DRestr(Neg_D(D))).main.
  proof.
  proc;inline*;auto;call(D_lossless (FC(BIRO.IRO)) (PC(SimLast(S, BIRO.IRO))) _ _ _);auto.
  + proc;inline*;sp;if;auto;sp;if;auto;sp;if;auto;2:smt(DBlock.dunifin_ll DCapacity.dunifin_ll). 
    sp;if;auto;sp;if;auto;2,4:smt(DBlock.dunifin_ll DCapacity.dunifin_ll).
    * while(true)(n-i);auto;2:smt(DBlock.dunifin_ll DCapacity.dunifin_ll).
      by sp;if;auto;smt(DBlock.dunifin_ll).
    while(true)(n0-i0);auto;2:smt(DBlock.dunifin_ll DCapacity.dunifin_ll).
    by sp;if;auto;smt(DBlock.dunifin_ll).
  + by proc;inline*;sp;if;auto;sp;if;auto;smt(DBlock.dunifin_ll DCapacity.dunifin_ll).
  proc;inline*;sp;if;auto;sp;if;auto;while(true)(n-i);auto;2:smt().
  by sp;if;auto;smt(DBlock.dunifin_ll).
  qed.




  local lemma neg_D_concl &m : 
      Pr [ IdealIndif(BIRO.IRO, SimLast(S), DRestr(D)).main() @ &m : res ] <=
      Pr [ RealIndif(Sponge,P,DRestr(D)).main() @ &m : res ] +
      (max_size ^ 2 - max_size)%r / 2%r  / (2^r)%r  / (2^c)%r  + 
      max_size%r * ((2*max_size)%r / (2^c)%r) + 
      max_size%r * ((2*max_size)%r / (2^c)%r).
  proof.
  cut->:Pr[IdealIndif(BIRO.IRO, SimLast(S), DRestr(D)).main() @ &m : res] =
        Pr[Neg_main(IdealIndif(BIRO.IRO, SimLast(S), DRestr(Neg_D(D)))).main() @ &m : res].
  + by byequiv=>//=;proc;inline*;auto;conseq(:_==> b0{1} = b2{2});progress;sim.
  cut->:Pr [ RealIndif(Sponge,P,DRestr(D)).main() @ &m : res ] =
        Pr [ Neg_main(RealIndif(Sponge,P,DRestr(Neg_D(D)))).main() @ &m : res ].
  + by byequiv=>//=;proc;inline*;auto;conseq(:_==> b0{1} = b2{2});progress;sim.
  cut h1 := Neg_A_Pr_minus (RealIndif(Sponge,P,DRestr(Neg_D(D)))) &m Real_lossless.
  cut h2 := Neg_A_Pr_minus (IdealIndif(BIRO.IRO, SimLast(S), DRestr(Neg_D(D)))) &m Ideal_lossless.
  cut/#:=concl (Neg_D(D)) _ &m;progress.
  by proc;call(D_lossless F0 P0 H H0 H1);auto.
  qed.

  lemma Inefficient_Real_Ideal &m : 
      `|Pr [ RealIndif(Sponge,Perm,DRestr(D)).main() @ &m : res ] -
        Pr [ IdealIndif(BIRO.IRO, SimLast(S), DRestr(D)).main() @ &m : res ]| <=
      (max_size ^ 2 - max_size)%r / 2%r  / (2^r)%r  / (2^c)%r  + 
      max_size%r * ((2*max_size)%r / (2^c)%r) + 
      max_size%r * ((2*max_size)%r / (2^c)%r).
  proof.
  cut := concl D D_lossless &m.
  cut := neg_D_concl &m.
  pose p1 := Pr[IdealIndif(BIRO.IRO, SimLast(S), DRestr(D)).main() @ &m : res].
  pose p2 := Pr[RealIndif(Sponge, Perm, DRestr(D)).main() @ &m : res]. 
  rewrite-5!(StdRing.RField.addrA).
  pose p3 := (max_size ^ 2)%r / 2%r / (2 ^ r)%r / (2 ^ c)%r +
             (max_size%r * ((2 * max_size)%r / (2 ^ c)%r) +
             max_size%r * ((2 * max_size)%r / (2 ^ c)%r)).
  smt().
  qed.  

end section Real_Ideal_Abs.



module Simulator (F : DFUNCTIONALITY) = {
  var m  : (state, state) fmap
  var mi : (state, state) fmap
  var paths : (capacity, block list * block) fmap
  var unvalid_map : (block list * int, block) fmap
  proc init() = {
    m <- empty;
    mi <- empty;
    paths <- empty.[c0 <- ([],b0)];
    unvalid_map <- empty;
  }
  proc f (x : state) : state = {
    var p,v,q,k,cs,y,y1,y2;
    if (x \notin m) {
      if (x.`2 \in paths) {
        (p,v) <- oget paths.[x.`2];
        (q,k) <- parse (rcons p (v +^ x.`1));
        if (valid q) {
          cs <@ F.f(q, k);
          y1 <- last b0 cs;
        } else {
          if (0 < k) {
            if ((q,k-1) \notin unvalid_map) {
              unvalid_map.[(q,k-1)] <$ bdistr;
            }
            y1 <- oget unvalid_map.[(q,k-1)];
          } else {
            y1 <- b0;
          }
        }
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

section Simplify_Simulator.

declare module D : DISTINGUISHER{Simulator, F.RO, BIRO.IRO, C, S, BIRO2.IRO}.

axiom D_lossless (F0 <: DFUNCTIONALITY{D}) (P0 <: DPRIMITIVE{D}) :
  islossless P0.f => islossless P0.fi => islossless F0.f => 
  islossless D(F0, P0).distinguish.

local clone import PROM.GenEager as IRO2 with
  type from   <- block list * int,
  type to     <- block,
  op sampleto <- fun _, bdistr,
  type input  <- unit,
  type output <- bool
proof * by exact/DBlock.dunifin_ll.

local module Simu (FRO : IRO2.RO) (F : DFUNCTIONALITY) = {
  proc init() = {
    Simulator(F).init();
    FRO.init();
  }
  proc f (x : state) : state = {
    var p,q,v,k,i,cs,y,y1,y2;
    if (x \notin Simulator.m) {
      if (x.`2 \in Simulator.paths) {
        (p,v) <- oget Simulator.paths.[x.`2];
        (q,k) <- parse (rcons p (v +^ x.`1));
        if (valid q) {
          cs <@ F.f(q, k);
          y1 <- last b0 cs;
        } else {
          if (0 < k) {
            i <- 0;
            while (i < k) {
              FRO.sample(q,i);
              i <- i + 1;
            }
            y1 <- FRO.get(q,k-1);
          } else {
            y1 <- b0;
          }
        }
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
    return y;
  }
  proc fi (x : state) : state = {
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
    return y;
  }
}.

local module L (F : IRO2.RO) = {
  proc distinguish = IdealIndif(BIRO.IRO, Simu(F), DRestr(D)).main
}.

local lemma equal1 &m :
  Pr [ IdealIndif(BIRO.IRO, SimLast(S), DRestr(D)).main() @ &m : res ] =
  Pr [ L(IRO2.RO).distinguish() @ &m : res ].
proof.
byequiv=>//=; proc; inline*; auto. 
call (: ={BIRO.IRO.mp,C.c} /\ ={m,mi,paths}(S,Simulator) /\
        BIRO2.IRO.mp{1} = IRO2.RO.m{2} /\ 
        incl Simulator.unvalid_map{2} BIRO2.IRO.mp{1}); first last.
+ by proc; inline*; conseq=>/>; sim.
+ by proc; inline*; conseq=>/>; sim.
+ by auto.
proc; sp; if; auto.
call(: ={BIRO.IRO.mp} /\ ={m,mi,paths}(S,Simulator) /\
        BIRO2.IRO.mp{1} = IRO2.RO.m{2} /\ 
        incl Simulator.unvalid_map{2} BIRO2.IRO.mp{1});auto.
if; 1,3: by auto.
seq 1 1: (={BIRO.IRO.mp,y1,x} /\ ={m,mi,paths}(S,Simulator) /\
          BIRO2.IRO.mp{1} = IRO2.RO.m{2} /\ 
          incl Simulator.unvalid_map{2} BIRO2.IRO.mp{1}); last first.
- by conseq=>/>; auto.
if; 1,3: by auto.
inline*; sp; if; 1,2: auto. 
- move=> /> &1 &2 h1 h2 bl n h3 h4 h5 h6 h7 h8.
  have:= h1; rewrite-h3 /= => [#] ->>->>. 
  have:= h4; rewrite-h2 /= => [#] ->>->>. 
  have->>/=: q{2} = (parse (rcons p{1} (v{1} +^ x{2}.`1))).`1 by smt().
  have->>/=: k{2} = (parse (rcons p{1} (v{1} +^ x{2}.`1))).`2 by smt().
  move: h5; have-> h5:= formatK (rcons p{1} (v{1} +^ x{2}.`1)).
  by have->>/=: q{1} = (parse (rcons p{1} (v{1} +^ x{2}.`1))).`1 by smt().
- sp; if; auto.
 * move=> /> &1 &2 h1 h2 bl n h3 h4 h5 h6 h7 h8 h9 h10.
    have:= h1; rewrite-h3 /= => [#] ->>->>. 
    have:= h4; rewrite-h2 /= => [#] ->>->>. 
    have->>/=: q{2} = (parse (rcons p{1} (v{1} +^ x{2}.`1))).`1 by smt().
    have->>/=: k{2} = (parse (rcons p{1} (v{1} +^ x{2}.`1))).`2 by smt().
    move: h5; have-> h5:= formatK (rcons p{1} (v{1} +^ x{2}.`1)).
    by have->>/=: q{1} = (parse (rcons p{1} (v{1} +^ x{2}.`1))).`1 by smt().
  by conseq(:_ ==> ={bs, BIRO.IRO.mp})=> />; sim=> />; smt(parseK formatK).
sp; rcondt{1} 1; 1: auto; if{2}; last first.
+ by rcondf{1} 1; auto; smt(parseK formatK).
sp; rcondf{2} 4; 1: auto.
+ conseq(:_ ==> (q,k-1) \in RO.m)=> />.
  splitwhile 1 : i + 1 < k.
  rcondt 2; 1:(auto; while (i + 1 <= k); auto; smt()).
  rcondf 7; 1:(auto; while (i + 1 <= k); auto; smt()).
  seq 1 : (i + 1 = k).
  - by while(i + 1 <= k); auto; smt().
  by auto=> />; smt(mem_set).
wp; rnd{2}; wp=> /=; conseq=> />.
conseq(:_==> i{2} = k{2} /\
    (0 < i{2} => last Block.b0 bs0{1} = oget RO.m{2}.[(q{2}, i{2} -1)]) /\
    BIRO2.IRO.mp{1} = RO.m{2} /\ incl Simulator.unvalid_map{2} BIRO2.IRO.mp{1}) =>/>.
+ smt(DBlock.dunifin_ll).
while (i{2} <= k{2} /\ n0{1} = k{2} /\ i0{1} = i{2} /\ x1{1} = q{2} /\ ={k} /\
  (0 < i{2} => last Block.b0 bs0{1} = oget RO.m{2}.[(q{2}, i{2} - 1)]) /\
  BIRO2.IRO.mp{1} = RO.m{2} /\ incl Simulator.unvalid_map{2} BIRO2.IRO.mp{1}).
+ sp; wp 2 2=> /=; conseq=> />.
  conseq(:_==> b0{1} = oget RO.m{2}.[(q{2}, i{2})] /\ 
      BIRO2.IRO.mp{1} = RO.m{2} /\
      incl Simulator.unvalid_map{2} BIRO2.IRO.mp{1}); 1: smt(last_rcons).
  if{1}; 2: rcondf{2} 2; 1: rcondt{2} 2; 1,3: auto.
  - by auto=> />; smt(incl_upd_nin).
 by  auto; smt(DBlock.dunifin_ll).
auto=> /> &1 &2 h1 h2 [#] q_L k_L h3 h4 h5 h6 h7 h8 h9 h10;split.
+ have:= h1; rewrite -h3 => [#] />; have:= h4; rewrite -h2 => [#] />.
  have:= h5.
  cut-> : q{2} = (parse (rcons p{1} (v{1} +^ x{2}.`1))).`1 by smt().
  cut-> : k{2} = (parse (rcons p{1} (v{1} +^ x{2}.`1))).`2 by smt().
  by rewrite (formatK (rcons p{1} (v{1} +^ x{2}.`1)))=> [#] />; smt().
smt().
qed.


local lemma equal2 &m :
  Pr [ IdealIndif(BIRO.IRO, Simulator, DRestr(D)).main() @ &m : res ] =
  Pr [ L(IRO2.LRO).distinguish() @ &m : res ].
proof.
byequiv=>//=; proc; inline*; auto. 
call (: ={BIRO.IRO.mp,C.c,Simulator.m,Simulator.mi,Simulator.paths} /\
        Simulator.unvalid_map{1} = IRO2.RO.m{2}); first last.
+ by proc; inline*; conseq=> />; sim.
+ by proc; inline*; conseq=> />; sim.
+ by auto=> />.
proc; sp; if; auto.
call(: ={BIRO.IRO.mp,Simulator.m,Simulator.mi,Simulator.paths} /\
        Simulator.unvalid_map{1} = IRO2.RO.m{2}); auto.
if; 1,3: auto.
seq 1 1: (={y1,x, BIRO.IRO.mp, Simulator.m, Simulator.mi, Simulator.paths} /\
  Simulator.unvalid_map{1} = RO.m{2}); 2: by (conseq=> />; sim).
if; 1,3: auto; sp. 
conseq=> />.
conseq(: ={q, k, BIRO.IRO.mp} /\ Simulator.unvalid_map{1} = RO.m{2} ==> _)=> />.
+ move=> &1 &2 h1 h2 h3 h4 h5 h6.
  by have:= h1; rewrite -h3 => [#] /> /#.
inline*; if; 1: auto; 1: sim.
if; 1,3: auto; sp.
swap{2} 4; while{2}((i<=k){2})(k{2}-i{2}); 1: by (auto; smt()).
by sp; if{1}; 2: rcondf{2} 2; 1: rcondt{2} 2; auto; smt(DBlock.dunifin_ll).
qed.



lemma Simplify_simulator &m :
  Pr [ IdealIndif(BIRO.IRO, Simulator, DRestr(D)).main() @ &m : res ] =
  Pr [ IdealIndif(BIRO.IRO, SimLast(S), DRestr(D)).main() @ &m : res ].
proof.
rewrite (equal1 &m) (equal2 &m) eq_sym.
by byequiv(RO_LRO_D L)=>//=.
qed.


end section Simplify_Simulator.





section Real_Ideal.
  declare module D : DISTINGUISHER{SLCommon.C, C, Perm, Redo, F.RO, F.RRO, S, BIRO.IRO, BIRO2.IRO, F2.RO, F2.FRO, Simulator}.

  axiom D_lossless (F0 <: DFUNCTIONALITY{D}) (P0 <: DPRIMITIVE{D}) :
    islossless P0.f => islossless P0.fi => islossless F0.f => 
    islossless D(F0, P0).distinguish.


  lemma Real_Ideal &m : 
      `|Pr [ RealIndif(Sponge,Perm,DRestr(D)).main() @ &m : res ] -
        Pr [ IdealIndif(BIRO.IRO, Simulator, DRestr(D)).main() @ &m : res ]| <=
      (max_size ^ 2 - max_size)%r / 2%r  / (2^r)%r  / (2^c)%r  + 
      max_size%r * ((2*max_size)%r / (2^c)%r) + 
      max_size%r * ((2*max_size)%r / (2^c)%r).
  proof.
  rewrite(Simplify_simulator D D_lossless &m).
  exact/(Inefficient_Real_Ideal D D_lossless &m).
  qed.  

end section Real_Ideal.

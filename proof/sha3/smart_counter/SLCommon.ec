(** This is a theory for the Squeezeless sponge: where the ideal
    functionality is a fixed-output-length random oracle whose output
    length is the input block size. We prove its security even when
    padding is not prefix-free. **)
require import Core Int Real StdOrder Ring IntExtra.
require import List FSet SmtMap Common PROM Distr DProd Dexcepted.

require (*..*) Indifferentiability.
(*...*) import Capacity IntOrder.

pragma -oldip.

(** Really? **)
abbrev ([+]) ['a 'b] (x : 'b) = fun (_ : 'a) => x.

type state  = block  * capacity.
op   dstate = bdistr `*` cdistr.

clone include Indifferentiability with
  type p     <- state, 
  type f_in  <- block list,
  type f_out <- block
  rename [module] "GReal" as "RealIndif"
         [module] "GIdeal"  as "IdealIndif".

(** max number of call to the permutation and its inverse, 
    including those performed by the construction. *)
op max_size : { int | 0 <= max_size } as max_ge0.

(** Ideal Functionality **)
clone export Tuple as TupleBl with
  type t <- block,
  op Support.enum <- Block.blocks
  proof Support.enum_spec by exact Block.enum_spec. 

op bl_enum = flatten (mkseq (fun i => wordn i) (max_size + 1)). 
op bl_univ = FSet.oflist bl_enum.

(* -------------------------------------------------------------------------- *)
(* Random oracle from block list to block                                     *)

clone import PROM.GenEager as F with
  type from <- block list,
  type to   <- block,
  op sampleto <- fun (_:block list)=> bdistr,
  type input <- unit,
  type output <- bool
  proof * by exact Block.DBlock.dunifin_ll.

module Redo = {
  var prefixes : (block list, state) fmap

  proc init() : unit = {
    prefixes <- empty.[[] <- (b0,c0)];
  }
}.

(** We can now define the squeezeless sponge construction **)
module SqueezelessSponge (P:DPRIMITIVE): FUNCTIONALITY = {
  proc init () = {
    Redo.init();
  } 

  proc f(p : block list): block = {
    var (sa,sc) <- (b0,c0);
    var i : int <- 0;

    while (i < size p) { (* Absorption *)
      if (take (i+1) p \in Redo.prefixes) {
        (sa,sc) <- oget Redo.prefixes.[take (i+1) p];
      } else {
        (sa,sc) <- (sa +^ nth witness p i, sc);
        (sa,sc) <@ P.f((sa,sc));
        Redo.prefixes.[take (i+1) p] <- (sa,sc);
      }
      i <- i + 1;
    }

    return sa;          (* Squeezing phase (non-iterated) *)
  }
}.

clone export DProd.ProdSampling as Sample2 with 
  type t1 <- block,
  type t2 <- capacity.

(* -------------------------------------------------------------------------- *)
(** TODO move this **)

op incl (m m':('a,'b)fmap) = 
  forall x,  m .[x] <> None => m'.[x] = m.[x].

(* -------------------------------------------------------------------------- *)
(** usefull type and operators for the proof **)

type handle  = int.

type hstate = block * handle.
 
type ccapacity = capacity * flag.

type smap    = (state , state    ) fmap.
type hsmap   = (hstate, hstate   ) fmap.
type handles = (handle, ccapacity) fmap.

pred is_pre_permutation (m mi : ('a,'a) fmap) =
     (forall x, rng m x => dom mi x)
  /\ (forall x, rng mi x => dom m x).

lemma half_permutation_set (m' mi' : ('a,'a) fmap) x' y':
     (forall x, rng m' x => dom mi' x)
  => (forall x, rng m'.[x' <- y'] x => dom mi'.[y' <- x'] x).
proof.
move=> h x0; rewrite rngE=> - /= [x]; case: (x = x')=> [<*>|].
+ by rewrite get_set_sameE=> /= <*>; rewrite domE get_set_sameE.
rewrite get_setE=> -> /= m'x_x0; move: (h x0 _).
+ by rewrite rngE; exists x.
by rewrite mem_set=> ->.
qed.

lemma pre_permutation_set (m mi : ('a,'a) fmap) x y:
  is_pre_permutation m mi =>
  is_pre_permutation m.[x <- y] mi.[y <- x].
proof.
move=> [dom_mi dom_m].
by split; apply/half_permutation_set.
qed.    

(* Functionnal version of the construction using handle *)
op step_hpath (mh:hsmap) (sah:hstate option) (b:block) = 
  if   sah = None
  then None 
  else 
    let sah = oget sah in 
    mh.[(sah.`1 +^ b, sah.`2)].

op build_hpath (mh:hsmap) (bs:block list) = 
 foldl (step_hpath mh) (Some (b0,0)) bs.

inductive build_hpath_spec mh p v h =
| Empty of (p = [])
         & (v = b0)
         & (h = 0)
| Extend p' b v' h' of (p = rcons p' b)
                     & (build_hpath mh p' = Some (v',h'))
                     & (mh.[(v' +^ b,h')] = Some (v,h)).

lemma build_hpathP mh p v h:
  build_hpath mh p = Some (v,h) <=> build_hpath_spec mh p v h.
proof.
elim/last_ind: p v h=> @/build_hpath //= [v h|p b ih v h].
+ by split=> [!~#] <*>; [exact/Empty|move=> []]; smt(size_rcons size_ge0).
rewrite -{1}cats1 foldl_cat {1}/step_hpath /=.
case: {-1}(foldl _ _ _) (eq_refl (foldl (step_hpath mh) (Some (b0,0)) p))=> //=.
+ apply/implybN; case=> [|p' b0 v' h'].
  + smt(size_rcons size_ge0).
  move=> ^/rconssI <<- /rconsIs ->>.
  by rewrite /build_hpath=> ->.
move=> [v' h']; rewrite -/(build_hpath _ _)=> build. 
split.
+ by move=> mh__; apply/(Extend mh (rcons p b) v h p b v' h' _ build mh__).
case=> [| p' b' v'' h''].
+ smt(size_rcons size_ge0).
move=> ^/rconssI <<- /rconsIs <<-.
by rewrite build /= => [#] <*>.
qed.

lemma build_hpath_map0 p:
   build_hpath empty p = if   p = [] then Some (b0,0) else None.
proof.
elim/last_ind: p=> //= p b _.
by rewrite -{1}cats1 foldl_cat {1}/step_hpath /= emptyE /= [smt(size_rcons size_ge0)].
qed.

(* -------------------------------------------------------------------------- *)
theory Prefix.

op prefix ['a] (s t : 'a list) =
  with s = x :: s', t = y :: t' => if x = y then 1 + prefix s' t' else 0
  with s = _ :: _ , t = []      => 0
  with s = []     , t = _ :: _  => 0
  with s = []     , t = []      => 0.

lemma prefix0s (s : 'a list): prefix [] s = 0.
proof. by elim: s. qed.

lemma prefixs0 (s : 'a list): prefix s [] = 0.
proof. by elim: s. qed.

lemma prefix_eq (l : 'a list) : prefix l l = size l.
proof. elim:l=>//=/#. qed.


lemma prefixC (l1 l2 : 'a list) : 
  prefix l1 l2 = prefix l2 l1.
proof.
move:l1; elim: l2=> //=; first by (move=> l1; elim: l1=> //=).
move=> e2 l2 Hind l1; move: e2 l2 Hind; elim: l1=> //=.
move=> e1 l1 Hind e2 l2 Hind1; rewrite Hind1 /#.
qed.

lemma prefix_ge0 (l1 l2 : 'a list) : 
  0 <= prefix l1 l2.
proof.
move: l2; elim: l1=> //=; first (move=> l2; elim: l2=> //=).
move=> e1 l1 Hind l2; move: e1 l1 Hind; elim: l2=> //=.
move=> e2 l2 Hind2 e1 l1 Hind1 /#.
qed.

lemma prefix_sizel (l1 l2 : 'a list) :
  prefix l1 l2 <= size l1.
proof.
move: l2; elim: l1=> //=; first by (move=> l2; elim: l2=> //=).
move=> e1 l1 Hind l2; move: e1 l1 Hind; elim: l2=> //=; 1:smt(size_ge0).
by move=> e2 l2 Hind2 e1 l1 Hind1; smt(size_ge0).
qed.

lemma prefix_sizer (l1 l2 : 'a list) :
  prefix l1 l2 <= size l2.
proof.
by rewrite prefixC prefix_sizel.
qed.

lemma prefix_take (l1 l2 : 'a list) :
  take (prefix l1 l2) l1 = take (prefix l1 l2) l2.
proof.
move: l2; elim: l1=> //=; first by (move=> l2; elim: l2=> //=).
move=> e1 l1 Hind l2 /=; move: e1 l1 Hind; elim: l2=> //=.
move=> e2 l2 Hind1 e1 l1 Hind2=> //=. 
by case: (e1 = e2)=> [-> /#|].
qed.

lemma take_take (l : 'a list) (i j : int) :
  take i (take j l) = take (min i j) l.
proof.
case: (i <= j)=> Hij.
+ case: (j < size l)=> Hjsize; last smt(take_oversize).
  case: (0 <= i)=> Hi0; last smt(take_le0).
  apply: (eq_from_nth witness); 1:smt(size_take).
  move=> k; rewrite !size_take //= 1:/# Hjsize /=.
  have ->: (if i < j then i else j) = i by smt().
  move=> [Hk0 Hki].
  by rewrite !nth_take /#.
case: (0 < j)=> //= Hj0; last smt(take_le0).
rewrite min_ler 1:/#.
by rewrite take_oversize //= size_take /#.
qed.

lemma prefix_take_leq (l1 l2 : 'a list) (i : int) :
  i <= prefix l1 l2 => take i l1 = take i l2.
proof.
move=> Hi; have ->: i = min i (prefix l1 l2) by smt(min_lel).
by rewrite -(take_take l1 i _) -(take_take l2 i _) prefix_take.
qed.

lemma prefix_nth (l1 l2 : 'a list) :
  let i = prefix l1 l2 in
  forall j, 0 <= j < i => 
  nth witness l1 j = nth witness l2 j.
proof.
move=> /=; have Htake:= prefix_take l1 l2.
move=> j [Hj0 Hjp]; rewrite -(nth_take witness (prefix l1 l2)) 1:prefix_ge0 //.
by rewrite -(nth_take witness (prefix l1 l2) l2) 1:prefix_ge0 // Htake.
qed.

(* TODO: can we define this as a fold on a set instead of on a list? *)
op max_prefix (l1 l2 : 'a list) (ll : 'a list list) =
  with ll = "[]" => l2
  with ll = (::) l' ll' => 
    if prefix l1 l2 < prefix l1 l' then max_prefix l1 l' ll'
    else max_prefix l1 l2 ll'.

op get_max_prefix (l : 'a list) (ll : 'a list list) =
  with ll = "[]" => []
  with ll = (::) l' ll' => max_prefix l l' ll'.

pred prefix_inv (queries : (block list, block) fmap)
                (prefixes : (block list, state) fmap) =
  (forall (bs : block list),
    bs \in queries => oget queries.[bs] = (oget prefixes.[bs]).`1) &&
  (forall (bs : block list),
    bs \in queries => forall i, take i bs \in prefixes) &&
  (forall (bs : block list),
    forall i, take i bs <> [] =>
    take i bs \in prefixes =>
    exists l2, (take i bs) ++ l2 \in queries).

pred all_prefixes (prefixes : (block list, state) fmap) =
  forall (bs : block list), bs \in prefixes => forall i, take i bs \in prefixes.

lemma aux_mem_get_max_prefix (l1 l2 : 'a list) ll :
  max_prefix l1 l2 ll = l2 \/ max_prefix l1 l2 ll \in ll.
proof.
move: l1 l2; elim: ll=> //= l3 ll Hind l1 l2. 
case: (prefix l1 l2 < prefix l1 l3)=> //= hmax.
+ by have /#:= Hind l1 l3.
by have /#:= Hind l1 l2.
qed.

lemma mem_get_max_prefix (l : 'a list) ll :
  ll <> [] => get_max_prefix l ll \in ll.
proof.
move: l; elim: ll=> //= l2 ll Hind l1.
exact/aux_mem_get_max_prefix.
qed.

lemma take_get_max_prefix l (prefixes : (block list,state) fmap) :
  (exists b, b \in prefixes) =>
  all_prefixes prefixes =>
  take (prefix l (get_max_prefix l (elems (fdom prefixes)))) l \in prefixes.
proof.
move=> nil_in_dom all_pref.
rewrite prefix_take all_pref -mem_fdom memE mem_get_max_prefix; smt(memE mem_fdom).
qed.
    
lemma take_get_max_prefix2 l (prefixes : (block list,state) fmap) i :
  (exists b, b \in prefixes) =>
  all_prefixes prefixes =>
  i <= prefix l (get_max_prefix l (elems (fdom prefixes))) =>
  take i l \in prefixes.
proof.
move=> nil_in_dom all_pref hi. 
rewrite (prefix_take_leq _ _ i hi) all_pref -mem_fdom memE mem_get_max_prefix.
smt(memE mem_fdom).
qed.

lemma prefix_cat (l l1 l2 : 'a list) :
  prefix (l ++ l1) (l ++ l2) = size l + prefix l1 l2.
proof. by move: l1 l2; elim: l=> /#. qed.

lemma prefix_leq_take (l1 l2 : 'a list) i :
  0 <= i <= min (size l1) (size l2) => 
  take i l1 = take i l2 =>
  i <= prefix l1 l2.
proof.
move=> [hi0 himax] htake.
rewrite -(cat_take_drop i l1) -(cat_take_drop i l2) htake.
rewrite prefix_cat size_take //=; smt(prefix_ge0).
qed.

lemma prefix0 (l1 l2 : 'a list) :
  prefix l1 l2 = 0 <=> l1 = [] \/ l2 = [] \/ head witness l1 <> head witness l2 .
proof.
move: l2; elim: l1=> //= [[] //=|].
move=> e1 l1 Hind l2; move: e1 l1 Hind; elim: l2=> //= e2 l2 Hind2 e1 l1 Hind1.
smt(prefix_ge0).
qed.

lemma head_nth0 (l : 'a list) : head witness l = nth witness l 0.
proof. by elim: l. qed.

lemma get_prefix (l1 l2 : 'a list) i :
  0 <= i <= min (size l1) (size l2)=>
  (drop i l1 = [] \/ drop i l2 = [] \/
  (i < min (size l1) (size l2) /\
  nth witness l1 i <> nth witness l2 i)) =>
  take i l1 = take i l2 =>
  i = prefix l1 l2.
proof.
move=>[hi0 hisize] [|[]]. 
+ move=> hi. 
  have:= size_eq0 (drop i l1); rewrite {2}hi /= size_drop // => h.
  have hsize: size l1 = i by smt().
  rewrite -hsize take_size.
  rewrite -{2}(cat_take_drop (size l1) l2)=> <-.
  by rewrite -{2}(cats0 l1) prefix_cat; case: (drop (size l1) l2).
+ move=> hi. 
  have:= size_eq0 (drop i l2); rewrite {2}hi /= size_drop // => h.
  have hsize: size l2 = i by rewrite /#.
  rewrite -hsize take_size.
  rewrite -{2}(cat_take_drop (size l2) l1)=> ->.
  by rewrite -{4}(cats0 l2) prefix_cat; case: (drop (size l2) l1).
move=> [himax hnth] htake.
rewrite -(cat_take_drop i l1) -(cat_take_drop i l2) htake. 
rewrite prefix_cat size_take //=.
have [_ ->]:= prefix0 (drop i l1) (drop i l2).
+ case: (i = size l1)=> hi1 //=.
  + by rewrite hi1 drop_size //=.
  case: (i = size l2)=> hi2 //=.
  + by rewrite hi2 drop_size //=.
  by rewrite 2!head_nth0 nth_drop //= nth_drop //= hnth.
smt().
qed.

lemma get_max_prefix_leq (l1 l2 : 'a list) (ll : 'a list list) :
  prefix l1 l2 <= prefix l1 (max_prefix l1 l2 ll).
proof. by move: l1 l2; elim: ll=> /#. qed.

lemma get_max_prefix_is_max (l1 l2 : 'a list) (ll : 'a list list) :
  forall l3, l3 \in ll => prefix l1 l3 <= prefix l1 (max_prefix l1 l2 ll).
proof.
move: l1 l2; elim: ll=> //= l4 ll Hind l1 l2 l3.
by case: (prefix l1 l2 < prefix l1 l4)=> //= h []; smt(get_max_prefix_leq).
qed.

lemma get_max_prefix_max (l : 'a list) (ll : 'a list list) :
  forall l2, l2 \in ll => prefix l l2 <= prefix l (get_max_prefix l ll).
proof. smt(get_max_prefix_is_max get_max_prefix_leq). qed.

(** TODO: NOT PRETTY! **)
lemma all_take_in (l : block list) i prefixes :
  0 <= i <= size l =>
  all_prefixes prefixes =>
  take i l \in prefixes =>
  i <= prefix l (get_max_prefix l (elems (fdom prefixes))).
proof.
move=>[hi0 hisize] all_prefix take_in_dom.
cut->:i = prefix l (take i l);2:smt(get_max_prefix_max memE mem_fdom).
apply get_prefix. 
+ smt(size_take). 
+ by right;left;apply size_eq0;rewrite size_drop//size_take//=/#.
smt(take_take).
qed.

lemma prefix_inv_leq (l : block list) i prefixes queries :
    0 <= i <= size l =>
    elems (fdom queries) <> [] =>
    all_prefixes prefixes =>
    take i l \in prefixes =>
    prefix_inv queries prefixes =>
    i <= prefix l (get_max_prefix l (elems (fdom queries))).
proof.
move=>h_i h_nil h_all_prefixes take_in_dom [?[h_prefix_inv h_exist]].
case(take i l = [])=>//=h_take_neq_nil.
+ smt(prefix_ge0 size_take).
cut[l2 h_l2_mem]:=h_exist l i h_take_neq_nil take_in_dom.
rewrite -mem_fdom memE in h_l2_mem.
rewrite(StdOrder.IntOrder.ler_trans _ _ _ _ (get_max_prefix_max _ _ _ h_l2_mem)).
rewrite-{1}(cat_take_drop i l)prefix_cat size_take 1:/#;smt(prefix_ge0).
qed.


lemma max_prefix_eq (l : 'a list) (ll : 'a list list) :
    max_prefix l l ll = l.
proof. 
move:l;elim:ll=>//=l2 ll Hind l1;smt( prefix_eq prefix_sizel).
qed.

lemma prefix_max_prefix_eq_size (l1 l2 : 'a list) (ll : 'a list list) :
    l1 = l2 \/ l1 \in ll =>
    prefix l1 (max_prefix l1 l2 ll) = size l1.
proof.
move:l1 l2;elim:ll=>//=;1:smt(prefix_eq). 
move=>l3 ll Hind l1 l2[->|[->|h1]].
+ by rewrite prefix_eq max_prefix_eq ltzNge prefix_sizel /= prefix_eq. 
+ rewrite prefix_eq max_prefix_eq. 
  case(prefix l3 l2 < size l3)=>//=h;1:by rewrite prefix_eq.
  cut h1:prefix l3 l2 = size l3 by smt(prefix_sizel).
  cut: size l3 <= prefix l3 (max_prefix l3 l2 ll);2:smt(prefix_sizel).
  rewrite-h1.
  by clear Hind l1 h h1;move:l2 l3;elim:ll=>//=l3 ll Hind l1 l2/#.
by case(prefix l1 l2 < prefix l1 l3)=>//=/#.
qed.

lemma prefix_get_max_prefix_eq_size (l : 'a list) (ll : 'a list list) :
    l \in ll =>
    prefix l (get_max_prefix l ll) = size l.
proof.
move:l;elim:ll=>//;smt(prefix_max_prefix_eq_size).
qed.

lemma get_max_prefix_exists (l : 'a list) (ll : 'a list list) :
    ll <> [] =>
    exists l2, take (prefix l (get_max_prefix l ll)) l ++ l2 \in ll.
proof.
move:l;elim:ll=>//=l2 ll Hind l1;clear Hind;move:l1 l2;elim:ll=>//=.
+ smt(cat_take_drop prefix_take).
move=>l3 ll Hind l1 l2.
case( prefix l1 l2 < prefix l1 l3 )=>//=h/#.
qed.

lemma prefix_geq (l1 l2 : 'a list) :
    prefix l1 l2 = prefix (take (prefix l1 l2) l1) (take (prefix l1 l2) l2).
proof.
move:l2;elim:l1=>//=[[] //=|] e1 l1 Hind l2;elim:l2=>//=e2 l2 Hind2.
case(e1=e2)=>//=h12.
cut->/=:! 1 + prefix l1 l2 <= 0 by smt(prefix_ge0).
rewrite h12/=/#.
qed.

lemma prefix_take_prefix (l1 l2 : 'a list) :
    prefix (take (prefix l1 l2) l1) l2 = prefix l1 l2.
proof.
move:l2;elim:l1=>//=e1 l1 Hind l2;elim:l2=>//=e2 l2 Hind2.
case(e1=e2)=>//=h12.
cut->/=:! 1 + prefix l1 l2 <= 0 by smt(prefix_ge0).
rewrite h12/=/#.
qed.

lemma prefix_leq_prefix_cat (l1 l2 l3 : 'a list) :
    prefix l1 l2 <= prefix (l1 ++ l3) l2.
proof.
move:l2 l3;elim l1=>//= [[]|]; 1,2:smt(take_le0 prefix_ge0).
move=>e1 l1 hind1 l2;elim:l2=>//=e2 l2 hind2 l3/#.
qed.

lemma prefix_take_leq_prefix (l1 l2 : 'a list) i :
    prefix (take i l1) l2 <= prefix l1 l2.
proof.
rewrite-{2}(cat_take_drop i l1).
move:(take i l1)(drop i l1);clear i l1=>l1 l3. 
exact prefix_leq_prefix_cat.
qed.

lemma prefix_take_geq_prefix (l1 l2 : 'a list) i :
    prefix l1 l2 <= i =>
    prefix l1 l2 = prefix (take i l1) l2.
proof.
move=>hi.
cut:prefix (take i l1) l2 <= prefix l1 l2.
+ rewrite-{2}(cat_take_drop i l1) prefix_leq_prefix_cat.
cut/#:prefix l1 l2 <= prefix (take i l1) l2.
rewrite -prefix_take_prefix.
rewrite-(cat_take_drop (prefix l1 l2) (take i l1))take_take min_lel// prefix_leq_prefix_cat. 
qed.

lemma get_max_prefix_take (l : 'a list) (ll : 'a list list) i :
    prefix l (get_max_prefix l ll) <= i =>
    get_max_prefix l ll = get_max_prefix (take i l) ll.
proof.
move:l;elim:ll=>//=l2 ll Hind l1;clear Hind;move:l1 l2;elim:ll=>//=l3 ll Hind l1 l2.
case( prefix l1 l2 < prefix l1 l3 )=>//=h hi.
+ rewrite -prefix_take_geq_prefix//=;1:smt(get_max_prefix_leq).
  rewrite -prefix_take_geq_prefix//=;1:smt(get_max_prefix_leq). 
  rewrite h/=/#.
rewrite -prefix_take_geq_prefix//=;1:smt(get_max_prefix_leq).
rewrite -prefix_take_geq_prefix//=;1:smt(get_max_prefix_leq). 
rewrite h/=/#.
qed.


lemma drop_prefix_neq (l1 l2 : 'a list) :
    drop (prefix l1 l2) l1 = [] \/ drop (prefix l1 l2) l1 <> drop (prefix l1 l2) l2.
proof.
move: l2; elim: l1=> //= e1 l1 hind1; elim=> //= e2 l2 //= hind2 //=.
smt(prefix_ge0).
qed.

lemma prefix_prefix_prefix (l1 l2 l3 : 'a list) (ll : 'a list list) :
    prefix l1 l2 <= prefix l1 l3 =>
    prefix l1 (max_prefix l1 l2 ll) <= prefix l1 (max_prefix l1 l3 ll).
proof.
move:l1 l2 l3;elim:ll=>//=l4 ll hind l1 l2 l3 h123/#.
qed.

lemma prefix_lt_size (l : 'a list) (ll : 'a list list) :
    prefix l (get_max_prefix l ll) < size l =>
    forall i, prefix l (get_max_prefix l ll) < i =>
    ! take i l \in ll.
proof.
move:l;elim:ll=>//=l2 ll Hind l1;clear Hind;move:l1 l2;elim:ll=>//=.
+ progress.
  rewrite-(cat_take_drop (prefix l1 l2) (take i l1))
    -{3}(cat_take_drop (prefix l1 l2) l2)take_take/min H0/=.
  rewrite prefix_take. 
  cut:drop (prefix l1 l2) (take i l1) <> drop (prefix l1 l2) l2;2:smt(catsI). 
  rewrite (prefix_take_geq_prefix l1 l2 i) 1:/#.  
  cut:=drop_prefix_neq (take i l1) l2.
  cut/#:drop (prefix (take i l1) l2) (take i l1) <> [].
  cut:0 < size (drop (prefix (take i l1) l2) (take i l1));2:smt(size_eq0).
  rewrite size_drop 1:prefix_ge0 size_take;1:smt(prefix_ge0).
  by rewrite-prefix_take_geq_prefix /#.

move=>l3 ll hind l1 l2.
case(prefix l1 l2 < prefix l1 l3)=>//=h;progress.
+ rewrite!negb_or/=. 
  cut:=hind l1 l3 H i H0;rewrite negb_or=>[][->->]/=.
  cut:=hind l1 l2 _ i _;smt(prefix_prefix_prefix).
smt(prefix_prefix_prefix).
qed.

lemma asfadst queries prefixes (bs : block list) :
    prefix_inv queries prefixes =>
    elems (fdom queries ) <> [] =>
    all_prefixes prefixes =>
    (forall j, 0 <= j <= size bs => take j bs \in prefixes) => 
    take (prefix bs (get_max_prefix bs (elems (fdom queries))) + 1) bs = bs.
proof.
progress. 
cut h:=prefix_inv_leq bs (size bs) prefixes queries _ _ _ _ _;rewrite//=.
+ exact size_ge0.
+ rewrite H2//=;exact size_ge0.
cut->/=:prefix bs (get_max_prefix bs (elems (fdom queries))) = size bs by smt(prefix_sizel).
rewrite take_oversize/#.
qed.


lemma prefix_exchange_prefix_inv (ll1 ll2 : 'a list list) (l : 'a list) :
    (forall l2, l2 \in ll1 => l2 \in ll2) =>
    (forall (l2 : 'a list), l2 \in ll1 => forall i, take i l2 \in ll2) =>
    (forall l2, l2 \in ll2 => exists l3, l2 ++ l3 \in ll1) =>
    prefix l (get_max_prefix l ll1) = prefix l (get_max_prefix l ll2).
proof.
case(ll1 = [])=>//=[-> _ _|].
+ by case: (ll2 = [])=> [->> //=|] //= + /mem_eq0.
move=> ll1_nil incl all_prefix incl2; have ll2_nil: ll2 <> [] by smt(mem_eq0).
have:= get_max_prefix_max l ll2 (get_max_prefix l ll1) _.
+ by rewrite incl mem_get_max_prefix ll1_nil.
cut mem_ll2:=mem_get_max_prefix l ll2 ll2_nil.
cut[]l3 mem_ll1:=incl2 _ mem_ll2.
cut:=get_max_prefix_max l ll1 _ mem_ll1.
smt(prefixC prefix_leq_prefix_cat).
qed.

lemma prefix_inv_nil queries prefixes :
    prefix_inv queries prefixes =>
    elems (fdom queries) = [] => fdom prefixes \subset fset1 [].
proof.
move=>[h1 [h2 h3]] h4 x h5;rewrite in_fset1.
cut:=h3 x (size x).
rewrite take_size -mem_fdom h5/=;apply absurd=>//=h6.
rewrite h6/=negb_exists/=;smt(memE mem_fdom).
qed.

lemma aux_prefix_exchange queries prefixes (l : block list) :
    prefix_inv queries prefixes => all_prefixes prefixes =>
    elems (fdom queries) <>  [] =>
    prefix l (get_max_prefix l (elems (fdom queries))) = 
    prefix l (get_max_prefix l (elems (fdom prefixes))).
proof.
move=>[h1[h2 h3]] h5 h4;apply prefix_exchange_prefix_inv.
+ move=> l2; rewrite -memE mem_fdom=> /h2 /(_ (size l2)).
  by rewrite take_size -mem_fdom memE.
+ move=> l2; rewrite -memE mem_fdom=> /h2 + i - /(_ i).
  by rewrite -mem_fdom memE.
move=>l2; rewrite -memE=> mem_l2.
case(l2=[])=>//=hl2;1:rewrite hl2/=. 
+ move:h4;apply absurd=>//=;rewrite negb_exists/= => /mem_eq0 //=.
have:= h3 l2 (size l2); rewrite take_size hl2 -mem_fdom mem_l2.
by move=> /= [] l3 hl3; exists l3; rewrite -memE mem_fdom.
qed.

lemma prefix_exchange queries prefixes (l : block list) :
    prefix_inv queries prefixes => all_prefixes prefixes =>
    prefix l (get_max_prefix l (elems (fdom queries))) = 
    prefix l (get_max_prefix l (elems (fdom prefixes))).
proof.
move=> [h1[h2 h3]] h5.
case: (elems (fdom queries) = [])=> h4.
+ cut h6:=prefix_inv_nil queries prefixes _ h4;1:rewrite/#.
  rewrite h4/=. 
  have fdom_prefixP: fdom prefixes = fset0 \/ fdom prefixes = fset1 [].
  + by move: h6; rewrite !fsetP /(\subset); smt(in_fset0 in_fset1).
  case(elems (fdom prefixes) = [])=>//=[->//=|]h7.
  cut h8:elems (fdom prefixes) = [[]].
  + have []:= fdom_prefixP.
    + by move=> h8; move: h7; rewrite h8 elems_fset0.
    by move=> ->; rewrite elems_fset1.
  by rewrite h8=>//=.
by apply/(aux_prefix_exchange _ _ _ _ h5 h4).
qed.

pred all_prefixes_fset (prefixes : block list fset) =
  forall bs, bs \in prefixes => forall i, take i bs \in prefixes.

pred inv_prefix_block  (queries : (block list, block) fmap)
               (prefixes : (block list, block) fmap) =
  (forall (bs : block list),
    bs \in queries => queries.[bs] = prefixes.[bs]) &&
  (forall (bs : block list),
    bs \in queries => forall i, 0 < i <= size bs => take i bs \in prefixes).

lemma prefix_gt0_mem l (ll : 'a list list) : 
    0 < prefix l (get_max_prefix l ll) =>
    get_max_prefix l ll \in ll.
proof.
move:l;elim:ll=>//=;first by move=>l;elim:l.
move=>l2 ll hind l1;clear hind;move:l1 l2;elim:ll=>//=l3 ll hind l1 l2.
by case(prefix l1 l2 < prefix l1 l3)=>//=/#.
qed.

lemma inv_prefix_block_mem_take queries prefixes l i :
    inv_prefix_block queries prefixes =>
    0 < i < prefix l (get_max_prefix l (elems (fdom queries))) =>
    take i l \in prefixes.
proof.
move=>[]H_incl H_all_prefixes Hi.
rewrite (prefix_take_leq _ (get_max_prefix l (elems (fdom queries))))1:/#.
rewrite H_all_prefixes.
cut:get_max_prefix l (elems (fdom queries)) \in queries;2:smt(domE).
by rewrite -mem_fdom memE;apply prefix_gt0_mem=>/#.
smt(prefix_sizer).
qed.

lemma prefix_cat_leq_prefix_size (l1 l2 l3 : 'a list):
    prefix (l1 ++ l2) l3 <= prefix l1 l3 + size l2.
proof.
move:l2 l3;elim:l1=>//=.
+ by move=> l2 []; smt(prefix_sizel).
move=>e1 l1 hind1 l2 l3;move:e1 l1 l2 hind1;elim:l3=>//=;1:smt(size_ge0).
by move=>e3 l3 hind3 e1 l1 l2 hind1;case(e1=e3)=>//=[->>/#|h];exact size_ge0.
qed.

lemma prefix_cat1 (l1 l2 l3 : 'a list) :
    prefix (l1 ++ l2) l3 = prefix l1 l3 + 
    if prefix l1 l3 = size l1 
    then prefix l2 (drop (size l1) l3)
    else 0.
proof.
move:l2 l3;elim:l1=>//=.
+ by move=> l2 []; smt(prefix_sizel).
move=>e1 l1 hind1 l2 l3;move:e1 l1 l2 hind1;elim:l3=>//=;1:smt(size_ge0).
by move=>e3 l3 hind3 e1 l1 l2 hind1;case(e1=e3)=>//=[->>|h];smt(size_ge0).
qed.


lemma prefix_leq_prefix_cat_size (l1 l2 : 'a list) (ll : 'a list list) :
    prefix (l1++l2) (get_max_prefix (l1++l2) ll) <= 
    prefix l1 (get_max_prefix l1 ll) + 
    if (prefix l1 (get_max_prefix l1 ll) = size l1)
    then prefix l2 (get_max_prefix l2 (map (drop (size l1)) ll))
    else 0.
proof.
move:l1 l2;elim:ll=>//=.
+ smt(prefixs0).
move=>l3 ll hind{hind};move:l3;elim:ll=>//=;1:smt(prefix_cat1).
move=>l4 ll hind l3 l1 l2.
case(prefix (l1 ++ l2) l3 < prefix (l1 ++ l2) l4)=>//=.
+ rewrite 2!prefix_cat1.
  case(prefix l1 l3 = size l1)=>//=H_l1l3;case(prefix l1 l4 = size l1)=>//=H_l1l4.
  - rewrite H_l1l4 H_l1l3/=ltz_add2l=>h;rewrite h/=.
    rewrite(StdOrder.IntOrder.ler_trans _ _ _ (hind _ _ _)).
    cut->/=:prefix l1 (max_prefix l1 l4 ll) = size l1
      by move:{hind};elim:ll=>//=;smt(prefix_sizel).
    by cut->/=:prefix l1 (max_prefix l1 l3 ll) = size l1
      by move:{hind};elim:ll=>//=;smt(prefix_sizel). 
  - smt(prefix_sizel prefix_ge0).
  - cut->/=h:prefix l1 l3 < prefix l1 l4 by smt(prefix_sizel).
    rewrite(StdOrder.IntOrder.ler_trans _ _ _ (hind _ _ _)).
    cut->/=:prefix l1 (max_prefix l1 l4 ll) = size l1
      by move:{hind};elim:ll=>//=;smt(prefix_sizel). 
    smt(prefix_prefix_prefix).
  move=>H_l3l4;rewrite H_l3l4/=.
  rewrite(StdOrder.IntOrder.ler_trans _ _ _ (hind _ _ _)).
  by case(prefix l1 (max_prefix l1 l4 ll) = size l1)=>//=->;
    smt(prefix_prefix_prefix).
rewrite 2!prefix_cat1.
case(prefix l1 l3 = size l1)=>//=H_l1l3;case(prefix l1 l4 = size l1)=>//=H_l1l4.
+ by rewrite H_l1l4 H_l1l3/=ltz_add2l=>h;rewrite h/=hind.
+ rewrite H_l1l3.
  cut->/=:!size l1 < prefix l1 l4 by smt(prefix_sizel).
  rewrite(StdOrder.IntOrder.ler_trans _ _ _ (hind _ _ _))//=.
  cut->//=:prefix l1 (max_prefix l1 l3 ll) = size l1
    by move:{hind};elim:ll=>//=;smt(prefix_sizel).
  smt(prefix_prefix_prefix).
+ smt(prefix_sizel prefix_ge0).
move=>H_l3l4;rewrite H_l3l4/=.
rewrite(StdOrder.IntOrder.ler_trans _ _ _ (hind _ _ _))//=.
smt(prefix_prefix_prefix).
qed.


lemma diff_size_prefix_leq_cat (l1 l2 : 'a list) (ll : 'a list list) :
    size l1 - prefix l1 (get_max_prefix l1 ll) <= 
    size (l1++l2) - prefix (l1++l2) (get_max_prefix (l1++l2) ll).
proof.
smt(prefix_leq_prefix_cat_size prefix_sizel prefix_ge0 size_ge0 prefix_sizer size_cat).
qed.



(* lemma prefix_inv_prefix queries prefixes l : *)
(*     prefix_inv queries prefixes => *)
(*     all_prefixes prefixes => *)
(*     (elems (fdom queries) = [] => elems (fdom prefixes) = [[]]) => *)
(*     prefix l (get_max_prefix l (elems (fdom queries))) =  *)
(*     prefix l (get_max_prefix l (elems (fdom prefixes))). *)
(* proof. *)
(* move=>[? h_prefix_inv] h_all_prefixes. *)
(* case(elems (fdom queries) = [])=>//=h_nil. *)
(* + by rewrite h_nil//==>->/=. *)
(* cut h_mem_queries:=mem_get_max_prefix l (elems (fdom queries)) h_nil. *)
(* cut h_leq :=all_take_in l (prefix l (get_max_prefix l (elems (fdom queries)))) _ _ h_all_prefixes _. *)
(* + smt(prefix_ge0 prefix_sizel). *)
(* + by rewrite prefix_take h_prefix_inv memE h_mem_queries. *)
(* cut:=all_take_in l (prefix l (get_max_prefix l (elems (fdom prefixes)))) _ _ h_all_prefixes _. *)
(* + smt(prefix_ge0 prefix_sizel). *)
(* +  *)
(* rewrite prefix_take. *)
  
(*   rewrite -take_size. *)

(* print mem_get_max_prefix. *)

(* qed. *)

pred invm (m mi : ('a * 'b, 'a * 'b) fmap) =
  forall x y, m.[x] = Some y <=> mi.[y] = Some x.

lemma invm_set (m mi : ('a * 'b, 'a * 'b) fmap) x y :
    ! x \in m => ! rng m y => invm m mi => invm m.[x <- y] mi.[y <- x].
proof.
move=>Hxdom Hyrng Hinv a b; rewrite !get_setE; split.
+ case(a=x)=>//=hax hab;cut->/#:b<>y.
  by cut/#: rng m b;rewrite rngE /#.
case(a=x)=>//=hax.
+ case(b=y)=>//=hby.
  by rewrite (eq_sym y b)hby/=-Hinv hax;rewrite domE /=/# in Hxdom.
by rewrite Hinv/#.
qed.

end Prefix.
export Prefix.

(* -------------------------------------------------------------------------- *)

module C = {
  var c  : int
  var queries : (block list, block) fmap
  proc init () = {
    c       <- 0;
    queries <- empty.[[] <- b0];
  }
}.

module PC (P:PRIMITIVE) = {

  proc init () = {
    C.init();
    P.init();
  }

  proc f (x:state) = {  
    var y <- (b0,c0);
    y        <@ P.f(x);
    C.c      <- C.c + 1;
    return y;
  }

  proc fi(x:state) = {
    var y <- (b0,c0);
    y        <@ P.fi(x);
    C.c      <- C.c + 1;
    return y;
  } 

}.

module DPRestr (P:DPRIMITIVE) = {

  proc f (x:state) = {  
    var y <- (b0,c0);
    if (C.c + 1 <= max_size) {
      y        <@ P.f(x);
      C.c      <- C.c + 1;
    }
    return y;
  }

  proc fi(x:state) = {
    var y <- (b0,c0);
    if (C.c + 1 <= max_size) {
      y        <@ P.fi(x);
      C.c      <- C.c + 1;
    }
    return y;
  } 

}.

module PRestr (P:PRIMITIVE) = {

  proc init () = {
    C.init();
    P.init();
  }

  proc f = DPRestr(P).f

  proc fi = DPRestr(P).fi

}.

module FC(F:FUNCTIONALITY) = {

  proc init() = {
    F.init();
  }

  proc f (bs:block list) = {
    var b <- b0;
    if (bs \notin C.queries) {
      C.c <- C.c + size bs - prefix bs (get_max_prefix bs (elems (fdom C.queries)));
      b <@ F.f(bs);
      C.queries.[bs] <- b;
    } else {
      b <- oget C.queries.[bs];
    }
    return b;
  }
}.

module DFRestr(F:DFUNCTIONALITY) = {

  proc f (bs:block list) = {
    var b <- b0;
    if (bs \notin C.queries) {
      if (C.c + size bs - prefix bs (get_max_prefix bs (elems (fdom C.queries))) <= max_size) {
        C.c <- C.c + size bs - prefix bs (get_max_prefix bs (elems (fdom C.queries)));
        b <@ F.f(bs);
        C.queries.[bs] <- b;
      }
    } else {
      b <- oget C.queries.[bs];
    }
    return b;
  }
}.

module FRestr(F:FUNCTIONALITY) = {

  proc init() = {
    Redo.init();
    F.init();
  }

  proc f = DFRestr(F).f 

}.

(* -------------------------------------------------------------------------- *)
(* This allow swap the counting from oracle to adversary *)
module DRestr(D:DISTINGUISHER, F:DFUNCTIONALITY, P:DPRIMITIVE) = {
  proc distinguish() = {
    var b;
    C.init();
    b <@ D(DFRestr(F), DPRestr(P)).distinguish();
    return b;
  }
}.

lemma rp_ll (P<:DPRIMITIVE{C}): islossless P.f => islossless DPRestr(P).f.
proof. move=>Hll;proc;sp;if;auto;call Hll;auto. qed.

lemma rpi_ll (P<:DPRIMITIVE{C}): islossless P.fi => islossless DPRestr(P).fi.
proof. move=>Hll;proc;sp;if;auto;call Hll;auto. qed.

lemma rf_ll (F<:DFUNCTIONALITY{C}): islossless F.f => islossless DFRestr(F).f.
proof. move=>Hll;proc;sp;if;auto;if=>//;auto;call Hll;auto. qed.

lemma DRestr_ll (D<:DISTINGUISHER{C}): 
  (forall (F<:DFUNCTIONALITY{D})(P<:DPRIMITIVE{D}),
     islossless P.f => islossless P.fi => islossless F.f =>
     islossless D(F,P).distinguish) =>
  forall (F <: DFUNCTIONALITY{DRestr(D)}) (P <: DPRIMITIVE{DRestr(D)}),
    islossless P.f =>
    islossless P.fi => islossless F.f => islossless DRestr(D, F, P).distinguish.
proof.
  move=> D_ll F P p_ll pi_ll f_ll;proc.
  call (D_ll (DFRestr(F)) (DPRestr(P)) _ _ _).
  + by apply (rp_ll P). + by apply (rpi_ll P). + by apply (rf_ll F). 
  by inline *;auto.
qed.

section RESTR. 

  declare module F:FUNCTIONALITY{C}.
  declare module P:PRIMITIVE{C,F}.
  declare module D:DISTINGUISHER{F,P,C}.

  lemma swap_restr &m: 
    Pr[Indif(FRestr(F), PRestr(P), D).main()@ &m: res] =
    Pr[Indif(F,P,DRestr(D)).main()@ &m: res].
  proof.
    byequiv=>//;auto.
    proc;inline *;wp. 
    swap{1}[1..2] 3;sim;auto;call(:true);auto. 
  qed.

end section RESTR.

section COUNT.

  declare module P:PRIMITIVE{C}.
  declare module CO:CONSTRUCTION{C,P}.
  declare module D:DISTINGUISHER{C,P,CO}.

  axiom f_ll  : islossless P.f.
  axiom fi_ll : islossless P.fi.

  axiom CO_ll : islossless CO(P).f.

  axiom D_ll (F <: DFUNCTIONALITY{D}) (P <: DPRIMITIVE{D}):
    islossless P.f => islossless P.fi => islossless F.f => 
    islossless D(F, P).distinguish.

  lemma Pr_restr &m : 
    Pr[Indif(FC(CO(P)), PC(P), D).main()@ &m:res /\ C.c <= max_size] <= 
    Pr[Indif(CO(P), P, DRestr(D)).main()@ &m:res].
  proof.
    byequiv (_: ={glob D, glob P, glob CO} ==> C.c{1} <= max_size => ={res})=>//;
      2:by move=> ??H[]?/H<-.
    symmetry;proc;inline *;wp.
    call (_: max_size < C.c, ={glob P, glob CO, glob C}).
    + apply D_ll.
    + proc; sp;if{1};1:by auto;call(_:true);auto. 
      by auto;call{2} f_ll;auto=>/#. 
    + by move=> ?_;proc;sp;auto;if;auto;call f_ll;auto.
    + by move=> _;proc;sp;auto;call f_ll;auto=>/#.
    + proc;sp;auto;if{1};1:by auto;call(_:true);auto.
      by call{2} fi_ll;auto=>/#. 
    + by move=> ?_;proc;sp;auto;if;auto;call fi_ll;auto.
    + by move=> _;proc;sp;auto;call fi_ll;auto=>/#.
    + proc;inline*;sp 1 1;if;auto;if{1};auto;1:by call(_: ={glob P});auto;sim.
      by call{2} CO_ll;auto=>/#.
    + by move=> ?_;proc;sp;if;auto;if;auto;call CO_ll;auto.
    + by move=> _;proc;sp;if;auto;call CO_ll;auto;smt(prefix_sizel).
    auto;call (_:true);auto;call(:true);auto=>/#.
  qed.

end section COUNT.

(* -------------------------------------------------------------------------- *)
op has (P : 'a -> 'b -> bool) (m : ('a,'b) fmap) =
  List.has (fun x=> x \in m /\ P x (oget m.[x])) (elems (fdom m)).

lemma hasP (P : 'a -> 'b -> bool) (m : ('a,'b) fmap):
  has P m <=> exists x, x \in m /\ P x (oget m.[x]).
proof.
rewrite hasP; split=> [] [x] [#].
+ by move=> _ x_in_m Pxmx; exists x.
by move=> x_in_m Pxmx; exists x; rewrite -memE mem_fdom.
qed.

op find (P : 'a -> 'b -> bool) (m : ('a,'b) fmap) =
  onth (elems (fdom m)) (find (fun x=> x \in m /\ P x (oget m.[x])) (elems (fdom m))).

lemma find_none (P : 'a -> 'b -> bool) (m : ('a,'b) fmap):
  has P m <=> find P m <> None.
proof.
rewrite has_find; split=> [h|].
+ by rewrite (onth_nth witness) 1:find_ge0 /=.
by apply/contraLR=> h; rewrite onth_nth_map nth_default 1:size_map 1:lezNgt.
qed.

lemma findP (P : 'a -> 'b -> bool) (m : ('a,'b) fmap):
  (exists x, find P m = Some x /\ x \in m /\ P x (oget m.[x])) \/
  (find P m = None /\ forall x, x \in m => !P x (oget m.[x])).
proof.
case: (has P m)=> ^ => [hasPm|nothasPm]; rewrite hasP.
+ move=> [x] [] x_in_m Pxmx; left.
  exists (nth witness (elems (fdom m)) (find (fun x=> x \in m /\ P x (oget m.[x])) (elems (fdom m)))).
  rewrite /find (onth_nth witness) /=.
  + by rewrite find_ge0 /=; apply/has_find/hasPm.
  by move: hasPm=> /(nth_find witness) /=.
rewrite negb_exists /=.
move: nothasPm; rewrite find_none=> /= -> h; right=> /= x.
by move: (h x); rewrite negb_and=> /#.
qed.

(** Operators and properties of handles *)
op hinv (handles:handles) (c:capacity) = 
   find (fun _ => pred1 c \o fst) handles.

op hinvK (handles:handles) (c:capacity) = 
   find (fun _ => pred1 c) (restr Known handles).

op huniq (handles:handles) = 
  forall h1 h2 cf1 cf2, 
     handles.[h1] = Some cf1 => 
     handles.[h2] = Some cf2 => 
     cf1.`1 = cf2.`1 => h1 = h2.

lemma hinvP handles c:
  if hinv handles c = None then forall h f, handles.[h] <> Some(c,f)
  else exists f, handles.[oget (hinv handles c)] = Some(c,f).
proof.
  have /= @/pred1 @/(\o) [[h []->[]Hmem <<-]|[]->H h f]/=  := 
    findP (fun (_ : handle) => pred1 c \o fst) handles.
  + exists (oget handles.[h]).`2.
    by move: Hmem; rewrite domE; case: (handles.[h])=> //= - [].
  by cut := H h;rewrite domE /#.
qed.

lemma huniq_hinv (handles:handles) (h:handle): 
  huniq handles => dom handles h => hinv handles (oget handles.[h]).`1 = Some h.
proof.
  move=> Huniq;pose c := (oget handles.[h]).`1.
  cut:=Huniq h;cut:=hinvP handles c.
  case (hinv _ _)=> /=[Hdiff _| h' +/(_ h')].
  + rewrite domE /=; move: (Hdiff h (oget handles.[h]).`2).
    by rewrite /c; case: handles.[h]=> //= - [].
  move=> [f ->] /(_ (oget handles.[h]) (c,f)) H1 H2;rewrite H1 //.
  by move: H2; rewrite domE; case: (handles.[h]).
qed.

lemma hinvKP handles c:
  if hinvK handles c = None then forall h, handles.[h] <> Some(c,Known)
  else handles.[oget (hinvK handles c)] = Some(c,Known).
proof.
  rewrite /hinvK.
  cut /= @/pred1/= [[h]|][->/=]:= findP (+ pred1 c) (restr Known handles).
  + by rewrite domE restrP;case (handles.[h])=>//= /#.
  by move=>+h-/(_ h);rewrite domE restrP => H1/#. 
qed.

lemma huniq_hinvK (handles:handles) c: 
  huniq handles => rng handles (c,Known) => handles.[oget (hinvK handles c)] = Some(c,Known).
proof.
  move=> Huniq;rewrite rngE=> -[h]H;case: (hinvK _ _) (Huniq h) (hinvKP handles c)=>//=.
  by move=>_/(_ h);rewrite H.
qed.

lemma huniq_hinvK_h h (handles:handles) c: 
  huniq handles => handles.[h] = Some (c,Known) => hinvK handles c = Some h.
proof.
  by move=> Huniq;case: (hinvK _ _) (hinvKP handles c)=>/= [ H | h' /Huniq H/H //]; apply H.
qed.

(* -------------------------------------------------------------------------- *)
(** The initial Game *)
module GReal(D:DISTINGUISHER) = RealIndif(SqueezelessSponge, PC(Perm), D).

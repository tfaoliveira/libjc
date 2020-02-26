(*------------------- Common Definitions and Lemmas --------------------*)
require import Core Int IntExtra IntDiv Real List Distr.
require import Ring StdRing StdOrder StdBigop BitEncoding DProd.
require (*--*) FinType BitWord PRP Monoid.
(*---*) import IntID IntOrder Bigint Bigint.BIA IntDiv.

pragma +implicits.


(* -------------------------------------------------------------------- *)
op r : { int | 2 <= r } as ge2_r.
op c : { int | 0 <  c } as gt0_c.

type block.    (* ~ bitstrings of size r *)
type capacity. (* ~ bitstrings of size c *)

(* -------------------------------------------------------------------- *)

lemma gt0_r : 0 < r.
proof. by apply/(ltr_le_trans 2)/ge2_r. qed.

lemma ge0_r : 0 <= r.
proof. by apply/ltrW/gt0_r. qed.

lemma ge0_c : 0 <= c.
proof. by apply/ltrW/gt0_c. qed.

(* -------------------------------------------------------------------- *)
clone export BitWord as Capacity with
  type word <- capacity,
    op n    <- c
  proof gt0_n by apply/gt0_c

  rename "word"     as "capacity"
         "Word"     as "Capacity"
         (* "dunifin"  as "cdistr" *)
         "zerow"    as "c0".
export Capacity DCapacity.

clone export BitWord as Block with
  type word <- block,
    op n    <- r
  proof gt0_n by apply/gt0_r

  rename "word"     as "block"
         "Word"     as "Block"
         (* "dunifin"  as "bdistr" *)
         "zerow"    as "b0".
export DBlock.

op cdistr = DCapacity.dunifin.
op bdistr = DBlock.dunifin.


(* ------------------------- Auxiliary Lemmas ------------------------- *)

lemma dvdz_close (n : int) :
  r %| n => 0 < n < 2 * r => n = r.
proof.
move=> dvd_rn.
have [m] <- : exists m, m * r = n
  by exists (n %/ r); by rewrite divzK.
move=> [gt0_m_tim_r m_tim_r_lt_2r].
case: (m = 1)=> // /ltr_total [/ltz1 le0_m | gt1_m].
rewrite pmulr_lgt0 1:gt0_r in gt0_m_tim_r.
have // : 0 < 0 by rewrite (@ltr_le_trans m).
rewrite ltr_pmul2r 1:gt0_r in m_tim_r_lt_2r.
rewrite -lez_add1r /= in gt1_m.
have // : 2 < 2 by rewrite (@ler_lt_trans m).
qed.

lemma chunk_nil' ['a] r : BitChunking.chunk r [<:'a>] = [].
proof. by rewrite /chunk /= mkseq0. qed.

lemma chunk_sing' r (xs : bool list) :
  0 < r => size xs = r => BitChunking.chunk r xs = [xs].
proof.
move=> gt0_r sz_xs_eq_r.
by rewrite /bits2blocks /chunk sz_xs_eq_r divzz ltr0_neq0 1:gt0_r b2i1
           mkseq1 /= drop0 -sz_xs_eq_r take_size.
qed.

lemma b0P : b0 = mkblock (nseq r false).
proof.
rewrite blockP=> i ge0_i_ltr; rewrite offunifE ge0_i_ltr /= getE ge0_i_ltr /=.
rewrite ofblockK 1:size_nseq 1:/#.
by rewrite nth_nseq.
qed.

lemma bits2w_inj_eq (cs ds : bool list) :
  size cs = r => size ds = r => mkblock cs = mkblock ds <=> cs = ds.
proof. by move=> s_cs_r s_ds_r; split=> //=; exact/mkblock_pinj. qed.

lemma last_drop_all_but_last (y : 'a, xs : 'a list) :
  xs = [] \/ drop (size xs - 1) xs = [last y xs].
proof.
elim xs=> // z zs ih /=.
case (size zs <= 0)=> [le0_sz_zs | gt0_sz_zs].
have sz_zs_eq0 : size zs = 0
  by rewrite (@ler_asym (size zs) 0); split=> // _; rewrite size_ge0.
by have -> : zs = [] by rewrite -size_eq0.
case (zs = [])=> // zs_non_nil. elim ih=> //.
by rewrite addzC (@last_nonempty y z).
qed.

(*------------------------------ Primitive -----------------------------*)
clone export PRP as PRPt with
  type D  <- block * capacity.

clone export StrongPRP as PRPSec.

clone export RP as Perm with
  op   dD <- bdistr `*` cdistr
  rename
    [module type] "PRP" as "PRIMITIVE"
    [module] "RP" as "Perm"
  proof dD_ll.
realize dD_ll.
by apply/dprod_ll; rewrite Block.DBlock.dunifin_ll Capacity.DCapacity.dunifin_ll.
qed.

(*---------------------- Needed Blocks Computation ---------------------*)

lemma needed_blocks0 : (0 + r - 1) %/ r = 0.
proof.
rewrite -divz_eq0 1:gt0_r; smt(gt0_r).
qed.

lemma needed_blocks_non_pos (n : int) :
  n <= 0 => (n + r - 1) %/ r <= 0.
proof.
move=> le0_n.
rewrite (lez_trans ((r - 1) %/ r)) 1:leq_div2r 1:/# 1:ge0_r.
have -> // : (r - 1) %/ r = 0
  by rewrite -divz_eq0 1:gt0_r; smt(gt0_r).
qed.

lemma needed_blocks_suff (n : int) :
  n <= (n + r - 1) %/ r * r.
proof.
have -> : (n + r - 1) %/r * r = (n + r - 1) - (n + r - 1)%% r
  by rewrite {2}(@divz_eq (n + r - 1) r) #ring.
by rewrite -(@addzA n) -(@addzA n) lez_addl subz_ge0 -ltzS -(@addzA r) /=
           ltz_pmod gt0_r.
qed.

lemma needed_blocks_correct (n : int) :
  0 <= (n + r - 1) %/ r * r - n < r.
proof.
split=> [| _].
by rewrite subz_ge0 needed_blocks_suff.
have -> : (n + r - 1) %/r * r = (n + r - 1) - (n + r - 1)%% r
  by rewrite {2}(@divz_eq (n + r - 1) r) #ring.
have -> : n + r - 1 - (n + r - 1) %% r - n = r - 1 - (n + r - 1) %% r
  by ring.
rewrite ltzE -(@ler_add2r (-r)) /=.
cut -> : r - 1 - (n + r - 1) %% r + 1 - r = -(n + r - 1) %% r by ring.
by rewrite oppz_le0 modz_ge0 gtr_eqF 1:gt0_r.
qed.

lemma needed_blocks_prod_r (n : int) :
  (n * r + r - 1) %/ r = n.
proof.
rewrite -addzA divzMDl 1:gtr_eqF 1:gt0_r // divz_small //.
smt(gt0_r).
qed.

lemma needed_blocks_eq_div_r (n : int) :
  r %| n <=> n %/ r = (n + r - 1) %/ r.
proof.
split=> [r_dvd_n | eq_div].
have {2}<- := divzK r n _; first trivial.
by rewrite needed_blocks_prod_r.
rewrite dvdzE.
rewrite {2}(@divz_eq n r) -!addrA @divzMDl 1:gtr_eqF 1:gt0_r //
        -{1}(@addz0 (n %/ r)) in eq_div.
have eq_div_simp : (n %% r + (r - 1)) %/ r = 0
  by rewrite (@addzI (n %/ r) 0 ((n %% r + (r - 1)) %/ r)).
have [_ n_mod_r_plus_r_min1_lt_r] : 0 <= n %% r + (r - 1) < r
  by rewrite divz_eq0 1:gt0_r.
have n_mod_r_plus_r_min1_lt_r_simp : n %% r <= 0
  by rewrite -(@lez_add2r (r - 1)) /= -ltzS -addzA /=.
by apply lez_anti; split=> // _; rewrite modz_ge0 1:gtr_eqF 1:gt0_r.
qed.

lemma needed_blocks_succ_eq_div_r (n : int) :
  ! r %| n <=> n %/ r + 1 = (n + r - 1) %/ r.
proof.
split=> [not_r_dvd_n | succ_eq_div].
have {2}-> := divz_eq n r.
rewrite -!addrA divzMDl 1:gtr_eqF 1:gt0_r //; ring.
rewrite dvdzE in not_r_dvd_n.
have gt0_mod : 0 < n %% r
  by rewrite ltz_def=> |>; rewrite modz_ge0 1:gtr_eqF 1:gt0_r.
have [r_le_n_mod_r_plus_r_min1 n_mod_r_plus_r_min1_lt_r] :
       r <= n %% r + (r - 1) < r + r.
  split=> [| _].
  by rewrite (@addrC r (-1)) addrA -{1}add0z lez_add2r -ltzS
             -addrA addNz.
  by rewrite (@addrC r (-1)) addrA ltz_add2r -(@ltz_add2r 1) -addrA /=
     (@ltr_trans r) 1:ltz_pmod 1:gt0_r -{1}addz0 ler_lt_add 1:lezz ltr01.
have [m [-> [ge0_m lt_mr]]] :
  exists (m : int), n %% r + (r - 1) = r + m /\ 0 <= m < r.
  exists (n %% r + (r - 1) - r).
  split; first ring.
  split=> [| _].
  by rewrite -(@lez_add2r r) -addrA addNz.
  by rewrite -(@ltz_add2r r) -addrA addNz.
rewrite -{1}(@mul1z r) divzMDl 1:gtr_eqF 1:gt0_r //
        opprD addrA /=.
rewrite divz_small; [by rewrite ger0_norm 1:ge0_r | done].
have not_eq_dvd : n %/ r <> (n + r - 1) %/ r by smt().
by rewrite needed_blocks_eq_div_r.
qed.

lemma needed_blocks_rel_div_r (n : int) :
  n %/ r = (n + r - 1) %/ r \/ n %/ r + 1 = (n + r - 1) %/ r.
proof.
case: (r %| n)=> [r_dvd_n | not_r_dvd_n].
left; by apply/needed_blocks_eq_div_r.
right; by apply/needed_blocks_succ_eq_div_r.
qed.

(* ------------------------- Padding/Unpadding ------------------------ *)

op num0 (n : int) = (-(n + 2)) %% r.

op mkpad (n : int) = true :: rcons (nseq (num0 n) false) true.

op pad (s : bool list) = s ++ mkpad (size s).

op unpad (s : bool list) =
  if !last false s then None else
  let i = index true (behead (rev s)) in
  if i + 1 = size s then None
  else let n = size s - (i + 2) in
       if i = num0 n then Some (take n s) else None.

lemma rev_mkpad n : rev (mkpad n) = mkpad n.
proof. by rewrite /mkpad rev_cons rev_rcons rev_nseq. qed.

lemma last_mkpad b n : last b (mkpad n) = true.
proof. by rewrite !(last_cons, last_rcons). qed.

lemma head_mkpad b n : head b (mkpad n) = true.
proof. by []. qed.

lemma last_pad b s : last b (pad s) = true.
proof. by rewrite last_cat last_mkpad. qed.

lemma size_mkpad n : size (mkpad n) = num0 n + 2.
proof.
rewrite /mkpad /= size_rcons size_nseq max_ler.
by rewrite /num0 modz_ge0 gtr_eqF ?gt0_r. by ring.
qed.

lemma size_pad_equiv (m : int) :
  0 <= m => m + num0 m + 2 = (m + 1) %/ r * r + r.
proof.
move=> ge0_m.
by rewrite /num0 modNz 1:/# 1:gt0_r -(@addrA _ 2) /= modzE #ring.
qed.

lemma size_padE (s : bool list) :
  size (pad s) = size s + num0 (size s) + 2.
proof. by rewrite /pad size_cat size_mkpad addrA. qed.

lemma size_pad (s : bool list) :
  size (pad s) = (size s + 1) %/ r * r + r.
proof. by rewrite size_padE size_pad_equiv 1:size_ge0. qed.

lemma size_pad_dvd_r s : r %| size (pad s).
proof. by rewrite size_pad dvdzD 1:dvdz_mull dvdzz. qed.

lemma dvd_r_num0 (m : int) : r %| (m + num0 m + 2).
proof. by rewrite /num0 /(%|) addrAC modzDmr subrr. qed.

lemma num0_ge0 (m : int) : 0 <= num0 m.
proof. by rewrite /num0 modz_ge0 ?gtr_eqF ?gt0_r. qed.

lemma num0_ltr (m : int) : num0 m < r.
proof. by rewrite /num0 ltz_pmod gt0_r. qed.

lemma index_true_behead_mkpad n :
  index true (behead (mkpad n)) = num0 n.
proof.
rewrite /mkpad -cats1 index_cat mem_nseq size_nseq.
by rewrite max_ler // /num0 modz_ge0 gtr_eqF ?gt0_r.
qed.

lemma padE (s : bool list, n : int) :
  0 <= n < r => r %| (size s + n + 2) =>
  pad s = s ++ [true] ++ nseq n false ++ [true].
proof.
move=> lt_0r dvdr; rewrite -!catA /pad /mkpad /= cats1 /num0.
by do! congr; rewrite -(dvdz_modzDr dvdr) modz_small 2:#ring /#.
qed.

lemma padK : pcancel pad unpad.
proof.
move=> s @/unpad; rewrite last_pad /= rev_cat rev_mkpad.
pose i := index _ _.
have ^iE {1 2}->: i = (-(size s + 2)) %% r.
  rewrite /i behead_cat //= index_cat {1}/mkpad /= mem_rcons /=.
  by rewrite index_true_behead_mkpad.
pose b := _ = size _; case b => @/b - {b}.
  rewrite modNz ?gt0_r ?ltr_spaddr ?size_ge0 //.
  rewrite -(@addrA _ 2) size_pad (@addrC _ r) -!addrA => /addrI.
  rewrite addrCA /= -subr_eq0 -opprD oppr_eq0 addrC -divz_eq.
  by rewrite addz_neq0 ?size_ge0.
move=> sz {sz}; rewrite /num0.
have -> : size (pad s) - (i + 2) + 2 = size (pad s) - i by ring.
pose b := _ = _ %% r; case b=> @/b - {b}; last first.
have -> // : size s + 2 = size (pad s) - i
  by rewrite /pad size_cat size_mkpad iE #ring.
move=> sz {sz} /=; rewrite iE -size_mkpad /pad size_cat addrK.
by rewrite take_cat /= take0 cats0.
qed.

lemma unpadK : ocancel unpad pad.
proof.
move=> s @/unpad; case: (last false s)=> //=.
elim/last_ind: s=> //= s b ih {ih}; rewrite last_rcons => ->.
rewrite rev_rcons /= size_rcons -(inj_eq (addIr (-1))) /= ?addrK.
pose i := index _ _; case: (i = size s)=> // ne_is @/pad @/num0.
have lt_is: i < size s by rewrite ltr_neqAle ne_is -size_rev index_size.
have [ge0_i lt_siz_s_i] : 0 <= i < size s.
  have le_siz_s_i : i <= size s by rewrite /i - size_rev index_size.
  split=> [| _]; [rewrite index_ge0 | rewrite ltr_neqAle //].
pose j := (size s + _ - _); case: (i = (-(j + 2)) %% r)=> iE; 2:done. (* => // iE. Loops in deploy-kms *)
apply/eq_sym; rewrite -{1}(@cat_take_drop j (rcons _ _)); congr.
have jE: j = size s - (i + 1) by rewrite /j #ring.
have [ge0_j lt_js]: 0 <= j < size s by move=> /#.
rewrite -cats1 drop_cat lt_js /= /mkpad -cats1 -cat_cons; congr=> //=.
rewrite size_take // size_cat /= ltr_spsaddr //= /num0 -iE.
have sz_js: size (drop j s) = i+1; last apply/(eq_from_nth false).
+ by rewrite size_drop //= max_ler ?subr_ge0 ?ltrW // /j #ring.
+ by rewrite sz_js /= addrC size_nseq max_ler.
rewrite sz_js => k [ge0_k lt_kSi]; rewrite nth_drop //.
move/ler_eqVlt: ge0_k => [<-|] /=.
  by rewrite jE -nth_rev ?nth_index // -index_mem size_rev.
move=> lt0_k; rewrite gtr_eqF //= nth_nseq 1:/#.
have ->: j + k = (size s) - ((i-k) + 1) by rewrite /j #ring.
by rewrite -nth_rev 1:/# &(@negbRL _ true) &(before_index) /#.
qed.

inductive unpad_spec (t : bool list) =
  Unpad (s : bool list, n : int) of
      (0 <= n < r)
    & (r %| (size s + n + 2))
    & (t = s ++ [true] ++ nseq n false ++ [true]).

lemma nosmt unpadP (t : bool list) :
  unpad t <> None <=> unpad_spec t.
proof.
split=> [|[s n lt_nr dvd ->]]; last by rewrite -padE ?padK.
case _: (unpad t) => // s sE _.
have ->: t = pad s by rewrite -(unpadK t) sE.
apply/(Unpad s (num0 (size s))).
  by rewrite num0_ge0 num0_ltr. by rewrite dvd_r_num0.
by rewrite -padE ?dvd_r_num0 // num0_ge0 num0_ltr.
qed.

(*------------------------------ Chunking ------------------------------*)

op chunk (bs : bool list) = BitChunking.chunk r bs.

lemma size_chunk bs : size (chunk bs) = size bs %/ r.
proof. by apply/BitChunking.size_chunk/gt0_r. qed.

lemma in_chunk_size bs b: mem (chunk bs) b => size b = r.
proof. by apply/BitChunking.in_chunk_size/gt0_r. qed.

lemma chunkK bs : r %| size bs => flatten (chunk bs) = bs.
proof. by apply/BitChunking.chunkK/gt0_r. qed.

lemma chunk_nil : chunk [] = [].
proof. by apply/(@chunk_nil' r). qed.

lemma chunk_sing (xs : bool list) : size xs = r => chunk xs = [xs].
proof. by apply/chunk_sing'/gt0_r. qed.

lemma chunk_cat (xs ys : bool list) :
  r %| size xs => chunk (xs ++ ys) = chunk xs ++ chunk ys.
proof. by apply/BitChunking.chunk_cat/gt0_r. qed.

lemma chunk_padK : pcancel (chunk \o pad) (unpad \o flatten).
proof. by move=> s @/(\o); rewrite chunkK 1:size_pad_dvd_r padK. qed.

lemma flattenK bs :
  (forall b, mem bs b => size b = r) => chunk (flatten bs) = bs.
proof. by apply/BitChunking.flattenK/gt0_r. qed.

(*--------------- Converting Between Block Lists and Bits --------------*)

op blocks2bits (xs:block list) : bool list = flatten (map ofblock xs).

lemma blocks2bits_nil : blocks2bits [] = [].
proof. by rewrite /blocks2bits /= flatten_nil. qed.

lemma blocks2bits_sing (x : block) : blocks2bits [x] = ofblock x.
proof. by rewrite /blocks2bits /flatten /= cats0. qed.

lemma blocks2bits_cat (xs ys : block list) :
  blocks2bits (xs ++ ys) = blocks2bits xs ++ blocks2bits ys.
proof. by rewrite /blocks2bits map_cat flatten_cat. qed.

lemma size_blocks2bits (xs : block list) :
  size (blocks2bits xs) = r * size xs.
proof.
elim: xs=> [| x xs ih]; first by rewrite blocks2bits_nil.
rewrite -cat1s blocks2bits_cat blocks2bits_sing size_cat //.
rewrite size_cat size_block ih /= #ring.
qed.

lemma size_blocks2bits_dvd_r (xs : block list) : r %| size(blocks2bits xs).
proof. by rewrite size_blocks2bits dvdz_mulr dvdzz. qed.

op bits2blocks (xs : bool list) : block list = map mkblock (chunk xs).

lemma bits2blocks_nil : bits2blocks [] = [].
proof. by rewrite /bits2blocks chunk_nil. qed.

lemma bits2blocks_sing (xs : bool list) :
  size xs = r => bits2blocks xs = [mkblock xs].
proof. by move=> sz_xs_eq_r; rewrite /bits2blocks chunk_sing. qed.

lemma bits2blocks_cat (xs ys : bool list) : r %| size xs => r %| size ys =>
  bits2blocks (xs ++ ys) = bits2blocks xs ++ bits2blocks ys.
proof.
move=> r_dvd_sz_xs r_dvd_sz_ys.
by rewrite /bits2blocks chunk_cat 2:map_cat.
qed.

lemma blocks2bitsK : cancel blocks2bits bits2blocks.
proof.
move=> xs; rewrite /blocks2bits /bits2blocks flattenK.
  by move=> b /mapP [x [_ ->]];rewrite size_block.
rewrite -map_comp -{2}(@map_id xs) /(\o) /=.
by apply eq_map=> @/idfun x /=; exact/mkblockK.
qed.

lemma bits2blocksK (bs : bool list) :
  r %| size bs => blocks2bits(bits2blocks bs) = bs.
proof.
move=> dvd_r_bs; rewrite /blocks2bits /bits2blocks -map_comp.
have map_tolistK :
  forall (xss : bool list list),
  (forall (xs : bool list), mem xss xs => size xs = r) =>
  map (ofblock \o mkblock) xss = xss.
+ elim=> [// | xs yss ih eqr_sz /=]; split.
    by apply ofblockK; rewrite eqr_sz.
  by apply/ih => zs mem_zss_zs; rewrite eqr_sz //=; right.
by rewrite map_tolistK; [apply in_chunk_size | exact chunkK].
qed.

(*-------------- Padding to Blocks / Unpadding from Blocks -------------*)

op pad2blocks : bool list -> block list  = bits2blocks \o pad.
op unpad_blocks : block list -> bool list option = unpad \o blocks2bits.

lemma pad2blocksK : pcancel pad2blocks unpad_blocks.
proof.
move=> xs @/pad2blocks @/unpad_blocks @/(\o).
by rewrite bits2blocksK 1:size_pad_dvd_r padK.
qed.

lemma unpadBlocksK : ocancel unpad_blocks pad2blocks.
proof.
move=> xs; rewrite /pad2blocks /unpad_blocks /(\o).
pose bs := blocks2bits xs.
case (unpad bs = None) => [-> // | unpad_bs_neq_None].
have unpad_bs : unpad bs = Some(oget(unpad bs))
  by move: unpad_bs_neq_None; case (unpad bs).
rewrite unpad_bs /=.
have -> : pad(oget(unpad bs)) = bs
  by rewrite - {2} (unpadK bs) unpad_bs.
by rewrite /bs blocks2bitsK.
qed.

lemma pad2blocks_inj : injective pad2blocks.
proof.
apply /(pcan_inj pad2blocks unpad_blocks) /pad2blocksK.
qed.

lemma size_pad2blocks s :
  size (pad2blocks s) = (size s + 1) %/ r + 1.
proof.
rewrite /pad2blocks /bits2blocks /(\o) size_map size_chunk size_pad.
have -> : (size s + 1) %/ r * r + r = ((size s + 1) %/r + 1) * r
  by rewrite mulzDl mul1r.
by rewrite mulzK 1:gtr_eqF 1:gt0_r.
qed.

(*-------------------------- Extending/Stripping -----------------------*)

op extend (xs : block list) (n : int) =
  xs ++ nseq n b0.

op strip (xs : block list) =
  let i = find (fun x => x <> b0) (rev xs) in
  (take (size xs - i) xs, i).

lemma strip_ge0 (xs : block list) :
  0 <= (strip xs).`2.
proof. by rewrite /strip /= find_ge0. qed.

lemma extendK (xs : block list) (n : int) :
  last b0 xs <> b0 => 0 <= n => strip(extend xs n) = (xs, n).
proof.
move=> xs_ends_not_b0 ge0_n; rewrite /strip /extend /=.
rewrite rev_cat rev_nseq size_cat size_nseq max_ler // -addzA.
have head_rev_xs_neq_b0 : head b0 (rev xs) <> b0 by rewrite - last_rev revK //.
have -> : rev xs = head b0 (rev xs) :: behead (rev xs).
  by rewrite head_behead //; case: (rev xs) head_rev_xs_neq_b0.
pose p := fun (x : block) => x <> b0.
have has_p_full : has p (nseq n b0 ++ head b0 (rev xs) :: behead (rev xs))
  by apply has_cat; right; simplify; left.
have not_has_p_nseq : ! has p (nseq n b0) by rewrite has_nseq.
have -> : find p (nseq n b0 ++ head b0 (rev xs) :: behead (rev xs)) = n.
  rewrite find_cat not_has_p_nseq /= size_nseq max_ler //.
  have -> // : p (head b0 (rev xs)) by trivial.
by rewrite (@addzC n) addNz /= take_size_cat.
qed.

lemma stripK (xs : block list) :
  extend (strip xs).`1 (strip xs).`2 = xs.
proof.
rewrite /extend /strip eq_sym /=; pose i := find _ _.
rewrite -{1}(@cat_take_drop (size xs - i) xs); congr.
have [ge0_i le_ixs]: 0 <= i <= size xs.
  by rewrite find_ge0 -size_rev find_size.
have sz_drop: size (drop (size xs - i) xs) = i.
  rewrite size_drop ?subr_ge0 // opprD opprK.
  by rewrite addrA /= max_ler.
apply/(eq_from_nth b0) => [|j]; rewrite ?size_nseq ?max_ler //.
rewrite sz_drop=> -[ge0_j lt_ji]; rewrite nth_nseq //.
rewrite nth_drop ?subr_ge0 // -{1}revK nth_rev ?size_rev.
  rewrite addr_ge0 ?subr_ge0 //= -ltr_subr_addr.
  by rewrite ltr_add2l ltr_opp2.
have @/predC1 /= ->// := (before_find b0 (predC1 b0)).
pose s := (_ - _)%Int; rewrite -/i (_ : s = i - (j+1)) /s 1:#ring.
by rewrite subr_ge0 -ltzE lt_ji /= ltr_snaddr // oppr_lt0 ltzS.
qed.

(*------------------------------ Validity ------------------------------*)

(* in Sponge *)

op valid_toplevel (_ : bool list) = true.

(* in BlockSponge *)

op valid_block (xs : block list) = unpad_blocks xs <> None.

lemma valid_pad2blocks (bs : bool list) :
  valid_block(pad2blocks bs).
proof.
by rewrite /valid_block pad2blocksK.
qed.

inductive valid_block_spec (xs : block list) =
  ValidBlock (s : bool list, n : int) of
      (0 <= n < r)
    & (blocks2bits xs = s ++ [true] ++ nseq n false ++ [true]).

lemma nosmt valid_blockP (xs : block list) :
  valid_block xs <=> valid_block_spec xs.
proof.
split=> [vb | [s n] [rng_n b2b] b2b_xs_eq].
have [up _] := (unpadP (blocks2bits xs)).
rewrite vb /= in up; case: up=> [s n rng_n _ b2b].
by apply (@ValidBlock xs s n).
rewrite unpadP (@Unpad (blocks2bits xs) s n) //.
have <- : size (blocks2bits xs) = size s + n + 2
  by rewrite b2b_xs_eq 3!size_cat /= size_nseq max_ler /#ring.
by apply size_blocks2bits_dvd_r.
qed.

lemma valid_block_ends_not_b0 (xs : block list) :
  valid_block xs => last b0 xs <> b0.
proof.
move=> vb_xs; have bp := valid_blockP xs.
rewrite vb_xs /= in bp.
move: bp=> [s n] _ b2b_xs_eq.
case: (last b0 xs <> b0)=> [// | last_xs_eq_b0]. 
rewrite negbK in last_xs_eq_b0.
have xs_non_nil : xs <> [].
  case: xs b2b_xs_eq last_xs_eq_b0 vb_xs=> // contrad.
  rewrite blocks2bits_nil in contrad.
  have contrad_last :
    false = last false (s ++ [true] ++ nseq n false ++ [true]).
    have {1}-> : false = last false [] by trivial.
    by rewrite {1}contrad.
  rewrite last_cat /= in contrad_last.
  elim contrad_last.
elim (last_drop_all_but_last b0 xs)=> // drop_xs.
have xs_take_drop : xs = take (size xs - 1) xs ++ drop (size xs - 1) xs
  by rewrite cat_take_drop.
rewrite drop_xs last_xs_eq_b0 b0P in xs_take_drop.
have last_b2b_xs_true : last true (blocks2bits xs) = true
   by rewrite b2b_xs_eq cats1 last_rcons.
have last_b2b_xs_false : last true (blocks2bits xs) = false
    by rewrite xs_take_drop blocks2bits_cat blocks2bits_sing ofblockK
               1:size_nseq 1:max_ler 1:ge0_r // last_cat
               last_nseq 1:gt0_r.
by rewrite last_b2b_xs_true in last_b2b_xs_false.
qed.

inductive valid_block_struct_spec (xs : block list) =
  ValidBlockStruct1 (ys : block list, x : block, s : bool list, n : int) of
      (xs = ys ++ [x])
    & (0 <= n)
    & (ofblock x = s ++ [true] ++ nseq n false ++ [true])
| ValidBlockStruct2 (ys : block list, y z : block) of
     (xs = ys ++ [y; z])
   & (last false (ofblock y))
   & (ofblock z = nseq (r - 1) false ++ [true]).

lemma nosmt valid_block_structP (xs : block list) :
  valid_block xs <=> valid_block_struct_spec xs.
proof.
rewrite valid_blockP.
split=> [[s n] [ge0_n lt_nr] b2b_xs_eq |
         [ys x s n xs_eq ge0_n w2b_x_eq |
          ys y z xs_eq lst w2b_z_eq]].
have sz_s_divz_eq : size s = size s %/ r * r + size s %% r
  by apply divz_eq.
pose tke := take (size s %/ r * r) s; pose drp := drop (size s %/ r * r) s.
have sz_tke : size tke = size s %/ r * r.
  rewrite size_take 1:mulr_ge0 1:divz_ge0 1:gt0_r 1:size_ge0
          1:ge0_r.
  case (size s %/ r * r < size s)=> // not_lt_sz_s.
  rewrite -lezNgt in not_lt_sz_s; apply ler_asym; split=> // _.
  by rewrite lez_floor gtr_eqF 1:gt0_r //.
have sz_drp : size drp = size s %% r.
  rewrite size_drop 1:mulr_ge0 1:divz_ge0 1:gt0_r 1:size_ge0
          1:ge0_r.
  case (size s %/ r * r < size s)=> // not_lt_sz_s.
  rewrite max_ler /#.
  have eq : size s %/ r * r = size s.
    rewrite -lezNgt in not_lt_sz_s; apply ler_asym; split=> //.
    by rewrite lez_floor gtr_eqF 1:gt0_r //.
  rewrite max_lel /#.
have sz_s_pad_dvd_r : r %| (size s + n + 2).
  have <- : size (s ++ [true] ++ nseq n false ++ [true]) = size s + n + 2
    by rewrite !size_cat /= size_nseq max_ler 1:ge0_n #ring.
  rewrite -b2b_xs_eq size_blocks2bits_dvd_r.
have sz_tke_dvd_r : r %| size tke by rewrite sz_tke dvdz_mull dvdzz.
have sz_drp_plus_n_plus_2_dvd_r : r %| (size drp + n + 2).
  rewrite sz_drp dvdzE
          -(@dvdz_modzDl (size s %/ r * r) (size s %% r + n + 2) r)
          1:dvdz_mull 1:dvdzz.
  have -> : size s %/ r * r + (size s %% r + n + 2) = size s + n + 2.
  rewrite {3}sz_s_divz_eq #ring. by rewrite -dvdzE.
have xs_eq : xs = bits2blocks(s ++ [true] ++ nseq n false ++ [true])
  by rewrite -blocks2bitsK b2b_xs_eq.
rewrite -(@cat_take_drop (size s %/ r * r) s) -!catA -/tke -/drp
        bits2blocks_cat in xs_eq.
+ rewrite sz_tke_dvd_r. rewrite !size_cat /= size_nseq max_ler 1:ge0_n.
+ have -> : size drp + (1 + (n + 1)) = size drp + n + 2 by ring.
+ rewrite sz_drp_plus_n_plus_2_dvd_r.
case: (n = r - 1)=> [n_eq_r_min1 | n_neq_r_min1].
have sz_drp_plus1_dvd_r : r %| (size drp + 1).
  rewrite dvdzE -(@addz0 (size drp + 1)) -{1}(@modzz r).
  have {1}-> : r = n + 1 by smt().
  rewrite modzDmr.
  have -> : size drp + 1 + (n + 1) = size drp + n + 2 by ring.
  by rewrite -dvdzE.
have sz_drp_plus1_eq_r : size drp + 1 = r.
  rewrite (@dvdz_close (size drp + 1)) //.
  split=> [| _]; first rewrite ltr_paddl 1:size_ge0 ltr01.
  have -> : 2 * r = r + r by ring.
  rewrite ltr_add // 1:sz_drp 1:ltz_pmod 1:gt0_r ltzE ge2_r.
apply (@ValidBlockStruct2 xs (bits2blocks tke)
      (mkblock (drp ++ [true])) (mkblock (nseq n false ++ [true]))).
rewrite xs_eq (@catA drp [true]) bits2blocks_cat 1:size_cat //
        1:size_cat 1:size_nseq 1:max_ler 1:ge0_n /= 1:/#
        (@bits2blocks_sing (drp ++ [true])) 1:size_cat //
        (@bits2blocks_sing (nseq n false ++ [true]))
        1:size_cat 1:size_nseq /= 1:max_ler 1:ge0_n /#.
rewrite ofblockK 1:size_cat //= cats1 last_rcons.
rewrite n_eq_r_min1 ofblockK 1:size_cat //= size_nseq max_ler /#.
have lt_n_r_min1 : n < r - 1 by smt().
move: xs_eq.
have sz_drp_plus_n_plus_2_eq_r : size drp + n + 2 = r.
  rewrite (@dvdz_close (size drp + n + 2)) // sz_drp.
  have n_plus2_rng : 2 <= n + 2 <= r by smt().
  rewrite -addrA; split=> [| _].
  rewrite ltr_paddl 1:modz_ge0 1:gtr_eqF 1:gt0_r // /#.
  have ->: 2 * r = r + r by ring.
  have -> : r + r = (r - 1) + (r + 1) by ring.
  rewrite ler_lt_add 1:-ltzS 1:-addrA /= 1:ltz_pmod 1:gt0_r.
  by rewrite -(@ltr_add2r (-2)) -2!addrA.
move=> xs_eq.
rewrite (@bits2blocks_sing
         (drp ++ ([true] ++ (nseq n false ++ [true]))))
        in xs_eq.
+ rewrite !size_cat /= size_nseq max_ler 1:ge0_n 1:sz_drp.
+   have -> : size s %% r + (1 + (n + 1)) = size s %%r + n + 2 by ring.
+   by rewrite -sz_drp.
apply (@ValidBlockStruct1 xs (bits2blocks tke)
       (mkblock (drp ++ ([true] ++ (nseq n false ++ [true]))))
       drp n)=> //.
by rewrite ofblockK 1:!size_cat /= 1:size_nseq 1:max_ler 1:ge0_n
           1:-sz_drp_plus_n_plus_2_eq_r 1:#ring -!catA cat1s.
have sz_w2b_x_eq_r : size (ofblock x) = r by apply size_block.
rewrite w2b_x_eq !size_cat /= size_nseq max_ler // in sz_w2b_x_eq_r.
have lt_nr : n < r by smt(size_ge0).
apply (@ValidBlock xs (blocks2bits ys ++ s) n)=> //.
by rewrite xs_eq blocks2bits_cat blocks2bits_sing w2b_x_eq -!catA.
move: xs_eq. have -> : [y; z] = [y] ++ [z] by trivial. move=> xs_eq.
have w2bits_y_eq : ofblock y = take (r - 1) (ofblock y) ++ [true].
  rewrite -{1}(@cat_take_drop (r - 1) (ofblock y)); congr.
  elim (last_drop_all_but_last false (ofblock y))=>
    [w2b_y_nil | drop_w2b_y_last].
    have not_lst_w2b_y : ! last false (ofblock y) by rewrite w2b_y_nil.
    by rewrite w2b_y_nil.
  rewrite lst in drop_w2b_y_last.
  by rewrite -drop_w2b_y_last size_block.
apply (@ValidBlock xs (blocks2bits ys ++ (take (r - 1) (ofblock y)))
       (r - 1)).
smt(ge2_r).
rewrite xs_eq 2!blocks2bits_cat 2!blocks2bits_sing -!catA; congr.
by rewrite {1}w2bits_y_eq -catA w2b_z_eq.
qed.

(* in AbsorbSponge *)

op valid_absorb (xs : block list) = valid_block((strip xs).`1).

inductive valid_absorb_spec (xs : block list) =
  ValidAbsorb (ys : block list, n : int) of
      (valid_block ys)
    & (0 <= n)
    & (xs = ys ++ nseq n b0).

lemma nosmt valid_absorbP (xs : block list) :
  valid_absorb xs <=> valid_absorb_spec xs.
proof.
rewrite /valid_absorb; split=> [strp_xs_valid | [ys n] ge0_n vb_ys ->].
by rewrite (@ValidAbsorb xs (strip xs).`1 (strip xs).`2)
           2:(@strip_ge0 xs) 2:(@stripK xs).
by rewrite -/(extend ys n) extendK 1:valid_block_ends_not_b0.
qed.

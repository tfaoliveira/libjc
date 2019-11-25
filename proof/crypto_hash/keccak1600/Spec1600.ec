(******************************************************************************
   Spec1600.ec:

   Byte-oriented and statefull specification of the sponge construction.
******************************************************************************)
require import AllCore List Int IntDiv.
from Jasmin require import JArray JMemory JModel JWord JWord_array JUtils.

require import EclibExtra JWordList.


op rate :int.
axiom rate_bnds: 0 < rate < 1600.
axiom rate_w64: 64 %| rate.

require Sponge1600.

clone import Sponge1600 as Spnge1600
 with op rate = rate
      proof rate_bnds by apply rate_bnds
      proof rate_w64 by apply rate_w64.

import Common1600 Block Capacity.


(* Additional results on bit-level constructions *)

lemma num0_block_suffix n k:
 num0 (k * rate + n) = num0 n.
proof. by rewrite /num0 -modzNm -addzA modzMDl modzNm. qed.

lemma mkpad_rate n:
 0 <= n => mkpad (r + n) = mkpad n.
proof.
move=> Hn; rewrite /mkpad /=; congr; congr.
by rewrite (num0_block_suffix n 1).
qed.

lemma chunk_r (m: bool list):
 size m = r => chunk m = [m].
proof.
have Hr: r <> 0 by smt(rate_bnds).
move=> Hsz; rewrite /chunk Hsz divzz /= Hr /b2i mkseq1 /= drop0.
by rewrite -Hsz take_size.
qed.
 
lemma pad2blocksE m:
 r <= size m =>
 pad2blocks m = mkblock (take r m) :: pad2blocks (drop r m).
proof.
move=> Hm.
have Hsz: size (take r m) = r by rewrite size_take; smt(rate_bnds).
rewrite -{1}(cat_take_drop r) /pad2blocks /(\o) /bits2blocks /pad.
rewrite -catA chunk_cat ?Hsz ?dvdzz map_cat chunk_r //.
by rewrite /= size_cat Hsz mkpad_rate; smt(size_ge0).
qed.

lemma mkblock_xor l1 l2:
 size l1 = r => size l2 = r =>
 mkblock l1 +^ mkblock l2 = mkblock (map2 Bool.(^^) l1 l2).
proof.
move=> *; rewrite /(+^) /offun; congr.
rewrite -(eq_mkseq (fun i => Bool.(^^) (nth false l1 i) (nth false l2 i))).
 move=> i /=; rewrite !Block.getE.
 case: (0 <= i < r) => E.
  rewrite eq_sym. rewrite !ofblockK //.
  rewrite (nth_inside witness false). smt().
  rewrite (nth_inside witness false). smt().
  done.
 rewrite nth_out. smt().
 rewrite nth_out. smt().
 done.
apply (eq_from_nth false).
 rewrite size_mkseq size_map2 H H0 max_ler.
 smt(rate_bnds). 
 by rewrite min_ler.
rewrite size_mkseq max_ler. smt(rate_bnds).
move=> i Hi.
rewrite nth_mkseq //=.
by rewrite (nth_map2 false false) /#.
qed.

op block0star1 = mkblock (nseq (rate-1) false ++ [true]).

lemma block0star1P m:
 size m <= r-2 =>
 mkblock (m++mkpad (size m))
 = mkblock (m++[true]++nseq (r-size m-1) false) +^ block0star1.
proof.
move=> Hm.
rewrite /mkpad mkblock_xor.
  by rewrite !size_cat size_nseq max_ler //= 1:/#; ring.
 by rewrite size_cat size_nseq max_ler; smt(rate_bnds).
have E: num0 (size m) = r - size m - 2.
 rewrite /num0 -(modzMDl 1) modz_small.
  by apply bound_abs; smt(rate_bnds size_ge0).
 by ring.
congr; apply (eq_from_nth false).
 rewrite !size_cat /= size_rcons size_nseq max_ler E; first smt(size_ge0).
 rewrite size_map2 min_ler.
  by rewrite !size_cat !size_nseq !max_ler; smt(rate_bnds size_ge0).
 by rewrite size_cat size_nseq max_ler /=; smt(rate_bnds).
move=> i; rewrite !size_cat /= size_rcons size_nseq max_ler ?num0_ge0 E.
rewrite -!cats1 (: size m + (1 + (r - size m - 2 + 1)) = r) 1:/# => Hi.
case: (i=r-1) => [->|?].
 rewrite nth_cat /= nth_cat.
 rewrite (:! r - 1 < size m) 1:/# /=.
 rewrite (:! r - 1 - size m - 1 < size (nseq (r - size m - 2) false)) /=.
  by rewrite size_nseq max_ler /#.
 rewrite (:r - 1 - size m <> 0) 1:/# /=.
 rewrite (:r - 1 - size m - 1 - size (nseq (r - size m - 2) false) = 0) /=.
  by rewrite size_nseq max_ler /#.
 rewrite (nth_map2 false false).
  rewrite min_ler.
   by rewrite size_cat size_nseq max_ler 1:/# !size_cat /= size_nseq max_ler /#.
  by rewrite size_cat size_nseq max_ler /#.
 rewrite !nth_cat size_cat /=. 
 rewrite (:! r - 1 < size m + 1) 1:/# /=.
 rewrite nth_nseq 1:/# /= size_nseq max_ler 1:/# ltzz /=.
 by ring.
rewrite (nth_map2 false false).
 rewrite min_ler.
  by rewrite size_cat size_nseq max_ler 1:/# !size_cat /= size_nseq max_ler /#.
 by rewrite size_cat size_nseq max_ler /#.
have ->: nth false (nseq (Top.rate - 1) false ++ [true]) i = false.
 rewrite nth_cat size_nseq max_ler 1:/# (: i < r-1) 1:/# /=.
 by rewrite nth_nseq /#.
rewrite Bool.xor_false nth_cat.
case: (i < size m) => I1.
 by rewrite -catA nth_cat I1.
rewrite eq_sym -catA nth_cat I1 /=; case: (i-size m <> 0) => I2 //=.
rewrite nth_cat size_nseq max_ler 1:/#.
rewrite (:i - size m - 1 < r - size m - 2) 1:/# /=.
by rewrite !nth_nseq /#.
qed.




(* 1600bit state *)
require import Array25 WArray200.

(* State is defined as an array of 25 64-bit words. But it can also be
 viewed as an array of 200 bytes (which is the preferred view in this
 specification).                                                              *)
type state = W64.t Array25.t.
abbrev state200 (st: state) : WArray200.t = WArray200.init64 ("_.[_]" st).
abbrev state25 (st200: WArray200.t) : state = Array25.init (WArray200.get64 st200).

(* set/get individual bytes *)
abbrev w64_set8 (w: W64.t) i (b: W8.t) = W8u8.pack8_t (W8u8.unpack8 w).[i <- b].
abbrev state_get8 (st: state) i = (state200 st).[i].
abbrev state_set8 (st: state) i x = state25 (state200 st).[i <- x].

lemma state_get8E st i:
 0 <= i < 200 =>
 state_get8 st i = st.[i %/ 8] \bits8 (i %% 8).
proof. by move=> Hi; rewrite initE Hi. qed.

lemma state_set8E st i x:
 0 <= i < 200 =>
 state_set8 st i x
 = st.[i %/ 8 <- w64_set8 st.[i %/ 8] (i %% 8) x].
proof.
move=> Hi; apply Array25.ext_eq => j Hj.
rewrite initiE // get64E get_set_if.
rewrite (: 0 <= i %/ 8 < 25 ) 1:/# /=.
rewrite -(W8u8.Pack.init_ext
   (fun (k:int) => if j=i%/8 then w64_set8 st.[i%/8] (i%%8) x \bits8 k
                             else st.[j] \bits8 k)).
 move=> k Hk /=.
 rewrite get_setE // state_get8E 1:/#.
  case: (8 * j + k = i) => E /=.
   rewrite (:j=i%/8) 1:/# /= pack8bE 1:/#. 
   by rewrite get_setE 1:/# (:i%%8=k) 1:/#.
  case: (j=i%/8) => E2.
   rewrite -!E2 /w64_set8 /=.
   rewrite pack8bE // get_set_if.
   by rewrite (:!k = i %% 8) 1:/# /= W8u8.get_unpack8 //; congr; smt().
  by congr; [congr|]; smt().
case: (j=i%/8) => E.
 by rewrite -{2}(W8u8.unpack8K (w64_set8 _ _ _)) /unpack8; congr.
by rewrite -(W8u8.unpack8K st.[j]); congr.
qed.


lemma state200K: cancel state200 state25.
proof.
move=> x; apply Array25.ext_eq => i Hi.
rewrite initiE // get64E /= -(W8u8.unpack8K x.[i]); congr.
apply W8u8.Pack.init_ext => k Hk /=.
by rewrite state_get8E 1:/#; congr; [congr|]; smt().
qed.

lemma state25K: cancel state25 state200.
proof.
move=> x; apply WArray200.ext_eq => i Hi.
rewrite state_get8E //.
rewrite initiE 1:/# get64E pack8bE 1:/#.
by rewrite initiE 1:/# /=; congr; smt().
qed.

(* conversion between different list representations for state *)
abbrev state2w8L (st: state): W8.t list = to_list (state200 st).
op state2bits (st: state): bool list = w8L2bits (state2w8L st).
op w8L2state (l: W8.t list): state = state25 (WArray200.of_list l).

lemma size_state2bits (st: state):
 size (state2bits st) = 1600.
proof. by rewrite /state2bits size_w8L2bits size_to_list. qed.

abbrev state2w64L (st: state): W64.t list = to_list st.
op w64L2state (l: W64.t list): state = Array25.of_list W64.zero l.

(* we can go back and forward on the various representations *)
lemma w8L2w64L2state l:
 w8L2state l = w64L2state (w8L2w64L l).
proof.
apply Array25.ext_eq => i Hi.
rewrite  initiE // get64E Array25.get_of_list //.
rewrite nth_w8L2w64L; congr.
apply W8u8.Pack.init_ext=> /= x Hx.
by rewrite get_of_list /#.
qed.

lemma w64L2w8L2state l:
 w64L2state l = w8L2state (w64L2w8L l).
proof.
apply Array25.ext_eq => i Hi.
rewrite Array25.get_of_list //.
rewrite Array25.initE Hi /= get64E /=.
rewrite -(W8u8.Pack.init_ext ((\bits8) (nth W64.zero l i))) /=.
move=> j Hj; rewrite WArray200.get_of_list 1:/# nth_w64L2w8L; congr.
+ congr; smt().
+ smt().
+ by rewrite (W8u8.unpack8K (nth W64.zero l i)).
qed.

lemma state2w8L2w64L st:
 state2w8L st = w64L2w8L (state2w64L st).
proof. by rewrite /init64 /w64L2w8L /flatten /Array25.to_list /mkseq. qed.

lemma state2w64L2w8L st:
 state2w64L st = w8L2w64L (state2w8L st).
proof. by rewrite state2w8L2w64L w64L2w8LK. qed.

lemma state_get8P st i:
 state_get8 st i = (state2w8L st).[i].
proof. by rewrite /state2w8L get_to_list. qed.



(* rate expressed in 8 and 64bit words *)
op rate64 = rate %/ 64.
op rate8 = 8*rate64.

lemma rate64P: 64 * rate64 = rate.
proof. by move: rate_w64; rewrite /rate64 mulzC dvdz_eq. qed.

lemma rate64_bnds: 0 < rate64 < 25.
proof. move: rate_bnds; rewrite -rate64P /#. qed.

lemma rate8P: 8 * rate8 = rate.
proof. by rewrite /rate8 /= -mulzA rate64P. qed.

lemma rate8_bnds: 0 < rate8 < 200.
proof. move: rate_bnds; rewrite -rate8P /#. qed.


(* project state into block+capacity *)
op state_r (st: state) : block =
 mkblock (take r (state2bits st)).

op w8L2block (l: W8.t list) : block =
 mkblock (w8L2bits (take rate8 l ++ nseq (rate8-size l) W8.zero)).

op state_c (st: state) : capacity =
 mkcapacity (drop r (state2bits st)).





(* Initial state *)
op st0 : state = Array25.create W64.zero.

lemma st0E:
 st0 = state25 (WArray200.create W8.zero).
proof.
apply Array25.ext_eq => i Hi.
rewrite /st0 createE !initiE // get64E; beta.
rewrite -(W8u8.unpack8K W64.zero); congr.
apply W8u8.Pack.init_ext => k Hk; beta.
by rewrite WArray200.initiE 1:/# /= W8u8.get_zero.
qed.

lemma state2bits0: state2bits st0 = nseq 1600 false.
proof.
rewrite st0E /state2bits /state2w8L state25K.
by rewrite /w8L2bits.
qed.

lemma st0_r: state_r st0 = b0.
proof.
rewrite /state_r state2bits0 b0P take_nseq min_lel //.
apply ltzW; smt(rate_bnds).
qed.

lemma c0P: c0 = mkcapacity (nseq c false).
proof.
rewrite capacityP=> i Hi.
by rewrite offunifE Hi /= getE Hi /= ofcapacityK 1:size_nseq 1:/# nth_nseq.
qed.

lemma st0_c: state_c st0 = c0.
proof. rewrite /state_c c0P state2bits0 drop_nseq; smt(rate_bnds). qed.



(* state addition *)


op addstate (st1 st2: state) : state =
 Array25.map2 W64.(`^`) st1 st2.

abbrev addstate8 (st: state) (l: W8.t list) : state = addstate st (w8L2state l).
abbrev state_xor8 (st: state) i x = state_set8 st i (state_get8 st i `^` x).
abbrev addstate64 (st: state) (l: W64.t list) : state = addstate st (w64L2state l).

lemma addstate8_w64L st l:
 addstate8 st (w64L2w8L l) = addstate64 st l.
proof. by rewrite -w64L2w8L2state. qed.

lemma addstate64_w8L st l:
 addstate64 st (w8L2w64L l) = addstate8 st l.
proof. by rewrite -w8L2w64L2state. qed.

lemma addstate_getE st1 st2 i:
 0 <= i < 25 =>
 (addstate st1 st2).[i] = st1.[i] `^` st2.[i].
proof. by move=> Hi; rewrite map2iE. qed.

lemma addstate64_getE st l i:
 0 <= i < 25 =>
 (addstate64 st l).[i] = st.[i] `^` nth W64.zero l i.
proof.
by move=> Hi; rewrite /addstate map2iE // (Array25.get_of_list W64.zero).
qed.

lemma addstate64_getE_out st l i:
 size l <= i =>
 (addstate64 st l).[i] = st.[i].
proof.
move=> Hsz; case: (0 <= i < 25) => E.
 by rewrite addstate64_getE // nth_out /#.
by rewrite !get_out.
qed.

lemma addstate8_get8E st l i:
 0 <= i < 200 =>
 state_get8 (addstate8 st l) i
 = (st.[i %/ 8] \bits8 (i %% 8)) `^` nth W8.zero l i.
proof.
move=> Hi.
rewrite state_get8E // -addstate64_w8L addstate64_getE 1:/#.
rewrite nth_w8L2w64L W8u8.xorb8E pack8bE 1:/#; congr.
by rewrite initiE 1:/# /= /#.
qed.

lemma addstate8_get8E_out st l i:
 size l <= i =>
 state_get8 (addstate8 st l) i = state_get8 st i.
proof.
move=> Hsz; case: (0 <= i < 200) => E.
 by rewrite addstate8_get8E // nth_out 1:/# state_get8E.
by rewrite !get_out.
qed.

lemma addstate64_rcons st l x:
 size l < 25 =>
 addstate64 st (rcons l x) = (addstate64 st l).[size l <- st.[size l] `^` x].
proof.
move=> Hsz; apply Array25.ext_eq => i Hi.
rewrite addstate64_getE // get_set_if (:0 <= size l < 25) /=; first smt(size_ge0).
case: (i=size l) => E; first by rewrite nth_rcons E.
rewrite addstate64_getE //; congr.
case: (i < size l) => H; first by rewrite nth_rcons H.
by rewrite !nth_out ?size_rcons /#.
qed.

lemma addstate64_rconsE i st l x:
 i = size l =>
 i < 25 =>
 addstate64 st (rcons l x) = (addstate64 st l).[i <- st.[i] `^` x].
proof. by move=> ->; apply addstate64_rcons. qed.

lemma to_list_addstate8 st l:
 state2w8L (addstate8 st l)
 = map2 W8.(`^`) (state2w8L st) (l++nseq (200-size l) W8.zero).
proof.
apply (eq_from_nth W8.zero).
 rewrite size_map2 !size_to_list min_lel //.
 rewrite size_cat size_nseq; smt(size_ge0).
rewrite size_to_list => i Hi.
rewrite WArray200.get_to_list (nth_map2 W8.zero W8.zero).
 rewrite size_to_list size_cat size_nseq; smt(size_ge0).
rewrite addstate8_get8E 1://; congr.
 by rewrite get_to_list state_get8E.
case: (i < size l) => E; first by rewrite nth_cat E.
rewrite nth_out 1:/# nth_cat.
by rewrite (:! i < size l) 1:/# /= nth_nseq_dflt.
qed.

lemma addstate8_rcons st l x:
 size l < 200 =>
 addstate8 st (rcons l x) = state_xor8 (addstate8 st l) (size l) x.
proof.
move=> Hsz.
rewrite -(state200K (addstate8 _ _)); congr; congr.
apply WArray200.to_list_inj.
rewrite to_list_addstate8.
apply (eq_from_nth W8.zero).
 by rewrite !size_to_list size_map2 size_cat size_rcons size_nseq /#.
rewrite size_map2 size_to_list size_cat size_rcons size_nseq min_lel 1:/#.
move=> i Hi.
rewrite get_to_list get_set_if (:0 <= size l < 200); first smt(size_ge0).
rewrite (nth_map2 W8.zero W8.zero).
 rewrite size_to_list size_cat size_rcons size_nseq /#.
rewrite get_to_list nth_cat /= size_rcons.
case: (i=size l) => E.
 rewrite (:i<size l+1) 1:/# /= E nth_rcons /= addstate8_get8E 1:/# state_get8E 1:/#.
 by rewrite nth_out.
rewrite addstate8_get8E // state_get8E //.
case: (i < size l) => H.
 by rewrite (: i < size l+1) 1:/# /= nth_rcons H.
by rewrite (:!i < size l+1) 1:/# /= nth_nseq_dflt nth_out 1:/#.
qed.

lemma addstate8_rconsE i st l x:
 i = size l =>
 i < 200 =>
 addstate8 st (rcons l x) = state_xor8 (addstate8 st l) i x.
proof. by move=> ->; apply addstate8_rcons. qed.


lemma addstate64_nil st: addstate64 st [] = st.
proof.
by apply Array25.ext_eq => i Hi; rewrite addstate_getE // get_of_list //.
qed.

lemma addstate8_nil st: addstate8 st [] = st.
proof. by rewrite -w64L2w8L_nil addstate8_w64L addstate64_nil. qed.


lemma addstate8_r st l:
 state_r (addstate8 st l) = state_r st +^ w8L2block l.
proof.
rewrite /state_r /state2bits /w8L2block mkblock_xor.
  rewrite size_take; first smt(rate_bnds).
  by rewrite size_w8L2bits WArray200.size_to_list /= (: r < 1600); smt(rate_bnds).
 rewrite size_w8L2bits size_cat size_nseq size_take; first smt(rate64_bnds).
 case: (rate8 < size l) => E.
  by rewrite max_lel; smt(size_ge0 rate64P).
 by rewrite max_ler 1:/#; smt(rate64P).
congr; rewrite to_list_addstate8.
have ->: (w8L2bits (take rate8 l ++ nseq (rate8 - size l) W8.zero))
 = take r (w8L2bits (l ++ nseq (rate8 - size l) W8.zero)).
 rewrite -rate8P take_w8L2bits take_cat'.
 case: (rate8 <= size l) => E.
  by rewrite nseq0_le 1:/# cats0.
 by rewrite take_oversize 1:/# take_nseq min_ler.
rewrite w8L2bits_xor take_map2; congr.
rewrite -rate8P !take_w8L2bits; congr.
rewrite !take_cat; case: (rate8 < size l) => //= E; congr.
by rewrite !take_nseq; smt(rate8_bnds).
qed.

lemma addstate_c st l:
 size l <= rate8 =>
 state_c (addstate8 st l) = state_c st.
proof.
move=> Hsz; rewrite /state_c /state2bits /w8L2block; congr.
rewrite -rate8P !drop_w8L2bits; congr.
rewrite to_list_addstate8 !drop_map2 drop_cat.
rewrite (:!rate8 < size l) 1:/#; iota.
rewrite drop_nseq; first smt(rate64_bnds).
rewrite map2_nseq0r //.
by rewrite size_drop; smt(rate64_bnds).
qed. 







(* We treat the sponge permutation as an abstract function. It acts
   as a bridge between the idealized permutation used in the security
   proof (RO), and the concrete Keccak-F[1600] instantiation adopted
   in the implementation.                                                     *)
op sponge_permutation : state -> state.







(* [match_state] relates the bit-level and word-level state representations                 *)
op match_state x st = x = (state_r st, state_c st).

lemma match_state_r (x:block*capacity) st:
 match_state x st => x.`1 = state_r st
by move=> ->.

lemma match_state_c (x:block*capacity) st:
 match_state x st => x.`2 = state_c st
by move=> ->.







(* messages, padding, etc. *)
type mess_t = W8.t list.

(* [aborb_split] reads a the contents of a full block into a list
   of bytes (return also the remaining bytes).   *)
op absorb_split (m: W8.t list): W8.t list * W8.t list =
 (take rate8 m, drop rate8 m).

lemma size_absorb_split1 m:
 rate8 <= size m => size (absorb_split m).`1 = rate8.
proof. move=> Hm; rewrite /absorb_split /= size_take'; smt(rate_bnds). qed.

lemma size_absorb_split2 m:
 rate8 <= size m => size (absorb_split m).`2 = size m - rate8.
proof. move=> Hm; rewrite /absorb_split /= size_drop; smt(rate_bnds). qed.

lemma absorb_splitP mbits m:
 rate8 <= size m =>
 w8L2block (absorb_split m).`1 = head b0 (pad2blocks (w8L2bits m ++ mbits)).
proof.
move=> Hm.
have Hsz8: size (take rate8 m) = rate8.
 rewrite size_take; first smt(rate8_bnds).
 case: (size m = rate8) => E.
   by rewrite -E ltzz.
  by have ->: rate8 < size m by smt().
rewrite pad2blocksE /=.
 by move: Hm; rewrite size_cat size_w8L2bits -rate8P; smt(size_ge0).
rewrite /w8L2block Hsz8 /= cats0; congr.
rewrite take_cat size_w8L2bits.
case: (size m = rate8) => E.
 rewrite !E !rate8P ltzz /r /Spnge1600.rate take0 cats0 -Hsz8 take_size.
 by rewrite /absorb_split /= -E take_size.
have ->/=: r < 8 * size m.
 by apply (StdOrder.IntOrder.ler_lt_trans (8*rate8)); smt(rate8P).
by rewrite -Hsz8 take_size /absorb_split /= -rate8P take_w8L2bits.
qed.

lemma addfullblockP mbits blk st m:
 rate8 <= size m =>
 blk = state_r st =>
 state_r (addstate8 st (absorb_split m).`1)
 = blk +^ head b0 (pad2blocks (w8L2bits m ++ mbits)).
proof.
move=> Hm Hst; rewrite /absorb_split /= addstate8_r -Hst; congr.
by rewrite -absorb_splitP.
qed.


(* [trail_byte] adds the first padding 1-bit to [mbits], which include
  both the "domain-separatioen" bits as well as additional suffix bits
  (e.g. "01" for SHA-3; "11" for RawSHAKE; "1111" for SHAKE). The last
  1-bit of the padding (the "rate" bit), is only added when adding to
  the state.
  Remark: the standard FIPS-202 specifies two domain bits, possibly
   prefixed by up to two additional suffix bits. Nonetheless, we
   only assume a weaker requirenment: that those bits together with
   the two mandatory bits of the padding fit in a single byte
   (i.e. [size mbits < 6]).                                                   *)
op trail_byte (mbits: bool list) : W8.t = W8.bits2w (mbits++[true]).



(* [absorb_final] reads the final block and adds the first padding bit       *)
op absorb_final (lbyte: W8.t) (m: W8.t list): W8.t list =
  m++[lbyte].


lemma finalblockP mbits m:
 size mbits < 6 =>
 size m < rate8 =>
 w8L2block (absorb_final (trail_byte mbits) m) +^ block0star1 =
 head b0 (pad2blocks (w8L2bits m ++ mbits)).
proof.
move=> Hmbits Hm.
rewrite /pad2blocks /(\o) /pad /bits2blocks /= chunk_r /=.
 rewrite !size_cat size_mkpad size_w8L2bits !addzA.
 rewrite (size_pad_equiv (8 * size m + size mbits)); first smt(size_ge0).
 by rewrite divz_small; first apply bound_abs; smt(size_ge0).
rewrite block0star1P /w8L2block; first rewrite size_cat size_w8L2bits /#.
congr; congr.
rewrite take_oversize /absorb_final /trail_byte; first by rewrite size_cat /#.
have ->: nseq (r - size (w8L2bits m ++ mbits) - 1) false
         = (nseq (chunkfillsize 8 (size (mbits ++ [true]))) false
           ++ nseq (r - 8*size m - 8) false).
 rewrite -!nseq_add; first 2 smt(chunkfillsize_cmp size_ge0).
 congr; rewrite !size_cat size_w8L2bits /= chunkfillsizeE' 1:/#; first smt(size_ge0).
 ring; rewrite /= modz_small; smt(size_ge0).
rewrite catA w8L2bits_cat; congr; last first.
 rewrite w8L2bits_nseq0.
  rewrite size_cat /=; smt(size_ge0).
 by rewrite mulzDr rate8P size_cat /=; congr; ring.
rewrite w8L2bits_cat -!catA; congr.
rewrite /w8L2bits /flatten /chunkfill chunkfillsizeE' 1:/# size_cat /=; first smt(size_ge0).
rewrite modz_small; first smt(size_ge0).
pose L:= (nth false _ 0 :: _).
apply (eq_from_nth false).
 by rewrite !size_cat /= size_nseq max_ler /#.
rewrite (:size L=8) //.
move=> i Hi; have: i \in iota_ 0 8 by smt().
move=> {Hi} Hi.
rewrite -cat1s !nth_cat /= nth_nseq_if.
move: i Hi; rewrite /L -List.allP /= => {L}.
move: mbits Hmbits => [|x0 [|x1 [|x2 [|x3 [|x4 [|x5 xs]]]]]] //=.
smt(size_ge0).
qed.

op addfinalbit (st: state): state =
 state_xor8 st (rate8-1) (W8.of_int 128).

op block0star1_st = addfinalbit st0.

lemma addfinalbitE st:
 addfinalbit st = addstate8 st (nseq (rate8-1) W8.zero ++ [W8.of_int 128]).
proof.
have Rbnds := rate8_bnds.
rewrite -(state200K (addstate8 _ _)) /addfinalbit; congr; congr.
apply ext_eq => i Hi; rewrite addstate8_get8E // get_set_if.
rewrite (:0 <= rate8 - 1 < 200) 1:/# nth_cat size_nseq max_ler 1:/# /=.
case: (i=rate8-1) => E; first by rewrite E /= state_get8E /#.
case: (i < rate8-1) => H.
 by rewrite nth_nseq 1:/# W8.xorw0 state_get8E.
by rewrite Ring.IntID.subr_eq0 E /= state_get8E.
qed.

lemma addfinalbitP st:
 state_r (addfinalbit st) = state_r st +^ block0star1.
proof.
have Rbnds := rate8_bnds.
rewrite addfinalbitE addstate8_r /block0star1 /w8L2block; congr; congr.
rewrite w8L2bits_cat take_oversize.
 by rewrite size_cat size_nseq /#.
rewrite size_cat size_nseq max_ler 1:/# /= cats0.
rewrite w8L2bits_cat w8L2bits_nseq0 1:/#.
rewrite (: r-1 = 8*(rate8-1) + 7) 1:-rate8P 1:/#.
rewrite nseq_add 1,2:/# -catA; congr.
rewrite -(W8.shlMP 1 7) // /w8L2bits /=.
have P: forall i, W8.one.[i] = (i=0).
 move=> i; rewrite of_intE /= /int2bs /= /mkseq /= bits2wE /=.
 case: (0 <= i < 8) => E.
  by rewrite initiE //.
 by rewrite W8.get_out // /#.
by rewrite /flatten /= !P /#.
qed.

op addfinalblock st l = addfinalbit (addstate8 st l).

lemma addfinalblock_r mbits st m:
 size mbits < 6 =>
 size m < rate8 =>
 state_r (addfinalblock st (absorb_final (trail_byte mbits) m))
 = state_r st +^ head b0 (pad2blocks (w8L2bits m ++ mbits)).
proof.
move=> Hmbits Hm.
rewrite /addfinalblock addfinalbitP !addstate8_r -Block.xorwA; congr.
by apply finalblockP.
qed.

lemma addfinalbit_c st:
 state_c (addfinalbit st) = state_c st.
proof.
rewrite addfinalbitE addstate_c // size_cat size_nseq /=; smt(rate8_bnds).
qed.

(* [squeezestate] extracts a [rate64] 64bit words from the state             *)
op squeezestate (st: state): W8.t list =
 take rate8 (state2w8L st).

lemma size_squeezestate st:
 size (squeezestate st) = rate8.
proof. rewrite /squeezestate size_take'; smt(rate64_bnds). qed.

op squeezestate64 (st: state) = take rate64 (state2w64L st).

lemma size_squeezestate64 st:
 size (squeezestate64 st) = rate64.
proof. rewrite /squeezestate64 size_take' ?size_to_list; smt(rate64_bnds). qed.

lemma squeezestateE st:
 squeezestate st = w64L2w8L (squeezestate64 st).
proof.
by rewrite /squeezestate /squeezestate64 /rate8 state2w8L2w64L take_w64L2w8L.
qed.


lemma size_pad2blocks8 mbits m:
 size mbits < 6 =>
 size (pad2blocks (w8L2bits m ++ mbits)) = size m %/ rate8 + 1.
proof.
rewrite size_pad2blocks size_cat size_w8L2bits -rate8P => ?; congr.
rewrite -addzA.
have := (divmod_mul rate8 8 (size m) (size mbits + 1) _ _);
by smt(size_ge0 rate8_bnds). 
qed.

lemma behead_pad2blocks m:
 r <= size m =>
 behead (pad2blocks m) = pad2blocks (drop r m).
proof.
rewrite /pad2blocks /bits2blocks /pad /(\o) behead_map => ?.
rewrite behead_chunk; congr.
rewrite drop_cat. 
case: (r = size m) => E.
 rewrite !E drop0 drop_size /= /mkpad.
 have ->: size m = 1*r + 0 by smt().
 by rewrite num0_block_suffix.
have ->/=: r < size m by smt().
rewrite size_drop; first smt(rate_bnds).
rewrite max_ler; first smt(size_ge0).
have {1}->: size m = 1*r + (size m - r) by ring.
by rewrite /mkpad num0_block_suffix.
qed.

lemma behead_pad2blocks8 mbits m:
 rate8 <= size m =>
 behead (pad2blocks (w8L2bits m ++ mbits)) =
 pad2blocks (w8L2bits (absorb_split m).`2 ++ mbits).
proof.
move=> ?; rewrite behead_pad2blocks.
 by rewrite size_cat size_w8L2bits -rate8P; smt(size_ge0).
rewrite /absorb_split /= drop_cat size_w8L2bits -rate8P.
rewrite StdOrder.IntOrder.ltr_pmul2l //.
case: (rate8 = size m) => E.
 by rewrite E /= drop0 drop_size w8L2bits_nil.
have ->/=: rate8 < size m by smt().
by rewrite -drop_w8L2bits mulzC.
qed.

lemma size_pad2blocks8_ge x m mbits:
 size mbits < 6 =>
 x <= size (pad2blocks (w8L2bits m ++ mbits)) <=> x*rate8 - rate8 <= size m.
proof.
move=> Hmbits; rewrite size_pad2blocks8 //.
rewrite (: x <= size m %/ rate8 + 1 = x-1 <= size m %/ rate8) 1:/#.
by rewrite lez_divRL; smt(rate8_bnds).
qed.

lemma needed_blocks8P n x:
 x < (8*n + r - 1) %/ r <=> 0 < n - x*rate8.
proof.
rewrite ltzE lez_divRL; first smt(rate_bnds).
rewrite mulzDl /= !(addzC _ r) -addzA lez_add2l.
rewrite -rate8P (mulzC 8) -mulzA mulzC -(lez_add2l 1) !(addzC 1) /= -ltzE.
by rewrite StdOrder.IntOrder.ltr_pmul2l /#.
qed.



(****************************************************************************
    Byte-oriented statefull specification of the sponge construction
****************************************************************************)
module Spec = {
  proc f(trail_byte: W8.t, m: W8.t list, outlen: int) : W8.t list = {
    var result,l,st;
    result <- [];
    st <- st0;
    (* ABSORB *)
    while (rate8 <= size m){
      (l, m) <- absorb_split m;
      st <- addstate8 st l;
      st <- sponge_permutation st;
    }
    st <- addfinalblock st (absorb_final trail_byte m);
    (* SQUEEZE *)
    while (rate8 < outlen){
      st <- sponge_permutation st;
      l <- squeezestate st;
      result <- result ++ l;
      outlen = outlen - rate8;
    }
    st <- sponge_permutation st;
    l <- squeezestate st;
    result <- result ++ take outlen l;
    return result;
  }
}.


(****************************************************************************
   Equivalence between the bit-level and byte-level specs.
****************************************************************************)
section.

declare module IdealizedPerm: DPRIMITIVE.
axiom perm_correct st:
  phoare [ IdealizedPerm.f:
            match_state x st
           ==>
            match_state res (sponge_permutation st) ] = 1%r.

lemma spec_correct mbits: 
equiv [ Sponge(IdealizedPerm).f ~ Spec.f :
        bs{1} = w8L2bits m{2} ++ mbits /\
        n{1} = 8*outlen{2} /\
        trail_byte{2} = trail_byte mbits /\ size mbits < 6
       ==> res{1} = w8L2bits res{2}].
proof.
have Rbnds:= rate8_bnds.
proc; simplify; exists* outlen{2}; elim* => outlen2.
swap {1} 1 1; swap {1} [2..3] 2.
swap {2} 1 3.
splitwhile {1} 3: (1 < size xs).
(* ABSORB intermediate blocks *)
seq 3 2: (#[/1,3:]pre /\ match_state (sa,sc){1} st{2} /\ 
           xs{1} = (pad2blocks (w8L2bits m ++ mbits)){2} /\
           size xs{1} = 1).
 sp; while (#[/5,7:]pre /\ match_state (sa,sc){1} st{2} /\
            xs{1} = pad2blocks (w8L2bits m{2} ++ mbits) /\
            outlen2 = outlen{2} /\ 1<=size xs{1}).
  wp 1 2; ecall {1} (perm_correct st{2}); wp; skip; progress.
  + by rewrite (match_state_r _ _ H0) eq_sym; apply addfullblockP.
  + by move: H0; rewrite addstate_c /match_state //= size_absorb_split1.
  + by rewrite H6.
  + by rewrite H6.
  + by rewrite behead_pad2blocks8.
  + by rewrite size_behead size_pad2blocks8 // max_ler /= lez_divRL /#.
  + rewrite size_absorb_split2 //.
    have: 3 <= size (pad2blocks (w8L2bits m{2} ++ mbits)).
     move: H8; rewrite size_behead max_ler. 
      by rewrite size_pad2blocks8 //= lez_divRL /#.
     smt().
    by rewrite size_pad2blocks8_ge /#.
  + have : 2 <= size (pad2blocks (w8L2bits m{2} ++ mbits)).
     by rewrite size_pad2blocks8_ge // /#.
    by pose L:= pad2blocks _; move: L => [|x1 [|x2 xs]].
  + have : 2 < size (pad2blocks (w8L2bits m{2} ++ mbits)).
     rewrite size_pad2blocks8 //.
     apply (StdOrder.IntOrder.ltr_le_trans (2+1)) => //.
     apply lez_add2r; rewrite lez_divRL /= 1:/#.
     move: H7; rewrite /absorb_split /= size_drop 1:/#.
     by rewrite max_ler /#.
    by pose L:= pad2blocks _; move: L => [|x1 [|x2 [|x3 xs]]] => //= /#.
 skip => |> *; progress.
 + by rewrite st0_r.
 + by rewrite st0_c.
 + rewrite size_pad2blocks8 //; smt(size_ge0 divz_ge0 rate8_bnds).
 + by move: H1; rewrite ltzE /= size_pad2blocks8_ge /#.
 + have: 2 <= size (pad2blocks (w8L2bits m{2} ++ mbits)).
    by rewrite size_pad2blocks8_ge /#.
   smt().
 + by rewrite ltzE /= size_pad2blocks8_ge /#.
 + rewrite size_pad2blocks8 // divz_small //. 
   by apply bound_abs; smt(size_ge0).   
(* ABSORB final block *)
unroll {1} 1; rcondt {1} 1.
 move=> *; skip => |> *.
 move: H1; case: (xs{hr}=[]); smt().
rcondf {1} 3.
 move=> *; wp; call (_:true); skip => |> ???.
 move: (pad2blocks _) => [|??] //= ?.
 by rewrite -size_eq0 /#.
(* SQUEEZE *)
case: (0 < outlen2); last first.
 (* corner case: no output *)
 rcondf {2} 3; first by move=> *; wp; skip => |> *; smt(rate8_bnds).
 rcondf {1} 5.
  move=> *; wp; call (_:true); skip => |> *.
  case: (8 * outlen{m} + r - 1 < 0) => ?.
   rewrite -lezNgt; apply ltzW.
   rewrite ltzNge divz_ge0; first smt(rate_bnds).
   smt().
  rewrite divz_small //.
  by apply bound_abs; smt(rate_bnds).
 wp 1 2; ecall {1} (perm_correct st{2}); wp; skip; progress.
 + rewrite (match_state_r _ _ H0) addfinalblock_r //.
   by move: H1; rewrite size_pad2blocks8 // /#.
 + rewrite /addfinalblock addfinalbitE addstate_c.
    by rewrite size_cat size_nseq /= /#.
   rewrite addstate_c /absorb_final.
    by move: H1; rewrite size_pad2blocks8 // size_cat /#.
   by rewrite (match_state_c _ _ H0).
 + by rewrite take_le0 /#.
splitwhile {1} 5: (i+1 < (n + r - 1) %/ r).
seq 5 3: (#[/3:5]pre /\ n{1} = 8*outlen2 /\ 
          outlen{2} = outlen2 - rate8*i{1} /\
          match_state (sa,sc){1} (sponge_permutation st{2}) /\
          z{1} = w8L2bits result{2} /\
          size result{2} = rate8 * i{1} /\
          i{1}+1 = (n{1} + r - 1) %/ r).
 (* SQUEEZE intermediate blocks *)
 while (#[:-1]post /\ i{1}+1 <= (n{1} + r - 1) %/ r).
  rcondt {1} 3.
   by move=> ?; wp; skip; progress.
  ecall {1} (perm_correct st{2}); wp; skip; progress.
  + smt().
  + by rewrite H7.
  + by rewrite H7.
  + rewrite w8L2bits_cat (match_state_r _ _ H6) /state_r ofblockK.
     by rewrite size_take 1:/# size_state2bits /#.
    by congr; rewrite -rate8P /squeezestate /state2bits -take_w8L2bits; congr.
  + by rewrite size_cat size_squeezestate /#.
  + smt().
  + by move: H9; rewrite needed_blocks8P /#. 
  + by rewrite needed_blocks8P /#.
 wp 1 1; ecall {1} (perm_correct st{2}); wp; skip; auto => |> *; progress.
 + rewrite (match_state_r _ _ H0) addfinalblock_r //.
   by move: H1; rewrite size_pad2blocks8 // /#.
 + rewrite /addfinalblock addfinalbitE addstate_c.
    by rewrite size_cat size_nseq /= /#.
   rewrite addstate_c /absorb_final.
    by move: H1; rewrite size_pad2blocks8 // size_cat /#.
   by rewrite (match_state_c _ _ H0).
 + by rewrite H4.
 + by rewrite H4.
 + have ->: 1 = 0+1 by done.
   by rewrite -ltzE needed_blocks8P /=.
 + by move: H5; rewrite needed_blocks8P /#.
 + by rewrite needed_blocks8P /#.
 + by rewrite needed_blocks8P /#.
 + smt().
(* SQUEEZE final block *)
rcondt {1} 1; first by move=> ?; wp; skip; progress; smt().
rcondf {1} 3; first by move=> ?; wp; skip; progress; smt().
rcondf {1} 3; first by move=> ?; wp; skip; progress; smt().
wp; skip; progress.
rewrite w8L2bits_cat take_cat'.
rewrite (:!8 * outlen2 <= size (w8L2bits result{2})) /=.
 by rewrite size_w8L2bits H1 -mulzA rate8P /#.
congr; rewrite (match_state_r _ _ H0) /squeezestate ofblockK.
 by rewrite size_take 1:/# size_state2bits /#.
rewrite take_take min_lel /state2bits.
 by rewrite size_w8L2bits H1 -mulzA rate8P /#.
rewrite size_w8L2bits.
have ->: 8 * outlen2 - 8 * size result{2} = 8*(outlen2 -size result{2}) by ring.
rewrite take_w8L2bits; congr.
rewrite take_take min_lel.
 by rewrite (: i{1}=i{1}+1-1) 1:/# mulzDr H2 -rate8P /#.
congr; smt().
qed.


end section.



(* List of Jasmin Words *)
require import AllCore List Int IntDiv.
from Jasmin require import JMemory JWord JUtils.


require import EclibExtra.


(*******************************************************************************)
(*                                   W8 lists                                  *)
(*******************************************************************************)

op w8L2bits (l: W8.t list) : bool list =
 flatten (map W8.w2bits l).

lemma w8L2bits_nil: w8L2bits [] = [] by done.

hint simplify w8L2bits_nil.

lemma w8L2bits_cons x xs: w8L2bits (x::xs) = W8.w2bits x ++ w8L2bits xs.
proof. by rewrite /w8L2bits map_cons flatten_cons. qed.

lemma w8L2bits_cat l1 l2:
 w8L2bits (l1++l2) = w8L2bits l1 ++ w8L2bits l2.
proof. by elim: l1 => //= x xs IH; rewrite !w8L2bits_cons IH. qed.

lemma size_w8L2bits x:
 size (w8L2bits x) = 8 * size x.
proof.
by rewrite /w8L2bits size_flatten -map_comp /(\o) /= StdBigop.Bigint.sumzE
StdBigop.Bigint.BIA.big_mapT /(\o) /= StdBigop.Bigint.big_constz count_predT_eq.
qed.

(*hint simplify size_w8L2bits.*)

lemma take_w8L2bits n l:
 take (8*n) (w8L2bits l) = w8L2bits (take n l).
proof.
elim/natind: n l => //=.
 move=> n Hn l; rewrite !take_le0 //.
 by apply StdOrder.IntOrder.mulr_ge0_le0.
move=> n Hn IH [|x xs] //=.
have ->/=: ! (n+1 <= 0) by rewrite -ltzNge ltzS.
rewrite !w8L2bits_cons take_cat.
have ->/=: ! (8 * (n + 1) < size (w2bits x)) by rewrite W8.size_w2bits /#.
by rewrite mulzDr /= IH.
qed.

lemma drop_w8L2bits n l:
 drop (8*n) (w8L2bits l) = w8L2bits (drop n l).
proof.
elim/natind: n l => //=.
 move=> n Hn l; rewrite !drop_le0 //.
 by apply StdOrder.IntOrder.mulr_ge0_le0.
move=> n Hn IH [|x xs] //=.
have ->/=: ! (n+1 <= 0) by rewrite -ltzNge ltzS.
rewrite !w8L2bits_cons drop_cat.
have ->/=: ! (8 * (n + 1) < size (w2bits x)) by rewrite W8.size_w2bits /#.
by rewrite mulzDr /= IH.
qed.

lemma w8L2bits_u64 w: w8L2bits (W8u8.to_list w) = W64.w2bits w.
proof. by rewrite /w8L2bits. qed.


op bits2w8L (bs: bool list) : W8.t list =
 map W8.bits2w (BitEncoding.BitChunking.chunk 8 (chunkfill false 8 bs)).

lemma bits2w8L_nil: bits2w8L [] = [].
proof.
rewrite /bits2w8L chunkfill_nil.
by rewrite /BitEncoding.BitChunking.chunk /= mkseq0.
qed.

hint simplify bits2w8L_nil.

lemma size_bits2w8L' bs:
 size (bits2w8L bs) = (size bs - 1) %/ 8 + 1.
proof.
rewrite /bits2w8L size_map BitEncoding.BitChunking.size_chunk //.
rewrite size_chunkfill //.
rewrite {3}(:8 = 1*8) 1:/# -mulzDl.
by rewrite -(addz0 (((size bs - 1) %/ 8 + 1) * 8)) divzMDl.
qed.

lemma size_bits2w8L bs:
 8 %| size bs => size (bits2w8L bs) = size bs %/ 8.
proof. by rewrite dvdzP size_bits2w8L' => [[k ->]]; smt(). qed.

lemma bits2w8LK bs:
 8 %| size bs => w8L2bits (bits2w8L bs) = bs.
proof.
move=> Hsz.
rewrite /w8L2bits -map_comp dvd_chunkfill //.
have : forall (x : bool list),
        x \in BitEncoding.BitChunking.chunk 8 bs =>
         idfun x = W8.w2bits (W8.bits2w x).
 move=> x Hx; beta.
 rewrite W8.bits2wK //.
 by apply (BitEncoding.BitChunking.in_chunk_size _ _ _ _ Hx).
rewrite List.eq_in_map => <-.
by rewrite map_id BitEncoding.BitChunking.chunkK // Hsz.
qed.

lemma bits2w8LK' bs:
 w8L2bits (bits2w8L bs) = chunkfill false 8 bs.
proof.
rewrite /bits2w8L -chunkfillK //.
by rewrite bits2w8LK ?chunkfillP // chunkfillK.
qed.

lemma w8L2bits_inj: injective w8L2bits.
proof.
rewrite /w8L2bits; elim.
 by move=> [|y ys].
move=> x xs IH; elim => //.
move=> y ys IH2.
rewrite !map_cons !flatten_cons.
rewrite eqseq_cat.
 by rewrite !size_w2bits.
move=> [/W8.w2bits_inj <- ?]; congr.
by apply IH.
qed.

lemma w8L2bitsK: cancel w8L2bits bits2w8L.
proof.
move=> k; apply w8L2bits_inj.
by rewrite bits2w8LK // size_w8L2bits dvdz_mulr.
qed.

lemma w8L2bits_xor l1 l2:
 w8L2bits (JUtils.map2 W8.(`^`) l1 l2)
 = map2 Bool.(^^) (w8L2bits l1) (w8L2bits l2).
proof.
elim: l1 l2 => //=.
 by move=> [|y ys]; rewrite w8L2bits_nil // w8L2bits_cons.
move=> x xs IH1; elim => //=.
move=> y ys IH2.
rewrite !w8L2bits_cons map2_cat.
 by rewrite !size_w2bits.
by rewrite IH1.
qed.

lemma w8L2bits_nseq0 n:
 0 <= n =>
 w8L2bits (nseq n W8.zero) = nseq (8*n) false.
proof.
elim/natind: n => /=.
 by move=> n Hn1 Hn2; rewrite !nseq0_le 1,2:/#.
move=> n Hn IH H; rewrite nseqS // w8L2bits_cons IH //.
by rewrite addzC mulzDr mulz1 nseq_add /#.
qed.


(*******************************************************************************)
(*                                   W64 lists                                  *)
(*******************************************************************************)

op w64L2bits (l: W64.t list) : bool list =
 flatten (map W64.w2bits l).

lemma size_w64L2bits l:
 size (w64L2bits l) = 64 * size l.
proof.
by rewrite /w64L2bits size_flatten -map_comp /(\o) /= StdBigop.Bigint.sumzE
StdBigop.Bigint.BIA.big_mapT /(\o) /= StdBigop.Bigint.big_constz count_predT_eq.
qed.

(*hint simplify size_w64L2bits.*)

op bits2w64L (bs: bool list) : W64.t list =
 map W64.bits2w (BitEncoding.BitChunking.chunk 64 (chunkfill false 64 bs)).

lemma bits2w64L_nil: bits2w64L [] = [].
proof.
rewrite /bits2w64L chunkfill_nil.
by rewrite /BitEncoding.BitChunking.chunk /= mkseq0.
qed.

lemma size_bits2w64L' bs:
 size (bits2w64L bs) = (size bs - 1) %/ 64 + 1.
proof.
rewrite /bits2w64L size_map BitEncoding.BitChunking.size_chunk //.
rewrite size_chunkfill //.
rewrite {3}(:64 = 1*64) 1:/# -mulzDl.
by rewrite -(addz0 (((size bs - 1) %/ 64 + 1) * 64)) divzMDl.
qed.

lemma size_bits2w64L bs:
 64 %| size bs => size (bits2w64L bs) = size bs %/ 64.
proof. by rewrite dvdzP size_bits2w64L' => [[k ->]]; smt(). qed.

hint simplify bits2w64L_nil.

lemma bits2w64LK bs:
 64 %| size bs => w64L2bits (bits2w64L bs) = bs.
proof.
move=> Hsz.
rewrite /w64L2bits -map_comp dvd_chunkfill //.
have : forall (x : bool list),
        x \in BitEncoding.BitChunking.chunk 64 bs =>
         idfun x = (fun x => w2bits ((bits2w x))%W64) x.
 move=> x Hx; beta.
 rewrite W64.bits2wK //.
 by apply (BitEncoding.BitChunking.in_chunk_size _ _ _ _ Hx).
rewrite List.eq_in_map => <-.
by rewrite map_id BitEncoding.BitChunking.chunkK // Hsz.
qed.

lemma bits2w64LK' bs:
 w64L2bits (bits2w64L bs) = chunkfill false 64 bs.
proof.
rewrite /bits2w64L -chunkfillK //.
by rewrite bits2w64LK ?chunkfillP // chunkfillK.
qed.

lemma w64L2bits_inj: injective w64L2bits.
proof.
rewrite /w64L2bits; elim.
 by move=> [|y ys].
move=> x xs IH; elim => //.
move=> y ys IH2.
rewrite !map_cons !flatten_cons.
rewrite eqseq_cat.
 by rewrite !size_w2bits.
move=> [/W64.w2bits_inj <- ?]; congr.
by apply IH.
qed.

lemma w64L2bitsK: cancel w64L2bits bits2w64L.
proof.
move=> k; apply w64L2bits_inj.
by rewrite bits2w64LK // size_w64L2bits dvdz_mulr.
qed.

lemma w64L2bits_nil: w64L2bits [] = [] by done.

lemma w64L2bits_cons x xs: w64L2bits (x::xs) = W64.w2bits x ++ w64L2bits xs.
proof. by rewrite /w64L2bits map_cons flatten_cons. qed.

lemma w64L2bits_cat l1 l2:
 w64L2bits (l1++l2) = w64L2bits l1 ++ w64L2bits l2.
proof.
elim: l1 => //=.
qed.

lemma take_w64L2bits n l:
 take (64*n) (w64L2bits l) = w64L2bits (take n l).
proof.
elim/natind: n l => //=.
 move=> n Hn l; rewrite !take_le0 //.
 by apply StdOrder.IntOrder.mulr_ge0_le0.
move=> n Hn IH [|x xs] /=.
 by rewrite w64L2bits_nil.
have ->/=: ! (n+1 <= 0) by rewrite -ltzNge ltzS.
rewrite !w64L2bits_cons take_cat.
have ->/=: ! (64 * (n + 1) < size (w2bits x)) by rewrite W64.size_w2bits /#.
by rewrite mulzDr /= IH.
qed.

lemma drop_w64L2bits n l:
 drop (64*n) (w64L2bits l) = w64L2bits (drop n l).
proof.
elim/natind: n l => //=.
 move=> n Hn l; rewrite !drop_le0 //.
 by apply StdOrder.IntOrder.mulr_ge0_le0.
move=> n Hn IH [|x xs] /=.
 by rewrite w64L2bits_nil.
have ->/=: ! (n+1 <= 0) by rewrite -ltzNge ltzS.
rewrite !w64L2bits_cons drop_cat.
have ->/=: ! (64 * (n + 1) < size (w2bits x)) by rewrite W64.size_w2bits /#.
by rewrite mulzDr /= IH.
qed.

lemma nth_w64L2bits l i:
 0 <= i < 64 * size l =>
 nth false (w64L2bits l) i
 = nth false (W64.w2bits (nth W64.zero l (i %/ 64))) (i%%64).
proof.
move=> Hi; rewrite /w64L2bits (BitEncoding.BitChunking.nth_flatten _ 64).
 by rewrite allP; move=> x /mapP [y [Hy ->]].
rewrite (nth_map W64.zero) //.
apply divz_cmp => //.
by rewrite mulzC.
qed.

lemma w64L2bits_xor l1 l2:
 w64L2bits (JUtils.map2 W64.(`^`) l1 l2)
 = map2 Bool.(^^) (w64L2bits l1) (w64L2bits l2).
proof.
elim: l1 l2 => //=.
 by move=> [|y ys]; rewrite w64L2bits_nil // w64L2bits_cons.
move=> x xs IH1; elim => /=.
 rewrite w64L2bits_nil map2C; first by move=> b1 b2; ring.
 by rewrite w64L2bits_cons.
move=> y ys IH2.
rewrite !w64L2bits_cons map2_cat.
 by rewrite !size_w2bits.
by rewrite IH1.
qed.

lemma w64L2bits_nseq0 n:
 0 <= n =>
 w64L2bits (nseq n W64.zero) = nseq (64*n) false.
proof.
elim/natind: n => /=.
 by move=> n Hn1 Hn2; rewrite !nseq0_le 1,2:/# w64L2bits_nil.
move=> n Hn IH H; rewrite nseqS // w64L2bits_cons IH //.
by rewrite addzC mulzDr mulz1 nseq_add /#.
qed.

(*******************************************************************************)
(*                      W8 lists  =>  W64 lists                                *)
(*******************************************************************************)

op w8L2w64L (l: W8.t list) : W64.t list =
 map W8u8.pack8 (BitEncoding.BitChunking.chunk 8 (chunkfill W8.zero 8 l)).

lemma w8L2w64L_nil: w8L2w64L [] = [].
proof. by rewrite /w8L2w64L chunkfill_nil /BitEncoding.BitChunking.chunk mkseq0. qed.

hint simplify w8L2w64L_nil.

lemma w8L2w64L_cat l1 l2:
 8 %| size l1 => w8L2w64L (l1++l2) = w8L2w64L l1 ++ w8L2w64L l2.
proof.
move=> Hsz; rewrite /w8L2w64L chunkfill_cat //.
rewrite BitEncoding.BitChunking.chunk_cat // map_cat.
by rewrite (chunkfillK' l1) //.
qed.

lemma w8L2w64L_singl xs:
 0 < size xs <= 8 => w8L2w64L xs = [pack8 xs].
proof.
move=> Hsz; rewrite /w8L2w64L /BitEncoding.BitChunking.chunk.
have ->: size (chunkfill W8.zero 8 xs) %/ 8 = 1.
 rewrite size_chunkfill // /#.
rewrite mkseq1 /= drop0 take_oversize.
 rewrite size_chunkfill //; smt(size_ge0).
rewrite !pack8E; apply W64.init_ext => x Hx /=.
by congr; rewrite !W8u8.Pack.get_of_list 1,2:/# nth_chunkfill.
qed.

lemma w8L2w64L_cons l:
 0 < size l =>
 w8L2w64L l = W8u8.pack8 (take 8 l) :: w8L2w64L (drop 8 l).
proof.
move=> Hsz0; rewrite -{1}(cat_take_drop 8 l).
case: (size l <= 8) => Hsz.
 by rewrite !drop_oversize //= cats0 take_oversize // w8L2w64L_singl // E /=.
rewrite w8L2w64L_cat.
 by rewrite size_take // (: 8 < size l) 1:/# /= dvdzz.
by rewrite w8L2w64L_singl // size_take // /#.
qed.

lemma drop_w8L2w64L n l:
 drop n (w8L2w64L l) = w8L2w64L (drop (8*n) l).
proof.
elim/natind: n l => //=.
 by move=> n Hn l; rewrite !drop_le0 // /#.
move=> n Hn IH l.
rewrite -drop_drop //.
move: l => [|x xs] //.
rewrite {1}(w8L2w64L_cons (x::xs) _) /= 1:[smt(size_ge0)] drop0.
rewrite (:! 8 * (n + 1) <= 0) 1:/# /= IH drop_drop 1:/# //.
by congr; congr; ring.
qed.

lemma size_w8L2w64L l:
 size (w8L2w64L l) = (size l - 1) %/ 8 + 1.
proof.
rewrite /w8L2w64L size_map BitEncoding.BitChunking.size_chunk //.
rewrite size_chunkfill //. 
by rewrite -{3}(mul1z 8) -mulzDl mulzK.
qed.

lemma size_w8L2w64L' l:
 8 %| size l => size (w8L2w64L l) = size l %/ 8.
proof. by rewrite size_w8L2w64L dvdz_eq => E; smt(). qed.

lemma take_w8L2w64L n l:
 take n (w8L2w64L l) = w8L2w64L (take (8*n) l).
proof.
rewrite -{1}(cat_take_drop (8*n) l).
case: (0 <= 8*n) => Hsz0; last by rewrite !take_le0 /#.
case: (8*n <= size l) => E.
 rewrite w8L2w64L_cat.
  rewrite size_take' 1:/# E /= /#.
 rewrite take_cat' !size_w8L2w64L size_take' // !E /=.
 rewrite (:n <= (8 * n - 1) %/ 8 + 1) 1:/# /= take_oversize //.
 by rewrite size_w8L2w64L size_take' // E /= /#.
rewrite drop_oversize 1:/# cats0 take_oversize //.
by rewrite size_w8L2w64L size_take' /#.
qed.

lemma nth_w8L2w64L (l : W8.t list) (i : int):
  nth W64.zero (w8L2w64L l) i
  = pack8_t (W8u8.Pack.init (fun j => l.[8*i + j])).
proof.
rewrite /w8L2w64L.
case: (0 <= i /\ i < (size l-1) %/ 8 + 1) => E; last first.
 rewrite nth_out; first by rewrite size_map size_chunkfilled /#.
 rewrite -(W8u8.Pack.init_ext (fun j => W8.zero)).
 move=> j Hj /=; rewrite nth_out// 1:/#.
 rewrite -(W8u8.unpack8K W64.zero); congr.
 apply W8u8.Pack.ext_eq => j Hj.
 by rewrite !W8u8.Pack.initiE //= W8u8.get_zero.
rewrite (nth_map []) /=; first by rewrite size_chunkfilled /#.
rewrite nth_chunkfilled' // 1:/#.
congr; apply W8u8.Pack.ext_eq => j Hj.
rewrite W8u8.Pack.initiE //=.
by rewrite W8u8.Pack.get_of_list //= nth_mkseq //.
qed.


(*******************************************************************************)
(*                      W64 lists  =>  W8 lists                                *)
(*******************************************************************************)


op w64L2w8L (l: W64.t list) : W8.t list =
 flatten (map W8u8.to_list l).

lemma w64L2w8L_nil:
 w64L2w8L [] = [].
proof. by rewrite /w64L2w8L. qed.

hint simplify w64L2w8L_nil.

lemma w64L2w8L_cons x xs:
 w64L2w8L (x::xs) = W8u8.to_list x ++ w64L2w8L xs.
proof. by rewrite /w64L2w8L map_cons flatten_cons. qed.

lemma size_w64L2w8L (l: W64.t list):
 size (w64L2w8L l) = 8 * size l.
proof.
elim: l => //= x xs IH.
by rewrite w64L2w8L_cons size_cat IH W8u8.Pack.size_to_list; ring.
qed.

(*hint simplify size_w64L2w8L.*)

lemma w64L2w8L2bits l:
 w8L2bits (w64L2w8L l) = w64L2bits l.
proof.
elim: l; first by rewrite /w64L2w8L /flatten.
move=> x xs IH.
rewrite /w64L2w8L map_cons flatten_cons w64L2bits_cons w8L2bits_cat; congr.
qed.

lemma w64L2w8L_singl x: w64L2w8L [x] = W8u8.to_list x by rewrite /w64L2w8L.

lemma w64L2w8L_cat l1 l2:
 w64L2w8L (l1++l2) = w64L2w8L l1 ++ w64L2w8L l2.
proof.
elim: l1 => //= x xs IH.
qed.

lemma take_w64L2w8L n l:
 take (8*n) (w64L2w8L l) = w64L2w8L (take n l).
proof.
elim: l n => //= x xs IH n.
case: (n <= 0) => E /=; first by rewrite take_le0 /#.
rewrite !w64L2w8L_cons -IH take_cat W8u8.Pack.size_to_list.
by rewrite (:!8*n<8) /#.
qed.

lemma nth_w64L2w8L (l : W64.t list) (i : int):
  nth W8.zero (w64L2w8L l) i
  = nth W64.zero l (i %/ 8) \bits8 (i %% 8).
proof.
rewrite /w64L2w8L.
have Hsz: all (fun (s : W8.t list) => size s = 8)
              (map (fun (w : W64.t) => (to_list w)%W8u8) l).
 by rewrite allP => x /mapP [y [Hy ->]].
rewrite (BitEncoding.BitChunking.nth_flatten W8.zero 8) //.
move: Hsz; rewrite allP => Hsz.
case: (0 <= i %/ 8 < size l) => E; last first.
 rewrite nth_out; first rewrite nth_out ?size_map /#.
 by rewrite nth_out // W8u8.get_zero /#.
rewrite (nth_map W64.zero) //; beta.
by rewrite W8u8.Pack.get_to_list W8u8.get_unpack8 /#.
qed.

lemma w8L2w64LK (l: W8.t list):
 8 %| size l => w64L2w8L (w8L2w64L l) = l.
proof.
move=> Hsz.
rewrite /w64L2w8L /w8L2w64L -map_comp dvd_chunkfill //.
have : forall (x : W8.t list),
        x \in BitEncoding.BitChunking.chunk 8 l =>
         idfun x = W8u8.to_list (pack8 x).
 move=> x Hx; beta.
 rewrite W8u8.pack8K // of_listK //.
 by apply (BitEncoding.BitChunking.in_chunk_size _ _ _ _ Hx).
rewrite List.eq_in_map => <-.
by rewrite map_id BitEncoding.BitChunking.chunkK // Hsz.
qed.

lemma w8Lw64LK' l:
 w64L2w8L (w8L2w64L l) = chunkfill W8.zero 8 l.
proof.
rewrite /w8L2w64L -chunkfillK //.
by rewrite w8L2w64LK ?chunkfillP // chunkfillK.
qed.

lemma w64L2w8L_inj: injective w64L2w8L.
proof.
rewrite /w64L2w8L; elim.
 by move=> [|y ys].
move=> x xs IH; elim => //.
move=> y ys IH2.
rewrite !map_cons !flatten_cons.
rewrite eqseq_cat //; beta.
move=> [/W8u8.Pack.to_list_inj E ?]; congr; last by apply IH.
by rewrite -unpack8K E.
qed.

lemma w64L2w8LK: cancel w64L2w8L w8L2w64L.
proof.
move=> k; apply w64L2w8L_inj.
by rewrite w8L2w64LK // size_w64L2w8L dvdz_mulr.
qed.

(*******************************************************************************)
(*                          MEMORY OPERATIONS                                  *)
(*******************************************************************************)

lemma stores_singl mem out x: stores mem out [x] = storeW8 mem out x.
proof. by rewrite storeW8E /stores. qed.

lemma stores_cat mem out l1 l2:
 stores mem out (l1++l2) = stores (stores mem out l1) (out + size l1) l2.
proof.
elim: l1 mem out => //= x xs IH mem out.
by rewrite !stores_cons IH addzA.
qed.

lemma stores_cons' mem out x xs:
 stores mem out (x::xs) = stores (storeW8 mem out x) (out+1) xs.
proof. by rewrite -cat1s stores_cat stores_singl. qed.

lemma stores_rcons mem out x xs:
 stores mem out (rcons xs x) = storeW8 (stores mem out xs) (out + size xs) x.
proof. by rewrite -cats1 stores_cat stores_singl. qed.

lemma stores_u64 mem out x:
 stores mem out (W8u8.to_list x) = storeW64 mem out x by rewrite storeW64E.


(* name alias to [stores] to avoid uncontrolled evaluation... *)
op stores8 mem out l = stores mem out l
axiomatized by stores8E.

lemma stores8_nil mem out: stores8 mem out [] = mem.
proof. by rewrite stores8E. qed.

lemma stores8_singl mem out x: stores8 mem out [x] = storeW8 mem out x.
proof. by rewrite stores8E storeW8E /stores. qed.

hint simplify stores8_nil, stores8_singl.

lemma stores8_cat mem out l1 l2:
 stores8 mem out (l1++l2) = stores8 (stores8 mem out l1) (out + size l1) l2.
proof. by rewrite !stores8E stores_cat. qed.

lemma stores8_cons' mem out x xs:
 stores8 mem out (x::xs) = stores8 (storeW8 mem out x) (out+1) xs.
proof. by rewrite !stores8E stores_cons'. qed.

lemma stores8_rcons mem out x xs:
 stores8 mem out (rcons xs x) = storeW8 (stores8 mem out xs) (out + size xs) x.
proof. by rewrite !stores8E stores_rcons. qed.

lemma stores8_u64 mem out x:
 stores8 mem out (W8u8.to_list x) = storeW64 mem out x.
proof. by rewrite stores8E storeW64E. qed.


(* as well for [store64]... *)
op stores64 (m: global_mem_t) (a:address) (w: W64.t list): global_mem_t =
 foldl (fun (m0 : global_mem_t) (i : int) => storeW64 m0 (a + 8*i) (nth W64.zero w i))
       m (iota_ 0 (size w))
axiomatized by stores64E.

lemma stores64_nil mem a: stores64 mem a [] = mem.
proof. by rewrite stores64E. qed.

lemma stores64_singl mem a x: stores64 mem a [x] = storeW64 mem a x.
proof. by rewrite stores64E. qed.

hint simplify stores64_nil, stores64_singl.

lemma stores64_cat mem out l1 l2:
 stores64 mem out (l1 ++ l2)
 = stores64 (stores64 mem out l1) (out + 8*size l1) l2.
proof.
rewrite !stores64E size_cat iota_add; first 2 smt(size_ge0).
rewrite (addzC 0) iota_addl foldl_cat foldl_map /=.
have ->: foldl (fun (m0 : global_mem_t) (i : int) =>
                 storeW64 m0 (out + 8 * i) (nth W64.zero (l1 ++ l2) i)) mem
               (iota_ 0 (size l1))
         = foldl (fun (m0 : global_mem_t) (i : int) =>
                   storeW64 m0 (out + 8 * i) (nth W64.zero l1 i)) mem
                 (iota_ 0 (size l1)).
 apply foldl_in_eq => mem' x; rewrite mem_iota => |> *.
 by rewrite nth_cat H0.
apply foldl_in_eq => mem' x; rewrite mem_iota => |> *.
case: (x=0) => E.
 by rewrite E /= nth_cat ltzz.
rewrite nth_cat (:! size l1 + x < size l1) 1:/# /=; congr; first smt().
congr; smt().
qed.

lemma stores64_cons mem a x xs:
 stores64 mem a (x::xs) = stores64 (storeW64 mem a x) (a+8) xs.
proof. by rewrite -cat1s stores64_cat. qed.

lemma stores64_rcons mem out xs x:
 stores64 mem out (rcons xs x)
 = storeW64 (stores64 mem out xs) (out + 8*size xs) x.
proof. by rewrite -cats1 stores64_cat. qed.

lemma stores64_stores8 mem out l:
 stores64 mem out l = stores8 mem out (w64L2w8L l).
proof.
rewrite stores8E; elim/last_ind: l mem out => //= xs x IH mem out.
rewrite stores64_rcons IH -cats1 w64L2w8L_cat stores_cat w64L2w8L_singl.
by rewrite stores_u64 size_w64L2w8L.
qed.


(** [memread] reads a list of bytes from memory *)
op memread (m: global_mem_t) (a: address) (sz: int): W8.t list =
  mkseq (fun i => m.[a + i]) sz.

lemma size_memread mem a sz:
 0 <= sz => size (memread mem a sz) = sz
by rewrite size_mkseq /#.

lemma drop_memread n mem ptr k:
  0 <= n <= k =>
  drop n (memread mem ptr k) = memread mem (ptr+n) (k-n).
proof.
move=> Hn; rewrite drop_mkseq //=.
by apply eq_mkseq => x; smt().
qed.

lemma nth_memread mem in_ inlen i:
 0 <= i < inlen =>
 nth W8.zero (memread mem in_ inlen) i
 = loadW8 mem (in_ + i)%Int.
proof. by move=> Hi; rewrite nth_mkseq. qed.

lemma memread0 mem in_: memread mem in_ 0 = [] by done.

lemma memread1 mem in_: memread mem in_ 1 = [loadW8 mem in_] by done.

hint simplify memread0, memread1.

lemma memread_add mem in_ x y:
 0 <= x => 0 <= y =>
 memread mem in_ (x+y)%Int = memread mem in_ x ++ memread mem (in_ + x) y.
proof.
move=> Hx Hy; rewrite /memread mkseq_add //; congr.
by apply eq_mkseq => z /=; rewrite addzA.
qed.

lemma memreadS mem in_ x:
 0 <= x =>
 memread mem in_ (x+1)%Int = rcons (memread mem in_ x) (loadW8 mem (in_+x)).
proof. by move=> Hx; rewrite memread_add //= cats1. qed.

lemma take_memread n mem ptr k:
 0 <= n => 
 take n (memread mem ptr k) = memread mem ptr (min n k).
proof. by move=> Hn; rewrite /memread take_mkseq. qed.

lemma loadW8_memread mem in_ inlen i:
 0 <= i < inlen =>
 loadW8 mem (in_ + i)%Int
 = nth W8.zero (memread mem in_ inlen) i.
proof.
rewrite /loadW8 /memread => Hi.
by rewrite nth_mkseq.
qed.

lemma loadW8_memread' mem in_ off inlen i:
 (off <= i < off + inlen)%Int =>
 loadW8 mem (in_ + i)%Int
 = nth W8.zero (memread mem (in_ + off) inlen) (i-off).
proof.
rewrite /loadW8 /memread => Hi.
by rewrite nth_mkseq /#.
qed.


lemma nth_memread_u64 mem in_ inlen i:
 0 <= i => 8*i+8 <= inlen =>
 loadW64 mem (in_+8*i) = nth W64.zero (w8L2w64L (memread mem in_ inlen)) i.
proof.
move=> ??; rewrite nth_w8L2w64L.
rewrite /loadW64 W8u8.pack8E pack8E; apply W64.init_ext => x Hx /=.
congr; rewrite W8u8.Pack.initiE 1:/# /= /memread.
by rewrite W8u8.Pack.initiE 1:/# /= nth_mkseq /#.
qed.


lemma memread_split off mem a sz:
 0 <= off <= sz =>
 memread mem a sz = memread mem a off ++ memread mem (a+off) (sz-off).
proof.
move=> Hoff; have ->: sz = off + (sz-off) by ring.
rewrite /memread mkseq_add 1,2:/#; congr.
rewrite (:off + (sz - off) - off = sz-off) 1:/#.
by apply eq_mkseq => i /#.
qed.



(** [memread64] reads a list of [n] (full) 64-bit words from memory *)
op memread64 (m: global_mem_t) (a: address) (n: int): W64.t list =
 mkseq (fun i => loadW64 m (a+8*i)) n.

lemma memread64_0 mem in_: memread64 mem in_ 0 = [] by done.

lemma memread64_1 mem in_: memread64 mem in_ 1 = [loadW64 mem in_] by done.

hint simplify memread64_0, memread64_1.

lemma size_memread64 mem a sz:
 0 <= sz => size (memread64 mem a sz) = sz
by rewrite size_mkseq /#.

lemma nth_memread64 m a sz i:
 0 <= i < sz =>
 nth W64.zero (memread64 m a sz) i = loadW64 m (a+8*i).
proof. by move=> Hsz; rewrite nth_mkseq //. qed.

lemma memread64E m a sz:
 memread64 m a sz = w8L2w64L (memread m a (8*sz)).
proof.
apply (eq_from_nth W64.zero).
 by rewrite size_mkseq size_w8L2w64L size_mkseq /#. 
rewrite size_mkseq => i Hi.
rewrite nth_w8L2w64L nth_memread64 1:/# /loadW64; congr.
apply W8u8.Pack.init_ext => j Hj /=.
by rewrite nth_mkseq /#.
qed.

lemma memread_split64 mem a sz:
 0 <= sz =>
 memread mem a sz
 = w64L2w8L (memread64 mem a (sz %/ 8))
   ++ memread mem (a + sz %/8 * 8) (sz %% 8).
proof.
move=> Hsz; rewrite (memread_split (sz %/ 8*8)) 1:/#; congr.
 by rewrite memread64E w8L2w64LK ?size_memread /#.
by rewrite modzE.
qed.

lemma memread64_add mem in_ x y:
 0 <= x => 0 <= y =>
 memread64 mem in_ (x+y)%Int = memread64 mem in_ x ++ memread64 mem (in_ + 8*x) y.
proof.
move=> Hx Hy; rewrite /memread64 mkseq_add //; congr.
by apply eq_mkseq => z /=; congr; ring.
qed.

lemma memread64S mem in_ i:
 0 <= i =>
 memread64 mem in_ (i+1)
 = rcons (memread64 mem in_ i) (loadW64 mem (in_ + 8*i)).
proof. by move=> Hi; rewrite memread64_add // memread64_1 cats1. qed.


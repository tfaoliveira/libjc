require import List Int IntDiv IntExtra CoreMap.
require import EClib Array2 Array3 Array4.
require import WArray16.
require import W64limbs.

require import JModel. (*here*)

require import Zp.
require ZModP.
import Zp.


(* packed lemmas for SMT calls *)
lemma ubW64_lemmas:
 (forall x, ubW64 W64.max_uint x)
 && (forall b x n, ubW64 (n-1) x => ubW64 n (x+(W64.of_int (b2i b))))
 && (forall n1 n2 x, (n1 <= n2)%Int => ubW64 n1 x => ubW64 n2 x)
 && (forall nx ny x y, ubW64 nx x => ubW64 ny y => ubW64 (nx+ny) (x+y))
 && (forall nx ny x y, ubW64 nx x => ubW64 ny y => ubW64 (nx*ny) (x*y))
 && (forall nx ny x y, ubW64 nx x => ubW64 ny y => ubW64 (nx*ny %/ W64.modulus) (mulhi x y)).
proof.
split; move=> *; first by apply ubW64T.
split; move=> *.
 by apply (ubW64D (n-1) 1) => //; apply ubW641.
split; move=> *; first by smt(ubW64W).
split; move=> *; first by apply ubW64D.
split; move=> *; first by apply ubW64M.
by apply ubW64Mhi.
qed.


type Rep2 = W64.t Array2.t.

type Rep3 = W64.t Array3.t.

(* [Rep3r] is a redundant representation for "r".
     r.[0], r.[1] - 128bit r
     r.[2] - 5 * r.[1] %/ 4
*)
type Rep3r = W64.t Array3.t.

op Rep3r_ok (r: Rep3r) =
 ubW64 1152921504606846975 r.[0]
 && ubW64 1152921504606846972 r.[1]
 && 4 %| to_uint r.[1]
 && to_uint r.[2] = 5 * (to_uint r.[1] %/ 4)
 && ubW64 1441151880758558715 r.[2].

op valRep2 (x: Rep2) = val_limbs64 (to_list x).

lemma valRep2E x:
 valRep2 x = to_uint x.[0] + 2^64 * to_uint x.[1].
proof. by rewrite /valRep2 /= /to_list /mkseq /val_digits /=. qed.
hint simplify valRep2E.

lemma valRep2_W8L y:
 valRep2 (Array2.init (WArray16.get64 y))
 = val_digits 256 (map W8.to_uint (WArray16.to_list y)).
proof.
rewrite valRep2E /= !WArray16.get64E !to_uint_unpack8u8 /= /val_digits /=.
by ring.
qed.

lemma valRep2_to_uint16u8 y:
  valRep2 (Array2.init (WArray16.get64 y)) =
 to_uint (W16u8.pack16_t (W16u8.Pack.init (WArray16."_.[_]" y))).
proof.
by rewrite valRep2_W8L to_uint_unpack16u8; congr; congr; congr.
qed.

op repres2(r : Rep2) = inzp (valRep2 r) axiomatized by repres2E.


op valRep3 (x: Rep3) = val_limbs64 (to_list x).

lemma valRep3E x:
 valRep3 x = to_uint x.[0] + 2^64 * to_uint x.[1] + 2^128 * to_uint x.[2].
proof. by rewrite /valRep3 /= /to_list /mkseq /val_digits /=; ring. qed.
hint simplify valRep3E.

op repres3(r : Rep3) = inzp (valRep3 r) axiomatized by repres3E.

op valRep3r (x: Rep3r) = val_limbs64 [x.[0]; x.[1]].

lemma valRep3rE x:
 valRep3r x = to_uint x.[0] + 2^64 * to_uint x.[1].
proof. by rewrite /valRep3r /= /to_list /mkseq /val_digits //=. qed.
hint simplify valRep3rE.

op repres3r(r : Rep3r) = inzp (valRep3r r) axiomatized by repres3rE.

lemma eqRep3 (x y:Rep3):
 x=y <=> (x.[0]=y.[0]) && (x.[1]=y.[1]) && (x.[2]=y.[2]).
proof. by move => /> *; apply (Array3.ext_eq_all x y). qed.

abbrev congpRep3 x xval = zpcgr (valRep3 x) xval.


lemma equiv_class3 x r:
  congpRep3 r (valRep3 x) <=> repres3 x = repres3 r.
proof.
split.
 move=> h; apply/Zp.Sub.val_inj/eq_sym.
 by rewrite !repres3E !inzpK.
by rewrite !repres3E /congpRep3 -!inzpK => ->.
qed.

lemma equiv_class3M r x y:
 congpRep3 r (valRep3 x * valRep3 y) <=>
 repres3 r = (repres3 x * repres3 y).
proof.
split.
 rewrite !repres3E -inzpM => ?.
 apply Zp.Sub.val_inj.
 by rewrite !inzpK.
by rewrite !repres3E -!inzpK inzpM => ->.
qed.

lemma equiv_class3D r x y:
 congpRep3 r (valRep3 x + valRep3 y) <=>
 repres3 r = (repres3 x + repres3 y).
proof.
split.
 rewrite !repres3E -inzpD => ?.
 apply Zp.Sub.val_inj.
 by rewrite !inzpK.
by rewrite !repres3E -!inzpK inzpD => ->.
qed.

lemma mul54_redp x:
 inzp (2^128 * x) = inzp (5 * (x %/ 4) + 2^128 * (x%%4)).
proof.
have := divz_eq x (2^2); rewrite mulzC => {1}->.
rewrite (mulzDr W128.modulus) -mulzA /=.
by rewrite !inzpD inzp_over.
qed.

lemma mul54_mul1_redp x x54 l:
 4 %| x =>
 x54 = 5 * (x %/ 4) =>
 inzp (2^128 * val_digits64 (mul1_digits x l)) = inzp (val_digits64 (mul1_digits x54 l)).
proof.
move => /dvdzP [x' ->].
rewrite mulzK // => ->.
rewrite !mul1_digitsP (mulzC _ 4) -!mulzA /= mulzA.
by rewrite inzp_over; congr; ring.
qed.

lemma add_digits64_redp x x54 l la l1 l2:
 4 %| x =>
 x54 = 5 * (x %/ 4) =>
 l1 = add_digits la (0::0::List.map (fun h => h * x) l) =>
 val_digits64 l2 = val_digits64 (add_digits la (map (fun h => h * x54) l)) =>
 inzp (val_digits64 l1) = inzp (val_digits64 l2).
proof.
move=> ?? -> ->.
rewrite !add_digitsP !inzpD -!mul1_digitsCE; congr.
rewrite !val_digits_cons /= -!mulzA /=.
by apply (mul54_mul1_redp x x54 l).
qed.

(*****************************************)

op mulmod3_pass0 (h: Rep3) (r:Rep3r) =
 [ to_uint (h.[0] * r.[0]) + to_uint (h.[1] * r.[2]);

   to_uint (h.[0] * r.[1]) + to_uint (mulhi h.[0] r.[0]) +
   to_uint (mulhi h.[1] r.[2]) + to_uint (h.[1] * r.[0]) + 
   to_uint (h.[2] * r.[2]);

   to_uint (mulhi h.[0] r.[1]) + to_uint (mulhi h.[1] r.[0]) +
   to_uint (h.[2] * r.[0])
 ].

lemma mulmod3_pass0_ok (h:Rep3) (r:Rep3r):
  ubW64 6 h.[2] =>
  Rep3r_ok r =>
  zpcgr (valRep3 h * valRep3r r) (val_digits64 (mulmod3_pass0 h r)).
proof.
rewrite /valRep3 /valRep3r -mul_limbs64P eq_inzp /to_list /mkseq => /> *.
apply (add_digits64_redp (to_uint r.[1]) (to_uint r.[2]) [ to_uint h.[1]; to_uint h.[2] ]
  [ to_uint h.[0] * to_uint r.[0];
    to_uint h.[0] * to_uint r.[1] + to_uint h.[1] * to_uint r.[0];
    to_uint h.[2] * to_uint r.[0] ]) => //. by rewrite /mul1_digits => /#. (*TO*)
rewrite /= /mulmod3_pass0 -!mulhiP !val_digits_cons; ring.
by rewrite (ubW64_mulhi0 6 1152921504606846975) // (ubW64_mulhi0 6 1441151880758558715).
qed.

op mulmod3_pass1 (h: Rep3) (r:Rep3r) =
 add_limbs64nc
   ((h.[0]*r.[0]) :: add_limbs64nc [h.[1]*r.[0] ; h.[2]*r.[0] ]
                                   [mulhi h.[0] r.[0]; mulhi h.[1] r.[0]])
   [h.[1]*r.[2]; h.[0]*r.[1]; mulhi h.[0] r.[1] ].

lemma mulmod3_pass1_ok (h:Rep3) (r:Rep3r):
  ubW64 6 h.[2] =>
  Rep3r_ok r =>
  val_digits64 (mulmod3_pass0 h r)
  = val_limbs64 (mulmod3_pass1 h r) + val_limbs64 [W64.zero; mulhi h.[1] r.[2] + h.[2]*r.[2]]
  /\ ubW64 9223372036854775797 (nth_limbs64 (mulmod3_pass1 h r) 2).
proof.
rewrite /mulmod3_pass1 => /> *.
have /= ?:= ubW64M _ _ _ _ H H0.
have ?:= ubW64T h.[0].
have ?:= ubW64T h.[1].
have /= := ubW64Mhi _ _ _ _ H7 H0.
have -> ?: 21267647932558653946861247386169114625 %/ 18446744073709551616
           = 1152921504606846974 by smt (edivzP divz_small).
have /= := ubW64Mhi _ _ _ _ H6 H1.
have -> ?: 21267647932558653891521015165040459780 %/ 18446744073709551616
           = 1152921504606846971 by smt (edivzP divz_small).
have /= ?:= ubW64M _ _ _ _ H H4.
have /= := ubW64Mhi _ _ _ _ H7 H4.
have -> ?: 26584559915698317364401268956300574725 %/ 18446744073709551616
           = 1441151880758558714 by smt (edivzP divz_small).
have /= [->] := (add_limbs64ncP' (6917529027641081850+1152921504606846974+1) 1152921504606846971
             ((h.[0] * r.[0]) :: add_limbs64nc [h.[1] * r.[0]; h.[2] * r.[0]]
                              [mulhi h.[0] r.[0]; mulhi h.[1] r.[0]])
        [h.[1] * r.[2]; h.[0] * r.[1]; mulhi h.[0] r.[1]] _ _ _ _)
; rewrite /= ?size_add_limbs64nc /nth_limbs64 //=.
 rewrite /add_limbs64nc /= !addcE /=.
 smt(ubW64_lemmas).
move=> Hub; split; last by apply Hub.
rewrite /mulmod3_pass0 /= !val_digits_cons val_digits_nil /=.
rewrite (add_limbs64ncP 6917529027641081850 1152921504606846974) => //=.
rewrite !val_digits_cons bW64_to_uintD 1:bW64ub 1://.
  smt(ubW64_lemmas).
 rewrite bW64ub 1://; smt(ubW64_lemmas).
by ring.
qed.

lemma mulmod3_pass1_spec (h:Rep3) (r:Rep3r):
  ubW64 6 h.[2] =>
  Rep3r_ok r =>
  exists t0 t1 t2, mulmod3_pass1 h r = [t0; t1; t2] &&
  inzp (valRep3 h * valRep3r r)
  = inzp (val_limbs64 [t0; t1; t2]
          + val_limbs64 [W64.zero; mulhi h.[1] r.[2] + h.[2]*r.[2]] )
  /\ ubW64 9223372036854775797 (nth_limbs64 (mulmod3_pass1 h r) 2).
proof.
rewrite /= => *.
exists (nth_limbs64 (mulmod3_pass1 h r) 0) 
       (nth_limbs64 (mulmod3_pass1 h r) 1)
       (nth_limbs64 (mulmod3_pass1 h r) 2); split.
 by rewrite /mulmod3_pass1 /add_limbs64nc /nth_limbs64.
move => E.
have := mulmod3_pass0_ok _ _ H H0.
rewrite eq_inzp.
have /= [-> ?] := mulmod3_pass1_ok _ _ H H0.
by rewrite {1}E /=.
qed.

op split_h2 (h2: W64.t) : W64.t * W64.t =
 (h2 `&` W64.of_int 3, (h2 `&` W64.of_int 18446744073709551612) + (h2 `>>` W8.of_int 2)).

lemma split_h2_spec h2:
 ubW64 9223372036854775797 h2 =>
 exists x y, split_h2 h2 = (x,y) /\
 to_uint x = to_uint h2 %% 4 /\
 to_uint y = 5 * (to_uint h2 %/ 4) /\
 inzp (2^128 * to_uint h2) = inzp (2^128 * to_uint x) + inzp (to_uint y).
proof.
move=> Hub.
exists (splitAt 2 h2).`1 ((splitAt 2 h2).`2 + (h2 `>>` W8.of_int 2)); split.
 rewrite /split_h2 /splitMask /=; congr; congr.
 apply W64.word_modeqP; congr.
 by rewrite of_uintK modz_small // to_uint_invw.
have := W64.splitAtP 2 h2 _; first by [].
rewrite /splitMask /=; move=> [<- E]; split; first by [].
have ? := ubW64Wand _ _ (invw ((of_int 3))%W64) Hub.
have ? := ubW64shr 2 _ _ _ Hub => //.
rewrite (ubW64D_to_uint _ _ _ _ _ H H0).
 smt (edivzP divz_small).
split; first by rewrite E to_uint_shr // pow2_2; ring.
rewrite E to_uint_shr // (W64.to_uint_and_mod 2) // !pow2_2.
rewrite {1}(divz_eq (to_uint h2) 4) mulzDr !inzpD.
rewrite (mulzC _ 4) -mulzA /= inzp_over (mulzDl 4 1) inzpD /=.
by ring.
qed.

lemma split_h2_repp h0 h1 h2:
 ubW64 9223372036854775797 h2 =>
 inzp (val_limbs64 [h0; h1; h2])
 = inzp (val_limbs64 [h0; h1; (split_h2 h2).`1])
   + inzp (val_limbs64 [(split_h2 h2).`2]).
proof.
move=> *.
have [? ? [-> /= [?[??]]]] := split_h2_spec _ H.
by rewrite /val_digits /= !mulzDr -!mulzA /= !inzpD H2; ring.
qed.

op mulmod3_pass2 (h: Rep3) (r:Rep3r) =
 let t = mulmod3_pass1 h r in
 let (h21, h22) = split_h2 (nth W64.zero t 2) in
 add_limbs64nc [nth W64.zero t 0; nth W64.zero t 1; h21]
               [h22; mulhi h.[1] r.[2] + h.[2]*r.[2]].

lemma mulmod3_pass3_ok (h:Rep3) (r:Rep3r):
  ubW64 6 h.[2] =>
  Rep3r_ok r =>
  inzp (valRep3 h * valRep3r r)
  = inzp (val_limbs64 (mulmod3_pass2 h r))
  /\ ubW64 4 (nth_limbs64 (mulmod3_pass2 h r) 2).
proof.
rewrite /mulmod3_pass2 => *.
have [t0 t1 t2 [-> [->]]] := mulmod3_pass1_spec _ _ H H0.
rewrite /nth_limbs64 /= => Ht2.
have [h21 h22 [-> /= [?[??]]]] /= := split_h2_spec _ Ht2.
have := add_limbs64ncP' 3 0
         [t0; t1; h21] [h22; mulhi h.[1] r.[2] + h.[2] * r.[2]]
         _ _ _ _; rewrite /nth_limbs64 //=.
 by rewrite /ubW64 H1 /=; smt(modz_cmp).
rewrite inzpD; move => [-> /= Hub].
split; last by [].
by rewrite /val_digits /= !mulzDr -!mulzA /= !inzpD H3; ring.
qed.

lemma mulmod3_spec (h hh:Rep3) (r:Rep3r):
  ubW64 6 h.[2] =>
  Rep3r_ok r =>
  [hh.[0]; hh.[1]; hh.[2]] = mulmod3_pass2 h r =>
  (repres3 h * repres3r r) = repres3 hh
  /\ ubW64 4 hh.[2].
proof.
move=> *.
rewrite !repres3E repres3rE -inzpM.
have := (mulmod3_pass3_ok _ _ H H0).
rewrite -!H1 /nth_limbs64 /=; move => [-> ->] /=; congr.
by rewrite /val_digits /=; ring.
qed.

(******************************************************************************************

                                   3-limb implementations

 ******************************************************************************************)

(* 3-limb implementations are taken directly from the jasmin-extracted code *)
require Poly1305_savx2.

module Mrep3 = {
  proc clamp = Poly1305_savx2.M.clamp
  proc load_add = Poly1305_savx2.M.load_add
  proc load_last_add = Poly1305_savx2.M.load_last_add
  proc mulmod = Poly1305_savx2.M.mulmod
  proc freeze = Poly1305_savx2.M.freeze
  proc load2 = Poly1305_savx2.M.load2
  proc store2 = Poly1305_savx2.M.store2
  proc add2 = Poly1305_savx2.M.add2
  proc setup = Poly1305_savx2.M.poly1305_ref3_setup
  proc update = Poly1305_savx2.M.poly1305_ref3_update
  proc finish = Poly1305_savx2.M.poly1305_ref3_last
  proc poly1305 = Poly1305_savx2.M.poly1305_ref3_local
}.

(****************************        Rep3 specs              *******************************)

require import Poly1305_Spec.

lemma clamp_spec mem kk:
 phoare [ Mrep3.clamp:
           Glob.mem = mem /\ kk = k /\  good_ptr kk 16
          ==>
           Rep3r_ok res /\ repres3r res = load_clamp mem kk ] = 1%r.
proof.
proc; wp; skip => ? /> *.
pose r0 := loadW64 Glob.mem{hr} (to_uint k{hr}) `&` W64.of_int 1152921487695413247.
pose r1 := loadW64 Glob.mem{hr} (to_uint (k{hr} + W64.of_int 8)) `&` W64.of_int 1152921487695413244.
have ?: ubW64 1152921504606846975 r0.
 apply (ubW64W 1152921487695413247) => //.
 have {1}->: 1152921487695413247 = 1152921487695413247 %% W64.modulus by smt(modz_small).
 rewrite /ubW64 /r0 -W64.of_uintK andwC W64.to_uintK. 
 by apply W64.to_uint_ule_andw.
have ?: ubW64 1152921504606846972 r1.
 apply (ubW64W 1152921487695413244) => //.
 have {1}->: 1152921487695413244 = 1152921487695413244 %% W64.modulus by smt(modz_small).
 rewrite /ubW64 /r1 -W64.of_uintK andwC W64.to_uintK.
 by apply W64.to_uint_ule_andw.
split; progress; rewrite /r0 /r1 //=.
+ rewrite dvdzE /r1 -(W64.to_uint_and_mod 2) // -andwA.
  have ->: (of_int 1152921487695413244)%W64 `&` (masklsb 2)%W64 = W64.zerow.
   apply W64.word_modeqP; congr.
   by rewrite to_uint0 W64.to_uint_and_mod //.
  by rewrite andw0.
+ rewrite to_uintD.
   have /= ?:= ubW64shr 2 1152921504606846972 _ _ H1 => //=.
   rewrite to_uint_shr //= modz_small.
    apply bound_abs; smt(W64.to_uint_cmp).
   smt().
  smt().
+ rewrite repres3rE /load_clamp /=; congr.
  rewrite -load2u64 /= -(of_int2u64 1152921487695413247 1152921487695413244) // andb2u64E /=.
  rewrite to_uintD_small of_uintK modz_small //; first smt().
  by rewrite to_uint2u64; ring.
qed.

lemma load_add_spec mem hh inp:
 phoare [ Mrep3.load_add:
           Glob.mem = mem /\ hh = h /\ inp = in_0 /\ ubW64 4 hh.[2] /\ good_ptr inp 16
          ==>
           ubW64 6 res.[2] /\
           repres3 res = repres3 hh + (load_block mem inp) ] = 1%r.
proof.
proc; wp; skip =>?[<-[<-[<-[? Hptr]]]] *.
have E: [h2.[0]; h2.[1]; h2.[2]]
        = add_limbs64nc [hh.[0]; hh.[1]; hh.[2]] 
                        [loadW64 Glob.mem{hr} (to_uint (inp + W64.zero));
                         loadW64 Glob.mem{hr} (to_uint (inp + (of_int 8)%W64));
                         W64.one].
 by rewrite /add_limbs64nc /h2 /tpl1 /h1 /tpl0 /h0 /tpl //=; clear h2 tpl1 h1 tpl0 h0 tpl.
have := add_limbs64ncP' 4 1 [hh.[0]; hh.[1]; hh.[2]]
      [loadW64 Glob.mem{hr} (to_uint (inp + W64.zero));
         loadW64 Glob.mem{hr} (to_uint (inp + (of_int 8)%W64)); W64.one] _ _ _ _; rewrite /nth_limbs64 //=.
rewrite -E; move => {E} [E ?]; split; first by [].
rewrite !repres3E {1}/valRep3 valRep3E /= E /load_block /load_lblock /= inzpD; congr.
 by congr; rewrite /val_digits /= !mulzDr; ring.
rewrite -(W16u8.Pack.init_ext (fun i => Glob.mem{hr}.[to_uint inp + i])) 1:/#.
congr.
rewrite to_uintD_small of_uintK modz_small //; first by move: Hptr; smt().
rewrite !load8u8' /val_digits /mkseq /=.
rewrite !(to_uint_unpack8u8 (W8u8.pack8 _)) /=.
rewrite (to_uint_unpack16u8 (W16u8.pack16_t _)) /=.
by rewrite /val_digits /=; ring.
qed.

op load_lblock' (mem : global_mem_t) (l ptr : W64.t) = 
   Zp.inzp (W128.to_uint (pack16_t (W16u8.Pack.init 
            (fun i => if i = W64.to_uint l then W8.one
                      else if i < W64.to_uint l 
                      then mem.[to_uint ptr + i] 
                      else W8.zero)))).

lemma load_lblock_alt mem l ptr:
 W64.to_uint l < 16 =>
 load_lblock mem l ptr = load_lblock' mem l ptr.
proof.
rewrite /load_lblock /load_lblock' /= => *; congr.
have ? : 0 <= to_uint l < 16 by smt(W64.to_uint_cmp).
rewrite -pow_mul //=; first smt().
have : to_uint l \in iota_ 0 16 by rewrite mem_iota; smt().
move: (to_uint l); apply/List.allP => /=.
rewrite !to_uint_unpack16u8 /val_digits /=; smt().
qed.

lemma load_last_add_spec_h mem hh inp inlen:
 hoare [ Mrep3.load_last_add:
           Glob.mem = mem /\ h = hh /\ in_0 = inp /\ len = inlen /\ ubW64 4 hh.[2] /\
           to_uint inlen < 16 /\ good_ptr in_0 (to_uint inlen)
          ==>
           ubW64 6 res.[2] /\
           repres3 res = repres3 hh + (load_lblock mem inlen inp) ].
proof.
proc => /=.
seq 6: (#pre /\ repres2 s = load_lblock mem inlen inp).
wp; while (j \ule len /\ in_0 = inp /\ len = inlen /\ to_uint inlen < 16 /\
           good_ptr in_0 (to_uint len) /\
           s = Array2.init (WArray16.get64 (WArray16.of_list 
                             (mkseq (fun i=> Glob.mem.[(to_uint in_0) + i]) (W64.to_uint j))))).
+ wp; skip; progress.
   move: {H} H2; rewrite ultE uleE => *. 
   by rewrite to_uintD_small /=; move: (W64.to_uint_cmp len{hr}); smt().
  move: {H} H0 H1 H2; rewrite ultE => Hlen_bnd Hptr Hj_bnd.
  move: (W64.to_uint_cmp in_0{hr}) (W64.to_uint_cmp j{hr}) => [Hin0 Hin1] [Hj0 X] {X}.
  have Hj1: to_uint in_0{hr} + to_uint j{hr} < W64.modulus by smt(StdOrder.IntOrder.ltr_le_trans).
  rewrite to_uintD_small //=.
  rewrite to_uintD_small; first by rewrite of_uintK modz_small; smt().
  congr; congr; rewrite /WArray16.set8 /= /loadW8 /=.
  rewrite WArray16.of_listE /= WArray16.of_listE WArray16.setE.
  pose X := WArray16.init64 _.
  apply WArray16.init_ext => i [Hi0 Hi1] /=.
  have HX: WArray16."_.[_]" X i
           = if i < to_uint j{hr} then Glob.mem{hr}.[to_uint (in_0{hr})+i] else W8.zero.
   rewrite /X; clear X.
   rewrite -(WArray16.init_ext (fun i => if i < to_uint j{hr}
                                                  then Glob.mem{hr}.[to_uint in_0{hr} + i]
                                                  else W8.zero)).
    by move=> k [Hk0 Hk1] /=; rewrite nth_mkseq_if Hk0.
   by rewrite WArray16_init64K WArray16.initE Hi0 Hi1.
  rewrite /mkseq iota_add //.
  rewrite iota1 /= map_cat nth_cat /= size_map size_iota max_ler //.
  case: (i < to_uint j{hr}) => ?.
   have ->/=: !i = to_uint j{hr}; first smt().
   rewrite nth_mkseq_if H Hi0 /=.
   by rewrite HX H.
  case: (i = to_uint j{hr}) => //= ?.
  have ->/= : !i - to_uint j{hr} = 0 by smt().
  rewrite HX.
  by have ->: !i < to_uint j{hr} by smt().
+ wp; skip; progress.
   by rewrite uleE /=; smt(W64.to_uint_cmp).
  rewrite mkseq0  WArray16.of_listE /=.
  rewrite -Array2.ext_eq_all /all_eq /=.
  by split;
   rewrite WArray16.get64E /=;
   apply W64.word_modeqP; congr;
   rewrite pack8u8_init_mkseq /mkseq /= (to_uint_unpack8u8 (W8u8.pack8_t _)) /=.
+ move: {H H4 H5} H0 H1.
  have ->: len{hr} = j0 by move: H2 H3; rewrite uleE ultE -lezNgt; smt(W64.word_modeqP).
  move: (W64.to_uint_cmp in_0{hr}) (W64.to_uint_cmp j{hr}) => [Hin0 Hin1] [Hj0 X] {X} Hj1 Hptr.
  rewrite load_lblock_alt /load_lblock' //=.
  rewrite repres2E valRep2_to_uint16u8; congr; congr; congr.
  apply W16u8.Pack.init_ext => i [Hi0 Hi1].
  rewrite /WArray16.set8.
  have ->: WArray16.of_list (mkseq (fun (i : int) =>
                                       Glob.mem{hr}.[to_uint in_0{hr} + i]) (to_uint j0))
           =  WArray16.init (fun (i : int) => if i < to_uint j0 
                                              then Glob.mem{hr}.[to_uint in_0{hr} + i]
                                              else W8.zero).
   rewrite WArray16.of_listE; apply WArray16.init_ext => k [Hk0 Hk1] /=.
   by rewrite nth_mkseq_if Hk0.
  rewrite WArray16_init64K WArray16.setE.
  by do rewrite WArray16.initE /= Hi0 Hi1 /=. 
wp; skip => ? [[?[?[?[?[?[??]]]]]]] *.
have E: [h2.[0]; h2.[1]; h2.[2]]
        = add_limbs64nc [hh.[0]; hh.[1]; hh.[2]] 
                        [s{hr}.[0]; s{hr}.[1]].
 rewrite /add_limbs64nc -!H0 /h2 /tpl1 /h1 /tpl0 /h0 /tpl //=; progress.
 by rewrite addcE /=.
have /= := add_limbs64ncP' 4 0 [hh.[0]; hh.[1]; hh.[2]] 
                               [s{hr}.[0]; s{hr}.[1]].
rewrite/ nth_limbs64 /= ubW640 H3 /= -E => [[?/=?]]; split.
 by apply (ubW64W 5).
rewrite -H6 !repres3E {1}/valRep3 valRep3E repres2E /= H7 /= inzpD /val_digits; congr.
by congr; simplify; ring.
qed.

lemma load_last_add_spec_ll: islossless Mrep3.load_last_add.
proof.
proc; wp.
while (j \ule len) (to_uint (len-j)).
 move=> *; wp; skip; rewrite !ultE !uleE; progress.
  by rewrite uleE to_uintD_small /=; move: (W64.to_uint_cmp len{hr}) => /#.
 rewrite to_uintB ?uleE //.
  by rewrite to_uintD_small /=; move: (W64.to_uint_cmp len{hr}) => /#.
 rewrite to_uintB ?uleE //.
 by rewrite to_uintD_small /=; move: (W64.to_uint_cmp len{hr}) => /#.
wp; skip; rewrite !uleE; progress; first smt(W64.to_uint_cmp).
move: H; rewrite uleE ultE => *.
by move: H0; rewrite to_uintB ?uleE // /#.
qed.

lemma load_last_add_spec mem hh inp inlen:
 phoare [ Mrep3.load_last_add:
           Glob.mem = mem /\ h = hh /\ in_0 = inp /\ len = inlen /\ ubW64 4 hh.[2] /\
           to_uint inlen < 16 /\ good_ptr in_0 (to_uint inlen)
          ==>
           ubW64 6 res.[2] /\
           repres3 res = repres3 hh + (load_lblock mem inlen inp) ] = 1%r.
proof. by conseq load_last_add_spec_ll (load_last_add_spec_h mem hh inp inlen). qed.

lemma mulmod_spec_h (hh:Rep3) (rr:Rep3r):
 hoare [ Mrep3.mulmod: 
             ubW64 6 hh.[2] /\ Rep3r_ok rr /\
             hh = h /\ rr = r  
             ==>
             ubW64 4 res.[2] /\
             repres3 res = (repres3 hh * repres3r rr) ].
proof.
proc.
seq 13: (ubW64 6 hh.[2] /\ Rep3r_ok rr /\ rr = r /\
         t2 = hh.[2]*rr.[2] /\ h.[0] = hh.[0] /\ h.[1] = hh.[1] /\
         t0 = hh.[0]*rr.[0] /\
         [t1; h.[2]] = add_limbs64nc [hh.[1] * rr.[0]; hh.[2] * rr.[0]]
                                      [mulhi hh.[0] rr.[0]; mulhi hh.[1] rr.[0]]) => //.
 wp; skip; progress.
    by rewrite mulrC.
   by rewrite muluE /= mulrC.    
  rewrite !muluE /= !addcE /=; congr.
  by rewrite /mulhi mulzC; ring.
 rewrite !muluE /= !addcE /=; congr; congr.
  by rewrite /mulhi mulzC.
 by congr; rewrite /carry_add mulrC /#.
seq 12: (ubW64 6 hh.[2] /\ Rep3r_ok rr /\ rr = r /\
         h.[1] = mulhi hh.[1] r.[2] + hh.[2]*r.[2] /\
         [t0; t1; h.[2]] = mulmod3_pass1 hh rr) => //.
 wp; skip; progress; rewrite !muluE /=.
   by congr; rewrite /mulhi mulzC H2.
  by rewrite H2 !addcE /=; ring.
 rewrite -H3 /= !H1 !H2; progress.
  by rewrite mulrC (W64.WRingA.mulrC r{hr}.[2] hh.[1]).
 rewrite {1}mulrC -!H1 !addcE //=; congr; congr.
  by rewrite /mulhi mulzC.
 by rewrite (W64.WRingA.mulrC r{hr}.[2] hh.[1]).
(* split_h2 *) 
exists* (h.[2]); elim* => h2.
seq 6: (ubW64 6 hh.[2] /\ Rep3r_ok rr /\ rr = r /\
        h.[1] = mulhi hh.[1] r.[2] + hh.[2]*r.[2] /\
        split_h2(h2) = (h.[2], h.[0]) /\
        [t0; t1; h2] = mulmod3_pass1 hh rr) => //.
 by wp; skip; progress; rewrite andwC; congr.
(* final chain *)
wp; skip => ? H *; move: H => |> *.
have E: [h1.[0]; h1.[1]; h1.[2]] = mulmod3_pass2 hh r{hr}.
 rewrite /mulmod3_pass2 /h1 /tpl1 /h0 /tpl0 /h /tpl; clear h1 tpl1 h0 tpl0 h tpl.
 rewrite  /= -H3 /= H2 /= -H1 /add_limbs64nc /=; progress.
   by rewrite !addcE /=; ring.
  by rewrite !addcE /= carry_addC; ring.
 by rewrite !addcE /= carry_addC (W64.carry_addC t0{hr}).
by have [-> ->] := mulmod3_spec _ _ _ H H0 E.
qed.

lemma mulmod_spec_ll : islossless Mrep3.mulmod.
proof. by proc; auto. qed.

lemma mulmod_spec (hh: W64.t Array3.t) rr :
  phoare [ Mrep3.mulmod: 
             ubW64 6 hh.[2] /\ Rep3r_ok rr /\
             hh = h /\ rr = r  
             ==>
             ubW64 4 res.[2] /\
             repres3 res = (repres3 hh * repres3r rr) ] = 1%r. 
proof. by conseq mulmod_spec_ll (mulmod_spec_h hh rr). qed.

lemma freeze_spec_h hh:
  hoare [ Mrep3.freeze :
            hh = h /\ ubW64 4 h.[2]
          ==>
            valRep2 res = (asint (repres3 hh)) %% 2^128 ].
proof.
have X: ubW64 4 hh.[2] => valRep3 hh < 2*p.
 rewrite /ubW64 /= pE.
 have /= ??:= W64.to_uint_cmp hh.[0].
 have /= ?:= W64.to_uint_cmp hh.[1].
 smt().
proc.
seq 11: (#pre /\ val_limbs64 [g.[0]; g.[1]; g2] = valRep3 hh + 5) => //.
 wp; skip => ?[<-?]*.
 split; first by [].
 have ->: 5 = val_limbs64 [W64.of_int 5] by smt().
 have ->: [g3.[0]; g3.[1]; (addc hh.[2] W64.zero tpl0.`1).`2]
          = add_limbs64nc [hh.[0]; hh.[1]; hh.[2]] [W64.of_int 5].
  by rewrite /add_limbs64nc /g3 /tpl0 /g1 /tpl /g0 /= !addcE.
 have ->:= add_limbs64ncP 4 0 [hh.[0]; hh.[1]; hh.[2]] [W64.of_int 5] _ _ _ _;
 by rewrite /nth_limbs64 /val_digits //=; ring.
seq 2: (#[/1:3]pre /\
        (p <= valRep3 hh => val_limbs64 [g.[0]; g.[1]] = (asint (repres3 hh)) %% W128.modulus) /\
        mask = if valRep3 hh < p then W64.zerow else W64.onew) => //.
 wp; skip  => ?[[<-?]E]*.
 split; first by done.
 split.
  move: (X H) => ??.
  rewrite repres3E inzpK zp_over_lt2p_red.
   by split => // ? //.
  rewrite -E modz_mod_pow2 /min /=.
  by rewrite (val_limbs64_mod2128 g{hr}.[0] g{hr}.[1] g2{hr}).
 have : to_uint (g2{hr}) %/ 4 = if valRep3 hh < p then 0 else 1.
  rewrite -(ltz_add2r 5) pE.
  have ->: 2^130 - 5 + 5 = 2^130 by done.
  case: (valRep3 hh + 5 < 2 ^ 130).
   rewrite -E -(val_limbs64_div2130 g{hr}.[0] g{hr}.[1]) /= => ?. 
   apply divz_eq0 => //; split => //.
   by rewrite /val_digits /=; smt(W64.to_uint_cmp).
  move: E; pose x:=val_limbs64 [g{hr}.[0]; g{hr}.[1]; g2{hr}]; move => E.
  move: (X H); rewrite -(ltz_add2r 5) pE -E. 
  by rewrite -(val_limbs64_div2130 g{hr}.[0] g{hr}.[1]) -/x /#.
 case: (valRep3 hh < p) => ??.
  have ->: g2{hr} `>>` (of_int 2)%W8 = W64.zerow.
   apply W64.word_modeqP; rewrite to_uint_shr //.
   rewrite (W8.of_uintK 2) !pow2_2.
   by rewrite (modz_small 2 W8.modulus) // H1 to_uint0.
  by rewrite /W64.zerow; ring.
 have ->: g2{hr} `>>` (of_int 2)%W8 = W64.one.
  apply W64.word_modeqP; rewrite to_uint_shr //.
  rewrite (W8.of_uintK 2) !pow2_2.
  by rewrite (modz_small 2 W8.modulus) // H1 to_uint1.
 by rewrite minus_one.
(* *)
wp; skip => ?[[<-?]].
case: (valRep3 hh < p).
 move => |> *.
 rewrite !andw0 !xor0w repres3E inzpK (modz_small (valRep3 hh)).
  apply bound_abs => /=; smt(W64.to_uint_cmp).
 by rewrite /valRep3 (val_limbs64_mod2128 hh.[0] hh.[1] hh.[2]) /val_digits.
move => ?; have -> /= [? ->/=]: p <= valRep3 hh. 
 by rewrite lezNgt.
by rewrite -!xorwA !xorwK !xorw0 H1 !repres3E !inzpK.
qed.

lemma freeze_spec_ll: islossless Mrep3.freeze.
proof. by proc; auto. qed.

lemma freeze_spec hh:
  phoare [ Mrep3.freeze :
            hh = h /\ ubW64 4 h.[2]
          ==>
            valRep2 res = (asint (repres3 hh)) %% 2^128 ] = 1%r.
proof. by conseq freeze_spec_ll (freeze_spec_h hh). qed.

lemma load2_spec mem kk:
 phoare [ Mrep3.load2:
           Glob.mem = mem /\ kk = p /\ good_ptr kk 16
          ==>
           valRep2 res = W128.to_uint (loadW128 mem (to_uint kk)) ] = 1%r.
proof.
proc; wp; skip; progress.
by rewrite -load2u64 // to_uint2u64 to_uintD_small //; smt().
qed.

lemma store2_spec mem pp xx:
 phoare [ Mrep3.store2:
           Glob.mem = mem /\ pp = p /\ xx = x /\ good_ptr pp 16
          ==>
           Glob.mem = storeW128 mem (to_uint pp) (W128.of_int (valRep2 xx))] = 1%r.
proof.
proc; wp; skip; progress.
rewrite to_uintD_small.
 by rewrite of_uintK modz_small //; smt(StdOrder.IntOrder.ltr_le_trans).
rewrite -store2u64; congr.
apply W128.word_modeqP; congr.
rewrite to_uint2u64 of_uintK modz_small //.
apply bound_abs; split; first smt(W64.to_uint_cmp).
move=> *. 
have /= ? := W64.to_uint_cmp x{hr}.[0].
have /= ? := W64.to_uint_cmp x{hr}.[1].
smt().
qed.

lemma add2_spec (hh ss: W64.t Array2.t):
 phoare [ Mrep3.add2 : 
             hh = h /\ ss = s  
          ==>
             valRep2 res = (valRep2 hh + valRep2 ss)%%2^128 ] = 1%r.
proof.
proc; wp; skip => ?[<- <-]*.
have E : (tpl0.`1, [tpl.`2; tpl0.`2]) = add_limbs64 [hh.[0]; hh.[1]] [ss.[0]; ss.[1]] false.
 by rewrite /= !addcE /= /h0 //=.
have ->: valRep2 hh + valRep2 ss = valRep2 hh + valRep2 ss + b2i false by rewrite b2i0.
have := (add_limbs64P [hh.[0]; hh.[1]] [ss.[0]; ss.[1]] false).
rewrite -E /= => <-.
rewrite /val_digits /=.
rewrite -modzDmr modzMr /= modz_small.
 apply bound_abs.
 have /= ? := W64.to_uint_cmp tpl.`2.
 have /= ? := W64.to_uint_cmp tpl0.`2.
 smt().
by rewrite /h0 /tpl.
qed.


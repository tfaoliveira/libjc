require import List Int IntExtra IntDiv CoreMap.
from Jasmin require import JModel.

require import Array25 WArray200 EclibExtra JWordList.

require import Spec1600 Keccak1600_sref.



(* Bounded memory assumption (established by the safety analysis) *)
abbrev good_ptr (ptr: W64.t) len =
 to_uint ptr + len < W64.modulus.
op inv_ptr (in_0 inlen out outlen: W64.t) =
 good_ptr in_0 (to_uint inlen) /\ good_ptr out (to_uint outlen).



(* lemmata... *)
lemma to_uintS_lt (x y:W64.t) :
 to_uint x < to_uint y =>
 to_uint (x + W64.one) = to_uint x + 1.
proof.
move=> H; rewrite to_uintD_small of_uintK modz_small //.
move: (W64.to_uint_cmp y); smt().
qed.

(* ...for readability *)
abbrev upd8 (f: W8.t -> W8.t -> W8.t) (st:state) (i:int) (x:W8.t) =
 state25 (set8 (state200 st) i (f (get8 (state200 st) i) x)).

lemma upd8_state_xor8 i st l x:
 i = size l =>
 0 <= i < 200 =>
(* state25 (set8 (state200 (addstate8 st l)) i
                 (get8 (state200 (addstate8 st l)) i `^` x))              *)
 upd8 W8.(`^`) (addstate8 st l) i x
 = state_xor8 (addstate8 st l) i x.
proof. by move=> Hsz Hi; rewrite /get8 addstate8_get8E_out // /#. qed.

(* SPECIFICATION OF LEAF-FUNCTIONS *)

lemma st0_spec_h:
  hoare [ M.st0 : true ==> res = st0 ] .
proof.
proc; sp.
while (0 <= i <= 25 /\ forall k, 0 <= k < i => state.[k]=W64.zero).
 wp; skip; progress; first 2 smt().
 case: (k < i{hr}) => E.
  by rewrite set_neqiE 1,2:/# H1 /#.
 by rewrite set_eqiE /#.
skip; progress; first smt().
move: H2; have ->: i0 = 25 by smt().
by move=> H2; apply Array25.ext_eq => ??; rewrite (H2 x) // /st0 createiE.
qed.

lemma st0_spec_ll: islossless M.st0.
proof.
islossless; while true (25 - i).
 by move=> ?; wp; skip => ? [??] /#.
by skip => ??? /#.
qed.

lemma st0_spec:
  phoare [ M.st0 : true ==> res = st0 ] = 1%r.
proof. by conseq st0_spec_ll st0_spec_h. qed.


lemma add_full_block_spec_h st in_ inlen_ r8_:
  hoare [ M.add_full_block:
           state = st
           /\ in_0 = in_
           /\ inlen = inlen_
           /\ r8 = r8_
           /\ good_ptr in_0 rate8
           /\ to_uint r8 = rate8
          ==>
           res.`1 = addstate64 st (memread64 Glob.mem (to_uint in_) rate64)
           /\ res.`2 = in_ + r8_
           /\ res.`3 = inlen_ - r8_
        ].
proof.
have Rbnds:= rate64_bnds.
have Wbnds:= W64.to_uint_cmp.
proc; simplify; wp; sp.
while (#[4:]pre /\ to_uint r64 = rate64 /\ to_uint i <= rate64 /\
       state = addstate8 st 
                   (absorb_split (memread Glob.mem (to_uint in_) (8*to_uint i))).`1).
 wp; skip; rewrite ultE; progress.
 + by rewrite to_uintD_small of_uintK modz_small /#.
 + rewrite (to_uintS_lt _ _ H3).
   rewrite /absorb_split /= !take_memread 1,2:/# !min_ler 1,2:/#.
   rewrite -!addstate64_w8L -!memread64E memread64S 1:/#.
   rewrite (addstate64_rconsE (to_uint i{hr})) ?size_memread64 1..3:/#.
   rewrite addstate64_getE_out ?size_memread64 // 1:/#.
   rewrite to_uintD_small to_uintM of_uintK !modz_small //; smt().
skip; progress.
+ by rewrite to_uint_shr /#.
+ smt().
+ by rewrite /absorb_split /= addstate8_nil.
+ have ->: to_uint i0 = rate64.
   by move: H1; rewrite -W64.uleNgt uleE to_uint_shr of_uintK //= /#.
  move: H5; rewrite /absorb_split /= take_oversize.
   by rewrite size_mkseq; smt().
  by move=>?; rewrite memread64E -addstate64_w8L.
qed.

lemma add_full_block_spec_ll: islossless M.add_full_block.
proof.
proc; wp; sp; while true (to_uint r64-to_uint i).
 move=> ?; wp; skip; progress.
 move: H; rewrite ultE => ?.
 rewrite to_uintD_small of_uintK modz_small //.
  by move: (W64.to_uint_cmp r64{hr}) => /#.
 smt().
skip; progress.
by rewrite ultE /#.
qed.

lemma add_full_block_spec st in_ inlen_ r8_:
 phoare [ M.add_full_block:
           state = st
           /\ in_0 = in_
           /\ inlen = inlen_
           /\ r8 = r8_
           /\ good_ptr in_0 rate8
           /\ to_uint r8 = rate8
          ==>
           res.`1 = addstate64 st (memread64 Glob.mem (to_uint in_) rate64)
           /\ res.`2 = (in_ + r8_)%W64
           /\ res.`3 = inlen_ - r8_
        ] = 1%r.
proof.
by conseq add_full_block_spec_ll (add_full_block_spec_h st in_ inlen_ r8_).
qed.


lemma add_final_block_spec_h st (in_ inlen_: W64.t) trail_byte_:
  hoare [ M.add_final_block:
           state = st
           /\ in_0 = in_
           /\ inlen = inlen_
           /\ trail_byte = trail_byte_
           /\ to_uint r8 = rate8
           /\ to_uint inlen_ < rate8
           /\ good_ptr in_0 (to_uint inlen_)
          ==>
           res = addfinalbit
                   (addstate8 st
                      (absorb_final (W8.of_int (to_uint trail_byte_))
                              (memread Glob.mem (to_uint in_) (to_uint inlen_))))
        ].
proof.
have Rbnds:= rate64_bnds.
have Wbnds:= W64.to_uint_cmp.
proc; simplify.
seq 4: (to_uint i = to_uint inlen_ %/ 8 /\
        state = addstate64 st 
                    (memread64 Glob.mem (to_uint in_) (to_uint inlen_ %/ 8)) /\
        #[2:]pre /\ to_uint inlen8 = to_uint inlen_ %/ 8 ).
 while (#[/3:]post /\ to_uint i <= to_uint inlen8 /\
        state = addstate64 st (memread64 Glob.mem (to_uint in_) (to_uint i))).
  wp; skip; rewrite !ultE; progress.
   by rewrite (to_uintS_lt _ _ H4) /#.
  rewrite (to_uintS_lt _ _ H4) memread64S 1:/# addstate64_rcons size_memread64 1..3:/#.
  rewrite addstate64_getE_out ?size_memread64 // 1:/#.
  by rewrite to_uintD_small to_uintM of_uintK !modz_small // /#.
 wp; skip; progress.
 + by rewrite to_uint_shr /#.
 + by rewrite to_uint_shr 1:/# /= divz_ge0 //= /#.
 + by rewrite addstate64_nil.
 + move: H7; rewrite to_uint_shr 1:/# /= => ?.
   by move: H2; rewrite ultE to_uint_shr /#.
 + move: H7; rewrite to_uint_shr 1:/# /= => ?.
   move: H2; rewrite ultE to_uint_shr 1:/# /= => ?.
   by rewrite (: to_uint i0 = to_uint inlen{hr} %/ 8) /#.
exists* (addstate64 st
          (memread64 Glob.mem (to_uint in_) (to_uint inlen_ %/ 8))); elim* => st'.
seq 2: (#[/1,4:-1]pre /\
        to_uint i = to_uint inlen_ /\
        state = addstate8 st
                  (memread Glob.mem (to_uint in_) (to_uint inlen_))).
 while (#[/:-2]post /\ to_uint inlen_ %/ 8 * 8 <= to_uint i <= to_uint inlen_ /\
        to_uint inlen_ %/ 8 = to_uint i %/ 8 /\
        state = addstate8 st (memread Glob.mem (to_uint in_) (to_uint i))).
  wp; skip; rewrite ultE => ?[[[?]]]; progress.
  + by rewrite (to_uintS_lt _ _ H6) /#.
  + by rewrite (to_uintS_lt _ _ H6) /#.
  + by rewrite (to_uintS_lt _ _ H6) /#.
  + rewrite (to_uintS_lt _ _ H6).
    rewrite memreadS 1:/# addstate8_rcons size_memread 1..3:/#.
    rewrite upd8_state_xor8 ?size_memread 1..3:/#.
    by rewrite to_uintD_small /#.
 wp; skip => ?[?]; progress.
 + by rewrite to_uint_shl of_uintK (modz_small 3) //= modz_small /#.
 + by rewrite to_uint_shl //= /#.
 + by rewrite to_uint_shl //= /#.
 + congr; rewrite memread64E to_uint_shl of_uintK modz_small //= 1:/#.
   by rewrite -H0 (mulzC 8) w8L2w64L2state.
 + by move: H5; rewrite -W64.uleNgt uleE /#.
 + by move: H5; rewrite -W64.uleNgt uleE /#.
exists* (addstate8 st (memread Glob.mem (to_uint in_) (to_uint inlen_))).
elim*=> st''.
seq 1: (#[/:-1]pre /\
        state = state_xor8 st'' (to_uint inlen_) trail_byte_).
 wp; skip => ?[?[[?]]]; progress.
 rewrite upd8_state_xor8 ?size_memread 1..3:/#.
 by rewrite H H4.
wp; skip => ?[[?[?]]] |> *.
rewrite /addfinalbit /absorb_final H /state_xor_u8 /state_xor8.
have ->: (to_uint (r8{hr} - W64.one)) = rate8-1.
 by rewrite to_uintB ?uleE /#.
by rewrite cats1 -(addstate8_rconsE) 1:size_memread /#.
qed.

lemma add_final_block_spec_ll: islossless M.add_final_block.
proof.
islossless.
 while true (to_uint inlen - to_uint i).
  move=> ?; wp; skip; progress.
  move: H; rewrite ultE ltzE=> ?; rewrite to_uintD_small of_uintK modz_small //.
  by move: (W64.to_uint_cmp inlen{hr}); smt().
  smt().
 by skip; progress; rewrite ultE /#.
while true (to_uint inlen8 - to_uint i).
 move=> ?; wp; skip; progress; rewrite to_uintD_small.
  by move: H (W64.to_uint_cmp inlen8{hr}); rewrite ultE ltzE; smt().
 by move: H; rewrite ultE /#.
by skip; progress; rewrite ultE /#.
qed.

lemma add_final_block_spec st (in_ inlen_: W64.t) trail_byte_:
  phoare [ M.add_final_block:
           state = st
           /\ in_0 = in_
           /\ inlen = inlen_
           /\ trail_byte = trail_byte_
           /\ to_uint r8 = rate8
           /\ to_uint inlen_ < rate8
           /\ good_ptr in_0 (to_uint inlen_)
          ==>
           res = addfinalbit
                   (addstate8 st
                      (absorb_final (W8.of_int (to_uint trail_byte_))
                              (memread Glob.mem (to_uint in_) (to_uint inlen_))))
        ] = 1%r.
proof.
by conseq add_final_block_spec_ll (add_final_block_spec_h st in_ inlen_ trail_byte_).
qed.


lemma xtr_full_block_spec_h mem st out_ outlen_:
  hoare [ M.xtr_full_block:
           Glob.mem = mem
           /\ state = st
           /\ out = out_
           /\ outlen = outlen_
           /\ rate8 <= to_uint outlen
           /\ to_uint rate = rate8
           /\ good_ptr out_ rate8
          ==>
           Glob.mem = stores64 mem (to_uint out_) (squeezestate64 st)
           /\ to_uint res.`1 = to_uint out_ + rate8
           /\ to_uint res.`2 = to_uint outlen_ - rate8
        ].
proof.
have Rbnds:= rate64_bnds.
have Wbnds:= W64.to_uint_cmp.
proc; simplify.
wp; while (state = st /\ out = out_ /\ outlen = outlen_ /\
           good_ptr out_ rate8 /\ to_uint rate64 = Spec1600.rate64 /\
           0 <= to_uint i <= to_uint rate64 /\
           Glob.mem = stores64 mem (to_uint out_) (take (to_uint i)
                               (squeezestate64 st))).
 wp; skip; rewrite ultE => |> *.
 rewrite (to_uintS_lt _ _ H3); progress; first 2 smt().
 rewrite (take_nth W64.zero); first by rewrite size_squeezestate64 /#.
 rewrite stores64_rcons; congr.
  rewrite to_uintD_small to_uintM_small of_uintK modz_small // 1..3:/#.
  by rewrite size_take 1:/# size_squeezestate64 /#.
 rewrite /squeezestate64 nth_take 1,2:/# -get_to_list.
 by apply nth_inside; rewrite size_to_list /#.
wp; skip => |> *; progress.
+ by rewrite to_uint_shr of_uintK modz_small // /#.
+ by rewrite to_uint_shr of_uintK modz_small // /#.
+ by rewrite take0.
+ have ->: to_uint i0 = rate64.
   by move: H2; rewrite -W64.uleNgt uleE to_uint_shr /#.
  by rewrite take_take min_ler //.
+ by rewrite to_uintD_small H0.
+ by rewrite to_uintB ?uleE /#.
qed.

lemma xtr_full_block_spec_ll: islossless M.xtr_full_block.
proof.
islossless.
while true (to_uint rate64 - to_uint i).
 move=> ?; wp; skip; progress.
 move: H; rewrite ultE => ?.
 rewrite to_uintD_small of_uintK modz_small // 2:/#.
 by have /# := W64.to_uint_cmp rate64{hr}.
by skip; progress; rewrite ultE /#.
qed.

lemma xtr_full_block_spec mem st out_ outlen_:
 phoare [ M.xtr_full_block:
           Glob.mem = mem
           /\ state = st
           /\ out = out_
           /\ outlen = outlen_
           /\ rate8 <= to_uint outlen
           /\ to_uint rate = rate8
           /\ good_ptr out_ rate8
          ==>
           Glob.mem = stores64 mem (to_uint out_) (squeezestate64 st)
           /\ to_uint res.`1 = to_uint out_ + rate8
           /\ to_uint res.`2 = to_uint outlen_ - rate8
        ] = 1%r.
proof.
by conseq xtr_full_block_spec_ll (xtr_full_block_spec_h mem st out_ outlen_).
qed.


lemma xtr_bytes_spec_h mem st out_ outlen_:
  hoare [ M.xtr_bytes:
           Glob.mem = mem
           /\ state = st
           /\ out = out_
           /\ outlen = outlen_
           /\ to_uint outlen_ <= rate8
           /\ good_ptr out_ (to_uint outlen_)
          ==>
           Glob.mem = stores8 mem (to_uint out_) (take (to_uint outlen_)
                                                      (squeezestate st)) ].
proof.
have Rbnds:= rate64_bnds.
have Wbnds:= W64.to_uint_cmp.
proc; simplify.
while (#[2,-2:]pre /\ outlen_ = outlen /\ out_ = out /\
       to_uint outlen_ %/ 8 * 8 <= to_uint i <= to_uint outlen_ /\
       Glob.mem = stores8 mem (to_uint out_) (take (to_uint i)
                                                   (squeezestate st))).
 wp; skip; rewrite !ultE => |> *.
 rewrite (to_uintS_lt _ _ H3); progress; first 2 smt().
 rewrite (take_nth W8.zero) ?size_squeezestate 1:/#.
 rewrite stores8_rcons; congr.
  by rewrite to_uintD_small 1:/# size_take ?size_squeezestate /#.
  by rewrite state_get8P nth_take /#.
wp; while (#[2:]pre /\ 0 <= to_uint i <= to_uint outlen_ %/ 8 /\ out = out_ /\
           to_uint outlen8 = to_uint outlen %/ 8 /\
           Glob.mem = stores64 mem (to_uint out_) (take (to_uint i)
                                                        (squeezestate64 st))).
 wp; skip; rewrite !ultE => |> *.
 rewrite (to_uintS_lt _ _ H4).
 have ->: to_uint (out{hr} + W64.of_int 8 * i{hr})
          = to_uint out{hr} + 8 * to_uint i{hr}.
  by rewrite to_uintD_small to_uintM_small of_uintK modz_small //= /#.
 progress; first 2 smt().
 + rewrite (take_nth W64.zero) ?size_squeezestate64 1:/#.
   rewrite stores64_rcons; congr.
    by rewrite size_take ?size_squeezestate64 /#.
   rewrite nth_take 1,2:/# -Array25.get_to_list.
   by apply nth_inside; rewrite Array25.size_to_list /#.
wp; skip => |> *; progress.
+ smt().
+ by rewrite to_uint_shr of_uintK modz_small //.
+ by rewrite take0.
+ move: H1; rewrite ultE to_uint_shr of_uintK modz_small //= => ?.
  by rewrite to_uint_shl of_uintK modz_small //= /#.
+ by rewrite to_uint_shl of_uintK modz_small //= /#.
+ rewrite to_uint_shl of_uintK modz_small //= 1:/#.
  rewrite stores64_stores8; congr.
  have ->: to_uint i0 = to_uint outlen{hr} %/ 8.
   by move: H1; rewrite ultE to_uint_shr of_uintK //= /#.
  by rewrite squeezestateE (mulzC _ 8) take_w64L2w8L.
+ by move: H5; rewrite ultE //= /#.
qed.

lemma xtr_bytes_spec_ll: islossless M.xtr_bytes.
proof.
islossless.
 while true (to_uint outlen - to_uint i).
  move=> ?; wp; skip => ?; rewrite ultE; progress.
  rewrite to_uintD_small 2:/#.
  move: (W64.to_uint_cmp outlen{hr}); smt().
 by skip; progress; rewrite ultE /#.
while true (to_uint outlen8 - to_uint i).
  move=> ?; wp; skip => ?; rewrite ultE; progress.
  rewrite to_uintD_small 2:/#.
  move: (W64.to_uint_cmp outlen8{hr}); smt().
by skip; progress; rewrite ultE /#.
qed.

lemma xtr_bytes_spec mem st out_ outlen_:
 phoare [ M.xtr_bytes:
           Glob.mem = mem
           /\ state = st
           /\ out = out_
           /\ outlen = outlen_
           /\ to_uint outlen_ <= rate8
           /\ good_ptr out_ (to_uint outlen_)
          ==>
           Glob.mem = stores8 mem (to_uint out_) (take (to_uint outlen_)
                                                      (squeezestate st))
        ] = 1%r.
proof. by conseq xtr_bytes_spec_ll (xtr_bytes_spec_h mem st out_ outlen_). qed.


(* MAIN RESULT *)

section.

axiom permutation_instantiation mem st:
  phoare [ M.__keccakf1600_ref:
            state = st /\ Glob.mem = mem
           ==>
            Glob.mem = mem /\ res = sponge_permutation st ] = 1%r.

lemma spec_correct mem out_: 
equiv [ Spec.f ~ M.__keccak1600_ref :
         Glob.mem{2} = mem /\ inv_ptr in_0{2} inlen{2} s_out{2} s_outlen{2} /\
         m{1} = (memread mem (to_uint in_0) (to_uint inlen)){2} /\
         s_out{2} = out_ /\
         outlen{1} = W64.to_uint s_outlen{2} /\
         to_uint s_trail_byte{2} < 64 (* at most 6 bits... *) /\ 
         to_uint trail_byte{1} = to_uint s_trail_byte{2} /\
         to_uint rate{2} = rate8
       ==> 
         Glob.mem{2} = stores8 mem (W64.to_uint out_) res{1}
      ].
proof.
have Rbnds:= rate64_bnds.
have Wbnds:= W64.to_uint_cmp.
proc; simplify; wp.
ecall {2} (xtr_bytes_spec Glob.mem{2} state{2} out{2} outlen{2}); simplify.
wp; ecall {2} (permutation_instantiation Glob.mem{2} state{2}); simplify.
wp; while (st{1}=state{2} /\ to_uint rate{2}=rate8 /\
       to_uint s_out{2} = to_uint out_ + size result{1} /\       
       to_uint outlen{2} = to_uint s_outlen{2} /\
       outlen{1} = to_uint s_outlen{2} /\ good_ptr s_out{2} (to_uint s_outlen{2}) /\
       Glob.mem{2} = stores8 mem (to_uint out_) result{1}).
 wp; ecall {2} (xtr_full_block_spec Glob.mem{2} state{2} out{2} outlen{2}); simplify.
 wp; ecall {2} (permutation_instantiation Glob.mem{2} state{2}); simplify.
 wp; skip; rewrite !ultE; progress; first 2 smt().
 + by rewrite size_cat H8 H0 size_squeezestate /#.
 + smt().
 + smt().
 + by rewrite H0 stores8_cat stores64_stores8 -squeezestateE.
 + by rewrite !ultE /#.
 + by move: H10; rewrite ultE /#.
wp; ecall {2} (add_final_block_spec state{2} in_0{2} inlen{2} trail_byte{2}); simplify.
wp; while (st{1}=state{2} /\ to_uint rate{2} = rate8 /\ 
           m{1} = memread Glob.mem{2} (to_uint in_0{2}) (to_uint inlen{2}) /\
           good_ptr in_0{2} (to_uint inlen{2}) /\
           s_out{2} = out_ /\ outlen{1}=to_uint s_outlen{2} ).
 wp; ecall {2} (permutation_instantiation Glob.mem{2} state{2}); simplify.
 wp; ecall {2} (add_full_block_spec state{2} in_0{2} inlen{2} rate{2}); simplify.
 wp; skip; rewrite uleE; progress; first smt().
 + rewrite H5; congr; congr. 
   rewrite /absorb_split /= memread64E -w8L2w64L2state; congr. 
   by rewrite take_memread 1:/# min_lel /#.
 + rewrite /absorb_split /= drop_memread 1:/# H6 to_uintD_small ?H 1:/#.
   by rewrite H7 to_uintB ?uleE 1:/# H4.
 + by rewrite H6 H7 to_uintD_small 1:/# to_uintB ?uleE /#.
 + rewrite uleE H7 to_uintB ?uleE 1:/#.
   by move: H8; rewrite size_absorb_split2 size_mkseq /#.
 + move: H8; rewrite H7 uleE to_uintB ?uleE 1:/# => *.
   by rewrite size_absorb_split2 1:/# size_memread /#.
wp; call {2} st0_spec; wp; skip; rewrite /inv_ptr => |> *; progress.
+ move: H4; rewrite size_mkseq uleE /max.
  by case: (0 < to_uint inlen{2}); smt().
+ move: H4; rewrite uleE H3 => ?.
  by rewrite size_memread /#.
+ by move: H5; rewrite uleE /#.
+ rewrite /addfinalblock; congr; congr; congr; congr.
  by apply W8.word_modeqP; rewrite to_uint_truncateu8 modz_mod H2.
+ by rewrite ultE H6.
+ by move: H9; rewrite ultE H6.
+ by move: H10; rewrite ultE H11 /#.
+ by rewrite H12 -stores8_cat.
qed.

end section.


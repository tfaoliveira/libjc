require import List Int IntExtra IntDiv CoreMap.
from Jasmin require import JModel.

require import Array7 Array9 Array24 Array25.
require import Keccakf1600_savx2_openssl.
require import Keccakf1600_savx2.

equiv equiv_savx2_openssl_with_savx2 :
  Keccakf1600_savx2.M.__keccakf1600_avx2 ~
  Keccakf1600_savx2_openssl.M.__keccakf1600_avx2_openssl :
  ={Glob.mem}
    /\ arg{1}.`1.[0] = arg{2}.`1
    /\ arg{1}.`1.[1] = arg{2}.`2
    /\ arg{1}.`1.[2] = arg{2}.`3
    /\ arg{1}.`1.[3] = arg{2}.`4
    /\ arg{1}.`1.[4] = arg{2}.`5
    /\ arg{1}.`1.[5] = arg{2}.`6
    /\ arg{1}.`1.[6] = arg{2}.`7
    /\ ={_rhotates_left,_rhotates_right,_iotas}
  ==>
  ={Glob.mem}
    /\ res{1}.[0] = res{2}.`1
    /\ res{1}.[1] = res{2}.`2
    /\ res{1}.[2] = res{2}.`3
    /\ res{1}.[3] = res{2}.`4
    /\ res{1}.[4] = res{2}.`5
    /\ res{1}.[5] = res{2}.`6
    /\ res{1}.[6] = res{2}.`7.
proof.
  proc.
  simplify.
  (** -- pre -- loop : pointers setup **)
  seq 5 5 : (#pre /\ ={t,rhotates_left,rhotates_right,iotas} /\ r{1} = i{2}).
  + by wp; skip; simplify; trivial.
  (** -- 1st -- theta **)
  seq 24 24: (#pre /\ ={d14}).
  + by wp; skip; simplify; trivial.
  (** -- 1st -- rho + pi + pre-chi shuffle **)
  seq 27 27: (#pre).
  + by wp; skip; simplify; trivial.
  (** -- 1st -- chi **)
  seq 53 53: (#pre).
  +by wp; skip; simplify; trivial.
  (** -- 1st -- iotas + preparing while **)
  seq 3 3: (#pre /\ ={zf}).
  +by wp; skip; trivial.

  (** while loop **)
  while(#pre).
    (** theta **)
    seq 24 24: (#pre /\ ={d14}).
    + by wp; skip; simplify; trivial.
    (** rho + pi + pre-chi shuffle **)
    seq 27 27: (#pre).
    + by wp; skip; simplify; trivial.
    (** chi **)
    seq 53 53: (#pre).
    +by wp; skip; simplify; trivial.
    (** iotas **)
    seq 2 2: (#pre).
    +by wp.
    (** decrement i **)
    +by wp; auto => />.
    +by auto.
qed.

op flat_state (st : W256.t Array7.t) 
              (axx : W256.t * W256.t * W256.t * W256.t * W256.t * W256.t * W256.t ) =
    st.[0] = axx.`1 /\
    st.[1] = axx.`2 /\
    st.[2] = axx.`3 /\
    st.[3] = axx.`4 /\
    st.[4] = axx.`5 /\
    st.[5] = axx.`6 /\
    st.[6] = axx.`7.

equiv avx2_avx2_openssl :
  Keccakf1600_savx2_openssl.M.__keccakf1600_avx2_openssl ~ M.__keccakf1600_avx2 :
    ={Glob.mem,_rhotates_left,_rhotates_right, _iotas} /\ 
       flat_state state{2} (arg{1}.`1,arg{1}.`2,arg{1}.`3,arg{1}.`4,arg{1}.`5,arg{1}.`6,arg{1}.`7) ==> 
       ={Glob.mem} /\ flat_state res{2} res{1}.
   proc.
   seq 112 112 : (#pre /\ ={zf,iotas,rhotates_left,rhotates_right,t} /\ i{1} = r{2}).
   seq 30 30 : (#pre /\ ={d14,t,iotas,rhotates_left,rhotates_right} /\ i{1} = r{2}).
   by wp;skip; rewrite /flat_state; auto => />.
   seq 30 30 : #pre.
   by wp;skip; rewrite /flat_state; auto => />.
   seq 30 30 : #pre.
   by wp;skip; rewrite /flat_state; auto => />.
   by wp;skip; rewrite /flat_state; auto => />.
   while (#pre).
   seq 30 30 : (#pre /\ ={d14}).
   by wp;skip; rewrite /flat_state; auto => />.
   seq 30 30 : #pre.
   by wp;skip; rewrite /flat_state; auto => />.
   seq 30 30 : #pre.
   by wp;skip; rewrite /flat_state; auto => />.
   by wp;skip; rewrite /flat_state; auto => />.
   by auto => />.
qed.

require import Array4p Array25.
require Keccakf1600_pref_op.
require Keccakf1600_sref.
require Keccakf1600_pref_table.
require import Keccakf1600_pavx2_prevec.
require Keccakf1600_pavx2_prevec_vops.
require import Ops.

op em_states (state : W256.t Array7.t) (st : W64.t Array25.t) = 
  state = 
    Array7.of_list witness [pack4 [st.[index 0 0]; st.[index 0 0]; st.[index 0 0]; st.[index 0 0]];
                            pack4 [st.[index 0 1]; st.[index 0 2]; st.[index 0 3]; st.[index 0 4]];
                            pack4 [st.[index 2 0]; st.[index 4 0]; st.[index 1 0]; st.[index 3 0]];
                            pack4 [st.[index 3 1]; st.[index 1 2]; st.[index 4 3]; st.[index 2 4]];
                            pack4 [st.[index 2 1]; st.[index 4 2]; st.[index 1 3]; st.[index 3 4]];
                            pack4 [st.[index 4 1]; st.[index 3 2]; st.[index 2 3]; st.[index 1 4]];
                            pack4 [st.[index 1 1]; st.[index 2 2]; st.[index 3 3]; st.[index 4 4]]].

lemma avx2corr st mem : 
  equiv [ Keccakf1600_sref.M.__keccakf1600_ref ~ M.__keccakf1600_avx2  : 
         W64.to_uint _rhotates_left{2} + 192 < W64.modulus /\
         W64.to_uint _rhotates_right{2} + 192 < W64.modulus /\
         W64.to_uint _iotas{2} + 768 < W64.modulus /\ Glob.mem{2} = mem /\ 
         Keccakf1600_pavx2_prevec.good_io4x mem (W64.to_uint _iotas{2}) /\ 
         good_rhol mem (to_uint _rhotates_left{2}) /\ 
         good_rhor mem (to_uint _rhotates_right{2}) /\
         em_states  state{2} state{1} /\ st = state{1}  ==>   
            Glob.mem{2} = mem /\ em_states res{2} res{1}   ].
proof.

transitivity Keccakf1600_pref_table.Mreftable.__keccakf1600_ref
  (={Glob.mem, state} ==> ={Glob.mem, res})
  (W64.to_uint _rhotates_left{2} + 192 < W64.modulus /\
         W64.to_uint _rhotates_right{2} + 192 < W64.modulus /\
         W64.to_uint _iotas{2} + 768 < W64.modulus /\          Glob.mem{2} = mem /\ 
         Keccakf1600_pavx2_prevec.good_io4x mem (W64.to_uint _iotas{2}) /\ 
         good_rhol mem (to_uint _rhotates_left{2}) /\ 
         good_rhor mem (to_uint _rhotates_right{2}) /\
         em_states  state{2} state{1} /\ st = state{1} ==>   
            Glob.mem{2} = mem /\ em_states res{2} res{1}).
+ smt(). + done.
+ transitivity Keccakf1600_pref_op.Mrefop.__keccakf1600_ref
    (={Glob.mem, state} ==> ={Glob.mem, res})
    (={Glob.mem, state} ==> ={Glob.mem, res}) => //.
  + smt().
  + by apply Keccakf1600_pref_op.ref_refop.
  by conseq Keccakf1600_pref_table.ref_reftable.
transitivity Mavx2_prevec.__keccakf1600_avx2_openssl
           (to_uint _rhotates_left{2} + 192 < W64.modulus /\
            to_uint _rhotates_right{2} + 192 < W64.modulus /\
            to_uint _iotas{2} + 768 < W64.modulus /\
            Glob.mem{2} = mem /\
            good_io4x mem (to_uint _iotas{2}) /\
            good_rhol mem (to_uint _rhotates_left{2}) /\
            good_rhor mem (to_uint _rhotates_right{2}) /\
            equiv_states ((of_list witness [st.[index 0 0]; st.[index 0 0]; st.[index 0 0]; st.[index 0 0]]))%Array4
              ((of_list witness [st.[index 0 1]; st.[index 0 2]; st.[index 0 3]; st.[index 0 4]]))%Array4
              ((of_list witness [st.[index 2 0]; st.[index 4 0]; st.[index 1 0]; st.[index 3 0]]))%Array4
              ((of_list witness [st.[index 3 1]; st.[index 1 2]; st.[index 4 3]; st.[index 2 4]]))%Array4
              ((of_list witness [st.[index 2 1]; st.[index 4 2]; st.[index 1 3]; st.[index 3 4]]))%Array4
              ((of_list witness [st.[index 4 1]; st.[index 3 2]; st.[index 2 3]; st.[index 1 4]]))%Array4
              ((of_list witness [st.[index 1 1]; st.[index 2 2]; st.[index 3 3]; st.[index 4 4]]))%Array4 st /\
            a00{2} = (of_list witness [st.[index 0 0]; st.[index 0 0]; st.[index 0 0]; st.[index 0 0]])%Array4 /\
            a01{2} = (of_list witness [st.[index 0 1]; st.[index 0 2]; st.[index 0 3]; st.[index 0 4]])%Array4 /\
            a20{2} = (of_list witness [st.[index 2 0]; st.[index 4 0]; st.[index 1 0]; st.[index 3 0]])%Array4 /\
            a31{2} = (of_list witness [st.[index 3 1]; st.[index 1 2]; st.[index 4 3]; st.[index 2 4]])%Array4 /\
            a21{2} = (of_list witness [st.[index 2 1]; st.[index 4 2]; st.[index 1 3]; st.[index 3 4]])%Array4 /\
            a41{2} = (of_list witness [st.[index 4 1]; st.[index 3 2]; st.[index 2 3]; st.[index 1 4]])%Array4 /\
            a11{2} = (of_list witness [st.[index 1 1]; st.[index 2 2]; st.[index 3 3]; st.[index 4 4]])%Array4 /\
            state{1} = st 
            ==>
            Glob.mem{2} = mem /\
            equiv_states res{2}.`1 res{2}.`2 res{2}.`3 res{2}.`4 res{2}.`5 res{2}.`6 res{2}.`7 res{1})

        (W64.to_uint _rhotates_left{2} + 192 < W64.modulus /\
         W64.to_uint _rhotates_right{2} + 192 < W64.modulus /\
         W64.to_uint _iotas{2} + 768 < W64.modulus /\ ={Glob.mem, _rhotates_left, _rhotates_right, _iotas} /\
         Keccakf1600_pavx2_prevec.good_io4x mem (W64.to_uint _iotas{2}) /\ 
         good_rhol mem (to_uint _rhotates_left{2}) /\ 
         good_rhor mem (to_uint _rhotates_right{2}) /\
         state{2} = Array7.of_list witness [pack4 (Array4.to_list a00{1});
                                            pack4 (Array4.to_list a01{1});
                                            pack4 (Array4.to_list a20{1});
                                            pack4 (Array4.to_list a31{1});
                                            pack4 (Array4.to_list a21{1});
                                            pack4 (Array4.to_list a41{1});
                                            pack4 (Array4.to_list a11{1})] /\
         a00{1} = (of_list witness [st.[index 0 0]; st.[index 0 0]; st.[index 0 0]; st.[index 0 0]])%Array4 /\
         a01{1} = (of_list witness [st.[index 0 1]; st.[index 0 2]; st.[index 0 3]; st.[index 0 4]])%Array4 /\
         a20{1} = (of_list witness [st.[index 2 0]; st.[index 4 0]; st.[index 1 0]; st.[index 3 0]])%Array4 /\
         a31{1} = (of_list witness [st.[index 3 1]; st.[index 1 2]; st.[index 4 3]; st.[index 2 4]])%Array4 /\
         a21{1} = (of_list witness [st.[index 2 1]; st.[index 4 2]; st.[index 1 3]; st.[index 3 4]])%Array4 /\
         a41{1} = (of_list witness [st.[index 4 1]; st.[index 3 2]; st.[index 2 3]; st.[index 1 4]])%Array4 /\
         a11{1} = (of_list witness [st.[index 1 1]; st.[index 2 2]; st.[index 3 3]; st.[index 4 4]])%Array4 
         ==>   
            ={Glob.mem} /\ 
            let (a00, a01, a20, a31, a21, a41, a11) = res{1} in
            res{2} = 
              Array7.of_list witness [pack4 (Array4.to_list a00);
                                      pack4 (Array4.to_list a01);
                                      pack4 (Array4.to_list a20);
                                      pack4 (Array4.to_list a31);
                                      pack4 (Array4.to_list a21);
                                      pack4 (Array4.to_list a41);
                                      pack4 (Array4.to_list a11)]).
+ move=> &1 &2 [#] ??? <<- ???.
  rewrite /em_states => h1 <<-.
  rewrite h1.
  exists Glob.mem{2}.
  by exists (Array4.of_list witness [st.[index 0 0]; st.[index 0 0]; st.[index 0 0]; st.[index 0 0]],
          Array4.of_list witness [st.[index 0 1]; st.[index 0 2]; st.[index 0 3]; st.[index 0 4]],
          Array4.of_list witness [st.[index 2 0]; st.[index 4 0]; st.[index 1 0]; st.[index 3 0]],
          Array4.of_list witness [st.[index 3 1]; st.[index 1 2]; st.[index 4 3]; st.[index 2 4]],
          Array4.of_list witness [st.[index 2 1]; st.[index 4 2]; st.[index 1 3]; st.[index 3 4]],
          Array4.of_list witness [st.[index 4 1]; st.[index 3 2]; st.[index 2 3]; st.[index 1 4]],
          Array4.of_list witness [st.[index 1 1]; st.[index 2 2]; st.[index 3 3]; st.[index 4 4]],
          _rhotates_left{2}, _rhotates_right{2}, _iotas{2}) => />.
+ move=> &1 &m &2 />.
  case: ( res{m} ) => a00 a01 a20 a31 a21 a41 a11 /=.
  rewrite /to_list /em_states /= /mkseq /=.
  by move=> 29! ->.
+ apply (Keccakf1600_pavx2_prevec.correct_perm 
           (Array4.of_list witness [st.[index 0 0]; st.[index 0 0]; st.[index 0 0]; st.[index 0 0]])
           (Array4.of_list witness [st.[index 0 1]; st.[index 0 2]; st.[index 0 3]; st.[index 0 4]])
           (Array4.of_list witness [st.[index 2 0]; st.[index 4 0]; st.[index 1 0]; st.[index 3 0]])
           (Array4.of_list witness [st.[index 3 1]; st.[index 1 2]; st.[index 4 3]; st.[index 2 4]])
           (Array4.of_list witness [st.[index 2 1]; st.[index 4 2]; st.[index 1 3]; st.[index 3 4]])
           (Array4.of_list witness [st.[index 4 1]; st.[index 3 2]; st.[index 2 3]; st.[index 1 4]])
           (Array4.of_list witness [st.[index 1 1]; st.[index 2 2]; st.[index 3 3]; st.[index 4 4]])
           st mem).

transitivity Keccakf1600_pavx2_prevec_vops.Mavx2_prevec_vops.__keccakf1600_avx2_openssl 
   (={Glob.mem} /\ Keccakf1600_pavx2_prevec_vops.match_ins arg{1} arg{2}==>
    ={Glob.mem} /\ Keccakf1600_pavx2_prevec_vops.match_states res{1} res{2})
   
( to_uint _rhotates_left{2} + 192 < W64.modulus /\
  to_uint _rhotates_right{2} + 192 < W64.modulus /\
  to_uint _iotas{2} + 768 < W64.modulus /\
  ={Glob.mem, _rhotates_left, _rhotates_right, _iotas} /\
  good_io4x mem (to_uint _iotas{2}) /\
  good_rhol mem (to_uint _rhotates_left{2}) /\
  good_rhor mem (to_uint _rhotates_right{2}) /\
  state{2} = 
    Array7.of_list witness [arg.`1; arg.`2; arg.`3; arg.`4; arg.`5; arg.`6; arg.`7]{1} ==>
  ={Glob.mem} /\
  res{2} =  Array7.of_list witness [res.`1; res.`2; res.`3; res.`4; res.`5; res.`6; res.`7]{1}).
+ move=> /> *.
  exists Glob.mem{2}.
  exists (pack4 [st.[index 0 0]; st.[index 0 0]; st.[index 0 0]; st.[index 0 0]],
          pack4 [st.[index 0 1]; st.[index 0 2]; st.[index 0 3]; st.[index 0 4]],
          pack4 [st.[index 2 0]; st.[index 4 0]; st.[index 1 0]; st.[index 3 0]],
          pack4 [st.[index 3 1]; st.[index 1 2]; st.[index 4 3]; st.[index 2 4]],
          pack4 [st.[index 2 1]; st.[index 4 2]; st.[index 1 3]; st.[index 3 4]],
          pack4 [st.[index 4 1]; st.[index 3 2]; st.[index 2 3]; st.[index 1 4]],
          pack4 [st.[index 1 1]; st.[index 2 2]; st.[index 3 3]; st.[index 4 4]],
          _rhotates_left{2}, _rhotates_right{2}, _iotas{2}) => />.
  by rewrite H8 H9 H10 H11 H12 H13 H14 H15 /is4u64=> />.
+ move=> &1 &m &2 /= [#] ->.
  rewrite /Keccakf1600_pavx2_prevec_vops.match_states /is4u64 => [#].
  by case: (res{1}) => a00 a01 a20 a31 a21 a41 a11 /= 7!-> [#] -> ->.
+ by apply Keccakf1600_pavx2_prevec_vops.prevec_vops_prevec.   
transitivity Keccakf1600_savx2_openssl.M.__keccakf1600_avx2_openssl 
  (={Glob.mem, arg} ==> ={Glob.mem, res}) 
    ( to_uint _rhotates_left{2} + 192 < W64.modulus /\
    to_uint _rhotates_right{2} + 192 < W64.modulus /\
    to_uint _iotas{2} + 768 < W64.modulus /\
    ={Glob.mem,_rhotates_left, _rhotates_right, _iotas} /\
    good_io4x mem (to_uint _iotas{2}) /\
    good_rhol mem (to_uint _rhotates_left{2}) /\
    good_rhor mem (to_uint _rhotates_right{2}) /\
    state{2} = (of_list witness [a00{1}; a01{1}; a20{1}; a31{1}; a21{1}; a41{1}; a11{1}])%Array7 ==>
  ={Glob.mem} /\
  res{2} = (of_list witness [res{1}.`1; res{1}.`2; res{1}.`3; res{1}.`4; res{1}.`5; res{1}.`6; res{1}.`7])%Array7). 
+ smt(). + done.
+ apply Keccakf1600_pavx2_prevec_vops.prevec_vops_openssl.
conseq avx2_avx2_openssl.
(**conseq equiv_savx2_openssl_with_savx2.**)
+ by move => /> *; rewrite H8 /=.
move=> /> &1 &2 ?????????? [/=] /> *.
by apply Array7.all_eq_eq;cbv delta.
qed.

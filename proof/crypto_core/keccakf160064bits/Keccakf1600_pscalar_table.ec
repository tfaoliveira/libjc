require import List Int IntExtra IntDiv CoreMap.
from Jasmin require import JModel.

require import Array5 Array24 Array25.
require import WArray40 WArray200.

require import Keccakf1600_pref_table.
require import Keccakf1600_pref_loop2.
require import Keccakf1600_sscalar.
require import Keccakf1600_pref_op.

module Mscalarrho = {
  include M [-keccak_rho_offsets,rhotates,rol_sum,round2x,__keccakf1600_scalar]
  include RhotatesAlgo
  
  proc rhotates (x:int, y:int) : int = {
    
    var r:int;
    var i:int;
    
    i <@ index (x, y);
    r <@ keccakRhoOffsets (i);
    return (r);
  }
  
 proc rol_sum (_D:W64.t Array5.t, _A:W64.t Array25.t, offset:int) : W64.t Array5.t = {
    var aux: int;
    
    var _C:W64.t Array5.t;
    var j:int;
    var j1:int;
    var k:int;
    var t:W64.t;
    _C <- witness;
    j <- 0;
    while (j < 5) {
      j1 <- ((j + offset) %% 5);
      k <@ rhotates (j, j1);
      t <- _A.[((5 * (j %% 5)) + (j1 %% 5))];
      t <- (t `^` _D.[j1]);
      t <@ rOL64 (t, k);
      _C.[j] <- t;
      j <- j + 1;
    }
    return (_C);
  }
  
  
  proc round2x (_A:W64.t Array25.t, _R:W64.t Array25.t, iotas:W64.t, o:int) : 
  W64.t Array25.t * W64.t Array25.t = {
    
    var iota_0:W64.t;
    var _C:W64.t Array5.t;
    var _D:W64.t Array5.t;
    _C <- witness;
    _D <- witness;
    iota_0 <- (loadW64 Glob.mem (W64.to_uint (iotas + (W64.of_int o))));
    _C <@ theta_sum (_A);
    _D <@ theta_rol (_C);
    _C <@ rol_sum (_D, _A, 0);
    _R <@ set_row (_R, 0, _C, iota_0);
    _C <@ rol_sum (_D, _A, 3);
    _R <@ set_row (_R, 1, _C, iota_0);
    _C <@ rol_sum (_D, _A, 1);
    _R <@ set_row (_R, 2, _C, iota_0);
    _C <@ rol_sum (_D, _A, 4);
    _R <@ set_row (_R, 3, _C, iota_0);
    _C <@ rol_sum (_D, _A, 2);
    _R <@ set_row (_R, 4, _C, iota_0);
    return (_A, _R);
  }
  
  proc keccak_f (_A:W64.t Array25.t, iotas:W64.t) : W64.t Array25.t * W64.t = {
    
    var zf:bool;
    var _R:W64.t Array25.t;
    var  _0:bool;
    var  _1:bool;
    var  _2:bool;
    var  _3:bool;
    _R <- witness;
    (_A, _R) <@ round2x (_A, _R, iotas, 0);
    (_R, _A) <@ round2x (_R, _A, iotas, 8);
    iotas <- (iotas + (W64.of_int 16));
    ( _0,  _1,  _2,  _3, zf) <- TEST_8 (truncateu8 iotas)
    (W8.of_int 255);
    while ((! zf)) {
      (_A, _R) <@ round2x (_A, _R, iotas, 0);
      (_R, _A) <@ round2x (_R, _A, iotas, 8);
      iotas <- (iotas + (W64.of_int 16));
      ( _0,  _1,  _2,  _3, zf) <- TEST_8 (truncateu8 iotas)
      (W8.of_int 255);
    }
    iotas <- (iotas - (W64.of_int 192));
    return (_A, iotas);
  }
}.

equiv scalarrhom : 
  M.__keccakf1600_scalar ~ Mscalarrho.keccak_f :
   ={Glob.mem,arg} ==> ={Glob.mem,res} by sim.

module Mscalartable = {
  include M [-keccak_rho_offsets,rhotates,rol_sum,round2x,__keccakf1600_scalar]
  include RhotatesTable
  
  proc rhotates (x:int, y:int) : int = {
    
    var r:int;
    var i:int;
    
    i <@ index (x, y);
    r <@ keccakRhoOffsets (i);
    return (r);
  }
  
 proc rol_sum (_D:W64.t Array5.t, _A:W64.t Array25.t, offset:int) : W64.t Array5.t = {
    var aux: int;
    
    var _C:W64.t Array5.t;
    var j:int;
    var j1:int;
    var k:int;
    var t:W64.t;
    _C <- witness;
    j <- 0;
    while (j < 5) {
      j1 <- ((j + offset) %% 5);
      k <@ rhotates (j, j1);
      t <- _A.[((5 * (j %% 5)) + (j1 %% 5))];
      t <- (t `^` _D.[j1]);
      t <@ rOL64 (t, k);
      _C.[j] <- t;
      j <- j + 1;
    }
    return (_C);
  }
  
  
  proc round2x (_A:W64.t Array25.t, _R:W64.t Array25.t, iotas:W64.t, o:int) : 
  W64.t Array25.t * W64.t Array25.t = {
    
    var iota_0:W64.t;
    var _C:W64.t Array5.t;
    var _D:W64.t Array5.t;
    _C <- witness;
    _D <- witness;
    iota_0 <- (loadW64 Glob.mem (W64.to_uint (iotas + (W64.of_int o))));
    _C <@ theta_sum (_A);
    _D <@ theta_rol (_C);
    _C <@ rol_sum (_D, _A, 0);
    _R <@ set_row (_R, 0, _C, iota_0);
    _C <@ rol_sum (_D, _A, 3);
    _R <@ set_row (_R, 1, _C, iota_0);
    _C <@ rol_sum (_D, _A, 1);
    _R <@ set_row (_R, 2, _C, iota_0);
    _C <@ rol_sum (_D, _A, 4);
    _R <@ set_row (_R, 3, _C, iota_0);
    _C <@ rol_sum (_D, _A, 2);
    _R <@ set_row (_R, 4, _C, iota_0);
    return (_A, _R);
  }
  
  proc keccak_f (_A:W64.t Array25.t, iotas:W64.t) : W64.t Array25.t * W64.t = {
    
    var zf:bool;
    var _R:W64.t Array25.t;
    var  _0:bool;
    var  _1:bool;
    var  _2:bool;
    var  _3:bool;
    _R <- witness;
    (_A, _R) <@ round2x (_A, _R, iotas, 0);
    (_R, _A) <@ round2x (_R, _A, iotas, 8);
    iotas <- (iotas + (W64.of_int 16));
    ( _0,  _1,  _2,  _3, zf) <- TEST_8 (truncateu8 iotas)
    (W8.of_int 255);
    while ((! zf)) {
      (_A, _R) <@ round2x (_A, _R, iotas, 0);
      (_R, _A) <@ round2x (_R, _A, iotas, 8);
      iotas <- (iotas + (W64.of_int 16));
      ( _0,  _1,  _2,  _3, zf) <- TEST_8 (truncateu8 iotas)
      (W8.of_int 255);
    }
    iotas <- (iotas - (W64.of_int 192));
    return (_A, iotas);
  }
}.

equiv rol_sum : 
  Mscalarrho.rol_sum ~ Mscalartable.rol_sum :
   ={arg} /\ 0 <= offset{1} < 5 ==> ={res}.
proc.
while (={j,_C,_A,_D,offset} /\ 0 <= j{1} <= 5 /\ 0 <= offset{1} < 5).
wp.
call (_:true); first by sim.
inline Mscalartable.rhotates Mscalarrho.rhotates.
wp.
call(rhotates_table_corr).
call (_: ={arg} /\ 0 <= x{1} < 5 /\ 0<=y{1} <5 ==> ={res} /\ 0<= res{1} <25).
proc. by auto => />;smt().
by auto => />; smt().
by auto => />; smt().
qed.


equiv round2x : 
  Mscalarrho.round2x ~ Mscalartable.round2x :
   ={Glob.mem,arg} ==> ={Glob.mem,res}.
proc.
do 5! (call (_:true); [by sim | call rol_sum]).
do 2! (call (_:true); first by sim).
by auto => />.
qed.

equiv scalartable : 
  Mscalarrho.keccak_f ~ Mscalartable.keccak_f :
   ={Glob.mem,arg} ==> ={Glob.mem,res}.
proc.
wp.
while (={Glob.mem,zf,_A,_R,iotas}).
+ by wp; do 2! call round2x; auto.
by wp; do 2! call round2x; auto.
qed.

op good_iotas (mem : global_mem_t, _iotas : int) =
    forall off, 0 <= off < 24 => 
      loadW64 mem (_iotas + (off * 8)) = iotas.[off].

lemma testsem : (forall (x : W64.t), (TEST_8 (truncateu8 x) (W8.of_int 255)).`5 <=> (W64.to_uint x %% 256 = 0)).
move => *.
rewrite /TEST_8 /rflags_of_bwop8 /truncateu8 /ZF_of_w8 /=.
have -> : W8.of_int 255 = W8.onew by rewrite oneE.
rewrite W8.andw1; split => h.
+ by rewrite (_ : 0 = to_uint W8.zero) 1:// -h W8.of_uintK.
by apply W8.to_uintRL; rewrite -h W8.of_uintK.
qed.

lemma rol0 : (forall x , (ROL_64 x (W8.of_int (rhotates 0))).`3 = x).
move => *.
rewrite ROL_64_E /rhotates rol_xor =>/>.
exact/Ops.lsr_0.
qed.

lemma rol00 : (forall x , (ROL_64 x (W8.zero)).`3 = x).
move => *.
rewrite ROL_64_E /rhotates rol_xor =>/>. 
exact/Ops.lsr_0.
qed.

lemma scalarcorr _iotas mem : 
  equiv [ Mrefloop2.__keccakf1600_ref ~ Mscalartable.keccak_f : 
        0 <= _iotas < W64.modulus - 24 * 8 /\
        good_iotas mem _iotas /\ (_iotas - 8*8) %% 256 = 0 /\ 
            mem = Glob.mem{2} /\ to_uint iotas{2} = _iotas /\
               state{1} = _A{2} ==> mem = Glob.mem{2} /\ to_uint res{2}.`2 = _iotas /\
               res{1} = res{2}.`1 ].
proc.
seq 2 1 : (#pre /\ constants{1} = iotas); first by inline *;auto => />.

seq 1 0 : (#{/~iotas{2}}pre /\ 
          _iotas = to_uint iotas{2} - round{1} * 8 /\ 
          round{1} = 0 /\
          state{1} = _A{2}); first by auto => />.

seq 4 3: (#{/~round{1} = 0}pre /\ round{1} = 2).

inline Mreftable.keccakP1600_round Mscalartable.round2x.

swap {2}[5..6] -4. seq 0 2 : #pre; first by auto => />.

swap {1} 2 -1.
swap {2} [3..5] -2.

seq 1 3 : (#pre /\ iota_0{2} = c{1}).
inline *;wp;skip; rewrite /good_iotas /iotas; auto => />.
move => &2 bound1 bound2 Tass. 
progress.
by  move : (Tass 0) => //=.

sp. 
inline Mreftable.theta.
seq 7 2 : (#pre /\ a{1}=state0{1} /\ d{1} = _D{2}).
inline *.
sp 3 2.
seq 2 6 : (#{/~c1{1}}{~c{2}}pre /\ c1{1} = c0{2}).
do 6!(unroll for {1} ^while).
do 6!(unroll for {2} ^while).
auto => />.
progress.
apply (Array5.ext_eq).
move => *.
case (x = 0); first by auto => />;smt( @W64).
case (x = 1); first by auto => />;smt( @W64).
case (x = 2); first by auto => />;smt( @W64).
case (x = 3); first by auto => />;smt( @W64).
case (x = 4); first by auto => />;smt( @W64).
smt().

sp 0 1;wp.

unroll for {1} 2.
unroll for {2} 2.
by auto => />.

seq 8 11 : (#{/~state{1}}{~state0{1}}{~_A0{2}}{~_R0{2}}pre /\ state{1} = _R{2}).
inline *.
do 30!(unroll for {1} ^while).
do 10!(unroll for {2} ^while).

do !((rcondt {2} ^if; first by move => *; wp;skip;auto => />) ||
    (rcondf {2} ^if; first by move => *; wp;skip;auto => />)).

wp;skip.
move => &1 &2 /> h1 h2 h3 h4.
apply Array25.all_eq_eq; cbv delta.
smt(rol0 rol00 @W64).

(* Second round *)

swap {2}[5..6] -4. seq 0 2 : #pre; first by auto => />.

swap {1} 3 -1.
swap {2} [3..5] -2.

seq 2 3 : (#{/~round{1}}pre /\
               round{1} = 1 /\
              (round{1} - 1) * 8 + _iotas = to_uint iotas{2}
             /\ iota_00{2} = c0{1}).

inline *;wp;skip; rewrite /good_iotas /iotas; auto => />.
move => &2 bound1 bound2 Tass.
move : (Tass 1) => //=.
rewrite (_ : to_uint (iotas{2} + (of_int 8)%W64) = to_uint iotas{2} + 8). rewrite to_uintD. smt(@W64). by trivial.

seq 8 4 : (#pre /\ a0{1}=state{1} /\ d0{1} = _D0{2} /\ _A1{2} = a0{1}).
inline *; sp 4 4.
seq 2 6 : (#{/~c2{1}}{~c{2}}pre /\ c2{1} = c0{2}).
do 6!(unroll for {1} ^while).
do 6!(unroll for {2} ^while).
auto => /> &2 ????.
by apply Array5.all_eq_eq; cbv delta.

sp 0 1;wp.

unroll for {1} 2.
unroll for {2} 2.
by auto => />.

seq 8 11 : (#{/~state{1}}{~_A1{2}}pre /\ state{1} = _A{2}).
inline *.
do 30!(unroll for {1} ^while).
do 10!(unroll for {2} ^while).

do !((rcondt {2} ^if; first by move => *; wp;skip;auto => />) ||
    (rcondf {2} ^if; first by move => *; wp;skip;auto => />)).

wp;skip => />.
move => &1 &2 /> h1 h2 h3 h4.
apply Array25.all_eq_eq; cbv delta.
smt(rol0 rol00 @W64).

auto => />.
rewrite to_uintD.
by smt(@W64).

(* Main loop *)

seq 0 1 : (#{/~round{1} = 2}pre /\ 0 < round{1} <= 24 /\ round{1} %% 2 = 0 /\
           zf{2} = (TEST_8 (truncateu8 iotas{2}) ((of_int 255))%W8).`5); first by auto => />.
wp.
while (#pre).
wp.

inline Mreftable.keccakP1600_round Mscalartable.round2x.

swap {2}[5..6] -4. seq 0 2 : #pre; first by auto => />.

swap {1} 2 -1.
swap {2} [3..5] -2.

seq 1 3 : (#pre /\ iota_0{2} = c{1}).
inline *;wp;skip; rewrite /good_iotas /iotas; auto => />.
move => &1 &2 bound1 bound2 Tass. 
progress.
move : (Tass round{1}) => //=.
rewrite (_:  to_uint iotas{2} - round{1} * 8 + round{1} * 8 = to_uint iotas{2}); first by ring.
smt().

inline Mreftable.theta.
seq 8 4 : (#pre /\ a{1}=state0{1} /\ state0{1} = state{1} /\ d{1} = _D{2}  /\ _A0{2} = _A{2}).
inline *.
sp 3 2.
seq 3 8 : (#{/~c1{1}}{~c{2}}pre /\ c1{1} = c0{2}).
do 6!(unroll for {1} ^while).
do 6!(unroll for {2} ^while).
auto => />.
progress.
apply (Array5.ext_eq).
move => *.
case (x1 = 0); first by auto => />;smt( @W64).
case (x1 = 1); first by auto => />;smt( @W64).
case (x1 = 2); first by auto => />;smt( @W64).
case (x1 = 3); first by auto => />;smt( @W64).
case (x1 = 4); first by auto => />;smt( @W64).
smt().

sp 0 1;wp.

unroll for {1} 2.
unroll for {2} 2.
auto => />.
move => *.
apply Array5.ext_eq. 
move => *.
case (x1 = 0); first by auto => />;smt( @W64).
case (x1 = 1); first by auto => />;smt( @W64).
case (x1 = 2); first by auto => />;smt( @W64).
case (x1 = 3); first by auto => />;smt( @W64).
case (x1 = 4); first by auto => />;smt( @W64).
smt().

seq 8 11 : (#{/~state{1}}{~state0{1}}{~_A0{2}}{~_R0{2}}pre /\ state{1} = _R{2}).
inline *.
do 30!(unroll for {1} ^while).
do 10!(unroll for {2} ^while).

do !((rcondt {2} ^if; first by move => *; wp;skip;auto => />) ||
    (rcondf {2} ^if; first by move => *; wp;skip;auto => />)).
wp;skip; move => &1 &2 /> h1 h2 h3 h4 ?????;
apply Array25.all_eq_eq; cbv delta.
smt(rol0 rol00 @W64).

(* Second round *)

swap {2}[5..6] -4. seq 0 2 : #pre; first by auto => />.
swap {1} 2 -1.
swap {2} [3..5] -2.

seq 1 3 : (#pre /\ iota_00{2} = c0{1}).
inline *;wp;skip; rewrite /good_iotas /iotas; auto => />.
move => &1 &2 bound1 bound2 Tass. 
progress.
move : (Tass (round{1} + 1)) => //=.
rewrite (_:  to_uint iotas{2} - round{1} * 8 + (round{1} + 1) * 8 = to_uint (iotas{2} + (of_int 8)%W64)).
rewrite to_uintD.
have bb : (to_uint iotas{2} + to_uint ((of_int 8))%W64 < W64.modulus).
smt().
smt(@W64).
smt().

seq 8 4 : (#pre /\ a0{1}=state{1} /\ d0{1} = _D0{2} /\ _A1{2} = a0{1}).
inline *; sp 4 4.
seq 2 6 : (#{/~c2{1}}{~c{2}}pre /\ c2{1} = c0{2}).
do 6!(unroll for {1} ^while).
do 6!(unroll for {2} ^while).
auto => />.
progress.
apply (Array5.ext_eq).
move => *.
case (x1 = 0); first by auto => />;smt( @W64).
case (x1 = 1); first by auto => />;smt( @W64).
case (x1 = 2); first by auto => />;smt( @W64).
case (x1 = 3); first by auto => />;smt( @W64).
case (x1 = 4); first by auto => />;smt( @W64).
smt().

sp 0 1;wp.

unroll for {1} 2.
unroll for {2} 2.
by auto => />.

seq 8 11 : (#{/~state{1}}{~_A1{2}}pre /\ state{1} = _A{2}).
inline *.
do 30!(unroll for {1} ^while).
do 10!(unroll for {2} ^while).

do !((rcondt {2} ^if; first by move => *; wp;skip;auto => />) ||
    (rcondf {2} ^if; first by move => *; wp;skip;auto => />)).
wp;skip; move => &1 &2 /> h1 h2 h3 h4 ?????;
apply Array25.all_eq_eq; cbv delta.
smt(rol0 rol00 @W64).

auto => />.

progress.
rewrite to_uintD;smt(). 
smt(). smt(). smt(). 
rewrite (testsem (iotas{2} + (of_int 16)%W64)). 
rewrite to_uintD.  
rewrite (_ : (to_uint iotas{2} + to_uint ((of_int 16))%W64) %% W64.modulus %% 256 = (to_uint iotas{2} + to_uint ((of_int 16))%W64)  %% 256). smt(@W64). smt(). 

move : H8.
rewrite testsem.
rewrite to_uintD. 
rewrite (_ : (to_uint iotas{2} + to_uint ((of_int 16))%W64) %% W64.modulus %% 256 = (to_uint iotas{2} + to_uint ((of_int 16))%W64)  %% 256). smt(@W64). smt().

auto => />.
progress.
rewrite (testsem (iotas{2}));smt(). 
move : H6.
rewrite testsem;smt().

move : H12.
rewrite testsem => //= *.
move : H8; rewrite (_ : round_L = 24); first by smt().
move => *.
have ir : (to_uint iotas{2} - round{1} * 8 + 24*8) %% 256 = 0. smt().
rewrite (_ : iotas_R = W64.of_int (to_uint iotas{2} - round{1} * 8 + 24*8)).
smt(@W64).
smt(@W64 @W8).
qed.

require Keccakf1600_pref_op.
require Keccakf1600_sref.

lemma scalarcorr_op _iotas mem : 
  equiv [ Keccakf1600_sref.M.__keccakf1600_ref ~ Keccakf1600_sscalar.M.__keccakf1600_scalar  : 
        0 <= _iotas < W64.modulus - 24 * 8 /\
        good_iotas mem _iotas /\ (_iotas - 8*8) %% 256 = 0 /\ ={Glob.mem} /\
            mem = Glob.mem{2} /\ to_uint iotas{2} = _iotas /\
               state{1} = a{2} ==> mem = Glob.mem{2} /\ to_uint res{2}.`2 = _iotas /\
               res{1} = res{2}.`1 ].
proof.
transitivity Mrefloop2.__keccakf1600_ref
  (={state, Glob.mem} ==> ={res, Glob.mem})
  ( 0 <= _iotas < W64.modulus - 24 * 8 /\
     good_iotas mem _iotas /\
     (_iotas - 8 * 8) %% 256 = 0 /\ ={Glob.mem} /\ mem = Glob.mem{2} /\ to_uint iotas{2} = _iotas /\ state{1} = a{2} 
    ==>
     mem = Glob.mem{2} /\ to_uint res{2}.`2 = _iotas /\ res{1} = res{2}.`1) => //. 
+ smt().
+ transitivity Mrefop.__keccakf1600_ref
    ( ={Glob.mem, state} ==> ={Glob.mem, res})
    (={state, Glob.mem} ==> ={res, Glob.mem}) => //.
  + smt(). + by apply Keccakf1600_pref_op.ref_refop.
  transitivity Mreftable.__keccakf1600_ref
    ( ={state, Glob.mem} ==> ={res, Glob.mem})
    ( ={state, Glob.mem} ==> ={res, Glob.mem}) => //.
  + smt(). + by apply Keccakf1600_pref_table.ref_reftable.
  transitivity Mrefloop.__keccakf1600_ref
    ( ={state, Glob.mem} ==> ={res, Glob.mem})
    ( ={state, Glob.mem} ==> ={res, Glob.mem}) => //.
  + smt(). + by apply reftable_refloop.
  transitivity Mrefloopk.__keccakf1600_ref
    ( ={state, Glob.mem} ==> ={res, Glob.mem})
    ( ={state, Glob.mem} ==> ={res, Glob.mem}) => //.
  + smt(). + by apply refloop_refloopk.
  by apply refloopk_refloop2 => *.  
transitivity Mscalartable.keccak_f
  ( 0 <= _iotas < W64.modulus - 24 * 8 /\
    good_iotas mem _iotas /\
    (_iotas - 8 * 8) %% 256 = 0 /\ mem = Glob.mem{2} /\ to_uint iotas{2} = _iotas /\ state{1} = _A{2} 
    ==>
    mem = Glob.mem{2} /\ to_uint res{2}.`2 = _iotas /\ res{1} = res{2}.`1)
  ( ={Glob.mem, arg} ==> ={Glob.mem, res}) => //.
+ smt (). + by apply (scalarcorr _iotas mem).
symmetry.
transitivity Mscalarrho.keccak_f
  ( ={Glob.mem, arg} ==> ={Glob.mem, res})
  ( ={Glob.mem, arg} ==> ={Glob.mem, res}) => //.
+ smt(). + by apply scalarrhom.
by apply scalartable.
qed.

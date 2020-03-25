require import Bool List Int IntExtra IntDiv CoreMap Real Zp.
from Jasmin require import JModel.
require import Curve25519_Spec.
require import Curve25519_Hop1.
import Zp ZModpRing Curve25519_Spec Curve25519_Hop1.

module MHop2 = {

  (* h = f + g *)
  proc add(f g : zp) : zp = 
  {
    var h: zp;
    h <- f + g;
    return h;
  }

  (* h = f - g *)
  proc sub(f g : zp) : zp =
  {
    var h: zp;
    h <- f - g;
    return h;
  }

  (* h = f * a24 *)  
  proc mul_a24 (f : zp, a24 : int) : zp =
  {
    var h: zp;
    h <- f * (inzp a24);
    return h;
  }

  (* h = f * g *)
  proc mul (f g : zp) : zp =
  {
    var h : zp;
    h <- f * g;
    return h;
  }

  (* h = f * f *)
  proc sqr (f : zp) : zp =
  {
    var h : zp;
    (*h <- f * f;*)
    h <- exp f 2;
    return h;
  }

  (* iterated sqr *)
  proc it_sqr (i : int, f : zp) : zp =
  {
    var h : zp;
    h <- witness;

    h <@ sqr(f);
    i <- i - 1;
    f <@ sqr(h);
    i <- i - 1;

    while (0 < i) {
      h <@ sqr(f);
      i <- i - 1;
      f <@ sqr(h);
      i <- i - 1;
    }

    return f;
  }

  (* f ** 2**255-19-2 *)
  proc invert (z1' : zp) : zp =
  {
    var t0 : zp;
    var t1 : zp;
    var t2 : zp;
    var t3 : zp;

    t0 <- witness;
    t1 <- witness;
    t2 <- witness;
    t3 <- witness;

    t0 <@ sqr (z1');
    t1 <@ sqr (t0);
    t1 <@ sqr (t1);
    t1 <@ mul (z1', t1);
    t0 <@ mul (t0,  t1);
    t2 <@ sqr (t0);
    t1 <@ mul (t1, t2);
    t2 <@ sqr (t1);
    t2 <@ it_sqr (4, t2);
    t1 <@ mul (t1, t2);
    t2 <@ it_sqr (10, t1);
    t2 <@ mul (t1, t2);
    t3 <@ it_sqr (20, t2);
    t2 <@ mul (t2, t3);
    t2 <@ it_sqr (10, t2);
    t1 <@ mul (t1, t2);
    t2 <@ it_sqr (50, t1);
    t2 <@ mul (t1, t2);
    t3 <@ it_sqr (100, t2);
    t2 <@ mul (t2, t3);
    t2 <@ it_sqr (50, t2);
    t1 <@ mul (t1, t2);
    t1 <@ it_sqr (4, t1);
    t1 <@ sqr (t1);
    t1 <@ mul (t0, t1);
    return t1;
  }
  
  proc cswap (x2 z2 x3 z3 : zp, toswap : bool) : zp * zp * zp * zp =
  {
    if(toswap)
    { (x2,z2,x3,z3) = (x3,z3,x2,z2); }
    else
    { (x2,z2,x3,z3) = (x2,z2,x3,z3); }
    return (x2,z2,x3,z3);
  }

  proc ith_bit (k' : W256.t, ctr : int) : bool =
  {
    return k'.[ctr];
  }

  proc decode_scalar_25519 (k' : W256.t) : W256.t =
  {
    k'.[0] <- false;
    k'.[1] <- false;
    k'.[2] <- false;
    k'.[255] <- false;
    k'.[254] <- true;
    return k';
  }

  proc decode_u_coordinate (u' : W256.t) : zp =
  {
    var u'' : zp;
    (* last bit of u is cleared but that can be introduced at the same time as arrays *)
    u'' <- inzp ( to_uint u' );
    return u'';
  }

  proc init_points (init : zp) : zp * zp * zp * zp = 
  {
    var x2 : zp;
    var z2 : zp;
    var x3 : zp;
    var z3 : zp;

    x2 <- witness;
    x3 <- witness;
    z2 <- witness;
    z3 <- witness;

    x2 <- Zp.one;
    z2 <- Zp.zero;
    x3 <- init;
    z3 <- Zp.one;

    return (x2, z2, x3, z3);
  }
  
  proc add_and_double (init x2 z2 x3 z3 : zp) : zp * zp * zp * zp =
  {
    var t0 : zp;
    var t1 : zp;
    var t2 : zp;
    t0 <- witness;
    t1 <- witness;
    t2 <- witness;
    t0 <@ sub (x2, z2);
    x2 <@ add (x2, z2);
    t1 <@ sub (x3, z3);
    z2 <@ add (x3, z3);
    z3 <@ mul (x2, t1);
    z2 <@ mul (z2, t0);
    t2 <@ sqr (x2);
    t1 <@ sqr (t0);
    x3 <@ add (z3, z2);
    z2 <@ sub (z3, z2);
    x2 <@ mul (t2, t1);
    t0 <@ sub (t2, t1);
    z2 <@ sqr (z2);
    z3 <@ mul_a24 (t0, 121665);
    x3 <@ sqr (x3);
    t2 <@ add (t2, z3);
    z3 <@ mul (init, z2);
    z2 <@ mul (t0, t2);
    return (x2, z2, x3, z3);
  }

  proc montgomery_ladder_step (k' : W256.t, 
                               init' x2 z2 x3 z3 : zp,
                               swapped : bool,
                               ctr' : int) : zp * zp * zp * zp * bool =
  { 
    var bit : bool;
    var toswap : bool;
    bit <@ ith_bit (k', ctr');
    toswap <- swapped;
    toswap <- (toswap ^^ bit);
    (x2, z2, x3, z3) <@ cswap (x2, z2, x3, z3, toswap);
    swapped <- bit;
    (x2, z2, x3, z3) <@ add_and_double (init', x2, z2, x3, z3);
    return (x2, z2, x3, z3, swapped);
  }

  proc montgomery_ladder (init' : zp, k' : W256.t) : zp * zp * zp * zp = 
  {
    var x2 : zp;
    var z2 : zp;
    var x3 : zp;
    var z3 : zp;
    var ctr : int;
    var swapped : bool;
    x2 <- witness;
    x3 <- witness;
    z2 <- witness;
    z3 <- witness;
    (x2, z2, x3, z3) <@ init_points (init');
    ctr <- 254;
    swapped <- false;
    while (0 <= ctr)
    { (x2, z2, x3, z3, swapped) <@
        montgomery_ladder_step (k', init', x2, z2, x3, z3, swapped, ctr);
      ctr <- ctr - 1;
    }
    return (x2, z2, x3, z3);
  }

  proc encode_point (x2 z2 : zp) : W256.t =
  {
    var r : zp;
    r <- witness;
    z2 <@ invert (z2);
    r <@  mul (x2, z2);
    (* no need to 'freeze' or 'tobytes' r in this spec *)
    return (W256.of_int (asint r));
  }

  proc scalarmult (k' u' : W256.t) : W256.t =
  {
    var u'' : zp;
    var x2 : zp;
    var z2 : zp;
    var x3 : zp;
    var z3 : zp;
    var r : W256.t;
   
    r <- witness;
    x2 <- witness;
    x3 <- witness;
    z2 <- witness;
    z3 <- witness;

    k'  <@ decode_scalar_25519 (k');
    u'' <@ decode_u_coordinate (u');
    (x2, z2, x3, z3) <@ montgomery_ladder (u'', k');
    r <@ encode_point (x2, z2);
    return r;
  }
}.

(** step 1 : decode_scalar_25519 **)
lemma eq_h2_decode_scalar_25519 k:
  hoare [ MHop2.decode_scalar_25519 : k' = k
          ==> res = decodeScalar25519 k].
proof.
  proc; wp; rewrite /decodeScalar25519 /=; skip.
  move => _ hk; rewrite hk //.
qed.

(** step 2 : decode_u_coordinate **)
lemma eq_h2_decode_u_coordinate u:
  hoare [ MHop2.decode_u_coordinate : u' = u
          ==> res = decodeUCoordinate u].
proof.
  proc; wp; rewrite /decode_u_coordinate /=; skip.
  move => _ hu; rewrite hu //.
qed.

(** step 3 : ith_bit **)
lemma eq_h2_ith_bit (k : W256.t) i:
  hoare [MHop2.ith_bit : k' = k /\ ctr = i ==> res = ith_bit k i].
proof.
  proc. rewrite /ith_bit. skip => />.
qed.

(** step 4 : cswap **)
lemma eq_h2_cswap (t : (zp * zp) * (zp * zp) )  b:
  hoare [MHop2.cswap : x2 = (t.`1).`1 /\
                       z2 = (t.`1).`2 /\
                       x3 = (t.`2).`1 /\
                       z3 = (t.`2).`2 /\
                       toswap = b 
         ==> ((res.`1, res.`2),(res.`3, res.`4)) = cswap t b].
proof.
  by proc; wp; skip; simplify => /#.
qed.

(** step 5 : add_and_double **)
lemma eq_h2_add_and_double (qx : zp) (nqs : (zp * zp) * (zp * zp)):
  hoare [MHop2.add_and_double : init = qx /\ 
                                x2 = nqs.`1.`1 /\
                                z2 = nqs.`1.`2 /\
                                x3 = nqs.`2.`1 /\
                                z3 = nqs.`2.`2
         ==> ((res.`1, res.`2),(res.`3, res.`4)) = add_and_double1 qx nqs].
proof.
  proc; inline *; wp; skip.
  rewrite /add_and_double1 /=. smt(expr2).
qed.

(** step 6 : montgomery_ladder_step **)
lemma eq_h2_montgomery_ladder_step (k : W256.t) 
                                   (init : zp)
                                   (nqs : (zp * zp) * (zp * zp) * bool) 
                                   (ctr : int) :
  hoare [MHop2.montgomery_ladder_step : k' = k /\ 
                                        init' = init /\
                                        x2 = nqs.`1.`1 /\
                                        z2 = nqs.`1.`2 /\
                                        x3 = nqs.`2.`1 /\
                                        z3 = nqs.`2.`2 /\
                                        swapped = nqs.`3 /\
                                        ctr' = ctr
         ==> ((res.`1, res.`2),(res.`3, res.`4),res.`5) =
             montgomery_ladder3_step k init nqs ctr].
proof.
  proc => /=.
  ecall (eq_h2_add_and_double init (cswap (select_tuple_12 nqs) (nqs.`3 ^^ (ith_bit k ctr)))).
  wp.
  ecall (eq_h2_cswap (select_tuple_12 nqs) (nqs.`3 ^^ (ith_bit k ctr))).
  wp.
  ecall (eq_h2_ith_bit k ctr). auto.
  rewrite /montgomery_ladder3_step => /#.
qed.

(** step 7 : montgomery_ladder **)
lemma unroll_ml3s  k init nqs (ctr : int) : (** unroll montgomery ladder 3 step **)
  0 <= ctr =>
    foldl (montgomery_ladder3_step k init)
          nqs
          (rev (iota_ 0 (ctr+1)))
    =
    foldl (montgomery_ladder3_step k init)
          (montgomery_ladder3_step k init nqs ctr)
          (rev (iota_ 0 (ctr))).
proof.
move => ctrge0.
rewrite 2!foldl_rev iotaSr //= -cats1 foldr_cat => /#.
qed.

lemma eq_h2_montgomery_ladder (init : zp)
                              (k : W256.t) :
  hoare [MHop2.montgomery_ladder : init' = init /\
                                   k.[0] = false /\
                                   k' = k
         ==> ((res.`1, res.`2),(res.`3,res.`4)) =
             select_tuple_12 (montgomery_ladder3 init k)].
proof.
proc.
  inline MHop2.init_points. sp. simplify.
  rewrite /montgomery_ladder3.

  while (foldl (montgomery_ladder3_step k' init')
               ((Zp.one, Zp.zero), (init, Zp.one), false)
               (rev (iota_ 0 255))
         =
         foldl (montgomery_ladder3_step k' init')
               ((x2,z2), (x3,z3), swapped)
               (rev (iota_ 0 (ctr+1)))
         ).
  wp.
  ecall (eq_h2_montgomery_ladder_step k' init' ((x2,z2),(x3,z3),swapped) ctr).
  skip. simplify.
  move => &hr [?] ? ? ?. smt(unroll_ml3s).
  skip. move => &hr [?] [?] [?] [?] [?] [?] [?] [?] [?] [?] [?] [?] [?] ?. subst.
  split; first by done.
  move => ? ? ? ? ? ? ?.
  have _ : rev (iota_ 0 (ctr0 + 1)) = []; smt(iota0).
qed.

(** step 8 : iterated square **)
lemma it_sqr1_m2_exp4 (e : int) (z : zp) :
  0 <= e - 2 => it_sqr1 e z = it_sqr1 (e-2) (exp (exp z 2) 2).
proof.
  rewrite expE // /= => ?.
  rewrite !eq_it_sqr1. smt(). trivial.
  rewrite /it_sqr (*expE*).
  (* directly rewriting expE takes too long *)
  have ee :  exp (exp z 4) (2 ^ (e - 2)) =  exp z (2^2 * 2 ^ (e - 2)). smt(expE).
  rewrite ee. congr.
  rewrite pow_add //.
qed.

lemma it_sqr1_0 (e : int) (z : zp) :
  0 = e => it_sqr1 e z = z.
proof.
  move => ?.
  rewrite eq_it_sqr1. smt().
  rewrite /it_sqr. subst. simplify.
  rewrite expr1 //.
qed.

lemma eq_h2_it_sqr (e : int) (z : zp) : 
  hoare[MHop2.it_sqr :
         i = e && 2 <= i && i %% 2 = 0 && f =  z 
         ==>
        res = it_sqr1 e z].
proof.
  proc. inline MHop2.sqr. simplify.
  while ( 0 <= i && i %% 2 = 0 && it_sqr1 e z = it_sqr1 i f).
  wp. skip.

  (** alternative version with progress **)
  (*
            progress. smt(). smt(). smt(it_sqr1_m2_exp4).
  wp. skip. progress. smt(). smt(). smt(it_sqr1_m2_exp4).
  smt(it_sqr1_0).
  *)

  move => &hr [[?]] [?] hin ?. simplify.
  split; first by smt(). move => ?.
  split; first by smt(). move => ?.
  rewrite hin. move : H2. apply it_sqr1_m2_exp4.
  wp. skip.
  move => &hr [?] [?] [?] ?. simplify.
  split.
  split; first by smt(). move => ?.
  split; first by smt(). move => ?.
  subst. move : H3.  apply it_sqr1_m2_exp4.
  move => ? ? ? [?] [?] ->. subst.
  have ieq0 : i0 = 0. smt().
  rewrite it_sqr1_0 /#.
qed.

(** step 9 : invert **)
lemma eq_h2_invert (z : zp) : 
  hoare[MHop2.invert : z1' =  z ==> res = invert2 z].
proof.
  proc.
  inline MHop2.sqr MHop2.mul.  wp.
  ecall (eq_h2_it_sqr 4   t1). wp.
  ecall (eq_h2_it_sqr 50  t2). wp.
  ecall (eq_h2_it_sqr 100 t2). wp.
  ecall (eq_h2_it_sqr 50  t1). wp.
  ecall (eq_h2_it_sqr 10  t2). wp.
  ecall (eq_h2_it_sqr 20  t2). wp.
  ecall (eq_h2_it_sqr 10  t1). wp.
  ecall (eq_h2_it_sqr 4   t2). wp.
  skip. simplify.
  move => &hr ?. 
  move=> ? ->. move=> ? ->. 
  move=> ? ->. move=> ? ->.
  move=> ? ->. move=> ? ->.
  move=> ? ->. move=> ? ->.
  rewrite invert2E /sqr /= H /#.
qed.

(** step 10 : encode point **)
lemma eq_h2_encode_point (q : zp * zp) : 
  hoare[MHop2.encode_point : x2 =  q.`1 /\ z2 = q.`2 ==> res = encodePoint1 q].
proof.
  proc. inline MHop2.mul. wp. sp.
  ecall (eq_h2_invert z2).
  skip. simplify.
  move => &hr [?] [?] ? ?. move=> ->.
  rewrite encodePoint1E /= H0 H1 //.
qed.

(** step 11 : scalarmult **)
lemma eq_h2_scalarmult (k u : W256.t) : 
  hoare[MHop2.scalarmult : k' = k /\ u' = u ==> res = scalarmult k u].
proof.
  rewrite -eq_scalarmult1.
  proc. sp.
  ecall (eq_h2_encode_point (x2,z2)).     simplify.
  ecall (eq_h2_montgomery_ladder u'' k'). simplify.
  ecall (eq_h2_decode_u_coordinate u').   simplify.
  ecall (eq_h2_decode_scalar_25519 k').   simplify.
  skip.
  move => &hr [?] [?] [?] [?] [?] [?] ?.
  move=> ? -> ? ->. split.
    by rewrite /decodeScalar25519 /=.
  move=> ? ? ? ? -> => /#.
qed.

require import Bool List Int IntExtra IntDiv CoreMap Real Zp.
from Jasmin require import JModel.
import ZModpRing Zp.

module MSpec2 = {

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
    h <- f * f;
    return h;
  }

  (* iterated sqr : i must be pair and >= 2 *)
  proc it_sqr (i : int, f : zp) : zp =
  {
    var h : zp;
    h <- witness;

    h <@ sqr(f);
    i <- i - 1;
    f <@ sqr(h);
    i <- i - 1;

    while (0 <= i) {
      h <@ sqr(f);
      i <- i - 1;
      f <@ sqr(h);
      i <- i - 1;
    }
    return f;
  }

  (* f ** 2**255-19-2 *)
  proc invert (z1 : zp) : zp =
  {
    var t0 : zp;
    var t1 : zp;
    var t2 : zp;
    var t3 : zp;

    t0 <- witness;
    t1 <- witness;
    t2 <- witness;
    t3 <- witness;

    t0 <@ sqr (z1);
    t1 <@ sqr (t0);
    t1 <@ sqr (t1);
    t1 <- z1 * t1;
    t0 <- t0 * t1;
    t2 <@ sqr (t0);
    t1 <- t1 * t2;
    t2 <@ sqr (t1);
    t2 <@ it_sqr (4, t2);
    t1 <- t1 * t2;
    t2 <@ it_sqr (10, t1);
    t2 <- t1 * t2;
    t3 <@ it_sqr (20, t2);
    t2 <- t2 * t3;
    t2 <@ it_sqr (10, t2);
    t1 <- t1 * t2;
    t2 <@ it_sqr (50, t1);
    t2 <- t1 * t2;
    t3 <@ it_sqr (100, t2);
    t2 <- t2 * t3;
    t2 <@ it_sqr (50, t2);
    t1 <- t1 * t2;
    t1 <@ it_sqr (4, t1);
    t1 <@ sqr (t1);
    t1 <- t0 * t1;
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

  proc ith_bit (k : W256.t, ctr : int) : bool =
  {
    return k.[ctr];
  }

  proc decode_scalar_25519 (kp : W64.t) : W256.t = 
  {
    var k : W256.t;
    k <- loadW256 Glob.mem (W64.to_uint kp);
    k.[0] <- false;
    k.[1] <- false;
    k.[2] <- false;
    k.[255] <- false;
    k.[254] <- true;
    return k;
  }

  proc decode_u_coordinate (up : W64.t) : zp =
  {
    var u : zp;
    (* last bit of u is cleared but that can be introduced at the same time as arrays *)
    u <- inzp ( to_uint ( loadW256 Glob.mem (W64.to_uint up) ) );
    return u;
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

  proc montgomery_ladder_step (k : W256.t, 
                               init x2 z2 x3 z3 : zp,
                               swapped : bool,
                               ctr : int) : zp * zp * zp * zp * bool =
  { 
    var bit : bool;
    var toswap : bool;
    bit <@ ith_bit (k, ctr);
    toswap <- swapped;
    toswap <- (toswap ^^ bit);
    (x2, z2, x3, z3) <@ cswap (x2, z2, x3, z3, toswap);
    swapped <- bit;
    (x2, z2, x3, z3) <@ add_and_double (init, x2, z2, x3, z3);
    return (x2, z2, x3, z3, swapped);
  }

  proc montgomery_ladder (init : zp, k : W256.t) : zp * zp * zp * zp = 
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
    (x2, z2, x3, z3) <@ init_points (init);
    ctr <- 254;
    swapped <- false;
    (x2, z2, x3, z3, swapped) <@ montgomery_ladder_step (k, init, x2, z2, x3, z3, swapped, ctr);
    ctr <- ctr - 1;
    while (0 <= ctr)
    { (x2, z2, x3, z3, swapped) <@ montgomery_ladder_step (k, init, x2, z2, x3, z3, swapped, ctr);
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

  proc x25519_scalarmult (rp kp up : W64.t) : unit =
  {    
    var k : W256.t;
    var u : zp;
    var x2 : zp;
    var z2 : zp;
    var x3 : zp;
    var z3 : zp;
    var r : W256.t;
   
    k <- witness;
    r <- witness;
    u <- witness;
    x2 <- witness;
    x3 <- witness;
    z2 <- witness;
    z3 <- witness;

    k <@ decode_scalar_25519 (kp);
    u <@ decode_u_coordinate (up);
    (x2, z2, x3, z3) <@ montgomery_ladder (u, k);
    r <@ encode_point (x2, z2);
    Glob.mem <- storeW256 Glob.mem (W64.to_uint rp) r;
    return ();
  }
}.

(*------------------------- Sponge Construction ------------------------*)

(* Specialization of the Sponge Construction for a 1600bit state        *)


require import Core Int IntDiv Real List FSet SmtMap.
(*---*) import IntExtra.
require import Distr DBool DList.
require import StdBigop StdOrder. import IntOrder.


op rate :int.
axiom rate_bnds: 0 < rate < 1600.
axiom rate_w64: 64 %| rate.

lemma rate_ge2: 2 <= rate.
proof.
case: (rate = 1) => E.
 by rewrite E; smt(rate_w64).
by smt (rate_bnds).
qed.

require Common.
clone export Common as Common1600
 with op r = rate,
      op c = 1600-r
      proof ge2_r by apply rate_ge2
      proof gt0_c by smt (rate_bnds).

require Indifferentiability.
clone include Indifferentiability with
  type p     <- block * capacity,
  type f_in  <- bool list * int,
  type f_out <- bool list

  rename
    [module] "Indif"  as "Experiment"
    [module] "GReal"  as "RealIndif"
    [module] "GIdeal" as "IdealIndif".

(*------------------------- Sponge Construction ------------------------*)
module (Sponge : CONSTRUCTION) (P : DPRIMITIVE) : FUNCTIONALITY = {
  proc init() : unit = {}

  proc f(bs : bool list, n : int) : bool list = {
    var z        <- [];
    var (sa, sc) <- (b0, Capacity.c0);
    var i        <- 0;
    var xs       <- pad2blocks bs;

    (* absorption *)
    while (xs <> []) {
      (sa, sc) <@ P.f(sa +^ head b0 xs, sc);
      xs       <- behead xs;
    }
    (* squeezing *)
    while (i < (n + r - 1) %/ r) {
      z        <- z ++ ofblock sa;
      i        <- i + 1;
      if (i < (n + r - 1) %/ r) {
        (sa, sc) <@ P.f(sa, sc);
      }
    }

    return take n z;
  }
}.


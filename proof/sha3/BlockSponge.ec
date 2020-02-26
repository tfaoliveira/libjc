(*-------------------- Padded Block Sponge Construction ----------------*)

require import AllCore Int Real List.
require (*--*) IRO Indifferentiability Gconcl.
require import Common SLCommon.

(*------------------------- Indifferentiability ------------------------*)

clone include Indifferentiability with
  type p     <- block * capacity,
  type f_in  <- block list * int,
  type f_out <- block list

  rename
    [module] "Indif" as "Experiment"
    [module] "GReal"  as "RealIndif"
    [module] "GIdeal"  as "IdealIndif".

(*------------------------- Ideal Functionality ------------------------*)

clone import IRO as BIRO with
  type from <- block list,
  type to   <- block,
  op valid  <- valid_block,
  op dto    <- bdistr.

(*------ Validity and Parsing/Formatting of Functionality Queries ------*)

op format (p : block list) (n : int) = p ++ nseq (n - 1) b0.
op parse: block list -> (block list * int).

axiom formatK bs: format (parse bs).`1 (parse bs).`2 = bs.
axiom parseK p n: 0 < n => valid_block p => parse (format p n) = (p,n).
axiom parse_nil: parse [] = ([],0).

lemma parse_injective: injective parse.
proof.
by move=> bs1 bs2 eq_format; rewrite -formatK eq_format (@formatK bs2).
qed.

lemma parse_valid p: valid_block p => parse p = (p,1).
proof.
move=>h;cut{1}->:p=format p 1;2:smt(parseK).
by rewrite/format/=nseq0 cats0.
qed.

(*---------------------------- Restrictions ----------------------------*)

(** The counter for the functionnality counts the number of times the
    underlying primitive is called inside the functionality. This
    number is equal to the sum of the number of blocks the input
    message contains and the number of additional blocks the squeezing
    phase has to output.
  *)

module C = {
  var c : int
  proc init() = {
    c <- 0;
  }
}.

module FC (F : DFUNCTIONALITY) = {
  proc init () : unit = {}

  proc f (bl : block list, nb : int) = {
    var z : block list <- [];
    if (C.c + size bl + (max (nb - 1) 0) <= max_size) {
      C.c <- C.c + size bl + (max (nb - 1) 0);
      z <@ F.f(bl, nb);
    }
    return z;
  }
}.

module PC (P : DPRIMITIVE) = {
  proc init() = {}

  proc f (a : state) = {
    var z : state <- (b0, c0);
    if (C.c + 1 <= max_size) {
      z <@ P.f(a);
      C.c <- C.c + 1;
    }
    return z;
  }

  proc fi (a : state) = {
    var z : state <- (b0, c0);
    if (C.c + 1 <= max_size) {
      z <@ P.fi(a);
      C.c <- C.c + 1;
    }
    return z;
  }
}.

module DRestr (D : DISTINGUISHER) (F : DFUNCTIONALITY) (P : DPRIMITIVE) = {
  proc distinguish () : bool = {
    var b : bool;
    C.init();
    b <@ D(FC(F), PC(P)).distinguish();
    return b;
  }
}.


(*----------------------------- Simulator ------------------------------*)

module Last (F : DFUNCTIONALITY) : SLCommon.DFUNCTIONALITY = {
  proc init() = {}
  proc f (p : block list) : block = {
    var z : block list <- [];
    z <@ F.f(parse p);
    return last b0 z;
  }
}.

module (Sim : SIMULATOR) (F : DFUNCTIONALITY) = Gconcl.S(Last(F)).

(*------------------------- Sponge Construction ------------------------*)

module (Sponge : CONSTRUCTION) (P : DPRIMITIVE) : FUNCTIONALITY = {
  proc init() = {}

  proc f(xs : block list, n : int) : block list = {
    var z        <- [];
    var (sa, sc) <- (b0, Capacity.c0);
    var i        <- 0;

    if (valid_block xs) {
      (* absorption *)
      while (xs <> []) {
        (sa, sc) <@ P.f(sa +^ head b0 xs, sc);
        xs       <- behead xs;
      }
      (* squeezing *)
      while (i < n) {
        z <- rcons z sa;
        i <- i + 1;
        if (i < n) {
          (sa, sc) <@ P.f(sa, sc);
        }
      }
    }
    return z;
  }
}.

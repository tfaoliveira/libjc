require import List Jasmin_model Int IntExtra IntDiv CoreMap Real.
require import Zp.
import Zp.

(****************************************************************)
(************ HACL* - Specification   **********************)
(*
let encode (w:word) =
  (pow2 (8 * length w)) `fadd` (little_endian w)

let rec poly (txt:text) (r:e:elem) : Tot elem (decreases (length txt)) =
  if length txt = 0 then zero
  else
    let a = poly (Seq.tail txt) r in
    let n = encode (Seq.head txt) in
    (n `fadd` a) `fmul` r

let encode_r (rb:word_16) =
  (little_endian rb) &| 0x0ffffffc0ffffffc0ffffffc0fffffff

let finish (a:elem) (s:word_16) : Tot tag =
  let n = (a + little_endian s) % pow2 128 in
  little_bytes 16ul n

let rec encode_bytes (txt:bytes) : Tot text (decreases (length txt)) =
  if length txt = 0 then createEmpty
  else
    let w, txt = split txt (min (length txt) 16) in
    append_last (encode_bytes txt) w

let poly1305 (msg:bytes) (k:key) : Tot tag =
  let text = encode_bytes msg in
  let r = encode_r (slice k 0 16) in
  let s = slice k 16 32 in
  finish (poly text r) s
*)
(****************************************************************)

(* The following spec matches the poly HACL* function over Zp *)

type Zp_msg = zp list. 

op poly1305_loop (r : zp) (m : Zp_msg) (n : int) =
  foldl (fun h i => (h + oget (onth m i)) * r) Zp.zero (iota_ 0 n).

op poly1305_ref (r : zp) (s : int) (m : Zp_msg) =
  let n = size m in
  let h' = poly1305_loop r m n
      in  (((asint h') %% 2^128) + s) %% 2^128.

lemma loop0 (m : Zp_msg) r : 
    poly1305_loop r m 0 = Zp.zero.
proof. by rewrite /poly1305_loop  iota0. qed.

lemma loopS  (m : Zp_msg) n r : 0 <= n =>
  poly1305_loop r m (n+1) =
  let h' = poly1305_loop r m n
      in (h' + oget (onth m (n))) * r.
proof. 
by move=> ge0_n; rewrite /poly1305_loop iotaSr // -cats1 foldl_cat. 
qed.

hint simplify loop0.
hint simplify loopS.

(****************************************************************)
(************ Imperative version           **********************)
(****************************************************************)

module Poly1305_RefWhile = {

   proc poly1305(r:zp, s : int, m : Zp_msg) = {
       var h,n,i;

       n <- size m;
       i <- 0;
       h <- Zp.zero;

       while (i < n) {
         h <- (h + oget (onth m i)) * r;
         i <- i + 1;
       }
       return (((asint h) %% 2^128) + s) %% 2^128;
   }
}.


lemma ref_ok m0 r0 s0 :
  hoare [ Poly1305_RefWhile.poly1305 :
    m = m0 /\ r = r0 /\ s = s0 ==> res = poly1305_ref r0 s0 m0 ].
proof.
proc; wp;sp.
conseq (_ :
      0 <= i /\ i <= n /\ h = poly1305_loop r m i
  ==> h = poly1305_loop r m n) => />.
+ by move=> /> &hr; rewrite size_ge0.
while (#pre); auto => />.
+ by move=> &hr /= ge0i; rewrite loopS //#.
+ smt().
qed.

lemma ref_ll : islossless Poly1305_RefWhile.poly1305.
proof. by islossless; sp;wp; while true (n-i) => *; auto => /#. qed.

lemma ref_ok_ll m0 r0 s0 :
  phoare [ Poly1305_RefWhile.poly1305 :
    m = m0 /\ r = r0 /\ s=s0 ==> res = poly1305_ref r0 s0 m0  ] = 1%r.
proof. by conseq ref_ll (ref_ok m0 r0 s0). qed.

(* The following operators match the encode operations in HACL* *)
(* Make explicit that x86-64 ops are little endian? *)

op load_lblock (mem : global_mem_t) (l ptr : W64.t) = 
   let x = pack16_t (W16u8.Pack.init 
            (fun i => if i < W64.to_uint l 
                      then mem.[to_uint ptr + i] 
                      else W8.zero))
   in (Zp.inzp (W128.to_uint x + 2^(8* W64.to_uint l))).

op load_block mem ptr = load_lblock mem (W64.of_int 16) ptr.

lemma load16u8vs128 (mem : global_mem_t) (ptr : W64.t) :
  loadW128 mem (to_uint ptr) = 
     pack16_t (W16u8.Pack.init 
            (fun i => if i < 16 
                      then mem.[to_uint ptr + i] 
                      else W8.zero)).
rewrite /loadW128.
have ? : forall i, 0<=i<16 => (mem.[to_uint ptr + i])= (if i < 16 then mem.[to_uint ptr + i] else W8.zero). smt(). 
move : (W16u8.Pack.init_ext 
            (fun (i : int) => mem.[to_uint ptr + i])
            (fun (i : int) => if i < 16 then mem.[to_uint ptr + i] else W8.zero)).
smt.
qed.

lemma full_block (mem : global_mem_t) (ptr : W64.t):
   load_block mem ptr = let x = (loadW128 mem (to_uint ptr))
                        in Zp.inzp (W128.to_uint x + 2^128).
proof. by rewrite /load_block load16u8vs128. qed.

op load_clamp(mem: global_mem_t) (ptr : W64.t) = 
   let x = loadW128 mem (to_uint ptr) in
   let xclamp = W128.andw x 
                   (W128.of_int 21267647620597763993911028882763415551)
                                 (* 0xFFFFFFC0FFFFFFC0FFFFFFC0FFFFFFF *)
   in Zp.inzp (W128.to_uint xclamp).

(* The following is our starting point for game-hope style equivalences,
   which we prove equivalent to the HACL* spec in this file *)

module Mspec = {
 
  proc poly1305 (out:W64.t, in_0:W64.t, inlen:W64.t, k:W64.t) : unit = {
    var r,h,x:zp;
    var b16:W64.t;
    var s:int;
    var h_int:int;
    var inlen0;

    r <- load_clamp Glob.mem k;
    h <- Zp.zero;
    inlen0 <- inlen;
    
    while (W64.of_int 16 \ule inlen0) {
      x <- load_block Glob.mem in_0;
      h <- h + x;
      h <- h * r;
      in_0 <- in_0 + W64.of_int 16;
      inlen0 <- inlen0 - W64.of_int 16;      
    }
    if (W64.of_int 0 \ult inlen0) {
      x <- load_lblock Glob.mem inlen0 in_0;
      h <- h + x;
      h <- h * r;
    }
    h_int <- (asint h) %% 2^128;
    k <- (k + (W64.of_int 16));
    s <- W128.to_uint (loadW128 Glob.mem (to_uint k));
    h_int <- (h_int + s) %% 2^128;
    Glob.mem <- storeW128 Glob.mem (to_uint out) (W128.of_int h_int);
  }

}.

(* Bounded memory assumption (established by the safety analysis) *)
abbrev good_ptr (ptr: W64.t) len =
 to_uint ptr + len < W64.modulus.
op inv_ptr (k in_0 len out: W64.t) =
 good_ptr k 32 /\ good_ptr in_0 (to_uint len) /\ good_ptr out 16.

(* Relational precondition: inputs to specification are
                            represented in memory *)
op poly1305_pre (r : zp) (s : int) (m : Zp_msg)
                (mem : global_mem_t) (inn, inl, kk : W64.t)  = 
      (size m = if  W64.to_uint inl %% 16 = 0 
           then to_uint inl %/ 16
           else to_uint inl %/ 16 + 1) /\
       m = mkseq (fun i => 
            let offset = W64.of_int (i * 16) in
               if i < size m - 1
               then load_block mem (inn + offset)
               else load_lblock mem (inl - offset) (inn + offset))
                     (size m) /\
        r = load_clamp mem kk /\
        s = to_uint (loadW128 mem (to_uint (kk + W64.of_int 16))).

(* Relational postcondition: output of specification is
                             stored in memory *)
op poly1305_post mem_pre mem_post outt rr ss mm =
  mem_post = storeW128 mem_pre (W64.to_uint outt)
       (W128.of_int (poly1305_ref rr ss mm)).

lemma loadW128_storeW128_eq mem ptr a : loadW128 (storeW128 mem ptr a) ptr = a.
proof.
  rewrite /loadW128 storeW128E.
  rewrite -{2}(W16u8.unpack8K a);congr.
  apply W16u8.Pack.packP => i hi. 
  rewrite initE hi /= get_storesE /= get_unpack8 1:// /#.
qed.

equiv spec_eq mem rr ss mm outt inn inl kk :
   Poly1305_RefWhile.poly1305 ~ Mspec.poly1305 : 
      Glob.mem{2} = mem /\
      r{1} = rr /\ s{1} = ss /\ m{1} = mm /\
      out{2} = outt /\ in_0{2} = inn /\ inlen{2} = inl /\ k{2} = kk /\
      poly1305_pre rr ss mm mem inn inl kk ==>
        res{1} = poly1305_ref rr ss mm <=>
          poly1305_post mem Glob.mem{2} outt rr ss mm.
            
proof.
proc.
seq 3 3 : (#{~in_0{2}=inn}pre /\ 
          (0 < n{1} => i{1} <= n{1} - 1) /\ 
          (0 = n{1} => i{1} = 0) /\ 
          0 <= i{1} /\
           ={h,r} /\ n{1} = size m{1} /\ i{1} <= n{1} /\ 
          to_uint inlen0{2} = to_uint inlen{2} - 16 * i{1} /\ 
          in_0{2} = inn + W64.of_int (16 * i{1}));
            first by 
             auto => />;move => &1 &2 [/ # *];progress;[1: by smt(size_ge0)| 2..: by smt ].
(* Iterations where while loops are always synched *)
splitwhile {1} 1 : (i < n - 1).
splitwhile {2} 1 : (16 < to_uint inlen0).
seq 1 1 : (#{/~0 < n{1} => i{1} <= n{1} - 1}pre /\ 
           (0 < n{1} => n{1} - 1 <= i{1})).
while (#pre).
auto => />;move => &1 &2 [/ # *].
progress.
by smt().
by smt().
by smt().
rewrite H0 /mkseq onth_nth_map; 
    rewrite (nth_map witness);
      first by rewrite size_map size_iota /max;smt().
    rewrite (nth_map witness);
      first by rewrite size_iota /max;smt().
    auto => />.
    by rewrite nth_iota => /#.
by smt().
by smt.
by smt.
by smt.
by smt.
by smt.
by smt.
auto => />;move => &1 &2 [/ # *].
progress.
by smt. by smt. by smt. by smt. by smt.

seq 1 2 : (#{/~n{1}}{~i{1}}pre); last first.       
  wp;skip;progress. smt. 
  move :  H H0.
  rewrite /poly1305_pre /poly1305_post /poly1305_ref => //= *. smt.

(* Last block processing *)
(* One last synched iteration? *)
case (to_uint inl %% 16 = 0).
seq 1 1 : ((#{/~n{1}}{~i{1}}pre) /\ inlen0{2} = W64.zero); 
   last by auto => />.
case (to_uint inl = 0).
while (#pre). 
exfalso. 
rewrite /poly1305_pre. 
move => &1 &2 [/ # *].
smt. 
auto => />.  
move => &1 &2 [/ # *].
progress.
smt. smt. smt.

(* One last synched iteration! *)
while (#{/~n{1}}{~i{1}}pre /\ n{1} = size m{1} /\
           in_0{2} = inn + (of_int (i{1} * 16))%W64 /\
           to_uint inlen0{2} = to_uint inlen{2} - 16 * i{1} /\
           ((to_uint inlen0{2} = 16 /\ n{1} -1 <= i{1}) \/
           (to_uint inlen0{2} = 0 /\ i{1} = n{1}))).
auto => />.
move => &1 &2 [/ # *].
progress.
elim H4; last by smt.
move => *.
rewrite H0 /mkseq onth_nth_map; 
    rewrite (nth_map witness);
      first by rewrite size_map size_iota /max;smt.
    rewrite (nth_map witness);
      first by rewrite size_iota /max;smt.
    auto => />.
    rewrite nth_iota. smt. 
rewrite (_: 0 + i{1} < size m{1} - 1 = false); first by smt. 
simplify. rewrite /load_block. 
rewrite (_ : inlen{2} - (of_int (i{1} * 16))%W64 = W64.of_int 16). 
move : H. rewrite H1. simplify. move => *.
smt. smt. smt.  by smt. smt. smt. smt.

skip.
move => &1 &2 [/ # *].
progress => //=.
smt. smt. smt. smt. smt.

(* Ref executes loop one more time *)
unroll {1} 1.
rcondt {1} 1.
move => &m.
skip.
smt.

seq  3 1: (#{/~ ={h}}{~i{1}}pre /\
              h{1} = (h{2} + oget (onth m{1} (i{1}-1))) * r{1} /\
              i{1} = n{1} /\
              to_uint inlen0{2} = to_uint inlen{2} - 16 * (i{1}-1) /\
    in_0{2} = inn + (of_int (16 * (i{1}-1)))%W64).
seq 2 0 : (#{/~ ={h}}{~i{1}}pre /\
              to_uint inlen0{2} = to_uint inlen{2} - 16 * (i{1}-1) /\
              h{1} = (h{2} + oget (onth m{1} (i{1}-1))) * r{1} /\
              i{1} = n{1} /\
in_0{2} = inn + (of_int (16 * (i{1}-1)))%W64).
auto => />. 
move => &1 &2 i_L [/ # *]. 
smt.
while (#pre ).
auto => />. 
skip.
move => &1 &2 [/ # *]. 
progress. smt. smt. smt. smt. smt. smt. smt. smt.
auto => />. 
move => &1 &2 i_L [/ # *]. 
progress.
rewrite {1} H. rewrite /mkseq onth_nth_map. 
rewrite (nth_map witness None Some). 
smt. 
rewrite (nth_map witness witness) => //=. 
smt. 
rewrite (_: nth witness (iota_ 0 (size m{1})) (size m{1} - 1) < size m{1} - 1 = false). smt.
simplify.
rewrite nth_iota. smt. 
rewrite (_: ((size m{1} - 1)) * 16 = 16 * (size m{1} - 1)). smt.
have __: (inlen0{2} = inlen{2} - W64.of_int (16 * (size m{1} - 1))). 
apply W64.word_modeqP. 
rewrite to_uintB. smt. smt. smt. smt.
qed.

lemma corr mem rr ss mm outt inn inl kk :
  phoare [ 
   Mspec.poly1305 : 
      Glob.mem = mem /\
      out = outt /\ in_0 = inn /\ inlen = inl /\ k = kk /\
      poly1305_pre rr ss mm mem inn inl kk ==> 
    poly1305_post mem Glob.mem outt rr ss mm] = 1%r.
proof.
bypr => &m pxm.
  rewrite -(_ :
       Pr[Poly1305_RefWhile.poly1305(rr, ss, mm) @ &m :
          res = poly1305_ref rr ss mm  ] = 1%r).
by byphoare (_ :  m = mm /\ r = rr /\ s=ss ==> res = poly1305_ref rr ss mm) => //;
apply: (ref_ok_ll mm rr ss).
have ? : (Pr[Poly1305_RefWhile.poly1305(rr, ss, mm) @ &m : res = poly1305_ref rr ss mm] = 
Pr[Mspec.poly1305(out{m}, in_0{m}, inlen{m}, k{m}) @ &m :
   poly1305_post mem Glob.mem outt rr ss mm]); last by smt().
byequiv => //=. proc*.
call (spec_eq mem rr ss mm outt inn inl kk).  
by auto => />.
qed.

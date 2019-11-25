require import List Int IntExtra IntDiv CoreMap.

from Jasmin require import JModel JArray JWord_array.

require import Array2p Array4p Array5 WArray128p WArray160p.

type t2u64 = W64.t Array2.t.
type t4u64 = W64.t Array4.t.

hint simplify W8.of_intwE @0.

lemma pack2_bits32 (w: W64.t):
   pack2 [w \bits32 0; w \bits32 1] = w.
proof. by apply W2u32.allP. qed.

lemma pack2_bits32_red (w1 w2: W64.t):
   w1 = w2 =>
   pack2 [w1 \bits32 0; w2 \bits32 1] = w1.
proof. by move=> ->; apply pack2_bits32. qed.

hint simplify pack2_bits32_red @0.

module Ops = {
  proc itruncate_4u64_2u64(t : t4u64) : t2u64 = {
       return Array2.of_list witness [ t.[0]; t.[1] ];
  }
  proc set_160(vv : t4u64 Array5.t, i : int, o : int, v : W64.t) : t4u64 Array5.t = {
      return vv.[i <- vv.[i].[o <- v]];
  }
  proc get_160(vv : t4u64 Array5.t, i : int, o : int) : W64.t = {
    return vv.[i].[o];
  }
  proc get_128(vv : t4u64 Array4.t, i : int, o : int) : W64.t = {
    return vv.[i].[o];
  }

  proc iVPBROADCAST_4u64(v : W64.t) : t4u64 = {
    var r : t4u64;
    r.[0] <-v;
    r.[1] <-v;
    r.[2] <-v;
    r.[3] <-v;
    return r;
  }
  
  proc iVPMULU_256 (x y:t4u64) : t4u64 = {
    var r : t4u64;
    r.[0] <- mulu64 x.[0] y.[0];
    r.[1] <- mulu64 x.[1] y.[1];
    r.[2] <- mulu64 x.[2] y.[2];
    r.[3] <- mulu64 x.[3] y.[3];
    return r; 
  }

  proc ivadd64u256(x y:t4u64) : t4u64 = {
    var r : t4u64;
    r.[0] <- x.[0] + y.[0];
    r.[1] <- x.[1] + y.[1];
    r.[2] <- x.[2] + y.[2];
    r.[3] <- x.[3] + y.[3];
    return r; 
  }

  proc iload4u64 (mem:global_mem_t, p:W64.t) : t4u64 = {
    var r : t4u64;
    r.[0] <- loadW64 mem (to_uint p);
    r.[1] <- loadW64 mem (to_uint (p + W64.of_int 8));
    r.[2] <- loadW64 mem (to_uint (p + W64.of_int 16));
    r.[3] <- loadW64 mem (to_uint (p + W64.of_int 24));
    return r;
  }

  proc iVPERM2I128(x y:t4u64, p : W8.t) : t4u64 = {
    var r : t4u64;
    r <- witness;
    r.[0] <- 
      let n = 0 in
      if p.[n + 3] then W64.of_int 0
      else 
        let w = if p.[n+1] then y else x in
        if p.[n] then w.[2] else w.[0];
    r.[1] <- 
      let n = 0 in
      if p.[n + 3] then W64.of_int 0
      else 
        let w = if p.[n+1] then y else x in
        if p.[n] then w.[3] else w.[1];
    r.[2] <- 
      let n = 4 in
      if p.[n + 3] then W64.of_int 0
      else 
        let w = if p.[n+1] then y else x in
        if p.[n] then w.[2] else w.[0];
    r.[3] <- 
      let n = 4 in
      if p.[n + 3] then W64.of_int 0
      else 
        let w = if p.[n+1] then y else x in
        if p.[n] then w.[3] else w.[1];
      
    return r;
  }

  proc iVPERMQ(x :t4u64, p : W8.t) : t4u64 = {
    var r : t4u64;
    r <- witness;
    r.[0] <- x.[ (to_uint p      ) %% 4 ];
    r.[1] <- x.[ (to_uint p %/  4) %% 4 ];
    r.[2] <- x.[ (to_uint p %/ 16) %% 4 ];
    r.[3] <- x.[ (to_uint p %/ 64) %% 4 ];
    return r;
  }

  proc iVPSRLDQ_256(x:t4u64, p : W8.t) : t4u64 = {
    var r : t4u64;
    r <- witness;
   
    r.[0] <- 
      if to_uint p = 8 then x.[1]
      else let i = min (to_uint p) 16 in
      if i < 8 then (x.[0] `>>>` 8 * i) `|` (x.[1] `<<<` (64 - 8 * i))
      else x.[1] `>>>` 8 * (i - 8);

    r.[1] <- 
      let i = min (to_uint p) 16 in
      if i < 8 then x.[1] `>>>` 8 * i
      else W64.zero;

    r.[2] <- 
      if to_uint p = 8 then x.[3]
      else let i = min (to_uint p) 16 in
      if i < 8 then (x.[2] `>>>` 8 * i) `|` (x.[3] `<<<` (64 - 8 * i))
      else x.[3] `>>>` 8 * (i - 8);

    r.[3] <- 
      let i = min (to_uint p) 16 in
      if i < 8 then x.[3] `>>>` 8 * i
      else W64.zero;

    return r;
  }

  proc iVPUNPCKH_4u64(x y:t4u64) : t4u64 = {
    var r : t4u64;
    r.[0] <- x.[1];
    r.[1] <- y.[1];
    r.[2] <- x.[3];
    r.[3] <- y.[3];
    return r;
  }

  proc iVPUNPCKL_4u64 (x y:t4u64) : t4u64 = {
    var r : t4u64;
    r.[0] <- x.[0];
    r.[1] <- y.[0];
    r.[2] <- x.[2];
    r.[3] <- y.[2];
    return r;
  }

  proc iVEXTRACTI128(x:t4u64, p : W8.t) : t2u64 = {
    var r : t2u64;
    r <- witness;
    r.[0] <- if p.[0] then x.[2] else x.[0];
    r.[1] <- if p.[0] then x.[3] else x.[1];
    return r;
  }  

  proc iVPEXTR_64(x:t2u64, p : W8.t) : W64.t = {
    return x.[to_uint p]; 
  }  

  proc ivshr64u256 (x: t4u64, y: W8.t) : t4u64 = {
    var r : t4u64;
    r.[0] <- x.[0] `>>` y;
    r.[1] <- x.[1] `>>` y;
    r.[2] <- x.[2] `>>` y;
    r.[3] <- x.[3] `>>` y;
    return r;
  }

  proc ivshl64u256 (x: t4u64, y: W8.t) : t4u64 = {
    var r : t4u64;
    r.[0] <- x.[0] `<<` y;
    r.[1] <- x.[1] `<<` y;
    r.[2] <- x.[2] `<<` y;
    r.[3] <- x.[3] `<<` y;
    return r;
  }


  proc iVPSRLV_4u64 (x: t4u64, y: t4u64) : t4u64 = {
    var r : t4u64;
    r.[0] <- x.[0] `>>>` W64.to_uint y.[0];
    r.[1] <- x.[1] `>>>` W64.to_uint y.[1];
    r.[2] <- x.[2] `>>>` W64.to_uint y.[2];
    r.[3] <- x.[3] `>>>` W64.to_uint y.[3];
    return r;
  }

  proc iVPSLLV_4u64 (x: t4u64, y:  t4u64) : t4u64 = {
    var r : t4u64;
    r.[0] <- x.[0] `<<<` W64.to_uint y.[0];
    r.[1] <- x.[1] `<<<` W64.to_uint y.[1];
    r.[2] <- x.[2] `<<<` W64.to_uint y.[2];
    r.[3] <- x.[3] `<<<` W64.to_uint y.[3];
    return r;
  }

  proc iland4u64  (x y:t4u64) : t4u64 = {
    var r : t4u64;
    r.[0] <- x.[0] `&` y.[0];
    r.[1] <- x.[1] `&` y.[1];
    r.[2] <- x.[2] `&` y.[2];
    r.[3] <- x.[3] `&` y.[3];
    return r;
  }

  proc ilor4u64 (x y:t4u64) : t4u64 = {
    var r : t4u64;
    r.[0] <- x.[0] `|` y.[0];
    r.[1] <- x.[1] `|` y.[1];
    r.[2] <- x.[2] `|` y.[2];
    r.[3] <- x.[3] `|` y.[3];
    return r;
  }

  proc ilandn4u64(x y:t4u64) : t4u64 = {
    var r : t4u64;
    r.[0] <- invw x.[0] `&` y.[0];
    r.[1] <- invw x.[1] `&` y.[1];
    r.[2] <- invw x.[2] `&` y.[2];
    r.[3] <- invw x.[3] `&` y.[3];
    return r; 
  }

  proc ilxor4u64(x y:t4u64) : t4u64 = {
    var r : t4u64;
    r.[0] <- x.[0] `^` y.[0];
    r.[1] <- x.[1] `^` y.[1];
    r.[2] <- x.[2] `^` y.[2];
    r.[3] <- x.[3] `^` y.[3];
    return r; 
  }

  proc iVPBLENDD_256(x y:t4u64, p : W8.t) :  W64.t Array4.t = {
    var r : t4u64;
    r <- witness;
    r.[0] <- 
      if p.[0] = p.[1] then
        let w = if p.[0] then y else x in
        w.[0]
      else
        let w0 = if p.[0] then y else x in
        let w1 = if p.[1] then y else x in
        W2u32.pack2 [w0.[0] \bits32 0; w1.[0] \bits32 1];
    r.[1] <- 
      if p.[2] = p.[3] then
        let w = if p.[2] then y else x in
        w.[1]
      else
        let w0 = if p.[2] then y else x in
        let w1 = if p.[3] then y else x in
        W2u32.pack2 [w0.[1] \bits32 0; w1.[1] \bits32 1];
    r.[2] <- 
      if p.[4] = p.[5] then
        let w = if p.[4] then y else x in
        w.[2]
      else
        let w0 = if p.[4] then y else x in
        let w1 = if p.[5] then y else x in
        W2u32.pack2 [w0.[2] \bits32 0; w1.[2] \bits32 1];
    r.[3] <-
      if p.[6] = p.[7] then
        let w = if p.[6] then y else x in
        w.[3]
      else 
        let w0 = if p.[6] then y else x in
        let w1 = if p.[7] then y else x in
        W2u32.pack2 [w0.[3] \bits32 0; w1.[3] \bits32 1];

    return r;
  }


  proc iVPSHUFD_256 (x :t4u64, p : W8.t) : t4u64 = {
    var r : t4u64;
    r <- witness;
    r.[0] <- 
      let m = W8.to_uint p in
      let p1 = (m %/ (2^(2*0)))%%4 in 
      let p2 = (m %/ (2^(2*1)))%%4 in
      if p1 %/ 2 = p2 %/ 2 /\ p1 %% 2 = 0 /\ p2 %% 2 = 1 then 
        x.[p1 %/ 2] 
      else
        pack2 [x.[p1 %/ 2] \bits32 p1 %% 2; x.[p2 %/ 2] \bits32 p2 %% 2];

    r.[1] <- 
      let m = W8.to_uint p in
      let p1 = (m %/ (2^(2*2)))%%4 in 
      let p2 = (m %/ (2^(2*3)))%%4 in 
      if p1 %/ 2 = p2 %/ 2 /\ p1 %% 2 = 0 /\ p2 %% 2 = 1 then 
        x.[p1 %/ 2] 
      else
        pack2 [x.[p1 %/ 2] \bits32 p1 %% 2; x.[p2 %/ 2] \bits32 p2 %% 2];

    r.[2] <- 
      let m = W8.to_uint p in
      let p1 = (m %/ (2^(2*0)))%%4 in 
      let p2 = (m %/ (2^(2*1)))%%4 in 
      if p1 %/ 2 = p2 %/ 2 /\ p1 %% 2 = 0 /\ p2 %% 2 = 1 then 
        x.[p1 %/ 2 + 2] 
      else
        pack2 [x.[p1 %/ 2 + 2] \bits32 p1 %% 2; x.[p2 %/ 2 + 2] \bits32 p2 %% 2];

    r.[3] <- 
      let m = W8.to_uint p in
      let p1 = (m %/ (2^(2*2)))%%4 in 
      let p2 = (m %/ (2^(2*3)))%%4 in 
      if p1 %/ 2 = p2 %/ 2 /\ p1 %% 2 = 0 /\ p2 %% 2 = 1 then 
        x.[p1 %/ 2 + 2] 
      else
        pack2 [x.[p1 %/ 2 + 2] \bits32 p1 %% 2; x.[p2 %/ 2 + 2] \bits32 p2 %% 2];
    return r;
  }
}.

type vt2u64 = W128.t.
type vt4u64 = W256.t.


module OpsV = {
  proc itruncate_4u64_2u64(t : vt4u64) : vt2u64 = {
       return truncateu128 t;
  }
  proc set_160(vv : vt4u64 Array5.t, i : int, o : int, v : W64.t) : vt4u64 Array5.t = {
    return Array5.init
      (WArray160.get256 (WArray160.set64 (WArray160.init256 (fun i2 => vv.[i2])) (o+4*i) v));
  }
  proc get_160(vv : vt4u64 Array5.t, i : int, o : int) : W64.t = {
    return (get64 (WArray160.init256 (fun i2 => vv.[i2])) (o+4*i));
  }
  proc get_128(vv : vt4u64 Array4.t, i : int, o : int) : W64.t = {
    return (get64 (WArray128.init256 (fun i2 => vv.[i2])) (o+4*i));
  }

  proc iVPBROADCAST_4u64(v : W64.t) : vt4u64 = {
    return x86_VPBROADCAST_4u64 v;
  }

  proc iVPMULU_256 (x y:vt4u64) : vt4u64 = {
    return x86_VPMULU_256 x y; 
  }

  proc ivadd64u256(x y:vt4u64) : vt4u64 = {
    return x86_VPADD_4u64 x y; 
  }

  proc iload4u64 (mem:global_mem_t, p:W64.t) : vt4u64 = {
    return loadW256 mem (to_uint p);  
  }

  proc iVPERM2I128(x y:vt4u64, p : W8.t) : vt4u64 = {
    return x86_VPERM2I128 x y p;
  }

  proc iVPERMQ(x :vt4u64, p : W8.t) : vt4u64 = {
    return x86_VPERMQ x p;
  }

  proc iVPSRLDQ_256(x:vt4u64, p : W8.t) : vt4u64 = {
    return x86_VPSRLDQ_256 x p;
  }

  proc iVPUNPCKH_4u64(x y:vt4u64) : vt4u64 = {
    return x86_VPUNPCKH_4u64 x y;
  }

  proc iVPUNPCKL_4u64 (x y:vt4u64) : vt4u64 = {
    return x86_VPUNPCKL_4u64 x y;
  }

  proc iVEXTRACTI128(x:vt4u64, p : W8.t) : vt2u64 = {
    return x86_VEXTRACTI128 x p;
  }  

  proc iVPEXTR_64(x:vt2u64, p : W8.t) : W64.t = {
    return x86_VPEXTR_64 x p;
  }  


  proc ivshr64u256 (x: vt4u64, y: W8.t) : vt4u64 = {
    return x86_VPSRL_4u64 x y;
  }

  proc ivshl64u256 (x: vt4u64, y: W8.t) : vt4u64 = {
    return x86_VPSLL_4u64 x y;
  }

  proc iVPSRLV_4u64 (x: vt4u64, y: vt4u64) : vt4u64 = {
    return x86_VPSRLV_4u64 x y;
  }

  proc iVPSLLV_4u64 (x: vt4u64, y: vt4u64) : vt4u64 = {
    return x86_VPSLLV_4u64 x y;
  }

  proc iland4u64  (x y: vt4u64) : vt4u64 = {
    return x `&` y;
  }

  proc ilor4u64 (x y: vt4u64) : vt4u64 = {
    return x `|` y;
  }

  proc ilandn4u64(x y: vt4u64) : vt4u64 = {
    return x86_VPANDN_256 x y;
  }

  proc ilxor4u64(x y: vt4u64) : vt4u64 = {
    return x `^` y;
  }

  proc iVPBLENDD_256(x y:vt4u64, p : W8.t) :  vt4u64 = {
    return x86_VPBLENDD_256 x y p;
  }

  proc iVPSHUFD_256 (x :vt4u64, p : W8.t) : vt4u64 = {
    return x86_VPSHUFD_256 x p;
  }

}.

op is2u64 (x : t2u64) (xv: vt2u64)  = xv = W2u64.pack2 [x.[0]; x.[1]].
op is4u64 (x : t4u64) (xv: vt4u64) = xv = W4u64.pack4 [x.[0]; x.[1]; x.[2]; x.[3]].

equiv eq_itruncate_4u64_2u64 : Ops.itruncate_4u64_2u64 ~ OpsV.itruncate_4u64_2u64 : is4u64 t{1} t{2} ==> is2u64 res{1} res{2}.
proof.
  proc; skip => &1 &2; rewrite /is2u64 /is4u64 => -> /=.
  apply (Core.can_inj _ _ W128.to_uintK).
  rewrite to_uint_truncateu128.
  rewrite - (W128.to_uint_small (to_uint (pack4 [t{1}.[0]; t{1}.[1]; t{1}.[2]; t{1}.[3]]) %% W128.modulus)).
  + by apply modz_cmp.
  congr; apply W128.wordP => i hi.
  rewrite W128.of_intwE hi W2u64.pack2wE 1:// /=.
  rewrite /int_bit /= modz_mod.
  have /= -> := modz_pow2_div 128 i; 1:smt().
  rewrite (modz_dvd_pow 1 (128 - i) _ 2) 1:/# /=.
  have -> : (to_uint (pack4 [t{1}.[0]; t{1}.[1]; t{1}.[2]; t{1}.[3]]) %/ (IntExtra.(^) 2 i) %% 2 <> 0) = 
            (pack4 [t{1}.[0]; t{1}.[1]; t{1}.[2]; t{1}.[3]]).[i].
  + rewrite -{2}(W256.to_uintK (pack4 [t{1}.[0]; t{1}.[1]; t{1}.[2]; t{1}.[3]])) W256.of_intwE /int_bit (modz_small _ W256.modulus) 2:/#.
    by have /= := W256.to_uint_cmp  (pack4 [t{1}.[0]; t{1}.[1]; t{1}.[2]; t{1}.[3]]);rewrite /(`|_|).
  rewrite W4u64.pack4wE 1:/#.
  case: (i < 64) => hi'.
  + by rewrite divz_small 1:/#.
  have -> // : i %/ 64 = 1.
  have -> : i = (i -64) + 1 * 64 by done.
  rewrite divzMDr 1://; smt(divz_small).
qed.

op is4u64_5 (x:t4u64 Array5.t) (xv:vt4u64 Array5.t) = 
  xv = Array5.init (fun i => W4u64.pack4 [x.[i].[0]; x.[i].[1]; x.[i].[2]; x.[i].[3]]).

op is4u64_4 (x:t4u64 Array4.t) (xv:vt4u64 Array4.t) = 
  xv = Array4.init (fun i => W4u64.pack4 [x.[i].[0]; x.[i].[1]; x.[i].[2]; x.[i].[3]]).

lemma get8_pack4u64 ws j: 
  W4u64.pack4_t ws \bits8 j = 
    if 0 <= j < 32 then ws.[j %/ 8] \bits8 (j %% 8) else W8.zero.
proof.
  rewrite pack4E W8.wordP => i hi.
  rewrite bits8E /= initE hi /= initE.
  have -> /= : (0 <= j * 8 + i < 256) <=> (0 <= j < 32) by smt().
  case : (0 <= j < 32) => hj //=.
  rewrite bits8E /= initE.
  have -> : (j * 8 + i) %/ 64 = j %/ 8.
  + rewrite {1}(divz_eq j 8) mulzDl mulzA /= -addzA divzMDl //.
    by rewrite (divz_small _ 64) //; smt (modz_cmp).
  rewrite hi /=;congr.
  rewrite {1}(divz_eq j 8) mulzDl mulzA /= -addzA modzMDl modz_small //; smt (modz_cmp).
qed.

lemma Array5_get_set_eq (t:'a Array5.t) i a: 0 <= i < 5 => t.[i <- a].[i] = a.
proof. by move=> hi;rewrite Array5.get_setE. qed.

equiv eq_set_160 : Ops.set_160 ~ OpsV.set_160 : is4u64_5 vv{1} vv{2} /\ ={i,o,v} /\ 0 <= i{1} < 5 /\ 0 <= o{1} < 4 ==> is4u64_5 res{1} res{2}.
proof.
  proc; skip; rewrite /is4u64_5 => /> &1 &2 h1 h2 h3 h4.
  apply Array5.tP => k hk.
  rewrite !Array5.initiE 1,2:// /=.
  rewrite /init256 set64E get256E -(W32u8.unpack8K (W4u64.pack4 _)); congr.
  apply W32u8.Pack.packP => j hj.
  rewrite W32u8.Pack.initiE 1:// get_unpack8 1:// /= WArray160.initiE 1:/# /=.
  rewrite WArray160.initiE 1:/# /=.
  rewrite (mulzC 32) modzMDl divzMDl 1:// divz_small 1:// modz_small 1:// /= Array5.initiE 1:// /=.
  rewrite !get8_pack4u64 hj /=.
  have /= <- := W4u64.Pack.init_of_list (fun i => vv{1}.[k].[i]).
  have /= <- := W4u64.Pack.init_of_list (fun j => vv{1}.[i{2} <- vv{1}.[i{2}].[o{2} <- v{2}]].[k].[j]).
  have ? : 0 <= j %/ 8 < 4 by rewrite ltz_divLR // lez_divRL.
  rewrite !W4u64.Pack.initiE 1,2:// /=.
  rewrite Array5.get_setE 1://.  
  case: (k = i{2}) => [->> | /#].
  rewrite Array4.get_setE 1://;smt(edivzP).
qed.

equiv eq_get_160 : Ops.get_160 ~ OpsV.get_160 : is4u64_5 vv{1} vv{2} /\ ={i,o} /\ 0 <= i{1} < 5 /\ 0 <= o{1} < 4 ==> ={res}.
proof.
  proc;skip;rewrite /is4u64_5 => /> &1 &2 h1 h2 h3 h4.
  rewrite /init256 get64E -(W8u8.unpack8K vv{1}.[i{2}].[o{2}]);congr.
  apply W8u8.Pack.packP => j hj.
  rewrite W8u8.Pack.initiE 1:// initiE 1:// /= initiE 1:/# /=.
  have -> : (8 * (o{2} + 4 * i{2}) + j) = (o{2} * 8 + j) + i{2} * 32 by ring.
  have ? : 0 <= o{2} * 8 + j < `|32| by smt().
  rewrite modzMDr divzMDr 1:// divz_small 1:// modz_small 1:// /=.
  rewrite Array5.initiE 1:// /= get8_pack4u64.
  have /= <- := W4u64.Pack.init_of_list (fun j => vv{1}.[i{2}].[j]).
  rewrite divzMDl 1:// divz_small 1:// modzMDl /= initiE 1:// modz_small 1:// /#.
qed.

equiv eq_get_128 : Ops.get_128 ~ OpsV.get_128 : is4u64_4 vv{1} vv{2} /\ ={i,o} /\ 0 <= i{1} < 4 /\ 0 <= o{1} < 4 ==> ={res}.
proof.
  proc;skip;rewrite /is4u64_4 => /> &1 &2 h1 h2 h3 h4.
  rewrite /init256 get64E -(W8u8.unpack8K vv{1}.[i{2}].[o{2}]);congr.
  apply W8u8.Pack.packP => j hj.
  rewrite W8u8.Pack.initiE 1:// initiE 1:// /= initiE 1:/# /=.
  have -> : (8 * (o{2} + 4 * i{2}) + j) = (o{2} * 8 + j) + i{2} * 32 by ring.
  have ? : 0 <= o{2} * 8 + j < `|32| by smt().
  rewrite modzMDr divzMDr 1:// divz_small 1:// modz_small 1:// /=.
  rewrite Array4.initiE 1:// /= get8_pack4u64.
  have /= <- := W4u64.Pack.init_of_list (fun j => vv{1}.[i{2}].[j]).
  rewrite divzMDl 1:// divz_small 1:// modzMDl /= initiE 1:// modz_small 1:// /#.
qed.

equiv eq_iVPBROADCAST_4u64 : Ops.iVPBROADCAST_4u64 ~ OpsV.iVPBROADCAST_4u64 : ={v} ==> is4u64 res{1} res{2}.
proof. by proc => /=;wp;skip;rewrite /is4u64. qed.

equiv eq_iVPMULU_256 : Ops.iVPMULU_256 ~ OpsV.iVPMULU_256 : is4u64 x{1} x{2} /\ is4u64 y{1} y{2} ==> is4u64 res{1} res{2}.
proof. by proc;wp;skip;rewrite /is4u64 => /> &1; rewrite /x86_VPMULU_256. qed.

equiv eq_ivadd64u256: Ops.ivadd64u256 ~ OpsV.ivadd64u256 : is4u64 x{1} x{2} /\ is4u64 y{1} y{2} ==> is4u64 res{1} res{2}.
proof. by proc;wp;skip;rewrite /is4u64 /x86_VPADD_4u64. qed.

equiv eq_iload4u64: Ops.iload4u64 ~ OpsV.iload4u64 : ={mem, p} /\ to_uint p{1} + 32 <= W64.modulus ==> is4u64 res{1} res{2}.
proof. 
  proc; wp; skip; rewrite /is4u64 => /> &2 hp.
  rewrite /loadW256 -(W32u8.unpack8K (W4u64.pack4 _));congr.
  apply W32u8.Pack.packP => j hj. 
  rewrite initiE 1:// W32u8.get_unpack8 1:// /= get8_pack4u64 hj /=.
  have /= <- := W4u64.Pack.init_of_list (fun j => loadW64 mem{2} (to_uint (p{2} + W64.of_int (8 * j)))).
  have ? : 0 <= j %/ 8 < 4 by rewrite ltz_divLR // lez_divRL.
  have ? := modz_cmp j 8.
  rewrite initiE 1:// /loadW64 /= pack8bE 1:// initiE 1:// /=. 
  have heq : to_uint (W64.of_int (8 * (j %/ 8))) = 8 * (j %/ 8).
  + by rewrite of_uintK modz_small 2:// /= /#.
  rewrite to_uintD_small heq 1:/#; smt (edivzP).
qed.

equiv eq_iVPERM2I128 : Ops.iVPERM2I128 ~ OpsV.iVPERM2I128 : 
  is4u64 x{1} x{2} /\ is4u64 y{1} y{2} /\ ={p} ==> is4u64 res{1} res{2}.
proof. 
  proc; wp; skip; rewrite /is4u64 => /> &1 &2; cbv delta.
  rewrite -(W8.to_uintK' p{2}) !of_intwE /=.
  apply W2u128.allP => /=.
  case: (W8.int_bit (to_uint p{2}) 3) => ?.
  + split; 1: by apply W2u64.allP; cbv delta.
    case: (W8.int_bit (to_uint p{2}) 7) => ?; 1: by apply W2u64.allP; cbv delta.
    by case: (W8.int_bit (to_uint p{2}) 5) => ?; case: (W8.int_bit (to_uint p{2}) 4).
  split.
  + by case: (W8.int_bit (to_uint p{2}) 1) => ?; case: (W8.int_bit (to_uint p{2}) 0). 
  case: (W8.int_bit (to_uint p{2}) 7) => ?;  1: by apply W2u64.allP; cbv delta.
  by case: (W8.int_bit (to_uint p{2}) 5) => ?; case: (W8.int_bit (to_uint p{2}) 4).
qed.

lemma pack4_bits64 (x:t4u64) (i:int): 0 <= i < 4 =>
    pack4 [x.[0]; x.[1]; x.[2]; x.[3]] \bits64 i = x.[i].
proof. by have /= <- [#|] -> := mema_iota 0 4. qed.

equiv eq_iVPERMQ : Ops.iVPERMQ ~ OpsV.iVPERMQ : is4u64 x{1} x{2} /\ ={p} ==> is4u64 res{1} res{2}.
proof. 
  proc; wp; skip; rewrite /is4u64 => /> &1 &2.
  by rewrite /x86_VPERMQ /= !pack4_bits64 ?modz_cmp.
qed.

lemma lsr_2u64 (w1 w2:W64.t) (x:int) : 0 <= x <= 64 => 
  pack2 [w1; w2] `>>>` x = pack2 [(w1 `>>>` x) `|` (w2 `<<<` 64 - x); w2 `>>>` x].
proof.
  move=> hx;apply W128.wordP => i hi.
  rewrite pack2wE 1://.
  rewrite W128.shrwE hi /=.
  case: (i < 64) => hi1.
  + have [-> ->] /=: i %/ 64 = 0 /\ i %% 64 = i by smt(edivzP). 
    rewrite pack2wE 1:/#.
    have -> : 0 <= i < 64 by smt().
    case: (i + x < 64) => hix.
    + have [-> ->] /= : (i + x) %/ 64 = 0 /\ (i + x) %% 64 = i + x by smt(edivzP).
      by rewrite (W64.get_out w2) 1:/#.
    have [-> ->] /= : (i + x) %/ 64 = 1 /\ (i + x) %% 64 = i - (64 - x) by smt(edivzP).
    by rewrite (W64.get_out w1) 1:/#.
  have [-> ->] /= : i %/ 64 = 1 /\ i %% 64 = i - 64 by smt(edivzP). 
  case (i + x < 128) => hix;last by rewrite W128.get_out 1:/# W64.get_out 1:/#.  
  rewrite pack2wE 1:/#.
  have -> /= : 0 <= i - 64 < 64 by smt().
  by have [-> ->] : (i + x) %/ 64 = 1 /\ (i + x) %% 64 = i - 64 + x by smt(edivzP).
qed.

lemma lsr_2u64_64 (w1 w2:W64.t) (x:int) : 64 <= x <= 128 => 
  pack2 [w1; w2] `>>>` x = pack2 [(w2 `>>>` (x - 64)); W64.zero].
proof.
  move=> hx;apply W128.wordP => i hi.
  rewrite pack2wE 1://.
  rewrite W128.shrwE hi /=.
  case: (i < 64) => hi1.
  + have [-> ->] /=: i %/ 64 = 0 /\ i %% 64 = i by smt(edivzP).
    case: (i + x < 128) => ?.
    + rewrite pack2wE 1:/#.
      by have -> /= /# : (i + x) %/ 64 = 1 by smt().
    by rewrite W128.get_out 1:/# W64.get_out 1:/#.
  have [-> ->] /= : i %/ 64 = 1 /\ i %% 64 = i - 64 by smt(edivzP). 
  by rewrite W128.get_out 1:/#.
qed.

lemma lsr_0 (w:W64.t) : w `<<<` 0 = w.
proof. by apply W64.wordP => i hi; rewrite W64.shlwE hi. qed.

equiv eq_iVPSRLDQ_256: Ops.iVPSRLDQ_256 ~ OpsV.iVPSRLDQ_256 : 
  is4u64 x{1} x{2} /\ ={p} ==> is4u64 res{1} res{2}.
proof. 
  proc; wp; skip; rewrite /is4u64 => /> &1 &2; cbv delta.
  case: (to_uint p{2} = 8) => [-> | ?] /=.
  + by rewrite !lsr_2u64 //= !lsr_0.
  pose i := if to_uint p{2} < 16 then to_uint p{2} else 16.
  case: (i < 8) => ?.
  + rewrite !lsr_2u64 //=; smt (W8.to_uint_cmp).
  by rewrite !lsr_2u64_64 1,2:/# /= /#.
qed.

equiv eq_iVPUNPCKH_4u64: Ops.iVPUNPCKH_4u64 ~ OpsV.iVPUNPCKH_4u64 : is4u64 x{1} x{2} /\ is4u64 y{1} y{2} ==> is4u64 res{1} res{2}.
proof. by proc; wp; skip; rewrite /is4u64 => />; cbv delta. qed.

equiv eq_iVPUNPCKL_4u64: Ops.iVPUNPCKL_4u64 ~ OpsV.iVPUNPCKL_4u64 : is4u64 x{1} x{2} /\ is4u64 y{1} y{2} ==> is4u64 res{1} res{2}.
proof. by proc; wp; skip; rewrite /is4u64 => />; cbv delta. qed.

equiv eq_iVEXTRACTI128: Ops.iVEXTRACTI128 ~ OpsV.iVEXTRACTI128 : 
  is4u64 x{1} x{2} /\ ={p} ==> is2u64 res{1} res{2}.
proof.
  proc; wp; skip;rewrite /is4u64 /is2u64 /x86_VEXTRACTI128 => /> &1 &2.
  by case: (p{2}.[0]) => ?; cbv delta.
qed.
 
equiv eq_iVPEXTR_64: Ops.iVPEXTR_64 ~ OpsV.iVPEXTR_64 : is2u64 x{1} x{2} /\ ={p} /\ (p{1} = W8.of_int 0 \/ p{2} = W8.of_int 1)==> res{1} = res{2}.
proof. by proc; skip; rewrite /is2u64 /x86_VPEXTR_64 => /> &1 &2 [] -> /=. qed.

equiv eq_ivshr64u256: Ops.ivshr64u256 ~ OpsV.ivshr64u256 : is4u64 x{1} x{2} /\ ={y} ==> is4u64 res{1} res{2}.
proof. by proc; wp; skip; rewrite /is4u64 /x86_VPSRL_4u64. qed.

equiv eq_ivshl64u256: Ops.ivshl64u256 ~ OpsV.ivshl64u256 : is4u64 x{1} x{2} /\ ={y} ==> is4u64 res{1} res{2}.
proof. by proc; wp; skip; rewrite /is4u64 /x86_VPSLL_4u64. qed.

equiv eq_iland4u64: Ops.iland4u64 ~ OpsV.iland4u64 : is4u64 x{1} x{2} /\ is4u64 y{1} y{2} ==> is4u64 res{1} res{2}.
proof. by proc; wp; skip; rewrite /is4u64. qed.

equiv eq_ilor4u64: Ops.ilor4u64 ~ OpsV.ilor4u64 : is4u64 x{1} x{2} /\ is4u64 y{1} y{2} ==> is4u64 res{1} res{2}.
proof. by proc; wp; skip; rewrite /is4u64. qed.

equiv eq_ilandn4u64 : Ops.ilandn4u64 ~ OpsV.ilandn4u64 : is4u64 x{1} x{2} /\ is4u64 y{1} y{2} ==> is4u64 res{1} res{2}.
proof. by proc; wp; skip; rewrite /is4u64 => />; cbv delta. qed.

equiv eq_ilxor4u64: Ops.ilxor4u64 ~ OpsV.ilxor4u64 : is4u64 x{1} x{2} /\ is4u64 y{1} y{2} ==> is4u64 res{1} res{2}.
proof. by proc; wp; skip; rewrite /is4u64. qed.

equiv eq_iVPSRLV_4u64 : Ops.iVPSRLV_4u64 ~ OpsV.iVPSRLV_4u64 : is4u64 x{1} x{2} /\ is4u64 y{1} y{2} ==> is4u64 res{1} res{2}.
proof. by proc;wp; skip; rewrite /is4u64 => />; cbv delta. qed.

equiv eq_iVPSLLV_4u64 : Ops.iVPSLLV_4u64 ~ OpsV.iVPSLLV_4u64 : is4u64 x{1} x{2} /\ is4u64 y{1} y{2} ==> is4u64 res{1} res{2}.
proof. by proc;wp; skip; rewrite /is4u64 => />; cbv delta. qed.

equiv eq_iVPBLENDD_256 : Ops.iVPBLENDD_256 ~ OpsV.iVPBLENDD_256 : 
  is4u64 x{1} x{2} /\ is4u64 y{1} y{2} /\ ={p}
  ==> 
  is4u64 res{1} res{2}.
proof. 
  proc; wp; skip; rewrite /is4u64 /x86_VPBLENDD_256 => /> &1 &2 /=.
  apply W8u32.allP => /=.
  split; 1: by case: (p{2}.[0] = p{2}.[1]); case: (p{2}.[0]).
  split; 1: by case: (p{2}.[0] = p{2}.[1]) => [->|]; case: (p{2}.[1]).
  split; 1: by case: (p{2}.[2] = p{2}.[3]); case: (p{2}.[2]).
  split; 1: by case: (p{2}.[2] = p{2}.[3]) => [->|];case: (p{2}.[3]).
  split; 1: by case: ( p{2}.[4] = p{2}.[5]); case: (p{2}.[4]).
  split; 1: by case: ( p{2}.[4] = p{2}.[5]) => [->|]; case: (p{2}.[5]).
  split; 1: by case: (p{2}.[6] = p{2}.[7]); case: (p{2}.[6]).
  by case: (p{2}.[6] = p{2}.[7]) => [->|]; case: (p{2}.[7]).
qed.

equiv eq_iVPSHUFD_256 : Ops.iVPSHUFD_256 ~ OpsV.iVPSHUFD_256 : 
  is4u64 x{1} x{2} /\ ={p} ==> is4u64 res{1} res{2}.
proof. 
  proc; wp; skip; rewrite /is4u64 => /> &1 &2; apply W8u32.allP; cbv delta.
  have heq0 : forall (w: t4u64) i, 0 <= i < 2 => (W2u64.Pack.of_list [w.[0]; w.[1]]).[i] = w.[i].
  + by move=> w i /(mema_iota 0 2) /= [#|] -> /=.
  have heq1 : forall (w: t4u64) i, 0 <= i < 2 => (W2u64.Pack.of_list [w.[2]; w.[3]]).[i] = w.[i+2].
  + by move=> w i /(mema_iota 0 2) /= [#|] -> /=.
  have hmod : forall x, 0 <= x %%4 %/2 < 2 by smt().
  do !(rewrite bits32_W2u64_red 1:modz_cmp 1:// heq0 1:hmod /=).
  do !(rewrite bits32_W2u64_red 1:modz_cmp 1:// heq1 1:hmod /=).
  split.
  + by case: (to_uint p{2} %% 4 %/ 2 = to_uint p{2} %/ 4 %% 4 %/ 2 /\
         to_uint p{2} %% 4 %% 2 = 0 /\ to_uint p{2} %/ 4 %% 4 %% 2 = 1) => [ [# -> ->] |].
  split.
  + by case: (to_uint p{2} %% 4 %/ 2 = to_uint p{2} %/ 4 %% 4 %/ 2 /\
         to_uint p{2} %% 4 %% 2 = 0 /\ to_uint p{2} %/ 4 %% 4 %% 2 = 1) => [ [# -> _ ->] |].
  split.
  + by case: (to_uint p{2} %/ 16 %% 4 %/ 2 = to_uint p{2} %/ 64 %% 4 %/ 2 /\
         to_uint p{2} %/ 16 %% 4 %% 2 = 0 /\ to_uint p{2} %/ 64 %% 4 %% 2 = 1) => [[# -> ->] |].
  split.
  + by case: (to_uint p{2} %/ 16 %% 4 %/ 2 = to_uint p{2} %/ 64 %% 4 %/ 2 /\
         to_uint p{2} %/ 16 %% 4 %% 2 = 0 /\ to_uint p{2} %/ 64 %% 4 %% 2 = 1) => [[# -> _ ->] |]. 
  split.
  + by case: (to_uint p{2} %% 4 %/ 2 = to_uint p{2} %/ 4 %% 4 %/ 2 /\
         to_uint p{2} %% 4 %% 2 = 0 /\ to_uint p{2} %/ 4 %% 4 %% 2 = 1) => [[# -> ->]|].
  split.
  + by case: (to_uint p{2} %% 4 %/ 2 = to_uint p{2} %/ 4 %% 4 %/ 2 /\
         to_uint p{2} %% 4 %% 2 = 0 /\ to_uint p{2} %/ 4 %% 4 %% 2 = 1) => [[# -> _ ->]|].
  split.
  + by case: (to_uint p{2} %/ 16 %% 4 %/ 2 = to_uint p{2} %/ 64 %% 4 %/ 2 /\
         to_uint p{2} %/ 16 %% 4 %% 2 = 0 /\ to_uint p{2} %/ 64 %% 4 %% 2 = 1) => [[# -> ->]|].
  by case: (to_uint p{2} %/ 16 %% 4 %/ 2 = to_uint p{2} %/ 64 %% 4 %/ 2 /\
       to_uint p{2} %/ 16 %% 4 %% 2 = 0 /\ to_uint p{2} %/ 64 %% 4 %% 2 = 1) => [[# -> _ ->]|].
qed.

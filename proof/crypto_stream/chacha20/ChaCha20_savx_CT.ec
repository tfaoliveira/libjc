require import List Int IntExtra IntDiv CoreMap.
require import Array2 Array4 Array8 Array16.
require import WArray32 WArray64 WArray128 WArray256.

from Jasmin require import JModel.

abbrev g_sigma3 = W128.of_int 142395606795449994141864265039627707764.


abbrev g_sigma2 = W128.of_int 161346349289517898123623123153137577266.


abbrev g_sigma1 = W128.of_int 67958818256384961134917122602578240622.


abbrev g_sigma0 = W128.of_int 129519094760645606705801321186012985445.


abbrev g_sigma = W128.of_int 142395606799862307709414285570774956133.


abbrev g_p1 = W128.of_int 1.


abbrev g_p0 = W128.of_int 0.


abbrev g_cnt_inc = W128.of_int 316912650130844326686193876996.


abbrev g_cnt = W128.of_int 237684487579686500932345921536.


abbrev g_r8 = W128.of_int 18676936380593224926704134051422339075.


abbrev g_r16 = W128.of_int 17342576855639742879858139805557719810.


module M = {
  var leakages : leakages_t
  
  proc load_shufb_cmd () : W128.t * W128.t = {
    var aux: W128.t;
    
    var s_r16:W128.t;
    var s_r8:W128.t;
    var r16:W128.t;
    var r8:W128.t;
    
    leakages <- LeakAddr([]) :: leakages;
    aux <- g_r16;
    r16 <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- g_r8;
    r8 <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- r16;
    s_r16 <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- r8;
    s_r8 <- aux;
    return (s_r16, s_r8);
  }
  
  proc init_x1 (key:W64.t, nonce:W64.t, counter:W32.t) : W128.t Array4.t = {
    var aux: W128.t;
    
    var st:W128.t Array4.t;
    st <- witness;
    leakages <- LeakAddr([]) :: leakages;
    aux <- g_sigma;
    leakages <- LeakAddr([0]) :: leakages;
    st.[0] <- aux;
    leakages <- LeakAddr([(W64.to_uint (key + (W64.of_int 0)))]) :: leakages;
    aux <- (loadW128 Glob.mem (W64.to_uint (key + (W64.of_int 0))));
    leakages <- LeakAddr([1]) :: leakages;
    st.[1] <- aux;
    leakages <- LeakAddr([(W64.to_uint (key + (W64.of_int 16)))]) :: leakages;
    aux <- (loadW128 Glob.mem (W64.to_uint (key + (W64.of_int 16))));
    leakages <- LeakAddr([2]) :: leakages;
    st.[2] <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- g_p0;
    leakages <- LeakAddr([3]) :: leakages;
    st.[3] <- aux;
    leakages <- LeakAddr([3]) :: leakages;
    aux <- x86_VPINSR_4u32 st.[3] counter (W8.of_int 0);
    leakages <- LeakAddr([3]) :: leakages;
    st.[3] <- aux;
    leakages <- LeakAddr([(W64.to_uint (nonce + (W64.of_int 0))); 3]) :: leakages;
    aux <- x86_VPINSR_4u32 st.[3]
    (loadW32 Glob.mem (W64.to_uint (nonce + (W64.of_int 0)))) (W8.of_int 1);
    leakages <- LeakAddr([3]) :: leakages;
    st.[3] <- aux;
    leakages <- LeakAddr([(W64.to_uint (nonce + (W64.of_int 4))); 3]) :: leakages;
    aux <- x86_VPINSR_2u64 st.[3]
    (loadW64 Glob.mem (W64.to_uint (nonce + (W64.of_int 4)))) (W8.of_int 1);
    leakages <- LeakAddr([3]) :: leakages;
    st.[3] <- aux;
    return (st);
  }
  
  proc init_x4 (k:W64.t, n1:W64.t, ctr:W32.t) : W128.t Array16.t = {
    var aux_1: int;
    var aux: W32.t;
    var aux_0: W128.t;
    var aux_2: W128.t Array16.t;
    
    var st:W128.t Array16.t;
    var s_ctr:W32.t;
    var s:W128.t Array16.t;
    var i:int;
    s <- witness;
    st <- witness;
    leakages <- LeakAddr([]) :: leakages;
    aux <- ctr;
    s_ctr <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <- g_sigma0;
    leakages <- LeakAddr([0]) :: leakages;
    s.[0] <- aux_0;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <- g_sigma1;
    leakages <- LeakAddr([1]) :: leakages;
    s.[1] <- aux_0;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <- g_sigma2;
    leakages <- LeakAddr([2]) :: leakages;
    s.[2] <- aux_0;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <- g_sigma3;
    leakages <- LeakAddr([3]) :: leakages;
    s.[3] <- aux_0;
    leakages <- LeakFor(0,8) :: LeakAddr([]) :: leakages;
    i <- 0;
    while (i < 8) {
      leakages <- LeakAddr([(W64.to_uint (k + (W64.of_int (4 * i))))]) :: leakages;
      aux_0 <- x86_VPBROADCAST_4u32 (loadW32 Glob.mem (W64.to_uint (k + (W64.of_int (4 * i)))));
      leakages <- LeakAddr([(4 + i)]) :: leakages;
      s.[(4 + i)] <- aux_0;
      i <- i + 1;
    }
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <- x86_VPBROADCAST_4u32 s_ctr;
    leakages <- LeakAddr([12]) :: leakages;
    s.[12] <- aux_0;
    leakages <- LeakAddr([12]) :: leakages;
    aux_0 <- (s.[12] \vadd32u128 g_cnt);
    leakages <- LeakAddr([12]) :: leakages;
    s.[12] <- aux_0;
    leakages <- LeakFor(0,3) :: LeakAddr([]) :: leakages;
    i <- 0;
    while (i < 3) {
      leakages <- LeakAddr([(W64.to_uint (n1 + (W64.of_int (4 * i))))]) :: leakages;
      aux_0 <- x86_VPBROADCAST_4u32 (loadW32 Glob.mem (W64.to_uint (n1 + (W64.of_int (4 * i)))));
      leakages <- LeakAddr([(13 + i)]) :: leakages;
      s.[(13 + i)] <- aux_0;
      i <- i + 1;
    }
    leakages <- LeakAddr([]) :: leakages;
    aux_2 <- s;
    st <- aux_2;
    return (st);
  }
  
  proc copy_state_x1 (st:W128.t Array4.t) : W128.t Array4.t = {
    var aux: W128.t Array4.t;
    
    var k:W128.t Array4.t;
    k <- witness;
    leakages <- LeakAddr([]) :: leakages;
    aux <- st;
    k <- aux;
    return (k);
  }
  
  proc copy_state_x2 (st:W128.t Array4.t) : W128.t Array4.t * W128.t Array4.t = {
    var aux_0: W128.t;
    var aux: W128.t Array4.t;
    
    var k1:W128.t Array4.t;
    var k2:W128.t Array4.t;
    k1 <- witness;
    k2 <- witness;
    leakages <- LeakAddr([]) :: leakages;
    aux <- st;
    k1 <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- st;
    k2 <- aux;
    leakages <- LeakAddr([3]) :: leakages;
    aux_0 <- (k2.[3] \vadd32u128 g_p1);
    leakages <- LeakAddr([3]) :: leakages;
    k2.[3] <- aux_0;
    return (k1, k2);
  }
  
  proc copy_state_x4 (st:W128.t Array16.t) : W128.t Array16.t = {
    var aux: W128.t Array16.t;
    
    var k:W128.t Array16.t;
    k <- witness;
    leakages <- LeakAddr([]) :: leakages;
    aux <- st;
    k <- aux;
    return (k);
  }
  
  proc sum_states_x1 (k:W128.t Array4.t, st:W128.t Array4.t) : W128.t Array4.t = {
    var aux: int;
    var aux_0: W128.t;
    
    var i:int;
    
    leakages <- LeakFor(0,4) :: LeakAddr([]) :: leakages;
    i <- 0;
    while (i < 4) {
      leakages <- LeakAddr([i; i]) :: leakages;
      aux_0 <- (k.[i] \vadd32u128 st.[i]);
      leakages <- LeakAddr([i]) :: leakages;
      k.[i] <- aux_0;
      i <- i + 1;
    }
    return (k);
  }
  
  proc sum_states_x2 (k1:W128.t Array4.t, k2:W128.t Array4.t,
                      st:W128.t Array4.t) : W128.t Array4.t * W128.t Array4.t = {
    var aux_0: W128.t;
    var aux: W128.t Array4.t;
    
    
    
    leakages <- LeakAddr([]) :: leakages;
    aux <@ sum_states_x1 (k1, st);
    k1 <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <@ sum_states_x1 (k2, st);
    k2 <- aux;
    leakages <- LeakAddr([3]) :: leakages;
    aux_0 <- (k2.[3] \vadd32u128 g_p1);
    leakages <- LeakAddr([3]) :: leakages;
    k2.[3] <- aux_0;
    return (k1, k2);
  }
  
  proc sum_states_x4 (k:W128.t Array16.t, st:W128.t Array16.t) : W128.t Array16.t = {
    var aux: int;
    var aux_0: W128.t;
    
    var i:int;
    
    leakages <- LeakFor(0,16) :: LeakAddr([]) :: leakages;
    i <- 0;
    while (i < 16) {
      leakages <- LeakAddr([i; i]) :: leakages;
      aux_0 <- (k.[i] \vadd32u128 st.[i]);
      leakages <- LeakAddr([i]) :: leakages;
      k.[i] <- aux_0;
      i <- i + 1;
    }
    return (k);
  }
  
  proc sub_rotate (t:W128.t Array8.t) : W128.t Array8.t = {
    var aux: W128.t;
    
    var x:W128.t Array8.t;
    x <- witness;
    leakages <- LeakAddr([1; 0]) :: leakages;
    aux <- x86_VPUNPCKL_2u64 t.[0] t.[1];
    leakages <- LeakAddr([0]) :: leakages;
    x.[0] <- aux;
    leakages <- LeakAddr([3; 2]) :: leakages;
    aux <- x86_VPUNPCKL_2u64 t.[2] t.[3];
    leakages <- LeakAddr([1]) :: leakages;
    x.[1] <- aux;
    leakages <- LeakAddr([1; 0]) :: leakages;
    aux <- x86_VPUNPCKH_2u64 t.[0] t.[1];
    leakages <- LeakAddr([2]) :: leakages;
    x.[2] <- aux;
    leakages <- LeakAddr([3; 2]) :: leakages;
    aux <- x86_VPUNPCKH_2u64 t.[2] t.[3];
    leakages <- LeakAddr([3]) :: leakages;
    x.[3] <- aux;
    leakages <- LeakAddr([5; 4]) :: leakages;
    aux <- x86_VPUNPCKL_2u64 t.[4] t.[5];
    leakages <- LeakAddr([4]) :: leakages;
    x.[4] <- aux;
    leakages <- LeakAddr([7; 6]) :: leakages;
    aux <- x86_VPUNPCKL_2u64 t.[6] t.[7];
    leakages <- LeakAddr([5]) :: leakages;
    x.[5] <- aux;
    leakages <- LeakAddr([5; 4]) :: leakages;
    aux <- x86_VPUNPCKH_2u64 t.[4] t.[5];
    leakages <- LeakAddr([6]) :: leakages;
    x.[6] <- aux;
    leakages <- LeakAddr([7; 6]) :: leakages;
    aux <- x86_VPUNPCKH_2u64 t.[6] t.[7];
    leakages <- LeakAddr([7]) :: leakages;
    x.[7] <- aux;
    return (x);
  }
  
  proc rotate (x:W128.t Array8.t) : W128.t Array8.t = {
    var aux: int;
    var aux_0: W128.t;
    var aux_1: W128.t Array8.t;
    
    var i:int;
    var t:W128.t Array8.t;
    t <- witness;
    leakages <- LeakFor(0,4) :: LeakAddr([]) :: leakages;
    i <- 0;
    while (i < 4) {
      leakages <- LeakAddr([((2 * i) + 1); ((2 * i) + 0)]) :: leakages;
      aux_0 <- x86_VPUNPCKL_4u32 x.[((2 * i) + 0)] x.[((2 * i) + 1)];
      leakages <- LeakAddr([i]) :: leakages;
      t.[i] <- aux_0;
      leakages <- LeakAddr([((2 * i) + 1); ((2 * i) + 0)]) :: leakages;
      aux_0 <- x86_VPUNPCKH_4u32 x.[((2 * i) + 0)] x.[((2 * i) + 1)];
      leakages <- LeakAddr([(4 + i)]) :: leakages;
      t.[(4 + i)] <- aux_0;
      i <- i + 1;
    }
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <@ sub_rotate (t);
    x <- aux_1;
    return (x);
  }
  
  proc rotate_stack (s:W128.t Array8.t) : W128.t Array8.t = {
    var aux: int;
    var aux_0: W128.t;
    var aux_1: W128.t Array8.t;
    
    var x:W128.t Array8.t;
    var i:int;
    var t:W128.t Array8.t;
    t <- witness;
    x <- witness;
    leakages <- LeakFor(0,4) :: LeakAddr([]) :: leakages;
    i <- 0;
    while (i < 4) {
      leakages <- LeakAddr([((2 * i) + 0)]) :: leakages;
      aux_0 <- s.[((2 * i) + 0)];
      leakages <- LeakAddr([i]) :: leakages;
      x.[i] <- aux_0;
      i <- i + 1;
    }
    leakages <- LeakFor(0,4) :: LeakAddr([]) :: leakages;
    i <- 0;
    while (i < 4) {
      leakages <- LeakAddr([((2 * i) + 1); i]) :: leakages;
      aux_0 <- x86_VPUNPCKL_4u32 x.[i] s.[((2 * i) + 1)];
      leakages <- LeakAddr([i]) :: leakages;
      t.[i] <- aux_0;
      leakages <- LeakAddr([((2 * i) + 1); i]) :: leakages;
      aux_0 <- x86_VPUNPCKH_4u32 x.[i] s.[((2 * i) + 1)];
      leakages <- LeakAddr([(4 + i)]) :: leakages;
      t.[(4 + i)] <- aux_0;
      i <- i + 1;
    }
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <@ sub_rotate (t);
    x <- aux_1;
    return (x);
  }
  
  proc rotate_first_half_x8 (k:W128.t Array16.t) : W128.t Array8.t *
                                                   W128.t Array8.t = {
    var aux: int;
    var aux_0: W128.t;
    var aux_1: W128.t Array8.t;
    
    var k0_7:W128.t Array8.t;
    var s_k8_15:W128.t Array8.t;
    var i:int;
    k0_7 <- witness;
    s_k8_15 <- witness;
    leakages <- LeakFor(0,8) :: LeakAddr([]) :: leakages;
    i <- 0;
    while (i < 8) {
      leakages <- LeakAddr([(8 + i)]) :: leakages;
      aux_0 <- k.[(8 + i)];
      leakages <- LeakAddr([i]) :: leakages;
      s_k8_15.[i] <- aux_0;
      i <- i + 1;
    }
    leakages <- LeakFor(0,8) :: LeakAddr([]) :: leakages;
    i <- 0;
    while (i < 8) {
      leakages <- LeakAddr([i]) :: leakages;
      aux_0 <- k.[i];
      leakages <- LeakAddr([i]) :: leakages;
      k0_7.[i] <- aux_0;
      i <- i + 1;
    }
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <@ rotate (k0_7);
    k0_7 <- aux_1;
    return (k0_7, s_k8_15);
  }
  
  proc rotate_second_half_x8 (s_k8_15:W128.t Array8.t) : W128.t Array8.t = {
    var aux: W128.t Array8.t;
    
    var k8_15:W128.t Array8.t;
    k8_15 <- witness;
    leakages <- LeakAddr([]) :: leakages;
    aux <@ rotate_stack (s_k8_15);
    k8_15 <- aux;
    return (k8_15);
  }
  
  proc interleave_0 (s:W128.t Array8.t, k:W128.t Array8.t, o:int) : W128.t Array8.t = {
    var aux: W128.t;
    
    var sk:W128.t Array8.t;
    sk <- witness;
    leakages <- LeakAddr([(o + 0)]) :: leakages;
    aux <- s.[(o + 0)];
    leakages <- LeakAddr([0]) :: leakages;
    sk.[0] <- aux;
    leakages <- LeakAddr([(o + 1)]) :: leakages;
    aux <- s.[(o + 1)];
    leakages <- LeakAddr([1]) :: leakages;
    sk.[1] <- aux;
    leakages <- LeakAddr([(o + 0)]) :: leakages;
    aux <- k.[(o + 0)];
    leakages <- LeakAddr([2]) :: leakages;
    sk.[2] <- aux;
    leakages <- LeakAddr([(o + 1)]) :: leakages;
    aux <- k.[(o + 1)];
    leakages <- LeakAddr([3]) :: leakages;
    sk.[3] <- aux;
    leakages <- LeakAddr([(o + 2)]) :: leakages;
    aux <- s.[(o + 2)];
    leakages <- LeakAddr([4]) :: leakages;
    sk.[4] <- aux;
    leakages <- LeakAddr([(o + 3)]) :: leakages;
    aux <- s.[(o + 3)];
    leakages <- LeakAddr([5]) :: leakages;
    sk.[5] <- aux;
    leakages <- LeakAddr([(o + 2)]) :: leakages;
    aux <- k.[(o + 2)];
    leakages <- LeakAddr([6]) :: leakages;
    sk.[6] <- aux;
    leakages <- LeakAddr([(o + 3)]) :: leakages;
    aux <- k.[(o + 3)];
    leakages <- LeakAddr([7]) :: leakages;
    sk.[7] <- aux;
    return (sk);
  }
  
  proc update_ptr (output:W64.t, plain:W64.t, len:W32.t, n:int) : W64.t *
                                                                  W64.t *
                                                                  W32.t = {
    var aux_0: W32.t;
    var aux: W64.t;
    
    
    
    leakages <- LeakAddr([]) :: leakages;
    aux <- (output + (W64.of_int n));
    output <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- (plain + (W64.of_int n));
    plain <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <- (len - (W32.of_int n));
    len <- aux_0;
    return (output, plain, len);
  }
  
  proc store (output:W64.t, plain:W64.t, len:W32.t, k:W128.t Array2.t) : 
  W64.t * W64.t * W32.t * W128.t Array2.t = {
    var aux_2: W32.t;
    var aux_1: W64.t;
    var aux_0: W64.t;
    var aux: W128.t;
    
    
    
    leakages <- LeakAddr([(W64.to_uint (plain + (W64.of_int 0))); 0]) :: leakages;
    aux <- (k.[0] `^` (loadW128 Glob.mem (W64.to_uint (plain + (W64.of_int 0)))));
    leakages <- LeakAddr([0]) :: leakages;
    k.[0] <- aux;
    leakages <- LeakAddr([(W64.to_uint (plain + (W64.of_int 16))); 1]) :: leakages;
    aux <- (k.[1] `^` (loadW128 Glob.mem (W64.to_uint (plain + (W64.of_int 16)))));
    leakages <- LeakAddr([1]) :: leakages;
    k.[1] <- aux;
    leakages <- LeakAddr([0]) :: leakages;
    aux <- k.[0];
    leakages <- LeakAddr([(W64.to_uint (output + (W64.of_int 0)))]) :: leakages;
    Glob.mem <-
    storeW128 Glob.mem (W64.to_uint (output + (W64.of_int 0))) aux;
    leakages <- LeakAddr([1]) :: leakages;
    aux <- k.[1];
    leakages <- LeakAddr([(W64.to_uint (output + (W64.of_int 16)))]) :: leakages;
    Glob.mem <-
    storeW128 Glob.mem (W64.to_uint (output + (W64.of_int 16))) aux;
    leakages <- LeakAddr([]) :: leakages;
    (aux_1, aux_0, aux_2) <@ update_ptr (output, plain, len, 32);
    output <- aux_1;
    plain <- aux_0;
    len <- aux_2;
    return (output, plain, len, k);
  }
  
  proc store_last (output:W64.t, plain:W64.t, len:W32.t, k:W128.t Array2.t) : unit = {
    var aux_3: W8.t;
    var aux_2: W32.t;
    var aux_1: W64.t;
    var aux_0: W64.t;
    var aux: W128.t;
    
    var r1:W128.t;
    var r2:W64.t;
    var r3:W8.t;
    
    leakages <- LeakAddr([0]) :: leakages;
    aux <- k.[0];
    r1 <- aux;
    leakages <- LeakCond(((W32.of_int 16) \ule len)) :: LeakAddr([]) :: leakages;
    if (((W32.of_int 16) \ule len)) {
      leakages <- LeakAddr([(W64.to_uint (plain + (W64.of_int 0)))]) :: leakages;
      aux <- (r1 `^` (loadW128 Glob.mem (W64.to_uint (plain + (W64.of_int 0)))));
      r1 <- aux;
      leakages <- LeakAddr([]) :: leakages;
      aux <- r1;
      leakages <- LeakAddr([(W64.to_uint (output + (W64.of_int 0)))]) :: leakages;
      Glob.mem <-
      storeW128 Glob.mem (W64.to_uint (output + (W64.of_int 0))) aux;
      leakages <- LeakAddr([]) :: leakages;
      (aux_1, aux_0, aux_2) <@ update_ptr (output, plain, len, 16);
      output <- aux_1;
      plain <- aux_0;
      len <- aux_2;
      leakages <- LeakAddr([1]) :: leakages;
      aux <- k.[1];
      r1 <- aux;
    } else {
      
    }
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- x86_VPEXTR_64 r1 (W8.of_int 0);
    r2 <- aux_1;
    leakages <- LeakCond(((W32.of_int 8) \ule len)) :: LeakAddr([]) :: leakages;
    if (((W32.of_int 8) \ule len)) {
      leakages <- LeakAddr([(W64.to_uint (plain + (W64.of_int 0)))]) :: leakages;
      aux_1 <- (r2 `^` (loadW64 Glob.mem (W64.to_uint (plain + (W64.of_int 0)))));
      r2 <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- r2;
      leakages <- LeakAddr([(W64.to_uint (output + (W64.of_int 0)))]) :: leakages;
      Glob.mem <-
      storeW64 Glob.mem (W64.to_uint (output + (W64.of_int 0))) aux_1;
      leakages <- LeakAddr([]) :: leakages;
      (aux_1, aux_0, aux_2) <@ update_ptr (output, plain, len, 8);
      output <- aux_1;
      plain <- aux_0;
      len <- aux_2;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- x86_VPEXTR_64 r1 (W8.of_int 1);
      r2 <- aux_1;
    } else {
      
    }
    
    leakages <- LeakCond(((W32.of_int 0) \ult len)) :: LeakAddr([]) :: leakages;
    
    while (((W32.of_int 0) \ult len)) {
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- r2;
      r3 <- (truncateu8 aux_1);
      leakages <- LeakAddr([(W64.to_uint (plain + (W64.of_int 0)))]) :: leakages;
      aux_3 <- (r3 `^` (loadW8 Glob.mem (W64.to_uint (plain + (W64.of_int 0)))));
      r3 <- aux_3;
      leakages <- LeakAddr([]) :: leakages;
      aux_3 <- r3;
      leakages <- LeakAddr([(W64.to_uint (output + (W64.of_int 0)))]) :: leakages;
      Glob.mem <-
      storeW8 Glob.mem (W64.to_uint (output + (W64.of_int 0))) aux_3;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- (r2 `>>` (W8.of_int 8));
      r2 <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      (aux_1, aux_0, aux_2) <@ update_ptr (output, plain, len, 1);
      output <- aux_1;
      plain <- aux_0;
      len <- aux_2;
    leakages <- LeakCond(((W32.of_int 0) \ult len)) :: LeakAddr([]) :: leakages;
    
    }
    return ();
  }
  
  proc store_x1 (output:W64.t, plain:W64.t, len:W32.t, k:W128.t Array4.t) : 
  W64.t * W64.t * W32.t * W128.t Array4.t = {
    var aux: int;
    var aux_3: W32.t;
    var aux_2: W64.t;
    var aux_1: W64.t;
    var aux_0: W128.t;
    
    var i:int;
    
    leakages <- LeakFor(0,4) :: LeakAddr([]) :: leakages;
    i <- 0;
    while (i < 4) {
      leakages <- LeakAddr([(W64.to_uint (plain + (W64.of_int (16 * i)))); i]) :: leakages;
      aux_0 <- (k.[i] `^` (loadW128 Glob.mem (W64.to_uint (plain + (W64.of_int (16 * i))))));
      leakages <- LeakAddr([i]) :: leakages;
      k.[i] <- aux_0;
      i <- i + 1;
    }
    leakages <- LeakFor(0,4) :: LeakAddr([]) :: leakages;
    i <- 0;
    while (i < 4) {
      leakages <- LeakAddr([i]) :: leakages;
      aux_0 <- k.[i];
      leakages <- LeakAddr([(W64.to_uint (output + (W64.of_int (16 * i))))]) :: leakages;
      Glob.mem <-
      storeW128 Glob.mem (W64.to_uint (output + (W64.of_int (16 * i)))) aux_0;
      i <- i + 1;
    }
    leakages <- LeakAddr([]) :: leakages;
    (aux_2, aux_1, aux_3) <@ update_ptr (output, plain, len, 64);
    output <- aux_2;
    plain <- aux_1;
    len <- aux_3;
    return (output, plain, len, k);
  }
  
  proc store_x1_last (output:W64.t, plain:W64.t, len:W32.t, k:W128.t Array4.t) : unit = {
    var aux_2: W32.t;
    var aux_1: W64.t;
    var aux_0: W64.t;
    var aux: W128.t;
    var aux_3: W128.t Array2.t;
    
    var r:W128.t Array2.t;
    r <- witness;
    leakages <- LeakAddr([0]) :: leakages;
    aux <- k.[0];
    leakages <- LeakAddr([0]) :: leakages;
    r.[0] <- aux;
    leakages <- LeakAddr([1]) :: leakages;
    aux <- k.[1];
    leakages <- LeakAddr([1]) :: leakages;
    r.[1] <- aux;
    leakages <- LeakCond(((W32.of_int 32) \ule len)) :: LeakAddr([]) :: leakages;
    if (((W32.of_int 32) \ule len)) {
      leakages <- LeakAddr([]) :: leakages;
      (aux_1, aux_0, aux_2, aux_3) <@ store (output, plain, len, r);
      output <- aux_1;
      plain <- aux_0;
      len <- aux_2;
      r <- aux_3;
      leakages <- LeakAddr([2]) :: leakages;
      aux <- k.[2];
      leakages <- LeakAddr([0]) :: leakages;
      r.[0] <- aux;
      leakages <- LeakAddr([3]) :: leakages;
      aux <- k.[3];
      leakages <- LeakAddr([1]) :: leakages;
      r.[1] <- aux;
    } else {
      
    }
    leakages <- LeakAddr([]) :: leakages;
    store_last (output, plain, len, r);
    return ();
  }
  
  proc store_x2 (output:W64.t, plain:W64.t, len:W32.t, k:W128.t Array8.t) : 
  W64.t * W64.t * W32.t = {
    var aux: int;
    var aux_3: W32.t;
    var aux_2: W64.t;
    var aux_1: W64.t;
    var aux_0: W128.t;
    
    var i:int;
    
    leakages <- LeakFor(0,8) :: LeakAddr([]) :: leakages;
    i <- 0;
    while (i < 8) {
      leakages <- LeakAddr([(W64.to_uint (plain + (W64.of_int (16 * i)))); i]) :: leakages;
      aux_0 <- (k.[i] `^` (loadW128 Glob.mem (W64.to_uint (plain + (W64.of_int (16 * i))))));
      leakages <- LeakAddr([i]) :: leakages;
      k.[i] <- aux_0;
      i <- i + 1;
    }
    leakages <- LeakFor(0,8) :: LeakAddr([]) :: leakages;
    i <- 0;
    while (i < 8) {
      leakages <- LeakAddr([i]) :: leakages;
      aux_0 <- k.[i];
      leakages <- LeakAddr([(W64.to_uint (output + (W64.of_int (16 * i))))]) :: leakages;
      Glob.mem <-
      storeW128 Glob.mem (W64.to_uint (output + (W64.of_int (16 * i)))) aux_0;
      i <- i + 1;
    }
    leakages <- LeakAddr([]) :: leakages;
    (aux_2, aux_1, aux_3) <@ update_ptr (output, plain, len, 128);
    output <- aux_2;
    plain <- aux_1;
    len <- aux_3;
    return (output, plain, len);
  }
  
  proc store_x2_last (output:W64.t, plain:W64.t, len:W32.t, k:W128.t Array8.t) : unit = {
    var aux: int;
    var aux_3: W32.t;
    var aux_2: W64.t;
    var aux_1: W64.t;
    var aux_0: W128.t;
    var aux_4: W128.t Array4.t;
    
    var i:int;
    var r:W128.t Array4.t;
    r <- witness;
    leakages <- LeakFor(0,4) :: LeakAddr([]) :: leakages;
    i <- 0;
    while (i < 4) {
      leakages <- LeakAddr([i]) :: leakages;
      aux_0 <- k.[i];
      leakages <- LeakAddr([i]) :: leakages;
      r.[i] <- aux_0;
      i <- i + 1;
    }
    leakages <- LeakCond(((W32.of_int 64) \ule len)) :: LeakAddr([]) :: leakages;
    if (((W32.of_int 64) \ule len)) {
      leakages <- LeakAddr([]) :: leakages;
      (aux_2, aux_1, aux_3, aux_4) <@ store_x1 (output, plain, len, r);
      output <- aux_2;
      plain <- aux_1;
      len <- aux_3;
      r <- aux_4;
      leakages <- LeakFor(0,4) :: LeakAddr([]) :: leakages;
      i <- 0;
      while (i < 4) {
        leakages <- LeakAddr([(i + 4)]) :: leakages;
        aux_0 <- k.[(i + 4)];
        leakages <- LeakAddr([i]) :: leakages;
        r.[i] <- aux_0;
        i <- i + 1;
      }
    } else {
      
    }
    leakages <- LeakAddr([]) :: leakages;
    store_x1_last (output, plain, len, r);
    return ();
  }
  
  proc store_half_x4 (output:W64.t, plain:W64.t, len:W32.t,
                      k:W128.t Array8.t, o:int) : unit = {
    var aux: int;
    var aux_0: W128.t;
    
    var i:int;
    
    leakages <- LeakFor(0,4) :: LeakAddr([]) :: leakages;
    i <- 0;
    while (i < 4) {
      leakages <- LeakAddr([(W64.to_uint (plain + (W64.of_int (o + (64 * i)))));
                           (2 * i)]) :: leakages;
      aux_0 <- (k.[(2 * i)] `^` (loadW128 Glob.mem (W64.to_uint (plain + (W64.of_int (o + (64 * i)))))));
      leakages <- LeakAddr([(2 * i)]) :: leakages;
      k.[(2 * i)] <- aux_0;
      leakages <- LeakAddr([(W64.to_uint (plain + (W64.of_int ((o + (64 * i)) + 16))));
                           ((2 * i) + 1)]) :: leakages;
      aux_0 <- (k.[((2 * i) + 1)] `^` (loadW128 Glob.mem (W64.to_uint (plain + (W64.of_int ((o + (64 * i)) + 16))))));
      leakages <- LeakAddr([((2 * i) + 1)]) :: leakages;
      k.[((2 * i) + 1)] <- aux_0;
      i <- i + 1;
    }
    leakages <- LeakFor(0,4) :: LeakAddr([]) :: leakages;
    i <- 0;
    while (i < 4) {
      leakages <- LeakAddr([(2 * i)]) :: leakages;
      aux_0 <- k.[(2 * i)];
      leakages <- LeakAddr([(W64.to_uint (output + (W64.of_int (o + (64 * i)))))]) :: leakages;
      Glob.mem <-
      storeW128 Glob.mem (W64.to_uint (output + (W64.of_int (o + (64 * i))))) aux_0;
      leakages <- LeakAddr([((2 * i) + 1)]) :: leakages;
      aux_0 <- k.[((2 * i) + 1)];
      leakages <- LeakAddr([(W64.to_uint (output + (W64.of_int ((o + (64 * i)) + 16))))]) :: leakages;
      Glob.mem <-
      storeW128 Glob.mem (W64.to_uint (output + (W64.of_int ((o + (64 * i)) + 16)))) aux_0;
      i <- i + 1;
    }
    return ();
  }
  
  proc store_x4 (output:W64.t, plain:W64.t, len:W32.t, k:W128.t Array16.t) : 
  W64.t * W64.t * W32.t = {
    var aux_3: W32.t;
    var aux_2: W64.t;
    var aux_1: W64.t;
    var aux_0: W128.t Array8.t;
    var aux: W128.t Array8.t;
    
    var k0_7:W128.t Array8.t;
    var s_k8_15:W128.t Array8.t;
    var k8_15:W128.t Array8.t;
    k0_7 <- witness;
    k8_15 <- witness;
    s_k8_15 <- witness;
    leakages <- LeakAddr([]) :: leakages;
    (aux_0, aux) <@ rotate_first_half_x8 (k);
    k0_7 <- aux_0;
    s_k8_15 <- aux;
    leakages <- LeakAddr([]) :: leakages;
    store_half_x4 (output, plain, len, k0_7, 0);
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <@ rotate_second_half_x8 (s_k8_15);
    k8_15 <- aux_0;
    leakages <- LeakAddr([]) :: leakages;
    store_half_x4 (output, plain, len, k8_15, 32);
    leakages <- LeakAddr([]) :: leakages;
    (aux_2, aux_1, aux_3) <@ update_ptr (output, plain, len, 256);
    output <- aux_2;
    plain <- aux_1;
    len <- aux_3;
    return (output, plain, len);
  }
  
  proc store_x4_last (output:W64.t, plain:W64.t, len:W32.t,
                      k:W128.t Array16.t) : unit = {
    var aux_3: W32.t;
    var aux_2: W64.t;
    var aux_1: W64.t;
    var aux_0: W128.t Array8.t;
    var aux: W128.t Array8.t;
    
    var k0_7:W128.t Array8.t;
    var s_k8_15:W128.t Array8.t;
    var s_k0_7:W128.t Array8.t;
    var k8_15:W128.t Array8.t;
    var i0_7:W128.t Array8.t;
    i0_7 <- witness;
    k0_7 <- witness;
    k8_15 <- witness;
    s_k0_7 <- witness;
    s_k8_15 <- witness;
    leakages <- LeakAddr([]) :: leakages;
    (aux_0, aux) <@ rotate_first_half_x8 (k);
    k0_7 <- aux_0;
    s_k8_15 <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <- k0_7;
    s_k0_7 <- aux_0;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <@ rotate_second_half_x8 (s_k8_15);
    k8_15 <- aux_0;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <@ interleave_0 (s_k0_7, k8_15, 0);
    i0_7 <- aux_0;
    leakages <- LeakCond(((W32.of_int 128) \ule len)) :: LeakAddr([]) :: leakages;
    if (((W32.of_int 128) \ule len)) {
      leakages <- LeakAddr([]) :: leakages;
      (aux_2, aux_1, aux_3) <@ store_x2 (output, plain, len, i0_7);
      output <- aux_2;
      plain <- aux_1;
      len <- aux_3;
      leakages <- LeakAddr([]) :: leakages;
      aux_0 <@ interleave_0 (s_k0_7, k8_15, 4);
      i0_7 <- aux_0;
    } else {
      
    }
    leakages <- LeakAddr([]) :: leakages;
    store_x2_last (output, plain, len, i0_7);
    return ();
  }
  
  proc increment_counter_x4 (s:W128.t Array16.t) : W128.t Array16.t = {
    var aux: W128.t;
    
    var t:W128.t;
    
    leakages <- LeakAddr([]) :: leakages;
    aux <- g_cnt_inc;
    t <- aux;
    leakages <- LeakAddr([12]) :: leakages;
    aux <- (t \vadd32u128 s.[12]);
    t <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- t;
    leakages <- LeakAddr([12]) :: leakages;
    s.[12] <- aux;
    return (s);
  }
  
  proc round_64 (k:W128.t Array4.t, r16:W128.t, r8:W128.t) : W128.t Array4.t = {
    var aux: W128.t;
    
    var t:W128.t;
    
    leakages <- LeakAddr([1; 0]) :: leakages;
    aux <- (k.[0] \vadd32u128 k.[1]);
    leakages <- LeakAddr([0]) :: leakages;
    k.[0] <- aux;
    leakages <- LeakAddr([0; 3]) :: leakages;
    aux <- (k.[3] `^` k.[0]);
    leakages <- LeakAddr([3]) :: leakages;
    k.[3] <- aux;
    leakages <- LeakAddr([3]) :: leakages;
    aux <- x86_VPSHUFB_128 k.[3] r16;
    leakages <- LeakAddr([3]) :: leakages;
    k.[3] <- aux;
    leakages <- LeakAddr([3; 2]) :: leakages;
    aux <- (k.[2] \vadd32u128 k.[3]);
    leakages <- LeakAddr([2]) :: leakages;
    k.[2] <- aux;
    leakages <- LeakAddr([2; 1]) :: leakages;
    aux <- (k.[1] `^` k.[2]);
    leakages <- LeakAddr([1]) :: leakages;
    k.[1] <- aux;
    leakages <- LeakAddr([1]) :: leakages;
    aux <- (k.[1] \vshl32u128 (W8.of_int 12));
    t <- aux;
    leakages <- LeakAddr([1]) :: leakages;
    aux <- (k.[1] \vshr32u128 (W8.of_int 20));
    leakages <- LeakAddr([1]) :: leakages;
    k.[1] <- aux;
    leakages <- LeakAddr([1]) :: leakages;
    aux <- (k.[1] `^` t);
    leakages <- LeakAddr([1]) :: leakages;
    k.[1] <- aux;
    leakages <- LeakAddr([1; 0]) :: leakages;
    aux <- (k.[0] \vadd32u128 k.[1]);
    leakages <- LeakAddr([0]) :: leakages;
    k.[0] <- aux;
    leakages <- LeakAddr([0; 3]) :: leakages;
    aux <- (k.[3] `^` k.[0]);
    leakages <- LeakAddr([3]) :: leakages;
    k.[3] <- aux;
    leakages <- LeakAddr([3]) :: leakages;
    aux <- x86_VPSHUFB_128 k.[3] r8;
    leakages <- LeakAddr([3]) :: leakages;
    k.[3] <- aux;
    leakages <- LeakAddr([3; 2]) :: leakages;
    aux <- (k.[2] \vadd32u128 k.[3]);
    leakages <- LeakAddr([2]) :: leakages;
    k.[2] <- aux;
    leakages <- LeakAddr([2; 1]) :: leakages;
    aux <- (k.[1] `^` k.[2]);
    leakages <- LeakAddr([1]) :: leakages;
    k.[1] <- aux;
    leakages <- LeakAddr([1]) :: leakages;
    aux <- (k.[1] \vshl32u128 (W8.of_int 7));
    t <- aux;
    leakages <- LeakAddr([1]) :: leakages;
    aux <- (k.[1] \vshr32u128 (W8.of_int 25));
    leakages <- LeakAddr([1]) :: leakages;
    k.[1] <- aux;
    leakages <- LeakAddr([1]) :: leakages;
    aux <- (k.[1] `^` t);
    leakages <- LeakAddr([1]) :: leakages;
    k.[1] <- aux;
    return (k);
  }
  
  proc round_128 (k1:W128.t Array4.t, k2:W128.t Array4.t, r16:W128.t,
                  r8:W128.t) : W128.t Array4.t * W128.t Array4.t = {
    var aux: W128.t;
    
    var t1:W128.t;
    var t2:W128.t;
    
    leakages <- LeakAddr([1; 0]) :: leakages;
    aux <- (k1.[0] \vadd32u128 k1.[1]);
    leakages <- LeakAddr([0]) :: leakages;
    k1.[0] <- aux;
    leakages <- LeakAddr([1; 0]) :: leakages;
    aux <- (k2.[0] \vadd32u128 k2.[1]);
    leakages <- LeakAddr([0]) :: leakages;
    k2.[0] <- aux;
    leakages <- LeakAddr([0; 3]) :: leakages;
    aux <- (k1.[3] `^` k1.[0]);
    leakages <- LeakAddr([3]) :: leakages;
    k1.[3] <- aux;
    leakages <- LeakAddr([0; 3]) :: leakages;
    aux <- (k2.[3] `^` k2.[0]);
    leakages <- LeakAddr([3]) :: leakages;
    k2.[3] <- aux;
    leakages <- LeakAddr([3]) :: leakages;
    aux <- x86_VPSHUFB_128 k1.[3] r16;
    leakages <- LeakAddr([3]) :: leakages;
    k1.[3] <- aux;
    leakages <- LeakAddr([3]) :: leakages;
    aux <- x86_VPSHUFB_128 k2.[3] r16;
    leakages <- LeakAddr([3]) :: leakages;
    k2.[3] <- aux;
    leakages <- LeakAddr([3; 2]) :: leakages;
    aux <- (k1.[2] \vadd32u128 k1.[3]);
    leakages <- LeakAddr([2]) :: leakages;
    k1.[2] <- aux;
    leakages <- LeakAddr([3; 2]) :: leakages;
    aux <- (k2.[2] \vadd32u128 k2.[3]);
    leakages <- LeakAddr([2]) :: leakages;
    k2.[2] <- aux;
    leakages <- LeakAddr([2; 1]) :: leakages;
    aux <- (k1.[1] `^` k1.[2]);
    leakages <- LeakAddr([1]) :: leakages;
    k1.[1] <- aux;
    leakages <- LeakAddr([1]) :: leakages;
    aux <- (k1.[1] \vshl32u128 (W8.of_int 12));
    t1 <- aux;
    leakages <- LeakAddr([1]) :: leakages;
    aux <- (k1.[1] \vshr32u128 (W8.of_int 20));
    leakages <- LeakAddr([1]) :: leakages;
    k1.[1] <- aux;
    leakages <- LeakAddr([2; 1]) :: leakages;
    aux <- (k2.[1] `^` k2.[2]);
    leakages <- LeakAddr([1]) :: leakages;
    k2.[1] <- aux;
    leakages <- LeakAddr([1]) :: leakages;
    aux <- (k1.[1] `^` t1);
    leakages <- LeakAddr([1]) :: leakages;
    k1.[1] <- aux;
    leakages <- LeakAddr([1]) :: leakages;
    aux <- (k2.[1] \vshl32u128 (W8.of_int 12));
    t2 <- aux;
    leakages <- LeakAddr([1]) :: leakages;
    aux <- (k2.[1] \vshr32u128 (W8.of_int 20));
    leakages <- LeakAddr([1]) :: leakages;
    k2.[1] <- aux;
    leakages <- LeakAddr([1]) :: leakages;
    aux <- (k2.[1] `^` t2);
    leakages <- LeakAddr([1]) :: leakages;
    k2.[1] <- aux;
    leakages <- LeakAddr([1; 0]) :: leakages;
    aux <- (k1.[0] \vadd32u128 k1.[1]);
    leakages <- LeakAddr([0]) :: leakages;
    k1.[0] <- aux;
    leakages <- LeakAddr([1; 0]) :: leakages;
    aux <- (k2.[0] \vadd32u128 k2.[1]);
    leakages <- LeakAddr([0]) :: leakages;
    k2.[0] <- aux;
    leakages <- LeakAddr([0; 3]) :: leakages;
    aux <- (k1.[3] `^` k1.[0]);
    leakages <- LeakAddr([3]) :: leakages;
    k1.[3] <- aux;
    leakages <- LeakAddr([0; 3]) :: leakages;
    aux <- (k2.[3] `^` k2.[0]);
    leakages <- LeakAddr([3]) :: leakages;
    k2.[3] <- aux;
    leakages <- LeakAddr([3]) :: leakages;
    aux <- x86_VPSHUFB_128 k1.[3] r8;
    leakages <- LeakAddr([3]) :: leakages;
    k1.[3] <- aux;
    leakages <- LeakAddr([3]) :: leakages;
    aux <- x86_VPSHUFB_128 k2.[3] r8;
    leakages <- LeakAddr([3]) :: leakages;
    k2.[3] <- aux;
    leakages <- LeakAddr([3; 2]) :: leakages;
    aux <- (k1.[2] \vadd32u128 k1.[3]);
    leakages <- LeakAddr([2]) :: leakages;
    k1.[2] <- aux;
    leakages <- LeakAddr([3; 2]) :: leakages;
    aux <- (k2.[2] \vadd32u128 k2.[3]);
    leakages <- LeakAddr([2]) :: leakages;
    k2.[2] <- aux;
    leakages <- LeakAddr([2; 1]) :: leakages;
    aux <- (k1.[1] `^` k1.[2]);
    leakages <- LeakAddr([1]) :: leakages;
    k1.[1] <- aux;
    leakages <- LeakAddr([1]) :: leakages;
    aux <- (k1.[1] \vshl32u128 (W8.of_int 7));
    t1 <- aux;
    leakages <- LeakAddr([1]) :: leakages;
    aux <- (k1.[1] \vshr32u128 (W8.of_int 25));
    leakages <- LeakAddr([1]) :: leakages;
    k1.[1] <- aux;
    leakages <- LeakAddr([2; 1]) :: leakages;
    aux <- (k2.[1] `^` k2.[2]);
    leakages <- LeakAddr([1]) :: leakages;
    k2.[1] <- aux;
    leakages <- LeakAddr([1]) :: leakages;
    aux <- (k1.[1] `^` t1);
    leakages <- LeakAddr([1]) :: leakages;
    k1.[1] <- aux;
    leakages <- LeakAddr([1]) :: leakages;
    aux <- (k2.[1] \vshl32u128 (W8.of_int 7));
    t2 <- aux;
    leakages <- LeakAddr([1]) :: leakages;
    aux <- (k2.[1] \vshr32u128 (W8.of_int 25));
    leakages <- LeakAddr([1]) :: leakages;
    k2.[1] <- aux;
    leakages <- LeakAddr([1]) :: leakages;
    aux <- (k2.[1] `^` t2);
    leakages <- LeakAddr([1]) :: leakages;
    k2.[1] <- aux;
    return (k1, k2);
  }
  
  proc shuffle_state (k:W128.t Array4.t) : W128.t Array4.t = {
    var aux: W128.t;
    
    
    
    leakages <- LeakAddr([1]) :: leakages;
    aux <- x86_VPSHUFD_128 k.[1]
    (W8.of_int (1 %% 2^2 + 2^2 * (2 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    leakages <- LeakAddr([1]) :: leakages;
    k.[1] <- aux;
    leakages <- LeakAddr([2]) :: leakages;
    aux <- x86_VPSHUFD_128 k.[2]
    (W8.of_int (2 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 1))));
    leakages <- LeakAddr([2]) :: leakages;
    k.[2] <- aux;
    leakages <- LeakAddr([3]) :: leakages;
    aux <- x86_VPSHUFD_128 k.[3]
    (W8.of_int (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (1 %% 2^2 + 2^2 * 2))));
    leakages <- LeakAddr([3]) :: leakages;
    k.[3] <- aux;
    return (k);
  }
  
  proc reverse_shuffle_state (k:W128.t Array4.t) : W128.t Array4.t = {
    var aux: W128.t;
    
    
    
    leakages <- LeakAddr([1]) :: leakages;
    aux <- x86_VPSHUFD_128 k.[1]
    (W8.of_int (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (1 %% 2^2 + 2^2 * 2))));
    leakages <- LeakAddr([1]) :: leakages;
    k.[1] <- aux;
    leakages <- LeakAddr([2]) :: leakages;
    aux <- x86_VPSHUFD_128 k.[2]
    (W8.of_int (2 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 1))));
    leakages <- LeakAddr([2]) :: leakages;
    k.[2] <- aux;
    leakages <- LeakAddr([3]) :: leakages;
    aux <- x86_VPSHUFD_128 k.[3]
    (W8.of_int (1 %% 2^2 + 2^2 * (2 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    leakages <- LeakAddr([3]) :: leakages;
    k.[3] <- aux;
    return (k);
  }
  
  proc rounds_x1 (k:W128.t Array4.t) : W128.t Array4.t = {
    var aux_0: W64.t;
    var aux: W128.t;
    var aux_1: W128.t Array4.t;
    
    var r16:W128.t;
    var r8:W128.t;
    var c:W64.t;
    
    leakages <- LeakAddr([]) :: leakages;
    aux <- g_r16;
    r16 <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- g_r8;
    r8 <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <- (W64.of_int 0);
    c <- aux_0;
    
    leakages <- LeakCond((c \ult (W64.of_int 10))) :: LeakAddr([]) :: leakages;
    
    while ((c \ult (W64.of_int 10))) {
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <@ round_64 (k, r16, r8);
      k <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <@ shuffle_state (k);
      k <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <@ round_64 (k, r16, r8);
      k <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <@ reverse_shuffle_state (k);
      k <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_0 <- (c + (W64.of_int 1));
      c <- aux_0;
    leakages <- LeakCond((c \ult (W64.of_int 10))) :: LeakAddr([]) :: leakages;
    
    }
    return (k);
  }
  
  proc rounds_x2 (k1:W128.t Array4.t, k2:W128.t Array4.t) : W128.t Array4.t *
                                                            W128.t Array4.t = {
    var aux_0: W64.t;
    var aux: W128.t;
    var aux_2: W128.t Array4.t;
    var aux_1: W128.t Array4.t;
    
    var r16:W128.t;
    var r8:W128.t;
    var c:W64.t;
    
    leakages <- LeakAddr([]) :: leakages;
    aux <- g_r16;
    r16 <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- g_r8;
    r8 <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <- (W64.of_int 0);
    c <- aux_0;
    
    leakages <- LeakCond((c \ult (W64.of_int 10))) :: LeakAddr([]) :: leakages;
    
    while ((c \ult (W64.of_int 10))) {
      leakages <- LeakAddr([]) :: leakages;
      (aux_2, aux_1) <@ round_128 (k1, k2, r16, r8);
      k1 <- aux_2;
      k2 <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_2 <@ shuffle_state (k1);
      k1 <- aux_2;
      leakages <- LeakAddr([]) :: leakages;
      aux_2 <@ shuffle_state (k2);
      k2 <- aux_2;
      leakages <- LeakAddr([]) :: leakages;
      (aux_2, aux_1) <@ round_128 (k1, k2, r16, r8);
      k1 <- aux_2;
      k2 <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_2 <@ reverse_shuffle_state (k1);
      k1 <- aux_2;
      leakages <- LeakAddr([]) :: leakages;
      aux_2 <@ reverse_shuffle_state (k2);
      k2 <- aux_2;
      leakages <- LeakAddr([]) :: leakages;
      aux_0 <- (c + (W64.of_int 1));
      c <- aux_0;
    leakages <- LeakCond((c \ult (W64.of_int 10))) :: LeakAddr([]) :: leakages;
    
    }
    return (k1, k2);
  }
  
  proc round_256 (k:W128.t Array16.t, s_r16:W128.t, s_r8:W128.t, a0:int,
                  b0:int, c0:int, d0:int, a1:int, b1:int, c1:int, d1:int) : 
  W128.t Array16.t = {
    var aux: W128.t;
    
    var t:W128.t;
    
    leakages <- LeakAddr([b0; a0]) :: leakages;
    aux <- (k.[a0] \vadd32u128 k.[b0]);
    leakages <- LeakAddr([a0]) :: leakages;
    k.[a0] <- aux;
    leakages <- LeakAddr([b1; a1]) :: leakages;
    aux <- (k.[a1] \vadd32u128 k.[b1]);
    leakages <- LeakAddr([a1]) :: leakages;
    k.[a1] <- aux;
    leakages <- LeakAddr([a0; d0]) :: leakages;
    aux <- (k.[d0] `^` k.[a0]);
    leakages <- LeakAddr([d0]) :: leakages;
    k.[d0] <- aux;
    leakages <- LeakAddr([a1; d1]) :: leakages;
    aux <- (k.[d1] `^` k.[a1]);
    leakages <- LeakAddr([d1]) :: leakages;
    k.[d1] <- aux;
    leakages <- LeakAddr([d0]) :: leakages;
    aux <- x86_VPSHUFB_128 k.[d0] s_r16;
    leakages <- LeakAddr([d0]) :: leakages;
    k.[d0] <- aux;
    leakages <- LeakAddr([d1]) :: leakages;
    aux <- x86_VPSHUFB_128 k.[d1] s_r16;
    leakages <- LeakAddr([d1]) :: leakages;
    k.[d1] <- aux;
    leakages <- LeakAddr([d0; c0]) :: leakages;
    aux <- (k.[c0] \vadd32u128 k.[d0]);
    leakages <- LeakAddr([c0]) :: leakages;
    k.[c0] <- aux;
    leakages <- LeakAddr([d1; c1]) :: leakages;
    aux <- (k.[c1] \vadd32u128 k.[d1]);
    leakages <- LeakAddr([c1]) :: leakages;
    k.[c1] <- aux;
    leakages <- LeakAddr([c0; b0]) :: leakages;
    aux <- (k.[b0] `^` k.[c0]);
    leakages <- LeakAddr([b0]) :: leakages;
    k.[b0] <- aux;
    leakages <- LeakAddr([c1; b1]) :: leakages;
    aux <- (k.[b1] `^` k.[c1]);
    leakages <- LeakAddr([b1]) :: leakages;
    k.[b1] <- aux;
    leakages <- LeakAddr([b0]) :: leakages;
    aux <- (k.[b0] \vshl32u128 (W8.of_int 12));
    t <- aux;
    leakages <- LeakAddr([b0]) :: leakages;
    aux <- (k.[b0] \vshr32u128 (W8.of_int 20));
    leakages <- LeakAddr([b0]) :: leakages;
    k.[b0] <- aux;
    leakages <- LeakAddr([b0]) :: leakages;
    aux <- (k.[b0] `^` t);
    leakages <- LeakAddr([b0]) :: leakages;
    k.[b0] <- aux;
    leakages <- LeakAddr([b1]) :: leakages;
    aux <- (k.[b1] \vshl32u128 (W8.of_int 12));
    t <- aux;
    leakages <- LeakAddr([b1]) :: leakages;
    aux <- (k.[b1] \vshr32u128 (W8.of_int 20));
    leakages <- LeakAddr([b1]) :: leakages;
    k.[b1] <- aux;
    leakages <- LeakAddr([b1]) :: leakages;
    aux <- (k.[b1] `^` t);
    leakages <- LeakAddr([b1]) :: leakages;
    k.[b1] <- aux;
    leakages <- LeakAddr([b0; a0]) :: leakages;
    aux <- (k.[a0] \vadd32u128 k.[b0]);
    leakages <- LeakAddr([a0]) :: leakages;
    k.[a0] <- aux;
    leakages <- LeakAddr([b1; a1]) :: leakages;
    aux <- (k.[a1] \vadd32u128 k.[b1]);
    leakages <- LeakAddr([a1]) :: leakages;
    k.[a1] <- aux;
    leakages <- LeakAddr([a0; d0]) :: leakages;
    aux <- (k.[d0] `^` k.[a0]);
    leakages <- LeakAddr([d0]) :: leakages;
    k.[d0] <- aux;
    leakages <- LeakAddr([a1; d1]) :: leakages;
    aux <- (k.[d1] `^` k.[a1]);
    leakages <- LeakAddr([d1]) :: leakages;
    k.[d1] <- aux;
    leakages <- LeakAddr([d0]) :: leakages;
    aux <- x86_VPSHUFB_128 k.[d0] s_r8;
    leakages <- LeakAddr([d0]) :: leakages;
    k.[d0] <- aux;
    leakages <- LeakAddr([d1]) :: leakages;
    aux <- x86_VPSHUFB_128 k.[d1] s_r8;
    leakages <- LeakAddr([d1]) :: leakages;
    k.[d1] <- aux;
    leakages <- LeakAddr([d0; c0]) :: leakages;
    aux <- (k.[c0] \vadd32u128 k.[d0]);
    leakages <- LeakAddr([c0]) :: leakages;
    k.[c0] <- aux;
    leakages <- LeakAddr([d1; c1]) :: leakages;
    aux <- (k.[c1] \vadd32u128 k.[d1]);
    leakages <- LeakAddr([c1]) :: leakages;
    k.[c1] <- aux;
    leakages <- LeakAddr([c0; b0]) :: leakages;
    aux <- (k.[b0] `^` k.[c0]);
    leakages <- LeakAddr([b0]) :: leakages;
    k.[b0] <- aux;
    leakages <- LeakAddr([c1; b1]) :: leakages;
    aux <- (k.[b1] `^` k.[c1]);
    leakages <- LeakAddr([b1]) :: leakages;
    k.[b1] <- aux;
    leakages <- LeakAddr([b0]) :: leakages;
    aux <- (k.[b0] \vshl32u128 (W8.of_int 7));
    t <- aux;
    leakages <- LeakAddr([b0]) :: leakages;
    aux <- (k.[b0] \vshr32u128 (W8.of_int 25));
    leakages <- LeakAddr([b0]) :: leakages;
    k.[b0] <- aux;
    leakages <- LeakAddr([b0]) :: leakages;
    aux <- (k.[b0] `^` t);
    leakages <- LeakAddr([b0]) :: leakages;
    k.[b0] <- aux;
    leakages <- LeakAddr([b1]) :: leakages;
    aux <- (k.[b1] \vshl32u128 (W8.of_int 7));
    t <- aux;
    leakages <- LeakAddr([b1]) :: leakages;
    aux <- (k.[b1] \vshr32u128 (W8.of_int 25));
    leakages <- LeakAddr([b1]) :: leakages;
    k.[b1] <- aux;
    leakages <- LeakAddr([b1]) :: leakages;
    aux <- (k.[b1] `^` t);
    leakages <- LeakAddr([b1]) :: leakages;
    k.[b1] <- aux;
    return (k);
  }
  
  proc double_round_256 (k:W128.t Array16.t, k_d3:W128.t, s_r16:W128.t,
                         s_r8:W128.t, a0:int, b0:int, c0:int, d0:int, a1:int,
                         b1:int, c1:int, d1:int, a2:int, b2:int, c2:int,
                         d2:int, a3:int, b3:int, c3:int, d3:int) : W128.t Array16.t *
                                                                   W128.t = {
    var aux_0: W128.t;
    var aux: W128.t Array16.t;
    
    
    
    leakages <- LeakAddr([]) :: leakages;
    aux <@ round_256 (k, s_r16, s_r8, a0, b0, c0, d0, a1, b1, c1, d1);
    k <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <- k_d3;
    leakages <- LeakAddr([d3]) :: leakages;
    k.[d3] <- aux_0;
    leakages <- LeakAddr([d1]) :: leakages;
    aux_0 <- k.[d1];
    k_d3 <- aux_0;
    leakages <- LeakAddr([]) :: leakages;
    aux <@ round_256 (k, s_r16, s_r8, a2, b2, c2, d2, a3, b3, c3, d3);
    k <- aux;
    return (k, k_d3);
  }
  
  proc rounds_x4 (k:W128.t Array16.t, s_r16:W128.t, s_r8:W128.t) : W128.t Array16.t = {
    var aux_0: W64.t;
    var aux: W128.t;
    var aux_1: W128.t Array16.t;
    
    var k15:W128.t;
    var c:W64.t;
    var k14:W128.t;
    
    leakages <- LeakAddr([15]) :: leakages;
    aux <- k.[15];
    k15 <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <- (W64.of_int 0);
    c <- aux_0;
    
    leakages <- LeakCond((c \ult (W64.of_int 10))) :: LeakAddr([]) :: leakages;
    
    while ((c \ult (W64.of_int 10))) {
      leakages <- LeakAddr([]) :: leakages;
      (aux_1, aux) <@ double_round_256 (k, k15, s_r16, s_r8, 0, 4, 8, 12, 2,
      6, 10, 14, 1, 5, 9, 13, 3, 7, 11, 15);
      k <- aux_1;
      k14 <- aux;
      leakages <- LeakAddr([]) :: leakages;
      (aux_1, aux) <@ double_round_256 (k, k14, s_r16, s_r8, 1, 6, 11, 12, 0,
      5, 10, 15, 2, 7, 8, 13, 3, 4, 9, 14);
      k <- aux_1;
      k15 <- aux;
      leakages <- LeakAddr([]) :: leakages;
      aux_0 <- (c + (W64.of_int 1));
      c <- aux_0;
    leakages <- LeakCond((c \ult (W64.of_int 10))) :: LeakAddr([]) :: leakages;
    
    }
    leakages <- LeakAddr([]) :: leakages;
    aux <- k15;
    leakages <- LeakAddr([15]) :: leakages;
    k.[15] <- aux;
    return (k);
  }
  
  proc chacha20_more_than_128 (output:W64.t, plain:W64.t, len:W32.t,
                               key:W64.t, nonce:W64.t, counter:W32.t) : unit = {
    var aux_4: W32.t;
    var aux_3: W64.t;
    var aux_2: W64.t;
    var aux_0: W128.t;
    var aux: W128.t;
    var aux_1: W128.t Array16.t;
    
    var s_r16:W128.t;
    var s_r8:W128.t;
    var st:W128.t Array16.t;
    var k:W128.t Array16.t;
    k <- witness;
    st <- witness;
    leakages <- LeakAddr([]) :: leakages;
    (aux_0, aux) <@ load_shufb_cmd ();
    s_r16 <- aux_0;
    s_r8 <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <@ init_x4 (key, nonce, counter);
    st <- aux_1;
    
    leakages <- LeakCond(((W32.of_int 256) \ule len)) :: LeakAddr([]) :: leakages;
    
    while (((W32.of_int 256) \ule len)) {
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <@ copy_state_x4 (st);
      k <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <@ rounds_x4 (k, s_r16, s_r8);
      k <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <@ sum_states_x4 (k, st);
      k <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      (aux_3, aux_2, aux_4) <@ store_x4 (output, plain, len, k);
      output <- aux_3;
      plain <- aux_2;
      len <- aux_4;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <@ increment_counter_x4 (st);
      st <- aux_1;
    leakages <- LeakCond(((W32.of_int 256) \ule len)) :: LeakAddr([]) :: leakages;
    
    }
    leakages <- LeakCond(((W32.of_int 0) \ult len)) :: LeakAddr([]) :: leakages;
    if (((W32.of_int 0) \ult len)) {
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <@ copy_state_x4 (st);
      k <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <@ rounds_x4 (k, s_r16, s_r8);
      k <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <@ sum_states_x4 (k, st);
      k <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      store_x4_last (output, plain, len, k);
    } else {
      
    }
    return ();
  }
  
  proc chacha20_less_than_129 (output:W64.t, plain:W64.t, len:W32.t,
                               key:W64.t, nonce:W64.t, counter:W32.t) : unit = {
    var aux_3: W32.t;
    var aux_2: W64.t;
    var aux_1: W64.t;
    var aux_0: W128.t Array4.t;
    var aux: W128.t Array4.t;
    
    var st:W128.t Array4.t;
    var k1:W128.t Array4.t;
    var k2:W128.t Array4.t;
    k1 <- witness;
    k2 <- witness;
    st <- witness;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <@ init_x1 (key, nonce, counter);
    st <- aux_0;
    leakages <- LeakCond(((W32.of_int 64) \ult len)) :: LeakAddr([]) :: leakages;
    if (((W32.of_int 64) \ult len)) {
      leakages <- LeakAddr([]) :: leakages;
      (aux_0, aux) <@ copy_state_x2 (st);
      k1 <- aux_0;
      k2 <- aux;
      leakages <- LeakAddr([]) :: leakages;
      (aux_0, aux) <@ rounds_x2 (k1, k2);
      k1 <- aux_0;
      k2 <- aux;
      leakages <- LeakAddr([]) :: leakages;
      (aux_0, aux) <@ sum_states_x2 (k1, k2, st);
      k1 <- aux_0;
      k2 <- aux;
      leakages <- LeakAddr([]) :: leakages;
      (aux_2, aux_1, aux_3, aux_0) <@ store_x1 (output, plain, len, k1);
      output <- aux_2;
      plain <- aux_1;
      len <- aux_3;
      k1 <- aux_0;
      leakages <- LeakAddr([]) :: leakages;
      store_x1_last (output, plain, len, k2);
    } else {
      leakages <- LeakAddr([]) :: leakages;
      aux_0 <@ copy_state_x1 (st);
      k1 <- aux_0;
      leakages <- LeakAddr([]) :: leakages;
      aux_0 <@ rounds_x1 (k1);
      k1 <- aux_0;
      leakages <- LeakAddr([]) :: leakages;
      aux_0 <@ sum_states_x1 (k1, st);
      k1 <- aux_0;
      leakages <- LeakAddr([]) :: leakages;
      store_x1_last (output, plain, len, k1);
    }
    return ();
  }
  
  proc chacha20_avx (output:W64.t, plain:W64.t, len:W32.t, key:W64.t,
                     nonce:W64.t, counter:W32.t) : unit = {
    
    
    
    leakages <- LeakCond((len \ult (W32.of_int 129))) :: LeakAddr([]) :: leakages;
    if ((len \ult (W32.of_int 129))) {
      leakages <- LeakAddr([]) :: leakages;
      chacha20_less_than_129 (output, plain, len, key, nonce, counter);
    } else {
      leakages <- LeakAddr([]) :: leakages;
      chacha20_more_than_128 (output, plain, len, key, nonce, counter);
    }
    return ();
  }
}.


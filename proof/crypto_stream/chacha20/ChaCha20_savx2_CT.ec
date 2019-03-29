require import List Int IntExtra IntDiv CoreMap.
require import Array2 Array4 Array8 Array16.
require import WArray16 WArray64 WArray128 WArray256 WArray512.

from Jasmin require import JModel.

abbrev g_p0 = W128.of_int 0.


abbrev g_sigma3 = W32.of_int 1797285236.


abbrev g_sigma2 = W32.of_int 2036477234.


abbrev g_sigma1 = W32.of_int 857760878.


abbrev g_sigma0 = W32.of_int 1634760805.


abbrev g_sigma = W128.of_int 142395606799862307709414285570774956133.


abbrev g_p2 = W256.of_int 680564733841876926926749214863536422914.


abbrev g_p1 = W256.of_int 340282366920938463463374607431768211456.


abbrev g_cnt_inc = W256.of_int 215679573387421932252121579908212843056389298378842373074615151886344.


abbrev g_cnt = W256.of_int 188719626707717088982296698380167795313645871959412740063448560304128.


abbrev g_r8 = W256.of_int 6355432118420048154175784972596847518577147054203239762089463134348153782275.


abbrev g_r16 = W256.of_int 5901373100945378232718128989223044758631764214521116316503579100742837863170.


abbrev g_r16_u128 = W128.of_int 17342576855639742879858139805557719810.


module M = {
  var leakages : leakages_t
  
  proc load_shufb_cmd () : W256.t * W256.t = {
    var aux: W256.t;
    
    var s_r16:W256.t;
    var s_r8:W256.t;
    var r16:W256.t;
    var r8:W256.t;
    
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
  
  proc init_x2 (key:W64.t, nonce:W64.t, counter:W32.t) : W256.t Array4.t = {
    var aux: W128.t;
    var aux_0: W256.t;
    
    var st:W256.t Array4.t;
    var nc:W128.t;
    var s_nc:W128.t;
    st <- witness;
    leakages <- LeakAddr([]) :: leakages;
    aux <- g_p0;
    nc <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- x86_VPINSR_4u32 nc counter (W8.of_int 0);
    nc <- aux;
    leakages <- LeakAddr([(W64.to_uint (nonce + (W64.of_int 0)))]) :: leakages;
    aux <- x86_VPINSR_4u32 nc
    (loadW32 Glob.mem (W64.to_uint (nonce + (W64.of_int 0)))) (W8.of_int 1);
    nc <- aux;
    leakages <- LeakAddr([(W64.to_uint (nonce + (W64.of_int 4)))]) :: leakages;
    aux <- x86_VPINSR_2u64 nc
    (loadW64 Glob.mem (W64.to_uint (nonce + (W64.of_int 4)))) (W8.of_int 1);
    nc <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- nc;
    s_nc <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <- x86_VPBROADCASTI_2u128 g_sigma;
    leakages <- LeakAddr([0]) :: leakages;
    st.[0] <- aux_0;
    leakages <- LeakAddr([(W64.to_uint (key + (W64.of_int 0)))]) :: leakages;
    aux_0 <- x86_VPBROADCASTI_2u128 (loadW128 Glob.mem (W64.to_uint (key + (W64.of_int 0))));
    leakages <- LeakAddr([1]) :: leakages;
    st.[1] <- aux_0;
    leakages <- LeakAddr([(W64.to_uint (key + (W64.of_int 16)))]) :: leakages;
    aux_0 <- x86_VPBROADCASTI_2u128 (loadW128 Glob.mem (W64.to_uint (key + (W64.of_int 16))));
    leakages <- LeakAddr([2]) :: leakages;
    st.[2] <- aux_0;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <- x86_VPBROADCASTI_2u128 s_nc;
    leakages <- LeakAddr([3]) :: leakages;
    st.[3] <- aux_0;
    leakages <- LeakAddr([3]) :: leakages;
    aux_0 <- (st.[3] \vadd32u256 g_p1);
    leakages <- LeakAddr([3]) :: leakages;
    st.[3] <- aux_0;
    return (st);
  }
  
  proc init_x8 (key:W64.t, nonce:W64.t, counter:W32.t) : W256.t Array16.t = {
    var aux_1: int;
    var aux: W32.t;
    var aux_0: W256.t;
    var aux_2: W256.t Array16.t;
    
    var st_:W256.t Array16.t;
    var s_counter:W32.t;
    var st:W256.t Array16.t;
    var i:int;
    st <- witness;
    st_ <- witness;
    leakages <- LeakAddr([]) :: leakages;
    aux <- counter;
    s_counter <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <- x86_VPBROADCAST_8u32 g_sigma0;
    leakages <- LeakAddr([0]) :: leakages;
    st.[0] <- aux_0;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <- x86_VPBROADCAST_8u32 g_sigma1;
    leakages <- LeakAddr([1]) :: leakages;
    st.[1] <- aux_0;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <- x86_VPBROADCAST_8u32 g_sigma2;
    leakages <- LeakAddr([2]) :: leakages;
    st.[2] <- aux_0;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <- x86_VPBROADCAST_8u32 g_sigma3;
    leakages <- LeakAddr([3]) :: leakages;
    st.[3] <- aux_0;
    leakages <- LeakFor(0,8) :: LeakAddr([]) :: leakages;
    i <- 0;
    while (i < 8) {
      leakages <- LeakAddr([(W64.to_uint (key + (W64.of_int (i * 4))))]) :: leakages;
      aux_0 <- x86_VPBROADCAST_8u32 (loadW32 Glob.mem (W64.to_uint (key + (W64.of_int (i * 4)))));
      leakages <- LeakAddr([(i + 4)]) :: leakages;
      st.[(i + 4)] <- aux_0;
      i <- i + 1;
    }
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <- x86_VPBROADCAST_8u32 s_counter;
    leakages <- LeakAddr([12]) :: leakages;
    st.[12] <- aux_0;
    leakages <- LeakAddr([12]) :: leakages;
    aux_0 <- (st.[12] \vadd32u256 g_cnt);
    leakages <- LeakAddr([12]) :: leakages;
    st.[12] <- aux_0;
    leakages <- LeakFor(0,3) :: LeakAddr([]) :: leakages;
    i <- 0;
    while (i < 3) {
      leakages <- LeakAddr([(W64.to_uint (nonce + (W64.of_int (i * 4))))]) :: leakages;
      aux_0 <- x86_VPBROADCAST_8u32 (loadW32 Glob.mem (W64.to_uint (nonce + (W64.of_int (i * 4)))));
      leakages <- LeakAddr([(i + 13)]) :: leakages;
      st.[(i + 13)] <- aux_0;
      i <- i + 1;
    }
    leakages <- LeakAddr([]) :: leakages;
    aux_2 <- st;
    st_ <- aux_2;
    return (st_);
  }
  
  proc copy_state_x2 (st:W256.t Array4.t) : W256.t Array4.t = {
    var aux: W256.t Array4.t;
    
    var k:W256.t Array4.t;
    k <- witness;
    leakages <- LeakAddr([]) :: leakages;
    aux <- st;
    k <- aux;
    return (k);
  }
  
  proc copy_state_x4 (st:W256.t Array4.t) : W256.t Array4.t * W256.t Array4.t = {
    var aux_0: W256.t;
    var aux: W256.t Array4.t;
    
    var k1:W256.t Array4.t;
    var k2:W256.t Array4.t;
    k1 <- witness;
    k2 <- witness;
    leakages <- LeakAddr([]) :: leakages;
    aux <- st;
    k1 <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- st;
    k2 <- aux;
    leakages <- LeakAddr([3]) :: leakages;
    aux_0 <- (k2.[3] \vadd32u256 g_p2);
    leakages <- LeakAddr([3]) :: leakages;
    k2.[3] <- aux_0;
    return (k1, k2);
  }
  
  proc copy_state_x8 (st:W256.t Array16.t) : W256.t Array16.t = {
    var aux: W256.t Array16.t;
    
    var k:W256.t Array16.t;
    k <- witness;
    leakages <- LeakAddr([]) :: leakages;
    aux <- st;
    k <- aux;
    return (k);
  }
  
  proc sum_states_x2 (k:W256.t Array4.t, st:W256.t Array4.t) : W256.t Array4.t = {
    var aux: int;
    var aux_0: W256.t;
    
    var i:int;
    
    leakages <- LeakFor(0,4) :: LeakAddr([]) :: leakages;
    i <- 0;
    while (i < 4) {
      leakages <- LeakAddr([i; i]) :: leakages;
      aux_0 <- (k.[i] \vadd32u256 st.[i]);
      leakages <- LeakAddr([i]) :: leakages;
      k.[i] <- aux_0;
      i <- i + 1;
    }
    return (k);
  }
  
  proc sum_states_x4 (k1:W256.t Array4.t, k2:W256.t Array4.t,
                      st:W256.t Array4.t) : W256.t Array4.t * W256.t Array4.t = {
    var aux_0: W256.t;
    var aux: W256.t Array4.t;
    
    
    
    leakages <- LeakAddr([]) :: leakages;
    aux <@ sum_states_x2 (k1, st);
    k1 <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <@ sum_states_x2 (k2, st);
    k2 <- aux;
    leakages <- LeakAddr([3]) :: leakages;
    aux_0 <- (k2.[3] \vadd32u256 g_p2);
    leakages <- LeakAddr([3]) :: leakages;
    k2.[3] <- aux_0;
    return (k1, k2);
  }
  
  proc sum_states_x8 (k:W256.t Array16.t, st:W256.t Array16.t) : W256.t Array16.t = {
    var aux: int;
    var aux_0: W256.t;
    
    var i:int;
    
    leakages <- LeakFor(0,16) :: LeakAddr([]) :: leakages;
    i <- 0;
    while (i < 16) {
      leakages <- LeakAddr([i; i]) :: leakages;
      aux_0 <- (k.[i] \vadd32u256 st.[i]);
      leakages <- LeakAddr([i]) :: leakages;
      k.[i] <- aux_0;
      i <- i + 1;
    }
    return (k);
  }
  
  proc increment_counter_x8 (s:W256.t Array16.t) : W256.t Array16.t = {
    var aux: W256.t;
    
    var t:W256.t;
    
    leakages <- LeakAddr([]) :: leakages;
    aux <- g_cnt_inc;
    t <- aux;
    leakages <- LeakAddr([12]) :: leakages;
    aux <- (t \vadd32u256 s.[12]);
    t <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- t;
    leakages <- LeakAddr([12]) :: leakages;
    s.[12] <- aux;
    return (s);
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
  
  proc perm_x2 (k:W256.t Array4.t) : W256.t Array4.t = {
    var aux: W256.t;
    
    var pk:W256.t Array4.t;
    pk <- witness;
    leakages <- LeakAddr([1; 0]) :: leakages;
    aux <- x86_VPERM2I128 k.[0] k.[1] (W8.of_int (0 %% 2^4 + 2^4 * 2));
    leakages <- LeakAddr([0]) :: leakages;
    pk.[0] <- aux;
    leakages <- LeakAddr([3; 2]) :: leakages;
    aux <- x86_VPERM2I128 k.[2] k.[3] (W8.of_int (0 %% 2^4 + 2^4 * 2));
    leakages <- LeakAddr([1]) :: leakages;
    pk.[1] <- aux;
    leakages <- LeakAddr([1; 0]) :: leakages;
    aux <- x86_VPERM2I128 k.[0] k.[1] (W8.of_int (1 %% 2^4 + 2^4 * 3));
    leakages <- LeakAddr([2]) :: leakages;
    pk.[2] <- aux;
    leakages <- LeakAddr([3; 2]) :: leakages;
    aux <- x86_VPERM2I128 k.[2] k.[3] (W8.of_int (1 %% 2^4 + 2^4 * 3));
    leakages <- LeakAddr([3]) :: leakages;
    pk.[3] <- aux;
    return (pk);
  }
  
  proc perm_x4 (k1:W256.t Array4.t, k2:W256.t Array4.t) : W256.t Array4.t *
                                                          W256.t Array4.t = {
    var aux: W256.t Array4.t;
    
    var pk1:W256.t Array4.t;
    var pk2:W256.t Array4.t;
    pk1 <- witness;
    pk2 <- witness;
    leakages <- LeakAddr([]) :: leakages;
    aux <@ perm_x2 (k1);
    pk1 <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <@ perm_x2 (k2);
    pk2 <- aux;
    return (pk1, pk2);
  }
  
  proc store (output:W64.t, plain:W64.t, len:W32.t, k:W256.t Array2.t) : 
  W64.t * W64.t * W32.t * W256.t Array2.t = {
    var aux_2: W32.t;
    var aux_1: W64.t;
    var aux_0: W64.t;
    var aux: W256.t;
    
    
    
    leakages <- LeakAddr([(W64.to_uint (plain + (W64.of_int 0))); 0]) :: leakages;
    aux <- (k.[0] `^` (loadW256 Glob.mem (W64.to_uint (plain + (W64.of_int 0)))));
    leakages <- LeakAddr([0]) :: leakages;
    k.[0] <- aux;
    leakages <- LeakAddr([(W64.to_uint (plain + (W64.of_int 32))); 1]) :: leakages;
    aux <- (k.[1] `^` (loadW256 Glob.mem (W64.to_uint (plain + (W64.of_int 32)))));
    leakages <- LeakAddr([1]) :: leakages;
    k.[1] <- aux;
    leakages <- LeakAddr([0]) :: leakages;
    aux <- k.[0];
    leakages <- LeakAddr([(W64.to_uint (output + (W64.of_int 0)))]) :: leakages;
    Glob.mem <-
    storeW256 Glob.mem (W64.to_uint (output + (W64.of_int 0))) aux;
    leakages <- LeakAddr([1]) :: leakages;
    aux <- k.[1];
    leakages <- LeakAddr([(W64.to_uint (output + (W64.of_int 32)))]) :: leakages;
    Glob.mem <-
    storeW256 Glob.mem (W64.to_uint (output + (W64.of_int 32))) aux;
    leakages <- LeakAddr([]) :: leakages;
    (aux_1, aux_0, aux_2) <@ update_ptr (output, plain, len, 64);
    output <- aux_1;
    plain <- aux_0;
    len <- aux_2;
    return (output, plain, len, k);
  }
  
  proc store_last (output:W64.t, plain:W64.t, len:W32.t, k:W256.t Array2.t) : unit = {
    var aux_4: W8.t;
    var aux_2: W32.t;
    var aux_1: W64.t;
    var aux_0: W64.t;
    var aux_3: W128.t;
    var aux: W256.t;
    
    var r0:W256.t;
    var r1:W128.t;
    var s0:W8.t Array16.t;
    var j:W64.t;
    var r3:W8.t;
    s0 <- witness;
    leakages <- LeakAddr([0]) :: leakages;
    aux <- k.[0];
    r0 <- aux;
    leakages <- LeakCond(((W32.of_int 32) \ule len)) :: LeakAddr([]) :: leakages;
    if (((W32.of_int 32) \ule len)) {
      leakages <- LeakAddr([(W64.to_uint (plain + (W64.of_int 0)))]) :: leakages;
      aux <- (r0 `^` (loadW256 Glob.mem (W64.to_uint (plain + (W64.of_int 0)))));
      r0 <- aux;
      leakages <- LeakAddr([]) :: leakages;
      aux <- r0;
      leakages <- LeakAddr([(W64.to_uint (output + (W64.of_int 0)))]) :: leakages;
      Glob.mem <-
      storeW256 Glob.mem (W64.to_uint (output + (W64.of_int 0))) aux;
      leakages <- LeakAddr([]) :: leakages;
      (aux_1, aux_0, aux_2) <@ update_ptr (output, plain, len, 32);
      output <- aux_1;
      plain <- aux_0;
      len <- aux_2;
      leakages <- LeakAddr([1]) :: leakages;
      aux <- k.[1];
      r0 <- aux;
    } else {
      
    }
    leakages <- LeakAddr([]) :: leakages;
    aux_3 <- x86_VEXTRACTI128 r0 (W8.of_int 0);
    r1 <- aux_3;
    leakages <- LeakCond(((W32.of_int 16) \ule len)) :: LeakAddr([]) :: leakages;
    if (((W32.of_int 16) \ule len)) {
      leakages <- LeakAddr([(W64.to_uint (plain + (W64.of_int 0)))]) :: leakages;
      aux_3 <- (r1 `^` (loadW128 Glob.mem (W64.to_uint (plain + (W64.of_int 0)))));
      r1 <- aux_3;
      leakages <- LeakAddr([]) :: leakages;
      aux_3 <- r1;
      leakages <- LeakAddr([(W64.to_uint (output + (W64.of_int 0)))]) :: leakages;
      Glob.mem <-
      storeW128 Glob.mem (W64.to_uint (output + (W64.of_int 0))) aux_3;
      leakages <- LeakAddr([]) :: leakages;
      (aux_1, aux_0, aux_2) <@ update_ptr (output, plain, len, 16);
      output <- aux_1;
      plain <- aux_0;
      len <- aux_2;
      leakages <- LeakAddr([]) :: leakages;
      aux_3 <- x86_VEXTRACTI128 r0 (W8.of_int 1);
      r1 <- aux_3;
    } else {
      
    }
    leakages <- LeakAddr([]) :: leakages;
    aux_3 <- r1;
    leakages <- LeakAddr([0]) :: leakages;
    s0 =
    Array16.init
    (WArray16.get8 (WArray16.set128 (WArray16.init8 (fun i => s0.[i])) 0 aux_3));
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- (W64.of_int 0);
    j <- aux_1;
    
    leakages <- LeakCond(((truncateu32 j) \ult len)) :: LeakAddr([]) :: leakages;
    
    while (((truncateu32 j) \ult len)) {
      leakages <- LeakAddr([(W64.to_uint (plain + j))]) :: leakages;
      aux_4 <- (loadW8 Glob.mem (W64.to_uint (plain + j)));
      r3 <- aux_4;
      leakages <- LeakAddr([(W64.to_uint j)]) :: leakages;
      aux_4 <- (r3 `^` s0.[(W64.to_uint j)]);
      r3 <- aux_4;
      leakages <- LeakAddr([]) :: leakages;
      aux_4 <- r3;
      leakages <- LeakAddr([(W64.to_uint (output + j))]) :: leakages;
      Glob.mem <- storeW8 Glob.mem (W64.to_uint (output + j)) aux_4;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- (j + (W64.of_int 1));
      j <- aux_1;
    leakages <- LeakCond(((truncateu32 j) \ult len)) :: LeakAddr([]) :: leakages;
    
    }
    return ();
  }
  
  proc store_x2 (output:W64.t, plain:W64.t, len:W32.t, k:W256.t Array4.t) : 
  W64.t * W64.t * W32.t * W256.t Array4.t = {
    var aux: int;
    var aux_3: W32.t;
    var aux_2: W64.t;
    var aux_1: W64.t;
    var aux_0: W256.t;
    
    var i:int;
    
    leakages <- LeakFor(0,4) :: LeakAddr([]) :: leakages;
    i <- 0;
    while (i < 4) {
      leakages <- LeakAddr([(W64.to_uint (plain + (W64.of_int (32 * i)))); i]) :: leakages;
      aux_0 <- (k.[i] `^` (loadW256 Glob.mem (W64.to_uint (plain + (W64.of_int (32 * i))))));
      leakages <- LeakAddr([i]) :: leakages;
      k.[i] <- aux_0;
      i <- i + 1;
    }
    leakages <- LeakFor(0,4) :: LeakAddr([]) :: leakages;
    i <- 0;
    while (i < 4) {
      leakages <- LeakAddr([i]) :: leakages;
      aux_0 <- k.[i];
      leakages <- LeakAddr([(W64.to_uint (output + (W64.of_int (32 * i))))]) :: leakages;
      Glob.mem <-
      storeW256 Glob.mem (W64.to_uint (output + (W64.of_int (32 * i)))) aux_0;
      i <- i + 1;
    }
    leakages <- LeakAddr([]) :: leakages;
    (aux_2, aux_1, aux_3) <@ update_ptr (output, plain, len, 128);
    output <- aux_2;
    plain <- aux_1;
    len <- aux_3;
    return (output, plain, len, k);
  }
  
  proc store_x2_last (output:W64.t, plain:W64.t, len:W32.t, k:W256.t Array4.t) : unit = {
    var aux_2: W32.t;
    var aux_1: W64.t;
    var aux_0: W64.t;
    var aux: W256.t;
    var aux_3: W256.t Array2.t;
    
    var r:W256.t Array2.t;
    r <- witness;
    leakages <- LeakAddr([0]) :: leakages;
    aux <- k.[0];
    leakages <- LeakAddr([0]) :: leakages;
    r.[0] <- aux;
    leakages <- LeakAddr([1]) :: leakages;
    aux <- k.[1];
    leakages <- LeakAddr([1]) :: leakages;
    r.[1] <- aux;
    leakages <- LeakCond(((W32.of_int 64) \ule len)) :: LeakAddr([]) :: leakages;
    if (((W32.of_int 64) \ule len)) {
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
  
  proc store_x4 (output:W64.t, plain:W64.t, len:W32.t, k:W256.t Array8.t) : 
  W64.t * W64.t * W32.t = {
    var aux: int;
    var aux_3: W32.t;
    var aux_2: W64.t;
    var aux_1: W64.t;
    var aux_0: W256.t;
    
    var i:int;
    
    leakages <- LeakFor(0,8) :: LeakAddr([]) :: leakages;
    i <- 0;
    while (i < 8) {
      leakages <- LeakAddr([(W64.to_uint (plain + (W64.of_int (32 * i)))); i]) :: leakages;
      aux_0 <- (k.[i] `^` (loadW256 Glob.mem (W64.to_uint (plain + (W64.of_int (32 * i))))));
      leakages <- LeakAddr([i]) :: leakages;
      k.[i] <- aux_0;
      i <- i + 1;
    }
    leakages <- LeakFor(0,8) :: LeakAddr([]) :: leakages;
    i <- 0;
    while (i < 8) {
      leakages <- LeakAddr([i]) :: leakages;
      aux_0 <- k.[i];
      leakages <- LeakAddr([(W64.to_uint (output + (W64.of_int (32 * i))))]) :: leakages;
      Glob.mem <-
      storeW256 Glob.mem (W64.to_uint (output + (W64.of_int (32 * i)))) aux_0;
      i <- i + 1;
    }
    leakages <- LeakAddr([]) :: leakages;
    (aux_2, aux_1, aux_3) <@ update_ptr (output, plain, len, 256);
    output <- aux_2;
    plain <- aux_1;
    len <- aux_3;
    return (output, plain, len);
  }
  
  proc store_x4_last (output:W64.t, plain:W64.t, len:W32.t, k:W256.t Array8.t) : unit = {
    var aux: int;
    var aux_3: W32.t;
    var aux_2: W64.t;
    var aux_1: W64.t;
    var aux_0: W256.t;
    var aux_4: W256.t Array4.t;
    
    var i:int;
    var r:W256.t Array4.t;
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
    leakages <- LeakCond(((W32.of_int 128) \ule len)) :: LeakAddr([]) :: leakages;
    if (((W32.of_int 128) \ule len)) {
      leakages <- LeakAddr([]) :: leakages;
      (aux_2, aux_1, aux_3, aux_4) <@ store_x2 (output, plain, len, r);
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
    store_x2_last (output, plain, len, r);
    return ();
  }
  
  proc store_half_x8 (output:W64.t, plain:W64.t, len:W32.t,
                      k:W256.t Array8.t, o:int) : unit = {
    var aux: int;
    var aux_0: W256.t;
    
    var i:int;
    
    leakages <- LeakFor(0,8) :: LeakAddr([]) :: leakages;
    i <- 0;
    while (i < 8) {
      leakages <- LeakAddr([(W64.to_uint (plain + (W64.of_int (o + (64 * i)))));
                           i]) :: leakages;
      aux_0 <- (k.[i] `^` (loadW256 Glob.mem (W64.to_uint (plain + (W64.of_int (o + (64 * i)))))));
      leakages <- LeakAddr([i]) :: leakages;
      k.[i] <- aux_0;
      i <- i + 1;
    }
    leakages <- LeakFor(0,8) :: LeakAddr([]) :: leakages;
    i <- 0;
    while (i < 8) {
      leakages <- LeakAddr([i]) :: leakages;
      aux_0 <- k.[i];
      leakages <- LeakAddr([(W64.to_uint (output + (W64.of_int (o + (64 * i)))))]) :: leakages;
      Glob.mem <-
      storeW256 Glob.mem (W64.to_uint (output + (W64.of_int (o + (64 * i))))) aux_0;
      i <- i + 1;
    }
    return ();
  }
  
  proc sub_rotate (t:W256.t Array8.t) : W256.t Array8.t = {
    var aux_0: int;
    var aux: W256.t;
    
    var x:W256.t Array8.t;
    var i:int;
    x <- witness;
    leakages <- LeakAddr([1; 0]) :: leakages;
    aux <- x86_VPUNPCKL_4u64 t.[0] t.[1];
    leakages <- LeakAddr([0]) :: leakages;
    x.[0] <- aux;
    leakages <- LeakAddr([3; 2]) :: leakages;
    aux <- x86_VPUNPCKL_4u64 t.[2] t.[3];
    leakages <- LeakAddr([1]) :: leakages;
    x.[1] <- aux;
    leakages <- LeakAddr([1; 0]) :: leakages;
    aux <- x86_VPUNPCKH_4u64 t.[0] t.[1];
    leakages <- LeakAddr([2]) :: leakages;
    x.[2] <- aux;
    leakages <- LeakAddr([3; 2]) :: leakages;
    aux <- x86_VPUNPCKH_4u64 t.[2] t.[3];
    leakages <- LeakAddr([3]) :: leakages;
    x.[3] <- aux;
    leakages <- LeakAddr([5; 4]) :: leakages;
    aux <- x86_VPUNPCKL_4u64 t.[4] t.[5];
    leakages <- LeakAddr([4]) :: leakages;
    x.[4] <- aux;
    leakages <- LeakAddr([7; 6]) :: leakages;
    aux <- x86_VPUNPCKL_4u64 t.[6] t.[7];
    leakages <- LeakAddr([5]) :: leakages;
    x.[5] <- aux;
    leakages <- LeakAddr([5; 4]) :: leakages;
    aux <- x86_VPUNPCKH_4u64 t.[4] t.[5];
    leakages <- LeakAddr([6]) :: leakages;
    x.[6] <- aux;
    leakages <- LeakAddr([7; 6]) :: leakages;
    aux <- x86_VPUNPCKH_4u64 t.[6] t.[7];
    leakages <- LeakAddr([7]) :: leakages;
    x.[7] <- aux;
    leakages <- LeakFor(0,4) :: LeakAddr([]) :: leakages;
    i <- 0;
    while (i < 4) {
      leakages <- LeakAddr([((2 * i) + 1); ((2 * i) + 0)]) :: leakages;
      aux <- x86_VPERM2I128 x.[((2 * i) + 0)] x.[((2 * i) + 1)]
      (W8.of_int (0 %% 2^4 + 2^4 * 2));
      leakages <- LeakAddr([i]) :: leakages;
      t.[i] <- aux;
      leakages <- LeakAddr([((2 * i) + 1); ((2 * i) + 0)]) :: leakages;
      aux <- x86_VPERM2I128 x.[((2 * i) + 0)] x.[((2 * i) + 1)]
      (W8.of_int (1 %% 2^4 + 2^4 * 3));
      leakages <- LeakAddr([(i + 4)]) :: leakages;
      t.[(i + 4)] <- aux;
      i <- i + 1;
    }
    return (t);
  }
  
  proc rotate (x:W256.t Array8.t) : W256.t Array8.t = {
    var aux: int;
    var aux_0: W256.t;
    var aux_1: W256.t Array8.t;
    
    var t:W256.t Array8.t;
    var i:int;
    t <- witness;
    leakages <- LeakFor(0,4) :: LeakAddr([]) :: leakages;
    i <- 0;
    while (i < 4) {
      leakages <- LeakAddr([((2 * i) + 1); ((2 * i) + 0)]) :: leakages;
      aux_0 <- x86_VPUNPCKL_8u32 x.[((2 * i) + 0)] x.[((2 * i) + 1)];
      leakages <- LeakAddr([i]) :: leakages;
      t.[i] <- aux_0;
      leakages <- LeakAddr([((2 * i) + 1); ((2 * i) + 0)]) :: leakages;
      aux_0 <- x86_VPUNPCKH_8u32 x.[((2 * i) + 0)] x.[((2 * i) + 1)];
      leakages <- LeakAddr([(i + 4)]) :: leakages;
      t.[(i + 4)] <- aux_0;
      i <- i + 1;
    }
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <@ sub_rotate (t);
    t <- aux_1;
    return (t);
  }
  
  proc rotate_stack (s:W256.t Array8.t) : W256.t Array8.t = {
    var aux: int;
    var aux_0: W256.t;
    var aux_1: W256.t Array8.t;
    
    var t:W256.t Array8.t;
    var i:int;
    var x:W256.t Array8.t;
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
      aux_0 <- x86_VPUNPCKL_8u32 x.[i] s.[((2 * i) + 1)];
      leakages <- LeakAddr([i]) :: leakages;
      t.[i] <- aux_0;
      leakages <- LeakAddr([((2 * i) + 1); i]) :: leakages;
      aux_0 <- x86_VPUNPCKH_8u32 x.[i] s.[((2 * i) + 1)];
      leakages <- LeakAddr([(4 + i)]) :: leakages;
      t.[(4 + i)] <- aux_0;
      i <- i + 1;
    }
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <@ sub_rotate (t);
    t <- aux_1;
    return (t);
  }
  
  proc rotate_first_half_x8 (k:W256.t Array16.t) : W256.t Array8.t *
                                                   W256.t Array8.t = {
    var aux: int;
    var aux_0: W256.t;
    var aux_1: W256.t Array8.t;
    
    var k0_7:W256.t Array8.t;
    var s_k8_15:W256.t Array8.t;
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
  
  proc rotate_second_half_x8 (s_k8_15:W256.t Array8.t) : W256.t Array8.t = {
    var aux: W256.t Array8.t;
    
    var k8_15:W256.t Array8.t;
    k8_15 <- witness;
    leakages <- LeakAddr([]) :: leakages;
    aux <@ rotate_stack (s_k8_15);
    k8_15 <- aux;
    return (k8_15);
  }
  
  proc interleave_0 (s:W256.t Array8.t, k:W256.t Array8.t, o:int) : W256.t Array8.t = {
    var aux: int;
    var aux_0: W256.t;
    
    var sk:W256.t Array8.t;
    var i:int;
    sk <- witness;
    leakages <- LeakFor(0,4) :: LeakAddr([]) :: leakages;
    i <- 0;
    while (i < 4) {
      leakages <- LeakAddr([(o + i)]) :: leakages;
      aux_0 <- s.[(o + i)];
      leakages <- LeakAddr([((2 * i) + 0)]) :: leakages;
      sk.[((2 * i) + 0)] <- aux_0;
      leakages <- LeakAddr([(o + i)]) :: leakages;
      aux_0 <- k.[(o + i)];
      leakages <- LeakAddr([((2 * i) + 1)]) :: leakages;
      sk.[((2 * i) + 1)] <- aux_0;
      i <- i + 1;
    }
    return (sk);
  }
  
  proc store_x8 (output:W64.t, plain:W64.t, len:W32.t, k:W256.t Array16.t) : 
  W64.t * W64.t * W32.t = {
    var aux_3: W32.t;
    var aux_2: W64.t;
    var aux_1: W64.t;
    var aux_0: W256.t Array8.t;
    var aux: W256.t Array8.t;
    
    var k0_7:W256.t Array8.t;
    var s_k8_15:W256.t Array8.t;
    var k8_15:W256.t Array8.t;
    k0_7 <- witness;
    k8_15 <- witness;
    s_k8_15 <- witness;
    leakages <- LeakAddr([]) :: leakages;
    (aux_0, aux) <@ rotate_first_half_x8 (k);
    k0_7 <- aux_0;
    s_k8_15 <- aux;
    leakages <- LeakAddr([]) :: leakages;
    store_half_x8 (output, plain, len, k0_7, 0);
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <@ rotate_second_half_x8 (s_k8_15);
    k8_15 <- aux_0;
    leakages <- LeakAddr([]) :: leakages;
    store_half_x8 (output, plain, len, k8_15, 32);
    leakages <- LeakAddr([]) :: leakages;
    (aux_2, aux_1, aux_3) <@ update_ptr (output, plain, len, 512);
    output <- aux_2;
    plain <- aux_1;
    len <- aux_3;
    return (output, plain, len);
  }
  
  proc store_x8_last (output:W64.t, plain:W64.t, len:W32.t,
                      k:W256.t Array16.t) : unit = {
    var aux_3: W32.t;
    var aux_2: W64.t;
    var aux_1: W64.t;
    var aux_0: W256.t Array8.t;
    var aux: W256.t Array8.t;
    
    var k0_7:W256.t Array8.t;
    var s_k8_15:W256.t Array8.t;
    var s_k0_7:W256.t Array8.t;
    var k8_15:W256.t Array8.t;
    var i0_7:W256.t Array8.t;
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
    leakages <- LeakCond(((W32.of_int 256) \ule len)) :: LeakAddr([]) :: leakages;
    if (((W32.of_int 256) \ule len)) {
      leakages <- LeakAddr([]) :: leakages;
      (aux_2, aux_1, aux_3) <@ store_x4 (output, plain, len, i0_7);
      output <- aux_2;
      plain <- aux_1;
      len <- aux_3;
      leakages <- LeakAddr([]) :: leakages;
      aux_0 <@ interleave_0 (s_k0_7, k8_15, 4);
      i0_7 <- aux_0;
    } else {
      
    }
    leakages <- LeakAddr([]) :: leakages;
    store_x4_last (output, plain, len, i0_7);
    return ();
  }
  
  proc rotate_x8 (k:W256.t Array4.t, i:int, r:int, r16:W256.t, r8:W256.t) : 
  W256.t Array4.t = {
    var aux: W256.t;
    
    var t:W256.t;
    
    leakages <- LeakCond((r = 16)) :: LeakAddr([]) :: leakages;
    if ((r = 16)) {
      leakages <- LeakAddr([i]) :: leakages;
      aux <- x86_VPSHUFB_256 k.[i] r16;
      leakages <- LeakAddr([i]) :: leakages;
      k.[i] <- aux;
    } else {
      leakages <- LeakCond((r = 8)) :: LeakAddr([]) :: leakages;
      if ((r = 8)) {
        leakages <- LeakAddr([i]) :: leakages;
        aux <- x86_VPSHUFB_256 k.[i] r8;
        leakages <- LeakAddr([i]) :: leakages;
        k.[i] <- aux;
      } else {
        leakages <- LeakAddr([i]) :: leakages;
        aux <- (k.[i] \vshl32u256 (W8.of_int r));
        t <- aux;
        leakages <- LeakAddr([i]) :: leakages;
        aux <- (k.[i] \vshr32u256 (W8.of_int (32 - r)));
        leakages <- LeakAddr([i]) :: leakages;
        k.[i] <- aux;
        leakages <- LeakAddr([i]) :: leakages;
        aux <- (k.[i] `^` t);
        leakages <- LeakAddr([i]) :: leakages;
        k.[i] <- aux;
      }
    }
    return (k);
  }
  
  proc line_x8 (k:W256.t Array4.t, a:int, b:int, c:int, r:int, r16:W256.t,
                r8:W256.t) : W256.t Array4.t = {
    var aux: W256.t;
    var aux_0: W256.t Array4.t;
    
    
    
    leakages <- LeakAddr([(b %/ 4); (a %/ 4)]) :: leakages;
    aux <- (k.[(a %/ 4)] \vadd32u256 k.[(b %/ 4)]);
    leakages <- LeakAddr([(a %/ 4)]) :: leakages;
    k.[(a %/ 4)] <- aux;
    leakages <- LeakAddr([(a %/ 4); (c %/ 4)]) :: leakages;
    aux <- (k.[(c %/ 4)] `^` k.[(a %/ 4)]);
    leakages <- LeakAddr([(c %/ 4)]) :: leakages;
    k.[(c %/ 4)] <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <@ rotate_x8 (k, (c %/ 4), r, r16, r8);
    k <- aux_0;
    return (k);
  }
  
  proc round_x2 (k:W256.t Array4.t, r16:W256.t, r8:W256.t) : W256.t Array4.t = {
    var aux: W256.t Array4.t;
    
    
    
    leakages <- LeakAddr([]) :: leakages;
    aux <@ line_x8 (k, 0, 4, 12, 16, r16, r8);
    k <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <@ line_x8 (k, 8, 12, 4, 12, r16, r8);
    k <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <@ line_x8 (k, 0, 4, 12, 8, r16, r8);
    k <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <@ line_x8 (k, 8, 12, 4, 7, r16, r8);
    k <- aux;
    return (k);
  }
  
  proc column_round_x2 (k:W256.t Array4.t, r16:W256.t, r8:W256.t) : W256.t Array4.t = {
    var aux: W256.t Array4.t;
    
    
    
    leakages <- LeakAddr([]) :: leakages;
    aux <@ round_x2 (k, r16, r8);
    k <- aux;
    return (k);
  }
  
  proc shuffle_state (k:W256.t Array4.t) : W256.t Array4.t = {
    var aux: W256.t;
    
    
    
    leakages <- LeakAddr([1]) :: leakages;
    aux <- x86_VPSHUFD_256 k.[1]
    (W8.of_int (1 %% 2^2 + 2^2 * (2 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    leakages <- LeakAddr([1]) :: leakages;
    k.[1] <- aux;
    leakages <- LeakAddr([2]) :: leakages;
    aux <- x86_VPSHUFD_256 k.[2]
    (W8.of_int (2 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 1))));
    leakages <- LeakAddr([2]) :: leakages;
    k.[2] <- aux;
    leakages <- LeakAddr([3]) :: leakages;
    aux <- x86_VPSHUFD_256 k.[3]
    (W8.of_int (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (1 %% 2^2 + 2^2 * 2))));
    leakages <- LeakAddr([3]) :: leakages;
    k.[3] <- aux;
    return (k);
  }
  
  proc reverse_shuffle_state (k:W256.t Array4.t) : W256.t Array4.t = {
    var aux: W256.t;
    
    
    
    leakages <- LeakAddr([1]) :: leakages;
    aux <- x86_VPSHUFD_256 k.[1]
    (W8.of_int (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (1 %% 2^2 + 2^2 * 2))));
    leakages <- LeakAddr([1]) :: leakages;
    k.[1] <- aux;
    leakages <- LeakAddr([2]) :: leakages;
    aux <- x86_VPSHUFD_256 k.[2]
    (W8.of_int (2 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 1))));
    leakages <- LeakAddr([2]) :: leakages;
    k.[2] <- aux;
    leakages <- LeakAddr([3]) :: leakages;
    aux <- x86_VPSHUFD_256 k.[3]
    (W8.of_int (1 %% 2^2 + 2^2 * (2 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    leakages <- LeakAddr([3]) :: leakages;
    k.[3] <- aux;
    return (k);
  }
  
  proc diagonal_round_x2 (k:W256.t Array4.t, r16:W256.t, r8:W256.t) : 
  W256.t Array4.t = {
    var aux: W256.t Array4.t;
    
    
    
    leakages <- LeakAddr([]) :: leakages;
    aux <@ shuffle_state (k);
    k <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <@ round_x2 (k, r16, r8);
    k <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <@ reverse_shuffle_state (k);
    k <- aux;
    return (k);
  }
  
  proc rounds_x2 (k:W256.t Array4.t) : W256.t Array4.t = {
    var aux_0: W64.t;
    var aux: W256.t;
    var aux_1: W256.t Array4.t;
    
    var r16:W256.t;
    var r8:W256.t;
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
      aux_1 <@ column_round_x2 (k, r16, r8);
      k <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <@ diagonal_round_x2 (k, r16, r8);
      k <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_0 <- (c + (W64.of_int 1));
      c <- aux_0;
    leakages <- LeakCond((c \ult (W64.of_int 10))) :: LeakAddr([]) :: leakages;
    
    }
    return (k);
  }
  
  proc round_x4 (k1:W256.t Array4.t, k2:W256.t Array4.t, r16:W256.t,
                 r8:W256.t) : W256.t Array4.t * W256.t Array4.t = {
    var aux: W256.t Array4.t;
    
    
    
    leakages <- LeakAddr([]) :: leakages;
    aux <@ round_x2 (k1, r16, r8);
    k1 <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <@ round_x2 (k2, r16, r8);
    k2 <- aux;
    return (k1, k2);
  }
  
  proc column_round_x4 (k1:W256.t Array4.t, k2:W256.t Array4.t, r16:W256.t,
                        r8:W256.t) : W256.t Array4.t * W256.t Array4.t = {
    var aux_0: W256.t Array4.t;
    var aux: W256.t Array4.t;
    
    
    
    leakages <- LeakAddr([]) :: leakages;
    (aux_0, aux) <@ round_x4 (k1, k2, r16, r8);
    k1 <- aux_0;
    k2 <- aux;
    return (k1, k2);
  }
  
  proc shuffle_state_x2 (k1:W256.t Array4.t, k2:W256.t Array4.t) : W256.t Array4.t *
                                                                   W256.t Array4.t = {
    var aux: W256.t Array4.t;
    
    
    
    leakages <- LeakAddr([]) :: leakages;
    aux <@ shuffle_state (k1);
    k1 <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <@ shuffle_state (k2);
    k2 <- aux;
    return (k1, k2);
  }
  
  proc reverse_shuffle_state_x2 (k1:W256.t Array4.t, k2:W256.t Array4.t) : 
  W256.t Array4.t * W256.t Array4.t = {
    var aux: W256.t Array4.t;
    
    
    
    leakages <- LeakAddr([]) :: leakages;
    aux <@ reverse_shuffle_state (k1);
    k1 <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <@ reverse_shuffle_state (k2);
    k2 <- aux;
    return (k1, k2);
  }
  
  proc diagonal_round_x4 (k1:W256.t Array4.t, k2:W256.t Array4.t, r16:W256.t,
                          r8:W256.t) : W256.t Array4.t * W256.t Array4.t = {
    var aux_0: W256.t Array4.t;
    var aux: W256.t Array4.t;
    
    
    
    leakages <- LeakAddr([]) :: leakages;
    (aux_0, aux) <@ shuffle_state_x2 (k1, k2);
    k1 <- aux_0;
    k2 <- aux;
    leakages <- LeakAddr([]) :: leakages;
    (aux_0, aux) <@ round_x4 (k1, k2, r16, r8);
    k1 <- aux_0;
    k2 <- aux;
    leakages <- LeakAddr([]) :: leakages;
    (aux_0, aux) <@ reverse_shuffle_state_x2 (k1, k2);
    k1 <- aux_0;
    k2 <- aux;
    return (k1, k2);
  }
  
  proc rounds_x4 (k1:W256.t Array4.t, k2:W256.t Array4.t) : W256.t Array4.t *
                                                            W256.t Array4.t = {
    var aux_0: W64.t;
    var aux: W256.t;
    var aux_2: W256.t Array4.t;
    var aux_1: W256.t Array4.t;
    
    var r16:W256.t;
    var r8:W256.t;
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
      (aux_2, aux_1) <@ column_round_x4 (k1, k2, r16, r8);
      k1 <- aux_2;
      k2 <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      (aux_2, aux_1) <@ diagonal_round_x4 (k1, k2, r16, r8);
      k1 <- aux_2;
      k2 <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_0 <- (c + (W64.of_int 1));
      c <- aux_0;
    leakages <- LeakCond((c \ult (W64.of_int 10))) :: LeakAddr([]) :: leakages;
    
    }
    return (k1, k2);
  }
  
  proc rotate_x8_s (k:W256.t Array16.t, i:int, r:int, r16:W256.t, r8:W256.t) : 
  W256.t Array16.t = {
    var aux: W256.t;
    
    var t:W256.t;
    
    leakages <- LeakCond((r = 16)) :: LeakAddr([]) :: leakages;
    if ((r = 16)) {
      leakages <- LeakAddr([i]) :: leakages;
      aux <- x86_VPSHUFB_256 k.[i] r16;
      leakages <- LeakAddr([i]) :: leakages;
      k.[i] <- aux;
    } else {
      leakages <- LeakCond((r = 8)) :: LeakAddr([]) :: leakages;
      if ((r = 8)) {
        leakages <- LeakAddr([i]) :: leakages;
        aux <- x86_VPSHUFB_256 k.[i] r8;
        leakages <- LeakAddr([i]) :: leakages;
        k.[i] <- aux;
      } else {
        leakages <- LeakAddr([i]) :: leakages;
        aux <- (k.[i] \vshl32u256 (W8.of_int r));
        t <- aux;
        leakages <- LeakAddr([i]) :: leakages;
        aux <- (k.[i] \vshr32u256 (W8.of_int (32 - r)));
        leakages <- LeakAddr([i]) :: leakages;
        k.[i] <- aux;
        leakages <- LeakAddr([i]) :: leakages;
        aux <- (k.[i] `^` t);
        leakages <- LeakAddr([i]) :: leakages;
        k.[i] <- aux;
      }
    }
    return (k);
  }
  
  proc _line_x8_v (k:W256.t Array16.t, a:int, b:int, c:int, r:int,
                   r16:W256.t, r8:W256.t) : W256.t Array16.t = {
    var aux: W256.t;
    var aux_0: W256.t Array16.t;
    
    
    
    leakages <- LeakAddr([b; a]) :: leakages;
    aux <- (k.[a] \vadd32u256 k.[b]);
    leakages <- LeakAddr([a]) :: leakages;
    k.[a] <- aux;
    leakages <- LeakAddr([a; c]) :: leakages;
    aux <- (k.[c] `^` k.[a]);
    leakages <- LeakAddr([c]) :: leakages;
    k.[c] <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <@ rotate_x8_s (k, c, r, r16, r8);
    k <- aux_0;
    return (k);
  }
  
  proc line_x8_v (k:W256.t Array16.t, a0:int, b0:int, c0:int, r0:int, a1:int,
                  b1:int, c1:int, r1:int, r16:W256.t, r8:W256.t) : W256.t Array16.t = {
    var aux: W256.t;
    var aux_0: W256.t Array16.t;
    
    
    
    leakages <- LeakAddr([b0; a0]) :: leakages;
    aux <- (k.[a0] \vadd32u256 k.[b0]);
    leakages <- LeakAddr([a0]) :: leakages;
    k.[a0] <- aux;
    leakages <- LeakAddr([b1; a1]) :: leakages;
    aux <- (k.[a1] \vadd32u256 k.[b1]);
    leakages <- LeakAddr([a1]) :: leakages;
    k.[a1] <- aux;
    leakages <- LeakAddr([a0; c0]) :: leakages;
    aux <- (k.[c0] `^` k.[a0]);
    leakages <- LeakAddr([c0]) :: leakages;
    k.[c0] <- aux;
    leakages <- LeakAddr([a1; c1]) :: leakages;
    aux <- (k.[c1] `^` k.[a1]);
    leakages <- LeakAddr([c1]) :: leakages;
    k.[c1] <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <@ rotate_x8_s (k, c0, r0, r16, r8);
    k <- aux_0;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <@ rotate_x8_s (k, c1, r1, r16, r8);
    k <- aux_0;
    return (k);
  }
  
  proc double_quarter_round_x8 (k:W256.t Array16.t, a0:int, b0:int, c0:int,
                                d0:int, a1:int, b1:int, c1:int, d1:int,
                                r16:W256.t, r8:W256.t) : W256.t Array16.t = {
    var aux: W256.t Array16.t;
    
    
    
    leakages <- LeakAddr([]) :: leakages;
    aux <@ _line_x8_v (k, a0, b0, d0, 16, r16, r8);
    k <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <@ line_x8_v (k, c0, d0, b0, 12, a1, b1, d1, 16, r16, r8);
    k <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <@ line_x8_v (k, a0, b0, d0, 8, c1, d1, b1, 12, r16, r8);
    k <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <@ line_x8_v (k, c0, d0, b0, 7, a1, b1, d1, 8, r16, r8);
    k <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <@ _line_x8_v (k, c1, d1, b1, 7, r16, r8);
    k <- aux;
    return (k);
  }
  
  proc column_round_x8 (k:W256.t Array16.t, k15:W256.t, s_r16:W256.t,
                        s_r8:W256.t) : W256.t Array16.t * W256.t = {
    var aux_0: W256.t;
    var aux: W256.t Array16.t;
    
    var k_:W256.t;
    
    leakages <- LeakAddr([]) :: leakages;
    aux <@ double_quarter_round_x8 (k, 0, 4, 8, 12, 2, 6, 10, 14, s_r16,
    s_r8);
    k <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <- k15;
    leakages <- LeakAddr([15]) :: leakages;
    k.[15] <- aux_0;
    leakages <- LeakAddr([14]) :: leakages;
    aux_0 <- k.[14];
    k_ <- aux_0;
    leakages <- LeakAddr([]) :: leakages;
    aux <@ double_quarter_round_x8 (k, 1, 5, 9, 13, 3, 7, 11, 15, s_r16,
    s_r8);
    k <- aux;
    return (k, k_);
  }
  
  proc diagonal_round_x8 (k:W256.t Array16.t, k14:W256.t, s_r16:W256.t,
                          s_r8:W256.t) : W256.t Array16.t * W256.t = {
    var aux_0: W256.t;
    var aux: W256.t Array16.t;
    
    var k_:W256.t;
    
    leakages <- LeakAddr([]) :: leakages;
    aux <@ double_quarter_round_x8 (k, 1, 6, 11, 12, 0, 5, 10, 15, s_r16,
    s_r8);
    k <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <- k14;
    leakages <- LeakAddr([14]) :: leakages;
    k.[14] <- aux_0;
    leakages <- LeakAddr([15]) :: leakages;
    aux_0 <- k.[15];
    k_ <- aux_0;
    leakages <- LeakAddr([]) :: leakages;
    aux <@ double_quarter_round_x8 (k, 2, 7, 8, 13, 3, 4, 9, 14, s_r16,
    s_r8);
    k <- aux;
    return (k, k_);
  }
  
  proc rounds_x8 (k:W256.t Array16.t, s_r16:W256.t, s_r8:W256.t) : W256.t Array16.t = {
    var aux_0: W64.t;
    var aux: W256.t;
    var aux_1: W256.t Array16.t;
    
    var k15:W256.t;
    var c:W64.t;
    var k14:W256.t;
    
    leakages <- LeakAddr([15]) :: leakages;
    aux <- k.[15];
    k15 <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <- (W64.of_int 0);
    c <- aux_0;
    
    leakages <- LeakCond((c \ult (W64.of_int 10))) :: LeakAddr([]) :: leakages;
    
    while ((c \ult (W64.of_int 10))) {
      leakages <- LeakAddr([]) :: leakages;
      (aux_1, aux) <@ column_round_x8 (k, k15, s_r16, s_r8);
      k <- aux_1;
      k14 <- aux;
      leakages <- LeakAddr([]) :: leakages;
      (aux_1, aux) <@ diagonal_round_x8 (k, k14, s_r16, s_r8);
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
  
  proc chacha20_more_than_256 (output:W64.t, plain:W64.t, len:W32.t,
                               key:W64.t, nonce:W64.t, counter:W32.t) : unit = {
    var aux_4: W32.t;
    var aux_3: W64.t;
    var aux_2: W64.t;
    var aux_0: W256.t;
    var aux: W256.t;
    var aux_1: W256.t Array16.t;
    
    var s_r16:W256.t;
    var s_r8:W256.t;
    var st:W256.t Array16.t;
    var k:W256.t Array16.t;
    k <- witness;
    st <- witness;
    leakages <- LeakAddr([]) :: leakages;
    (aux_0, aux) <@ load_shufb_cmd ();
    s_r16 <- aux_0;
    s_r8 <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <@ init_x8 (key, nonce, counter);
    st <- aux_1;
    
    leakages <- LeakCond(((W32.of_int 512) \ule len)) :: LeakAddr([]) :: leakages;
    
    while (((W32.of_int 512) \ule len)) {
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <@ copy_state_x8 (st);
      k <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <@ rounds_x8 (k, s_r16, s_r8);
      k <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <@ sum_states_x8 (k, st);
      k <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      (aux_3, aux_2, aux_4) <@ store_x8 (output, plain, len, k);
      output <- aux_3;
      plain <- aux_2;
      len <- aux_4;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <@ increment_counter_x8 (st);
      st <- aux_1;
    leakages <- LeakCond(((W32.of_int 512) \ule len)) :: LeakAddr([]) :: leakages;
    
    }
    leakages <- LeakCond(((W32.of_int 0) \ult len)) :: LeakAddr([]) :: leakages;
    if (((W32.of_int 0) \ult len)) {
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <@ copy_state_x8 (st);
      k <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <@ rounds_x8 (k, s_r16, s_r8);
      k <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <@ sum_states_x8 (k, st);
      k <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      store_x8_last (output, plain, len, k);
    } else {
      
    }
    return ();
  }
  
  proc chacha20_less_than_257 (output:W64.t, plain:W64.t, len:W32.t,
                               key:W64.t, nonce:W64.t, counter:W32.t) : unit = {
    var aux_3: W32.t;
    var aux_2: W64.t;
    var aux_1: W64.t;
    var aux_0: W256.t Array4.t;
    var aux: W256.t Array4.t;
    
    var st:W256.t Array4.t;
    var k1:W256.t Array4.t;
    var k2:W256.t Array4.t;
    k1 <- witness;
    k2 <- witness;
    st <- witness;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <@ init_x2 (key, nonce, counter);
    st <- aux_0;
    leakages <- LeakCond(((W32.of_int 128) \ult len)) :: LeakAddr([]) :: leakages;
    if (((W32.of_int 128) \ult len)) {
      leakages <- LeakAddr([]) :: leakages;
      (aux_0, aux) <@ copy_state_x4 (st);
      k1 <- aux_0;
      k2 <- aux;
      leakages <- LeakAddr([]) :: leakages;
      (aux_0, aux) <@ rounds_x4 (k1, k2);
      k1 <- aux_0;
      k2 <- aux;
      leakages <- LeakAddr([]) :: leakages;
      (aux_0, aux) <@ sum_states_x4 (k1, k2, st);
      k1 <- aux_0;
      k2 <- aux;
      leakages <- LeakAddr([]) :: leakages;
      (aux_0, aux) <@ perm_x4 (k1, k2);
      k1 <- aux_0;
      k2 <- aux;
      leakages <- LeakAddr([]) :: leakages;
      (aux_2, aux_1, aux_3, aux_0) <@ store_x2 (output, plain, len, k1);
      output <- aux_2;
      plain <- aux_1;
      len <- aux_3;
      k1 <- aux_0;
      leakages <- LeakAddr([]) :: leakages;
      store_x2_last (output, plain, len, k2);
    } else {
      leakages <- LeakAddr([]) :: leakages;
      aux_0 <@ copy_state_x2 (st);
      k1 <- aux_0;
      leakages <- LeakAddr([]) :: leakages;
      aux_0 <@ rounds_x2 (k1);
      k1 <- aux_0;
      leakages <- LeakAddr([]) :: leakages;
      aux_0 <@ sum_states_x2 (k1, st);
      k1 <- aux_0;
      leakages <- LeakAddr([]) :: leakages;
      aux_0 <@ perm_x2 (k1);
      k1 <- aux_0;
      leakages <- LeakAddr([]) :: leakages;
      store_x2_last (output, plain, len, k1);
    }
    return ();
  }
  
  proc chacha20_avx2 (output:W64.t, plain:W64.t, len:W32.t, key:W64.t,
                      nonce:W64.t, counter:W32.t) : unit = {
    
    
    
    leakages <- LeakCond((len \ult (W32.of_int 257))) :: LeakAddr([]) :: leakages;
    if ((len \ult (W32.of_int 257))) {
      leakages <- LeakAddr([]) :: leakages;
      chacha20_less_than_257 (output, plain, len, key, nonce, counter);
    } else {
      leakages <- LeakAddr([]) :: leakages;
      chacha20_more_than_256 (output, plain, len, key, nonce, counter);
    }
    return ();
  }
}.


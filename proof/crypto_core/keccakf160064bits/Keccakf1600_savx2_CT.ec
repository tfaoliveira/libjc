require import List Int IntExtra IntDiv CoreMap.
from Jasmin require import JModel.

require import Array7 Array9.
require import WArray224 WArray288.



module M = {
  var leakages : leakages_t
  
  proc __keccakf1600_avx2 (state:W256.t Array7.t, _rhotates_left:W64.t,
                           _rhotates_right:W64.t, _iotas:W64.t) : W256.t Array7.t = {
    var aux_5: bool;
    var aux_4: bool;
    var aux_3: bool;
    var aux_2: bool;
    var aux_0: W32.t;
    var aux: W64.t;
    var aux_1: W256.t;
    
    var rhotates_left:W64.t;
    var rhotates_right:W64.t;
    var iotas:W64.t;
    var r:W32.t;
    var zf:bool;
    var c00:W256.t;
    var c14:W256.t;
    var t:W256.t Array9.t;
    var d14:W256.t;
    var d00:W256.t;
    var  _0:bool;
    var  _1:bool;
    var  _2:bool;
    t <- witness;
    leakages <- LeakAddr([]) :: leakages;
    aux <- (_rhotates_left + (W64.of_int 96));
    rhotates_left <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- (_rhotates_right + (W64.of_int 96));
    rhotates_right <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux <- _iotas;
    iotas <- aux;
    leakages <- LeakAddr([]) :: leakages;
    aux_0 <- (W32.of_int 24);
    r <- aux_0;
    leakages <- LeakAddr([2]) :: leakages;
    aux_1 <- x86_VPSHUFD_256 state.[2]
    (W8.of_int (2 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 1))));
    c00 <- aux_1;
    leakages <- LeakAddr([3; 5]) :: leakages;
    aux_1 <- (state.[5] `^` state.[3]);
    c14 <- aux_1;
    leakages <- LeakAddr([6; 4]) :: leakages;
    aux_1 <- (state.[4] `^` state.[6]);
    leakages <- LeakAddr([2]) :: leakages;
    t.[2] <- aux_1;
    leakages <- LeakAddr([1]) :: leakages;
    aux_1 <- (c14 `^` state.[1]);
    c14 <- aux_1;
    leakages <- LeakAddr([2]) :: leakages;
    aux_1 <- (c14 `^` t.[2]);
    c14 <- aux_1;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- x86_VPERMQ c14
    (W8.of_int (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (1 %% 2^2 + 2^2 * 2))));
    leakages <- LeakAddr([4]) :: leakages;
    t.[4] <- aux_1;
    leakages <- LeakAddr([2]) :: leakages;
    aux_1 <- (c00 `^` state.[2]);
    c00 <- aux_1;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- x86_VPERMQ c00
    (W8.of_int (2 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 1))));
    leakages <- LeakAddr([0]) :: leakages;
    t.[0] <- aux_1;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- (c14 \vshr64u256 (W8.of_int 63));
    leakages <- LeakAddr([1]) :: leakages;
    t.[1] <- aux_1;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- (c14 \vadd64u256 c14);
    leakages <- LeakAddr([2]) :: leakages;
    t.[2] <- aux_1;
    leakages <- LeakAddr([2; 1]) :: leakages;
    aux_1 <- (t.[1] `|` t.[2]);
    leakages <- LeakAddr([1]) :: leakages;
    t.[1] <- aux_1;
    leakages <- LeakAddr([1]) :: leakages;
    aux_1 <- x86_VPERMQ t.[1]
    (W8.of_int (1 %% 2^2 + 2^2 * (2 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    d14 <- aux_1;
    leakages <- LeakAddr([4; 1]) :: leakages;
    aux_1 <- (t.[1] `^` t.[4]);
    d00 <- aux_1;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- x86_VPERMQ d00
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
    d00 <- aux_1;
    leakages <- LeakAddr([0]) :: leakages;
    aux_1 <- (c00 `^` state.[0]);
    c00 <- aux_1;
    leakages <- LeakAddr([0]) :: leakages;
    aux_1 <- (c00 `^` t.[0]);
    c00 <- aux_1;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- (c00 \vshr64u256 (W8.of_int 63));
    leakages <- LeakAddr([0]) :: leakages;
    t.[0] <- aux_1;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- (c00 \vadd64u256 c00);
    leakages <- LeakAddr([1]) :: leakages;
    t.[1] <- aux_1;
    leakages <- LeakAddr([0; 1]) :: leakages;
    aux_1 <- (t.[1] `|` t.[0]);
    leakages <- LeakAddr([1]) :: leakages;
    t.[1] <- aux_1;
    leakages <- LeakAddr([2]) :: leakages;
    aux_1 <- (state.[2] `^` d00);
    leakages <- LeakAddr([2]) :: leakages;
    state.[2] <- aux_1;
    leakages <- LeakAddr([0]) :: leakages;
    aux_1 <- (state.[0] `^` d00);
    leakages <- LeakAddr([0]) :: leakages;
    state.[0] <- aux_1;
    leakages <- LeakAddr([1]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 d14 t.[1]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (1 %% 2^1 + 2^1 * 1))))))));
    d14 <- aux_1;
    leakages <- LeakAddr([4]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[4] c00
    (W8.of_int (1 %% 2^1 +
               2^1 * (1 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    leakages <- LeakAddr([4]) :: leakages;
    t.[4] <- aux_1;
    leakages <- LeakAddr([4]) :: leakages;
    aux_1 <- (d14 `^` t.[4]);
    d14 <- aux_1;
    leakages <- LeakAddr([(W64.to_uint (rhotates_left + (W64.of_int ((32 * 0) - 96))));
                         2]) :: leakages;
    aux_1 <- x86_VPSLLV_4u64 state.[2]
    (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((32 * 0) - 96)))));
    leakages <- LeakAddr([3]) :: leakages;
    t.[3] <- aux_1;
    leakages <- LeakAddr([(W64.to_uint (rhotates_right + (W64.of_int ((32 * 0) - 96))));
                         2]) :: leakages;
    aux_1 <- x86_VPSRLV_4u64 state.[2]
    (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((32 * 0) - 96)))));
    leakages <- LeakAddr([2]) :: leakages;
    state.[2] <- aux_1;
    leakages <- LeakAddr([3; 2]) :: leakages;
    aux_1 <- (state.[2] `|` t.[3]);
    leakages <- LeakAddr([2]) :: leakages;
    state.[2] <- aux_1;
    leakages <- LeakAddr([3]) :: leakages;
    aux_1 <- (state.[3] `^` d14);
    leakages <- LeakAddr([3]) :: leakages;
    state.[3] <- aux_1;
    leakages <- LeakAddr([(W64.to_uint (rhotates_left + (W64.of_int ((32 * 2) - 96))));
                         3]) :: leakages;
    aux_1 <- x86_VPSLLV_4u64 state.[3]
    (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((32 * 2) - 96)))));
    leakages <- LeakAddr([4]) :: leakages;
    t.[4] <- aux_1;
    leakages <- LeakAddr([(W64.to_uint (rhotates_right + (W64.of_int ((32 * 2) - 96))));
                         3]) :: leakages;
    aux_1 <- x86_VPSRLV_4u64 state.[3]
    (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((32 * 2) - 96)))));
    leakages <- LeakAddr([3]) :: leakages;
    state.[3] <- aux_1;
    leakages <- LeakAddr([4; 3]) :: leakages;
    aux_1 <- (state.[3] `|` t.[4]);
    leakages <- LeakAddr([3]) :: leakages;
    state.[3] <- aux_1;
    leakages <- LeakAddr([4]) :: leakages;
    aux_1 <- (state.[4] `^` d14);
    leakages <- LeakAddr([4]) :: leakages;
    state.[4] <- aux_1;
    leakages <- LeakAddr([(W64.to_uint (rhotates_left + (W64.of_int ((32 * 3) - 96))));
                         4]) :: leakages;
    aux_1 <- x86_VPSLLV_4u64 state.[4]
    (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((32 * 3) - 96)))));
    leakages <- LeakAddr([5]) :: leakages;
    t.[5] <- aux_1;
    leakages <- LeakAddr([(W64.to_uint (rhotates_right + (W64.of_int ((32 * 3) - 96))));
                         4]) :: leakages;
    aux_1 <- x86_VPSRLV_4u64 state.[4]
    (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((32 * 3) - 96)))));
    leakages <- LeakAddr([4]) :: leakages;
    state.[4] <- aux_1;
    leakages <- LeakAddr([5; 4]) :: leakages;
    aux_1 <- (state.[4] `|` t.[5]);
    leakages <- LeakAddr([4]) :: leakages;
    state.[4] <- aux_1;
    leakages <- LeakAddr([5]) :: leakages;
    aux_1 <- (state.[5] `^` d14);
    leakages <- LeakAddr([5]) :: leakages;
    state.[5] <- aux_1;
    leakages <- LeakAddr([(W64.to_uint (rhotates_left + (W64.of_int ((32 * 4) - 96))));
                         5]) :: leakages;
    aux_1 <- x86_VPSLLV_4u64 state.[5]
    (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((32 * 4) - 96)))));
    leakages <- LeakAddr([6]) :: leakages;
    t.[6] <- aux_1;
    leakages <- LeakAddr([(W64.to_uint (rhotates_right + (W64.of_int ((32 * 4) - 96))));
                         5]) :: leakages;
    aux_1 <- x86_VPSRLV_4u64 state.[5]
    (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((32 * 4) - 96)))));
    leakages <- LeakAddr([5]) :: leakages;
    state.[5] <- aux_1;
    leakages <- LeakAddr([6; 5]) :: leakages;
    aux_1 <- (state.[5] `|` t.[6]);
    leakages <- LeakAddr([5]) :: leakages;
    state.[5] <- aux_1;
    leakages <- LeakAddr([6]) :: leakages;
    aux_1 <- (state.[6] `^` d14);
    leakages <- LeakAddr([6]) :: leakages;
    state.[6] <- aux_1;
    leakages <- LeakAddr([2]) :: leakages;
    aux_1 <- x86_VPERMQ state.[2]
    (W8.of_int (1 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 2))));
    leakages <- LeakAddr([3]) :: leakages;
    t.[3] <- aux_1;
    leakages <- LeakAddr([3]) :: leakages;
    aux_1 <- x86_VPERMQ state.[3]
    (W8.of_int (1 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 2))));
    leakages <- LeakAddr([4]) :: leakages;
    t.[4] <- aux_1;
    leakages <- LeakAddr([(W64.to_uint (rhotates_left + (W64.of_int ((32 * 5) - 96))));
                         6]) :: leakages;
    aux_1 <- x86_VPSLLV_4u64 state.[6]
    (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((32 * 5) - 96)))));
    leakages <- LeakAddr([7]) :: leakages;
    t.[7] <- aux_1;
    leakages <- LeakAddr([(W64.to_uint (rhotates_right + (W64.of_int ((32 * 5) - 96))));
                         6]) :: leakages;
    aux_1 <- x86_VPSRLV_4u64 state.[6]
    (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((32 * 5) - 96)))));
    leakages <- LeakAddr([1]) :: leakages;
    t.[1] <- aux_1;
    leakages <- LeakAddr([7; 1]) :: leakages;
    aux_1 <- (t.[1] `|` t.[7]);
    leakages <- LeakAddr([1]) :: leakages;
    t.[1] <- aux_1;
    leakages <- LeakAddr([1]) :: leakages;
    aux_1 <- (state.[1] `^` d14);
    leakages <- LeakAddr([1]) :: leakages;
    state.[1] <- aux_1;
    leakages <- LeakAddr([4]) :: leakages;
    aux_1 <- x86_VPERMQ state.[4]
    (W8.of_int (3 %% 2^2 + 2^2 * (2 %% 2^2 + 2^2 * (1 %% 2^2 + 2^2 * 0))));
    leakages <- LeakAddr([5]) :: leakages;
    t.[5] <- aux_1;
    leakages <- LeakAddr([5]) :: leakages;
    aux_1 <- x86_VPERMQ state.[5]
    (W8.of_int (2 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 1))));
    leakages <- LeakAddr([6]) :: leakages;
    t.[6] <- aux_1;
    leakages <- LeakAddr([(W64.to_uint (rhotates_left + (W64.of_int ((32 * 1) - 96))));
                         1]) :: leakages;
    aux_1 <- x86_VPSLLV_4u64 state.[1]
    (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((32 * 1) - 96)))));
    leakages <- LeakAddr([8]) :: leakages;
    t.[8] <- aux_1;
    leakages <- LeakAddr([(W64.to_uint (rhotates_right + (W64.of_int ((32 * 1) - 96))));
                         1]) :: leakages;
    aux_1 <- x86_VPSRLV_4u64 state.[1]
    (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((32 * 1) - 96)))));
    leakages <- LeakAddr([2]) :: leakages;
    t.[2] <- aux_1;
    leakages <- LeakAddr([8; 2]) :: leakages;
    aux_1 <- (t.[2] `|` t.[8]);
    leakages <- LeakAddr([2]) :: leakages;
    t.[2] <- aux_1;
    leakages <- LeakAddr([1]) :: leakages;
    aux_1 <- x86_VPSRLDQ_256 t.[1] (W8.of_int 8);
    leakages <- LeakAddr([7]) :: leakages;
    t.[7] <- aux_1;
    leakages <- LeakAddr([7; 1]) :: leakages;
    aux_1 <- ((invw t.[1]) `&` t.[7]);
    leakages <- LeakAddr([0]) :: leakages;
    t.[0] <- aux_1;
    leakages <- LeakAddr([6; 2]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[2] t.[6]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (1 %% 2^1 +
                           2^1 * (1 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    leakages <- LeakAddr([3]) :: leakages;
    state.[3] <- aux_1;
    leakages <- LeakAddr([2; 4]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[4] t.[2]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (1 %% 2^1 +
                           2^1 * (1 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    leakages <- LeakAddr([8]) :: leakages;
    t.[8] <- aux_1;
    leakages <- LeakAddr([4; 3]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[3] t.[4]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (1 %% 2^1 +
                           2^1 * (1 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    leakages <- LeakAddr([5]) :: leakages;
    state.[5] <- aux_1;
    leakages <- LeakAddr([3; 2]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[2] t.[3]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (1 %% 2^1 +
                           2^1 * (1 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    leakages <- LeakAddr([7]) :: leakages;
    t.[7] <- aux_1;
    leakages <- LeakAddr([4; 3]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 state.[3] t.[4]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (1 %% 2^1 +
                                       2^1 * (1 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    leakages <- LeakAddr([3]) :: leakages;
    state.[3] <- aux_1;
    leakages <- LeakAddr([5; 8]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[8] t.[5]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (1 %% 2^1 +
                                       2^1 * (1 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    leakages <- LeakAddr([8]) :: leakages;
    t.[8] <- aux_1;
    leakages <- LeakAddr([2; 5]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 state.[5] t.[2]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (1 %% 2^1 +
                                       2^1 * (1 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    leakages <- LeakAddr([5]) :: leakages;
    state.[5] <- aux_1;
    leakages <- LeakAddr([6; 7]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[7] t.[6]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (1 %% 2^1 +
                                       2^1 * (1 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    leakages <- LeakAddr([7]) :: leakages;
    t.[7] <- aux_1;
    leakages <- LeakAddr([5; 3]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 state.[3] t.[5]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (1 %% 2^1 + 2^1 * 1))))))));
    leakages <- LeakAddr([3]) :: leakages;
    state.[3] <- aux_1;
    leakages <- LeakAddr([6; 8]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[8] t.[6]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (1 %% 2^1 + 2^1 * 1))))))));
    leakages <- LeakAddr([8]) :: leakages;
    t.[8] <- aux_1;
    leakages <- LeakAddr([6; 5]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 state.[5] t.[6]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (1 %% 2^1 + 2^1 * 1))))))));
    leakages <- LeakAddr([5]) :: leakages;
    state.[5] <- aux_1;
    leakages <- LeakAddr([4; 7]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[7] t.[4]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (1 %% 2^1 + 2^1 * 1))))))));
    leakages <- LeakAddr([7]) :: leakages;
    t.[7] <- aux_1;
    leakages <- LeakAddr([8; 3]) :: leakages;
    aux_1 <- ((invw state.[3]) `&` t.[8]);
    leakages <- LeakAddr([3]) :: leakages;
    state.[3] <- aux_1;
    leakages <- LeakAddr([7; 5]) :: leakages;
    aux_1 <- ((invw state.[5]) `&` t.[7]);
    leakages <- LeakAddr([5]) :: leakages;
    state.[5] <- aux_1;
    leakages <- LeakAddr([2; 5]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[5] t.[2]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (1 %% 2^1 +
                           2^1 * (1 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    leakages <- LeakAddr([6]) :: leakages;
    state.[6] <- aux_1;
    leakages <- LeakAddr([5; 3]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[3] t.[5]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (1 %% 2^1 +
                           2^1 * (1 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    leakages <- LeakAddr([8]) :: leakages;
    t.[8] <- aux_1;
    leakages <- LeakAddr([3; 3]) :: leakages;
    aux_1 <- (state.[3] `^` t.[3]);
    leakages <- LeakAddr([3]) :: leakages;
    state.[3] <- aux_1;
    leakages <- LeakAddr([3; 6]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 state.[6] t.[3]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (1 %% 2^1 +
                                       2^1 * (1 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    leakages <- LeakAddr([6]) :: leakages;
    state.[6] <- aux_1;
    leakages <- LeakAddr([4; 8]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[8] t.[4]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (1 %% 2^1 +
                                       2^1 * (1 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    leakages <- LeakAddr([8]) :: leakages;
    t.[8] <- aux_1;
    leakages <- LeakAddr([5; 5]) :: leakages;
    aux_1 <- (state.[5] `^` t.[5]);
    leakages <- LeakAddr([5]) :: leakages;
    state.[5] <- aux_1;
    leakages <- LeakAddr([4; 6]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 state.[6] t.[4]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (1 %% 2^1 + 2^1 * 1))))))));
    leakages <- LeakAddr([6]) :: leakages;
    state.[6] <- aux_1;
    leakages <- LeakAddr([2; 8]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[8] t.[2]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (1 %% 2^1 + 2^1 * 1))))))));
    leakages <- LeakAddr([8]) :: leakages;
    t.[8] <- aux_1;
    leakages <- LeakAddr([8; 6]) :: leakages;
    aux_1 <- ((invw state.[6]) `&` t.[8]);
    leakages <- LeakAddr([6]) :: leakages;
    state.[6] <- aux_1;
    leakages <- LeakAddr([6; 6]) :: leakages;
    aux_1 <- (state.[6] `^` t.[6]);
    leakages <- LeakAddr([6]) :: leakages;
    state.[6] <- aux_1;
    leakages <- LeakAddr([1]) :: leakages;
    aux_1 <- x86_VPERMQ t.[1]
    (W8.of_int (2 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (1 %% 2^2 + 2^2 * 0))));
    leakages <- LeakAddr([4]) :: leakages;
    state.[4] <- aux_1;
    leakages <- LeakAddr([0; 4]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 state.[4] state.[0]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (1 %% 2^1 +
                                       2^1 * (1 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    leakages <- LeakAddr([8]) :: leakages;
    t.[8] <- aux_1;
    leakages <- LeakAddr([1]) :: leakages;
    aux_1 <- x86_VPERMQ t.[1]
    (W8.of_int (1 %% 2^2 + 2^2 * (2 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    leakages <- LeakAddr([1]) :: leakages;
    state.[1] <- aux_1;
    leakages <- LeakAddr([0; 1]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 state.[1] state.[0]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (1 %% 2^1 + 2^1 * 1))))))));
    leakages <- LeakAddr([1]) :: leakages;
    state.[1] <- aux_1;
    leakages <- LeakAddr([8; 1]) :: leakages;
    aux_1 <- ((invw state.[1]) `&` t.[8]);
    leakages <- LeakAddr([1]) :: leakages;
    state.[1] <- aux_1;
    leakages <- LeakAddr([5; 4]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[4] t.[5]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (1 %% 2^1 +
                           2^1 * (1 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    leakages <- LeakAddr([2]) :: leakages;
    state.[2] <- aux_1;
    leakages <- LeakAddr([4; 6]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[6] t.[4]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (1 %% 2^1 +
                           2^1 * (1 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    leakages <- LeakAddr([7]) :: leakages;
    t.[7] <- aux_1;
    leakages <- LeakAddr([6; 2]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 state.[2] t.[6]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (1 %% 2^1 +
                                       2^1 * (1 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    leakages <- LeakAddr([2]) :: leakages;
    state.[2] <- aux_1;
    leakages <- LeakAddr([3; 7]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[7] t.[3]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (1 %% 2^1 +
                                       2^1 * (1 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    leakages <- LeakAddr([7]) :: leakages;
    t.[7] <- aux_1;
    leakages <- LeakAddr([3; 2]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 state.[2] t.[3]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (1 %% 2^1 + 2^1 * 1))))))));
    leakages <- LeakAddr([2]) :: leakages;
    state.[2] <- aux_1;
    leakages <- LeakAddr([5; 7]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[7] t.[5]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (1 %% 2^1 + 2^1 * 1))))))));
    leakages <- LeakAddr([7]) :: leakages;
    t.[7] <- aux_1;
    leakages <- LeakAddr([7; 2]) :: leakages;
    aux_1 <- ((invw state.[2]) `&` t.[7]);
    leakages <- LeakAddr([2]) :: leakages;
    state.[2] <- aux_1;
    leakages <- LeakAddr([2; 2]) :: leakages;
    aux_1 <- (state.[2] `^` t.[2]);
    leakages <- LeakAddr([2]) :: leakages;
    state.[2] <- aux_1;
    leakages <- LeakAddr([0]) :: leakages;
    aux_1 <- x86_VPERMQ t.[0]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
    leakages <- LeakAddr([0]) :: leakages;
    t.[0] <- aux_1;
    leakages <- LeakAddr([3]) :: leakages;
    aux_1 <- x86_VPERMQ state.[3]
    (W8.of_int (3 %% 2^2 + 2^2 * (2 %% 2^2 + 2^2 * (1 %% 2^2 + 2^2 * 0))));
    leakages <- LeakAddr([3]) :: leakages;
    state.[3] <- aux_1;
    leakages <- LeakAddr([5]) :: leakages;
    aux_1 <- x86_VPERMQ state.[5]
    (W8.of_int (1 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 2))));
    leakages <- LeakAddr([5]) :: leakages;
    state.[5] <- aux_1;
    leakages <- LeakAddr([6]) :: leakages;
    aux_1 <- x86_VPERMQ state.[6]
    (W8.of_int (2 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 1))));
    leakages <- LeakAddr([6]) :: leakages;
    state.[6] <- aux_1;
    leakages <- LeakAddr([3; 6]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[6] t.[3]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (1 %% 2^1 +
                           2^1 * (1 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    leakages <- LeakAddr([4]) :: leakages;
    state.[4] <- aux_1;
    leakages <- LeakAddr([6; 5]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[5] t.[6]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (1 %% 2^1 +
                           2^1 * (1 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    leakages <- LeakAddr([7]) :: leakages;
    t.[7] <- aux_1;
    leakages <- LeakAddr([5; 4]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 state.[4] t.[5]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (1 %% 2^1 +
                                       2^1 * (1 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    leakages <- LeakAddr([4]) :: leakages;
    state.[4] <- aux_1;
    leakages <- LeakAddr([2; 7]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[7] t.[2]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (1 %% 2^1 +
                                       2^1 * (1 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    leakages <- LeakAddr([7]) :: leakages;
    t.[7] <- aux_1;
    leakages <- LeakAddr([2; 4]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 state.[4] t.[2]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (1 %% 2^1 + 2^1 * 1))))))));
    leakages <- LeakAddr([4]) :: leakages;
    state.[4] <- aux_1;
    leakages <- LeakAddr([3; 7]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[7] t.[3]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (1 %% 2^1 + 2^1 * 1))))))));
    leakages <- LeakAddr([7]) :: leakages;
    t.[7] <- aux_1;
    leakages <- LeakAddr([7; 4]) :: leakages;
    aux_1 <- ((invw state.[4]) `&` t.[7]);
    leakages <- LeakAddr([4]) :: leakages;
    state.[4] <- aux_1;
    leakages <- LeakAddr([0; 0]) :: leakages;
    aux_1 <- (state.[0] `^` t.[0]);
    leakages <- LeakAddr([0]) :: leakages;
    state.[0] <- aux_1;
    leakages <- LeakAddr([1; 1]) :: leakages;
    aux_1 <- (state.[1] `^` t.[1]);
    leakages <- LeakAddr([1]) :: leakages;
    state.[1] <- aux_1;
    leakages <- LeakAddr([4; 4]) :: leakages;
    aux_1 <- (state.[4] `^` t.[4]);
    leakages <- LeakAddr([4]) :: leakages;
    state.[4] <- aux_1;
    leakages <- LeakAddr([(W64.to_uint (iotas + (W64.of_int ((32 * 0) - 0))));
                         0]) :: leakages;
    aux_1 <- (state.[0] `^` (loadW256 Glob.mem (W64.to_uint (iotas + (W64.of_int ((32 * 0) - 0))))));
    leakages <- LeakAddr([0]) :: leakages;
    state.[0] <- aux_1;
    leakages <- LeakAddr([]) :: leakages;
    aux <- (iotas + (W64.of_int 32));
    iotas <- aux;
    leakages <- LeakAddr([]) :: leakages;
    (aux_5, aux_4, aux_3, aux_2, aux_0) <- x86_DEC_32 r;
     _0 <- aux_5;
     _1 <- aux_4;
     _2 <- aux_3;
    zf <- aux_2;
    r <- aux_0;
    leakages <- LeakCond((! zf)) :: LeakAddr([]) :: leakages;
    
    while ((! zf)) {
      leakages <- LeakAddr([2]) :: leakages;
      aux_1 <- x86_VPSHUFD_256 state.[2]
      (W8.of_int (2 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 1))));
      c00 <- aux_1;
      leakages <- LeakAddr([3; 5]) :: leakages;
      aux_1 <- (state.[5] `^` state.[3]);
      c14 <- aux_1;
      leakages <- LeakAddr([6; 4]) :: leakages;
      aux_1 <- (state.[4] `^` state.[6]);
      leakages <- LeakAddr([2]) :: leakages;
      t.[2] <- aux_1;
      leakages <- LeakAddr([1]) :: leakages;
      aux_1 <- (c14 `^` state.[1]);
      c14 <- aux_1;
      leakages <- LeakAddr([2]) :: leakages;
      aux_1 <- (c14 `^` t.[2]);
      c14 <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- x86_VPERMQ c14
      (W8.of_int (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (1 %% 2^2 + 2^2 * 2))));
      leakages <- LeakAddr([4]) :: leakages;
      t.[4] <- aux_1;
      leakages <- LeakAddr([2]) :: leakages;
      aux_1 <- (c00 `^` state.[2]);
      c00 <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- x86_VPERMQ c00
      (W8.of_int (2 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 1))));
      leakages <- LeakAddr([0]) :: leakages;
      t.[0] <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- (c14 \vshr64u256 (W8.of_int 63));
      leakages <- LeakAddr([1]) :: leakages;
      t.[1] <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- (c14 \vadd64u256 c14);
      leakages <- LeakAddr([2]) :: leakages;
      t.[2] <- aux_1;
      leakages <- LeakAddr([2; 1]) :: leakages;
      aux_1 <- (t.[1] `|` t.[2]);
      leakages <- LeakAddr([1]) :: leakages;
      t.[1] <- aux_1;
      leakages <- LeakAddr([1]) :: leakages;
      aux_1 <- x86_VPERMQ t.[1]
      (W8.of_int (1 %% 2^2 + 2^2 * (2 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
      d14 <- aux_1;
      leakages <- LeakAddr([4; 1]) :: leakages;
      aux_1 <- (t.[1] `^` t.[4]);
      d00 <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- x86_VPERMQ d00
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
      d00 <- aux_1;
      leakages <- LeakAddr([0]) :: leakages;
      aux_1 <- (c00 `^` state.[0]);
      c00 <- aux_1;
      leakages <- LeakAddr([0]) :: leakages;
      aux_1 <- (c00 `^` t.[0]);
      c00 <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- (c00 \vshr64u256 (W8.of_int 63));
      leakages <- LeakAddr([0]) :: leakages;
      t.[0] <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- (c00 \vadd64u256 c00);
      leakages <- LeakAddr([1]) :: leakages;
      t.[1] <- aux_1;
      leakages <- LeakAddr([0; 1]) :: leakages;
      aux_1 <- (t.[1] `|` t.[0]);
      leakages <- LeakAddr([1]) :: leakages;
      t.[1] <- aux_1;
      leakages <- LeakAddr([2]) :: leakages;
      aux_1 <- (state.[2] `^` d00);
      leakages <- LeakAddr([2]) :: leakages;
      state.[2] <- aux_1;
      leakages <- LeakAddr([0]) :: leakages;
      aux_1 <- (state.[0] `^` d00);
      leakages <- LeakAddr([0]) :: leakages;
      state.[0] <- aux_1;
      leakages <- LeakAddr([1]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 d14 t.[1]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (1 %% 2^1 + 2^1 * 1))))))));
      d14 <- aux_1;
      leakages <- LeakAddr([4]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[4] c00
      (W8.of_int (1 %% 2^1 +
                 2^1 * (1 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      leakages <- LeakAddr([4]) :: leakages;
      t.[4] <- aux_1;
      leakages <- LeakAddr([4]) :: leakages;
      aux_1 <- (d14 `^` t.[4]);
      d14 <- aux_1;
      leakages <- LeakAddr([(W64.to_uint (rhotates_left + (W64.of_int ((32 * 0) - 96))));
                           2]) :: leakages;
      aux_1 <- x86_VPSLLV_4u64 state.[2]
      (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((32 * 0) - 96)))));
      leakages <- LeakAddr([3]) :: leakages;
      t.[3] <- aux_1;
      leakages <- LeakAddr([(W64.to_uint (rhotates_right + (W64.of_int ((32 * 0) - 96))));
                           2]) :: leakages;
      aux_1 <- x86_VPSRLV_4u64 state.[2]
      (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((32 * 0) - 96)))));
      leakages <- LeakAddr([2]) :: leakages;
      state.[2] <- aux_1;
      leakages <- LeakAddr([3; 2]) :: leakages;
      aux_1 <- (state.[2] `|` t.[3]);
      leakages <- LeakAddr([2]) :: leakages;
      state.[2] <- aux_1;
      leakages <- LeakAddr([3]) :: leakages;
      aux_1 <- (state.[3] `^` d14);
      leakages <- LeakAddr([3]) :: leakages;
      state.[3] <- aux_1;
      leakages <- LeakAddr([(W64.to_uint (rhotates_left + (W64.of_int ((32 * 2) - 96))));
                           3]) :: leakages;
      aux_1 <- x86_VPSLLV_4u64 state.[3]
      (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((32 * 2) - 96)))));
      leakages <- LeakAddr([4]) :: leakages;
      t.[4] <- aux_1;
      leakages <- LeakAddr([(W64.to_uint (rhotates_right + (W64.of_int ((32 * 2) - 96))));
                           3]) :: leakages;
      aux_1 <- x86_VPSRLV_4u64 state.[3]
      (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((32 * 2) - 96)))));
      leakages <- LeakAddr([3]) :: leakages;
      state.[3] <- aux_1;
      leakages <- LeakAddr([4; 3]) :: leakages;
      aux_1 <- (state.[3] `|` t.[4]);
      leakages <- LeakAddr([3]) :: leakages;
      state.[3] <- aux_1;
      leakages <- LeakAddr([4]) :: leakages;
      aux_1 <- (state.[4] `^` d14);
      leakages <- LeakAddr([4]) :: leakages;
      state.[4] <- aux_1;
      leakages <- LeakAddr([(W64.to_uint (rhotates_left + (W64.of_int ((32 * 3) - 96))));
                           4]) :: leakages;
      aux_1 <- x86_VPSLLV_4u64 state.[4]
      (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((32 * 3) - 96)))));
      leakages <- LeakAddr([5]) :: leakages;
      t.[5] <- aux_1;
      leakages <- LeakAddr([(W64.to_uint (rhotates_right + (W64.of_int ((32 * 3) - 96))));
                           4]) :: leakages;
      aux_1 <- x86_VPSRLV_4u64 state.[4]
      (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((32 * 3) - 96)))));
      leakages <- LeakAddr([4]) :: leakages;
      state.[4] <- aux_1;
      leakages <- LeakAddr([5; 4]) :: leakages;
      aux_1 <- (state.[4] `|` t.[5]);
      leakages <- LeakAddr([4]) :: leakages;
      state.[4] <- aux_1;
      leakages <- LeakAddr([5]) :: leakages;
      aux_1 <- (state.[5] `^` d14);
      leakages <- LeakAddr([5]) :: leakages;
      state.[5] <- aux_1;
      leakages <- LeakAddr([(W64.to_uint (rhotates_left + (W64.of_int ((32 * 4) - 96))));
                           5]) :: leakages;
      aux_1 <- x86_VPSLLV_4u64 state.[5]
      (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((32 * 4) - 96)))));
      leakages <- LeakAddr([6]) :: leakages;
      t.[6] <- aux_1;
      leakages <- LeakAddr([(W64.to_uint (rhotates_right + (W64.of_int ((32 * 4) - 96))));
                           5]) :: leakages;
      aux_1 <- x86_VPSRLV_4u64 state.[5]
      (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((32 * 4) - 96)))));
      leakages <- LeakAddr([5]) :: leakages;
      state.[5] <- aux_1;
      leakages <- LeakAddr([6; 5]) :: leakages;
      aux_1 <- (state.[5] `|` t.[6]);
      leakages <- LeakAddr([5]) :: leakages;
      state.[5] <- aux_1;
      leakages <- LeakAddr([6]) :: leakages;
      aux_1 <- (state.[6] `^` d14);
      leakages <- LeakAddr([6]) :: leakages;
      state.[6] <- aux_1;
      leakages <- LeakAddr([2]) :: leakages;
      aux_1 <- x86_VPERMQ state.[2]
      (W8.of_int (1 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 2))));
      leakages <- LeakAddr([3]) :: leakages;
      t.[3] <- aux_1;
      leakages <- LeakAddr([3]) :: leakages;
      aux_1 <- x86_VPERMQ state.[3]
      (W8.of_int (1 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 2))));
      leakages <- LeakAddr([4]) :: leakages;
      t.[4] <- aux_1;
      leakages <- LeakAddr([(W64.to_uint (rhotates_left + (W64.of_int ((32 * 5) - 96))));
                           6]) :: leakages;
      aux_1 <- x86_VPSLLV_4u64 state.[6]
      (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((32 * 5) - 96)))));
      leakages <- LeakAddr([7]) :: leakages;
      t.[7] <- aux_1;
      leakages <- LeakAddr([(W64.to_uint (rhotates_right + (W64.of_int ((32 * 5) - 96))));
                           6]) :: leakages;
      aux_1 <- x86_VPSRLV_4u64 state.[6]
      (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((32 * 5) - 96)))));
      leakages <- LeakAddr([1]) :: leakages;
      t.[1] <- aux_1;
      leakages <- LeakAddr([7; 1]) :: leakages;
      aux_1 <- (t.[1] `|` t.[7]);
      leakages <- LeakAddr([1]) :: leakages;
      t.[1] <- aux_1;
      leakages <- LeakAddr([1]) :: leakages;
      aux_1 <- (state.[1] `^` d14);
      leakages <- LeakAddr([1]) :: leakages;
      state.[1] <- aux_1;
      leakages <- LeakAddr([4]) :: leakages;
      aux_1 <- x86_VPERMQ state.[4]
      (W8.of_int (3 %% 2^2 + 2^2 * (2 %% 2^2 + 2^2 * (1 %% 2^2 + 2^2 * 0))));
      leakages <- LeakAddr([5]) :: leakages;
      t.[5] <- aux_1;
      leakages <- LeakAddr([5]) :: leakages;
      aux_1 <- x86_VPERMQ state.[5]
      (W8.of_int (2 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 1))));
      leakages <- LeakAddr([6]) :: leakages;
      t.[6] <- aux_1;
      leakages <- LeakAddr([(W64.to_uint (rhotates_left + (W64.of_int ((32 * 1) - 96))));
                           1]) :: leakages;
      aux_1 <- x86_VPSLLV_4u64 state.[1]
      (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((32 * 1) - 96)))));
      leakages <- LeakAddr([8]) :: leakages;
      t.[8] <- aux_1;
      leakages <- LeakAddr([(W64.to_uint (rhotates_right + (W64.of_int ((32 * 1) - 96))));
                           1]) :: leakages;
      aux_1 <- x86_VPSRLV_4u64 state.[1]
      (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((32 * 1) - 96)))));
      leakages <- LeakAddr([2]) :: leakages;
      t.[2] <- aux_1;
      leakages <- LeakAddr([8; 2]) :: leakages;
      aux_1 <- (t.[2] `|` t.[8]);
      leakages <- LeakAddr([2]) :: leakages;
      t.[2] <- aux_1;
      leakages <- LeakAddr([1]) :: leakages;
      aux_1 <- x86_VPSRLDQ_256 t.[1] (W8.of_int 8);
      leakages <- LeakAddr([7]) :: leakages;
      t.[7] <- aux_1;
      leakages <- LeakAddr([7; 1]) :: leakages;
      aux_1 <- ((invw t.[1]) `&` t.[7]);
      leakages <- LeakAddr([0]) :: leakages;
      t.[0] <- aux_1;
      leakages <- LeakAddr([6; 2]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[2] t.[6]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (1 %% 2^1 +
                             2^1 * (1 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      leakages <- LeakAddr([3]) :: leakages;
      state.[3] <- aux_1;
      leakages <- LeakAddr([2; 4]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[4] t.[2]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (1 %% 2^1 +
                             2^1 * (1 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      leakages <- LeakAddr([8]) :: leakages;
      t.[8] <- aux_1;
      leakages <- LeakAddr([4; 3]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[3] t.[4]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (1 %% 2^1 +
                             2^1 * (1 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      leakages <- LeakAddr([5]) :: leakages;
      state.[5] <- aux_1;
      leakages <- LeakAddr([3; 2]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[2] t.[3]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (1 %% 2^1 +
                             2^1 * (1 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      leakages <- LeakAddr([7]) :: leakages;
      t.[7] <- aux_1;
      leakages <- LeakAddr([4; 3]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 state.[3] t.[4]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (1 %% 2^1 +
                                         2^1 * (1 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      leakages <- LeakAddr([3]) :: leakages;
      state.[3] <- aux_1;
      leakages <- LeakAddr([5; 8]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[8] t.[5]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (1 %% 2^1 +
                                         2^1 * (1 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      leakages <- LeakAddr([8]) :: leakages;
      t.[8] <- aux_1;
      leakages <- LeakAddr([2; 5]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 state.[5] t.[2]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (1 %% 2^1 +
                                         2^1 * (1 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      leakages <- LeakAddr([5]) :: leakages;
      state.[5] <- aux_1;
      leakages <- LeakAddr([6; 7]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[7] t.[6]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (1 %% 2^1 +
                                         2^1 * (1 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      leakages <- LeakAddr([7]) :: leakages;
      t.[7] <- aux_1;
      leakages <- LeakAddr([5; 3]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 state.[3] t.[5]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (1 %% 2^1 + 2^1 * 1))))))));
      leakages <- LeakAddr([3]) :: leakages;
      state.[3] <- aux_1;
      leakages <- LeakAddr([6; 8]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[8] t.[6]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (1 %% 2^1 + 2^1 * 1))))))));
      leakages <- LeakAddr([8]) :: leakages;
      t.[8] <- aux_1;
      leakages <- LeakAddr([6; 5]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 state.[5] t.[6]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (1 %% 2^1 + 2^1 * 1))))))));
      leakages <- LeakAddr([5]) :: leakages;
      state.[5] <- aux_1;
      leakages <- LeakAddr([4; 7]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[7] t.[4]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (1 %% 2^1 + 2^1 * 1))))))));
      leakages <- LeakAddr([7]) :: leakages;
      t.[7] <- aux_1;
      leakages <- LeakAddr([8; 3]) :: leakages;
      aux_1 <- ((invw state.[3]) `&` t.[8]);
      leakages <- LeakAddr([3]) :: leakages;
      state.[3] <- aux_1;
      leakages <- LeakAddr([7; 5]) :: leakages;
      aux_1 <- ((invw state.[5]) `&` t.[7]);
      leakages <- LeakAddr([5]) :: leakages;
      state.[5] <- aux_1;
      leakages <- LeakAddr([2; 5]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[5] t.[2]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (1 %% 2^1 +
                             2^1 * (1 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      leakages <- LeakAddr([6]) :: leakages;
      state.[6] <- aux_1;
      leakages <- LeakAddr([5; 3]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[3] t.[5]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (1 %% 2^1 +
                             2^1 * (1 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      leakages <- LeakAddr([8]) :: leakages;
      t.[8] <- aux_1;
      leakages <- LeakAddr([3; 3]) :: leakages;
      aux_1 <- (state.[3] `^` t.[3]);
      leakages <- LeakAddr([3]) :: leakages;
      state.[3] <- aux_1;
      leakages <- LeakAddr([3; 6]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 state.[6] t.[3]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (1 %% 2^1 +
                                         2^1 * (1 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      leakages <- LeakAddr([6]) :: leakages;
      state.[6] <- aux_1;
      leakages <- LeakAddr([4; 8]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[8] t.[4]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (1 %% 2^1 +
                                         2^1 * (1 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      leakages <- LeakAddr([8]) :: leakages;
      t.[8] <- aux_1;
      leakages <- LeakAddr([5; 5]) :: leakages;
      aux_1 <- (state.[5] `^` t.[5]);
      leakages <- LeakAddr([5]) :: leakages;
      state.[5] <- aux_1;
      leakages <- LeakAddr([4; 6]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 state.[6] t.[4]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (1 %% 2^1 + 2^1 * 1))))))));
      leakages <- LeakAddr([6]) :: leakages;
      state.[6] <- aux_1;
      leakages <- LeakAddr([2; 8]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[8] t.[2]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (1 %% 2^1 + 2^1 * 1))))))));
      leakages <- LeakAddr([8]) :: leakages;
      t.[8] <- aux_1;
      leakages <- LeakAddr([8; 6]) :: leakages;
      aux_1 <- ((invw state.[6]) `&` t.[8]);
      leakages <- LeakAddr([6]) :: leakages;
      state.[6] <- aux_1;
      leakages <- LeakAddr([6; 6]) :: leakages;
      aux_1 <- (state.[6] `^` t.[6]);
      leakages <- LeakAddr([6]) :: leakages;
      state.[6] <- aux_1;
      leakages <- LeakAddr([1]) :: leakages;
      aux_1 <- x86_VPERMQ t.[1]
      (W8.of_int (2 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (1 %% 2^2 + 2^2 * 0))));
      leakages <- LeakAddr([4]) :: leakages;
      state.[4] <- aux_1;
      leakages <- LeakAddr([0; 4]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 state.[4] state.[0]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (1 %% 2^1 +
                                         2^1 * (1 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      leakages <- LeakAddr([8]) :: leakages;
      t.[8] <- aux_1;
      leakages <- LeakAddr([1]) :: leakages;
      aux_1 <- x86_VPERMQ t.[1]
      (W8.of_int (1 %% 2^2 + 2^2 * (2 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
      leakages <- LeakAddr([1]) :: leakages;
      state.[1] <- aux_1;
      leakages <- LeakAddr([0; 1]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 state.[1] state.[0]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (1 %% 2^1 + 2^1 * 1))))))));
      leakages <- LeakAddr([1]) :: leakages;
      state.[1] <- aux_1;
      leakages <- LeakAddr([8; 1]) :: leakages;
      aux_1 <- ((invw state.[1]) `&` t.[8]);
      leakages <- LeakAddr([1]) :: leakages;
      state.[1] <- aux_1;
      leakages <- LeakAddr([5; 4]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[4] t.[5]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (1 %% 2^1 +
                             2^1 * (1 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      leakages <- LeakAddr([2]) :: leakages;
      state.[2] <- aux_1;
      leakages <- LeakAddr([4; 6]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[6] t.[4]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (1 %% 2^1 +
                             2^1 * (1 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      leakages <- LeakAddr([7]) :: leakages;
      t.[7] <- aux_1;
      leakages <- LeakAddr([6; 2]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 state.[2] t.[6]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (1 %% 2^1 +
                                         2^1 * (1 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      leakages <- LeakAddr([2]) :: leakages;
      state.[2] <- aux_1;
      leakages <- LeakAddr([3; 7]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[7] t.[3]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (1 %% 2^1 +
                                         2^1 * (1 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      leakages <- LeakAddr([7]) :: leakages;
      t.[7] <- aux_1;
      leakages <- LeakAddr([3; 2]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 state.[2] t.[3]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (1 %% 2^1 + 2^1 * 1))))))));
      leakages <- LeakAddr([2]) :: leakages;
      state.[2] <- aux_1;
      leakages <- LeakAddr([5; 7]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[7] t.[5]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (1 %% 2^1 + 2^1 * 1))))))));
      leakages <- LeakAddr([7]) :: leakages;
      t.[7] <- aux_1;
      leakages <- LeakAddr([7; 2]) :: leakages;
      aux_1 <- ((invw state.[2]) `&` t.[7]);
      leakages <- LeakAddr([2]) :: leakages;
      state.[2] <- aux_1;
      leakages <- LeakAddr([2; 2]) :: leakages;
      aux_1 <- (state.[2] `^` t.[2]);
      leakages <- LeakAddr([2]) :: leakages;
      state.[2] <- aux_1;
      leakages <- LeakAddr([0]) :: leakages;
      aux_1 <- x86_VPERMQ t.[0]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
      leakages <- LeakAddr([0]) :: leakages;
      t.[0] <- aux_1;
      leakages <- LeakAddr([3]) :: leakages;
      aux_1 <- x86_VPERMQ state.[3]
      (W8.of_int (3 %% 2^2 + 2^2 * (2 %% 2^2 + 2^2 * (1 %% 2^2 + 2^2 * 0))));
      leakages <- LeakAddr([3]) :: leakages;
      state.[3] <- aux_1;
      leakages <- LeakAddr([5]) :: leakages;
      aux_1 <- x86_VPERMQ state.[5]
      (W8.of_int (1 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 2))));
      leakages <- LeakAddr([5]) :: leakages;
      state.[5] <- aux_1;
      leakages <- LeakAddr([6]) :: leakages;
      aux_1 <- x86_VPERMQ state.[6]
      (W8.of_int (2 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 1))));
      leakages <- LeakAddr([6]) :: leakages;
      state.[6] <- aux_1;
      leakages <- LeakAddr([3; 6]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[6] t.[3]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (1 %% 2^1 +
                             2^1 * (1 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      leakages <- LeakAddr([4]) :: leakages;
      state.[4] <- aux_1;
      leakages <- LeakAddr([6; 5]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[5] t.[6]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (1 %% 2^1 +
                             2^1 * (1 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      leakages <- LeakAddr([7]) :: leakages;
      t.[7] <- aux_1;
      leakages <- LeakAddr([5; 4]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 state.[4] t.[5]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (1 %% 2^1 +
                                         2^1 * (1 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      leakages <- LeakAddr([4]) :: leakages;
      state.[4] <- aux_1;
      leakages <- LeakAddr([2; 7]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[7] t.[2]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (1 %% 2^1 +
                                         2^1 * (1 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      leakages <- LeakAddr([7]) :: leakages;
      t.[7] <- aux_1;
      leakages <- LeakAddr([2; 4]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 state.[4] t.[2]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (1 %% 2^1 + 2^1 * 1))))))));
      leakages <- LeakAddr([4]) :: leakages;
      state.[4] <- aux_1;
      leakages <- LeakAddr([3; 7]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[7] t.[3]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (1 %% 2^1 + 2^1 * 1))))))));
      leakages <- LeakAddr([7]) :: leakages;
      t.[7] <- aux_1;
      leakages <- LeakAddr([7; 4]) :: leakages;
      aux_1 <- ((invw state.[4]) `&` t.[7]);
      leakages <- LeakAddr([4]) :: leakages;
      state.[4] <- aux_1;
      leakages <- LeakAddr([0; 0]) :: leakages;
      aux_1 <- (state.[0] `^` t.[0]);
      leakages <- LeakAddr([0]) :: leakages;
      state.[0] <- aux_1;
      leakages <- LeakAddr([1; 1]) :: leakages;
      aux_1 <- (state.[1] `^` t.[1]);
      leakages <- LeakAddr([1]) :: leakages;
      state.[1] <- aux_1;
      leakages <- LeakAddr([4; 4]) :: leakages;
      aux_1 <- (state.[4] `^` t.[4]);
      leakages <- LeakAddr([4]) :: leakages;
      state.[4] <- aux_1;
      leakages <- LeakAddr([(W64.to_uint (iotas + (W64.of_int ((32 * 0) - 0))));
                           0]) :: leakages;
      aux_1 <- (state.[0] `^` (loadW256 Glob.mem (W64.to_uint (iotas + (W64.of_int ((32 * 0) - 0))))));
      leakages <- LeakAddr([0]) :: leakages;
      state.[0] <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux <- (iotas + (W64.of_int 32));
      iotas <- aux;
      leakages <- LeakAddr([]) :: leakages;
      (aux_5, aux_4, aux_3, aux_2, aux_0) <- x86_DEC_32 r;
       _0 <- aux_5;
       _1 <- aux_4;
       _2 <- aux_3;
      zf <- aux_2;
      r <- aux_0;
    leakages <- LeakCond((! zf)) :: LeakAddr([]) :: leakages;
    
    }
    return (state);
  }
}.


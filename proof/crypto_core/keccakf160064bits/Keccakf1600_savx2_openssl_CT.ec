require import List Int IntExtra IntDiv CoreMap.
from Jasmin require import JModel.

require import Array9.
require import WArray288.



module M = {
  var leakages : leakages_t
  
  proc __keccakf1600_avx2_openssl (a00:W256.t, a01:W256.t, a20:W256.t,
                                   a31:W256.t, a21:W256.t, a41:W256.t,
                                   a11:W256.t, _rhotates_left:W64.t,
                                   _rhotates_right:W64.t, _iotas:W64.t) : 
  W256.t * W256.t * W256.t * W256.t * W256.t * W256.t * W256.t = {
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
    var i:W32.t;
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
    i <- aux_0;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- x86_VPSHUFD_256 a20 (W8.of_int 78);
    c00 <- aux_1;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- (a41 `^` a31);
    c14 <- aux_1;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- (a21 `^` a11);
    leakages <- LeakAddr([2]) :: leakages;
    t.[2] <- aux_1;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- (c14 `^` a01);
    c14 <- aux_1;
    leakages <- LeakAddr([2]) :: leakages;
    aux_1 <- (c14 `^` t.[2]);
    c14 <- aux_1;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- x86_VPERMQ c14 (W8.of_int 147);
    leakages <- LeakAddr([4]) :: leakages;
    t.[4] <- aux_1;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- (c00 `^` a20);
    c00 <- aux_1;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- x86_VPERMQ c00 (W8.of_int 78);
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
    aux_1 <- x86_VPERMQ t.[1] (W8.of_int 57);
    d14 <- aux_1;
    leakages <- LeakAddr([4; 1]) :: leakages;
    aux_1 <- (t.[1] `^` t.[4]);
    d00 <- aux_1;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- x86_VPERMQ d00 (W8.of_int 0);
    d00 <- aux_1;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- (c00 `^` a00);
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
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- (a20 `^` d00);
    a20 <- aux_1;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- (a00 `^` d00);
    a00 <- aux_1;
    leakages <- LeakAddr([1]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 d14 t.[1]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
    d14 <- aux_1;
    leakages <- LeakAddr([4]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[4] c00
    (W8.of_int (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
    leakages <- LeakAddr([4]) :: leakages;
    t.[4] <- aux_1;
    leakages <- LeakAddr([4]) :: leakages;
    aux_1 <- (d14 `^` t.[4]);
    d14 <- aux_1;
    leakages <- LeakAddr([(W64.to_uint (rhotates_left + (W64.of_int ((0 * 32) - 96))))]) :: leakages;
    aux_1 <- x86_VPSLLV_4u64 a20
    (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((0 * 32) - 96)))));
    leakages <- LeakAddr([3]) :: leakages;
    t.[3] <- aux_1;
    leakages <- LeakAddr([(W64.to_uint (rhotates_right + (W64.of_int ((0 * 32) - 96))))]) :: leakages;
    aux_1 <- x86_VPSRLV_4u64 a20
    (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((0 * 32) - 96)))));
    a20 <- aux_1;
    leakages <- LeakAddr([3]) :: leakages;
    aux_1 <- (a20 `|` t.[3]);
    a20 <- aux_1;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- (a31 `^` d14);
    a31 <- aux_1;
    leakages <- LeakAddr([(W64.to_uint (rhotates_left + (W64.of_int ((2 * 32) - 96))))]) :: leakages;
    aux_1 <- x86_VPSLLV_4u64 a31
    (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((2 * 32) - 96)))));
    leakages <- LeakAddr([4]) :: leakages;
    t.[4] <- aux_1;
    leakages <- LeakAddr([(W64.to_uint (rhotates_right + (W64.of_int ((2 * 32) - 96))))]) :: leakages;
    aux_1 <- x86_VPSRLV_4u64 a31
    (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((2 * 32) - 96)))));
    a31 <- aux_1;
    leakages <- LeakAddr([4]) :: leakages;
    aux_1 <- (a31 `|` t.[4]);
    a31 <- aux_1;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- (a21 `^` d14);
    a21 <- aux_1;
    leakages <- LeakAddr([(W64.to_uint (rhotates_left + (W64.of_int ((3 * 32) - 96))))]) :: leakages;
    aux_1 <- x86_VPSLLV_4u64 a21
    (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((3 * 32) - 96)))));
    leakages <- LeakAddr([5]) :: leakages;
    t.[5] <- aux_1;
    leakages <- LeakAddr([(W64.to_uint (rhotates_right + (W64.of_int ((3 * 32) - 96))))]) :: leakages;
    aux_1 <- x86_VPSRLV_4u64 a21
    (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((3 * 32) - 96)))));
    a21 <- aux_1;
    leakages <- LeakAddr([5]) :: leakages;
    aux_1 <- (a21 `|` t.[5]);
    a21 <- aux_1;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- (a41 `^` d14);
    a41 <- aux_1;
    leakages <- LeakAddr([(W64.to_uint (rhotates_left + (W64.of_int ((4 * 32) - 96))))]) :: leakages;
    aux_1 <- x86_VPSLLV_4u64 a41
    (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((4 * 32) - 96)))));
    leakages <- LeakAddr([6]) :: leakages;
    t.[6] <- aux_1;
    leakages <- LeakAddr([(W64.to_uint (rhotates_right + (W64.of_int ((4 * 32) - 96))))]) :: leakages;
    aux_1 <- x86_VPSRLV_4u64 a41
    (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((4 * 32) - 96)))));
    a41 <- aux_1;
    leakages <- LeakAddr([6]) :: leakages;
    aux_1 <- (a41 `|` t.[6]);
    a41 <- aux_1;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- (a11 `^` d14);
    a11 <- aux_1;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- x86_VPERMQ a20 (W8.of_int 141);
    leakages <- LeakAddr([3]) :: leakages;
    t.[3] <- aux_1;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- x86_VPERMQ a31 (W8.of_int 141);
    leakages <- LeakAddr([4]) :: leakages;
    t.[4] <- aux_1;
    leakages <- LeakAddr([(W64.to_uint (rhotates_left + (W64.of_int ((5 * 32) - 96))))]) :: leakages;
    aux_1 <- x86_VPSLLV_4u64 a11
    (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((5 * 32) - 96)))));
    leakages <- LeakAddr([7]) :: leakages;
    t.[7] <- aux_1;
    leakages <- LeakAddr([(W64.to_uint (rhotates_right + (W64.of_int ((5 * 32) - 96))))]) :: leakages;
    aux_1 <- x86_VPSRLV_4u64 a11
    (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((5 * 32) - 96)))));
    leakages <- LeakAddr([1]) :: leakages;
    t.[1] <- aux_1;
    leakages <- LeakAddr([7; 1]) :: leakages;
    aux_1 <- (t.[1] `|` t.[7]);
    leakages <- LeakAddr([1]) :: leakages;
    t.[1] <- aux_1;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- (a01 `^` d14);
    a01 <- aux_1;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- x86_VPERMQ a21 (W8.of_int 27);
    leakages <- LeakAddr([5]) :: leakages;
    t.[5] <- aux_1;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- x86_VPERMQ a41 (W8.of_int 114);
    leakages <- LeakAddr([6]) :: leakages;
    t.[6] <- aux_1;
    leakages <- LeakAddr([(W64.to_uint (rhotates_left + (W64.of_int ((1 * 32) - 96))))]) :: leakages;
    aux_1 <- x86_VPSLLV_4u64 a01
    (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((1 * 32) - 96)))));
    leakages <- LeakAddr([8]) :: leakages;
    t.[8] <- aux_1;
    leakages <- LeakAddr([(W64.to_uint (rhotates_right + (W64.of_int ((1 * 32) - 96))))]) :: leakages;
    aux_1 <- x86_VPSRLV_4u64 a01
    (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((1 * 32) - 96)))));
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
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
    a31 <- aux_1;
    leakages <- LeakAddr([2; 4]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[4] t.[2]
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
    leakages <- LeakAddr([8]) :: leakages;
    t.[8] <- aux_1;
    leakages <- LeakAddr([4; 3]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[3] t.[4]
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
    a41 <- aux_1;
    leakages <- LeakAddr([3; 2]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[2] t.[3]
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
    leakages <- LeakAddr([7]) :: leakages;
    t.[7] <- aux_1;
    leakages <- LeakAddr([4]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 a31 t.[4]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    a31 <- aux_1;
    leakages <- LeakAddr([5; 8]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[8] t.[5]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    leakages <- LeakAddr([8]) :: leakages;
    t.[8] <- aux_1;
    leakages <- LeakAddr([2]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 a41 t.[2]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    a41 <- aux_1;
    leakages <- LeakAddr([6; 7]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[7] t.[6]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    leakages <- LeakAddr([7]) :: leakages;
    t.[7] <- aux_1;
    leakages <- LeakAddr([5]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 a31 t.[5]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
    a31 <- aux_1;
    leakages <- LeakAddr([6; 8]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[8] t.[6]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
    leakages <- LeakAddr([8]) :: leakages;
    t.[8] <- aux_1;
    leakages <- LeakAddr([6]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 a41 t.[6]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
    a41 <- aux_1;
    leakages <- LeakAddr([4; 7]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[7] t.[4]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
    leakages <- LeakAddr([7]) :: leakages;
    t.[7] <- aux_1;
    leakages <- LeakAddr([8]) :: leakages;
    aux_1 <- x86_VPANDN_256 a31 t.[8];
    a31 <- aux_1;
    leakages <- LeakAddr([7]) :: leakages;
    aux_1 <- x86_VPANDN_256 a41 t.[7];
    a41 <- aux_1;
    leakages <- LeakAddr([2; 5]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[5] t.[2]
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
    a11 <- aux_1;
    leakages <- LeakAddr([5; 3]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[3] t.[5]
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
    leakages <- LeakAddr([8]) :: leakages;
    t.[8] <- aux_1;
    leakages <- LeakAddr([3]) :: leakages;
    aux_1 <- (a31 `^` t.[3]);
    a31 <- aux_1;
    leakages <- LeakAddr([3]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 a11 t.[3]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    a11 <- aux_1;
    leakages <- LeakAddr([4; 8]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[8] t.[4]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    leakages <- LeakAddr([8]) :: leakages;
    t.[8] <- aux_1;
    leakages <- LeakAddr([5]) :: leakages;
    aux_1 <- (a41 `^` t.[5]);
    a41 <- aux_1;
    leakages <- LeakAddr([4]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 a11 t.[4]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
    a11 <- aux_1;
    leakages <- LeakAddr([2; 8]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[8] t.[2]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
    leakages <- LeakAddr([8]) :: leakages;
    t.[8] <- aux_1;
    leakages <- LeakAddr([8]) :: leakages;
    aux_1 <- x86_VPANDN_256 a11 t.[8];
    a11 <- aux_1;
    leakages <- LeakAddr([6]) :: leakages;
    aux_1 <- (a11 `^` t.[6]);
    a11 <- aux_1;
    leakages <- LeakAddr([1]) :: leakages;
    aux_1 <- x86_VPERMQ t.[1] (W8.of_int 30);
    a21 <- aux_1;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 a21 a00
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    leakages <- LeakAddr([8]) :: leakages;
    t.[8] <- aux_1;
    leakages <- LeakAddr([1]) :: leakages;
    aux_1 <- x86_VPERMQ t.[1] (W8.of_int 57);
    a01 <- aux_1;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 a01 a00
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
    a01 <- aux_1;
    leakages <- LeakAddr([8]) :: leakages;
    aux_1 <- x86_VPANDN_256 a01 t.[8];
    a01 <- aux_1;
    leakages <- LeakAddr([5; 4]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[4] t.[5]
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
    a20 <- aux_1;
    leakages <- LeakAddr([4; 6]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[6] t.[4]
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
    leakages <- LeakAddr([7]) :: leakages;
    t.[7] <- aux_1;
    leakages <- LeakAddr([6]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 a20 t.[6]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    a20 <- aux_1;
    leakages <- LeakAddr([3; 7]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[7] t.[3]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    leakages <- LeakAddr([7]) :: leakages;
    t.[7] <- aux_1;
    leakages <- LeakAddr([3]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 a20 t.[3]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
    a20 <- aux_1;
    leakages <- LeakAddr([5; 7]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[7] t.[5]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
    leakages <- LeakAddr([7]) :: leakages;
    t.[7] <- aux_1;
    leakages <- LeakAddr([7]) :: leakages;
    aux_1 <- x86_VPANDN_256 a20 t.[7];
    a20 <- aux_1;
    leakages <- LeakAddr([2]) :: leakages;
    aux_1 <- (a20 `^` t.[2]);
    a20 <- aux_1;
    leakages <- LeakAddr([0]) :: leakages;
    aux_1 <- x86_VPERMQ t.[0] (W8.of_int 0);
    leakages <- LeakAddr([0]) :: leakages;
    t.[0] <- aux_1;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- x86_VPERMQ a31 (W8.of_int 27);
    a31 <- aux_1;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- x86_VPERMQ a41 (W8.of_int 141);
    a41 <- aux_1;
    leakages <- LeakAddr([]) :: leakages;
    aux_1 <- x86_VPERMQ a11 (W8.of_int 114);
    a11 <- aux_1;
    leakages <- LeakAddr([3; 6]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[6] t.[3]
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
    a21 <- aux_1;
    leakages <- LeakAddr([6; 5]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[5] t.[6]
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
    leakages <- LeakAddr([7]) :: leakages;
    t.[7] <- aux_1;
    leakages <- LeakAddr([5]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 a21 t.[5]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    a21 <- aux_1;
    leakages <- LeakAddr([2; 7]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[7] t.[2]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    leakages <- LeakAddr([7]) :: leakages;
    t.[7] <- aux_1;
    leakages <- LeakAddr([2]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 a21 t.[2]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
    a21 <- aux_1;
    leakages <- LeakAddr([3; 7]) :: leakages;
    aux_1 <- x86_VPBLENDD_256 t.[7] t.[3]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
    leakages <- LeakAddr([7]) :: leakages;
    t.[7] <- aux_1;
    leakages <- LeakAddr([7]) :: leakages;
    aux_1 <- x86_VPANDN_256 a21 t.[7];
    a21 <- aux_1;
    leakages <- LeakAddr([0]) :: leakages;
    aux_1 <- (a00 `^` t.[0]);
    a00 <- aux_1;
    leakages <- LeakAddr([1]) :: leakages;
    aux_1 <- (a01 `^` t.[1]);
    a01 <- aux_1;
    leakages <- LeakAddr([4]) :: leakages;
    aux_1 <- (a21 `^` t.[4]);
    a21 <- aux_1;
    leakages <- LeakAddr([(W64.to_uint (iotas + (W64.of_int 0)))]) :: leakages;
    aux_1 <- (a00 `^` (loadW256 Glob.mem (W64.to_uint (iotas + (W64.of_int 0)))));
    a00 <- aux_1;
    leakages <- LeakAddr([]) :: leakages;
    aux <- (iotas + (W64.of_int 32));
    iotas <- aux;
    leakages <- LeakAddr([]) :: leakages;
    (aux_5, aux_4, aux_3, aux_2, aux_0) <- x86_DEC_32 i;
     _0 <- aux_5;
     _1 <- aux_4;
     _2 <- aux_3;
    zf <- aux_2;
    i <- aux_0;
    leakages <- LeakCond((! zf)) :: LeakAddr([]) :: leakages;
    
    while ((! zf)) {
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- x86_VPSHUFD_256 a20 (W8.of_int 78);
      c00 <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- (a41 `^` a31);
      c14 <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- (a21 `^` a11);
      leakages <- LeakAddr([2]) :: leakages;
      t.[2] <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- (c14 `^` a01);
      c14 <- aux_1;
      leakages <- LeakAddr([2]) :: leakages;
      aux_1 <- (c14 `^` t.[2]);
      c14 <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- x86_VPERMQ c14 (W8.of_int 147);
      leakages <- LeakAddr([4]) :: leakages;
      t.[4] <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- (c00 `^` a20);
      c00 <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- x86_VPERMQ c00 (W8.of_int 78);
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
      aux_1 <- x86_VPERMQ t.[1] (W8.of_int 57);
      d14 <- aux_1;
      leakages <- LeakAddr([4; 1]) :: leakages;
      aux_1 <- (t.[1] `^` t.[4]);
      d00 <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- x86_VPERMQ d00 (W8.of_int 0);
      d00 <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- (c00 `^` a00);
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
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- (a20 `^` d00);
      a20 <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- (a00 `^` d00);
      a00 <- aux_1;
      leakages <- LeakAddr([1]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 d14 t.[1]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
      d14 <- aux_1;
      leakages <- LeakAddr([4]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[4] c00
      (W8.of_int (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
      leakages <- LeakAddr([4]) :: leakages;
      t.[4] <- aux_1;
      leakages <- LeakAddr([4]) :: leakages;
      aux_1 <- (d14 `^` t.[4]);
      d14 <- aux_1;
      leakages <- LeakAddr([(W64.to_uint (rhotates_left + (W64.of_int ((0 * 32) - 96))))]) :: leakages;
      aux_1 <- x86_VPSLLV_4u64 a20
      (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((0 * 32) - 96)))));
      leakages <- LeakAddr([3]) :: leakages;
      t.[3] <- aux_1;
      leakages <- LeakAddr([(W64.to_uint (rhotates_right + (W64.of_int ((0 * 32) - 96))))]) :: leakages;
      aux_1 <- x86_VPSRLV_4u64 a20
      (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((0 * 32) - 96)))));
      a20 <- aux_1;
      leakages <- LeakAddr([3]) :: leakages;
      aux_1 <- (a20 `|` t.[3]);
      a20 <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- (a31 `^` d14);
      a31 <- aux_1;
      leakages <- LeakAddr([(W64.to_uint (rhotates_left + (W64.of_int ((2 * 32) - 96))))]) :: leakages;
      aux_1 <- x86_VPSLLV_4u64 a31
      (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((2 * 32) - 96)))));
      leakages <- LeakAddr([4]) :: leakages;
      t.[4] <- aux_1;
      leakages <- LeakAddr([(W64.to_uint (rhotates_right + (W64.of_int ((2 * 32) - 96))))]) :: leakages;
      aux_1 <- x86_VPSRLV_4u64 a31
      (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((2 * 32) - 96)))));
      a31 <- aux_1;
      leakages <- LeakAddr([4]) :: leakages;
      aux_1 <- (a31 `|` t.[4]);
      a31 <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- (a21 `^` d14);
      a21 <- aux_1;
      leakages <- LeakAddr([(W64.to_uint (rhotates_left + (W64.of_int ((3 * 32) - 96))))]) :: leakages;
      aux_1 <- x86_VPSLLV_4u64 a21
      (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((3 * 32) - 96)))));
      leakages <- LeakAddr([5]) :: leakages;
      t.[5] <- aux_1;
      leakages <- LeakAddr([(W64.to_uint (rhotates_right + (W64.of_int ((3 * 32) - 96))))]) :: leakages;
      aux_1 <- x86_VPSRLV_4u64 a21
      (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((3 * 32) - 96)))));
      a21 <- aux_1;
      leakages <- LeakAddr([5]) :: leakages;
      aux_1 <- (a21 `|` t.[5]);
      a21 <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- (a41 `^` d14);
      a41 <- aux_1;
      leakages <- LeakAddr([(W64.to_uint (rhotates_left + (W64.of_int ((4 * 32) - 96))))]) :: leakages;
      aux_1 <- x86_VPSLLV_4u64 a41
      (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((4 * 32) - 96)))));
      leakages <- LeakAddr([6]) :: leakages;
      t.[6] <- aux_1;
      leakages <- LeakAddr([(W64.to_uint (rhotates_right + (W64.of_int ((4 * 32) - 96))))]) :: leakages;
      aux_1 <- x86_VPSRLV_4u64 a41
      (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((4 * 32) - 96)))));
      a41 <- aux_1;
      leakages <- LeakAddr([6]) :: leakages;
      aux_1 <- (a41 `|` t.[6]);
      a41 <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- (a11 `^` d14);
      a11 <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- x86_VPERMQ a20 (W8.of_int 141);
      leakages <- LeakAddr([3]) :: leakages;
      t.[3] <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- x86_VPERMQ a31 (W8.of_int 141);
      leakages <- LeakAddr([4]) :: leakages;
      t.[4] <- aux_1;
      leakages <- LeakAddr([(W64.to_uint (rhotates_left + (W64.of_int ((5 * 32) - 96))))]) :: leakages;
      aux_1 <- x86_VPSLLV_4u64 a11
      (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((5 * 32) - 96)))));
      leakages <- LeakAddr([7]) :: leakages;
      t.[7] <- aux_1;
      leakages <- LeakAddr([(W64.to_uint (rhotates_right + (W64.of_int ((5 * 32) - 96))))]) :: leakages;
      aux_1 <- x86_VPSRLV_4u64 a11
      (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((5 * 32) - 96)))));
      leakages <- LeakAddr([1]) :: leakages;
      t.[1] <- aux_1;
      leakages <- LeakAddr([7; 1]) :: leakages;
      aux_1 <- (t.[1] `|` t.[7]);
      leakages <- LeakAddr([1]) :: leakages;
      t.[1] <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- (a01 `^` d14);
      a01 <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- x86_VPERMQ a21 (W8.of_int 27);
      leakages <- LeakAddr([5]) :: leakages;
      t.[5] <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- x86_VPERMQ a41 (W8.of_int 114);
      leakages <- LeakAddr([6]) :: leakages;
      t.[6] <- aux_1;
      leakages <- LeakAddr([(W64.to_uint (rhotates_left + (W64.of_int ((1 * 32) - 96))))]) :: leakages;
      aux_1 <- x86_VPSLLV_4u64 a01
      (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((1 * 32) - 96)))));
      leakages <- LeakAddr([8]) :: leakages;
      t.[8] <- aux_1;
      leakages <- LeakAddr([(W64.to_uint (rhotates_right + (W64.of_int ((1 * 32) - 96))))]) :: leakages;
      aux_1 <- x86_VPSRLV_4u64 a01
      (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((1 * 32) - 96)))));
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
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
      a31 <- aux_1;
      leakages <- LeakAddr([2; 4]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[4] t.[2]
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
      leakages <- LeakAddr([8]) :: leakages;
      t.[8] <- aux_1;
      leakages <- LeakAddr([4; 3]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[3] t.[4]
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
      a41 <- aux_1;
      leakages <- LeakAddr([3; 2]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[2] t.[3]
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
      leakages <- LeakAddr([7]) :: leakages;
      t.[7] <- aux_1;
      leakages <- LeakAddr([4]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 a31 t.[4]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
      a31 <- aux_1;
      leakages <- LeakAddr([5; 8]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[8] t.[5]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
      leakages <- LeakAddr([8]) :: leakages;
      t.[8] <- aux_1;
      leakages <- LeakAddr([2]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 a41 t.[2]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
      a41 <- aux_1;
      leakages <- LeakAddr([6; 7]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[7] t.[6]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
      leakages <- LeakAddr([7]) :: leakages;
      t.[7] <- aux_1;
      leakages <- LeakAddr([5]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 a31 t.[5]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
      a31 <- aux_1;
      leakages <- LeakAddr([6; 8]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[8] t.[6]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
      leakages <- LeakAddr([8]) :: leakages;
      t.[8] <- aux_1;
      leakages <- LeakAddr([6]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 a41 t.[6]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
      a41 <- aux_1;
      leakages <- LeakAddr([4; 7]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[7] t.[4]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
      leakages <- LeakAddr([7]) :: leakages;
      t.[7] <- aux_1;
      leakages <- LeakAddr([8]) :: leakages;
      aux_1 <- x86_VPANDN_256 a31 t.[8];
      a31 <- aux_1;
      leakages <- LeakAddr([7]) :: leakages;
      aux_1 <- x86_VPANDN_256 a41 t.[7];
      a41 <- aux_1;
      leakages <- LeakAddr([2; 5]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[5] t.[2]
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
      a11 <- aux_1;
      leakages <- LeakAddr([5; 3]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[3] t.[5]
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
      leakages <- LeakAddr([8]) :: leakages;
      t.[8] <- aux_1;
      leakages <- LeakAddr([3]) :: leakages;
      aux_1 <- (a31 `^` t.[3]);
      a31 <- aux_1;
      leakages <- LeakAddr([3]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 a11 t.[3]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
      a11 <- aux_1;
      leakages <- LeakAddr([4; 8]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[8] t.[4]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
      leakages <- LeakAddr([8]) :: leakages;
      t.[8] <- aux_1;
      leakages <- LeakAddr([5]) :: leakages;
      aux_1 <- (a41 `^` t.[5]);
      a41 <- aux_1;
      leakages <- LeakAddr([4]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 a11 t.[4]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
      a11 <- aux_1;
      leakages <- LeakAddr([2; 8]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[8] t.[2]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
      leakages <- LeakAddr([8]) :: leakages;
      t.[8] <- aux_1;
      leakages <- LeakAddr([8]) :: leakages;
      aux_1 <- x86_VPANDN_256 a11 t.[8];
      a11 <- aux_1;
      leakages <- LeakAddr([6]) :: leakages;
      aux_1 <- (a11 `^` t.[6]);
      a11 <- aux_1;
      leakages <- LeakAddr([1]) :: leakages;
      aux_1 <- x86_VPERMQ t.[1] (W8.of_int 30);
      a21 <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 a21 a00
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
      leakages <- LeakAddr([8]) :: leakages;
      t.[8] <- aux_1;
      leakages <- LeakAddr([1]) :: leakages;
      aux_1 <- x86_VPERMQ t.[1] (W8.of_int 57);
      a01 <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 a01 a00
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
      a01 <- aux_1;
      leakages <- LeakAddr([8]) :: leakages;
      aux_1 <- x86_VPANDN_256 a01 t.[8];
      a01 <- aux_1;
      leakages <- LeakAddr([5; 4]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[4] t.[5]
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
      a20 <- aux_1;
      leakages <- LeakAddr([4; 6]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[6] t.[4]
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
      leakages <- LeakAddr([7]) :: leakages;
      t.[7] <- aux_1;
      leakages <- LeakAddr([6]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 a20 t.[6]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
      a20 <- aux_1;
      leakages <- LeakAddr([3; 7]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[7] t.[3]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
      leakages <- LeakAddr([7]) :: leakages;
      t.[7] <- aux_1;
      leakages <- LeakAddr([3]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 a20 t.[3]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
      a20 <- aux_1;
      leakages <- LeakAddr([5; 7]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[7] t.[5]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
      leakages <- LeakAddr([7]) :: leakages;
      t.[7] <- aux_1;
      leakages <- LeakAddr([7]) :: leakages;
      aux_1 <- x86_VPANDN_256 a20 t.[7];
      a20 <- aux_1;
      leakages <- LeakAddr([2]) :: leakages;
      aux_1 <- (a20 `^` t.[2]);
      a20 <- aux_1;
      leakages <- LeakAddr([0]) :: leakages;
      aux_1 <- x86_VPERMQ t.[0] (W8.of_int 0);
      leakages <- LeakAddr([0]) :: leakages;
      t.[0] <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- x86_VPERMQ a31 (W8.of_int 27);
      a31 <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- x86_VPERMQ a41 (W8.of_int 141);
      a41 <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux_1 <- x86_VPERMQ a11 (W8.of_int 114);
      a11 <- aux_1;
      leakages <- LeakAddr([3; 6]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[6] t.[3]
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
      a21 <- aux_1;
      leakages <- LeakAddr([6; 5]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[5] t.[6]
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
      leakages <- LeakAddr([7]) :: leakages;
      t.[7] <- aux_1;
      leakages <- LeakAddr([5]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 a21 t.[5]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
      a21 <- aux_1;
      leakages <- LeakAddr([2; 7]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[7] t.[2]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
      leakages <- LeakAddr([7]) :: leakages;
      t.[7] <- aux_1;
      leakages <- LeakAddr([2]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 a21 t.[2]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
      a21 <- aux_1;
      leakages <- LeakAddr([3; 7]) :: leakages;
      aux_1 <- x86_VPBLENDD_256 t.[7] t.[3]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
      leakages <- LeakAddr([7]) :: leakages;
      t.[7] <- aux_1;
      leakages <- LeakAddr([7]) :: leakages;
      aux_1 <- x86_VPANDN_256 a21 t.[7];
      a21 <- aux_1;
      leakages <- LeakAddr([0]) :: leakages;
      aux_1 <- (a00 `^` t.[0]);
      a00 <- aux_1;
      leakages <- LeakAddr([1]) :: leakages;
      aux_1 <- (a01 `^` t.[1]);
      a01 <- aux_1;
      leakages <- LeakAddr([4]) :: leakages;
      aux_1 <- (a21 `^` t.[4]);
      a21 <- aux_1;
      leakages <- LeakAddr([(W64.to_uint (iotas + (W64.of_int 0)))]) :: leakages;
      aux_1 <- (a00 `^` (loadW256 Glob.mem (W64.to_uint (iotas + (W64.of_int 0)))));
      a00 <- aux_1;
      leakages <- LeakAddr([]) :: leakages;
      aux <- (iotas + (W64.of_int 32));
      iotas <- aux;
      leakages <- LeakAddr([]) :: leakages;
      (aux_5, aux_4, aux_3, aux_2, aux_0) <- x86_DEC_32 i;
       _0 <- aux_5;
       _1 <- aux_4;
       _2 <- aux_3;
      zf <- aux_2;
      i <- aux_0;
    leakages <- LeakCond((! zf)) :: LeakAddr([]) :: leakages;
    
    }
    return (a00, a01, a20, a31, a21, a41, a11);
  }
}.


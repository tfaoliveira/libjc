require import List Int IntExtra IntDiv CoreMap.
from Jasmin require import JModel.

require import Array7 Array9.
require import WArray224 WArray288.



module M = {
  proc keccak_f (state:W256.t Array7.t, _rhotates_left:W64.t,
                 _rhotates_right:W64.t, _iotas:W64.t) : W256.t Array7.t = {
    
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
    rhotates_left <- (_rhotates_left + (W64.of_int 96));
    rhotates_right <- (_rhotates_right + (W64.of_int 96));
    iotas <- _iotas;
    r <- (W32.of_int 24);
    c00 <- x86_VPSHUFD_256 state.[2]
    (W8.of_int (2 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 1))));
    c14 <- (state.[5] `^` state.[3]);
    t.[2] <- (state.[4] `^` state.[6]);
    c14 <- (c14 `^` state.[1]);
    c14 <- (c14 `^` t.[2]);
    t.[4] <- x86_VPERMQ c14
    (W8.of_int (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (1 %% 2^2 + 2^2 * 2))));
    c00 <- (c00 `^` state.[2]);
    t.[0] <- x86_VPERMQ c00
    (W8.of_int (2 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 1))));
    t.[1] <- (c14 \vshr64u256 (W8.of_int 63));
    t.[2] <- (c14 \vadd64u256 c14);
    t.[1] <- (t.[1] `|` t.[2]);
    d14 <- x86_VPERMQ t.[1]
    (W8.of_int (1 %% 2^2 + 2^2 * (2 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    d00 <- (t.[1] `^` t.[4]);
    d00 <- x86_VPERMQ d00
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
    c00 <- (c00 `^` state.[0]);
    c00 <- (c00 `^` t.[0]);
    t.[0] <- (c00 \vshr64u256 (W8.of_int 63));
    t.[1] <- (c00 \vadd64u256 c00);
    t.[1] <- (t.[1] `|` t.[0]);
    state.[2] <- (state.[2] `^` d00);
    state.[0] <- (state.[0] `^` d00);
    d14 <- x86_VPBLENDD_256 d14 t.[1]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (1 %% 2^1 + 2^1 * 1))))))));
    t.[4] <- x86_VPBLENDD_256 t.[4] c00
    (W8.of_int (1 %% 2^1 +
               2^1 * (1 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    d14 <- (d14 `^` t.[4]);
    t.[3] <- x86_VPSLLV_4u64 state.[2]
    (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((0 * 32) - 96)))));
    state.[2] <- x86_VPSRLV_4u64 state.[2]
    (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((0 * 32) - 96)))));
    state.[2] <- (state.[2] `|` t.[3]);
    state.[3] <- (state.[3] `^` d14);
    t.[4] <- x86_VPSLLV_4u64 state.[3]
    (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((2 * 32) - 96)))));
    state.[3] <- x86_VPSRLV_4u64 state.[3]
    (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((2 * 32) - 96)))));
    state.[3] <- (state.[3] `|` t.[4]);
    state.[4] <- (state.[4] `^` d14);
    t.[5] <- x86_VPSLLV_4u64 state.[4]
    (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((3 * 32) - 96)))));
    state.[4] <- x86_VPSRLV_4u64 state.[4]
    (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((3 * 32) - 96)))));
    state.[4] <- (state.[4] `|` t.[5]);
    state.[5] <- (state.[5] `^` d14);
    t.[6] <- x86_VPSLLV_4u64 state.[5]
    (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((4 * 32) - 96)))));
    state.[5] <- x86_VPSRLV_4u64 state.[5]
    (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((4 * 32) - 96)))));
    state.[5] <- (state.[5] `|` t.[6]);
    state.[6] <- (state.[6] `^` d14);
    t.[3] <- x86_VPERMQ state.[2]
    (W8.of_int (1 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 2))));
    t.[4] <- x86_VPERMQ state.[3]
    (W8.of_int (1 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 2))));
    t.[7] <- x86_VPSLLV_4u64 state.[6]
    (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((5 * 32) - 96)))));
    t.[1] <- x86_VPSRLV_4u64 state.[6]
    (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((5 * 32) - 96)))));
    t.[1] <- (t.[1] `|` t.[7]);
    state.[1] <- (state.[1] `^` d14);
    t.[5] <- x86_VPERMQ state.[4]
    (W8.of_int (3 %% 2^2 + 2^2 * (2 %% 2^2 + 2^2 * (1 %% 2^2 + 2^2 * 0))));
    t.[6] <- x86_VPERMQ state.[5]
    (W8.of_int (2 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 1))));
    t.[8] <- x86_VPSLLV_4u64 state.[1]
    (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((1 * 32) - 96)))));
    t.[2] <- x86_VPSRLV_4u64 state.[1]
    (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((1 * 32) - 96)))));
    t.[2] <- (t.[2] `|` t.[8]);
    t.[7] <- x86_VPSRLDQ_256 t.[1] (W8.of_int 8);
    t.[0] <- ((invw t.[1]) `&` t.[7]);
    state.[3] <- x86_VPBLENDD_256 t.[2] t.[6]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (1 %% 2^1 +
                           2^1 * (1 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    t.[8] <- x86_VPBLENDD_256 t.[4] t.[2]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (1 %% 2^1 +
                           2^1 * (1 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    state.[5] <- x86_VPBLENDD_256 t.[3] t.[4]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (1 %% 2^1 +
                           2^1 * (1 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    t.[7] <- x86_VPBLENDD_256 t.[2] t.[3]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (1 %% 2^1 +
                           2^1 * (1 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    state.[3] <- x86_VPBLENDD_256 state.[3] t.[4]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (1 %% 2^1 +
                                       2^1 * (1 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    t.[8] <- x86_VPBLENDD_256 t.[8] t.[5]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (1 %% 2^1 +
                                       2^1 * (1 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    state.[5] <- x86_VPBLENDD_256 state.[5] t.[2]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (1 %% 2^1 +
                                       2^1 * (1 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    t.[7] <- x86_VPBLENDD_256 t.[7] t.[6]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (1 %% 2^1 +
                                       2^1 * (1 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    state.[3] <- x86_VPBLENDD_256 state.[3] t.[5]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (1 %% 2^1 + 2^1 * 1))))))));
    t.[8] <- x86_VPBLENDD_256 t.[8] t.[6]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (1 %% 2^1 + 2^1 * 1))))))));
    state.[5] <- x86_VPBLENDD_256 state.[5] t.[6]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (1 %% 2^1 + 2^1 * 1))))))));
    t.[7] <- x86_VPBLENDD_256 t.[7] t.[4]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (1 %% 2^1 + 2^1 * 1))))))));
    state.[3] <- ((invw state.[3]) `&` t.[8]);
    state.[5] <- ((invw state.[5]) `&` t.[7]);
    state.[6] <- x86_VPBLENDD_256 t.[5] t.[2]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (1 %% 2^1 +
                           2^1 * (1 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    t.[8] <- x86_VPBLENDD_256 t.[3] t.[5]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (1 %% 2^1 +
                           2^1 * (1 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    state.[3] <- (state.[3] `^` t.[3]);
    state.[6] <- x86_VPBLENDD_256 state.[6] t.[3]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (1 %% 2^1 +
                                       2^1 * (1 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    t.[8] <- x86_VPBLENDD_256 t.[8] t.[4]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (1 %% 2^1 +
                                       2^1 * (1 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    state.[5] <- (state.[5] `^` t.[5]);
    state.[6] <- x86_VPBLENDD_256 state.[6] t.[4]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (1 %% 2^1 + 2^1 * 1))))))));
    t.[8] <- x86_VPBLENDD_256 t.[8] t.[2]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (1 %% 2^1 + 2^1 * 1))))))));
    state.[6] <- ((invw state.[6]) `&` t.[8]);
    state.[6] <- (state.[6] `^` t.[6]);
    state.[4] <- x86_VPERMQ t.[1]
    (W8.of_int (2 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (1 %% 2^2 + 2^2 * 0))));
    t.[8] <- x86_VPBLENDD_256 state.[4] state.[0]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (1 %% 2^1 +
                                       2^1 * (1 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    state.[1] <- x86_VPERMQ t.[1]
    (W8.of_int (1 %% 2^2 + 2^2 * (2 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    state.[1] <- x86_VPBLENDD_256 state.[1] state.[0]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (1 %% 2^1 + 2^1 * 1))))))));
    state.[1] <- ((invw state.[1]) `&` t.[8]);
    state.[2] <- x86_VPBLENDD_256 t.[4] t.[5]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (1 %% 2^1 +
                           2^1 * (1 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    t.[7] <- x86_VPBLENDD_256 t.[6] t.[4]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (1 %% 2^1 +
                           2^1 * (1 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    state.[2] <- x86_VPBLENDD_256 state.[2] t.[6]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (1 %% 2^1 +
                                       2^1 * (1 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    t.[7] <- x86_VPBLENDD_256 t.[7] t.[3]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (1 %% 2^1 +
                                       2^1 * (1 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    state.[2] <- x86_VPBLENDD_256 state.[2] t.[3]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (1 %% 2^1 + 2^1 * 1))))))));
    t.[7] <- x86_VPBLENDD_256 t.[7] t.[5]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (1 %% 2^1 + 2^1 * 1))))))));
    state.[2] <- ((invw state.[2]) `&` t.[7]);
    state.[2] <- (state.[2] `^` t.[2]);
    t.[0] <- x86_VPERMQ t.[0]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
    state.[3] <- x86_VPERMQ state.[3]
    (W8.of_int (3 %% 2^2 + 2^2 * (2 %% 2^2 + 2^2 * (1 %% 2^2 + 2^2 * 0))));
    state.[5] <- x86_VPERMQ state.[5]
    (W8.of_int (1 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 2))));
    state.[6] <- x86_VPERMQ state.[6]
    (W8.of_int (2 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 1))));
    state.[4] <- x86_VPBLENDD_256 t.[6] t.[3]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (1 %% 2^1 +
                           2^1 * (1 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    t.[7] <- x86_VPBLENDD_256 t.[5] t.[6]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (1 %% 2^1 +
                           2^1 * (1 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    state.[4] <- x86_VPBLENDD_256 state.[4] t.[5]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (1 %% 2^1 +
                                       2^1 * (1 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    t.[7] <- x86_VPBLENDD_256 t.[7] t.[2]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (1 %% 2^1 +
                                       2^1 * (1 %% 2^1 +
                                             2^1 * (0 %% 2^1 + 2^1 * 0))))))));
    state.[4] <- x86_VPBLENDD_256 state.[4] t.[2]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (1 %% 2^1 + 2^1 * 1))))))));
    t.[7] <- x86_VPBLENDD_256 t.[7] t.[3]
    (W8.of_int (0 %% 2^1 +
               2^1 * (0 %% 2^1 +
                     2^1 * (0 %% 2^1 +
                           2^1 * (0 %% 2^1 +
                                 2^1 * (0 %% 2^1 +
                                       2^1 * (0 %% 2^1 +
                                             2^1 * (1 %% 2^1 + 2^1 * 1))))))));
    state.[4] <- ((invw state.[4]) `&` t.[7]);
    state.[0] <- (state.[0] `^` t.[0]);
    state.[1] <- (state.[1] `^` t.[1]);
    state.[4] <- (state.[4] `^` t.[4]);
    state.[0] <-
    (state.[0] `^` (loadW256 Glob.mem (W64.to_uint (iotas + (W64.of_int ((0 * 32) - 0))))));
    iotas <- (iotas + (W64.of_int 32));
    ( _0,  _1,  _2, zf, r) <- x86_DEC_32 r;
    while ((! zf)) {
      c00 <- x86_VPSHUFD_256 state.[2]
      (W8.of_int (2 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 1))));
      c14 <- (state.[5] `^` state.[3]);
      t.[2] <- (state.[4] `^` state.[6]);
      c14 <- (c14 `^` state.[1]);
      c14 <- (c14 `^` t.[2]);
      t.[4] <- x86_VPERMQ c14
      (W8.of_int (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (1 %% 2^2 + 2^2 * 2))));
      c00 <- (c00 `^` state.[2]);
      t.[0] <- x86_VPERMQ c00
      (W8.of_int (2 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 1))));
      t.[1] <- (c14 \vshr64u256 (W8.of_int 63));
      t.[2] <- (c14 \vadd64u256 c14);
      t.[1] <- (t.[1] `|` t.[2]);
      d14 <- x86_VPERMQ t.[1]
      (W8.of_int (1 %% 2^2 + 2^2 * (2 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
      d00 <- (t.[1] `^` t.[4]);
      d00 <- x86_VPERMQ d00
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
      c00 <- (c00 `^` state.[0]);
      c00 <- (c00 `^` t.[0]);
      t.[0] <- (c00 \vshr64u256 (W8.of_int 63));
      t.[1] <- (c00 \vadd64u256 c00);
      t.[1] <- (t.[1] `|` t.[0]);
      state.[2] <- (state.[2] `^` d00);
      state.[0] <- (state.[0] `^` d00);
      d14 <- x86_VPBLENDD_256 d14 t.[1]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (1 %% 2^1 + 2^1 * 1))))))));
      t.[4] <- x86_VPBLENDD_256 t.[4] c00
      (W8.of_int (1 %% 2^1 +
                 2^1 * (1 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      d14 <- (d14 `^` t.[4]);
      t.[3] <- x86_VPSLLV_4u64 state.[2]
      (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((0 * 32) - 96)))));
      state.[2] <- x86_VPSRLV_4u64 state.[2]
      (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((0 * 32) - 96)))));
      state.[2] <- (state.[2] `|` t.[3]);
      state.[3] <- (state.[3] `^` d14);
      t.[4] <- x86_VPSLLV_4u64 state.[3]
      (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((2 * 32) - 96)))));
      state.[3] <- x86_VPSRLV_4u64 state.[3]
      (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((2 * 32) - 96)))));
      state.[3] <- (state.[3] `|` t.[4]);
      state.[4] <- (state.[4] `^` d14);
      t.[5] <- x86_VPSLLV_4u64 state.[4]
      (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((3 * 32) - 96)))));
      state.[4] <- x86_VPSRLV_4u64 state.[4]
      (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((3 * 32) - 96)))));
      state.[4] <- (state.[4] `|` t.[5]);
      state.[5] <- (state.[5] `^` d14);
      t.[6] <- x86_VPSLLV_4u64 state.[5]
      (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((4 * 32) - 96)))));
      state.[5] <- x86_VPSRLV_4u64 state.[5]
      (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((4 * 32) - 96)))));
      state.[5] <- (state.[5] `|` t.[6]);
      state.[6] <- (state.[6] `^` d14);
      t.[3] <- x86_VPERMQ state.[2]
      (W8.of_int (1 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 2))));
      t.[4] <- x86_VPERMQ state.[3]
      (W8.of_int (1 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 2))));
      t.[7] <- x86_VPSLLV_4u64 state.[6]
      (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((5 * 32) - 96)))));
      t.[1] <- x86_VPSRLV_4u64 state.[6]
      (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((5 * 32) - 96)))));
      t.[1] <- (t.[1] `|` t.[7]);
      state.[1] <- (state.[1] `^` d14);
      t.[5] <- x86_VPERMQ state.[4]
      (W8.of_int (3 %% 2^2 + 2^2 * (2 %% 2^2 + 2^2 * (1 %% 2^2 + 2^2 * 0))));
      t.[6] <- x86_VPERMQ state.[5]
      (W8.of_int (2 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 1))));
      t.[8] <- x86_VPSLLV_4u64 state.[1]
      (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((1 * 32) - 96)))));
      t.[2] <- x86_VPSRLV_4u64 state.[1]
      (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((1 * 32) - 96)))));
      t.[2] <- (t.[2] `|` t.[8]);
      t.[7] <- x86_VPSRLDQ_256 t.[1] (W8.of_int 8);
      t.[0] <- ((invw t.[1]) `&` t.[7]);
      state.[3] <- x86_VPBLENDD_256 t.[2] t.[6]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (1 %% 2^1 +
                             2^1 * (1 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      t.[8] <- x86_VPBLENDD_256 t.[4] t.[2]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (1 %% 2^1 +
                             2^1 * (1 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      state.[5] <- x86_VPBLENDD_256 t.[3] t.[4]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (1 %% 2^1 +
                             2^1 * (1 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      t.[7] <- x86_VPBLENDD_256 t.[2] t.[3]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (1 %% 2^1 +
                             2^1 * (1 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      state.[3] <- x86_VPBLENDD_256 state.[3] t.[4]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (1 %% 2^1 +
                                         2^1 * (1 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      t.[8] <- x86_VPBLENDD_256 t.[8] t.[5]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (1 %% 2^1 +
                                         2^1 * (1 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      state.[5] <- x86_VPBLENDD_256 state.[5] t.[2]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (1 %% 2^1 +
                                         2^1 * (1 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      t.[7] <- x86_VPBLENDD_256 t.[7] t.[6]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (1 %% 2^1 +
                                         2^1 * (1 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      state.[3] <- x86_VPBLENDD_256 state.[3] t.[5]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (1 %% 2^1 + 2^1 * 1))))))));
      t.[8] <- x86_VPBLENDD_256 t.[8] t.[6]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (1 %% 2^1 + 2^1 * 1))))))));
      state.[5] <- x86_VPBLENDD_256 state.[5] t.[6]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (1 %% 2^1 + 2^1 * 1))))))));
      t.[7] <- x86_VPBLENDD_256 t.[7] t.[4]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (1 %% 2^1 + 2^1 * 1))))))));
      state.[3] <- ((invw state.[3]) `&` t.[8]);
      state.[5] <- ((invw state.[5]) `&` t.[7]);
      state.[6] <- x86_VPBLENDD_256 t.[5] t.[2]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (1 %% 2^1 +
                             2^1 * (1 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      t.[8] <- x86_VPBLENDD_256 t.[3] t.[5]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (1 %% 2^1 +
                             2^1 * (1 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      state.[3] <- (state.[3] `^` t.[3]);
      state.[6] <- x86_VPBLENDD_256 state.[6] t.[3]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (1 %% 2^1 +
                                         2^1 * (1 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      t.[8] <- x86_VPBLENDD_256 t.[8] t.[4]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (1 %% 2^1 +
                                         2^1 * (1 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      state.[5] <- (state.[5] `^` t.[5]);
      state.[6] <- x86_VPBLENDD_256 state.[6] t.[4]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (1 %% 2^1 + 2^1 * 1))))))));
      t.[8] <- x86_VPBLENDD_256 t.[8] t.[2]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (1 %% 2^1 + 2^1 * 1))))))));
      state.[6] <- ((invw state.[6]) `&` t.[8]);
      state.[6] <- (state.[6] `^` t.[6]);
      state.[4] <- x86_VPERMQ t.[1]
      (W8.of_int (2 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (1 %% 2^2 + 2^2 * 0))));
      t.[8] <- x86_VPBLENDD_256 state.[4] state.[0]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (1 %% 2^1 +
                                         2^1 * (1 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      state.[1] <- x86_VPERMQ t.[1]
      (W8.of_int (1 %% 2^2 + 2^2 * (2 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
      state.[1] <- x86_VPBLENDD_256 state.[1] state.[0]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (1 %% 2^1 + 2^1 * 1))))))));
      state.[1] <- ((invw state.[1]) `&` t.[8]);
      state.[2] <- x86_VPBLENDD_256 t.[4] t.[5]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (1 %% 2^1 +
                             2^1 * (1 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      t.[7] <- x86_VPBLENDD_256 t.[6] t.[4]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (1 %% 2^1 +
                             2^1 * (1 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      state.[2] <- x86_VPBLENDD_256 state.[2] t.[6]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (1 %% 2^1 +
                                         2^1 * (1 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      t.[7] <- x86_VPBLENDD_256 t.[7] t.[3]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (1 %% 2^1 +
                                         2^1 * (1 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      state.[2] <- x86_VPBLENDD_256 state.[2] t.[3]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (1 %% 2^1 + 2^1 * 1))))))));
      t.[7] <- x86_VPBLENDD_256 t.[7] t.[5]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (1 %% 2^1 + 2^1 * 1))))))));
      state.[2] <- ((invw state.[2]) `&` t.[7]);
      state.[2] <- (state.[2] `^` t.[2]);
      t.[0] <- x86_VPERMQ t.[0]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
      state.[3] <- x86_VPERMQ state.[3]
      (W8.of_int (3 %% 2^2 + 2^2 * (2 %% 2^2 + 2^2 * (1 %% 2^2 + 2^2 * 0))));
      state.[5] <- x86_VPERMQ state.[5]
      (W8.of_int (1 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 2))));
      state.[6] <- x86_VPERMQ state.[6]
      (W8.of_int (2 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 1))));
      state.[4] <- x86_VPBLENDD_256 t.[6] t.[3]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (1 %% 2^1 +
                             2^1 * (1 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      t.[7] <- x86_VPBLENDD_256 t.[5] t.[6]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (1 %% 2^1 +
                             2^1 * (1 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      state.[4] <- x86_VPBLENDD_256 state.[4] t.[5]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (1 %% 2^1 +
                                         2^1 * (1 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      t.[7] <- x86_VPBLENDD_256 t.[7] t.[2]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (1 %% 2^1 +
                                         2^1 * (1 %% 2^1 +
                                               2^1 * (0 %% 2^1 + 2^1 * 0))))))));
      state.[4] <- x86_VPBLENDD_256 state.[4] t.[2]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (1 %% 2^1 + 2^1 * 1))))))));
      t.[7] <- x86_VPBLENDD_256 t.[7] t.[3]
      (W8.of_int (0 %% 2^1 +
                 2^1 * (0 %% 2^1 +
                       2^1 * (0 %% 2^1 +
                             2^1 * (0 %% 2^1 +
                                   2^1 * (0 %% 2^1 +
                                         2^1 * (0 %% 2^1 +
                                               2^1 * (1 %% 2^1 + 2^1 * 1))))))));
      state.[4] <- ((invw state.[4]) `&` t.[7]);
      state.[0] <- (state.[0] `^` t.[0]);
      state.[1] <- (state.[1] `^` t.[1]);
      state.[4] <- (state.[4] `^` t.[4]);
      state.[0] <-
      (state.[0] `^` (loadW256 Glob.mem (W64.to_uint (iotas + (W64.of_int ((0 * 32) - 0))))));
      iotas <- (iotas + (W64.of_int 32));
      ( _0,  _1,  _2, zf, r) <- x86_DEC_32 r;
    }
    return (state);
  }
}.


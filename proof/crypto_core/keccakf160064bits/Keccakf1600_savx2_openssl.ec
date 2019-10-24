require import List Int IntExtra IntDiv CoreMap.
from Jasmin require import JModel.

require import Array9.
require import WArray288.



module M = {
  proc __keccakf1600_avx2_openssl (a00:W256.t, a01:W256.t, a20:W256.t,
                                   a31:W256.t, a21:W256.t, a41:W256.t,
                                   a11:W256.t, _rhotates_left:W64.t,
                                   _rhotates_right:W64.t, _iotas:W64.t) : 
  W256.t * W256.t * W256.t * W256.t * W256.t * W256.t * W256.t = {
    
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
    rhotates_left <- (_rhotates_left + (W64.of_int 96));
    rhotates_right <- (_rhotates_right + (W64.of_int 96));
    iotas <- _iotas;
    i <- (W32.of_int 24);
    c00 <- x86_VPSHUFD_256 a20 (W8.of_int 78);
    c14 <- (a41 `^` a31);
    t.[2] <- (a21 `^` a11);
    c14 <- (c14 `^` a01);
    c14 <- (c14 `^` t.[2]);
    t.[4] <- x86_VPERMQ c14 (W8.of_int 147);
    c00 <- (c00 `^` a20);
    t.[0] <- x86_VPERMQ c00 (W8.of_int 78);
    t.[1] <- (c14 \vshr64u256 (W8.of_int 63));
    t.[2] <- (c14 \vadd64u256 c14);
    t.[1] <- (t.[1] `|` t.[2]);
    d14 <- x86_VPERMQ t.[1] (W8.of_int 57);
    d00 <- (t.[1] `^` t.[4]);
    d00 <- x86_VPERMQ d00 (W8.of_int 0);
    c00 <- (c00 `^` a00);
    c00 <- (c00 `^` t.[0]);
    t.[0] <- (c00 \vshr64u256 (W8.of_int 63));
    t.[1] <- (c00 \vadd64u256 c00);
    t.[1] <- (t.[1] `|` t.[0]);
    a20 <- (a20 `^` d00);
    a00 <- (a00 `^` d00);
    d14 <- x86_VPBLENDD_256 d14 t.[1]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
    t.[4] <- x86_VPBLENDD_256 t.[4] c00
    (W8.of_int (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
    d14 <- (d14 `^` t.[4]);
    t.[3] <- x86_VPSLLV_4u64 a20
    (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((0 * 32) - 96)))));
    a20 <- x86_VPSRLV_4u64 a20
    (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((0 * 32) - 96)))));
    a20 <- (a20 `|` t.[3]);
    a31 <- (a31 `^` d14);
    t.[4] <- x86_VPSLLV_4u64 a31
    (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((2 * 32) - 96)))));
    a31 <- x86_VPSRLV_4u64 a31
    (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((2 * 32) - 96)))));
    a31 <- (a31 `|` t.[4]);
    a21 <- (a21 `^` d14);
    t.[5] <- x86_VPSLLV_4u64 a21
    (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((3 * 32) - 96)))));
    a21 <- x86_VPSRLV_4u64 a21
    (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((3 * 32) - 96)))));
    a21 <- (a21 `|` t.[5]);
    a41 <- (a41 `^` d14);
    t.[6] <- x86_VPSLLV_4u64 a41
    (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((4 * 32) - 96)))));
    a41 <- x86_VPSRLV_4u64 a41
    (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((4 * 32) - 96)))));
    a41 <- (a41 `|` t.[6]);
    a11 <- (a11 `^` d14);
    t.[3] <- x86_VPERMQ a20 (W8.of_int 141);
    t.[4] <- x86_VPERMQ a31 (W8.of_int 141);
    t.[7] <- x86_VPSLLV_4u64 a11
    (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((5 * 32) - 96)))));
    t.[1] <- x86_VPSRLV_4u64 a11
    (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((5 * 32) - 96)))));
    t.[1] <- (t.[1] `|` t.[7]);
    a01 <- (a01 `^` d14);
    t.[5] <- x86_VPERMQ a21 (W8.of_int 27);
    t.[6] <- x86_VPERMQ a41 (W8.of_int 114);
    t.[8] <- x86_VPSLLV_4u64 a01
    (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((1 * 32) - 96)))));
    t.[2] <- x86_VPSRLV_4u64 a01
    (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((1 * 32) - 96)))));
    t.[2] <- (t.[2] `|` t.[8]);
    t.[7] <- x86_VPSRLDQ_256 t.[1] (W8.of_int 8);
    t.[0] <- ((invw t.[1]) `&` t.[7]);
    a31 <- x86_VPBLENDD_256 t.[2] t.[6]
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
    t.[8] <- x86_VPBLENDD_256 t.[4] t.[2]
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
    a41 <- x86_VPBLENDD_256 t.[3] t.[4]
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
    t.[7] <- x86_VPBLENDD_256 t.[2] t.[3]
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
    a31 <- x86_VPBLENDD_256 a31 t.[4]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    t.[8] <- x86_VPBLENDD_256 t.[8] t.[5]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    a41 <- x86_VPBLENDD_256 a41 t.[2]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    t.[7] <- x86_VPBLENDD_256 t.[7] t.[6]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    a31 <- x86_VPBLENDD_256 a31 t.[5]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
    t.[8] <- x86_VPBLENDD_256 t.[8] t.[6]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
    a41 <- x86_VPBLENDD_256 a41 t.[6]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
    t.[7] <- x86_VPBLENDD_256 t.[7] t.[4]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
    a31 <- x86_VPANDN_256 a31 t.[8];
    a41 <- x86_VPANDN_256 a41 t.[7];
    a11 <- x86_VPBLENDD_256 t.[5] t.[2]
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
    t.[8] <- x86_VPBLENDD_256 t.[3] t.[5]
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
    a31 <- (a31 `^` t.[3]);
    a11 <- x86_VPBLENDD_256 a11 t.[3]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    t.[8] <- x86_VPBLENDD_256 t.[8] t.[4]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    a41 <- (a41 `^` t.[5]);
    a11 <- x86_VPBLENDD_256 a11 t.[4]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
    t.[8] <- x86_VPBLENDD_256 t.[8] t.[2]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
    a11 <- x86_VPANDN_256 a11 t.[8];
    a11 <- (a11 `^` t.[6]);
    a21 <- x86_VPERMQ t.[1] (W8.of_int 30);
    t.[8] <- x86_VPBLENDD_256 a21 a00
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    a01 <- x86_VPERMQ t.[1] (W8.of_int 57);
    a01 <- x86_VPBLENDD_256 a01 a00
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
    a01 <- x86_VPANDN_256 a01 t.[8];
    a20 <- x86_VPBLENDD_256 t.[4] t.[5]
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
    t.[7] <- x86_VPBLENDD_256 t.[6] t.[4]
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
    a20 <- x86_VPBLENDD_256 a20 t.[6]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    t.[7] <- x86_VPBLENDD_256 t.[7] t.[3]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    a20 <- x86_VPBLENDD_256 a20 t.[3]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
    t.[7] <- x86_VPBLENDD_256 t.[7] t.[5]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
    a20 <- x86_VPANDN_256 a20 t.[7];
    a20 <- (a20 `^` t.[2]);
    t.[0] <- x86_VPERMQ t.[0] (W8.of_int 0);
    a31 <- x86_VPERMQ a31 (W8.of_int 27);
    a41 <- x86_VPERMQ a41 (W8.of_int 141);
    a11 <- x86_VPERMQ a11 (W8.of_int 114);
    a21 <- x86_VPBLENDD_256 t.[6] t.[3]
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
    t.[7] <- x86_VPBLENDD_256 t.[5] t.[6]
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
    a21 <- x86_VPBLENDD_256 a21 t.[5]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    t.[7] <- x86_VPBLENDD_256 t.[7] t.[2]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    a21 <- x86_VPBLENDD_256 a21 t.[2]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
    t.[7] <- x86_VPBLENDD_256 t.[7] t.[3]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
    a21 <- x86_VPANDN_256 a21 t.[7];
    a00 <- (a00 `^` t.[0]);
    a01 <- (a01 `^` t.[1]);
    a21 <- (a21 `^` t.[4]);
    a00 <-
    (a00 `^` (loadW256 Glob.mem (W64.to_uint (iotas + (W64.of_int 0)))));
    iotas <- (iotas + (W64.of_int 32));
    ( _0,  _1,  _2, zf, i) <- x86_DEC_32 i;
    while ((! zf)) {
      c00 <- x86_VPSHUFD_256 a20 (W8.of_int 78);
      c14 <- (a41 `^` a31);
      t.[2] <- (a21 `^` a11);
      c14 <- (c14 `^` a01);
      c14 <- (c14 `^` t.[2]);
      t.[4] <- x86_VPERMQ c14 (W8.of_int 147);
      c00 <- (c00 `^` a20);
      t.[0] <- x86_VPERMQ c00 (W8.of_int 78);
      t.[1] <- (c14 \vshr64u256 (W8.of_int 63));
      t.[2] <- (c14 \vadd64u256 c14);
      t.[1] <- (t.[1] `|` t.[2]);
      d14 <- x86_VPERMQ t.[1] (W8.of_int 57);
      d00 <- (t.[1] `^` t.[4]);
      d00 <- x86_VPERMQ d00 (W8.of_int 0);
      c00 <- (c00 `^` a00);
      c00 <- (c00 `^` t.[0]);
      t.[0] <- (c00 \vshr64u256 (W8.of_int 63));
      t.[1] <- (c00 \vadd64u256 c00);
      t.[1] <- (t.[1] `|` t.[0]);
      a20 <- (a20 `^` d00);
      a00 <- (a00 `^` d00);
      d14 <- x86_VPBLENDD_256 d14 t.[1]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
      t.[4] <- x86_VPBLENDD_256 t.[4] c00
      (W8.of_int (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
      d14 <- (d14 `^` t.[4]);
      t.[3] <- x86_VPSLLV_4u64 a20
      (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((0 * 32) - 96)))));
      a20 <- x86_VPSRLV_4u64 a20
      (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((0 * 32) - 96)))));
      a20 <- (a20 `|` t.[3]);
      a31 <- (a31 `^` d14);
      t.[4] <- x86_VPSLLV_4u64 a31
      (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((2 * 32) - 96)))));
      a31 <- x86_VPSRLV_4u64 a31
      (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((2 * 32) - 96)))));
      a31 <- (a31 `|` t.[4]);
      a21 <- (a21 `^` d14);
      t.[5] <- x86_VPSLLV_4u64 a21
      (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((3 * 32) - 96)))));
      a21 <- x86_VPSRLV_4u64 a21
      (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((3 * 32) - 96)))));
      a21 <- (a21 `|` t.[5]);
      a41 <- (a41 `^` d14);
      t.[6] <- x86_VPSLLV_4u64 a41
      (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((4 * 32) - 96)))));
      a41 <- x86_VPSRLV_4u64 a41
      (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((4 * 32) - 96)))));
      a41 <- (a41 `|` t.[6]);
      a11 <- (a11 `^` d14);
      t.[3] <- x86_VPERMQ a20 (W8.of_int 141);
      t.[4] <- x86_VPERMQ a31 (W8.of_int 141);
      t.[7] <- x86_VPSLLV_4u64 a11
      (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((5 * 32) - 96)))));
      t.[1] <- x86_VPSRLV_4u64 a11
      (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((5 * 32) - 96)))));
      t.[1] <- (t.[1] `|` t.[7]);
      a01 <- (a01 `^` d14);
      t.[5] <- x86_VPERMQ a21 (W8.of_int 27);
      t.[6] <- x86_VPERMQ a41 (W8.of_int 114);
      t.[8] <- x86_VPSLLV_4u64 a01
      (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((1 * 32) - 96)))));
      t.[2] <- x86_VPSRLV_4u64 a01
      (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((1 * 32) - 96)))));
      t.[2] <- (t.[2] `|` t.[8]);
      t.[7] <- x86_VPSRLDQ_256 t.[1] (W8.of_int 8);
      t.[0] <- ((invw t.[1]) `&` t.[7]);
      a31 <- x86_VPBLENDD_256 t.[2] t.[6]
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
      t.[8] <- x86_VPBLENDD_256 t.[4] t.[2]
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
      a41 <- x86_VPBLENDD_256 t.[3] t.[4]
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
      t.[7] <- x86_VPBLENDD_256 t.[2] t.[3]
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
      a31 <- x86_VPBLENDD_256 a31 t.[4]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
      t.[8] <- x86_VPBLENDD_256 t.[8] t.[5]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
      a41 <- x86_VPBLENDD_256 a41 t.[2]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
      t.[7] <- x86_VPBLENDD_256 t.[7] t.[6]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
      a31 <- x86_VPBLENDD_256 a31 t.[5]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
      t.[8] <- x86_VPBLENDD_256 t.[8] t.[6]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
      a41 <- x86_VPBLENDD_256 a41 t.[6]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
      t.[7] <- x86_VPBLENDD_256 t.[7] t.[4]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
      a31 <- x86_VPANDN_256 a31 t.[8];
      a41 <- x86_VPANDN_256 a41 t.[7];
      a11 <- x86_VPBLENDD_256 t.[5] t.[2]
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
      t.[8] <- x86_VPBLENDD_256 t.[3] t.[5]
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
      a31 <- (a31 `^` t.[3]);
      a11 <- x86_VPBLENDD_256 a11 t.[3]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
      t.[8] <- x86_VPBLENDD_256 t.[8] t.[4]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
      a41 <- (a41 `^` t.[5]);
      a11 <- x86_VPBLENDD_256 a11 t.[4]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
      t.[8] <- x86_VPBLENDD_256 t.[8] t.[2]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
      a11 <- x86_VPANDN_256 a11 t.[8];
      a11 <- (a11 `^` t.[6]);
      a21 <- x86_VPERMQ t.[1] (W8.of_int 30);
      t.[8] <- x86_VPBLENDD_256 a21 a00
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
      a01 <- x86_VPERMQ t.[1] (W8.of_int 57);
      a01 <- x86_VPBLENDD_256 a01 a00
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
      a01 <- x86_VPANDN_256 a01 t.[8];
      a20 <- x86_VPBLENDD_256 t.[4] t.[5]
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
      t.[7] <- x86_VPBLENDD_256 t.[6] t.[4]
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
      a20 <- x86_VPBLENDD_256 a20 t.[6]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
      t.[7] <- x86_VPBLENDD_256 t.[7] t.[3]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
      a20 <- x86_VPBLENDD_256 a20 t.[3]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
      t.[7] <- x86_VPBLENDD_256 t.[7] t.[5]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
      a20 <- x86_VPANDN_256 a20 t.[7];
      a20 <- (a20 `^` t.[2]);
      t.[0] <- x86_VPERMQ t.[0] (W8.of_int 0);
      a31 <- x86_VPERMQ a31 (W8.of_int 27);
      a41 <- x86_VPERMQ a41 (W8.of_int 141);
      a11 <- x86_VPERMQ a11 (W8.of_int 114);
      a21 <- x86_VPBLENDD_256 t.[6] t.[3]
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
      t.[7] <- x86_VPBLENDD_256 t.[5] t.[6]
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
      a21 <- x86_VPBLENDD_256 a21 t.[5]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
      t.[7] <- x86_VPBLENDD_256 t.[7] t.[2]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
      a21 <- x86_VPBLENDD_256 a21 t.[2]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
      t.[7] <- x86_VPBLENDD_256 t.[7] t.[3]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
      a21 <- x86_VPANDN_256 a21 t.[7];
      a00 <- (a00 `^` t.[0]);
      a01 <- (a01 `^` t.[1]);
      a21 <- (a21 `^` t.[4]);
      a00 <-
      (a00 `^` (loadW256 Glob.mem (W64.to_uint (iotas + (W64.of_int 0)))));
      iotas <- (iotas + (W64.of_int 32));
      ( _0,  _1,  _2, zf, i) <- x86_DEC_32 i;
    }
    return (a00, a01, a20, a31, a21, a41, a11);
  }
}.


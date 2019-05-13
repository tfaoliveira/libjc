require import List Int IntExtra IntDiv CoreMap.
from Jasmin require import JModel.

require import Array9.
require import WArray288.



module M = {
  proc __keccak_f1600_avx2_openssl (A00:W256.t, A01:W256.t, A20:W256.t,
                                    A31:W256.t, A21:W256.t, A41:W256.t,
                                    A11:W256.t, _rhotates_left:W64.t,
                                    _rhotates_right:W64.t, _iotas:W64.t) : 
  W256.t * W256.t * W256.t * W256.t * W256.t * W256.t * W256.t = {
    
    var rhotates_left:W64.t;
    var rhotates_right:W64.t;
    var iotas:W64.t;
    var i:W32.t;
    var zf:bool;
    var C00:W256.t;
    var C14:W256.t;
    var T:W256.t Array9.t;
    var D14:W256.t;
    var D00:W256.t;
    var  _0:bool;
    var  _1:bool;
    var  _2:bool;
    T <- witness;
    rhotates_left <- (_rhotates_left + (W64.of_int 96));
    rhotates_right <- (_rhotates_right + (W64.of_int 96));
    iotas <- _iotas;
    i <- (W32.of_int 24);
    C00 <- x86_VPSHUFD_256 A20 (W8.of_int 78);
    C14 <- (A41 `^` A31);
    T.[2] <- (A21 `^` A11);
    C14 <- (C14 `^` A01);
    C14 <- (C14 `^` T.[2]);
    T.[4] <- x86_VPERMQ C14 (W8.of_int 147);
    C00 <- (C00 `^` A20);
    T.[0] <- x86_VPERMQ C00 (W8.of_int 78);
    T.[1] <- (C14 \vshr64u256 (W8.of_int 63));
    T.[2] <- (C14 \vadd64u256 C14);
    T.[1] <- (T.[1] `|` T.[2]);
    D14 <- x86_VPERMQ T.[1] (W8.of_int 57);
    D00 <- (T.[1] `^` T.[4]);
    D00 <- x86_VPERMQ D00 (W8.of_int 0);
    C00 <- (C00 `^` A00);
    C00 <- (C00 `^` T.[0]);
    T.[0] <- (C00 \vshr64u256 (W8.of_int 63));
    T.[1] <- (C00 \vadd64u256 C00);
    T.[1] <- (T.[1] `|` T.[0]);
    A20 <- (A20 `^` D00);
    A00 <- (A00 `^` D00);
    D14 <- x86_VPBLENDD_256 D14 T.[1]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
    T.[4] <- x86_VPBLENDD_256 T.[4] C00
    (W8.of_int (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
    D14 <- (D14 `^` T.[4]);
    T.[3] <- x86_VPSLLV_4u64 A20
    (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((0 * 32) - 96)))));
    A20 <- x86_VPSRLV_4u64 A20
    (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((0 * 32) - 96)))));
    A20 <- (A20 `|` T.[3]);
    A31 <- (A31 `^` D14);
    T.[4] <- x86_VPSLLV_4u64 A31
    (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((2 * 32) - 96)))));
    A31 <- x86_VPSRLV_4u64 A31
    (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((2 * 32) - 96)))));
    A31 <- (A31 `|` T.[4]);
    A21 <- (A21 `^` D14);
    T.[5] <- x86_VPSLLV_4u64 A21
    (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((3 * 32) - 96)))));
    A21 <- x86_VPSRLV_4u64 A21
    (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((3 * 32) - 96)))));
    A21 <- (A21 `|` T.[5]);
    A41 <- (A41 `^` D14);
    T.[6] <- x86_VPSLLV_4u64 A41
    (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((4 * 32) - 96)))));
    A41 <- x86_VPSRLV_4u64 A41
    (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((4 * 32) - 96)))));
    A41 <- (A41 `|` T.[6]);
    A11 <- (A11 `^` D14);
    T.[3] <- x86_VPERMQ A20 (W8.of_int 141);
    T.[4] <- x86_VPERMQ A31 (W8.of_int 141);
    T.[7] <- x86_VPSLLV_4u64 A11
    (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((5 * 32) - 96)))));
    T.[1] <- x86_VPSRLV_4u64 A11
    (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((5 * 32) - 96)))));
    T.[1] <- (T.[1] `|` T.[7]);
    A01 <- (A01 `^` D14);
    T.[5] <- x86_VPERMQ A21 (W8.of_int 27);
    T.[6] <- x86_VPERMQ A41 (W8.of_int 114);
    T.[8] <- x86_VPSLLV_4u64 A01
    (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((1 * 32) - 96)))));
    T.[2] <- x86_VPSRLV_4u64 A01
    (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((1 * 32) - 96)))));
    T.[2] <- (T.[2] `|` T.[8]);
    T.[7] <- x86_VPSRLDQ_256 T.[1] (W8.of_int 8);
    T.[0] <- ((invw T.[1]) `&` T.[7]);
    A31 <- x86_VPBLENDD_256 T.[2] T.[6]
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
    T.[8] <- x86_VPBLENDD_256 T.[4] T.[2]
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
    A41 <- x86_VPBLENDD_256 T.[3] T.[4]
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
    T.[7] <- x86_VPBLENDD_256 T.[2] T.[3]
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
    A31 <- x86_VPBLENDD_256 A31 T.[4]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    T.[8] <- x86_VPBLENDD_256 T.[8] T.[5]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    A41 <- x86_VPBLENDD_256 A41 T.[2]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    T.[7] <- x86_VPBLENDD_256 T.[7] T.[6]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    A31 <- x86_VPBLENDD_256 A31 T.[5]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
    T.[8] <- x86_VPBLENDD_256 T.[8] T.[6]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
    A41 <- x86_VPBLENDD_256 A41 T.[6]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
    T.[7] <- x86_VPBLENDD_256 T.[7] T.[4]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
    A31 <- x86_VPANDN_256 A31 T.[8];
    A41 <- x86_VPANDN_256 A41 T.[7];
    A11 <- x86_VPBLENDD_256 T.[5] T.[2]
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
    T.[8] <- x86_VPBLENDD_256 T.[3] T.[5]
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
    A31 <- (A31 `^` T.[3]);
    A11 <- x86_VPBLENDD_256 A11 T.[3]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    T.[8] <- x86_VPBLENDD_256 T.[8] T.[4]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    A41 <- (A41 `^` T.[5]);
    A11 <- x86_VPBLENDD_256 A11 T.[4]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
    T.[8] <- x86_VPBLENDD_256 T.[8] T.[2]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
    A11 <- x86_VPANDN_256 A11 T.[8];
    A11 <- (A11 `^` T.[6]);
    A21 <- x86_VPERMQ T.[1] (W8.of_int 30);
    T.[8] <- x86_VPBLENDD_256 A21 A00
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    A01 <- x86_VPERMQ T.[1] (W8.of_int 57);
    A01 <- x86_VPBLENDD_256 A01 A00
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
    A01 <- x86_VPANDN_256 A01 T.[8];
    A20 <- x86_VPBLENDD_256 T.[4] T.[5]
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
    T.[7] <- x86_VPBLENDD_256 T.[6] T.[4]
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
    A20 <- x86_VPBLENDD_256 A20 T.[6]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    T.[7] <- x86_VPBLENDD_256 T.[7] T.[3]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    A20 <- x86_VPBLENDD_256 A20 T.[3]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
    T.[7] <- x86_VPBLENDD_256 T.[7] T.[5]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
    A20 <- x86_VPANDN_256 A20 T.[7];
    A20 <- (A20 `^` T.[2]);
    T.[0] <- x86_VPERMQ T.[0] (W8.of_int 0);
    A31 <- x86_VPERMQ A31 (W8.of_int 27);
    A41 <- x86_VPERMQ A41 (W8.of_int 141);
    A11 <- x86_VPERMQ A11 (W8.of_int 114);
    A21 <- x86_VPBLENDD_256 T.[6] T.[3]
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
    T.[7] <- x86_VPBLENDD_256 T.[5] T.[6]
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
    A21 <- x86_VPBLENDD_256 A21 T.[5]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    T.[7] <- x86_VPBLENDD_256 T.[7] T.[2]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
    A21 <- x86_VPBLENDD_256 A21 T.[2]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
    T.[7] <- x86_VPBLENDD_256 T.[7] T.[3]
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
    A21 <- x86_VPANDN_256 A21 T.[7];
    A00 <- (A00 `^` T.[0]);
    A01 <- (A01 `^` T.[1]);
    A21 <- (A21 `^` T.[4]);
    A00 <-
    (A00 `^` (loadW256 Glob.mem (W64.to_uint (iotas + (W64.of_int 0)))));
    iotas <- (iotas + (W64.of_int 32));
    ( _0,  _1,  _2, zf, i) <- x86_DEC_32 i;
    while ((! zf)) {
      C00 <- x86_VPSHUFD_256 A20 (W8.of_int 78);
      C14 <- (A41 `^` A31);
      T.[2] <- (A21 `^` A11);
      C14 <- (C14 `^` A01);
      C14 <- (C14 `^` T.[2]);
      T.[4] <- x86_VPERMQ C14 (W8.of_int 147);
      C00 <- (C00 `^` A20);
      T.[0] <- x86_VPERMQ C00 (W8.of_int 78);
      T.[1] <- (C14 \vshr64u256 (W8.of_int 63));
      T.[2] <- (C14 \vadd64u256 C14);
      T.[1] <- (T.[1] `|` T.[2]);
      D14 <- x86_VPERMQ T.[1] (W8.of_int 57);
      D00 <- (T.[1] `^` T.[4]);
      D00 <- x86_VPERMQ D00 (W8.of_int 0);
      C00 <- (C00 `^` A00);
      C00 <- (C00 `^` T.[0]);
      T.[0] <- (C00 \vshr64u256 (W8.of_int 63));
      T.[1] <- (C00 \vadd64u256 C00);
      T.[1] <- (T.[1] `|` T.[0]);
      A20 <- (A20 `^` D00);
      A00 <- (A00 `^` D00);
      D14 <- x86_VPBLENDD_256 D14 T.[1]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
      T.[4] <- x86_VPBLENDD_256 T.[4] C00
      (W8.of_int (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
      D14 <- (D14 `^` T.[4]);
      T.[3] <- x86_VPSLLV_4u64 A20
      (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((0 * 32) - 96)))));
      A20 <- x86_VPSRLV_4u64 A20
      (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((0 * 32) - 96)))));
      A20 <- (A20 `|` T.[3]);
      A31 <- (A31 `^` D14);
      T.[4] <- x86_VPSLLV_4u64 A31
      (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((2 * 32) - 96)))));
      A31 <- x86_VPSRLV_4u64 A31
      (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((2 * 32) - 96)))));
      A31 <- (A31 `|` T.[4]);
      A21 <- (A21 `^` D14);
      T.[5] <- x86_VPSLLV_4u64 A21
      (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((3 * 32) - 96)))));
      A21 <- x86_VPSRLV_4u64 A21
      (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((3 * 32) - 96)))));
      A21 <- (A21 `|` T.[5]);
      A41 <- (A41 `^` D14);
      T.[6] <- x86_VPSLLV_4u64 A41
      (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((4 * 32) - 96)))));
      A41 <- x86_VPSRLV_4u64 A41
      (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((4 * 32) - 96)))));
      A41 <- (A41 `|` T.[6]);
      A11 <- (A11 `^` D14);
      T.[3] <- x86_VPERMQ A20 (W8.of_int 141);
      T.[4] <- x86_VPERMQ A31 (W8.of_int 141);
      T.[7] <- x86_VPSLLV_4u64 A11
      (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((5 * 32) - 96)))));
      T.[1] <- x86_VPSRLV_4u64 A11
      (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((5 * 32) - 96)))));
      T.[1] <- (T.[1] `|` T.[7]);
      A01 <- (A01 `^` D14);
      T.[5] <- x86_VPERMQ A21 (W8.of_int 27);
      T.[6] <- x86_VPERMQ A41 (W8.of_int 114);
      T.[8] <- x86_VPSLLV_4u64 A01
      (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((1 * 32) - 96)))));
      T.[2] <- x86_VPSRLV_4u64 A01
      (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((1 * 32) - 96)))));
      T.[2] <- (T.[2] `|` T.[8]);
      T.[7] <- x86_VPSRLDQ_256 T.[1] (W8.of_int 8);
      T.[0] <- ((invw T.[1]) `&` T.[7]);
      A31 <- x86_VPBLENDD_256 T.[2] T.[6]
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
      T.[8] <- x86_VPBLENDD_256 T.[4] T.[2]
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
      A41 <- x86_VPBLENDD_256 T.[3] T.[4]
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
      T.[7] <- x86_VPBLENDD_256 T.[2] T.[3]
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
      A31 <- x86_VPBLENDD_256 A31 T.[4]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
      T.[8] <- x86_VPBLENDD_256 T.[8] T.[5]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
      A41 <- x86_VPBLENDD_256 A41 T.[2]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
      T.[7] <- x86_VPBLENDD_256 T.[7] T.[6]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
      A31 <- x86_VPBLENDD_256 A31 T.[5]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
      T.[8] <- x86_VPBLENDD_256 T.[8] T.[6]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
      A41 <- x86_VPBLENDD_256 A41 T.[6]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
      T.[7] <- x86_VPBLENDD_256 T.[7] T.[4]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
      A31 <- x86_VPANDN_256 A31 T.[8];
      A41 <- x86_VPANDN_256 A41 T.[7];
      A11 <- x86_VPBLENDD_256 T.[5] T.[2]
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
      T.[8] <- x86_VPBLENDD_256 T.[3] T.[5]
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
      A31 <- (A31 `^` T.[3]);
      A11 <- x86_VPBLENDD_256 A11 T.[3]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
      T.[8] <- x86_VPBLENDD_256 T.[8] T.[4]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
      A41 <- (A41 `^` T.[5]);
      A11 <- x86_VPBLENDD_256 A11 T.[4]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
      T.[8] <- x86_VPBLENDD_256 T.[8] T.[2]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
      A11 <- x86_VPANDN_256 A11 T.[8];
      A11 <- (A11 `^` T.[6]);
      A21 <- x86_VPERMQ T.[1] (W8.of_int 30);
      T.[8] <- x86_VPBLENDD_256 A21 A00
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
      A01 <- x86_VPERMQ T.[1] (W8.of_int 57);
      A01 <- x86_VPBLENDD_256 A01 A00
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
      A01 <- x86_VPANDN_256 A01 T.[8];
      A20 <- x86_VPBLENDD_256 T.[4] T.[5]
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
      T.[7] <- x86_VPBLENDD_256 T.[6] T.[4]
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
      A20 <- x86_VPBLENDD_256 A20 T.[6]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
      T.[7] <- x86_VPBLENDD_256 T.[7] T.[3]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
      A20 <- x86_VPBLENDD_256 A20 T.[3]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
      T.[7] <- x86_VPBLENDD_256 T.[7] T.[5]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
      A20 <- x86_VPANDN_256 A20 T.[7];
      A20 <- (A20 `^` T.[2]);
      T.[0] <- x86_VPERMQ T.[0] (W8.of_int 0);
      A31 <- x86_VPERMQ A31 (W8.of_int 27);
      A41 <- x86_VPERMQ A41 (W8.of_int 141);
      A11 <- x86_VPERMQ A11 (W8.of_int 114);
      A21 <- x86_VPBLENDD_256 T.[6] T.[3]
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
      T.[7] <- x86_VPBLENDD_256 T.[5] T.[6]
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0))));
      A21 <- x86_VPBLENDD_256 A21 T.[5]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
      T.[7] <- x86_VPBLENDD_256 T.[7] T.[2]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0))));
      A21 <- x86_VPBLENDD_256 A21 T.[2]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
      T.[7] <- x86_VPBLENDD_256 T.[7] T.[3]
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3))));
      A21 <- x86_VPANDN_256 A21 T.[7];
      A00 <- (A00 `^` T.[0]);
      A01 <- (A01 `^` T.[1]);
      A21 <- (A21 `^` T.[4]);
      A00 <-
      (A00 `^` (loadW256 Glob.mem (W64.to_uint (iotas + (W64.of_int 0)))));
      iotas <- (iotas + (W64.of_int 32));
      ( _0,  _1,  _2, zf, i) <- x86_DEC_32 i;
    }
    return (A00, A01, A20, A31, A21, A41, A11);
  }
}.


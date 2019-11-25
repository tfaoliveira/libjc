require import List Int IntExtra IntDiv CoreMap.
from Jasmin require import JModel.

require import Array4p Array9 Array24 Array25.
require import WArray288.
require import Keccakf1600_pref_op.
require import Ops.

module Mavx2_prevec_vops = {

  proc __keccakf1600_avx2_openssl (
           a00:W256.t, a01:W256.t, a20:W256.t, a31:W256.t,
           a21:W256.t, a41:W256.t, a11:W256.t,
           _rhotates_left:W64.t, _rhotates_right:W64.t, _iotas:W64.t) :
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
    c00 <@ OpsV.iVPSHUFD_256(a20,(W8.of_int 78));
    c14 <@ OpsV.ilxor4u64(a41,a31);
    t.[2] <@ OpsV.ilxor4u64(a21,a11);
    c14 <@ OpsV.ilxor4u64(c14,a01);
    c14 <@ OpsV.ilxor4u64(c14,t.[2]);
    t.[4] <- OpsV.iVPERMQ(c14,(W8.of_int 147));
    c00 <@ OpsV.ilxor4u64(c00,a20);
    t.[0] <- OpsV.iVPERMQ(c00,(W8.of_int 78));
    t.[1] <- OpsV.ivshr64u256(c14, (W8.of_int 63));
    t.[2] <- OpsV.ivadd64u256(c14, c14);
    t.[1] <@ OpsV.ilor4u64(t.[1],t.[2]);
    d14 <- OpsV.iVPERMQ(t.[1],(W8.of_int 57));
    d00 <@ OpsV.ilxor4u64(t.[1],t.[4]);
    d00 <- OpsV.iVPERMQ(d00,(W8.of_int 0));
    c00 <@ OpsV.ilxor4u64(c00,a00);
    c00 <@ OpsV.ilxor4u64(c00,t.[0]);
    t.[0] <- OpsV.ivshr64u256(c00, (W8.of_int 63));
    t.[1] <- OpsV.ivadd64u256(c00, c00);
    t.[1] <@ OpsV.ilor4u64(t.[1],t.[0]);
    a20 <@ OpsV.ilxor4u64(a20,d00);
    a00 <@ OpsV.ilxor4u64(a00,d00);
    d14 <- OpsV.iVPBLENDD_256(d14,t.[1],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
    t.[4] <- OpsV.iVPBLENDD_256(t.[4],c00,
    (W8.of_int (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
    d14 <@ OpsV.ilxor4u64(d14,t.[4]);
    t.[3] <@ OpsV.iVPSLLV_4u64(a20, 
          (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((0 * 32) - 96))))));
    a20 <@ OpsV.iVPSRLV_4u64(a20, 
          (loadW256 Glob.mem (W64.to_uint (rhotates_right+ (W64.of_int ((0 * 32) - 96))))));
    a20 <@ OpsV.ilor4u64(a20,t.[3]);
    a31 <@ OpsV.ilxor4u64(a31,d14);
    t.[4] <@ OpsV.iVPSLLV_4u64(a31, 
          (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((2 * 32) - 96))))));
    a31 <@ OpsV.iVPSRLV_4u64(a31, 
          (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((2 * 32) - 96))))));
    a31 <@ OpsV.ilor4u64(a31,t.[4]);
    a21 <@ OpsV.ilxor4u64(a21,d14);
    t.[5] <@ OpsV.iVPSLLV_4u64(a21, 
          (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((3 * 32) - 96))))));
    a21 <@ OpsV.iVPSRLV_4u64(a21, 
          (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((3 * 32) - 96))))));
    a21 <@ OpsV.ilor4u64(a21,t.[5]);
    a41 <@ OpsV.ilxor4u64(a41,d14);
    t.[6] <@ OpsV.iVPSLLV_4u64(a41, 
          (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((4 * 32) - 96))))));
    a41 <@ OpsV.iVPSRLV_4u64(a41, 
          (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((4 * 32) - 96))))));
    a41 <@ OpsV.ilor4u64(a41,t.[6]);
    a11 <@ OpsV.ilxor4u64(a11,d14);
    t.[3] <- OpsV.iVPERMQ(a20,(W8.of_int 141));
    t.[4] <- OpsV.iVPERMQ(a31,(W8.of_int 141));
    t.[7] <@ OpsV.iVPSLLV_4u64(a11, 
          (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((5 * 32) - 96))))));
    t.[1] <@ OpsV.iVPSRLV_4u64(a11, 
          (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((5 * 32) - 96))))));
    t.[1] <@ OpsV.ilor4u64(t.[1],t.[7]);
    a01 <@ OpsV.ilxor4u64(a01,d14);
    t.[5] <- OpsV.iVPERMQ(a21,(W8.of_int 27));
    t.[6] <- OpsV.iVPERMQ(a41,(W8.of_int 114));
    t.[8] <@ OpsV.iVPSLLV_4u64(a01, 
          (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((1 * 32) - 96))))));
    t.[2] <@ OpsV.iVPSRLV_4u64(a01, 
          (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((1 * 32) - 96))))));
    t.[2] <@ OpsV.ilor4u64(t.[2],t.[8]);
    t.[7] <@ OpsV.iVPSRLDQ_256(t.[1],(W8.of_int 8));
    t.[0] <@ OpsV.ilandn4u64(t.[1],t.[7]);
    a31 <@ OpsV.iVPBLENDD_256(t.[2],t.[6],
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
    t.[8] <@ OpsV.iVPBLENDD_256(t.[4],t.[2],
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
    a41 <@ OpsV.iVPBLENDD_256(t.[3], t.[4],
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
    t.[7] <@ OpsV.iVPBLENDD_256(t.[2], t.[3],
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
    a31 <@ OpsV.iVPBLENDD_256(a31 ,t.[4],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
    t.[8] <@ OpsV.iVPBLENDD_256(t.[8], t.[5],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
    a41 <@ OpsV.iVPBLENDD_256(a41, t.[2],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
    t.[7] <@ OpsV.iVPBLENDD_256(t.[7], t.[6],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
    a31 <@ OpsV.iVPBLENDD_256(a31, t.[5],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
    t.[8] <@ OpsV.iVPBLENDD_256(t.[8], t.[6],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
    a41 <@ OpsV.iVPBLENDD_256(a41, t.[6],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
    t.[7] <@ OpsV.iVPBLENDD_256(t.[7], t.[4],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
    a31 <@ OpsV.ilandn4u64(a31,t.[8]);
    a41 <@ OpsV.ilandn4u64(a41,t.[7]);
    a11 <@ OpsV.iVPBLENDD_256(t.[5],t.[2],
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
    t.[8] <@ OpsV.iVPBLENDD_256(t.[3], t.[5],
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
    a31 <@ OpsV.ilxor4u64(a31,t.[3]);
    a11 <@ OpsV.iVPBLENDD_256(a11,t.[3],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
    t.[8] <@ OpsV.iVPBLENDD_256(t.[8],t.[4],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
    a41 <@ OpsV.ilxor4u64(a41,t.[5]);
    a11 <@ OpsV.iVPBLENDD_256(a11, t.[4],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
    t.[8] <@ OpsV.iVPBLENDD_256(t.[8], t.[2],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
    a11 <@ OpsV.ilandn4u64(a11,t.[8]);
    a11 <@ OpsV.ilxor4u64(a11,t.[6]);
    a21 <@ OpsV.iVPERMQ(t.[1],(W8.of_int 30));
    t.[8] <@ OpsV.iVPBLENDD_256(a21, a00,
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
    a01 <@ OpsV.iVPERMQ(t.[1],(W8.of_int 57));
    a01 <@ OpsV.iVPBLENDD_256(a01, a00,
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
    a01 <@ OpsV.ilandn4u64(a01,t.[8]);
    a20 <@ OpsV.iVPBLENDD_256(t.[4], t.[5],
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
    t.[7] <@ OpsV.iVPBLENDD_256(t.[6], t.[4],
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
    a20 <@ OpsV.iVPBLENDD_256(a20, t.[6],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
    t.[7] <@ OpsV.iVPBLENDD_256(t.[7], t.[3],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
    a20 <@ OpsV.iVPBLENDD_256(a20, t.[3],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
    t.[7] <@ OpsV.iVPBLENDD_256(t.[7], t.[5],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
    a20 <@ OpsV.ilandn4u64(a20,t.[7]);
    a20 <@ OpsV.ilxor4u64(a20,t.[2]);
    t.[0] <@ OpsV.iVPERMQ(t.[0],(W8.of_int 0));
    a31 <@ OpsV.iVPERMQ(a31,(W8.of_int 27));
    a41 <@ OpsV.iVPERMQ(a41,(W8.of_int 141));
    a11 <@ OpsV.iVPERMQ(a11,(W8.of_int 114));
    a21 <@ OpsV.iVPBLENDD_256(t.[6], t.[3],
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
    t.[7] <@ OpsV.iVPBLENDD_256(t.[5], t.[6],
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
    a21 <@ OpsV.iVPBLENDD_256(a21, t.[5],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
    t.[7] <@ OpsV.iVPBLENDD_256(t.[7], t.[2],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
    a21 <@ OpsV.iVPBLENDD_256(a21, t.[2],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
    t.[7] <@ OpsV.iVPBLENDD_256(t.[7], t.[3],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
    a21 <@ OpsV.ilandn4u64(a21,t.[7]);
    a00 <@ OpsV.ilxor4u64(a00,t.[0]);
    a01 <@ OpsV.ilxor4u64(a01,t.[1]);
    a21 <@ OpsV.ilxor4u64(a21,t.[4]);
    a00 <@ OpsV.ilxor4u64(a00, 
            (loadW256 Glob.mem (W64.to_uint (iotas + (W64.of_int 0)))));
    iotas <- (iotas + (W64.of_int 32));
    ( _0,  _1,  _2, zf, i) <- x86_DEC_32 i;
    while ((! zf)) {
      c00 <@ OpsV.iVPSHUFD_256(a20,(W8.of_int 78));
      c14 <@ OpsV.ilxor4u64(a41,a31);
      t.[2] <@ OpsV.ilxor4u64(a21,a11);
      c14 <@ OpsV.ilxor4u64(c14,a01);
      c14 <@ OpsV.ilxor4u64(c14,t.[2]);
      t.[4] <@ OpsV.iVPERMQ(c14,(W8.of_int 147));
      c00 <@ OpsV.ilxor4u64(c00,a20);
      t.[0] <@ OpsV.iVPERMQ(c00,(W8.of_int 78));
      t.[1] <@ OpsV.ivshr64u256(c14, (W8.of_int 63));
      t.[2] <@ OpsV.ivadd64u256(c14, c14);
      t.[1] <@ OpsV.ilor4u64(t.[1],t.[2]);
      d14 <@ OpsV.iVPERMQ(t.[1],(W8.of_int 57));
      d00 <@ OpsV.ilxor4u64(t.[1],t.[4]);
      d00 <@ OpsV.iVPERMQ(d00,(W8.of_int 0));
      c00 <@ OpsV.ilxor4u64(c00,a00);
      c00 <@ OpsV.ilxor4u64(c00,t.[0]);
      t.[0] <@ OpsV.ivshr64u256(c00, (W8.of_int 63));
      t.[1] <@ OpsV.ivadd64u256(c00, c00);
      t.[1] <@ OpsV.ilor4u64(t.[1],t.[0]);
      a20 <@ OpsV.ilxor4u64(a20,d00);
      a00 <@ OpsV.ilxor4u64(a00,d00);
      d14 <@ OpsV.iVPBLENDD_256(d14,t.[1],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
        t.[4] <@ OpsV.iVPBLENDD_256(t.[4],c00,
      (W8.of_int (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
      d14 <@ OpsV.ilxor4u64(d14,t.[4]);
      t.[3] <@ OpsV.iVPSLLV_4u64(a20, 
            (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((0 * 32) - 96))))));
      a20 <@ OpsV.iVPSRLV_4u64(a20, 
            (loadW256 Glob.mem (W64.to_uint (rhotates_right+ (W64.of_int ((0 * 32) - 96))))));
      a20 <@ OpsV.ilor4u64(a20,t.[3]);
      a31 <@ OpsV.ilxor4u64(a31,d14);
      t.[4] <@ OpsV.iVPSLLV_4u64(a31, 
            (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((2 * 32) - 96))))));
      a31 <@ OpsV.iVPSRLV_4u64(a31, 
            (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((2 * 32) - 96))))));
      a31 <@ OpsV.ilor4u64(a31,t.[4]);
      a21 <@ OpsV.ilxor4u64(a21,d14);
      t.[5] <@ OpsV.iVPSLLV_4u64(a21, 
            (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((3 * 32) - 96))))));
      a21 <@ OpsV.iVPSRLV_4u64(a21, 
            (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((3 * 32) - 96))))));
      a21 <@ OpsV.ilor4u64(a21,t.[5]);
      a41 <@ OpsV.ilxor4u64(a41,d14);
      t.[6] <@ OpsV.iVPSLLV_4u64(a41, 
            (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((4 * 32) - 96))))));
      a41 <@ OpsV.iVPSRLV_4u64(a41, 
            (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((4 * 32) - 96))))));
      a41 <@ OpsV.ilor4u64(a41,t.[6]);
      a11 <@ OpsV.ilxor4u64(a11,d14);
      t.[3] <- OpsV.iVPERMQ(a20,(W8.of_int 141));
      t.[4] <- OpsV.iVPERMQ(a31,(W8.of_int 141));
      t.[7] <@ OpsV.iVPSLLV_4u64(a11, 
            (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((5 * 32) - 96))))));
      t.[1] <@ OpsV.iVPSRLV_4u64(a11, 
            (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((5 * 32) - 96))))));
      t.[1] <@ OpsV.ilor4u64(t.[1],t.[7]);
      a01 <@ OpsV.ilxor4u64(a01,d14);
      t.[5] <- OpsV.iVPERMQ(a21,(W8.of_int 27));
      t.[6] <- OpsV.iVPERMQ(a41,(W8.of_int 114));
      t.[8] <@ OpsV.iVPSLLV_4u64(a01, 
            (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((1 * 32) - 96))))));
      t.[2] <@ OpsV.iVPSRLV_4u64(a01, 
          (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((1 * 32) - 96))))));
      t.[2] <@ OpsV.ilor4u64(t.[2],t.[8]);
      t.[7] <@ OpsV.iVPSRLDQ_256(t.[1],(W8.of_int 8));
      t.[0] <@ OpsV.ilandn4u64(t.[1],t.[7]);
      a31 <@ OpsV.iVPBLENDD_256(t.[2], t.[6],
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
        t.[8] <@ OpsV.iVPBLENDD_256(t.[4], t.[2],
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
        a41 <@ OpsV.iVPBLENDD_256(t.[3], t.[4],
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
        t.[7] <@ OpsV.iVPBLENDD_256(t.[2], t.[3],
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
        a31 <@ OpsV.iVPBLENDD_256(a31, t.[4],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
        t.[8] <@ OpsV.iVPBLENDD_256(t.[8], t.[5],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
        a41 <@ OpsV.iVPBLENDD_256(a41, t.[2],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
        t.[7] <@ OpsV.iVPBLENDD_256(t.[7], t.[6],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
        a31 <@ OpsV.iVPBLENDD_256(a31, t.[5],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
        t.[8] <@ OpsV.iVPBLENDD_256(t.[8], t.[6],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
        a41 <@ OpsV.iVPBLENDD_256(a41, t.[6],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
        t.[7] <@ OpsV.iVPBLENDD_256(t.[7], t.[4],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
        a31 <@ OpsV.ilandn4u64(a31,t.[8]);
        a41 <@ OpsV.ilandn4u64(a41,t.[7]);
        a11 <@ OpsV.iVPBLENDD_256(t.[5], t.[2],
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
        t.[8] <@ OpsV.iVPBLENDD_256(t.[3], t.[5],
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
        a31 <@ OpsV.ilxor4u64(a31,t.[3]);
        a11 <@ OpsV.iVPBLENDD_256(a11, t.[3],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
        t.[8] <@ OpsV.iVPBLENDD_256(t.[8], t.[4],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
        a41 <@ OpsV.ilxor4u64(a41,t.[5]);
        a11 <@ OpsV.iVPBLENDD_256(a11, t.[4],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
        t.[8] <@ OpsV.iVPBLENDD_256(t.[8], t.[2],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
        a11 <@ OpsV.ilandn4u64(a11,t.[8]);
        a11 <@ OpsV.ilxor4u64(a11,t.[6]);
        a21 <@ OpsV.iVPERMQ(t.[1],(W8.of_int 30));
        t.[8] <@ OpsV.iVPBLENDD_256(a21, a00,
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
        a01 <@ OpsV.iVPERMQ(t.[1],(W8.of_int 57));
        a01 <@ OpsV.iVPBLENDD_256(a01 ,a00,
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
        a01 <@ OpsV.ilandn4u64(a01,t.[8]);
        a20 <@ OpsV.iVPBLENDD_256(t.[4], t.[5],
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
        t.[7] <@ OpsV.iVPBLENDD_256(t.[6], t.[4],
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
        a20 <@ OpsV.iVPBLENDD_256(a20, t.[6],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
        t.[7] <@ OpsV.iVPBLENDD_256(t.[7], t.[3],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
        a20 <@ OpsV.iVPBLENDD_256(a20, t.[3],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
        t.[7] <@ OpsV.iVPBLENDD_256(t.[7], t.[5],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
        a20 <@ OpsV.ilandn4u64(a20,t.[7]);
        a20 <@ OpsV.ilxor4u64(a20,t.[2]);
        t.[0] <@ OpsV.iVPERMQ(t.[0],(W8.of_int 0));
        a31 <@ OpsV.iVPERMQ(a31,(W8.of_int 27));
        a41 <@ OpsV.iVPERMQ(a41,(W8.of_int 141));
        a11 <@ OpsV.iVPERMQ(a11,(W8.of_int 114));
        a21 <@ OpsV.iVPBLENDD_256(t.[6], t.[3],
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
        t.[7] <@ OpsV.iVPBLENDD_256(t.[5], t.[6],
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
        a21 <@ OpsV.iVPBLENDD_256(a21, t.[5],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
        t.[7] <@ OpsV.iVPBLENDD_256(t.[7] ,t.[2],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
        a21 <@ OpsV.iVPBLENDD_256(a21, t.[2],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
        t.[7] <@ OpsV.iVPBLENDD_256(t.[7], t.[3],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
        a21 <@ OpsV.ilandn4u64(a21,t.[7]);
        a00 <@ OpsV.ilxor4u64(a00,t.[0]);
        a01 <@ OpsV.ilxor4u64(a01,t.[1]);
        a21 <@ OpsV.ilxor4u64(a21,t.[4]);
        a00 <@ OpsV.ilxor4u64(a00, 
                (loadW256 Glob.mem (W64.to_uint (iotas + (W64.of_int 0)))));
        iotas <- (iotas + (W64.of_int 32));
      ( _0,  _1,  _2, zf, i) <- x86_DEC_32 i;
    }
    return (a00, a01, a20, a31, a21, a41, a11);
  }
}.

require import Keccakf1600_savx2_openssl.

equiv prevec_vops_openssl :
  Mavx2_prevec_vops.__keccakf1600_avx2_openssl ~ M.__keccakf1600_avx2_openssl :
   ={Glob.mem,arg} ==> ={Glob.mem,res}.
proc.
   seq 112 112 : (#pre /\ ={zf,iotas,rhotates_left,rhotates_right,t,i}).
   seq 30 30 : (#pre /\ ={d14,t,iotas,rhotates_left,rhotates_right,i}).
   by inline*;wp;skip; rewrite /flat_state; auto => />.
   seq 30 30 : #pre.
   by inline*;wp;skip; rewrite /flat_state; auto => />.
   seq 30 30 : #pre.
   by inline*;wp;skip; rewrite /flat_state; auto => />.
   by inline*;wp;skip; rewrite /flat_state; auto => />.
   while (#pre).
   seq 30 30 : (#pre /\ ={d14}).
   by inline*;wp;skip; rewrite /flat_state; auto => />.
   seq 30 30 : #pre.
   by inline*;wp;skip; rewrite /flat_state; auto => />.
   seq 30 30 : #pre.
   by inline*;wp;skip; rewrite /flat_state; auto => />.
   by inline*;wp;skip; rewrite /flat_state; auto => />.
   by auto => />.
qed.

require import Keccakf1600_pavx2_prevec.

op match_ins(st1 : W64.t Array4.t * W64.t Array4.t * W64.t Array4.t * W64.t Array4.t *
    W64.t Array4.t * W64.t Array4.t * W64.t Array4.t * W64.t * W64.t * W64.t,
             st2 : W256.t * W256.t * W256.t * W256.t * W256.t * W256.t * W256.t * W64.t *
    W64.t * W64.t) =
   is4u64 st1.`1 st2.`1 /\
   is4u64 st1.`2 st2.`2 /\
   is4u64 st1.`3 st2.`3 /\
   is4u64 st1.`4 st2.`4 /\
   is4u64 st1.`5 st2.`5 /\
   is4u64 st1.`6 st2.`6 /\
   is4u64 st1.`7 st2.`7 /\
   st1.`8 = st2.`8 /\
   st1.`9 = st2.`9 /\
   st1.`10 = st2.`10.

op match_states( st1 : W64.t Array4.t * W64.t Array4.t * W64.t Array4.t * W64.t Array4.t *
    W64.t Array4.t * W64.t Array4.t * W64.t Array4.t, 
                st2 : W256.t * W256.t * W256.t * W256.t * W256.t * W256.t * W256.t) =
   is4u64 st1.`1 st2.`1 /\
   is4u64 st1.`2 st2.`2 /\
   is4u64 st1.`3 st2.`3 /\
   is4u64 st1.`4 st2.`4 /\
   is4u64 st1.`5 st2.`5 /\
   is4u64 st1.`6 st2.`6 /\
   is4u64 st1.`7 st2.`7.

lemma lift2arrayP (w:W256.t) : w = pack4 [(lift2array w).[0]; (lift2array w).[1]; (lift2array w).[2]; (lift2array w).[3]].
proof.
  apply W4u64.wordP => i hi.
  rewrite /lift2array /= pack4bE 1:// get_of_list 1:// /#.
qed.

equiv prevec_vops_prevec :
  Mavx2_prevec.__keccakf1600_avx2_openssl ~ Mavx2_prevec_vops.__keccakf1600_avx2_openssl :
   ={Glob.mem} /\ match_ins arg{1} arg{2} ==> ={Glob.mem} /\ match_states res{1} res{2}.
proof.
  proc.
  while (#pre /\ ={zf,iotas,rhotates_left,rhotates_right,i}).
   + wp;
     do !(call eq_ilxor4u64 || call eq_ilandn4u64 || call eq_iVPBLENDD_256 || call eq_iVPERMQ || call eq_ilandn4u64 ||
          call eq_iVPSRLDQ_256 || call eq_iVPSLLV_4u64 || call eq_ilor4u64 || call eq_iVPSRLV_4u64 ||
          call eq_ivadd64u256 || call eq_ivshr64u256 || call eq_iVPSHUFD_256); wp; skip => />; rewrite /is4u64 => />. 
    smt (lift2arrayP).
  wp;
  do !(call eq_ilxor4u64 || call eq_ilandn4u64 || call eq_iVPBLENDD_256 || call eq_iVPERMQ || call eq_ilandn4u64 ||
       call eq_iVPSRLDQ_256 || call eq_iVPSLLV_4u64 || call eq_ilor4u64 || call eq_iVPSRLV_4u64 ||
       call eq_ivadd64u256 || call eq_ivshr64u256 || call eq_iVPSHUFD_256); wp; skip => />; rewrite /is4u64 => />. 
  smt (lift2arrayP).
qed.


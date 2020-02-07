require import AllCore List Int IntExtra IntDiv CoreMap.
from Jasmin require import JModel.

require import Array4p Array9 Array24 Array25 Array96p.
require import WArray288.

require import Keccakf1600_pref_table.
require import Keccakf1600_pref_op.
require import Ops.

op lift2array(x :  W256.t) : W64.t Array4.t =
    Array4.init (fun (n : int) => x \bits64 n).

op good_rhotates_right : int Array24.t = (
  witness
     .[4* 0+0 <- 64 -  3].[4* 0+1 <- 64 - 18].[4* 0+2 <- 64 - 36].[4* 0+3 <- 64 - 41]
     .[4* 1+0 <- 64 -  1].[4* 1+1 <- 64 - 62].[4* 1+2 <- 64 - 28].[4* 1+3 <- 64 - 27]
     .[4* 2+0 <- 64 - 45].[4* 2+1 <- 64 -  6].[4* 2+2 <- 64 - 56].[4* 2+3 <- 64 - 39]
     .[4* 3+0 <- 64 - 10].[4* 3+1 <- 64 - 61].[4* 3+2 <- 64 - 55].[4* 3+3 <- 64 -  8]
     .[4* 4+0 <- 64 -  2].[4* 4+1 <- 64 - 15].[4* 4+2 <- 64 - 25].[4* 4+3 <- 64 - 20]
     .[4* 5+0 <- 64 - 44].[4* 5+1 <- 64 - 43].[4* 5+2 <- 64 - 21].[4* 5+3 <- 64 - 14])%Array24.


op good_rhotates_left : int Array24.t = (
  witness
     .[4* 0+0 <-  3].[4* 0+1 <- 18].[4* 0+2 <- 36].[4* 0+3 <- 41]
     .[4* 1+0 <-  1].[4* 1+1 <- 62].[4* 1+2 <- 28].[4* 1+3 <- 27]
     .[4* 2+0 <- 45].[4* 2+1 <-  6].[4* 2+2 <- 56].[4* 2+3 <- 39]
     .[4* 3+0 <- 10].[4* 3+1 <- 61].[4* 3+2 <- 55].[4* 3+3 <-  8]
     .[4* 4+0 <-  2].[4* 4+1 <- 15].[4* 4+2 <- 25].[4* 4+3 <- 20]
     .[4* 5+0 <- 44].[4* 5+1 <- 43].[4* 5+2 <- 21].[4* 5+3 <- 14])%Array24.


op good_iotas4x : W64.t Array96.t = (
  witness 
     .[4* 0+0 <- W64.one                       ].[4* 0+1 <- W64.one                       ].[4* 0+2 <- W64.one                       ].[4* 0+3 <- W64.one                       ]                    
     .[4* 1+0 <- W64.of_int 32898              ].[4* 1+1 <- W64.of_int 32898              ].[4* 1+2 <- W64.of_int 32898              ].[4* 1+3 <- W64.of_int 32898              ]                
     .[4* 2+0 <- W64.of_int 9223372036854808714].[4* 2+1 <- W64.of_int 9223372036854808714].[4* 2+2 <- W64.of_int 9223372036854808714].[4* 2+3 <- W64.of_int 9223372036854808714] 
     .[4* 3+0 <- W64.of_int 9223372039002292224].[4* 3+1 <- W64.of_int 9223372039002292224].[4* 3+2 <- W64.of_int 9223372039002292224].[4* 3+3 <- W64.of_int 9223372039002292224] 
     .[4* 4+0 <- W64.of_int 32907              ].[4* 4+1 <- W64.of_int 32907              ].[4* 4+2 <- W64.of_int 32907              ].[4* 4+3 <- W64.of_int 32907              ]               
     .[4* 5+0 <- W64.of_int 2147483649         ].[4* 5+1 <- W64.of_int 2147483649         ].[4* 5+2 <- W64.of_int 2147483649         ].[4* 5+3 <- W64.of_int 2147483649         ]          
     .[4* 6+0 <- W64.of_int 9223372039002292353].[4* 6+1 <- W64.of_int 9223372039002292353].[4* 6+2 <- W64.of_int 9223372039002292353].[4* 6+3 <- W64.of_int 9223372039002292353] 
     .[4* 7+0 <- W64.of_int 9223372036854808585].[4* 7+1 <- W64.of_int 9223372036854808585].[4* 7+2 <- W64.of_int 9223372036854808585].[4* 7+3 <- W64.of_int 9223372036854808585] 
     .[4* 8+0 <- W64.of_int 138                ].[4* 8+1 <- W64.of_int 138                ].[4* 8+2 <- W64.of_int 138                ].[4* 8+3 <- W64.of_int 138                ]                 
     .[4* 9+0 <- W64.of_int 136                ].[4* 9+1 <- W64.of_int 136                ].[4* 9+2 <- W64.of_int 136                ].[4* 9+3 <- W64.of_int 136                ]                  
     .[4*10+0 <- W64.of_int 2147516425         ].[4*10+1 <- W64.of_int 2147516425         ].[4*10+2 <- W64.of_int 2147516425         ].[4*10+3 <- W64.of_int 2147516425         ]          
     .[4*11+0 <- W64.of_int 2147483658         ].[4*11+1 <- W64.of_int 2147483658         ].[4*11+2 <- W64.of_int 2147483658         ].[4*11+3 <- W64.of_int 2147483658         ]           
     .[4*12+0 <- W64.of_int 2147516555         ].[4*12+1 <- W64.of_int 2147516555         ].[4*12+2 <- W64.of_int 2147516555         ].[4*12+3 <- W64.of_int 2147516555         ]            
     .[4*13+0 <- W64.of_int 9223372036854775947].[4*13+1 <- W64.of_int 9223372036854775947].[4*13+2 <- W64.of_int 9223372036854775947].[4*13+3 <- W64.of_int 9223372036854775947] 
     .[4*14+0 <- W64.of_int 9223372036854808713].[4*14+1 <- W64.of_int 9223372036854808713].[4*14+2 <- W64.of_int 9223372036854808713].[4*14+3 <- W64.of_int 9223372036854808713] 
     .[4*15+0 <- W64.of_int 9223372036854808579].[4*15+1 <- W64.of_int 9223372036854808579].[4*15+2 <- W64.of_int 9223372036854808579].[4*15+3 <- W64.of_int 9223372036854808579] 
     .[4*16+0 <- W64.of_int 9223372036854808578].[4*16+1 <- W64.of_int 9223372036854808578].[4*16+2 <- W64.of_int 9223372036854808578].[4*16+3 <- W64.of_int 9223372036854808578] 
     .[4*17+0 <- W64.of_int 9223372036854775936].[4*17+1 <- W64.of_int 9223372036854775936].[4*17+2 <- W64.of_int 9223372036854775936].[4*17+3 <- W64.of_int 9223372036854775936] 
     .[4*18+0 <- W64.of_int 32778              ].[4*18+1 <- W64.of_int 32778              ].[4*18+2 <- W64.of_int 32778              ].[4*18+3 <- W64.of_int 32778              ]               
     .[4*19+0 <- W64.of_int 9223372039002259466].[4*19+1 <- W64.of_int 9223372039002259466].[4*19+2 <- W64.of_int 9223372039002259466].[4*19+3 <- W64.of_int 9223372039002259466] 
     .[4*20+0 <- W64.of_int 9223372039002292353].[4*20+1 <- W64.of_int 9223372039002292353].[4*20+2 <- W64.of_int 9223372039002292353].[4*20+3 <- W64.of_int 9223372039002292353] 
     .[4*21+0 <- W64.of_int 9223372036854808704].[4*21+1 <- W64.of_int 9223372036854808704].[4*21+2 <- W64.of_int 9223372036854808704].[4*21+3 <- W64.of_int 9223372036854808704] 
     .[4*22+0 <- W64.of_int 2147483649         ].[4*22+1 <- W64.of_int 2147483649         ].[4*22+2 <- W64.of_int 2147483649         ].[4*22+3 <- W64.of_int 2147483649         ]             
     .[4*23+0 <- W64.of_int 9223372039002292232].[4*23+1 <- W64.of_int 9223372039002292232].[4*23+2 <- W64.of_int 9223372039002292232].[4*23+3 <- W64.of_int 9223372039002292232])%Array96.

module Mavx2_prevec = {

  proc __keccakf1600_avx2_openssl(
           a00:W64.t Array4.t, a01:W64.t Array4.t, a20:W64.t Array4.t, a31:W64.t Array4.t,
           a21:W64.t Array4.t, a41:W64.t Array4.t, a11:W64.t Array4.t,
           _rhotates_left:W64.t, _rhotates_right:W64.t, _iotas:W64.t) : 
         W64.t Array4.t * W64.t Array4.t * W64.t Array4.t * W64.t Array4.t *
         W64.t Array4.t * W64.t Array4.t * W64.t Array4.t = {

    var rhotates_left:W64.t;
    var rhotates_right:W64.t;
    var iotas:W64.t;
    var i:W32.t;
    var zf:bool;
    var c00:W64.t Array4.t;
    var c14:W64.t Array4.t;
    var t:W64.t Array4.t Array9.t;
    var d14:W64.t Array4.t;
    var d00:W64.t Array4.t;
    var  _0:bool;
    var  _1:bool;
    var  _2:bool;
    t <- witness;
    rhotates_left <- (_rhotates_left + (W64.of_int 96));
    rhotates_right <- (_rhotates_right + (W64.of_int 96));
    iotas <- _iotas;
    i <- (W32.of_int 24);
    c00 <@ Ops.iVPSHUFD_256(a20,(W8.of_int 78));
    c14 <@ Ops.ilxor4u64(a41,a31);
    t.[2] <@ Ops.ilxor4u64(a21,a11);
    c14 <@ Ops.ilxor4u64(c14,a01);
    c14 <@ Ops.ilxor4u64(c14,t.[2]);
    t.[4] <- Ops.iVPERMQ(c14,(W8.of_int 147));
    c00 <@ Ops.ilxor4u64(c00,a20);
    t.[0] <- Ops.iVPERMQ(c00,(W8.of_int 78));
    t.[1] <- Ops.ivshr64u256(c14, (W8.of_int 63));
    t.[2] <- Ops.ivadd64u256(c14, c14);
    t.[1] <@ Ops.ilor4u64(t.[1],t.[2]);
    d14 <- Ops.iVPERMQ(t.[1],(W8.of_int 57));
    d00 <@ Ops.ilxor4u64(t.[1],t.[4]);
    d00 <- Ops.iVPERMQ(d00,(W8.of_int 0));
    c00 <@ Ops.ilxor4u64(c00,a00);
    c00 <@ Ops.ilxor4u64(c00,t.[0]);
    t.[0] <- Ops.ivshr64u256(c00, (W8.of_int 63));
    t.[1] <- Ops.ivadd64u256(c00, c00);
    t.[1] <@ Ops.ilor4u64(t.[1],t.[0]);
    a20 <@ Ops.ilxor4u64(a20,d00);
    a00 <@ Ops.ilxor4u64(a00,d00);
    d14 <- Ops.iVPBLENDD_256(d14,t.[1],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
    t.[4] <- Ops.iVPBLENDD_256(t.[4],c00,
    (W8.of_int (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
    d14 <@ Ops.ilxor4u64(d14,t.[4]);
    t.[3] <@ Ops.iVPSLLV_4u64(a20, lift2array
          (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((0 * 32) - 96))))));
    a20 <@ Ops.iVPSRLV_4u64(a20, lift2array
          (loadW256 Glob.mem (W64.to_uint (rhotates_right+ (W64.of_int ((0 * 32) - 96))))));
    a20 <@ Ops.ilor4u64(a20,t.[3]);
    a31 <@ Ops.ilxor4u64(a31,d14);
    t.[4] <@ Ops.iVPSLLV_4u64(a31, lift2array
          (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((2 * 32) - 96))))));
    a31 <@ Ops.iVPSRLV_4u64(a31, lift2array
          (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((2 * 32) - 96))))));
    a31 <@ Ops.ilor4u64(a31,t.[4]);
    a21 <@ Ops.ilxor4u64(a21,d14);
    t.[5] <@ Ops.iVPSLLV_4u64(a21, lift2array
          (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((3 * 32) - 96))))));
    a21 <@ Ops.iVPSRLV_4u64(a21, lift2array
          (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((3 * 32) - 96))))));
    a21 <@ Ops.ilor4u64(a21,t.[5]);
    a41 <@ Ops.ilxor4u64(a41,d14);
    t.[6] <@ Ops.iVPSLLV_4u64(a41, lift2array
          (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((4 * 32) - 96))))));
    a41 <@ Ops.iVPSRLV_4u64(a41, lift2array
          (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((4 * 32) - 96))))));
    a41 <@ Ops.ilor4u64(a41,t.[6]);
    a11 <@ Ops.ilxor4u64(a11,d14);
    t.[3] <- Ops.iVPERMQ(a20,(W8.of_int 141));
    t.[4] <- Ops.iVPERMQ(a31,(W8.of_int 141));
    t.[7] <@ Ops.iVPSLLV_4u64(a11, lift2array
          (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((5 * 32) - 96))))));
    t.[1] <@ Ops.iVPSRLV_4u64(a11, lift2array
          (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((5 * 32) - 96))))));
    t.[1] <@ Ops.ilor4u64(t.[1],t.[7]);
    a01 <@ Ops.ilxor4u64(a01,d14);
    t.[5] <- Ops.iVPERMQ(a21,(W8.of_int 27));
    t.[6] <- Ops.iVPERMQ(a41,(W8.of_int 114));
    t.[8] <@ Ops.iVPSLLV_4u64(a01, lift2array
          (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((1 * 32) - 96))))));
    t.[2] <@ Ops.iVPSRLV_4u64(a01, lift2array
          (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((1 * 32) - 96))))));
    t.[2] <@ Ops.ilor4u64(t.[2],t.[8]);
    t.[7] <@ Ops.iVPSRLDQ_256(t.[1],(W8.of_int 8));
    t.[0] <@ Ops.ilandn4u64(t.[1],t.[7]);
    a31 <@ Ops.iVPBLENDD_256(t.[2],t.[6],
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
    t.[8] <@ Ops.iVPBLENDD_256(t.[4],t.[2],
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
    a41 <@ Ops.iVPBLENDD_256(t.[3], t.[4],
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
    t.[7] <@ Ops.iVPBLENDD_256(t.[2], t.[3],
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
    a31 <@ Ops.iVPBLENDD_256(a31 ,t.[4],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
    t.[8] <@ Ops.iVPBLENDD_256(t.[8], t.[5],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
    a41 <@ Ops.iVPBLENDD_256(a41, t.[2],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
    t.[7] <@ Ops.iVPBLENDD_256(t.[7], t.[6],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
    a31 <@ Ops.iVPBLENDD_256(a31, t.[5],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
    t.[8] <@ Ops.iVPBLENDD_256(t.[8], t.[6],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
    a41 <@ Ops.iVPBLENDD_256(a41, t.[6],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
    t.[7] <@ Ops.iVPBLENDD_256(t.[7], t.[4],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
    a31 <@ Ops.ilandn4u64(a31,t.[8]);
    a41 <@ Ops.ilandn4u64(a41,t.[7]);
    a11 <@ Ops.iVPBLENDD_256(t.[5],t.[2],
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
    t.[8] <@ Ops.iVPBLENDD_256(t.[3], t.[5],
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
    a31 <@ Ops.ilxor4u64(a31,t.[3]);
    a11 <@ Ops.iVPBLENDD_256(a11,t.[3],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
    t.[8] <@ Ops.iVPBLENDD_256(t.[8],t.[4],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
    a41 <@ Ops.ilxor4u64(a41,t.[5]);
    a11 <@ Ops.iVPBLENDD_256(a11, t.[4],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
    t.[8] <@ Ops.iVPBLENDD_256(t.[8], t.[2],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
    a11 <@ Ops.ilandn4u64(a11,t.[8]);
    a11 <@ Ops.ilxor4u64(a11,t.[6]);
    a21 <@ Ops.iVPERMQ(t.[1],(W8.of_int 30));
    t.[8] <@ Ops.iVPBLENDD_256(a21, a00,
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
    a01 <@ Ops.iVPERMQ(t.[1],(W8.of_int 57));
    a01 <@ Ops.iVPBLENDD_256(a01, a00,
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
    a01 <@ Ops.ilandn4u64(a01,t.[8]);
    a20 <@ Ops.iVPBLENDD_256(t.[4], t.[5],
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
    t.[7] <@ Ops.iVPBLENDD_256(t.[6], t.[4],
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
    a20 <@ Ops.iVPBLENDD_256(a20, t.[6],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
    t.[7] <@ Ops.iVPBLENDD_256(t.[7], t.[3],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
    a20 <@ Ops.iVPBLENDD_256(a20, t.[3],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
    t.[7] <@ Ops.iVPBLENDD_256(t.[7], t.[5],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
    a20 <@ Ops.ilandn4u64(a20,t.[7]);
    a20 <@ Ops.ilxor4u64(a20,t.[2]);
    t.[0] <@ Ops.iVPERMQ(t.[0],(W8.of_int 0));
    a31 <@ Ops.iVPERMQ(a31,(W8.of_int 27));
    a41 <@ Ops.iVPERMQ(a41,(W8.of_int 141));
    a11 <@ Ops.iVPERMQ(a11,(W8.of_int 114));
    a21 <@ Ops.iVPBLENDD_256(t.[6], t.[3],
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
    t.[7] <@ Ops.iVPBLENDD_256(t.[5], t.[6],
    (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
    a21 <@ Ops.iVPBLENDD_256(a21, t.[5],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
    t.[7] <@ Ops.iVPBLENDD_256(t.[7], t.[2],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
    a21 <@ Ops.iVPBLENDD_256(a21, t.[2],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
    t.[7] <@ Ops.iVPBLENDD_256(t.[7], t.[3],
    (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
    a21 <@ Ops.ilandn4u64(a21,t.[7]);
    a00 <@ Ops.ilxor4u64(a00,t.[0]);
    a01 <@ Ops.ilxor4u64(a01,t.[1]);
    a21 <@ Ops.ilxor4u64(a21,t.[4]);
    a00 <@ Ops.ilxor4u64(a00, lift2array
            (loadW256 Glob.mem (W64.to_uint (iotas + (W64.of_int 0)))));
    iotas <- (iotas + (W64.of_int 32));
    ( _0,  _1,  _2, zf, i) <- DEC_32 i;
    while ((! zf)) {
      c00 <@ Ops.iVPSHUFD_256(a20,(W8.of_int 78));
      c14 <@ Ops.ilxor4u64(a41,a31);
      t.[2] <@ Ops.ilxor4u64(a21,a11);
      c14 <@ Ops.ilxor4u64(c14,a01);
      c14 <@ Ops.ilxor4u64(c14,t.[2]);
      t.[4] <@ Ops.iVPERMQ(c14,(W8.of_int 147));
      c00 <@ Ops.ilxor4u64(c00,a20);
      t.[0] <@ Ops.iVPERMQ(c00,(W8.of_int 78));
      t.[1] <@ Ops.ivshr64u256(c14, (W8.of_int 63));
      t.[2] <@ Ops.ivadd64u256(c14, c14);
      t.[1] <@ Ops.ilor4u64(t.[1],t.[2]);
      d14 <@ Ops.iVPERMQ(t.[1],(W8.of_int 57));
      d00 <@ Ops.ilxor4u64(t.[1],t.[4]);
      d00 <@ Ops.iVPERMQ(d00,(W8.of_int 0));
      c00 <@ Ops.ilxor4u64(c00,a00);
      c00 <@ Ops.ilxor4u64(c00,t.[0]);
      t.[0] <@ Ops.ivshr64u256(c00, (W8.of_int 63));
      t.[1] <@ Ops.ivadd64u256(c00, c00);
      t.[1] <@ Ops.ilor4u64(t.[1],t.[0]);
      a20 <@ Ops.ilxor4u64(a20,d00);
      a00 <@ Ops.ilxor4u64(a00,d00);
      d14 <@ Ops.iVPBLENDD_256(d14,t.[1],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
        t.[4] <@ Ops.iVPBLENDD_256(t.[4],c00,
      (W8.of_int (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
      d14 <@ Ops.ilxor4u64(d14,t.[4]);
      t.[3] <@ Ops.iVPSLLV_4u64(a20, lift2array
            (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((0 * 32) - 96))))));
      a20 <@ Ops.iVPSRLV_4u64(a20, lift2array
            (loadW256 Glob.mem (W64.to_uint (rhotates_right+ (W64.of_int ((0 * 32) - 96))))));
      a20 <@ Ops.ilor4u64(a20,t.[3]);
      a31 <@ Ops.ilxor4u64(a31,d14);
      t.[4] <@ Ops.iVPSLLV_4u64(a31, lift2array
            (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((2 * 32) - 96))))));
      a31 <@ Ops.iVPSRLV_4u64(a31, lift2array
            (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((2 * 32) - 96))))));
      a31 <@ Ops.ilor4u64(a31,t.[4]);
      a21 <@ Ops.ilxor4u64(a21,d14);
      t.[5] <@ Ops.iVPSLLV_4u64(a21, lift2array
            (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((3 * 32) - 96))))));
      a21 <@ Ops.iVPSRLV_4u64(a21, lift2array
            (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((3 * 32) - 96))))));
      a21 <@ Ops.ilor4u64(a21,t.[5]);
      a41 <@ Ops.ilxor4u64(a41,d14);
      t.[6] <@ Ops.iVPSLLV_4u64(a41, lift2array
            (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((4 * 32) - 96))))));
      a41 <@ Ops.iVPSRLV_4u64(a41, lift2array
            (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((4 * 32) - 96))))));
      a41 <@ Ops.ilor4u64(a41,t.[6]);
      a11 <@ Ops.ilxor4u64(a11,d14);
      t.[3] <- Ops.iVPERMQ(a20,(W8.of_int 141));
      t.[4] <- Ops.iVPERMQ(a31,(W8.of_int 141));
      t.[7] <@ Ops.iVPSLLV_4u64(a11, lift2array
            (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((5 * 32) - 96))))));
      t.[1] <@ Ops.iVPSRLV_4u64(a11, lift2array
            (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((5 * 32) - 96))))));
      t.[1] <@ Ops.ilor4u64(t.[1],t.[7]);
      a01 <@ Ops.ilxor4u64(a01,d14);
      t.[5] <- Ops.iVPERMQ(a21,(W8.of_int 27));
      t.[6] <- Ops.iVPERMQ(a41,(W8.of_int 114));
      t.[8] <@ Ops.iVPSLLV_4u64(a01, lift2array
            (loadW256 Glob.mem (W64.to_uint (rhotates_left + (W64.of_int ((1 * 32) - 96))))));
      t.[2] <@ Ops.iVPSRLV_4u64(a01, lift2array
          (loadW256 Glob.mem (W64.to_uint (rhotates_right + (W64.of_int ((1 * 32) - 96))))));
      t.[2] <@ Ops.ilor4u64(t.[2],t.[8]);
      t.[7] <@ Ops.iVPSRLDQ_256(t.[1],(W8.of_int 8));
      t.[0] <@ Ops.ilandn4u64(t.[1],t.[7]);
      a31 <@ Ops.iVPBLENDD_256(t.[2], t.[6],
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
        t.[8] <@ Ops.iVPBLENDD_256(t.[4], t.[2],
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
        a41 <@ Ops.iVPBLENDD_256(t.[3], t.[4],
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
        t.[7] <@ Ops.iVPBLENDD_256(t.[2], t.[3],
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
        a31 <@ Ops.iVPBLENDD_256(a31, t.[4],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
        t.[8] <@ Ops.iVPBLENDD_256(t.[8], t.[5],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
        a41 <@ Ops.iVPBLENDD_256(a41, t.[2],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
        t.[7] <@ Ops.iVPBLENDD_256(t.[7], t.[6],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
        a31 <@ Ops.iVPBLENDD_256(a31, t.[5],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
        t.[8] <@ Ops.iVPBLENDD_256(t.[8], t.[6],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
        a41 <@ Ops.iVPBLENDD_256(a41, t.[6],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
        t.[7] <@ Ops.iVPBLENDD_256(t.[7], t.[4],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
        a31 <@ Ops.ilandn4u64(a31,t.[8]);
        a41 <@ Ops.ilandn4u64(a41,t.[7]);
        a11 <@ Ops.iVPBLENDD_256(t.[5], t.[2],
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
        t.[8] <@ Ops.iVPBLENDD_256(t.[3], t.[5],
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
        a31 <@ Ops.ilxor4u64(a31,t.[3]);
        a11 <@ Ops.iVPBLENDD_256(a11, t.[3],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
        t.[8] <@ Ops.iVPBLENDD_256(t.[8], t.[4],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
        a41 <@ Ops.ilxor4u64(a41,t.[5]);
        a11 <@ Ops.iVPBLENDD_256(a11, t.[4],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
        t.[8] <@ Ops.iVPBLENDD_256(t.[8], t.[2],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
        a11 <@ Ops.ilandn4u64(a11,t.[8]);
        a11 <@ Ops.ilxor4u64(a11,t.[6]);
        a21 <@ Ops.iVPERMQ(t.[1],(W8.of_int 30));
        t.[8] <@ Ops.iVPBLENDD_256(a21, a00,
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
        a01 <@ Ops.iVPERMQ(t.[1],(W8.of_int 57));
        a01 <@ Ops.iVPBLENDD_256(a01 ,a00,
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
        a01 <@ Ops.ilandn4u64(a01,t.[8]);
        a20 <@ Ops.iVPBLENDD_256(t.[4], t.[5],
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
        t.[7] <@ Ops.iVPBLENDD_256(t.[6], t.[4],
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
        a20 <@ Ops.iVPBLENDD_256(a20, t.[6],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
        t.[7] <@ Ops.iVPBLENDD_256(t.[7], t.[3],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
        a20 <@ Ops.iVPBLENDD_256(a20, t.[3],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
        t.[7] <@ Ops.iVPBLENDD_256(t.[7], t.[5],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
        a20 <@ Ops.ilandn4u64(a20,t.[7]);
        a20 <@ Ops.ilxor4u64(a20,t.[2]);
        t.[0] <@ Ops.iVPERMQ(t.[0],(W8.of_int 0));
        a31 <@ Ops.iVPERMQ(a31,(W8.of_int 27));
        a41 <@ Ops.iVPERMQ(a41,(W8.of_int 141));
        a11 <@ Ops.iVPERMQ(a11,(W8.of_int 114));
        a21 <@ Ops.iVPBLENDD_256(t.[6], t.[3],
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
        t.[7] <@ Ops.iVPBLENDD_256(t.[5], t.[6],
      (W8.of_int (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 0)))));
        a21 <@ Ops.iVPBLENDD_256(a21, t.[5],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
        t.[7] <@ Ops.iVPBLENDD_256(t.[7] ,t.[2],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (3 %% 2^2 + 2^2 * 0)))));
        a21 <@ Ops.iVPBLENDD_256(a21, t.[2],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
        t.[7] <@ Ops.iVPBLENDD_256(t.[7], t.[3],
      (W8.of_int (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * (0 %% 2^2 + 2^2 * 3)))));
        a21 <@ Ops.ilandn4u64(a21,t.[7]);
        a00 <@ Ops.ilxor4u64(a00,t.[0]);
        a01 <@ Ops.ilxor4u64(a01,t.[1]);
        a21 <@ Ops.ilxor4u64(a21,t.[4]);
        a00 <@ Ops.ilxor4u64(a00, lift2array
                (loadW256 Glob.mem (W64.to_uint (iotas + (W64.of_int 0)))));
        iotas <- (iotas + (W64.of_int 32));
      ( _0,  _1,  _2, zf, i) <- DEC_32 i;
    }
    return (a00, a01, a20, a31, a21, a41, a11);
  }
}.

(*
   ($a00,	# [0][0] [0][0] [0][0] [0][0]		
    $a01,	# [0][4] [0][3] [0][2] [0][1]		
    $a20,	# [3][0] [1][0] [4][0] [2][0]		
    $a31,	# [2][4] [4][3] [1][2] [3][1]		
    $a21,	# [3][4] [1][3] [4][2] [2][1]		
    $a41,	# [1][4] [2][3] [3][2] [4][1]		
    $a11) =	# [4][4] [3][3] [2][2] [1][1]		
*)

op index x y = 5*x+y. 

op equiv_states (a00 a01 a20 a31 a21 a41 a11 : W64.t Array4.t, st : W64.t Array25.t) : bool =
   a00.[3] = st.[index 0 0] /\ a00.[2] = st.[index 0 0] /\ a00.[1] = st.[index 0 0] /\ a00.[0] = st.[index 0 0] /\
   a01.[3] = st.[index 0 4] /\ a01.[2] = st.[index 0 3] /\ a01.[1] = st.[index 0 2] /\ a01.[0] = st.[index 0 1] /\
   a20.[3] = st.[index 3 0] /\ a20.[2] = st.[index 1 0] /\ a20.[1] = st.[index 4 0] /\ a20.[0] = st.[index 2 0] /\
   a31.[3] = st.[index 2 4] /\ a31.[2] = st.[index 4 3] /\ a31.[1] = st.[index 1 2] /\ a31.[0] = st.[index 3 1] /\
   a21.[3] = st.[index 3 4] /\ a21.[2] = st.[index 1 3] /\ a21.[1] = st.[index 4 2] /\ a21.[0] = st.[index 2 1] /\
   a41.[3] = st.[index 1 4] /\ a41.[2] = st.[index 2 3] /\ a41.[1] = st.[index 3 2] /\ a41.[0] = st.[index 4 1] /\
   a11.[3] = st.[index 4 4] /\ a11.[2] = st.[index 3 3] /\ a11.[1] = st.[index 2 2] /\ a11.[0] = st.[index 1 1].

op equiv_states_chi (a00 a01 a20 a31 a21 a41 a11 : W64.t Array4.t, st : W64.t Array25.t) : bool =
   a00.[3] = st.[index 0 0] /\ a00.[2] = st.[index 0 0] /\ a00.[1] = st.[index 0 0] /\ a00.[0] = st.[index 0 0] /\
   a01.[3] = st.[index 0 4] /\ a01.[2] = st.[index 0 3] /\ a01.[1] = st.[index 0 2] /\ a01.[0] = st.[index 0 1] /\
   a20.[3] = st.[index 3 0] /\ a20.[2] = st.[index 1 0] /\ a20.[1] = st.[index 4 0] /\ a20.[0] = st.[index 2 0] /\
   a31.[3] = st.[index 3 1] /\ a31.[2] = st.[index 1 2] /\ a31.[1] = st.[index 4 3] /\ a31.[0] = st.[index 2 4] /\
   a21.[3] = st.[index 3 4] /\ a21.[2] = st.[index 1 3] /\ a21.[1] = st.[index 4 2] /\ a21.[0] = st.[index 2 1] /\
   a41.[3] = st.[index 3 2] /\ a41.[2] = st.[index 1 4] /\ a41.[1] = st.[index 4 1] /\ a41.[0] = st.[index 2 3] /\
   a11.[3] = st.[index 3 3] /\ a11.[2] = st.[index 1 1] /\ a11.[1] = st.[index 4 4] /\ a11.[0] = st.[index 2 2].

lemma dec : forall (x : W32.t),
      0 < to_uint x <= 24 => 
         to_uint (DEC_32 x).`5 = to_uint x - 1.
proof.
  move=> x hx;cbv delta.
  by rewrite W32.to_uintB ?uleE //= /#.
qed.

lemma decK (x : W32.t): (DEC_32 x).`5 + W32.one = x.
proof. rewrite /DEC_32 /= /rflags_of_aluop_nocf32 /= => *; ring. qed.

lemma dec0 (x : W32.t): 0 < to_uint x <= 24 => 
  (DEC_32 x).`4 <=> to_uint (DEC_32 x).`5 = 0.
proof. by move=> hx;cbv delta; rewrite W32.to_uint_eq. qed.

lemma rolcomp (x : W64.t):
  (ROL_64 x W8.one).`3 = (x `>>` W8.of_int 63) `|` (x + x).
proof. 
rewrite ROL_64_E /= rol_xor_shft //= (_: x + x = x `<<` W8.one).
+ by rewrite /(`<<`) W64.to_uint_eq to_uint_shl //= to_uintD //= /#.
rewrite /(`<<`) /(`>>`) /= xorE orE !map2E.
apply W64.init_ext => /> ?; smt (W64.get_out).
qed. 

lemma commor (x y  : W64.t): x `|` y = y `|` x.
proof.  by rewrite orE !map2E; apply W64.init_ext => /> ???; rewrite orbC. qed.

lemma rol0 x: (ROL_64 x W8.zero).`3 = x.
proof. rewrite ROL_64_E rol_xor =>/>; exact/lsr_0. qed.

lemma roln x n: 0 <= n < 64 => 
    (ROL_64 x (W8.of_int n)).`3 =
              (x `>>>` (64 - n)) `|` (x `<<<` n).
move => H.
case (n = 0) => HH. 
+ by rewrite HH rol0 => />; smt(lsr_0). 
rewrite ROL_64_E /= rol_xor_shft /= 1:/#.
rewrite /(`<<`) /(`>>`) => />.
have n256 : n %% 256 = n by smt().
have n64 : n %% 64 = n by smt().
have n64_  : (64 - n) %% 256 = 64 - n by smt().
have n64_m: (64 - n) %% 64 = 64 - n by smt().
rewrite !(n256, n64, n64_, n64_m).
rewrite xorE orE !map2E => />.
apply W64.init_ext => /> ???; smt (W64.get_out).
qed. 

op good_io4x (mem : global_mem_t, _iotas : int) =
    forall off, 0 <= off < 4 * 24 =>
      loadW64 mem (_iotas + (off * 8)) = good_iotas4x.[off].

op good_rhol (mem : global_mem_t, _rhotates_left : int) =
    forall off, 0 <= off < 24 => 
      loadW64 mem (_rhotates_left + (off * 8)) = W64.of_int good_rhotates_left.[off].

op good_rhor (mem : global_mem_t, _rhotates_right : int) =
    forall off, 0 <= off < 24 => 
      loadW64 mem ( _rhotates_right + (off * 8)) = W64.of_int good_rhotates_right.[off].

(* TODO: move this in JMemory *)
lemma loadW256_bits64 m p i : 0 <= i < 4 =>
  loadW256 m p \bits64 i = loadW64 m (p + i * 8).
proof. 
  move=> hi; rewrite /loadW256 /loadW64.
  apply W64.wordP => j hj.
  rewrite bits64iE // pack8wE // initiE; 1:by apply divz_cmp.
  rewrite pack32wE; 1:by apply W4u64.in_bound. 
  rewrite initiE /=; 1:by apply divz_cmp => //=;apply W4u64.in_bound.
  have -> : i * 64 = (i * 8) * 8 by ring. 
  by rewrite modzMDl divzMDl // -addzA. 
qed.

lemma load4u64 mem p : 
  pack4
    [loadW64 mem p;
     loadW64 mem (p + 8);
     loadW64 mem (p + 16);
     loadW64 mem (p + 24)] =
  loadW256 mem p.
proof.
  have -> : W4u64.Pack.of_list
          [loadW64 mem p; loadW64 mem (p + 8);
           loadW64 mem (p + 16); loadW64 mem (p + 24)] =
         W4u64.Pack.init (fun i => loadW64 mem (p + i * 8)).
  + by apply W4u64.Pack.all_eqP; rewrite /all_eq.
  apply (can_inj _ _ W4u64.unpack64K); apply W4u64.Pack.packP => i hi.
  by rewrite pack4K initiE //=  get_unpack64 // loadW256_bits64.
qed.

lemma loadlift_rhor : forall (mem : global_mem_t) (x : W64.t) (off : int),
   to_uint x + 192 < W64.modulus =>
   good_rhor mem (to_uint x) => 0 <= off < 6 =>
     lift2array
          (loadW256 mem (to_uint (x + W64.of_int (8 * 4 * off)))) =
              (witness
                 .[0 <- W64.of_int good_rhotates_right.[4*off + 0]]
                 .[1 <- W64.of_int good_rhotates_right.[4*off + 1]]
                 .[2 <- W64.of_int good_rhotates_right.[4*off + 2]]
                 .[3 <- W64.of_int good_rhotates_right.[4*off + 3]])%Array4.
proof.
  move=> mem x off /= hx hgood hoff.
  rewrite -load4u64 /lift2array; apply Array4.tP => i hi.
  rewrite Array4.initiE 1:// /= W4u64.pack4bE 1:// W4u64.Pack.get_of_list 1://.
  have h32: to_uint (W64.of_int (32 * off)) = 32 * off.
  + by rewrite W64.to_uint_small /= /#.
  have -> : to_uint (x + W64.of_int (32 * off)) = to_uint x + 32 * off.
  + by rewrite W64.to_uintD_small h32 // /#.
  smt (Array4.get_setE).
qed.


(* these are the same as above *)
lemma loadlift_rhol : forall (mem : global_mem_t) (x : W64.t) (off : int),
   to_uint x + 192 < W64.modulus =>
   good_rhol mem (to_uint x) => 0 <= off < 6 =>
     lift2array
          (loadW256 mem (to_uint (x + W64.of_int (8 * 4 * off)))) =
              (witness
                 .[0 <- W64.of_int good_rhotates_left.[4*off + 0]]
                 .[1 <- W64.of_int good_rhotates_left.[4*off + 1]]
                 .[2 <- W64.of_int good_rhotates_left.[4*off + 2]]
                 .[3 <- W64.of_int good_rhotates_left.[4*off + 3]])%Array4.
proof.
  move=> mem x off /= hx hgood hoff.
  rewrite -load4u64 /lift2array; apply Array4.tP => i hi.
  rewrite Array4.initiE 1:// /= W4u64.pack4bE 1:// W4u64.Pack.get_of_list 1://.
  have h32: to_uint (W64.of_int (32 * off)) = 32 * off.
  + by rewrite W64.to_uint_small /= /#.
  have -> : to_uint (x + W64.of_int (32 * off)) = to_uint x + 32 * off.
  + by rewrite W64.to_uintD_small h32 // /#.
  smt (Array4.get_setE).
qed.

lemma loadlift_iotas : forall (mem : global_mem_t) (x : W64.t) (off : int),
   to_uint x + 768 < W64.modulus =>
   good_io4x mem (to_uint x) => 0 <= off < 24 =>
     lift2array
          (loadW256 mem (to_uint (x + W64.of_int (8 * 4 * off)))) =
              (witness
                 .[0 <- good_iotas4x.[off * 4 + 0]]
                 .[1 <- good_iotas4x.[off * 4 + 1]]
                 .[2 <- good_iotas4x.[off * 4 + 2]]
                 .[3 <- good_iotas4x.[off * 4 + 3]])%Array4.
proof.
  move=> mem x off /= hx hgood hoff.
  rewrite -load4u64 /lift2array; apply Array4.tP => i hi.
  rewrite Array4.initiE 1:// /= W4u64.pack4bE 1:// W4u64.Pack.get_of_list 1://.
  have h32: to_uint (W64.of_int (32 * off)) = 32 * off.
  + by rewrite W64.to_uint_small /= /#.
  have -> : to_uint (x + W64.of_int (32 * off)) = to_uint x + 32 * off.
  + by rewrite W64.to_uintD_small h32 // /#.
  have -> : to_uint x + 32 * off + 24 = to_uint x + (4 * off + 3) * 8 by ring.
  have -> : to_uint x + 32 * off + 16 = to_uint x + (4 * off + 2) * 8 by ring.
  have -> : to_uint x + 32 * off + 8 = to_uint x + (4 * off + 1) * 8 by ring.
  have -> : 32 * off = (4 * off) * 8 by ring. 
  move : (hgood (off * 4 + i) _) => />.  smt(@W64). smt (Array4.get_setE).
qed.

op conversion(o1 o2 : int) : int = 
  let (x,y) = 
   ((witness
     .[0 <-  (2,0)]
     .[1 <-  (4,0)]
     .[2 <-  (1,0)]
     .[3 <-  (3,0)]
     .[4 <-  (0,1)]
     .[5 <-  (0,2)]
     .[6 <-  (0,3)]
     .[7 <-  (0,4)]
     .[8 <-  (3,1)]
     .[9 <-  (1,2)]
     .[10 <- (4,3)]
     .[11 <- (2,4)]
     .[12 <- (2,1)]
     .[13 <- (4,2)]
     .[14 <- (1,3)]
     .[15 <- (3,4)]
     .[16 <- (4,1)]
     .[17 <- (3,2)]
     .[18 <- (2,3)]
     .[19 <- (1,4)]
     .[20 <- (1,1)]
     .[21 <- (2,2)]
     .[22 <- (3,3)]
     .[23 <- (4,4)])%Array24).[o1*4 + o2] in (5*x + y).

lemma lift_roln mem rl rr o1 o2 x:
   W64.to_uint rl + 192 < W64.modulus =>
   W64.to_uint rr + 192 < W64.modulus =>
   0 <= o1 < 6 => 0 <= o2 < 4 =>
   good_rhol mem (W64.to_uint rl) => 
   good_rhor mem (W64.to_uint rr) =>
  (x `>>>`
   (to_uint
       (lift2array
          (loadW256 mem
             (to_uint (rr + W64.of_int 96 + W64.of_int (8 * 4 * o1 - 96))))).[o2]))%W64 `|`
  (x `<<<`
    (to_uint
       (lift2array
          (loadW256 mem
             (to_uint (rl + W64.of_int 96 + W64.of_int (8 * 4 * o1 - 96))))).[o2]))%W64
    = (ROL_64 x ((of_int (rhotates (conversion o1 o2))))%W8).`3.
proof.
move => hl192 hr192 ho1 ho2 hgl hgr.
rewrite (loadlift_rhol mem (rl) o1 hl192) 1,2://. 
rewrite (loadlift_rhor mem (rr) o1 hr192) 1,2://. 
rewrite /good_rhotates_right /good_rhotates_left /rhotates /conversion; cbv delta.
move: ho1 ho2 => /(mema_iota 0 6) ho1 /(mema_iota 0 4).
by move: ho1 => /= [#|]  -> [#|] ->; cbv delta; rewrite roln.
qed.

lemma correct_perm _a00 _a01 _a20 _a31 _a21 _a41 _a11 st mem:
    equiv [ Mreftable.__keccakf1600_ref ~ Mavx2_prevec.__keccakf1600_avx2_openssl :
         to_uint _rhotates_left{2} + 192 < W64.modulus /\
         to_uint _rhotates_right{2} + 192 < W64.modulus /\
         to_uint _iotas{2} + 768 < W64.modulus /\
         Glob.mem{2} = mem /\ good_io4x mem (to_uint _iotas{2}) /\ 
         good_rhol mem (to_uint _rhotates_left{2}) /\ good_rhor mem (to_uint _rhotates_right{2}) /\
         equiv_states _a00 _a01 _a20 _a31 _a21 _a41 _a11 st /\
         a00{2} = _a00 /\ a01{2} = _a01 /\ a20{2} = _a20 /\ a31{2} = _a31 /\
          a21{2} = _a21 /\ a41{2} = _a41 /\ a11{2} = _a11 /\  state{1} = st ==> 
           Glob.mem{2} = mem /\
           equiv_states res{2}.`1 res{2}.`2 res{2}.`3 res{2}.`4 res{2}.`5 res{2}.`6 res{2}.`7 res{1}].
proof.
proc.
unroll {1} 3.
rcondt {1} 3; first by move => *; inline *; auto => />.

seq 0 1 : #pre; first by auto => />.
inline Mreftable.keccakRoundConstants.
sp 2 4.

seq 1 105 : (#{/~a00{2}}{~a01{2}}{~a20{2}}{~a31{2}}{~a21{2}}{~a41{2}}{~a11{2}}{~state{1}}pre /\ Glob.mem{2} = mem /\
             good_io4x mem (to_uint _iotas{2}) /\
             good_rhol mem (to_uint _rhotates_left{2}) /\
             good_rhor mem (to_uint _rhotates_right{2}) /\
             to_uint _rhotates_left{2} + 192 < W64.modulus /\
             to_uint _rhotates_right{2} + 192 < W64.modulus /\
             to_uint _iotas{2} + 768 < W64.modulus /\
             equiv_states a00{2} a01{2} a20{2} a31{2} a21{2} a41{2} a11{2}  state{1}).

seq 0 0 : (#pre /\ (constants{1}.[round{1}])%Array24 = W64.of_int 1). 
by auto => />; rewrite /iotas;smt().

inline Mreftable.keccakP1600_round.

sp 2 0.
inline Mreftable.theta.
sp 1 0.

swap {2} [20..21] 3.
swap {2} 28 -3.
swap {2} 32 -6.
swap {2} 36 -9.
swap {2} 40 -12.
swap {2} 46 -17.

seq 9 29 :  (#{/~state{1}}post /\ c{1} = W64.of_int 1 /\
             equiv_states a00{2} a01{2} a20{2} a31{2} a21{2} a41{2} a11{2}  state0{1}).
+ conseq />.
  do 13!(unroll for {1} ^while).
  inline *. wp;skip => &1 &2 [#] 9!->>. 
  move=> ??? ->> ???? 7!<<- ->> h.
  cbv int_bit index W8.int_bit.
  by smt(W64.xorwA W64.xorwC W64.xorw0 W64.xorwK rolcomp commor).

(* Rho PI *)
inline Mreftable.rho Mreftable.pi.

seq 11 22 :  (#{/~ state{1}}post  /\ c{1} = W64.of_int 1 /\
     equiv_states_chi a00{2} t{2}.[1] t{2}.[2] t{2}.[3] t{2}.[4] t{2}.[5] t{2}.[6] state0{1}).
conseq />.
do 13!(unroll for {1} ^while).
inline *; wp; skip => &1 &2 [#] 7!->> 8? ->> ?.
cbv index rhotates.
split; first by smt(rol0). 
split; first by smt(rol0).
split; first by smt(rol0).
split; first by smt(rol0).
split.
+ have /= -> := lift_roln _ _ _ 5 3 a11{2}.[3] H4 H5 _ _ H2 H3; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 5 2 a11{2}.[2] H4 H5 _ _ H2 H3; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 5 1 a11{2}.[1] H4 H5 _ _ H2 H3; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 5 0 a11{2}.[0] H4 H5 _ _ H2 H3; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 1 3 a01{2}.[3] H4 H5 _ _ H2 H3; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 1 2 a01{2}.[2] H4 H5 _ _ H2 H3; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 1 1 a01{2}.[1] H4 H5 _ _ H2 H3; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 1 0 a01{2}.[0] H4 H5 _ _ H2 H3; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 0 2 a20{2}.[2] H4 H5 _ _ H2 H3; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 0 0 a20{2}.[0] H4 H5 _ _ H2 H3; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 0 3 a20{2}.[3] H4 H5 _ _ H2 H3; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 0 1 a20{2}.[1] H4 H5 _ _ H2 H3; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 2 2 a31{2}.[2] H4 H5 _ _ H2 H3; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 2 0 a31{2}.[0] H4 H5 _ _ H2 H3; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 2 3 a31{2}.[3] H4 H5 _ _ H2 H3; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 2 1 a31{2}.[1] H4 H5 _ _ H2 H3; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 3 0 a21{2}.[0] H4 H5 _ _ H2 H3; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 3 1 a21{2}.[1] H4 H5 _ _ H2 H3; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 3 2 a21{2}.[2] H4 H5 _ _ H2 H3; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 3 3 a21{2}.[3] H4 H5 _ _ H2 H3; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 4 1 a41{2}.[1] H4 H5 _ _ H2 H3; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 4 3 a41{2}.[3] H4 H5 _ _ H2 H3; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 4 0 a41{2}.[0] H4 H5 _ _ H2 H3; 1,2: done; cbv delta; smt().
have /= -> := lift_roln _ _ _ 4 2 a41{2}.[2] H4 H5 _ _ H2 H3; 1,2: done; cbv delta; smt().

(* Chi *)
inline Mreftable.chi.
conseq />.
seq 5 53 : (#{~state0{1}}pre /\
               equiv_states a00{2} a01{2} a20{2} a31{2} a21{2} a41{2} a11{2}  state0{1}).
+ conseq />.
  do 11!(unroll for {1} ^while).
  inline *; wp; skip => &1 &2 [#] 7!->> 8? ->> ?.
  cbv delta.
  smt (W64.xorwC W64.andwC).

inline *; wp;skip => &1 &2 [#] 7!->> 8? ->> ?.
cbv index.
have /= -> /= := loadlift_iotas _ _ 0 H6 H1 _; 1:done.
rewrite /good_iotas4x /= /#.

seq 1 2 : (#{/~iotas{2}}{~round{1}}{~i{2}}{~st}pre /\
               iotas{2} = _iotas{2} + W64.of_int (round{1} * 32) /\
               to_uint i{2} = 24 - round{1} /\
               ((to_uint i{2} = 0) <> round{1} < 24) /\
               (DEC_32 (i{2} + W32.of_int 1)).`4 = zf{2} /\
               0 < round{1} /\ 
               to_uint i{2} <= 24 /\
               constants{1} = Keccakf1600_pref_op.iotas).
+ auto => /> *.
  by rewrite dec 1:// /= decK.

while (#pre).

inline Mreftable.keccakP1600_round.


sp 2 0.
inline Mreftable.theta.
sp 1 0.

swap {2} [20..21] 3.
swap {2} 28 -3.
swap {2} 32 -6.
swap {2} 36 -9.
swap {2} 40 -12.
swap {2} 46 -17.

seq 9 29 :  (#{/~state{1}}post /\ c{1} = constants{1}.[round{1}] /\ round{1} < 24 /\
             equiv_states a00{2} a01{2} a20{2} a31{2} a21{2} a41{2} a11{2}  state0{1}).
+ conseq />.
  do 13!(unroll for {1} ^while).
  inline *; wp;skip.
  move => &1 &2 [#] 7!->> 8? ->> ?? <<- ?????.
  cbv delta.
  rewrite !rolcomp /(`>>`) /=.
  smt(W64.xorwA W64.xorwC W64.xorw0 W64.xorwK commor).

(* Rho PI *)
inline Mreftable.rho Mreftable.pi.
seq 11 22 :  (#{/~ state{1}}post  /\ c{1} = constants{1}.[round{1}] /\ round{1} < 24 /\
     equiv_states_chi a00{2} t{2}.[1] t{2}.[2] t{2}.[3] t{2}.[4] t{2}.[5] t{2}.[6] state0{1}).
conseq />.
do 13!(unroll for {1} ^while).
inline *; wp;skip.
move => &1 &2 [#] 4!->> _ ?????? ->> ?? <<- ???? ->> ??.
cbv index rhotates.
split; first by smt(rol0). 
split; first by smt(rol0).
split; first by smt(rol0).
split; first by smt(rol0).
split.
+ have /= -> := lift_roln _ _ _ 5 3 a11{2}.[3] H2 H3 _ _ H0 H1; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 5 2 a11{2}.[2] H2 H3 _ _ H0 H1; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 5 1 a11{2}.[1] H2 H3 _ _ H0 H1; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 5 0 a11{2}.[0] H2 H3 _ _ H0 H1; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 1 3 a01{2}.[3] H2 H3 _ _ H0 H1; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 1 2 a01{2}.[2] H2 H3 _ _ H0 H1; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 1 1 a01{2}.[1] H2 H3 _ _ H0 H1; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 1 0 a01{2}.[0] H2 H3 _ _ H0 H1; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 0 2 a20{2}.[2] H2 H3 _ _ H0 H1; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 0 0 a20{2}.[0] H2 H3 _ _ H0 H1; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 0 3 a20{2}.[3] H2 H3 _ _ H0 H1; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 0 1 a20{2}.[1] H2 H3 _ _ H0 H1; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 2 2 a31{2}.[2] H2 H3 _ _ H0 H1; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 2 0 a31{2}.[0] H2 H3 _ _ H0 H1; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 2 3 a31{2}.[3] H2 H3 _ _ H0 H1; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 2 1 a31{2}.[1] H2 H3 _ _ H0 H1; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 3 0 a21{2}.[0] H2 H3 _ _ H0 H1; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 3 1 a21{2}.[1] H2 H3 _ _ H0 H1; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 3 2 a21{2}.[2] H2 H3 _ _ H0 H1; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 3 3 a21{2}.[3] H2 H3 _ _ H0 H1; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 4 1 a41{2}.[1] H2 H3 _ _ H0 H1; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 4 3 a41{2}.[3] H2 H3 _ _ H0 H1; 1,2: done; cbv delta; smt().
split.
+ have /= -> := lift_roln _ _ _ 4 0 a41{2}.[0] H2 H3 _ _ H0 H1; 1,2: done; cbv delta; smt().
have /= -> := lift_roln _ _ _ 4 2 a41{2}.[2] H2 H3 _ _ H0 H1; 1,2: done; cbv delta; smt().

(* Chi *)
inline Mreftable.chi.
seq 5 53 : (#{~state0{1}}pre /\
               equiv_states a00{2} a01{2} a20{2} a31{2} a21{2} a41{2} a11{2}  state0{1}).
conseq />.
do 11!(unroll for {1} ^while).
inline *; wp; skip => &1 &2 [#] 4!->> ???? ??? ->> ?? <<- ???? ->> ??.
cbv delta.
smt (W64.xorwC W64.andwC).

(* iota *)

seq 2 1 : (#{/~ state0{1}}pre /\
    equiv_states a00{2} a01{2} a20{2} a31{2} a21{2} a41{2} a11{2}
    state{1}).
conseq />.
inline *; wp; skip => &1 &2 [#] 4!->> ???? ??? ->> ?? <<- ???? ->> ??.
cbv.
have -> : round{1} * 32 = 8*4*round{1}; 1: ring.
have -> /= := loadlift_iotas _ _ (round{1}) H5 H0; 1: smt().
cbv index.
have -> : good_iotas4x.[round{1} * 4 + 3] = iotas.[round{1}].
+ have : 1 <= round{1} < 24 by smt().
  by move /(mema_iota 1 23) => /> [#|] ->; cbv delta.
have -> : good_iotas4x.[round{1} * 4 + 2] = iotas.[round{1}].
+ have : 1 <= round{1} < 24 by smt().
  by move /(mema_iota 1 23) => /> [#|] ->; cbv delta.
have -> : good_iotas4x.[round{1} * 4 + 1] = iotas.[round{1}].
+ have : 1 <= round{1} < 24 by smt().
  by move /(mema_iota 1 23) => /> [#|] ->; cbv delta.
have -> : good_iotas4x.[round{1} * 4] = iotas.[round{1}].
+ have : 1 <= round{1} < 24 by smt().
  by move /(mema_iota 1 23) => /> [#|] ->; cbv delta.
smt().

conseq />.
wp;skip => />; smt(dec dec0 decK).

skip => |> *.
rewrite dec0 1:to_uintD_small /= 1,2:/# dec to_uintD_small /= /#.
qed.

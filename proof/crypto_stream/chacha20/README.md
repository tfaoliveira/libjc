# ChaCha20 : Equivalence proof between AVX2 from proof/ and src/
We can start by the initialization functions:

* `init_x2`
* `init_x8`

So, we need to prove that the execution of the function `src/init_x2` is equivalent to the `proof/init_x2`. The code of `src/init_x2`
is:

```C
fn init_x2(reg u64 key nonce, reg u32 counter) -> reg u256[4]
{
  reg u256[4] st;
  reg u128 nc;
  stack u128 s_nc;

  nc = g_p0;
  nc = #x86_VPINSR_4u32(nc, counter, 0);
  nc = #x86_VPINSR_4u32(nc, (u32)[nonce + 0], 1);
  nc = #x86_VPINSR_2u64(nc, (u64)[nonce + 4], 1);
  s_nc = nc;

  st[0] = #x86_VPBROADCAST_2u128(g_sigma);
  st[1] = #x86_VPBROADCAST_2u128((u128)[key + 0]);
  st[2] = #x86_VPBROADCAST_2u128((u128)[key + 16]);
  st[3] = #x86_VPBROADCAST_2u128(s_nc);
  st[3] +8u32= g_p1;

  return st;
}
```

And the code from `proof/init_x2` is:

```C
fn init_x2(reg u64 key nonce, reg u32 counter) -> reg u32[16], reg u32[16]
{
  reg u32[16] st_1 st_2;
  st_1 = init(key, nonce, counter); counter += 1;
  st_2 = init(key, nonce, counter);
  return st_1, st_2;
}
```

Where `init` is the reference initialization function. From here onwards `S1` refers to `src` implementation and `P1` to the `proof` implementation. The goal is to prove that `S1.st <=> P1{st_1,st_2}`. Sigma variables are initialized as follows:

```C
u32  g_sigma0   = 0x61707865;
u32  g_sigma1   = 0x3320646e;
u32  g_sigma2   = 0x79622d32;
u32  g_sigma3   = 0x6b206574;
u128 g_sigma    = 0x6b20657479622d323320646e61707865;
```

The layout of `S1.st` is the following:

```C
S1.st
0: 2u128 [ sigma          , sigma          ]
1: 2u128 [ (u128)[k + 0 ] , (u128)[k + 0]  ]
2: 2u128 [ (u128)[k + 16] , (u128)[k + 16] ]
3: 8u32  [ (u32)[n + 8]   , (u32)[n + 4], (u32)[n + 0] , (counter+1),
           (u32)[n + 8]   , (u32)[n + 4], (u32)[n + 0] , counter    ]
```

And `P1.{st_1, st_2}`:
```C
P1.st_2             P1.st_1
 0: sigma0          0: sigma0
 1: sigma1          1: sigma1
 2: sigma2          2: sigma2
 3: sigma3          3: sigma3
 4: (u32)[k + 0]    4: (u32)[k + 0]
    ...
11: (u32)[k + 28]  11: (u32)[k + 28]
12: counter+1      12: counter
13: (u32)[n + 0]   13: (u32)[n + 0]
14: (u32)[n + 4]   14: (u32)[n + 4]
15: (u32)[n + 8]   15: (u32)[n + 8]
```

Although the organization in memory/registers is different between the two representations it's easy to write a function that transforms `P1.{st_1,st_2}` into `S1.st`. This function can be defined as follows (check file relational_invariant.jazz; just for `eval` purposes):

```C
fn p1_to_s1(reg u32[16] st_1 st_2) -> reg u256[4]
{
  inline int i;
  reg u256[4] st;

  for i=0 to 4
  { st[i] = 0;
    st[i] = #x86_VINSERTI128(st[i], st_1[u128 i], 0);
    st[i] = #x86_VINSERTI128(st[i], st_2[u128 i], 1);
  }

  return st;
}
```










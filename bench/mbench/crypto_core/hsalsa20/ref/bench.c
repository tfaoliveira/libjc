#define BENCH_WARM 255
#define BENCH_LOOPS 3
#define BENCH_CYCLES (16384*128)

/*export fn hsalsa20_ref(reg u64 _subkey _nonce _key _sigma)*/
/*  CRYPTO_OUTPUTBYTES 32*/
/*  CRYPTO_INPUTBYTES 16*/
/*  CRYPTO_KEYBYTES 32*/
/*  CRYPTO_CONSTBYTES 16*/

#define BENCH_FVARS_DEC uint8_t subkey[32],nonce[16],key[32],sigma[16];
#define BENCH_FTYPE void
#define BENCH_FNAME hsalsa20_ref
#define BENCH_FARGS_DEC uint8_t*,uint8_t*,uint8_t*,uint8_t*
#define BENCH_FVARS_CALL subkey,nonce,key,sigma

#include "mbench.c"



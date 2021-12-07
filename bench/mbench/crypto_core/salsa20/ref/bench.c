#define BENCH_WARM 255
#define BENCH_LOOPS 3
#define BENCH_CYCLES (16384*128)

/*export fn hsalsa20_ref(reg u64 _state _nonce _key _sigma)*/
/*  CRYPTO_OUTPUTBYTES 64*/
/*  CRYPTO_INPUTBYTES 16*/
/*  CRYPTO_KEYBYTES 32*/
/*  CRYPTO_CONSTBYTES 16*/

#define BENCH_FVARS_DEC uint8_t state[64],nonce[16],key[32],sigma[16];
#define BENCH_FTYPE void
#define BENCH_FNAME salsa20_ref
#define BENCH_FARGS_DEC uint8_t*,uint8_t*,uint8_t*,uint8_t*
#define BENCH_FVARS_CALL state,nonce,key,sigma

#include "mbench.c"



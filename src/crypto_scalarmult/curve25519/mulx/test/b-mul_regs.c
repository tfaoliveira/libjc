#define BENCH_CYCLES (16384*96+1)
#define BENCH_FVARS_DEC uint64_t h[4]; uint64_t f[4]; uint64_t g[4];
#define BENCH_FTYPE void
#define BENCH_FNAME fe64_mul_regs
#define BENCH_FARGS_DEC uint64_t*,uint64_t*,uint64_t*
#define BENCH_FVARS_CALL h,f,g

#include "mbench.c"

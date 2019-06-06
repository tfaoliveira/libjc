#define BENCH_CYCLES 16383
#define BENCH_FVARS_DEC uint64_t h[4]; uint64_t f[4];
#define BENCH_FTYPE void
#define BENCH_FNAME fe64_invert
#define BENCH_FARGS_DEC uint64_t*,uint64_t*
#define BENCH_FVARS_CALL h,f

#include "mbench.c"

#include <stdint.h>

#undef force_inline
#define force_inline __attribute__((always_inline))

static force_inline void fesquare(uint64_t* out, uint64_t x7, uint64_t x8, uint64_t x6, uint64_t x4, uint64_t x2);

#include "crypto_hash.h"
#include "impl.h"
#include "api.h"
#include <string.h>
#include <stdint.h>

extern void shake256_avx2_jazz(
         uint8_t *out,
  const  uint8_t *in,
          size_t inlen,
        uint64_t **m
);

uint64_t rhotates_left[6*4] __attribute__((aligned(32))) = {
     3,   18,    36,    41,
     1,   62,    28,    27,
    45,    6,    56,    39,
    10,   61,    55,     8,
     2,   15,    25,    20,
    44,   43,    21,    14 };


uint64_t rhotates_right[6*4] __attribute__((aligned(32))) = {
    64-3,  64-18,  64-36,  64-41,
    64-1,  64-62,  64-28,  64-27,
    64-45, 64-6,   64-56,  64-39,
    64-10, 64-61,  64-55,  64-8,
    64-2,  64-15,  64-25,  64-20,
    64-44, 64-43,  64-21,  64-14 };

uint64_t iotas[24*4] __attribute__((aligned(32))) = {
    0x0000000000000001UL, 0x0000000000000001UL, 0x0000000000000001UL, 0x0000000000000001UL,
    0x0000000000008082UL, 0x0000000000008082UL, 0x0000000000008082UL, 0x0000000000008082UL,
    0x800000000000808aUL, 0x800000000000808aUL, 0x800000000000808aUL, 0x800000000000808aUL,
    0x8000000080008000UL, 0x8000000080008000UL, 0x8000000080008000UL, 0x8000000080008000UL,
    0x000000000000808bUL, 0x000000000000808bUL, 0x000000000000808bUL, 0x000000000000808bUL,
    0x0000000080000001UL, 0x0000000080000001UL, 0x0000000080000001UL, 0x0000000080000001UL,
    0x8000000080008081UL, 0x8000000080008081UL, 0x8000000080008081UL, 0x8000000080008081UL,
    0x8000000000008009UL, 0x8000000000008009UL, 0x8000000000008009UL, 0x8000000000008009UL,
    0x000000000000008aUL, 0x000000000000008aUL, 0x000000000000008aUL, 0x000000000000008aUL,
    0x0000000000000088UL, 0x0000000000000088UL, 0x0000000000000088UL, 0x0000000000000088UL,
    0x0000000080008009UL, 0x0000000080008009UL, 0x0000000080008009UL, 0x0000000080008009UL,
    0x000000008000000aUL, 0x000000008000000aUL, 0x000000008000000aUL, 0x000000008000000aUL,
    0x000000008000808bUL, 0x000000008000808bUL, 0x000000008000808bUL, 0x000000008000808bUL,
    0x800000000000008bUL, 0x800000000000008bUL, 0x800000000000008bUL, 0x800000000000008bUL,
    0x8000000000008089UL, 0x8000000000008089UL, 0x8000000000008089UL, 0x8000000000008089UL,
    0x8000000000008003UL, 0x8000000000008003UL, 0x8000000000008003UL, 0x8000000000008003UL,
    0x8000000000008002UL, 0x8000000000008002UL, 0x8000000000008002UL, 0x8000000000008002UL,
    0x8000000000000080UL, 0x8000000000000080UL, 0x8000000000000080UL, 0x8000000000000080UL,
    0x000000000000800aUL, 0x000000000000800aUL, 0x000000000000800aUL, 0x000000000000800aUL,
    0x800000008000000aUL, 0x800000008000000aUL, 0x800000008000000aUL, 0x800000008000000aUL,
    0x8000000080008081UL, 0x8000000080008081UL, 0x8000000080008081UL, 0x8000000080008081UL,
    0x8000000000008080UL, 0x8000000000008080UL, 0x8000000000008080UL, 0x8000000000008080UL,
    0x0000000080000001UL, 0x0000000080000001UL, 0x0000000080000001UL, 0x0000000080000001UL,
    0x8000000080008008UL, 0x8000000080008008UL, 0x8000000080008008UL, 0x8000000080008008UL };

int shake256_avx2(unsigned char *out,const unsigned char *in,unsigned long long inlen)
{
  uint64_t state[28] __attribute__((aligned(32)));
  memset(state, 0, sizeof(state));
  uint64_t *m[4] = {state, rhotates_left, rhotates_right, iotas};
  shake256_avx2_jazz(out, in, inlen, m);
  return 0;
}



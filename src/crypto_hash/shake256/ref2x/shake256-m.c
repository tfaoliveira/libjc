#include "crypto_hash.h"
#include "impl.h"
#include "api.h"
#include <string.h>
#include <stdint.h>

extern void shake256_ref2x_jazz(
         uint8_t *out,
  const  uint8_t *in,
          size_t inlen,
  const uint64_t *iotas,
        uint64_t *m
);

uint64_t iotas[32] __attribute__((aligned(256))) = 
{
       0,0,0,0,0,0,0, 0
   , 0x0000000000000001
   , 0x0000000000008082
   , 0x800000000000808a
   , 0x8000000080008000
   , 0x000000000000808b
   , 0x0000000080000001
   , 0x8000000080008081
   , 0x8000000000008009
   , 0x000000000000008a
   , 0x0000000000000088
   , 0x0000000080008009
   , 0x000000008000000a
   , 0x000000008000808b
   , 0x800000000000008b
   , 0x8000000000008089
   , 0x8000000000008003
   , 0x8000000000008002
   , 0x8000000000000080
   , 0x000000000000800a
   , 0x800000008000000a
   , 0x8000000080008081
   , 0x8000000000008080
   , 0x0000000080000001
   , 0x8000000080008008
};

int shake256_ref2x(unsigned char *out,const unsigned char *in,unsigned long long inlen)
{
  uint64_t m[50] __attribute__((aligned(32)));
  shake256_ref2x_jazz(out, in, inlen, &(iotas[8]), m);
  return 0;
}


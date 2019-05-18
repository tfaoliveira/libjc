#include "crypto_hash.h"
#include "api.h"
#include <string.h>
#include <stdint.h>

extern void
Hacl_SHA3_sha3_384(
  uint32_t inputByteLen,
  uint8_t *input,
  uint8_t *output
);

int crypto_hash(unsigned char *out,const unsigned char *in,unsigned long long inlen)
{
  Hacl_SHA3_sha3_384((uint32_t)inlen, in, out);
  return 0;
}

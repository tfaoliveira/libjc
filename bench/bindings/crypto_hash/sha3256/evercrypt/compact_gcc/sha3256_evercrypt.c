#include "crypto_hash.h"
#include "api.h"
#include <string.h>
#include <stdint.h>

extern void
Hacl_SHA3_sha3_256(
  uint32_t inputByteLen,
  uint8_t *input,
  uint8_t *output
);

int crypto_hash(unsigned char *out,const unsigned char *in,unsigned long long inlen)
{
  evercrypt_compact_gcc_Hacl_SHA3_sha3_256((uint32_t)inlen, in, out);
  return 0;
}

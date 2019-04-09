#include "crypto_hash.h"
#include "impl.h"
#include "api.h"
#include <string.h>
#include <stdint.h>

extern void shake256_impl(
  const unsigned char *in,
  unsigned long long inlen,
  unsigned char *out,
  unsigned long long outlen
);

int crypto_hash(unsigned char *out,const unsigned char *in,unsigned long long inlen)
{
  unsigned char out__[CRYPTO_BYTES];
  shake256_impl(in, inlen<<3, out__, CRYPTO_BYTES<<3);
  memcpy(out, out__, CRYPTO_BYTES);
  return 0;
}

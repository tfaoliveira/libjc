#include <string.h>

#include "crypto_hash.h"
#include "impl.h"
#include "api.h"

extern void shake256_impl(
  unsigned char *out,
  const unsigned char *in,
  unsigned long long inlen
);

int crypto_hash(unsigned char *out,const unsigned char *in,unsigned long long inlen)
{
  unsigned char out__[CRYPTO_BYTES];
  shake256_impl(out__, in, inlen);
  memcpy(out, out__, CRYPTO_BYTES);
  return 0;
}

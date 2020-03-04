#include <string.h>

#include "crypto_hash.h"
#include "impl.h"
#include "api.h"

extern void sha256_impl(
  unsigned char *out,
  const unsigned char *in,
  unsigned long long inlen,
  unsigned char *padded
);

int crypto_hash(unsigned char *out,const unsigned char *in,unsigned long long inlen)
{
  unsigned char out__[CRYPTO_BYTES];
  unsigned char padded[128];
  sha256_impl(out__, in, inlen, padded);
  memcpy(out, out__, CRYPTO_BYTES);
  return 0;
}

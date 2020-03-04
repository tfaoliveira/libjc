#include <string.h>

#include "crypto_hashblocks_sha256.h"
#include "crypto_auth.h"

#include "impl.h"
#include "api.h"

extern void hmacsha256_impl(
  unsigned char *out,
  const unsigned char *in,
  unsigned long long inlen,
  const unsigned char *k,
  unsigned char *padded
);

int crypto_auth(unsigned char *out,const unsigned char *in,unsigned long long inlen,const unsigned char *k)
{
  unsigned char out__[CRYPTO_BYTES];
  unsigned char padded[128];
  hmacsha256_impl(out__, in, inlen, k, padded);
  memcpy(out, out__, CRYPTO_BYTES);
  return 0;
}

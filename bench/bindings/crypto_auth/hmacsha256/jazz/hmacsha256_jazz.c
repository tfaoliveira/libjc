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
  unsigned long long klen,
  unsigned char *kpadded
);

int crypto_auth(unsigned char *out,const unsigned char *in,unsigned long long inlen,const unsigned char *k)
{
  unsigned char hkpadded[32+128];
  hmacsha256_impl(out, in, inlen, k, 32, hkpadded);
  return 0;
}

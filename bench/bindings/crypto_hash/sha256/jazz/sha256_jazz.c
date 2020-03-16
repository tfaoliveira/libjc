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
  unsigned char padded[128];
  sha256_impl(out, in, inlen, padded);
  return 0;
}

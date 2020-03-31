#include <string.h>

#include "crypto_hash.h"
#include "impl.h"
#include "api.h"

extern void sha512_impl(
  unsigned char *out,
  const unsigned char *in,
  unsigned long long inlen,
  unsigned char *padded
);

int crypto_hash(unsigned char *out,const unsigned char *in,unsigned long long inlen)
{
  unsigned char padded[256];
  sha512_impl(out, in, inlen, padded);
  return 0;
}

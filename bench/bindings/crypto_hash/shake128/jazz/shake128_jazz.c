#include <string.h>

#include "crypto_hash.h"
#include "impl.h"
#include "api.h"

extern void shake128_impl(
  unsigned char *out,
  unsigned long long outlen,
  const unsigned char *in,
  unsigned long long inlen
);

int crypto_hash(unsigned char *out,const unsigned char *in,unsigned long long inlen)
{
  shake128_impl(out, CRYPTO_BYTES, in, inlen);
  return 0;
}

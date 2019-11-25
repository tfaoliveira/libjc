#include "crypto_onetimeauth.h"

int crypto_onetimeauth(
  unsigned char *out,
  const unsigned char *in,
  unsigned long long inlen,
  const unsigned char *k
)
{
  hacl_star_ccomp_Poly1305_64_crypto_onetimeauth(out, in, inlen, k);
  return 0;
}

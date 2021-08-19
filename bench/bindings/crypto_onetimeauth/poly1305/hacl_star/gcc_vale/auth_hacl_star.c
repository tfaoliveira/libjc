#include "crypto_onetimeauth.h"

int crypto_onetimeauth(
  unsigned char *out,
  const unsigned char *in,
  unsigned long long inlen,
  const unsigned char *k
)
{
  hacl_star_gcc_vale_EverCrypt_Poly1305_poly1305_vale(out, in, inlen, k);
  return 0;
}



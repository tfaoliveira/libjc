#include "crypto_onetimeauth.h"
#include <stddef.h>

#include "poly1305.h"
#include "poly1305_local.h"

int crypto_onetimeauth(
  unsigned char *out,
  const unsigned char *in,
  unsigned long long inlen,
  const unsigned char *k
)
{
  POLY1305 poly1305;
  openssl_static_Poly1305_Init(&poly1305, k);
  openssl_static_Poly1305_Update(&poly1305, in, inlen);
  openssl_static_Poly1305_Final(&poly1305, out);
  return 0;
}

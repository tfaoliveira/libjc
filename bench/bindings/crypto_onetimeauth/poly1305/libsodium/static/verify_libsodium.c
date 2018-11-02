#include "crypto_verify_16.h"
#include "crypto_onetimeauth.h"

int crypto_onetimeauth_verify(
  const unsigned char *h,
  const unsigned char *in,
  unsigned long long inlen,
  const unsigned char *k
)
{
  libsodium_static_sodium_init();
  return libsodium_static_crypto_onetimeauth_poly1305_verify(h, in, inlen, k);
}

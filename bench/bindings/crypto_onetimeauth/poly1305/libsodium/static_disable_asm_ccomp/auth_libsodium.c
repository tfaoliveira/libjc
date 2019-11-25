#include "crypto_onetimeauth.h"
#include <stddef.h>

int crypto_onetimeauth(
  unsigned char *out,
  const unsigned char *in,
  unsigned long long inlen,
  const unsigned char *k
)
{
  libsodium_static_disable_asm_ccomp_sodium_init();
  libsodium_static_disable_asm_ccomp_crypto_onetimeauth_poly1305(out, in, inlen, k);
  return 0;
}



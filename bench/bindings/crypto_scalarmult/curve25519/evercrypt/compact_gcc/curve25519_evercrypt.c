#include "crypto_scalarmult.h"

int crypto_scalarmult(
  unsigned char *q,
  const unsigned char *n,
  const unsigned char *p
)
{
  evercrypt_compact_gcc_EverCrypt_Curve25519_ecdh(q,n,p);
  return 0;
}

int crypto_scalarmult_base(
  unsigned char *q,
  const unsigned char *n
)
{
  evercrypt_compact_gcc_EverCrypt_Curve25519_secret_to_public(q,n);
  return 0;
}

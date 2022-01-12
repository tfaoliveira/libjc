#include "crypto_scalarmult.h"

extern int boringssl_static_X25519(
  unsigned char *q,
  const unsigned char *n,
  const unsigned char *p
);

extern int boringssl_static_X25519_public_from_private(
  unsigned char *q,
  const unsigned char *n
);

int crypto_scalarmult(
  unsigned char *q,
  const unsigned char *n,
  const unsigned char *p
)
{
  int r;
  r = boringssl_static_X25519(q,n,p);
  return 0;
}

int crypto_scalarmult_base(
  unsigned char *q,
  const unsigned char *n
)
{
  int r;
  r = boringssl_static_X25519_public_from_private(q,n);
  return 0;
}

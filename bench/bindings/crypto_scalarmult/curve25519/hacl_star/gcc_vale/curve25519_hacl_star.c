#include "crypto_scalarmult.h"

extern int hacl_star_gcc_vale_Hacl_Curve25519_64_scalarmult(
  unsigned char *q,
  const unsigned char *n,
  const unsigned char *p
);

extern int hacl_star_gcc_vale_Hacl_Curve25519_64_secret_to_public(
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
  r = hacl_star_gcc_vale_Hacl_Curve25519_64_scalarmult(q,n,p);
  return 0;
}

int crypto_scalarmult_base(
  unsigned char *q,
  const unsigned char *n
)
{
  int r;
  r = hacl_star_gcc_vale_Hacl_Curve25519_64_secret_to_public(q,n);
  return 0;
}

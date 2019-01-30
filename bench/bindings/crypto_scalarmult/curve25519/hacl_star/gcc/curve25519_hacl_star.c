#include "crypto_scalarmult.h"

extern int hacl_star_gcc_Hacl_Curve25519_crypto_scalarmult(
  unsigned char *q,
  const unsigned char *n,
  const unsigned char *p
);

static const unsigned char basepoint[32] = {9};

int crypto_scalarmult(
  unsigned char *q,
  const unsigned char *n,
  const unsigned char *p
)
{
  int r;
  r = hacl_star_gcc_Hacl_Curve25519_crypto_scalarmult(q,n,p);
  return 0;
}

int crypto_scalarmult_base(
  unsigned char *q,
  const unsigned char *n
)
{
  int r;
  r = crypto_scalarmult(q,n,basepoint);
  return 0;
}

#include <string.h>
#include "crypto_scalarmult.h"
#include "impl.h"

extern int curve25519_impl(
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
  unsigned char n_[32], p_[32];
  memcpy(n_, n, 32);
  memcpy(p_, p, 32);
  curve25519_impl(q,n_,p_);
  return 0;
}

int crypto_scalarmult_base(
  unsigned char *q,
  const unsigned char *n
)
{
  crypto_scalarmult(q,n,basepoint);
  return 0;
}


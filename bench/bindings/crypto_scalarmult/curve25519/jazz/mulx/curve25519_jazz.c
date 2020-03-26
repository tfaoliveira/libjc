#include <string.h>
#include <stdint.h>
#include "crypto_scalarmult.h"

extern int curve25519_mulx(
  unsigned char *q,
  const unsigned char *n,
  const unsigned char *p
);

extern int curve25519_mulx_base(
  unsigned char *q,
  const unsigned char *n
);

int crypto_scalarmult(
  unsigned char *q,
  const unsigned char *n,
  const unsigned char *p
)
{
  curve25519_mulx(q,n,p);
  return 0;
}

int crypto_scalarmult_base(
  unsigned char *q,
  const unsigned char *n
)
{
  curve25519_mulx_base(q,n);
  return 0;
}


#include "crypto_scalarmult.h"

extern int openssl_static_no_asm_X25519(
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
  r = openssl_static_no_asm_X25519(q,n,p);
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

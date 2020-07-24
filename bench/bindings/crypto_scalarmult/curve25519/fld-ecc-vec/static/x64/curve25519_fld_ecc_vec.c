#include "crypto_scalarmult.h"
#include "faz_ecdh_avx2.h"
#include <stdio.h>
#include <string.h>

int crypto_scalarmult(
  unsigned char *q,
  const unsigned char *n,
  const unsigned char *p
)
{
  X25519_KEY _q, _n, _p;
  memcpy(_n, n, 32);
  memcpy(_p, p, 32);
  X25519_x64.shared(_q, _p, _n);
  memcpy(q, _q, 32);
  return 0;
}

int crypto_scalarmult_base(
  unsigned char *q,
  const unsigned char *n
)
{
  X25519_KEY _q, _n;
  memcpy(_n, n, 32);
  X25519_x64.keygen(_q, _n);
  memcpy(q, _q, 32);
  return 0;
}

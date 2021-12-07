#include "crypto_core.h"
#include "impl.h"
#include "api.h"

extern void crypto_core_hsalsa20_impl(
        unsigned char *subkey,
  const unsigned char *nonce,
  const unsigned char *key,
  const unsigned char *sigma
);

int crypto_core(unsigned char *out, const unsigned char *in, const unsigned char *k, const unsigned char *c)
{
  crypto_core_hsalsa20_impl(out, in, k, c);
  return 0;
}


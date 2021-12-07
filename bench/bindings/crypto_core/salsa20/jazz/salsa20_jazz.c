#include "crypto_core.h"
#include "impl.h"
#include "api.h"

extern void crypto_core_salsa20_impl(
        unsigned char *state, //64
  const unsigned char *nonce, //16
  const unsigned char *key,   //32
  const unsigned char *sigma  //16
);

int crypto_core(unsigned char *out, const unsigned char *in, const unsigned char *k, const unsigned char *c)
{
  crypto_core_salsa20_impl(out, in, k, c);
  return 0;
}


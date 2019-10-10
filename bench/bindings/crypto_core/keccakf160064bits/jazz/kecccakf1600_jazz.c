#include "crypto_core.h"
#include "impl.h"
#include "api.h"

extern void keccakf1600_impl(
  unsigned char *out,
  const unsigned char *in
);

int crypto_core(unsigned char *out, const unsigned char *in, const unsigned char *k, const unsigned char *c)
{
  keccakf1600_ref(out, in);
  return 0;
}


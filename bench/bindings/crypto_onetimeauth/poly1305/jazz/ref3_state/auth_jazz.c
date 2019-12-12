#include "crypto_verify_16.h"
#include "crypto_onetimeauth.h"
#include "impl.h"

#include <stdint.h>

typedef struct state_t_
{
  uint64_t *r;
  uint64_t *h;
} state_t;

extern void poly1305_impl(
  unsigned char *out,
  state_t *state,
  const unsigned char *in,
  unsigned long long inlen,
  const unsigned char *k
);

int crypto_onetimeauth(
  unsigned char *out,
  const unsigned char *in,
  unsigned long long inlen,
  const unsigned char *k
)
{
  uint64_t rh[6];
  state_t state;
  state.r = &(rh[0]);
  state.h = &(rh[3]);
  poly1305_impl(out, &state, in, inlen, k);
  return 0;
}

int crypto_onetimeauth_verify(
  const unsigned char *h,
  const unsigned char *in,
  unsigned long long inlen,
  const unsigned char *k
)
{
  unsigned char correct[16];
  crypto_onetimeauth(correct,in,inlen,k);
  return crypto_verify_16(h,correct);
}

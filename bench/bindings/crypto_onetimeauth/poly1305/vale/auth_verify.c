#include "crypto_verify_16.h"
#include "crypto_onetimeauth.h"
#include "poly1305.h"
#include "api.h"

extern void poly1305(ctxt *ctx, const void *in, uint64_t inlen);

int crypto_onetimeauth(
  unsigned char *out,
  const unsigned char *in,
  unsigned long long inlen,
  const unsigned char *k
)
{
  ctxt ctx;
  memcpy(&(ctx.key_r0), k, CRYPTO_KEYBYTES);
  poly1305(&ctx, in, inlen);
  memcpy(out, &(ctx.h0), CRYPTO_BYTES);
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

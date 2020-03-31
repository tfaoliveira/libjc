#include <string.h>
#include <stdlib.h>

#include "crypto_hash.h"
#include "api.h"

extern unsigned long long sha512_ctx_size_ref0c();
extern void sha512_init_ref0c(unsigned char *ctx);
extern void sha512_update_ref0c(const unsigned char *in, unsigned long long inlen, unsigned char *ctx);
extern void sha512_finish_ref0c(unsigned char *out, unsigned char *ctx);

int crypto_hash(unsigned char *out,const unsigned char *in,unsigned long long inlen)
{
  unsigned long long i, ctx_size;
  unsigned char *ctx;

  ctx_size = sha512_ctx_size_ref0c();
  ctx = (unsigned char*) malloc(sizeof(unsigned char) * ctx_size);

  sha512_init_ref0c(ctx);
  sha512_update_ref0c(in, inlen, ctx);
  sha512_finish_ref0c(out, ctx);

  free(ctx);
  return 0;
}

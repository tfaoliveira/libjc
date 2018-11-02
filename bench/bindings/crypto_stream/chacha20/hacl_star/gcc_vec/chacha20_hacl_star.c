#include "crypto_stream.h"
#include <string.h>

int crypto_stream(
  unsigned char *out,
  unsigned long long outlen,
  const unsigned char *n,
  const unsigned char *k
)
{
  unsigned char nonce[12];
  memset(out, 0, outlen);
  memset(nonce, 0, 4);
  memcpy(nonce+4, n, 8);
  hacl_star_gcc_vec_Hacl_Chacha20_Vec128_chacha20(out, out, outlen, k, nonce, 0);
	return 0;
}

int crypto_stream_xor(
  unsigned char *out,
  const unsigned char *in,
  unsigned long long inlen,
  const unsigned char *n,
  const unsigned char *k
)
{
  unsigned char nonce[12];
  memset(nonce, 0, 4);
  memcpy(nonce+4, n, 8);
  hacl_star_gcc_vec_Hacl_Chacha20_Vec128_chacha20(out, in, inlen, k, nonce, 0);
	return 0;
}

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
  libsodium_static_disable_asm_sodium_init();
  memset(out, 0, outlen);
  memset(nonce, 0, 4);
  memcpy(nonce+4, n, 8);
  libsodium_static_disable_asm_crypto_stream_chacha20_ietf(out, outlen, nonce, k);
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
  libsodium_static_disable_asm_sodium_init();
  memset(nonce, 0, 4);
  memcpy(nonce+4, n, 8);
  libsodium_static_disable_asm_crypto_stream_chacha20_ietf_xor(out, in, inlen, nonce, k);
	return 0;
}


#include "crypto_stream.h"
#include <string.h>

int crypto_stream(
  unsigned char *out,
  unsigned long long outlen,
  const unsigned char *n,
  const unsigned char *k
)
{
  libsodium_static_sodium_init();
  libsodium_static_crypto_stream_chacha20_ietf(out, outlen, n, k);
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
  libsodium_static_sodium_init();
  libsodium_static_crypto_stream_chacha20_ietf_xor(out, in, inlen, n, k);
	return 0;
}

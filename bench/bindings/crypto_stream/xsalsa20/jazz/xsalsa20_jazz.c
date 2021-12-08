#include "crypto_stream.h"
#include "impl.h"
#include <string.h>
#include <stdint.h>

extern void xsalsa20_impl(
  unsigned char *out,
  const unsigned char *in,
  unsigned long long inlen,
  const unsigned char *k,
  const unsigned char *n
);

int crypto_stream(
  unsigned char *out,
  unsigned long long outlen,
  const unsigned char *n,
  const unsigned char *k
)
{
  memset(out, 0, outlen);
	xsalsa20_impl(out, out, outlen, n, k);
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
	xsalsa20_impl(out, in, inlen, n, k);
	return 0;
}

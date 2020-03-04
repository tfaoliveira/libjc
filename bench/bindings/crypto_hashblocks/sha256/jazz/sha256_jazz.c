#include "crypto_hashblocks.h"

#include "impl.h"
#include "api.h"

extern unsigned long long sha256_blocks_impl(
  unsigned char *statebytes,
  const unsigned char *in,
  unsigned long long inlen
);

int crypto_hashblocks(unsigned char *statebytes,const unsigned char *in,unsigned long long inlen)
{
  inlen = sha256_blocks_impl(statebytes,in,inlen);
  return inlen;
}

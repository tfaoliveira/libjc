#include "crypto_onetimeauth.h"
#include "kernelrandombytes.h"
#include "cpucycles.h"
#include "measure.h"

const char *primitiveimplementation = crypto_onetimeauth_IMPLEMENTATION;
const char *implementationversion = crypto_onetimeauth_VERSION;
const char *sizenames[] = { "outputbytes", "keybytes", 0 };
const long long sizes[] = { crypto_onetimeauth_BYTES, crypto_onetimeauth_KEYBYTES };

#define MAXTEST_BYTES 16384

static unsigned char *k;
static unsigned char *m;
static unsigned char *h;

void preallocate(void)
{
}

void allocate(void)
{
  k = alignedcalloc(crypto_onetimeauth_KEYBYTES);
  m = alignedcalloc(MAXTEST_BYTES);
  h = alignedcalloc(crypto_onetimeauth_BYTES);
}

#define WARM_TIMINGS (16)
#define TIMINGS (1024)
#define LOOPS 3

static long long cycles[TIMINGS+1];

int update_increment_setup1(int mlen)
{
  if(mlen < 64)
    return 1;
  if(mlen < 128)
    return 2;
  if(mlen < 256)
    return 4;
  if(mlen < 512)
    return 8;
  if(mlen < 1024)
    return 16;
  if(mlen < 2048)
    return 32;
  if(mlen < 4096)
    return 64;
  if(mlen < 8192)
    return 128;
  if(mlen < 16384)
    return 256;
  return 512;
}

int update_increment(int mlen)
{
  return update_increment_setup1(mlen);
}

void measure(void)
{
  int i;
  int loop;
  int mlen;
  int inc = 1;

  for (loop = 0;loop < LOOPS;++loop) {

    /* originally mlen = 0; but we are not interested in measuring the cpu time
       for zero length messages */
    for (mlen = 0;mlen <= MAXTEST_BYTES;mlen += inc) {

      // fill the inputs with random bytes
      kernelrandombytes(k,crypto_onetimeauth_KEYBYTES);
      kernelrandombytes(m,mlen);
      kernelrandombytes(h,crypto_onetimeauth_BYTES);

      // warm up
      for (i = 0;i < WARM_TIMINGS;++i) {
        crypto_onetimeauth(h,m,mlen,k);
      }

      // measure
      for (i = 0;i <= TIMINGS;++i) {
        cycles[i] = cpucycles();
        crypto_onetimeauth(h,m,mlen,k);
      }

      for (i = 0;i < TIMINGS;++i) {
        cycles[i] = cycles[i + 1] - cycles[i];
      }

      printentry(mlen,"cycles",cycles,TIMINGS);

      inc = update_increment(mlen);
    }
  }
}

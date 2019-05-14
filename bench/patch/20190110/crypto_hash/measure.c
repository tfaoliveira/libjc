#include <stdlib.h>
#include "kernelrandombytes.h"
#include "cpucycles.h"
#include "crypto_hash.h"
#include "measure.h"

const char *primitiveimplementation = crypto_hash_IMPLEMENTATION;
const char *implementationversion = crypto_hash_VERSION;
const char *sizenames[] = { "outputbytes", 0 };
const long long sizes[] = { crypto_hash_BYTES };

#define MAXTEST_BYTES 16384

static unsigned char *h;
static unsigned char *m;

void preallocate(void)
{
}

void allocate(void)
{
  h = alignedcalloc(crypto_hash_BYTES);
  m = alignedcalloc(MAXTEST_BYTES);
}

#define WARM_TIMINGS (128)
#define TIMINGS (1024)
#define LOOPS 3

static long long cycles[TIMINGS + 1];

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

static void printcycles(long long mlen)
{
  int i;
  for (i = 0;i < TIMINGS;++i) cycles[i] = cycles[i + 1] - cycles[i];
  printentry(mlen,"cycles",cycles,TIMINGS);
}

void measure(void)
{
  int i;
  int loop;
  int mlen;
  int inc = 1;

  for (loop = 0;loop < LOOPS;++loop) {
    for (mlen = 1;mlen <= MAXTEST_BYTES;mlen += inc) {

      kernelrandombytes(m,mlen);

      // warm up
      for (i = 0;i < WARM_TIMINGS;++i) {
        crypto_hash(h,m,mlen);
      }

      // measure
      for (i = 0;i <= TIMINGS;++i) {
        cycles[i] = cpucycles();
        crypto_hash(h,m,mlen);
      }

      printcycles(mlen);

      inc = update_increment(mlen);
    }
  }
}

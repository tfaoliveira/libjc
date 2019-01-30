#include <stdlib.h>
#include "kernelrandombytes.h"
#include "cpucycles.h"
#include "crypto_stream.h"
#include "measure.h"

const char *primitiveimplementation = crypto_stream_IMPLEMENTATION;
const char *implementationversion = crypto_stream_VERSION;
const char *sizenames[] = { "keybytes", "noncebytes", 0 };
const long long sizes[] = { crypto_stream_KEYBYTES, crypto_stream_NONCEBYTES };

#define MAXTEST_BYTES 16384
#ifdef SUPERCOP
#define MGAP 8192
#else
#define MGAP 8
#endif

static unsigned char *k;
static unsigned char *n;
static unsigned char *m;
static unsigned char *c;

void preallocate(void)
{
}

void allocate(void)
{
  k = alignedcalloc(crypto_stream_KEYBYTES);
  n = alignedcalloc(crypto_stream_NONCEBYTES);
  m = alignedcalloc(MAXTEST_BYTES);
  c = alignedcalloc(MAXTEST_BYTES);
}

#define TIMINGS (8192*4)
static long long cycles[TIMINGS + 1];

#define LOOPS 3

int update_increment(int mlen)
{
  if(mlen < 512)
    return 1;
  if(mlen < 4096)
    return 32;
  return 1024;
}

int update_timings(int mlen)
{
  if(mlen < 256)
    return TIMINGS;
  if(mlen < 512)
    return TIMINGS/2;
  if(mlen < 4096)
    return TIMINGS/16;
  return TIMINGS/64;
}

void measure(void)
{
  int i;
  int loop;
  int mlen;
  int inc = 1;
  int timings = TIMINGS;

  for (loop = 0;loop < LOOPS;++loop) {
    for (mlen = 0;mlen <= MAXTEST_BYTES;mlen += inc) {

      kernelrandombytes(k,crypto_stream_KEYBYTES);
      kernelrandombytes(n,crypto_stream_NONCEBYTES);
      kernelrandombytes(m,mlen);
      kernelrandombytes(c,mlen);

      /*      for (i = 0;i <= timings;++i) {*/
      /*        cycles[i] = cpucycles();*/
      /*        crypto_stream(c,mlen,n,k);*/
      /*      }*/
      /*      for (i = 0;i < timings;++i) cycles[i] = cycles[i + 1] - cycles[i];*/
      /*      printentry(mlen,"cycles",cycles,timings);*/

      for (i = 0;i <= timings;++i) {
        cycles[i] = cpucycles();
        crypto_stream_xor(c,m,mlen,n,k);
      }
      for (i = 0;i < timings;++i) cycles[i] = cycles[i + 1] - cycles[i];
      printentry(mlen,"xor_cycles",cycles,timings);

      inc = update_increment(mlen);
      timings = update_timings(mlen);
    }
  }
}

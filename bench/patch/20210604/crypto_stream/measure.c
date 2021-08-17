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

#define WARM_TIMINGS (16)
#define TIMINGS (2047)
#define LOOPS 3

static long long cycles[TIMINGS+1];

int update_increment_setup1(int mlen)
{
  if(mlen < 64)   // 2**6 -> 2**(6-6)
    return 1;
  if(mlen < 128)  // 2**7
    return 2;
  if(mlen < 256)  // 2**8
    return 4;
  if(mlen < 512)  // ...
    return 8;
  if(mlen < 1024)
    return 16;
  if(mlen < 2048)
    return 32;
  if(mlen < 4096)
    return 64;
  if(mlen < 8192)
    return 128;
  if(mlen < 16384) // 2**14 -> 2**(14-6) 
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
    for (mlen = 1;mlen <= MAXTEST_BYTES;mlen += inc) {

      // fill the inputs with random bytes
      kernelrandombytes(k,crypto_stream_KEYBYTES);
      kernelrandombytes(n,crypto_stream_NONCEBYTES);
      kernelrandombytes(m,mlen);
      kernelrandombytes(c,mlen);

      // warm up
      for (i = 0;i < WARM_TIMINGS;++i) {
        crypto_stream_xor(c,m,mlen,n,k);
      }

      // measure
      for (i = 0;i <= TIMINGS;++i) {
        cycles[i] = cpucycles();
        crypto_stream_xor(c,m,mlen,n,k);
      }

      for (i = 0;i < TIMINGS;++i) {
        cycles[i] = cycles[i + 1] - cycles[i];
      }

      printentry(mlen,"xor_cycles",cycles,TIMINGS);

      inc = update_increment(mlen);
    }
  } 
}

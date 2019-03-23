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

#define EST_TIMINGS (64)
#define MAX_TIMINGS (8192*16)
#define CPU_TIME (25000000)

#define LOOPS 3

static long long est_cycles[EST_TIMINGS + 1]; // estimate cycles
static long long cycles[MAX_TIMINGS + 1];
static long long loops[LOOPS][MAXTEST_BYTES + 1];

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

/* copied and adapted from printentry from file measure-anything.c */
long long getcycles(long long *cycles, long long timings)
{
  long long i;
  long long j;
  long long belowj;
  long long abovej;
  long long sum;

  j = 0;
  for (;j + 1 < timings;++j) { 
    belowj = 0;
    for (i = 0;i < timings;++i) if (cycles[i] < cycles[j]) ++belowj;
    abovej = 0;
    for (i = 0;i < timings;++i) if (cycles[i] > cycles[j]) ++abovej;
    if (belowj * 2 < timings && abovej * 2 < timings) break;
  }

  return cycles[j];
}

void measure(void)
{
  int i;
  int loop;
  int mlen;
  int inc = 1;

  // estimate number of cycles that a function takes to execute
  // real, or as real it can be... , number of cycles that a function takes to execute
  // timings, number of times that a function will be executed 
  long long estimate, real, timings; 

  for (loop = 0;loop < LOOPS;++loop) {

    /* originally mlen = 0; but we are not interested in measuring the cpu time
       for zero length messages */
    for (mlen = 0;mlen <= MAXTEST_BYTES;mlen += inc) {

      // fill the inputs with random bytes
      kernelrandombytes(k,crypto_onetimeauth_KEYBYTES);
      kernelrandombytes(m,mlen);
      kernelrandombytes(h,crypto_onetimeauth_BYTES);

      // get an estimate of how many cycles it takes to execute crypto_stream_xor
      for (i = 0;i <= EST_TIMINGS;++i) {
        est_cycles[i] = cpucycles();
        crypto_onetimeauth(h,m,mlen,k);
      }
      for (i = 0;i < EST_TIMINGS;++i) {
        est_cycles[i] = est_cycles[i + 1] - est_cycles[i];
      }

      // for example, if we estimate a function to take 1000 cpu cycles to execute
      // and we want to measure it for 10M cpu cycles then we are going to measure
      // it 10001 times
      estimate = getcycles(est_cycles, EST_TIMINGS);
      timings = (CPU_TIME > estimate) ? (CPU_TIME / estimate) : 1;
      timings |= 1;
      timings = (timings > MAX_TIMINGS) ? MAX_TIMINGS : timings;

      for (i = 0;i <= timings;++i) {
        cycles[i] = cpucycles();
        crypto_onetimeauth(h,m,mlen,k);
      }

      for (i = 0;i < timings;++i) {
        cycles[i] = cycles[i + 1] - cycles[i];
      }
      real = getcycles(cycles, timings);

      loops[loop][mlen] = real;

      printentry(mlen,"cycles",cycles,timings);

      inc = update_increment(mlen);
    }
  }
}

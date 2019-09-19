#include <stdio.h>
#include <stdlib.h>
#include "kernelrandombytes.h"
#include "cpucycles.h"
#include "crypto_stream.h"
#include "measure.h"

const char *primitiveimplementation = crypto_stream_IMPLEMENTATION;
const char *implementationversion = crypto_stream_VERSION;
const char *sizenames[] = { "keybytes", "noncebytes", 0 };
const long long sizes[] = { crypto_stream_KEYBYTES, crypto_stream_NONCEBYTES };

#define MAXRND_MEM 8192
#define MAXTEST_BYTES 16384

//static unsigned char *k;
//static unsigned char *n;
//static unsigned char *m;
//static unsigned char *c;

static unsigned char *k[MAXRND_MEM];
static unsigned char *n[MAXRND_MEM];
static unsigned char *m[MAXRND_MEM];
static unsigned char *c[MAXRND_MEM];

void preallocate(void)
{
}

void allocate(void)
{
  int i;
  for(i=0;i<MAXRND_MEM;i++)
  {
    k[i] = alignedcalloc(crypto_stream_KEYBYTES);
    n[i] = alignedcalloc(crypto_stream_NONCEBYTES);
    m[i] = alignedcalloc(MAXTEST_BYTES);
    c[i] = alignedcalloc(MAXTEST_BYTES);
  }
}

#define EST_TIMINGS (64)
#define MAX_TIMINGS (8192*8)
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
  long long begin, end, estimate, real, timings; 
  unsigned long long pmem;

  for (loop = 0;loop < LOOPS;++loop) {


    // fill the inputs with random bytes
    for (i = 0;i < MAXRND_MEM; i++) {
      kernelrandombytes(k[i],crypto_stream_KEYBYTES);
      kernelrandombytes(n[i],crypto_stream_NONCEBYTES);
      kernelrandombytes(m[i],MAXTEST_BYTES);
      kernelrandombytes(c[i],MAXTEST_BYTES);
    }

    // originally mlen = 0; but we are not interested in measuring the cpu time
    // for zero length messages
    for (mlen = 1;mlen <= MAXTEST_BYTES;mlen += inc) {

      // get an estimate of how many cycles it takes to execute crypto_stream_xor
      for (i = 0;i <= EST_TIMINGS;++i) {

        // calculate position
        kernelrandombytes((unsigned char *)&pmem,sizeof(unsigned long long));
        pmem = pmem & (MAXRND_MEM - 1);

        begin = cpucycles();
        crypto_stream_xor(c[pmem],m[pmem],mlen,n[pmem],k[pmem]);
        end = cpucycles();
        est_cycles[i] = end - begin;
      }

      // for example, if we estimate a function to take 1000 cpu cycles to execute
      // and we want to measure it for 10M cpu cycles then we are going to measure
      // it 10001 times
      estimate = getcycles(est_cycles, EST_TIMINGS);
      timings = ((CPU_TIME / estimate) > EST_TIMINGS) ? (CPU_TIME / estimate) : EST_TIMINGS;
      timings |= 1;
      timings = (timings > MAX_TIMINGS) ? MAX_TIMINGS : timings;


      for (i = 0;i <= timings;++i) {
        kernelrandombytes((unsigned char *)&pmem,sizeof(unsigned long long));
        pmem = pmem % MAXRND_MEM;
        begin = cpucycles();
        crypto_stream_xor(c[pmem],m[pmem],mlen,n[pmem],k[pmem]);
        end = cpucycles();
        cycles[i] = end - begin;
      }

      real = getcycles(cycles, timings);

      loops[loop][mlen] = real;

      // this is already calculated TODO: implement a function that only dumps
      // data in measure_anything.c
      printentry(mlen,"xor_cycles",cycles,timings);

      inc = update_increment(mlen);
    }
  }

  // run some statistical tests on loops to check if data is stable:
  // -- between loops and across messages lengths
  // -- and rerun the tests that are not stable until they are (or any given threshold) 
}

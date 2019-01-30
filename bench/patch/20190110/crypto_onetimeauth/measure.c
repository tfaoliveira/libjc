#include "crypto_onetimeauth.h"
#include "kernelrandombytes.h"
#include "cpucycles.h"
#include "measure.h"

const char *primitiveimplementation = crypto_onetimeauth_IMPLEMENTATION;
const char *implementationversion = crypto_onetimeauth_VERSION;
const char *sizenames[] = { "outputbytes", "keybytes", 0 };
const long long sizes[] = { crypto_onetimeauth_BYTES, crypto_onetimeauth_KEYBYTES };

#define MAXTEST_BYTES 16384
#ifdef SUPERCOP
#define MGAP 8192
#else
#define MGAP 8
#endif

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

#define TIMINGS (8192*2)
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

      kernelrandombytes(k,crypto_onetimeauth_KEYBYTES);
      kernelrandombytes(m,mlen);
      kernelrandombytes(h,crypto_onetimeauth_BYTES);

      for (i = 0;i <= TIMINGS;++i) {
        cycles[i] = cpucycles();
        crypto_onetimeauth(h,m,mlen,k);
      }
      for (i = 0;i < TIMINGS;++i) cycles[i] = cycles[i + 1] - cycles[i];
      printentry(mlen,"cycles",cycles,TIMINGS);


      /*      for (i = 0;i <= TIMINGS;++i) {*/
      /*        cycles[i] = cpucycles();*/
      /*	      crypto_onetimeauth_verify(h,m,mlen,k);*/
      /*      }*/
      /*      for (i = 0;i < TIMINGS;++i) cycles[i] = cycles[i + 1] - cycles[i];*/
      /*      printentry(mlen,"verify_cycles",cycles,TIMINGS);*/

      inc = update_increment(mlen);
      timings = update_timings(mlen);
    }
  }
}

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

int compare(const void * a, const void * b)
{ return ( *(uint64_t*)a - *(uint64_t*)b ); }


// begin code from supercop
#define WARM_TIMINGS (128*64 +1)
#define TIMINGS (8192*128)

static long long cycles[TIMINGS + 1];

static void printnum(long long x)
{
  printf("%lld ",x);
}

void printentry(const char *filename, const char *measuring,long long *m,long long mlen)
{
  long long i;
  long long j;
  long long belowj;
  long long abovej;
  long long sum;

  printf("%s\n", measuring);

  if (mlen > 0) { 
    for (j = 0;j + 1 < mlen;++j) { 
      belowj = 0;
      for (i = 0;i < mlen;++i) if (m[i] < m[j]) ++belowj;
      abovej = 0;
      for (i = 0;i < mlen;++i) if (m[i] > m[j]) ++abovej;
      if (belowj * 2 < mlen && abovej * 2 < mlen) break;
    } 
    printnum(m[j]);
    if (mlen > 1) {
      sum = 0;
      for (i = 0;i < mlen;++i) sum += m[i];
      printnum(sum/mlen);
    }

  } 
  printf("\n");
  fflush(stdout);

  //
  FILE *file;
  file = fopen(filename, "w");
  qsort(cycles+1, TIMINGS, sizeof(uint64_t), compare);
  for(i=2;i<=TIMINGS;i+=512)
  { fprintf(file, "%llu, %llu\n", i, cycles[i]); }
  fclose(file);
  //
}

static void printcycles(char *f, char *m)
{
  int i;
  for (i = 0;i < TIMINGS;++i) cycles[i] = cycles[i + 1] - cycles[i];
  printentry(f, m,cycles,TIMINGS);
}

long long cpucycles(void)
{
  unsigned long long result;
  asm volatile(".byte 15;.byte 49;shlq $32,%%rdx;orq %%rdx,%%rax"
    : "=a" (result) ::  "%rdx");
  return result;
}

// end code from supercop

uint64_t iotas_x86_64[32] __attribute__((aligned(256))) = 
{
       0,0,0,0,0,0,0, 0
   , 0x0000000000000001
   , 0x0000000000008082
   , 0x800000000000808a
   , 0x8000000080008000
   , 0x000000000000808b
   , 0x0000000080000001
   , 0x8000000080008081
   , 0x8000000000008009
   , 0x000000000000008a
   , 0x0000000000000088
   , 0x0000000080008009
   , 0x000000008000000a
   , 0x000000008000808b
   , 0x800000000000008b
   , 0x8000000000008089
   , 0x8000000000008003
   , 0x8000000000008002
   , 0x8000000000000080
   , 0x000000000000800a
   , 0x800000008000000a
   , 0x8000000080008081
   , 0x8000000000008080
   , 0x0000000080000001
   , 0x8000000080008008
};

uint64_t rhotates_left_avx2[6*4] __attribute__((aligned(32))) = {
     3,   18,    36,    41,
     1,   62,    28,    27,
    45,    6,    56,    39,
    10,   61,    55,     8,
     2,   15,    25,    20,
    44,   43,    21,    14 };


uint64_t rhotates_right_avx2[6*4] __attribute__((aligned(32))) = {
    64-3,  64-18,  64-36,  64-41,
    64-1,  64-62,  64-28,  64-27,
    64-45, 64-6,   64-56,  64-39,
    64-10, 64-61,  64-55,  64-8,
    64-2,  64-15,  64-25,  64-20,
    64-44, 64-43,  64-21,  64-14 };

uint64_t iotas_avx2[24*4] __attribute__((aligned(32))) = {
    0x0000000000000001UL, 0x0000000000000001UL, 0x0000000000000001UL, 0x0000000000000001UL,
    0x0000000000008082UL, 0x0000000000008082UL, 0x0000000000008082UL, 0x0000000000008082UL,
    0x800000000000808aUL, 0x800000000000808aUL, 0x800000000000808aUL, 0x800000000000808aUL,
    0x8000000080008000UL, 0x8000000080008000UL, 0x8000000080008000UL, 0x8000000080008000UL,
    0x000000000000808bUL, 0x000000000000808bUL, 0x000000000000808bUL, 0x000000000000808bUL,
    0x0000000080000001UL, 0x0000000080000001UL, 0x0000000080000001UL, 0x0000000080000001UL,
    0x8000000080008081UL, 0x8000000080008081UL, 0x8000000080008081UL, 0x8000000080008081UL,
    0x8000000000008009UL, 0x8000000000008009UL, 0x8000000000008009UL, 0x8000000000008009UL,
    0x000000000000008aUL, 0x000000000000008aUL, 0x000000000000008aUL, 0x000000000000008aUL,
    0x0000000000000088UL, 0x0000000000000088UL, 0x0000000000000088UL, 0x0000000000000088UL,
    0x0000000080008009UL, 0x0000000080008009UL, 0x0000000080008009UL, 0x0000000080008009UL,
    0x000000008000000aUL, 0x000000008000000aUL, 0x000000008000000aUL, 0x000000008000000aUL,
    0x000000008000808bUL, 0x000000008000808bUL, 0x000000008000808bUL, 0x000000008000808bUL,
    0x800000000000008bUL, 0x800000000000008bUL, 0x800000000000008bUL, 0x800000000000008bUL,
    0x8000000000008089UL, 0x8000000000008089UL, 0x8000000000008089UL, 0x8000000000008089UL,
    0x8000000000008003UL, 0x8000000000008003UL, 0x8000000000008003UL, 0x8000000000008003UL,
    0x8000000000008002UL, 0x8000000000008002UL, 0x8000000000008002UL, 0x8000000000008002UL,
    0x8000000000000080UL, 0x8000000000000080UL, 0x8000000000000080UL, 0x8000000000000080UL,
    0x000000000000800aUL, 0x000000000000800aUL, 0x000000000000800aUL, 0x000000000000800aUL,
    0x800000008000000aUL, 0x800000008000000aUL, 0x800000008000000aUL, 0x800000008000000aUL,
    0x8000000080008081UL, 0x8000000080008081UL, 0x8000000080008081UL, 0x8000000080008081UL,
    0x8000000000008080UL, 0x8000000000008080UL, 0x8000000000008080UL, 0x8000000000008080UL,
    0x0000000080000001UL, 0x0000000080000001UL, 0x0000000080000001UL, 0x0000000080000001UL,
    0x8000000080008008UL, 0x8000000080008008UL, 0x8000000080008008UL, 0x8000000080008008UL };


extern void KeccakF1600_OpenSSL_AVX2();
extern void KeccakF1600_OpenSSL_x86_64(uint64_t *, uint64_t *);
extern void KeccakF1600_x86_64(uint64_t *, uint64_t *);
extern void KeccakF1600_x86_64_STATE_IN_STACK_0(uint64_t *, uint64_t *);
extern void KeccakF1600_x86_64_KECCAK_F_IMPL_3(uint64_t *, uint64_t *);
extern void KeccakF1600_AVX2(uint64_t *, uint64_t *, uint64_t *, uint64_t *);

int main()
{
  long long i;
  uint64_t s1[25], s2[25], s3[28], s4[50];


  // to increase the cpu frequency if necessary
  for (i = 0;i <= TIMINGS*2;++i)
  { KeccakF1600_OpenSSL_x86_64(s1, s2); }



  // KeccakF1600_OpenSSL_x86_64
  for (i = 0;i <= WARM_TIMINGS;++i)
  { KeccakF1600_OpenSSL_x86_64(s1, s2); }

  for (i = 0;i <= TIMINGS;++i)
  { cycles[i] = cpucycles();
    KeccakF1600_OpenSSL_x86_64(s1, s2); }
  printcycles("plot/openssl_x86_64.csv","KeccakF1600_OpenSSL_x86_64");



  // KeccakF1600_x86_64
  for (i = 0;i <= WARM_TIMINGS;++i)
  { KeccakF1600_x86_64(s1, iotas_x86_64+8); }

  for (i = 0;i <= TIMINGS;++i)
  { cycles[i] = cpucycles();
    KeccakF1600_x86_64(s1, iotas_x86_64+8); }
  printcycles("plot/jazz_x86_64.csv","KeccakF1600_x86_64");



  // KeccakF1600_x86_64_STATE_IN_STACK_0
  for (i = 0;i <= WARM_TIMINGS;++i)
  { KeccakF1600_x86_64_STATE_IN_STACK_0(s4, iotas_x86_64+8); }

  for (i = 0;i <= TIMINGS;++i)
  { cycles[i] = cpucycles();
    KeccakF1600_x86_64_STATE_IN_STACK_0(s4, iotas_x86_64+8); }
  printcycles("plot/jazz_x86_64_state_in_stack_0.csv","KeccakF1600_x86_64_STATE_IN_STACK_0");



  // KeccakF1600_x86_64_KECCAK_F_IMPL_3
  for (i = 0;i <= WARM_TIMINGS;++i)
  { KeccakF1600_x86_64_KECCAK_F_IMPL_3(s4, iotas_x86_64+8); }

  for (i = 0;i <= TIMINGS;++i)
  { cycles[i] = cpucycles();
    KeccakF1600_x86_64_KECCAK_F_IMPL_3(s4, iotas_x86_64+9); }
  printcycles("plot/jazz_x86_64_keccak_f_impl_3.csv","KeccakF1600_x86_64_KECCAK_F_IMPL_3");



  // KeccakF1600_OpenSSL_AVX2
  for (i = 0;i <= WARM_TIMINGS;++i)
  { KeccakF1600_OpenSSL_AVX2(); }

  for (i = 0;i <= TIMINGS;++i)
  { cycles[i] = cpucycles();
    KeccakF1600_OpenSSL_AVX2(); }
  printcycles("plot/openssl_avx2.csv","KeccakF1600_OpenSSL_AVX2");



  // KeccakF1600_AVX2
  for (i = 0;i <= WARM_TIMINGS;++i)
  { KeccakF1600_AVX2(s3,rhotates_left_avx2, rhotates_right_avx2, iotas_avx2); }

  for (i = 0;i <= TIMINGS;++i)
  { cycles[i] = cpucycles();
    KeccakF1600_AVX2(s3,rhotates_left_avx2, rhotates_right_avx2, iotas_avx2); }
  printcycles("plot/jazz_avx2.csv","KeccakF1600_AVX2");



  return 0;
}


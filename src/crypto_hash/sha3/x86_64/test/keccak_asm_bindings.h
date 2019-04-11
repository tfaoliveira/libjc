#ifndef KECCAK_ASM_BINDINGS
#define KECCAK_ASM_BINDINGS

#include <stddef.h>
#include <stdint.h>

//
// C reference (https://github.com/mjosaarinen/tiny_sha3/main.c)
//

// state context
typedef struct sha3_ctxt {
    union {                                 // state:
        uint8_t b[200];                     // 8-bit bytes
        uint64_t q[25];                     // 64-bit words
    } st;
    int pt, rsiz, mdlen;                    // these don't overflow
} sha3_ctx_t, *sha3_ctx_ptr;

int sha3_init(sha3_ctx_ptr c, int mdlen); 
int sha3_update(sha3_ctx_ptr c, const void *data, size_t len);
int sha3_final(void *md, sha3_ctx_ptr c);    // digest goes to md
// compute a sha3 hash (md) of given byte length from "in"
void *sha3(const void *in, size_t inlen, void *md, int mdlen);

// Compression function.
void sha3_keccakf(uint64_t st[25]);
static inline void sha3_keccakftest(uint64_t st[25], uint64_t count) {
  while (count--) sha3_keccakf(st);
};

#define shake256_init(c) sha3_init(c, 32)
#define shake_update sha3_update
void shake_xof(sha3_ctx_ptr c);
void shake_out(sha3_ctx_ptr c, void *out, size_t len);


//
// Jasmin interfaces
//

extern void keccakF2x_test_jazz(uint64_t st[25], uint64_t count);
extern void keccak_shake256_jazz(void *datain, size_t inbitlen, void *dataout, size_t outbitlen);

uint64_t iotas[32]  __attribute__((aligned(256))) =  { 0, 0, 0, 0, 0, 0, 0, 0
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


extern void keccakFshort(uint64_t st[25]);

static inline void KeccakF_short_test(uint64_t st[25], uint64_t count) {
  uint64_t st_alt[25];
  while (count--) keccakF_short(st, st_alt, iotas+8);
  /*
  printf("\nCheck IOTAS:\n");
  uint64_t *iotas_ptr = iotas+8;
  while (((long long)iotas_ptr) & 0xFF) {
    printf("%016llx ", *iotas_ptr);
    iotas_ptr++;
  }
  */
};

//
// OpenSSL
//

extern int KeccakF1600(uint64_t *st);

static inline void KeccakF1600test(uint64_t st[25], uint64_t count) {
  while (count--) KeccakF1600(st);
};



#endif /* KECCAK_ASM_BINDINGS */

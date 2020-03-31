#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

#include "common/test.c"

typedef struct param_t
{ uint8_t *msg;
  uint64_t msglen;
  uint8_t *DST;
  uint64_t DSTlen;
} param_t;

extern uint64_t sha256_ctx_size();
extern void expand_message_xmd_sha256(uint8_t *out, uint64_t outlen, param_t *_param, uint8_t *ctx);

// borrowed from here: https://github.com/relic-toolkit/relic/blob/master/test/test_md.c
#define TEST1   "abc"

#define TEST2a  "abcdbcdecdefdefgefghfghighijhi"
#define TEST2b  "jkijkljklmklmnlmnomnopnopq"

#define TEST3a	"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
#define TEST3b	"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"

#define TEST4a	"abcdefghbcdefghicdefghijdefghijkefghijklfghijklmghijklmn"
#define TEST4b	"hijklmnoijklmnopjklmnopqklmnopqrlmnopqrsmnopqrstnopqrstu"

char *tests[3] = {
	TEST1,
	TEST2a TEST2b,
	TEST3a TEST3b,
};

uint8_t result_xmd_sha256[4][75] = {
	{0x94, 0x77, 0xB7, 0xE5, 0xCA, 0x5E, 0xF7, 0x57, 0x6C, 0xF8, 0xF1,
	 0x18, 0x26, 0xAA, 0x86, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
	{0xE8, 0x5E, 0x5B, 0x4E, 0x3F, 0x36, 0x71, 0xC9, 0x6D, 0xA0, 0xF9,
	 0x52, 0xFF, 0x55, 0x00, 0xDB, 0x95, 0x62, 0x1D, 0x0C, 0x89, 0x4F,
	 0xD0, 0x8F, 0x37, 0x78, 0x50, 0x9D, 0xF5, 0x44, 0x9D, 0x63, 0xB7,
	 0x6C, 0xEC, 0x88, 0xF3, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
	{0x3D, 0x5B, 0x01, 0x5C, 0x89, 0x4E, 0x82, 0x4D, 0xDA, 0xCC, 0x0B,
	 0x87, 0x27, 0x4A, 0x62, 0x66, 0xCB, 0xF5, 0x55, 0xF7, 0xF3, 0x84,
	 0x58, 0x09, 0x4A, 0xED, 0xD6, 0xD6, 0x70, 0x86, 0xC0, 0x04, 0x24,
	 0xE6, 0xE3, 0x83, 0xAA, 0x0F, 0x35, 0xB7, 0x82, 0xF7, 0xAC, 0xFF,
	 0xE0, 0xE8, 0x51, 0x25, 0xDB, 0xB4, 0x8B, 0xC0, 0x29, 0xD7, 0xE3,
	 0x0E, 0x7B, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
	{0xD9, 0x95, 0x00, 0xD5, 0xCE, 0x7B, 0x24, 0xB6, 0x7E, 0x38, 0x21,
	 0xC0, 0x02, 0x9A, 0xBE, 0xF6, 0x6D, 0x20, 0x67, 0x51, 0x18, 0xFF,
	 0xA1, 0xCF, 0xFB, 0x81, 0x62, 0xF2, 0xFB, 0x4D, 0x8F, 0x8A, 0xE2,
	 0x41, 0x35, 0xFA, 0x8B, 0x1C, 0xAD, 0xE8, 0x00, 0x28, 0xA3, 0x5A,
	 0x3D, 0xB6, 0xCF, 0xCB, 0xBB, 0x35, 0x04, 0xF8, 0x6C, 0xB0, 0xA3,
	 0x1B, 0x2F, 0x01, 0x12, 0xC6, 0x10, 0x2B, 0x70, 0x2B, 0xDF, 0xD2,
	 0x8D, 0xAC, 0x57, 0xE3, 0x8F, 0x57, 0xE3, 0xE9, 0xBE},
};
//

int test1()
{
  int r;
  uint64_t ctxlen;
  uint8_t *ctx, out[75];

  ctxlen = sha256_ctx_size();
  ctx = (uint8_t*) calloc(ctxlen,1);

  //test1
  param_t p1 = { (uint8_t *)TEST1, strlen(TEST1), (uint8_t *)"", 0 };
  expand_message_xmd_sha256(out, 16, &p1, ctx);
  r = (memcmp(out, result_xmd_sha256[0], 16) == 0) ? TEST_OK : TEST_ERR;

  //test2
  param_t p2 = { (uint8_t *)TEST2a, strlen(TEST2a), (uint8_t *)TEST2b, strlen(TEST2b) };
  expand_message_xmd_sha256(out, 37, &p2, ctx);
  r += (memcmp(out, result_xmd_sha256[1], 37) == 0) ? TEST_OK : TEST_ERR;

  //test3
  param_t p3 = { (uint8_t *)TEST3a, strlen(TEST3a), (uint8_t *)TEST3b, strlen(TEST3b) };
  expand_message_xmd_sha256(out, 57, &p3, ctx);
  r += (memcmp(out, result_xmd_sha256[2], 57) == 0) ? TEST_OK : TEST_ERR;

  //test4
  param_t p4 = { (uint8_t *)TEST4a, strlen(TEST4a), (uint8_t *)TEST4b, strlen(TEST4b) };
  expand_message_xmd_sha256(out, 75, &p4, ctx);
  r += (memcmp(out, result_xmd_sha256[3], 75) == 0) ? TEST_OK : TEST_ERR;

  free(ctx);
  return r;
}

int main()
{
  int r;
  r  = test1(); test_check(r,"test1");
  return r;
}


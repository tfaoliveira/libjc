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

extern uint64_t sha512_ctx_size();
extern void expand_message_xmd_sha512(uint8_t *out, uint64_t outlen, param_t *_param, uint8_t *ctx);

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

uint8_t result_xmd_sha512[4][75] = {
	{0x59, 0xDB, 0xF2, 0x0C, 0x8A, 0x4C, 0xCA, 0xA9, 0x92, 0xA9, 0x69,
	 0xEE, 0xFA, 0x7B, 0x75, 0x25, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
	{0x42, 0x86, 0xE2, 0x61, 0xD3, 0x5C, 0xAD, 0x94, 0x6B, 0xA2, 0xFF,
	 0x55, 0x8D, 0x5C, 0x71, 0xE8, 0x85, 0x76, 0x74, 0x55, 0xF8, 0xAE,
	 0x1D, 0xB3, 0xE8, 0x7A, 0xF3, 0x2E, 0x54, 0x31, 0x22, 0x01, 0xA0,
	 0x61, 0x8A, 0xC4, 0xCF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
	{0x2A, 0x86, 0x54, 0x63, 0x3F, 0x41, 0xDF, 0x61, 0x52, 0x07, 0xCE,
	 0x04, 0xA8, 0x98, 0x22, 0x15, 0xAA, 0xC3, 0x39, 0x73, 0x21, 0x8B,
	 0x84, 0x96, 0x71, 0xCA, 0x61, 0x34, 0x09, 0x6E, 0x4E, 0xBC, 0x1D,
	 0xD3, 0x60, 0x2A, 0xC1, 0xA5, 0xF1, 0xA2, 0x07, 0xD4, 0xB7, 0xE1,
	 0xEC, 0x03, 0xF1, 0x51, 0x57, 0x05, 0x0B, 0xD4, 0xE9, 0xB3, 0xE6,
	 0xAE, 0x66, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
	{0x07, 0x63, 0x10, 0x42, 0x23, 0x90, 0x13, 0x01, 0x61, 0xA2, 0x95,
	 0xCE, 0xB4, 0xA4, 0xA6, 0x4C, 0xFE, 0xE9, 0xA5, 0x57, 0x62, 0xA6,
	 0xC2, 0x98, 0x2B, 0x6C, 0x78, 0x7A, 0x50, 0xFE, 0x14, 0xC1, 0x42,
	 0x48, 0x32, 0x67, 0x8B, 0x6E, 0x8F, 0x05, 0xB5, 0x9F, 0xE5, 0x83,
	 0x0C, 0xE5, 0x29, 0x7F, 0x0F, 0x99, 0xC3, 0xDF, 0x6E, 0xF6, 0x2D,
	 0x33, 0x46, 0xEA, 0xF7, 0xC9, 0xC5, 0x9F, 0xF7, 0xCB, 0x6D, 0x68,
	 0xDC, 0x7F, 0x06, 0xEB, 0x60, 0x17, 0x66, 0x24, 0x99},
};
//

int test1()
{
  int r;
  uint64_t ctxlen;
  uint8_t *ctx, out[75];

  ctxlen = sha512_ctx_size();
  ctx = (uint8_t*) calloc(ctxlen,1);

  //test1
  param_t p1 = { (uint8_t *)TEST1, strlen(TEST1), (uint8_t *)"", 0 };
  expand_message_xmd_sha512(out, 16, &p1, ctx);
  r = (memcmp(out, result_xmd_sha512[0], 16) == 0) ? TEST_OK : TEST_ERR;

  //test2
  param_t p2 = { (uint8_t *)TEST2a, strlen(TEST2a), (uint8_t *)TEST2b, strlen(TEST2b) };
  expand_message_xmd_sha512(out, 37, &p2, ctx);
  r += (memcmp(out, result_xmd_sha512[1], 37) == 0) ? TEST_OK : TEST_ERR;

  //test3
  param_t p3 = { (uint8_t *)TEST3a, strlen(TEST3a), (uint8_t *)TEST3b, strlen(TEST3b) };
  expand_message_xmd_sha512(out, 57, &p3, ctx);
  r += (memcmp(out, result_xmd_sha512[2], 57) == 0) ? TEST_OK : TEST_ERR;

  //test4
  param_t p4 = { (uint8_t *)TEST4a, strlen(TEST4a), (uint8_t *)TEST4b, strlen(TEST4b) };
  expand_message_xmd_sha512(out, 75, &p4, ctx);
  r += (memcmp(out, result_xmd_sha512[3], 75) == 0) ? TEST_OK : TEST_ERR;

  free(ctx);
  return r;
}

int main()
{
  int r;
  r  = test1(); test_check(r,"test1");
  return r;
}


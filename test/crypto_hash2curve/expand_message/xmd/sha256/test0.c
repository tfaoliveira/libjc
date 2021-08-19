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

#define TEST3a  "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
#define TEST3b  "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"

#define TEST4a  "abcdefghbcdefghicdefghijdefghijkefghijklfghijklmghijklmn"
#define TEST4b  "hijklmnoijklmnopjklmnopqklmnopqrlmnopqrsmnopqrstnopqrstu"

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
  {0x39, 0x65, 0x3C, 0xBF, 0x00, 0x21, 0xBE, 0x81, 0x5C, 0x84, 0xD6,
   0x9D, 0xF1, 0xB1, 0xF3, 0x0D, 0x70, 0xE1, 0x4D, 0xB9, 0xF2, 0x45,
   0xC7, 0x6D, 0xEF, 0x80, 0x6D, 0x6A, 0x3E, 0x6F, 0x67, 0xAF, 0xB5,
   0xB7, 0x2A, 0x51, 0x85, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
  {0x37, 0x73, 0x2D, 0x66, 0xE2, 0x1B, 0x59, 0x48, 0xF0, 0x10, 0xFA,
   0x57, 0xDA, 0xC9, 0x8A, 0x08, 0x6E, 0x73, 0x0B, 0x67, 0xEF, 0x32,
   0x52, 0xB0, 0x6E, 0x5A, 0x9C, 0x85, 0xCE, 0x22, 0x6B, 0x2F, 0x60,
   0x7B, 0x35, 0x14, 0xA1, 0x39, 0x2E, 0x64, 0x81, 0xF8, 0xCE, 0xA3,
   0xF0, 0x41, 0x55, 0x41, 0xFA, 0x3F, 0x8F, 0x38, 0x5D, 0x95, 0xCC,
   0x2A, 0x59, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
  {0x9B, 0xF5, 0xCA, 0x1E, 0x5E, 0x91, 0x75, 0x14, 0xB4, 0x31, 0xCD,
   0xFC, 0x72, 0x35, 0x61, 0x9C, 0x4D, 0xC4, 0x13, 0xAD, 0x69, 0xE8,
   0x2D, 0x8D, 0x1E, 0xF0, 0x03, 0xC3, 0xA7, 0x86, 0xD9, 0xC7, 0x17,
   0x47, 0x01, 0x07, 0xD3, 0x69, 0x8C, 0x06, 0x9D, 0xEB, 0x48, 0x3A,
   0x01, 0x13, 0x17, 0xD3, 0x8D, 0x1F, 0xAD, 0x85, 0x5F, 0x8E, 0xFF,
   0x90, 0xBA, 0x44, 0xBC, 0xB3, 0xBC, 0xAC, 0xED, 0x1F, 0x8F, 0x21,
   0x4C, 0xCF, 0xB7, 0x31, 0x0D, 0x41, 0x21, 0x7D, 0x94},
};

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

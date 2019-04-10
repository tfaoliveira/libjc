// main.c
// adapted from https://github.com/mjosaarinen/tiny_sha3/main.c

#include <stdio.h>
#include <string.h>
#include <time.h>
#include <assert.h>

#include "keccak_asm_bindings.h"

#define TESTREP 10000000

// read a hex string, return byte length or -1 on error.

static int test_hexdigit(char ch)
{
    if (ch >= '0' && ch <= '9')
        return  ch - '0';
    if (ch >= 'A' && ch <= 'F')
        return  ch - 'A' + 10;
    if (ch >= 'a' && ch <= 'f')
        return  ch - 'a' + 10;
    return -1;
}

static int test_readhex(uint8_t *buf, const char *str, int maxbytes)
{
    int i, h, l;

    for (i = 0; i < maxbytes; i++) {
        h = test_hexdigit(str[2 * i]);
        if (h < 0)
            return i;
        l = test_hexdigit(str[2 * i + 1]);
        if (l < 0)
            return i;
        buf[i] = (h << 4) + l;
    }

    return i;
}

static void printhex(uint8_t *buf, int maxbytes)
{
    int i;

    for (i = 0; i < maxbytes; i++)
      printf("%02x", buf[i]);
    printf("\n");
}

// returns zero on success, nonzero + stderr messages on failure

// testvectors:
//https://www.di-mgt.com.au/sha_testvectors.html


// test for SHAKE256

int test_shake_256()
{
    // Test vectors have bytes 480..511 of XOF output for given inputs.
    // From http://csrc.nist.gov/groups/ST/toolkit/examples.html#aHashing

    const char *testhex[2] = {
        // SHAKE256, message of length 0
        "AB0BAE316339894304E35877B0C28A9B1FD166C796B9CC258A064A8F57E27F2A",
        // SHAKE256, 1600-bit test pattern
        "6A1A9D7846436E4DCA5728B6F760EEF0CA92BF0BE5615E96959D767197A0BEEB"
    };

    int i, fails, fail_cmp, fail_jazz, fail_ref;
    sha3_ctx_t sha3;
    uint8_t chk_ref[32], buf[200], ref[512], jazz[512];

    memset(buf, 0xA3, 200);
    fails = 0;

    for (i = 0; i < 2; i++) {
      shake256_init(&sha3);

      if (i == 0) {
	shake_xof(&sha3);        // switch to extensible output
	shake_out(&sha3, ref, 512);
	keccak_shake256_jazz(buf, 0*8, jazz, 512*8); // size in bits
      } else {                   // 1600-bit test pattern
	shake_update(&sha3, buf, 200);
	shake_xof(&sha3);        // switch to extensible output
	shake_out(&sha3, ref, 512);
	keccak_shake256_jazz(buf, 200*8, jazz, 512*8);
      }
      // compare implementations
      fail_cmp = memcmp(ref, jazz, 512) ? 512 : 0;
      // compare to reference values
      test_readhex(chk_ref, testhex[i], 32);
      fail_ref = memcmp(chk_ref, ref+480, 32) ? 32 : 0;
      fail_jazz = memcmp(chk_ref, jazz+480, 32) ? 32 : 0;
      
      if (fail_cmp) {
	fprintf(stderr, "SHAKE-256 comparison test %d test FAILED.\n",
		i);
	//printhex(ref, fail_cmp);
	//printhex(jazz, fail_cmp);
	fails++;
      }
      if (fail_ref) {
	fprintf(stderr, "SHAKE-256 ref test %d test FAILED.\n", i);
	printhex(chk_ref, fail_ref);
	printhex(ref, fail_ref);
      }
      if (fail_jazz) {
	fprintf(stderr, "SHAKE-256 jazz test %d test FAILED.\n", i);
	printhex(chk_ref, fail_jazz);
	printhex(ref, fail_jazz);
      }
    }

    return fails;
}

// test speed of the keccakF function

void test_keccakf_speed()
{
    int i;
    uint64_t st[25], x, n;
    clock_t bg, us;

    printf("Keccak-p[1600,512] Speed Test\n\n");

    // Simple C reference implementation:
    for (i = 0; i < 25; i++) st[i] = i;
    
    bg = clock();
    n = 0;
    do {
      sha3_keccakftest(st, TESTREP);
      n += TESTREP;
      us = clock() - bg;
    } while (0); //(us < 3 * CLOCKS_PER_SEC);

    x = 0;
    for (i = 0; i < 25; i++)
        x += st[i];

    printf("Simple C reference (%016lX): %.3f/ Second.\n",
	   (unsigned long) x,
	   (CLOCKS_PER_SEC * ((double) n)) / ((double) us));

    // Jasmin Keccak2x implementation:
    for (i = 0; i < 25; i++) st[i] = i;
    
    bg = clock();
    n = 0;
    do {
      keccakF2x_test_jazz(st, TESTREP);
      n += TESTREP;
      us = clock() - bg;
    } while (0); //(us < 3 * CLOCKS_PER_SEC);

    x = 0;
    for (i = 0; i < 25; i++)
        x += st[i];

    printf("Jasmin Keccak2x (%016lX): %.3f/ Second.\n",
	   (unsigned long) x,
	   (CLOCKS_PER_SEC * ((double) n)) / ((double) us));


    // OpenSSL x86_64 implementation:
    for (i = 0; i < 25; i++) st[i] = i;
    bg = clock();
    n = 0;
    do {
      KeccakF1600test(st, TESTREP);
      n += TESTREP;
      us = clock() - bg;
    } while (0); //(us < 3 * CLOCKS_PER_SEC);

    x = 0;
    for (i = 0; i < 25; i++)
        x += st[i];

    printf("OpenSSL x86_64 (%016lX): %.3f/ Second.\n",
	   (unsigned long) x,
	   (CLOCKS_PER_SEC * ((double) n)) / ((double) us));


    // Jasmin Keccak2x_short implementation:
    for (i = 0; i < 25; i++) st[i] = i;
    
    bg = clock();
    n = 0;
    do {
      KeccakF_short_test(st, TESTREP);
      n += TESTREP;
      us = clock() - bg;
    } while (0); //(us < 3 * CLOCKS_PER_SEC);

    x = 0;
    for (i = 0; i < 25; i++)
        x += st[i];

    printf("Jasmin Keccak2x_short (%016lX): %.3f/ Second.\n",
	   (unsigned long) x,
	   (CLOCKS_PER_SEC * ((double) n)) / ((double) us));


}

// main
int main(int argc, char **argv)
{
    if (test_shake_256() == 0)
        printf("\nFIPS 202 / SHA3-256, SHAKE256 Self-Tests OK!\n\n");
    test_keccakf_speed();

    return 0;
}


//TODO implement header file...

#define TEST_OK 0
#define TEST_ERR 1

#define RED   "\x1b[31m"
#define GREEN "\x1b[32m"
#define RESET "\x1b[0m"

void test_pass(char *s)
{ printf("%s - " GREEN "[PASS]" RESET "\n", s); }

void test_fail(char *s)
{ printf("%s - " RED "[FAIL]" RESET "\n", s); }

void test_check(int r, char *s)
{ r == TEST_OK ? test_pass(s) : test_fail(s); }

void dump_u8s(char *str, uint8_t *p, uint64_t l)
{
  uint64_t i;
  printf("%s",str);
  for(i=0; i<l; i++)
  { printf("%02x ", p[i]); }
  printf("\n");
}

#include <stddef.h>
#include <openssl/evp.h>
#include "crypto_hash.h"

int crypto_hash(unsigned char *out,const unsigned char *in,unsigned long long inlen)
{
  int ok = 1;
  EVP_MD_CTX *x;

  x = openssl_static_EVP_MD_CTX_new();
  if (!x) return -111;

  if (ok) ok = openssl_static_EVP_DigestInit_ex(&x,EVP_shake256(),NULL);
  if (ok) ok = openssl_static_EVP_DigestUpdate(&x,in,inlen);
  if (ok) ok = openssl_static_EVP_DigestFinalXOF(&x,out,crypto_hash_BYTES);

  openssl_static_EVP_MD_CTX_free(x);
  if (!ok) return -111;
  return 0;
}

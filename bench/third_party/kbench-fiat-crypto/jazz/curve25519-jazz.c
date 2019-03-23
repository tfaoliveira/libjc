/* SPDX-License-Identifier: GPL-2.0
 *
 * Copyright (C) 2015 Google Inc. All Rights Reserved.
 * Copyright (C) 2015-2018 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
 *
 * Original author: Peter Schwabe <peter@cryptojedi.org>
 */

/*#include <linux/kernel.h>*/
/*#include <linux/string.h>*/

enum { CURVE25519_POINT_SIZE = 32 };

#include "crypto_scalarmult.h"
#include <stdint.h>
#include <string.h>
typedef uint8_t u8;

extern void curve25519_ref4(u8 out[CURVE25519_POINT_SIZE], const u8 scalar[CURVE25519_POINT_SIZE], const u8 point[CURVE25519_POINT_SIZE]);

int crypto_scalarmult(u8 out[CURVE25519_POINT_SIZE], const u8 scalar[CURVE25519_POINT_SIZE], const u8 point[CURVE25519_POINT_SIZE])
{
  u8 scalar_[32], point_[32];
  memcpy(scalar_, scalar, 32);
  memcpy(point_, point, 32);
  curve25519_ref4(out,scalar_,point_);
	return 0;
}

static const unsigned char basepoint[32] = {9};

int crypto_scalarmult_base(
  unsigned char *q,
  const unsigned char *n
)
{
  int r;
  r = crypto_scalarmult(q,n,basepoint);
  return 0;
}


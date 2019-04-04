#ifndef __POLY1305_VALE_H
#define __POLY1305_VALE_H

#include <stdio.h>
#include "gcc_compat.h"
#include <stdint.h>
#include <string.h>

typedef struct ctxt
{
    uint64_t h0;
    uint64_t h1;
    uint64_t h2;
    uint64_t key_r0;

    uint64_t key_r1;
    uint64_t key_s0;
    uint64_t key_s1;
    uint64_t scratch0;
    
    uint64_t scratch[24 - 8];
} ctxt;

#endif // __POLY1305_VALE_H

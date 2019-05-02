#include <stdio.h>

typedef unsigned char u8;
typedef unsigned long long u64;

extern void __KeccakF1600_wrapper(u64 r[7*4],
                                  u64 _rhotates_left[6*4],
                                  u64 _rhotates_right[6*4],
                                  u64 _iotas[24*4]);


u64 rhotates_left[6*4] = {
     3,   18,    36,    41,
     1,   62,    28,    27,
    45,    6,    56,    39,
    10,   61,    55,     8,
     2,   15,    25,    20,
    44,   43,    21,    14 };


u64 rhotates_right[6*4] = {
    64-3,  64-18,  64-36,  64-41,
    64-1,  64-62,  64-28,  64-27,
    64-45, 64-6,   64-56,  64-39,
    64-10, 64-61,  64-55,  64-8,
    64-2,  64-15,  64-25,  64-20,
    64-44, 64-43,  64-21,  64-14 };

u64 iotas[24*4] = {
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

int main() {
    u64 in0[7*4] = {
        0x0000000000000000UL, 0x0000000000000000UL, 0x0000000000000000UL, 0x0000000000000000UL, 
        0x0000000000000000UL, 0x0000000000000000UL, 0x0000000000000000UL, 0x0000000000000000UL, 
        0x0000000000000000UL, 0x0000000000000000UL, 0x0000000000000000UL, 0x0000000000000000UL, 
        0x0000000000000000UL, 0x0000000000000000UL, 0x0000000000000000UL, 0x0000000000000000UL, 
        0x0000000000000000UL, 0x0000000000000000UL, 0x0000000000000000UL, 0x0000000000000000UL, 
        0x0000000000000000UL, 0x0000000000000000UL, 0x0000000000000000UL, 0x0000000000000000UL,
        0x0000000000000000UL, 0x0000000000000000UL, 0x0000000000000000UL, 0x0000000000000000UL
    };
    __KeccakF1600_wrapper(in0,rhotates_left,rhotates_right,iotas);
    printf("%16llx %16llx %16llx %16llx\n",
    	in0[0],in0[1],in0[2],in0[3]);
    printf("%16llx %16llx %16llx %16llx\n",
    	in0[4],in0[5],in0[6],in0[7]);
    printf("%16llx %16llx %16llx %16llx\n",
    	in0[8],in0[9],in0[10],in0[11]);
    printf("%16llx %16llx %16llx %16llx\n",
    	in0[12],in0[13],in0[14],in0[15]);
    printf("%16llx %16llx %16llx %16llx\n",
    	in0[16],in0[17],in0[18],in0[19]);
    printf("%16llx %16llx %16llx %16llx\n",
    	in0[20],in0[21],in0[22],in0[23]);
    printf("%16llx %16llx %16llx %16llx\n",
    	in0[24],in0[25],in0[26],in0[27]);
	return 0;
}
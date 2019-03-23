typedef uint8_t u8;
typedef uint64_t u64;

static force_inline u8 /*bool*/ _addcarryx_u51(u8 /*bool*/ c, u64 a, u64 b, u64 *low)
{
	/* This function extracts 51 bits of result and 1 bit of carry (52 total), so
	 *a 64-bit intermediate is sufficient.
	 */
	u64 x = a + b + c;
	*low = x & ((1ULL << 51) - 1);
	return (x >> 51) & 1;
}

static force_inline u8 /*bool*/ _subborrow_u51(u8 /*bool*/ c, u64 a, u64 b, u64 *low)
{
	/* This function extracts 51 bits of result and 1 bit of borrow (52 total), so
	 * a 64-bit intermediate is sufficient.
	 */
	u64 x = a - b - c;
	*low = x & ((1ULL << 51) - 1);
	return x >> 63;
}

# Very Short Introduction to the Jasmin Programming Language
STATUS : early draft

This is a very light introduction to the Jasmin language from a programmers point
of view. Its main goal is to give an intuition to the reader on how to write Jasmin
programs and what are the main concerns that one should keep in mind when developing
in Jasmin -- which means that this short tutorial only covers the basics and purposely
ignores some cases that don't fit in the 'main' to keep it simple enough. Mainly
because in assembly there is no exception without rule... Wait. Rule without exception.
Hope you have fun. Please assume `x64`.

## Data Types

There are different data types in Jasmin, we can start by unsigned integers in the 
context of `x64` non-vectorized code, these are: `u8; u16; u32; u64` for 8, 16, 32
and 64 bits variables, respectively. When using `AVX/AVX2` extensions the types
`u128` and `u256` are also available.

A programmer with a C/C++ background is now probably expecting to read some mention
to pointers but, in Jasmin there is no specific type declarator for these: variables
that hold pointers are also declared as `u64`.

It is also possible to declare arrays of fixed size of the previously mentioned
types with, for example, `u64[10]` for an array with 10 elements with the type
`u64`.

`inline int` is typically used for compile-time know values/unrolling and `bool`
for the `CPU` flags, such as the carry flag and zero flag, to give a couple of 
examples. 

## Storage Classes, Declarations and Arrays Accesses

Jasmin differs from most programming languages here (and it is similar to `qhasm`):
it is **mandatory** to specify 'where' a given variable 'stays': it can be in a CPU 
`reg`ister or in `stack`.

For example, if we want to declare an array `z` with 10 elements with the type `u64`
that lies in the stack frame (`stack`) we can achieve that by declaring `z` such as:
`stack u64[10] z;`. Imagine that `x` and `y` are also arrays sharing the same type,
then the declaration of them could -- but not necessarily since they could be declared
independently across different lines --- go as: `stack u64[10] x y z;`.

If all these values were to be in registers then: `reg u64[10] x y z;` would do it.

Worth to mention again that the length of any array declared in Jasmin, `reg` or `stack
should be statically known. `bool` should be declared as `reg`. An `inline int` is treated as
a constant value so it doesn't need anything more. Some examples on variables declarations:

```
inline int j;
reg u32 a s m;
reg u128 i;
stack u256[101] n;
reg bool cf zf;

// this is a line comment btw
```

As final notes of this section, when accessing a register array the **index** should
be statically known: by using either a constant or an `inline int`; for `stack` arrays
the index can be constant or 'dynamic', which means that the offset could be in a
`reg u64` variable for instance. Imagine an array `r`, declared as a `reg u64[3]`
and `s` having type `u64[3]`, `i` being an `inline int` and `index` declared as `reg u64`:

```
i = 1;
index = 2;
r[0] = s[0];
r[1] = s[i];
r[2] = s[(int) index];

/* and this is a multi-line comment...
   ...btw
 */
```

The presented code basically loads the contents of `s` (stack) into `r` (registers).
If `s` and `r` have the same length, which is the case, then we can simply write
the following code:

```
r = s;  // load s[0..2] into r[0..2]
s = r;  // store r[0..2] into s[0..2]
```

## How Stack Works - Some Considerations

To have a better understanding of how the stack works, from a programmer's point
of view that likes to understand how stuff works under the hood, let's start by
saying that there are 16 different registers in a `x64` processor. From these 16
registers only 15 are available to use: `rsp` (stack pointer) is reserved by the
Jasmin compiler handle `stack` variables.

As such, all variables/arrays declared with the `stack` type will be placed in the 
stack-frame and will be accessed by using the stack pointer (`rsp`) as a base address
(the programmer doesn't really need to worry about this).

Also interesting is that the Jasmin compiler will try to minimize the needed stack
space by 'merging' stack variables if their liveness doesn't intersect -- in summary,
sometimes the needed stack space is not equal to the sum of all stack variables,
it can be less, which frees the programmer from this task of stack space optimization.

While it can be obvious to programmers that are familiar with low level languages,
it is worth to mention that the main reason for stack variables / arrays to exist
is because there are not enough registers.

To give an intuition, stack variables are mainly used to temporarily store values
in the memory such that we can have more free registers, or to hold read-only values,
as some assembly operations allow one operand to be a stack value. 

For instance, imagine a -- quite common -- case where there is a variable named
`out` declared as `reg u64` that holds an output pointer to store the results of
a given computation and that:

 * this variable is not used until the very end of the program/function
 * we need the 15 registers to perform out computation faster

Probably the best thing to do is to store this value into a `stack u64 out_s`
variable to free the register that contains `out`:
```
out_s = out;

// do some very fast, world-speed-record computation

out = out_s; 
```

### Variable Size Access

```
stack u256[4] s;
reg u64[4] r;

r[0] = r256[u64 0];
r[1] = r256[u64 4];
r[2] = r256[u64 8];
r[3] = r256[u64 12];
```

(where u64 could be replaced by any lower unit)

## How Memory Works

(receives input pointer in)

```
reg u64[4] r;

r[0] = [in + 8*0];
r[1] = [in + 8*1];
r[2] = [in + 8*2];
r[3] = [in + 8*3];
```

## Register allocation
(no more register to allocate 'name of variable' followed by a '#' and a seemingly strange number : you should perform some spills)

### General Overview
### (possible failures, inlining, possible warnings)
* all non exported functions are inlined - this should only be mentioned in functions section and introduced throughout the explanation for the inline ints / for
* possible warnings about lea; assigns of inline ints (not to worry); maybe more but I need to write 'strange' code to make them appear.
* failures - difficult to state non-trivial failures - it should be example oriented and it should be written through time

## Operators (high-level, low-level, flags)
```
//add/sub with carry - from poly1305 or curve25519 mulx

//avx avx2: adds +8u64= ... xors ^= ... 

```

## Control Flow - Loops (for, while, if)

```
inline int i;
for i=0 to 4
{ r[i] = a[i*2]; } // explain that this will be fully unrolled

// And there could be fully unrolled if's

// and whiles

x = 0;
while(x < 10){
  /* loop body here */
  x++;
}

// or
x = 0;
while{
  x++;
}(x < 10)

// or

x = 10;
while{

 (_,_,_,zf,c) = #x86_DEC(c);
}(!zf)

```

Note: There are some cases where it can be useful to perform control flow tests directly in `stack` values.

-- TODO: the other reason besides the main reason defined in How the stack works
can be stated here with a memory copy example from ChaCha20

## Functions Overview
Worth to mention:
* Functions are inlined, receive an arbitrary number of arguments and return another arbitrary set of arguments (could be zero)
* If you change/modify (even if you restore it to the previous value, for instance: p = p + 1; // p = p -1; ) one of the function inputs and you need it live then you should also return it to make these changes visible to the caller function.

### Exporting functions
* Begin the declaration of the function with the 'export' keyword.
* System V AMD64 ABI
* RDI, RSI, RDX, RCX, R8, R9
* If any of the instructions need one of the registers arguments (mul) then this value will have to be dummy assigned or spilled into mem





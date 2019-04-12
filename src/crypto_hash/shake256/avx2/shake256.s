	.text
	.p2align	5
	.globl	_shake256_avx2_jazz
	.globl	shake256_avx2_jazz
_shake256_avx2_jazz:
shake256_avx2_jazz:
	pushq	%rbp
	subq	$24, %rsp
	movq	%rdi, 16(%rsp)
	movq	(%rcx), %rax
	movq	8(%rcx), %rdi
	movq	16(%rcx), %r8
	movq	24(%rcx), %rcx
	jmp 	Lshake256_avx2_jazz$17
Lshake256_avx2_jazz$18:
	movq	(%rsi), %r9
	xorq	%r9, (%rax)
	movq	8(%rsi), %r9
	xorq	%r9, 8(%rax)
	movq	16(%rsi), %r9
	xorq	%r9, 16(%rax)
	movq	24(%rsi), %r9
	xorq	%r9, 24(%rax)
	movq	32(%rsi), %r9
	xorq	%r9, 32(%rax)
	movq	40(%rsi), %r9
	xorq	%r9, 40(%rax)
	movq	48(%rsi), %r9
	xorq	%r9, 48(%rax)
	movq	56(%rsi), %r9
	xorq	%r9, 56(%rax)
	movq	64(%rsi), %r9
	xorq	%r9, 64(%rax)
	movq	72(%rsi), %r9
	xorq	%r9, 72(%rax)
	movq	80(%rsi), %r9
	xorq	%r9, 80(%rax)
	movq	88(%rsi), %r9
	xorq	%r9, 88(%rax)
	movq	96(%rsi), %r9
	xorq	%r9, 96(%rax)
	movq	104(%rsi), %r9
	xorq	%r9, 104(%rax)
	movq	112(%rsi), %r9
	xorq	%r9, 112(%rax)
	movq	120(%rsi), %r9
	xorq	%r9, 120(%rax)
	movq	128(%rsi), %r9
	xorq	%r9, 128(%rax)
	leaq	136(%rsi), %rsi
	leaq	-136(%rdx), %rdx
	movq	%rsi, 8(%rsp)
	movq	%rdx, (%rsp)
	vmovdqu	(%rax), %ymm0
	vmovdqu	32(%rax), %ymm1
	vmovdqu	64(%rax), %ymm2
	vmovdqu	96(%rax), %ymm3
	vmovdqu	128(%rax), %ymm4
	vmovdqu	160(%rax), %ymm5
	vmovdqu	192(%rax), %ymm6
	leaq	96(%rdi), %rdx
	leaq	96(%r8), %rsi
	movq	%rcx, %r9
	movl	$24, %r10d
Lshake256_avx2_jazz$19:
	vpshufd	$78, %ymm2, %ymm7
	vpxor	%ymm3, %ymm5, %ymm8
	vpxor	%ymm6, %ymm4, %ymm9
	vpxor	%ymm1, %ymm8, %ymm8
	vpxor	%ymm9, %ymm8, %ymm8
	vpermq	$-109, %ymm8, %ymm9
	vpxor	%ymm2, %ymm7, %ymm7
	vpermq	$78, %ymm7, %ymm10
	vpsrlq	$63, %ymm8, %ymm11
	vpaddq	%ymm8, %ymm8, %ymm8
	vpor	%ymm8, %ymm11, %ymm8
	vpermq	$57, %ymm8, %ymm11
	vpxor	%ymm9, %ymm8, %ymm8
	vpermq	$0, %ymm8, %ymm8
	vpxor	%ymm0, %ymm7, %ymm7
	vpxor	%ymm10, %ymm7, %ymm7
	vpsrlq	$63, %ymm7, %ymm10
	vpaddq	%ymm7, %ymm7, %ymm12
	vpor	%ymm10, %ymm12, %ymm10
	vpxor	%ymm8, %ymm2, %ymm2
	vpxor	%ymm8, %ymm0, %ymm0
	vpblendd	$-64, %ymm10, %ymm11, %ymm8
	vpblendd	$3, %ymm7, %ymm9, %ymm7
	vpxor	%ymm7, %ymm8, %ymm7
	vpsllvq	-96(%rdx), %ymm2, %ymm8
	vpsrlvq	-96(%rsi), %ymm2, %ymm2
	vpor	%ymm8, %ymm2, %ymm2
	vpxor	%ymm7, %ymm3, %ymm3
	vpsllvq	-32(%rdx), %ymm3, %ymm8
	vpsrlvq	-32(%rsi), %ymm3, %ymm3
	vpor	%ymm8, %ymm3, %ymm3
	vpxor	%ymm7, %ymm4, %ymm4
	vpsllvq	(%rdx), %ymm4, %ymm8
	vpsrlvq	(%rsi), %ymm4, %ymm4
	vpor	%ymm8, %ymm4, %ymm4
	vpxor	%ymm7, %ymm5, %ymm5
	vpsllvq	32(%rdx), %ymm5, %ymm8
	vpsrlvq	32(%rsi), %ymm5, %ymm5
	vpor	%ymm8, %ymm5, %ymm5
	vpxor	%ymm7, %ymm6, %ymm6
	vpermq	$-115, %ymm2, %ymm8
	vpermq	$-115, %ymm3, %ymm9
	vpsllvq	64(%rdx), %ymm6, %ymm2
	vpsrlvq	64(%rsi), %ymm6, %ymm3
	vpor	%ymm2, %ymm3, %ymm10
	vpxor	%ymm7, %ymm1, %ymm1
	vpermq	$27, %ymm4, %ymm4
	vpermq	$114, %ymm5, %ymm7
	vpsllvq	-64(%rdx), %ymm1, %ymm2
	vpsrlvq	-64(%rsi), %ymm1, %ymm1
	vpor	%ymm2, %ymm1, %ymm1
	vpsrldq	$8, %ymm10, %ymm2
	vpandn	%ymm2, %ymm10, %ymm3
	vpblendd	$12, %ymm7, %ymm1, %ymm2
	vpblendd	$12, %ymm1, %ymm9, %ymm5
	vpblendd	$12, %ymm9, %ymm8, %ymm6
	vpblendd	$12, %ymm8, %ymm1, %ymm11
	vpblendd	$48, %ymm9, %ymm2, %ymm2
	vpblendd	$48, %ymm4, %ymm5, %ymm5
	vpblendd	$48, %ymm1, %ymm6, %ymm6
	vpblendd	$48, %ymm7, %ymm11, %ymm11
	vpblendd	$-64, %ymm4, %ymm2, %ymm2
	vpblendd	$-64, %ymm7, %ymm5, %ymm5
	vpblendd	$-64, %ymm7, %ymm6, %ymm6
	vpblendd	$-64, %ymm9, %ymm11, %ymm11
	vpandn	%ymm5, %ymm2, %ymm2
	vpandn	%ymm11, %ymm6, %ymm5
	vpblendd	$12, %ymm1, %ymm4, %ymm6
	vpblendd	$12, %ymm4, %ymm8, %ymm11
	vpxor	%ymm8, %ymm2, %ymm12
	vpblendd	$48, %ymm8, %ymm6, %ymm2
	vpblendd	$48, %ymm9, %ymm11, %ymm6
	vpxor	%ymm4, %ymm5, %ymm5
	vpblendd	$-64, %ymm9, %ymm2, %ymm2
	vpblendd	$-64, %ymm1, %ymm6, %ymm6
	vpandn	%ymm6, %ymm2, %ymm2
	vpxor	%ymm7, %ymm2, %ymm6
	vpermq	$30, %ymm10, %ymm2
	vpblendd	$48, %ymm0, %ymm2, %ymm2
	vpermq	$57, %ymm10, %ymm11
	vpblendd	$-64, %ymm0, %ymm11, %ymm11
	vpandn	%ymm2, %ymm11, %ymm11
	vpblendd	$12, %ymm4, %ymm9, %ymm2
	vpblendd	$12, %ymm9, %ymm7, %ymm13
	vpblendd	$48, %ymm7, %ymm2, %ymm2
	vpblendd	$48, %ymm8, %ymm13, %ymm13
	vpblendd	$-64, %ymm8, %ymm2, %ymm2
	vpblendd	$-64, %ymm4, %ymm13, %ymm13
	vpandn	%ymm13, %ymm2, %ymm2
	vpxor	%ymm1, %ymm2, %ymm2
	vpermq	$0, %ymm3, %ymm13
	vpermq	$27, %ymm12, %ymm3
	vpermq	$-115, %ymm5, %ymm5
	vpermq	$114, %ymm6, %ymm6
	vpblendd	$12, %ymm8, %ymm7, %ymm12
	vpblendd	$12, %ymm7, %ymm4, %ymm7
	vpblendd	$48, %ymm4, %ymm12, %ymm4
	vpblendd	$48, %ymm1, %ymm7, %ymm7
	vpblendd	$-64, %ymm1, %ymm4, %ymm1
	vpblendd	$-64, %ymm8, %ymm7, %ymm4
	vpandn	%ymm4, %ymm1, %ymm4
	vpxor	%ymm13, %ymm0, %ymm0
	vpxor	%ymm10, %ymm11, %ymm1
	vpxor	%ymm9, %ymm4, %ymm4
	vpxor	(%r9), %ymm0, %ymm0
	leaq	32(%r9), %r9
	decl	%r10d
	jne 	Lshake256_avx2_jazz$19
	vmovdqu	%ymm0, (%rax)
	vmovdqu	%ymm1, 32(%rax)
	vmovdqu	%ymm2, 64(%rax)
	vmovdqu	%ymm3, 96(%rax)
	vmovdqu	%ymm4, 128(%rax)
	vmovdqu	%ymm5, 160(%rax)
	vmovdqu	%ymm6, 192(%rax)
	movq	8(%rsp), %rsi
	movq	(%rsp), %rdx
Lshake256_avx2_jazz$17:
	cmpq	$136, %rdx
	jnb 	Lshake256_avx2_jazz$18
	movq	%rdx, %r9
	shrq	$3, %r9
	movq	$0, %r10
	jmp 	Lshake256_avx2_jazz$15
Lshake256_avx2_jazz$16:
	movq	(%rsi,%r10,8), %r11
	xorq	%r11, (%rax,%r10,8)
	leaq	1(%r10), %r10
Lshake256_avx2_jazz$15:
	cmpq	%r9, %r10
	jb  	Lshake256_avx2_jazz$16
	shlq	$3, %r10
	jmp 	Lshake256_avx2_jazz$13
Lshake256_avx2_jazz$14:
	movb	(%rsi,%r10), %r9b
	xorb	%r9b, (%rax,%r10)
	leaq	1(%r10), %r10
Lshake256_avx2_jazz$13:
	cmpq	%rdx, %r10
	jb  	Lshake256_avx2_jazz$14
	xorb	$31, (%rax,%r10)
	xorb	$-128, 135(%rax)
	vmovdqu	(%rax), %ymm0
	vmovdqu	32(%rax), %ymm1
	vmovdqu	64(%rax), %ymm2
	vmovdqu	96(%rax), %ymm3
	vmovdqu	128(%rax), %ymm4
	vmovdqu	160(%rax), %ymm5
	vmovdqu	192(%rax), %ymm6
	leaq	96(%rdi), %rdx
	leaq	96(%r8), %rsi
	movq	%rcx, %r9
	movl	$24, %r10d
Lshake256_avx2_jazz$12:
	vpshufd	$78, %ymm2, %ymm7
	vpxor	%ymm3, %ymm5, %ymm8
	vpxor	%ymm6, %ymm4, %ymm9
	vpxor	%ymm1, %ymm8, %ymm8
	vpxor	%ymm9, %ymm8, %ymm8
	vpermq	$-109, %ymm8, %ymm9
	vpxor	%ymm2, %ymm7, %ymm7
	vpermq	$78, %ymm7, %ymm10
	vpsrlq	$63, %ymm8, %ymm11
	vpaddq	%ymm8, %ymm8, %ymm8
	vpor	%ymm8, %ymm11, %ymm8
	vpermq	$57, %ymm8, %ymm11
	vpxor	%ymm9, %ymm8, %ymm8
	vpermq	$0, %ymm8, %ymm8
	vpxor	%ymm0, %ymm7, %ymm7
	vpxor	%ymm10, %ymm7, %ymm7
	vpsrlq	$63, %ymm7, %ymm10
	vpaddq	%ymm7, %ymm7, %ymm12
	vpor	%ymm10, %ymm12, %ymm10
	vpxor	%ymm8, %ymm2, %ymm2
	vpxor	%ymm8, %ymm0, %ymm0
	vpblendd	$-64, %ymm10, %ymm11, %ymm8
	vpblendd	$3, %ymm7, %ymm9, %ymm7
	vpxor	%ymm7, %ymm8, %ymm7
	vpsllvq	-96(%rdx), %ymm2, %ymm8
	vpsrlvq	-96(%rsi), %ymm2, %ymm2
	vpor	%ymm8, %ymm2, %ymm2
	vpxor	%ymm7, %ymm3, %ymm3
	vpsllvq	-32(%rdx), %ymm3, %ymm8
	vpsrlvq	-32(%rsi), %ymm3, %ymm3
	vpor	%ymm8, %ymm3, %ymm3
	vpxor	%ymm7, %ymm4, %ymm4
	vpsllvq	(%rdx), %ymm4, %ymm8
	vpsrlvq	(%rsi), %ymm4, %ymm4
	vpor	%ymm8, %ymm4, %ymm4
	vpxor	%ymm7, %ymm5, %ymm5
	vpsllvq	32(%rdx), %ymm5, %ymm8
	vpsrlvq	32(%rsi), %ymm5, %ymm5
	vpor	%ymm8, %ymm5, %ymm5
	vpxor	%ymm7, %ymm6, %ymm6
	vpermq	$-115, %ymm2, %ymm8
	vpermq	$-115, %ymm3, %ymm9
	vpsllvq	64(%rdx), %ymm6, %ymm2
	vpsrlvq	64(%rsi), %ymm6, %ymm3
	vpor	%ymm2, %ymm3, %ymm10
	vpxor	%ymm7, %ymm1, %ymm1
	vpermq	$27, %ymm4, %ymm4
	vpermq	$114, %ymm5, %ymm7
	vpsllvq	-64(%rdx), %ymm1, %ymm2
	vpsrlvq	-64(%rsi), %ymm1, %ymm1
	vpor	%ymm2, %ymm1, %ymm1
	vpsrldq	$8, %ymm10, %ymm2
	vpandn	%ymm2, %ymm10, %ymm3
	vpblendd	$12, %ymm7, %ymm1, %ymm2
	vpblendd	$12, %ymm1, %ymm9, %ymm5
	vpblendd	$12, %ymm9, %ymm8, %ymm6
	vpblendd	$12, %ymm8, %ymm1, %ymm11
	vpblendd	$48, %ymm9, %ymm2, %ymm2
	vpblendd	$48, %ymm4, %ymm5, %ymm5
	vpblendd	$48, %ymm1, %ymm6, %ymm6
	vpblendd	$48, %ymm7, %ymm11, %ymm11
	vpblendd	$-64, %ymm4, %ymm2, %ymm2
	vpblendd	$-64, %ymm7, %ymm5, %ymm5
	vpblendd	$-64, %ymm7, %ymm6, %ymm6
	vpblendd	$-64, %ymm9, %ymm11, %ymm11
	vpandn	%ymm5, %ymm2, %ymm2
	vpandn	%ymm11, %ymm6, %ymm5
	vpblendd	$12, %ymm1, %ymm4, %ymm6
	vpblendd	$12, %ymm4, %ymm8, %ymm11
	vpxor	%ymm8, %ymm2, %ymm12
	vpblendd	$48, %ymm8, %ymm6, %ymm2
	vpblendd	$48, %ymm9, %ymm11, %ymm6
	vpxor	%ymm4, %ymm5, %ymm5
	vpblendd	$-64, %ymm9, %ymm2, %ymm2
	vpblendd	$-64, %ymm1, %ymm6, %ymm6
	vpandn	%ymm6, %ymm2, %ymm2
	vpxor	%ymm7, %ymm2, %ymm6
	vpermq	$30, %ymm10, %ymm2
	vpblendd	$48, %ymm0, %ymm2, %ymm2
	vpermq	$57, %ymm10, %ymm11
	vpblendd	$-64, %ymm0, %ymm11, %ymm11
	vpandn	%ymm2, %ymm11, %ymm11
	vpblendd	$12, %ymm4, %ymm9, %ymm2
	vpblendd	$12, %ymm9, %ymm7, %ymm13
	vpblendd	$48, %ymm7, %ymm2, %ymm2
	vpblendd	$48, %ymm8, %ymm13, %ymm13
	vpblendd	$-64, %ymm8, %ymm2, %ymm2
	vpblendd	$-64, %ymm4, %ymm13, %ymm13
	vpandn	%ymm13, %ymm2, %ymm2
	vpxor	%ymm1, %ymm2, %ymm2
	vpermq	$0, %ymm3, %ymm13
	vpermq	$27, %ymm12, %ymm3
	vpermq	$-115, %ymm5, %ymm5
	vpermq	$114, %ymm6, %ymm6
	vpblendd	$12, %ymm8, %ymm7, %ymm12
	vpblendd	$12, %ymm7, %ymm4, %ymm7
	vpblendd	$48, %ymm4, %ymm12, %ymm4
	vpblendd	$48, %ymm1, %ymm7, %ymm7
	vpblendd	$-64, %ymm1, %ymm4, %ymm1
	vpblendd	$-64, %ymm8, %ymm7, %ymm4
	vpandn	%ymm4, %ymm1, %ymm4
	vpxor	%ymm13, %ymm0, %ymm0
	vpxor	%ymm10, %ymm11, %ymm1
	vpxor	%ymm9, %ymm4, %ymm4
	vpxor	(%r9), %ymm0, %ymm0
	leaq	32(%r9), %r9
	decl	%r10d
	jne 	Lshake256_avx2_jazz$12
	vmovdqu	%ymm0, (%rax)
	vmovdqu	%ymm1, 32(%rax)
	vmovdqu	%ymm2, 64(%rax)
	vmovdqu	%ymm3, 96(%rax)
	vmovdqu	%ymm4, 128(%rax)
	vmovdqu	%ymm5, 160(%rax)
	vmovdqu	%ymm6, 192(%rax)
	movq	16(%rsp), %rdx
	movq	$136, 16(%rsp)
	jmp 	Lshake256_avx2_jazz$5
Lshake256_avx2_jazz$6:
	movq	$136, %rsi
	movq	%rsi, %r9
	shrq	$3, %r9
	movq	$0, %r10
	jmp 	Lshake256_avx2_jazz$10
Lshake256_avx2_jazz$11:
	movq	(%rax,%r10,8), %r11
	movq	%r11, (%rdx,%r10,8)
	leaq	1(%r10), %r10
Lshake256_avx2_jazz$10:
	cmpq	%r9, %r10
	jb  	Lshake256_avx2_jazz$11
	shlq	$3, %r10
	jmp 	Lshake256_avx2_jazz$8
Lshake256_avx2_jazz$9:
	movb	(%rax,%r10), %r9b
	movb	%r9b, (%rdx,%r10)
	leaq	1(%r10), %r10
Lshake256_avx2_jazz$8:
	cmpq	%rsi, %r10
	jb  	Lshake256_avx2_jazz$9
	leaq	(%rdx,%rsi), %rdx
	movq	%rdx, 8(%rsp)
	vmovdqu	(%rax), %ymm0
	vmovdqu	32(%rax), %ymm1
	vmovdqu	64(%rax), %ymm2
	vmovdqu	96(%rax), %ymm3
	vmovdqu	128(%rax), %ymm4
	vmovdqu	160(%rax), %ymm5
	vmovdqu	192(%rax), %ymm6
	leaq	96(%rdi), %rdx
	leaq	96(%r8), %rsi
	movq	%rcx, %r9
	movl	$24, %r10d
Lshake256_avx2_jazz$7:
	vpshufd	$78, %ymm2, %ymm7
	vpxor	%ymm3, %ymm5, %ymm8
	vpxor	%ymm6, %ymm4, %ymm9
	vpxor	%ymm1, %ymm8, %ymm8
	vpxor	%ymm9, %ymm8, %ymm8
	vpermq	$-109, %ymm8, %ymm9
	vpxor	%ymm2, %ymm7, %ymm7
	vpermq	$78, %ymm7, %ymm10
	vpsrlq	$63, %ymm8, %ymm11
	vpaddq	%ymm8, %ymm8, %ymm8
	vpor	%ymm8, %ymm11, %ymm8
	vpermq	$57, %ymm8, %ymm11
	vpxor	%ymm9, %ymm8, %ymm8
	vpermq	$0, %ymm8, %ymm8
	vpxor	%ymm0, %ymm7, %ymm7
	vpxor	%ymm10, %ymm7, %ymm7
	vpsrlq	$63, %ymm7, %ymm10
	vpaddq	%ymm7, %ymm7, %ymm12
	vpor	%ymm10, %ymm12, %ymm10
	vpxor	%ymm8, %ymm2, %ymm2
	vpxor	%ymm8, %ymm0, %ymm0
	vpblendd	$-64, %ymm10, %ymm11, %ymm8
	vpblendd	$3, %ymm7, %ymm9, %ymm7
	vpxor	%ymm7, %ymm8, %ymm7
	vpsllvq	-96(%rdx), %ymm2, %ymm8
	vpsrlvq	-96(%rsi), %ymm2, %ymm2
	vpor	%ymm8, %ymm2, %ymm2
	vpxor	%ymm7, %ymm3, %ymm3
	vpsllvq	-32(%rdx), %ymm3, %ymm8
	vpsrlvq	-32(%rsi), %ymm3, %ymm3
	vpor	%ymm8, %ymm3, %ymm3
	vpxor	%ymm7, %ymm4, %ymm4
	vpsllvq	(%rdx), %ymm4, %ymm8
	vpsrlvq	(%rsi), %ymm4, %ymm4
	vpor	%ymm8, %ymm4, %ymm4
	vpxor	%ymm7, %ymm5, %ymm5
	vpsllvq	32(%rdx), %ymm5, %ymm8
	vpsrlvq	32(%rsi), %ymm5, %ymm5
	vpor	%ymm8, %ymm5, %ymm5
	vpxor	%ymm7, %ymm6, %ymm6
	vpermq	$-115, %ymm2, %ymm8
	vpermq	$-115, %ymm3, %ymm9
	vpsllvq	64(%rdx), %ymm6, %ymm2
	vpsrlvq	64(%rsi), %ymm6, %ymm3
	vpor	%ymm2, %ymm3, %ymm10
	vpxor	%ymm7, %ymm1, %ymm1
	vpermq	$27, %ymm4, %ymm4
	vpermq	$114, %ymm5, %ymm7
	vpsllvq	-64(%rdx), %ymm1, %ymm2
	vpsrlvq	-64(%rsi), %ymm1, %ymm1
	vpor	%ymm2, %ymm1, %ymm1
	vpsrldq	$8, %ymm10, %ymm2
	vpandn	%ymm2, %ymm10, %ymm3
	vpblendd	$12, %ymm7, %ymm1, %ymm2
	vpblendd	$12, %ymm1, %ymm9, %ymm5
	vpblendd	$12, %ymm9, %ymm8, %ymm6
	vpblendd	$12, %ymm8, %ymm1, %ymm11
	vpblendd	$48, %ymm9, %ymm2, %ymm2
	vpblendd	$48, %ymm4, %ymm5, %ymm5
	vpblendd	$48, %ymm1, %ymm6, %ymm6
	vpblendd	$48, %ymm7, %ymm11, %ymm11
	vpblendd	$-64, %ymm4, %ymm2, %ymm2
	vpblendd	$-64, %ymm7, %ymm5, %ymm5
	vpblendd	$-64, %ymm7, %ymm6, %ymm6
	vpblendd	$-64, %ymm9, %ymm11, %ymm11
	vpandn	%ymm5, %ymm2, %ymm2
	vpandn	%ymm11, %ymm6, %ymm5
	vpblendd	$12, %ymm1, %ymm4, %ymm6
	vpblendd	$12, %ymm4, %ymm8, %ymm11
	vpxor	%ymm8, %ymm2, %ymm12
	vpblendd	$48, %ymm8, %ymm6, %ymm2
	vpblendd	$48, %ymm9, %ymm11, %ymm6
	vpxor	%ymm4, %ymm5, %ymm5
	vpblendd	$-64, %ymm9, %ymm2, %ymm2
	vpblendd	$-64, %ymm1, %ymm6, %ymm6
	vpandn	%ymm6, %ymm2, %ymm2
	vpxor	%ymm7, %ymm2, %ymm6
	vpermq	$30, %ymm10, %ymm2
	vpblendd	$48, %ymm0, %ymm2, %ymm2
	vpermq	$57, %ymm10, %ymm11
	vpblendd	$-64, %ymm0, %ymm11, %ymm11
	vpandn	%ymm2, %ymm11, %ymm11
	vpblendd	$12, %ymm4, %ymm9, %ymm2
	vpblendd	$12, %ymm9, %ymm7, %ymm13
	vpblendd	$48, %ymm7, %ymm2, %ymm2
	vpblendd	$48, %ymm8, %ymm13, %ymm13
	vpblendd	$-64, %ymm8, %ymm2, %ymm2
	vpblendd	$-64, %ymm4, %ymm13, %ymm13
	vpandn	%ymm13, %ymm2, %ymm2
	vpxor	%ymm1, %ymm2, %ymm2
	vpermq	$0, %ymm3, %ymm13
	vpermq	$27, %ymm12, %ymm3
	vpermq	$-115, %ymm5, %ymm5
	vpermq	$114, %ymm6, %ymm6
	vpblendd	$12, %ymm8, %ymm7, %ymm12
	vpblendd	$12, %ymm7, %ymm4, %ymm7
	vpblendd	$48, %ymm4, %ymm12, %ymm4
	vpblendd	$48, %ymm1, %ymm7, %ymm7
	vpblendd	$-64, %ymm1, %ymm4, %ymm1
	vpblendd	$-64, %ymm8, %ymm7, %ymm4
	vpandn	%ymm4, %ymm1, %ymm4
	vpxor	%ymm13, %ymm0, %ymm0
	vpxor	%ymm10, %ymm11, %ymm1
	vpxor	%ymm9, %ymm4, %ymm4
	vpxor	(%r9), %ymm0, %ymm0
	leaq	32(%r9), %r9
	decl	%r10d
	jne 	Lshake256_avx2_jazz$7
	vmovdqu	%ymm0, (%rax)
	vmovdqu	%ymm1, 32(%rax)
	vmovdqu	%ymm2, 64(%rax)
	vmovdqu	%ymm3, 96(%rax)
	vmovdqu	%ymm4, 128(%rax)
	vmovdqu	%ymm5, 160(%rax)
	vmovdqu	%ymm6, 192(%rax)
	subq	$136, 16(%rsp)
	movq	8(%rsp), %rdx
Lshake256_avx2_jazz$5:
	cmpq	$136, 16(%rsp)
	jnb 	Lshake256_avx2_jazz$6
	movq	16(%rsp), %rcx
	movq	%rcx, %rsi
	shrq	$3, %rsi
	movq	$0, %rdi
	jmp 	Lshake256_avx2_jazz$3
Lshake256_avx2_jazz$4:
	movq	(%rax,%rdi,8), %r8
	movq	%r8, (%rdx,%rdi,8)
	leaq	1(%rdi), %rdi
Lshake256_avx2_jazz$3:
	cmpq	%rsi, %rdi
	jb  	Lshake256_avx2_jazz$4
	shlq	$3, %rdi
	jmp 	Lshake256_avx2_jazz$1
Lshake256_avx2_jazz$2:
	movb	(%rax,%rdi), %sil
	movb	%sil, (%rdx,%rdi)
	leaq	1(%rdi), %rdi
Lshake256_avx2_jazz$1:
	cmpq	%rcx, %rdi
	jb  	Lshake256_avx2_jazz$2
	addq	$24, %rsp
	popq	%rbp
	ret 

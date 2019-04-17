	.text
	.p2align	5
	.globl	_shake128_avx2_jazz
	.globl	shake128_avx2_jazz
_shake128_avx2_jazz:
shake128_avx2_jazz:
	pushq	%rbp
	pushq	%rbx
	subq	$256, %rsp
	vpbroadcastq	g_zero(%rip), %ymm2
	vmovdqu	%ymm2, %ymm3
	vmovdqu	%ymm2, %ymm4
	vmovdqu	%ymm2, %ymm12
	vmovdqu	%ymm2, %ymm10
	vmovdqu	%ymm2, %ymm11
	vmovdqu	%ymm2, %ymm9
	movq	(%rcx), %rax
	movq	8(%rcx), %r8
	movq	16(%rcx), %r9
	movq	24(%rcx), %rcx
	jmp 	Lshake128_avx2_jazz$17
Lshake128_avx2_jazz$18:
	movq	40(%rsi), %r10
	movq	80(%rsi), %r11
	movq	120(%rsi), %rbp
	movq	160(%rsi), %rbx
	movq	%r11, 224(%rsp)
	movq	%rbx, 232(%rsp)
	movq	%r10, 240(%rsp)
	movq	%rbp, 248(%rsp)
	vpbroadcastq	(%rsi), %ymm0
	vmovdqu	8(%rsi), %ymm1
	vpxor	%ymm0, %ymm2, %ymm2
	vpxor	%ymm1, %ymm3, %ymm3
	vpxor	224(%rsp), %ymm4, %ymm4
	vpbroadcastq	s_zero(%rip), %ymm0
	vmovdqu	48(%rsi), %ymm1
	vmovdqu	88(%rsi), %ymm5
	vmovdqu	128(%rsi), %ymm6
	vpblendd	$-61, %ymm0, %ymm6, %ymm7
	vpblendd	$60, %ymm0, %ymm6, %ymm0
	vpblendd	$-61, %ymm1, %ymm5, %ymm6
	vpblendd	$60, %ymm1, %ymm5, %ymm1
	vpblendd	$-16, %ymm7, %ymm6, %ymm5
	vpblendd	$-52, %ymm0, %ymm1, %ymm8
	vpblendd	$51, %ymm0, %ymm1, %ymm1
	vpxor	%ymm5, %ymm9, %ymm9
	vpxor	%ymm8, %ymm10, %ymm10
	vpblendd	$15, %ymm7, %ymm6, %ymm5
	vpblendd	$3, %ymm0, %ymm1, %ymm0
	vpxor	%ymm5, %ymm11, %ymm11
	vpxor	%ymm0, %ymm12, %ymm12
	leaq	168(%rsi), %rsi
	leaq	-168(%rdx), %rdx
	leaq	96(%rax), %r10
	leaq	96(%r8), %r11
	movq	%r9, %rbp
	movl	$24, %ebx
	.p2align	5
Lshake128_avx2_jazz$19:
	vpshufd	$78, %ymm4, %ymm0
	vpxor	%ymm12, %ymm11, %ymm1
	vpxor	%ymm9, %ymm10, %ymm5
	vpxor	%ymm3, %ymm1, %ymm1
	vpxor	%ymm5, %ymm1, %ymm1
	vpermq	$-109, %ymm1, %ymm5
	vpxor	%ymm4, %ymm0, %ymm0
	vpermq	$78, %ymm0, %ymm6
	vpsrlq	$63, %ymm1, %ymm7
	vpaddq	%ymm1, %ymm1, %ymm1
	vpor	%ymm1, %ymm7, %ymm1
	vpermq	$57, %ymm1, %ymm7
	vpxor	%ymm5, %ymm1, %ymm1
	vpermq	$0, %ymm1, %ymm1
	vpxor	%ymm2, %ymm0, %ymm0
	vpxor	%ymm6, %ymm0, %ymm0
	vpsrlq	$63, %ymm0, %ymm6
	vpaddq	%ymm0, %ymm0, %ymm8
	vpor	%ymm6, %ymm8, %ymm6
	vpxor	%ymm1, %ymm4, %ymm4
	vpxor	%ymm1, %ymm2, %ymm1
	vpblendd	$-64, %ymm6, %ymm7, %ymm2
	vpblendd	$3, %ymm0, %ymm5, %ymm0
	vpxor	%ymm0, %ymm2, %ymm0
	vpsllvq	-96(%r10), %ymm4, %ymm2
	vpsrlvq	-96(%r11), %ymm4, %ymm4
	vpor	%ymm2, %ymm4, %ymm2
	vpxor	%ymm0, %ymm12, %ymm4
	vpsllvq	-32(%r10), %ymm4, %ymm5
	vpsrlvq	-32(%r11), %ymm4, %ymm4
	vpor	%ymm5, %ymm4, %ymm4
	vpxor	%ymm0, %ymm10, %ymm5
	vpsllvq	(%r10), %ymm5, %ymm6
	vpsrlvq	(%r11), %ymm5, %ymm5
	vpor	%ymm6, %ymm5, %ymm5
	vpxor	%ymm0, %ymm11, %ymm6
	vpsllvq	32(%r10), %ymm6, %ymm7
	vpsrlvq	32(%r11), %ymm6, %ymm6
	vpor	%ymm7, %ymm6, %ymm6
	vpxor	%ymm0, %ymm9, %ymm7
	vpermq	$-115, %ymm2, %ymm2
	vpermq	$-115, %ymm4, %ymm8
	vpsllvq	64(%r10), %ymm7, %ymm4
	vpsrlvq	64(%r11), %ymm7, %ymm7
	vpor	%ymm4, %ymm7, %ymm7
	vpxor	%ymm0, %ymm3, %ymm0
	vpermq	$27, %ymm5, %ymm3
	vpermq	$114, %ymm6, %ymm5
	vpsllvq	-64(%r10), %ymm0, %ymm4
	vpsrlvq	-64(%r11), %ymm0, %ymm0
	vpor	%ymm4, %ymm0, %ymm0
	vpsrldq	$8, %ymm7, %ymm4
	vpandn	%ymm4, %ymm7, %ymm6
	vpblendd	$12, %ymm5, %ymm0, %ymm4
	vpblendd	$12, %ymm0, %ymm8, %ymm9
	vpblendd	$12, %ymm8, %ymm2, %ymm10
	vpblendd	$12, %ymm2, %ymm0, %ymm11
	vpblendd	$48, %ymm8, %ymm4, %ymm4
	vpblendd	$48, %ymm3, %ymm9, %ymm9
	vpblendd	$48, %ymm0, %ymm10, %ymm10
	vpblendd	$48, %ymm5, %ymm11, %ymm11
	vpblendd	$-64, %ymm3, %ymm4, %ymm4
	vpblendd	$-64, %ymm5, %ymm9, %ymm9
	vpblendd	$-64, %ymm5, %ymm10, %ymm10
	vpblendd	$-64, %ymm8, %ymm11, %ymm11
	vpandn	%ymm9, %ymm4, %ymm4
	vpandn	%ymm11, %ymm10, %ymm9
	vpblendd	$12, %ymm0, %ymm3, %ymm10
	vpblendd	$12, %ymm3, %ymm2, %ymm11
	vpxor	%ymm2, %ymm4, %ymm12
	vpblendd	$48, %ymm2, %ymm10, %ymm4
	vpblendd	$48, %ymm8, %ymm11, %ymm10
	vpxor	%ymm3, %ymm9, %ymm9
	vpblendd	$-64, %ymm8, %ymm4, %ymm4
	vpblendd	$-64, %ymm0, %ymm10, %ymm10
	vpandn	%ymm10, %ymm4, %ymm4
	vpxor	%ymm5, %ymm4, %ymm10
	vpermq	$30, %ymm7, %ymm4
	vpblendd	$48, %ymm1, %ymm4, %ymm4
	vpermq	$57, %ymm7, %ymm11
	vpblendd	$-64, %ymm1, %ymm11, %ymm11
	vpandn	%ymm4, %ymm11, %ymm13
	vpblendd	$12, %ymm3, %ymm8, %ymm4
	vpblendd	$12, %ymm8, %ymm5, %ymm11
	vpblendd	$48, %ymm5, %ymm4, %ymm4
	vpblendd	$48, %ymm2, %ymm11, %ymm11
	vpblendd	$-64, %ymm2, %ymm4, %ymm4
	vpblendd	$-64, %ymm3, %ymm11, %ymm11
	vpandn	%ymm11, %ymm4, %ymm4
	vpxor	%ymm0, %ymm4, %ymm4
	vpermq	$0, %ymm6, %ymm6
	vpermq	$27, %ymm12, %ymm12
	vpermq	$-115, %ymm9, %ymm11
	vpermq	$114, %ymm10, %ymm9
	vpblendd	$12, %ymm2, %ymm5, %ymm10
	vpblendd	$12, %ymm5, %ymm3, %ymm5
	vpblendd	$48, %ymm3, %ymm10, %ymm3
	vpblendd	$48, %ymm0, %ymm5, %ymm5
	vpblendd	$-64, %ymm0, %ymm3, %ymm0
	vpblendd	$-64, %ymm2, %ymm5, %ymm2
	vpandn	%ymm2, %ymm0, %ymm0
	vpxor	%ymm6, %ymm1, %ymm1
	vpxor	%ymm7, %ymm13, %ymm3
	vpxor	%ymm8, %ymm0, %ymm10
	vpxor	(%rbp), %ymm1, %ymm2
	leaq	32(%rbp), %rbp
	decl	%ebx
	jne 	Lshake128_avx2_jazz$19
Lshake128_avx2_jazz$17:
	cmpq	$168, %rdx
	jnb 	Lshake128_avx2_jazz$18
	vpbroadcastq	g_zero(%rip), %ymm0
	vmovdqu	%ymm0, (%rsp)
	vmovdqu	%ymm0, 32(%rsp)
	vmovdqu	%ymm0, 64(%rsp)
	vmovdqu	%ymm0, 96(%rsp)
	vmovdqu	%ymm0, 128(%rsp)
	vmovdqu	%ymm0, 160(%rsp)
	vmovdqu	%ymm0, 192(%rsp)
	movq	%rdx, %r10
	shrq	$3, %r10
	movq	$0, %r11
	jmp 	Lshake128_avx2_jazz$15
Lshake128_avx2_jazz$16:
	movq	(%rsi,%r11,8), %rbp
	movq	(%rcx,%r11,8), %rbx
	movq	%rbp, (%rsp,%rbx,8)
	leaq	1(%r11), %r11
Lshake128_avx2_jazz$15:
	cmpq	%r10, %r11
	jb  	Lshake128_avx2_jazz$16
	movq	(%rcx,%r11,8), %r10
	shlq	$3, %r11
	shlq	$3, %r10
	jmp 	Lshake128_avx2_jazz$13
Lshake128_avx2_jazz$14:
	movb	(%rsi,%r11), %bpl
	movb	%bpl, (%rsp,%r10)
	leaq	1(%r11), %r11
	leaq	1(%r10), %r10
Lshake128_avx2_jazz$13:
	cmpq	%rdx, %r11
	jb  	Lshake128_avx2_jazz$14
	movb	$31, (%rsp,%r10)
	movq	$20, %rdx
	movq	(%rcx,%rdx,8), %rdx
	shlq	$3, %rdx
	leaq	7(%rdx), %rdx
	xorb	$-128, (%rsp,%rdx)
	movq	(%rsp), %rdx
	movq	%rdx, 8(%rsp)
	movq	%rdx, 16(%rsp)
	movq	%rdx, 24(%rsp)
	vpxor	(%rsp), %ymm2, %ymm0
	vpxor	32(%rsp), %ymm3, %ymm1
	vpxor	64(%rsp), %ymm4, %ymm2
	vpxor	96(%rsp), %ymm12, %ymm3
	vpxor	128(%rsp), %ymm10, %ymm4
	vpxor	160(%rsp), %ymm11, %ymm5
	vpxor	192(%rsp), %ymm9, %ymm6
	leaq	96(%rax), %rdx
	leaq	96(%r8), %rsi
	movq	%r9, %r10
	movl	$24, %r11d
	.p2align	5
Lshake128_avx2_jazz$12:
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
	vpxor	(%r10), %ymm0, %ymm0
	leaq	32(%r10), %r10
	decl	%r11d
	jne 	Lshake128_avx2_jazz$12
	movq	$168, %rdx
	jmp 	Lshake128_avx2_jazz$5
Lshake128_avx2_jazz$6:
	movq	$168, %rsi
	vmovdqu	%ymm0, (%rsp)
	vmovdqu	%ymm1, 32(%rsp)
	vmovdqu	%ymm2, 64(%rsp)
	vmovdqu	%ymm3, 96(%rsp)
	vmovdqu	%ymm4, 128(%rsp)
	vmovdqu	%ymm5, 160(%rsp)
	vmovdqu	%ymm6, 192(%rsp)
	movq	%rsi, %r10
	shrq	$3, %r10
	movq	$0, %r11
	jmp 	Lshake128_avx2_jazz$10
Lshake128_avx2_jazz$11:
	movq	(%rcx,%r11,8), %rbp
	movq	(%rsp,%rbp,8), %rbp
	movq	%rbp, (%rdi,%r11,8)
	leaq	1(%r11), %r11
Lshake128_avx2_jazz$10:
	cmpq	%r10, %r11
	jb  	Lshake128_avx2_jazz$11
	movq	(%rcx,%r11,8), %r10
	shlq	$3, %r11
	shlq	$3, %r10
	jmp 	Lshake128_avx2_jazz$8
Lshake128_avx2_jazz$9:
	movb	(%rsp,%r10), %bpl
	movb	%bpl, (%rdi,%r11)
	leaq	1(%r11), %r11
	leaq	1(%r10), %r10
Lshake128_avx2_jazz$8:
	cmpq	%rsi, %r11
	jb  	Lshake128_avx2_jazz$9
	leaq	(%rdi,%rsi), %rdi
	leaq	96(%rax), %rsi
	leaq	96(%r8), %r10
	movq	%r9, %r11
	movl	$24, %ebp
	.p2align	5
Lshake128_avx2_jazz$7:
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
	vpsllvq	-96(%rsi), %ymm2, %ymm8
	vpsrlvq	-96(%r10), %ymm2, %ymm2
	vpor	%ymm8, %ymm2, %ymm2
	vpxor	%ymm7, %ymm3, %ymm3
	vpsllvq	-32(%rsi), %ymm3, %ymm8
	vpsrlvq	-32(%r10), %ymm3, %ymm3
	vpor	%ymm8, %ymm3, %ymm3
	vpxor	%ymm7, %ymm4, %ymm4
	vpsllvq	(%rsi), %ymm4, %ymm8
	vpsrlvq	(%r10), %ymm4, %ymm4
	vpor	%ymm8, %ymm4, %ymm4
	vpxor	%ymm7, %ymm5, %ymm5
	vpsllvq	32(%rsi), %ymm5, %ymm8
	vpsrlvq	32(%r10), %ymm5, %ymm5
	vpor	%ymm8, %ymm5, %ymm5
	vpxor	%ymm7, %ymm6, %ymm6
	vpermq	$-115, %ymm2, %ymm8
	vpermq	$-115, %ymm3, %ymm9
	vpsllvq	64(%rsi), %ymm6, %ymm2
	vpsrlvq	64(%r10), %ymm6, %ymm3
	vpor	%ymm2, %ymm3, %ymm10
	vpxor	%ymm7, %ymm1, %ymm1
	vpermq	$27, %ymm4, %ymm4
	vpermq	$114, %ymm5, %ymm7
	vpsllvq	-64(%rsi), %ymm1, %ymm2
	vpsrlvq	-64(%r10), %ymm1, %ymm1
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
	vpxor	(%r11), %ymm0, %ymm0
	leaq	32(%r11), %r11
	decl	%ebp
	jne 	Lshake128_avx2_jazz$7
	leaq	-168(%rdx), %rdx
Lshake128_avx2_jazz$5:
	cmpq	$168, %rdx
	jnb 	Lshake128_avx2_jazz$6
	vmovdqu	%ymm0, (%rsp)
	vmovdqu	%ymm1, 32(%rsp)
	vmovdqu	%ymm2, 64(%rsp)
	vmovdqu	%ymm3, 96(%rsp)
	vmovdqu	%ymm4, 128(%rsp)
	vmovdqu	%ymm5, 160(%rsp)
	vmovdqu	%ymm6, 192(%rsp)
	movq	%rdx, %rax
	shrq	$3, %rax
	movq	$0, %rsi
	jmp 	Lshake128_avx2_jazz$3
Lshake128_avx2_jazz$4:
	movq	(%rcx,%rsi,8), %r8
	movq	(%rsp,%r8,8), %r8
	movq	%r8, (%rdi,%rsi,8)
	leaq	1(%rsi), %rsi
Lshake128_avx2_jazz$3:
	cmpq	%rax, %rsi
	jb  	Lshake128_avx2_jazz$4
	movq	(%rcx,%rsi,8), %rax
	shlq	$3, %rsi
	shlq	$3, %rax
	jmp 	Lshake128_avx2_jazz$1
Lshake128_avx2_jazz$2:
	movb	(%rsp,%rax), %cl
	movb	%cl, (%rdi,%rsi)
	leaq	1(%rsi), %rsi
	leaq	1(%rax), %rax
Lshake128_avx2_jazz$1:
	cmpq	%rdx, %rsi
	jb  	Lshake128_avx2_jazz$2
	addq	$256, %rsp
	popq	%rbx
	popq	%rbp
	ret 
	.data
	.globl	_g_zero
	.globl	g_zero
	.p2align	3
_g_zero:
g_zero:
	.quad	0
	.globl	_s_zero
	.globl	s_zero
	.p2align	3
_s_zero:
s_zero:
	.quad	0

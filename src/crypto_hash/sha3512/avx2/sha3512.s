	.text
	.p2align	5
	.globl	_sha3512_avx2_jazz
	.globl	sha3512_avx2_jazz
_sha3512_avx2_jazz:
sha3512_avx2_jazz:
	pushq	%rbp
	pushq	%rbx
	subq	$224, %rsp
	vpbroadcastq	g_zero(%rip), %ymm6
	vmovdqu	%ymm6, %ymm7
	vmovdqu	%ymm6, %ymm8
	vmovdqu	%ymm6, %ymm9
	vmovdqu	%ymm6, %ymm10
	vmovdqu	%ymm6, %ymm0
	vmovdqu	%ymm6, %ymm11
	movq	(%rcx), %rax
	movq	8(%rcx), %r8
	movq	16(%rcx), %r9
	movq	24(%rcx), %rcx
	jmp 	Lsha3512_avx2_jazz$10
Lsha3512_avx2_jazz$11:
	vpbroadcastq	s_zero(%rip), %ymm1
	vpbroadcastq	(%rsi), %ymm2
	vpbroadcastq	40(%rsi), %ymm3
	vmovdqu	8(%rsi), %ymm4
	vmovdqu	48(%rsi), %ymm5
	vpxor	%ymm2, %ymm6, %ymm6
	vpxor	%ymm4, %ymm7, %ymm7
	vpblendd	$-49, %ymm1, %ymm3, %ymm2
	vpblendd	$-13, %ymm1, %ymm5, %ymm3
	vpblendd	$-49, %ymm1, %ymm5, %ymm4
	vpblendd	$-4, %ymm1, %ymm5, %ymm1
	vpxor	%ymm2, %ymm8, %ymm8
	vpxor	%ymm3, %ymm9, %ymm9
	vpxor	%ymm4, %ymm10, %ymm10
	vpxor	%ymm1, %ymm11, %ymm11
	leaq	72(%rsi), %rsi
	leaq	-72(%rdx), %rdx
	leaq	96(%rax), %r10
	leaq	96(%r8), %r11
	movq	%r9, %rbp
	movl	$24, %ebx
	.p2align	5
Lsha3512_avx2_jazz$12:
	vpshufd	$78, %ymm8, %ymm1
	vpxor	%ymm9, %ymm0, %ymm2
	vpxor	%ymm11, %ymm10, %ymm3
	vpxor	%ymm7, %ymm2, %ymm2
	vpxor	%ymm3, %ymm2, %ymm2
	vpermq	$-109, %ymm2, %ymm3
	vpxor	%ymm8, %ymm1, %ymm1
	vpermq	$78, %ymm1, %ymm4
	vpsrlq	$63, %ymm2, %ymm5
	vpaddq	%ymm2, %ymm2, %ymm2
	vpor	%ymm2, %ymm5, %ymm2
	vpermq	$57, %ymm2, %ymm5
	vpxor	%ymm3, %ymm2, %ymm2
	vpermq	$0, %ymm2, %ymm2
	vpxor	%ymm6, %ymm1, %ymm1
	vpxor	%ymm4, %ymm1, %ymm1
	vpsrlq	$63, %ymm1, %ymm4
	vpaddq	%ymm1, %ymm1, %ymm12
	vpor	%ymm4, %ymm12, %ymm4
	vpxor	%ymm2, %ymm8, %ymm8
	vpxor	%ymm2, %ymm6, %ymm2
	vpblendd	$-64, %ymm4, %ymm5, %ymm4
	vpblendd	$3, %ymm1, %ymm3, %ymm1
	vpxor	%ymm1, %ymm4, %ymm1
	vpsllvq	-96(%r10), %ymm8, %ymm3
	vpsrlvq	-96(%r11), %ymm8, %ymm4
	vpor	%ymm3, %ymm4, %ymm3
	vpxor	%ymm1, %ymm9, %ymm4
	vpsllvq	-32(%r10), %ymm4, %ymm5
	vpsrlvq	-32(%r11), %ymm4, %ymm4
	vpor	%ymm5, %ymm4, %ymm4
	vpxor	%ymm1, %ymm10, %ymm5
	vpsllvq	(%r10), %ymm5, %ymm6
	vpsrlvq	(%r11), %ymm5, %ymm5
	vpor	%ymm6, %ymm5, %ymm5
	vpxor	%ymm1, %ymm0, %ymm0
	vpsllvq	32(%r10), %ymm0, %ymm6
	vpsrlvq	32(%r11), %ymm0, %ymm0
	vpor	%ymm6, %ymm0, %ymm0
	vpxor	%ymm1, %ymm11, %ymm6
	vpermq	$-115, %ymm3, %ymm3
	vpermq	$-115, %ymm4, %ymm4
	vpsllvq	64(%r10), %ymm6, %ymm8
	vpsrlvq	64(%r11), %ymm6, %ymm6
	vpor	%ymm8, %ymm6, %ymm6
	vpxor	%ymm1, %ymm7, %ymm1
	vpermq	$27, %ymm5, %ymm5
	vpermq	$114, %ymm0, %ymm7
	vpsllvq	-64(%r10), %ymm1, %ymm0
	vpsrlvq	-64(%r11), %ymm1, %ymm1
	vpor	%ymm0, %ymm1, %ymm1
	vpsrldq	$8, %ymm6, %ymm0
	vpandn	%ymm0, %ymm6, %ymm0
	vpblendd	$12, %ymm7, %ymm1, %ymm8
	vpblendd	$12, %ymm1, %ymm4, %ymm9
	vpblendd	$12, %ymm4, %ymm3, %ymm10
	vpblendd	$12, %ymm3, %ymm1, %ymm11
	vpblendd	$48, %ymm4, %ymm8, %ymm8
	vpblendd	$48, %ymm5, %ymm9, %ymm9
	vpblendd	$48, %ymm1, %ymm10, %ymm10
	vpblendd	$48, %ymm7, %ymm11, %ymm11
	vpblendd	$-64, %ymm5, %ymm8, %ymm8
	vpblendd	$-64, %ymm7, %ymm9, %ymm9
	vpblendd	$-64, %ymm7, %ymm10, %ymm10
	vpblendd	$-64, %ymm4, %ymm11, %ymm11
	vpandn	%ymm9, %ymm8, %ymm8
	vpandn	%ymm11, %ymm10, %ymm9
	vpblendd	$12, %ymm1, %ymm5, %ymm10
	vpblendd	$12, %ymm5, %ymm3, %ymm11
	vpxor	%ymm3, %ymm8, %ymm12
	vpblendd	$48, %ymm3, %ymm10, %ymm8
	vpblendd	$48, %ymm4, %ymm11, %ymm10
	vpxor	%ymm5, %ymm9, %ymm11
	vpblendd	$-64, %ymm4, %ymm8, %ymm8
	vpblendd	$-64, %ymm1, %ymm10, %ymm9
	vpandn	%ymm9, %ymm8, %ymm8
	vpxor	%ymm7, %ymm8, %ymm10
	vpermq	$30, %ymm6, %ymm8
	vpblendd	$48, %ymm2, %ymm8, %ymm8
	vpermq	$57, %ymm6, %ymm9
	vpblendd	$-64, %ymm2, %ymm9, %ymm9
	vpandn	%ymm8, %ymm9, %ymm13
	vpblendd	$12, %ymm5, %ymm4, %ymm8
	vpblendd	$12, %ymm4, %ymm7, %ymm9
	vpblendd	$48, %ymm7, %ymm8, %ymm8
	vpblendd	$48, %ymm3, %ymm9, %ymm9
	vpblendd	$-64, %ymm3, %ymm8, %ymm8
	vpblendd	$-64, %ymm5, %ymm9, %ymm9
	vpandn	%ymm9, %ymm8, %ymm8
	vpxor	%ymm1, %ymm8, %ymm8
	vpermq	$0, %ymm0, %ymm14
	vpermq	$27, %ymm12, %ymm9
	vpermq	$-115, %ymm11, %ymm0
	vpermq	$114, %ymm10, %ymm11
	vpblendd	$12, %ymm3, %ymm7, %ymm10
	vpblendd	$12, %ymm7, %ymm5, %ymm7
	vpblendd	$48, %ymm5, %ymm10, %ymm5
	vpblendd	$48, %ymm1, %ymm7, %ymm7
	vpblendd	$-64, %ymm1, %ymm5, %ymm1
	vpblendd	$-64, %ymm3, %ymm7, %ymm3
	vpandn	%ymm3, %ymm1, %ymm1
	vpxor	%ymm14, %ymm2, %ymm2
	vpxor	%ymm6, %ymm13, %ymm7
	vpxor	%ymm4, %ymm1, %ymm10
	vpxor	(%rbp), %ymm2, %ymm6
	leaq	32(%rbp), %rbp
	decl	%ebx
	jne 	Lsha3512_avx2_jazz$12
Lsha3512_avx2_jazz$10:
	cmpq	$72, %rdx
	jnb 	Lsha3512_avx2_jazz$11
	vpbroadcastq	g_zero(%rip), %ymm1
	vmovdqu	%ymm1, (%rsp)
	vmovdqu	%ymm1, 32(%rsp)
	vmovdqu	%ymm1, 64(%rsp)
	vmovdqu	%ymm1, 96(%rsp)
	vmovdqu	%ymm1, 128(%rsp)
	vmovdqu	%ymm1, 160(%rsp)
	vmovdqu	%ymm1, 192(%rsp)
	movq	%rdx, %r10
	shrq	$3, %r10
	movq	$0, %r11
	jmp 	Lsha3512_avx2_jazz$8
Lsha3512_avx2_jazz$9:
	movq	(%rsi,%r11,8), %rbp
	movq	(%rcx,%r11,8), %rbx
	movq	%rbp, (%rsp,%rbx,8)
	leaq	1(%r11), %r11
Lsha3512_avx2_jazz$8:
	cmpq	%r10, %r11
	jb  	Lsha3512_avx2_jazz$9
	movq	(%rcx,%r11,8), %r10
	shlq	$3, %r11
	shlq	$3, %r10
	jmp 	Lsha3512_avx2_jazz$6
Lsha3512_avx2_jazz$7:
	movb	(%rsi,%r11), %bpl
	movb	%bpl, (%rsp,%r10)
	leaq	1(%r11), %r11
	leaq	1(%r10), %r10
Lsha3512_avx2_jazz$6:
	cmpq	%rdx, %r11
	jb  	Lsha3512_avx2_jazz$7
	movb	$6, (%rsp,%r10)
	movq	$8, %rdx
	movq	(%rcx,%rdx,8), %rdx
	shlq	$3, %rdx
	leaq	7(%rdx), %rdx
	xorb	$-128, (%rsp,%rdx)
	movq	(%rsp), %rdx
	movq	%rdx, 8(%rsp)
	movq	%rdx, 16(%rsp)
	movq	%rdx, 24(%rsp)
	vpxor	(%rsp), %ymm6, %ymm1
	vpxor	32(%rsp), %ymm7, %ymm2
	vpxor	64(%rsp), %ymm8, %ymm3
	vpxor	96(%rsp), %ymm9, %ymm4
	vpxor	128(%rsp), %ymm10, %ymm5
	vpxor	160(%rsp), %ymm0, %ymm0
	vpxor	192(%rsp), %ymm11, %ymm6
	leaq	96(%rax), %rax
	leaq	96(%r8), %rdx
	movl	$24, %esi
	.p2align	5
Lsha3512_avx2_jazz$5:
	vpshufd	$78, %ymm3, %ymm7
	vpxor	%ymm4, %ymm0, %ymm8
	vpxor	%ymm6, %ymm5, %ymm9
	vpxor	%ymm2, %ymm8, %ymm8
	vpxor	%ymm9, %ymm8, %ymm8
	vpermq	$-109, %ymm8, %ymm9
	vpxor	%ymm3, %ymm7, %ymm7
	vpermq	$78, %ymm7, %ymm10
	vpsrlq	$63, %ymm8, %ymm11
	vpaddq	%ymm8, %ymm8, %ymm8
	vpor	%ymm8, %ymm11, %ymm8
	vpermq	$57, %ymm8, %ymm11
	vpxor	%ymm9, %ymm8, %ymm8
	vpermq	$0, %ymm8, %ymm8
	vpxor	%ymm1, %ymm7, %ymm7
	vpxor	%ymm10, %ymm7, %ymm7
	vpsrlq	$63, %ymm7, %ymm10
	vpaddq	%ymm7, %ymm7, %ymm12
	vpor	%ymm10, %ymm12, %ymm10
	vpxor	%ymm8, %ymm3, %ymm3
	vpxor	%ymm8, %ymm1, %ymm1
	vpblendd	$-64, %ymm10, %ymm11, %ymm8
	vpblendd	$3, %ymm7, %ymm9, %ymm7
	vpxor	%ymm7, %ymm8, %ymm7
	vpsllvq	-96(%rax), %ymm3, %ymm8
	vpsrlvq	-96(%rdx), %ymm3, %ymm3
	vpor	%ymm8, %ymm3, %ymm3
	vpxor	%ymm7, %ymm4, %ymm4
	vpsllvq	-32(%rax), %ymm4, %ymm8
	vpsrlvq	-32(%rdx), %ymm4, %ymm4
	vpor	%ymm8, %ymm4, %ymm4
	vpxor	%ymm7, %ymm5, %ymm5
	vpsllvq	(%rax), %ymm5, %ymm8
	vpsrlvq	(%rdx), %ymm5, %ymm5
	vpor	%ymm8, %ymm5, %ymm5
	vpxor	%ymm7, %ymm0, %ymm0
	vpsllvq	32(%rax), %ymm0, %ymm8
	vpsrlvq	32(%rdx), %ymm0, %ymm0
	vpor	%ymm8, %ymm0, %ymm0
	vpxor	%ymm7, %ymm6, %ymm6
	vpermq	$-115, %ymm3, %ymm8
	vpermq	$-115, %ymm4, %ymm9
	vpsllvq	64(%rax), %ymm6, %ymm3
	vpsrlvq	64(%rdx), %ymm6, %ymm4
	vpor	%ymm3, %ymm4, %ymm10
	vpxor	%ymm7, %ymm2, %ymm2
	vpermq	$27, %ymm5, %ymm5
	vpermq	$114, %ymm0, %ymm7
	vpsllvq	-64(%rax), %ymm2, %ymm0
	vpsrlvq	-64(%rdx), %ymm2, %ymm2
	vpor	%ymm0, %ymm2, %ymm2
	vpsrldq	$8, %ymm10, %ymm0
	vpandn	%ymm0, %ymm10, %ymm0
	vpblendd	$12, %ymm7, %ymm2, %ymm3
	vpblendd	$12, %ymm2, %ymm9, %ymm4
	vpblendd	$12, %ymm9, %ymm8, %ymm6
	vpblendd	$12, %ymm8, %ymm2, %ymm11
	vpblendd	$48, %ymm9, %ymm3, %ymm3
	vpblendd	$48, %ymm5, %ymm4, %ymm4
	vpblendd	$48, %ymm2, %ymm6, %ymm6
	vpblendd	$48, %ymm7, %ymm11, %ymm11
	vpblendd	$-64, %ymm5, %ymm3, %ymm3
	vpblendd	$-64, %ymm7, %ymm4, %ymm4
	vpblendd	$-64, %ymm7, %ymm6, %ymm6
	vpblendd	$-64, %ymm9, %ymm11, %ymm11
	vpandn	%ymm4, %ymm3, %ymm3
	vpandn	%ymm11, %ymm6, %ymm4
	vpblendd	$12, %ymm2, %ymm5, %ymm6
	vpblendd	$12, %ymm5, %ymm8, %ymm11
	vpxor	%ymm8, %ymm3, %ymm12
	vpblendd	$48, %ymm8, %ymm6, %ymm3
	vpblendd	$48, %ymm9, %ymm11, %ymm6
	vpxor	%ymm5, %ymm4, %ymm11
	vpblendd	$-64, %ymm9, %ymm3, %ymm3
	vpblendd	$-64, %ymm2, %ymm6, %ymm4
	vpandn	%ymm4, %ymm3, %ymm3
	vpxor	%ymm7, %ymm3, %ymm6
	vpermq	$30, %ymm10, %ymm3
	vpblendd	$48, %ymm1, %ymm3, %ymm3
	vpermq	$57, %ymm10, %ymm4
	vpblendd	$-64, %ymm1, %ymm4, %ymm4
	vpandn	%ymm3, %ymm4, %ymm13
	vpblendd	$12, %ymm5, %ymm9, %ymm3
	vpblendd	$12, %ymm9, %ymm7, %ymm4
	vpblendd	$48, %ymm7, %ymm3, %ymm3
	vpblendd	$48, %ymm8, %ymm4, %ymm4
	vpblendd	$-64, %ymm8, %ymm3, %ymm3
	vpblendd	$-64, %ymm5, %ymm4, %ymm4
	vpandn	%ymm4, %ymm3, %ymm3
	vpxor	%ymm2, %ymm3, %ymm3
	vpermq	$0, %ymm0, %ymm14
	vpermq	$27, %ymm12, %ymm4
	vpermq	$-115, %ymm11, %ymm0
	vpermq	$114, %ymm6, %ymm6
	vpblendd	$12, %ymm8, %ymm7, %ymm11
	vpblendd	$12, %ymm7, %ymm5, %ymm7
	vpblendd	$48, %ymm5, %ymm11, %ymm5
	vpblendd	$48, %ymm2, %ymm7, %ymm7
	vpblendd	$-64, %ymm2, %ymm5, %ymm2
	vpblendd	$-64, %ymm8, %ymm7, %ymm5
	vpandn	%ymm5, %ymm2, %ymm5
	vpxor	%ymm14, %ymm1, %ymm1
	vpxor	%ymm10, %ymm13, %ymm2
	vpxor	%ymm9, %ymm5, %ymm5
	vpxor	(%r9), %ymm1, %ymm1
	leaq	32(%r9), %r9
	decl	%esi
	jne 	Lsha3512_avx2_jazz$5
	movq	$64, %rax
	vmovdqu	%ymm1, (%rsp)
	vmovdqu	%ymm2, 32(%rsp)
	vmovdqu	%ymm3, 64(%rsp)
	vmovdqu	%ymm4, 96(%rsp)
	vmovdqu	%ymm5, 128(%rsp)
	vmovdqu	%ymm0, 160(%rsp)
	vmovdqu	%ymm6, 192(%rsp)
	movq	%rax, %rdx
	shrq	$3, %rdx
	movq	$0, %rsi
	jmp 	Lsha3512_avx2_jazz$3
Lsha3512_avx2_jazz$4:
	movq	(%rcx,%rsi,8), %r8
	movq	(%rsp,%r8,8), %r8
	movq	%r8, (%rdi,%rsi,8)
	leaq	1(%rsi), %rsi
Lsha3512_avx2_jazz$3:
	cmpq	%rdx, %rsi
	jb  	Lsha3512_avx2_jazz$4
	movq	(%rcx,%rsi,8), %rcx
	shlq	$3, %rsi
	shlq	$3, %rcx
	jmp 	Lsha3512_avx2_jazz$1
Lsha3512_avx2_jazz$2:
	movb	(%rsp,%rcx), %dl
	movb	%dl, (%rdi,%rsi)
	leaq	1(%rsi), %rsi
	leaq	1(%rcx), %rcx
Lsha3512_avx2_jazz$1:
	cmpq	%rax, %rsi
	jb  	Lsha3512_avx2_jazz$2
	addq	$224, %rsp
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
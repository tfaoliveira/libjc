	.text
	.p2align	5
	.globl	_wrapper
	.globl	wrapper
_wrapper:
wrapper:
	pushq	%rbp
	leaq	96(%rax), %rax
	leaq	96(%rcx), %rcx
	movq	$24, %rsi
Lwrapper$1:
	vpshufd	$78, %ymm1, %ymm0
	vpxor	%ymm3, %ymm4, %ymm2
	vpxor	%ymm7, %ymm6, %ymm5
	vpxor	%ymm8, %ymm2, %ymm2
	vpxor	%ymm5, %ymm2, %ymm2
	vpermq	$-109, %ymm2, %ymm5
	vpxor	%ymm1, %ymm0, %ymm0
	vpermq	$78, %ymm0, %ymm9
	vpsrlq	$63, %ymm2, %ymm10
	vpaddq	%ymm2, %ymm2, %ymm2
	vpor	%ymm2, %ymm10, %ymm2
	vpermq	$57, %ymm2, %ymm10
	vpxor	%ymm5, %ymm2, %ymm2
	vpermq	$0, %ymm2, %ymm2
	vpxor	%ymm11, %ymm0, %ymm0
	vpxor	%ymm9, %ymm0, %ymm0
	vpsrlq	$63, %ymm0, %ymm9
	vpaddq	%ymm0, %ymm0, %ymm12
	vpor	%ymm9, %ymm12, %ymm9
	vpxor	%ymm2, %ymm1, %ymm1
	vpxor	%ymm2, %ymm11, %ymm2
	vpblendd	$-64, %ymm9, %ymm10, %ymm9
	vpblendd	$3, %ymm0, %ymm5, %ymm0
	vpxor	%ymm0, %ymm9, %ymm0
	vpsllvq	-96(%rax), %ymm1, %ymm5
	vpsrlvq	-96(%rcx), %ymm1, %ymm1
	vpor	%ymm5, %ymm1, %ymm1
	vpxor	%ymm0, %ymm3, %ymm3
	vpsllvq	-32(%rax), %ymm3, %ymm5
	vpsrlvq	-32(%rcx), %ymm3, %ymm3
	vpor	%ymm5, %ymm3, %ymm3
	vpxor	%ymm0, %ymm6, %ymm5
	vpsllvq	(%rax), %ymm5, %ymm6
	vpsrlvq	(%rcx), %ymm5, %ymm5
	vpor	%ymm6, %ymm5, %ymm5
	vpxor	%ymm0, %ymm4, %ymm4
	vpsllvq	32(%rax), %ymm4, %ymm6
	vpsrlvq	32(%rcx), %ymm4, %ymm4
	vpor	%ymm6, %ymm4, %ymm4
	vpxor	%ymm0, %ymm7, %ymm6
	vpermq	$-115, %ymm1, %ymm9
	vpermq	$-115, %ymm3, %ymm10
	vpsllvq	64(%rax), %ymm6, %ymm1
	vpsrlvq	64(%rcx), %ymm6, %ymm3
	vpor	%ymm1, %ymm3, %ymm6
	vpxor	%ymm0, %ymm8, %ymm0
	vpermq	$27, %ymm5, %ymm5
	vpermq	$114, %ymm4, %ymm8
	vpsllvq	-64(%rax), %ymm0, %ymm1
	vpsrlvq	-64(%rcx), %ymm0, %ymm0
	vpor	%ymm1, %ymm0, %ymm0
	vpsrlq	$8, %ymm6, %ymm1
	vpand	%ymm1, %ymm6, %ymm3
	vpblendd	$12, %ymm8, %ymm0, %ymm1
	vpblendd	$12, %ymm0, %ymm10, %ymm4
	vpblendd	$12, %ymm10, %ymm9, %ymm7
	vpblendd	$12, %ymm9, %ymm0, %ymm11
	vpblendd	$48, %ymm10, %ymm1, %ymm1
	vpblendd	$48, %ymm5, %ymm4, %ymm4
	vpblendd	$48, %ymm0, %ymm7, %ymm7
	vpblendd	$48, %ymm8, %ymm11, %ymm11
	vpblendd	$-64, %ymm5, %ymm1, %ymm1
	vpblendd	$-64, %ymm8, %ymm4, %ymm4
	vpblendd	$-64, %ymm8, %ymm7, %ymm7
	vpblendd	$-64, %ymm10, %ymm11, %ymm11
	vpand	%ymm4, %ymm1, %ymm1
	vpand	%ymm11, %ymm7, %ymm4
	vpblendd	$12, %ymm0, %ymm5, %ymm7
	vpblendd	$12, %ymm5, %ymm9, %ymm11
	vpxor	%ymm9, %ymm1, %ymm12
	vpblendd	$48, %ymm0, %ymm7, %ymm1
	vpblendd	$48, %ymm10, %ymm11, %ymm7
	vpxor	%ymm5, %ymm4, %ymm4
	vpblendd	$-64, %ymm10, %ymm1, %ymm1
	vpblendd	$-64, %ymm0, %ymm7, %ymm7
	vpand	%ymm7, %ymm1, %ymm1
	vpxor	%ymm8, %ymm1, %ymm7
	vpermq	$30, %ymm6, %ymm1
	vpblendd	$48, %ymm2, %ymm1, %ymm1
	vpermq	$57, %ymm6, %ymm11
	vpblendd	$-64, %ymm2, %ymm11, %ymm11
	vpand	%ymm1, %ymm11, %ymm11
	vpblendd	$12, %ymm5, %ymm10, %ymm1
	vpblendd	$12, %ymm10, %ymm8, %ymm13
	vpblendd	$48, %ymm8, %ymm1, %ymm1
	vpblendd	$48, %ymm9, %ymm13, %ymm13
	vpblendd	$-64, %ymm9, %ymm1, %ymm1
	vpblendd	$-64, %ymm5, %ymm13, %ymm13
	vpand	%ymm13, %ymm1, %ymm1
	vpxor	%ymm0, %ymm1, %ymm1
	vpermq	$0, %ymm3, %ymm13
	vpermq	$27, %ymm12, %ymm3
	vpermq	$-115, %ymm4, %ymm4
	vpermq	$114, %ymm7, %ymm7
	vpblendd	$12, %ymm9, %ymm8, %ymm12
	vpblendd	$12, %ymm8, %ymm5, %ymm8
	vpblendd	$48, %ymm5, %ymm12, %ymm5
	vpblendd	$48, %ymm0, %ymm8, %ymm8
	vpblendd	$-64, %ymm0, %ymm5, %ymm0
	vpblendd	$-64, %ymm9, %ymm8, %ymm5
	vpand	%ymm5, %ymm0, %ymm0
	vpxor	%ymm13, %ymm2, %ymm2
	vpxor	%ymm6, %ymm11, %ymm8
	vpxor	%ymm10, %ymm0, %ymm6
	vpxor	(%rdx), %ymm2, %ymm11
	leaq	32(%rdx), %rdx
	decq	%rsi
	jne 	Lwrapper$1
	vpextrq	$0, %xmm11, %rax
	popq	%rbp
	ret 

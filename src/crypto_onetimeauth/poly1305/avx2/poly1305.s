	.text
	.p2align	5
	.globl	_poly1305_avx2
	.globl	poly1305_avx2
_poly1305_avx2:
poly1305_avx2:
	pushq	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$656, %rsp
  movq %rsp, %r15
  andq    $-31, %rsp
  movq %r15, -8(%rsp)
	cmpq	$257, %rdx
	jb  	Lpoly1305_avx2$1
	movq	%rdx, %r8
	movq	(%rcx), %r9
	movq	8(%rcx), %r10
	movq	$1152921487695413247, %rax
	andq	%rax, %r9
	movq	$1152921487695413244, %rax
	andq	%rax, %r10
	movq	%r10, %r11
	shrq	$2, %r11
	addq	%r10, %r11
	addq	$16, %rcx
	movq	%r9, %rbp
	movq	%r10, %rbx
	movq	$0, %r12
	movq	%rbp, %rax
	andq	$67108863, %rax
	movq	%rax, 152(%rsp)
	movq	%rbp, %rax
	shrq	$26, %rax
	andq	$67108863, %rax
	movq	%rax, 184(%rsp)
	movq	%rbp, %rax
	shrdq	$52, %rbx, %rax
	movq	%rax, %rdx
	andq	$67108863, %rax
	movq	%rax, 216(%rsp)
	shrq	$26, %rdx
	andq	$67108863, %rdx
	movq	%rdx, 248(%rsp)
	movq	%rbx, %rax
	shrdq	$40, %r12, %rax
	movq	%rax, 280(%rsp)
	movq	%r10, %rax
	mulq	%rbp
	movq	%rax, %r13
	movq	%r9, %rax
	movq	%rdx, %r14
	mulq	%rbp
	movq	%rax, %rbp
	movq	%r9, %rax
	movq	%rdx, %r15
	mulq	%rbx
	addq	%rax, %r13
	movq	%r11, %rax
	adcq	%rdx, %r14
	mulq	%rbx
	movq	%r12, %rbx
	addq	%rax, %rbp
	adcq	%rdx, %r15
	imulq	%r11, %rbx
	addq	%rbx, %r13
	movq	%r15, %rbx
	adcq	$0, %r14
	imulq	%r9, %r12
	addq	%r13, %rbx
	movq	$-4, %rax
	adcq	%r12, %r14
	andq	%r14, %rax
	movq	%r14, %r12
	shrq	$2, %r14
	andq	$3, %r12
	addq	%r14, %rax
	addq	%rax, %rbp
	adcq	$0, %rbx
	adcq	$0, %r12
	movq	%rbp, %rax
	andq	$67108863, %rax
	movq	%rax, 144(%rsp)
	movq	%rbp, %rax
	shrq	$26, %rax
	andq	$67108863, %rax
	movq	%rax, 176(%rsp)
	movq	%rbp, %rax
	shrdq	$52, %rbx, %rax
	movq	%rax, %rdx
	andq	$67108863, %rax
	movq	%rax, 208(%rsp)
	shrq	$26, %rdx
	andq	$67108863, %rdx
	movq	%rdx, 240(%rsp)
	movq	%rbx, %rax
	shrdq	$40, %r12, %rax
	movq	%rax, 272(%rsp)
	movq	%r10, %rax
	mulq	%rbp
	movq	%rax, %r13
	movq	%r9, %rax
	movq	%rdx, %r14
	mulq	%rbp
	movq	%rax, %rbp
	movq	%r9, %rax
	movq	%rdx, %r15
	mulq	%rbx
	addq	%rax, %r13
	movq	%r11, %rax
	adcq	%rdx, %r14
	mulq	%rbx
	movq	%r12, %rbx
	addq	%rax, %rbp
	adcq	%rdx, %r15
	imulq	%r11, %rbx
	addq	%rbx, %r13
	movq	%r15, %rbx
	adcq	$0, %r14
	imulq	%r9, %r12
	addq	%r13, %rbx
	movq	$-4, %rax
	adcq	%r12, %r14
	andq	%r14, %rax
	movq	%r14, %r12
	shrq	$2, %r14
	andq	$3, %r12
	addq	%r14, %rax
	addq	%rax, %rbp
	adcq	$0, %rbx
	adcq	$0, %r12
	movq	%rbp, %rax
	andq	$67108863, %rax
	movq	%rax, 136(%rsp)
	movq	%rbp, %rax
	shrq	$26, %rax
	andq	$67108863, %rax
	movq	%rax, 168(%rsp)
	movq	%rbp, %rax
	shrdq	$52, %rbx, %rax
	movq	%rax, %rdx
	andq	$67108863, %rax
	movq	%rax, 200(%rsp)
	shrq	$26, %rdx
	andq	$67108863, %rdx
	movq	%rdx, 232(%rsp)
	movq	%rbx, %rax
	shrdq	$40, %r12, %rax
	movq	%rax, 264(%rsp)
	movq	%r10, %rax
	mulq	%rbp
	movq	%rax, %r13
	movq	%r9, %rax
	movq	%rdx, %r14
	mulq	%rbp
	movq	%rax, %rbp
	movq	%r9, %rax
	movq	%rdx, %r15
	mulq	%rbx
	addq	%rax, %r13
	movq	%r11, %rax
	adcq	%rdx, %r14
	mulq	%rbx
	movq	%r12, %rbx
	addq	%rax, %rbp
	adcq	%rdx, %r15
	imulq	%r11, %rbx
	addq	%rbx, %r13
	movq	%r15, %rax
	adcq	$0, %r14
	imulq	%r9, %r12
	addq	%r13, %rax
	movq	$-4, %rdx
	adcq	%r12, %r14
	andq	%r14, %rdx
	movq	%r14, %rbx
	shrq	$2, %r14
	andq	$3, %rbx
	addq	%r14, %rdx
	addq	%rdx, %rbp
	adcq	$0, %rax
	adcq	$0, %rbx
	movq	%rbp, %rdx
	andq	$67108863, %rdx
	movq	%rdx, 128(%rsp)
	movq	%rbp, %rdx
	shrq	$26, %rdx
	andq	$67108863, %rdx
	movq	%rdx, 160(%rsp)
	movq	%rbp, %rdx
	shrdq	$52, %rax, %rdx
	movq	%rdx, %rbp
	andq	$67108863, %rdx
	movq	%rdx, 192(%rsp)
	shrq	$26, %rbp
	andq	$67108863, %rbp
	movq	%rbp, 224(%rsp)
	shrdq	$40, %rbx, %rax
	movq	%rax, 256(%rsp)
	vpbroadcastq	five_u64(%rip), %ymm0
	vpmuludq	160(%rsp), %ymm0, %ymm1
	vmovdqu	%ymm1, (%rsp)
	vpmuludq	192(%rsp), %ymm0, %ymm1
	vmovdqu	%ymm1, 32(%rsp)
	vpmuludq	224(%rsp), %ymm0, %ymm1
	vmovdqu	%ymm1, 64(%rsp)
	vpmuludq	256(%rsp), %ymm0, %ymm0
	vmovdqu	%ymm0, 96(%rsp)
	vpbroadcastq	128(%rsp), %ymm0
	vmovdqu	%ymm0, 480(%rsp)
	vpbroadcastq	160(%rsp), %ymm0
	vmovdqu	%ymm0, 512(%rsp)
	vpbroadcastq	192(%rsp), %ymm0
	vmovdqu	%ymm0, 544(%rsp)
	vpbroadcastq	224(%rsp), %ymm0
	vmovdqu	%ymm0, 576(%rsp)
	vpbroadcastq	256(%rsp), %ymm0
	vmovdqu	%ymm0, 608(%rsp)
	vpbroadcastq	(%rsp), %ymm0
	vmovdqu	%ymm0, 352(%rsp)
	vpbroadcastq	32(%rsp), %ymm0
	vmovdqu	%ymm0, 384(%rsp)
	vpbroadcastq	64(%rsp), %ymm0
	vmovdqu	%ymm0, 416(%rsp)
	vpbroadcastq	96(%rsp), %ymm0
	vmovdqu	%ymm0, 448(%rsp)
	vpbroadcastq	zero_u64(%rip), %ymm0
	vpbroadcastq	zero_u64(%rip), %ymm1
	vpbroadcastq	zero_u64(%rip), %ymm2
	vpbroadcastq	zero_u64(%rip), %ymm3
	vpbroadcastq	zero_u64(%rip), %ymm4
	vpbroadcastq	mask26_u64(%rip), %ymm5
	vmovdqu	%ymm5, 288(%rsp)
	vpbroadcastq	bit25_u64(%rip), %ymm6
	vmovdqu	%ymm6, 320(%rsp)
	vmovdqu	(%rsi), %ymm6
	vmovdqu	32(%rsi), %ymm7
	addq	$64, %rsi
	vperm2i128	$32, %ymm7, %ymm6, %ymm8
	vperm2i128	$49, %ymm7, %ymm6, %ymm6
	vpsrldq	$6, %ymm8, %ymm7
	vpsrldq	$6, %ymm6, %ymm9
	vpunpckhqdq	%ymm6, %ymm8, %ymm10
	vpunpcklqdq	%ymm6, %ymm8, %ymm6
	vpunpcklqdq	%ymm9, %ymm7, %ymm7
	vpsrlq	$4, %ymm7, %ymm8
	vpand	%ymm5, %ymm8, %ymm8
	vpsrlq	$26, %ymm6, %ymm9
	vpand	%ymm5, %ymm6, %ymm6
	vpsrlq	$30, %ymm7, %ymm7
	vpand	%ymm5, %ymm7, %ymm7
	vpsrlq	$40, %ymm10, %ymm10
	vpor	320(%rsp), %ymm10, %ymm10
	vpand	%ymm5, %ymm9, %ymm5
	jmp 	Lpoly1305_avx2$13
.p2align 5,,
Lpoly1305_avx2$14:
	vmovdqu	480(%rsp), %ymm9
	vmovdqu	512(%rsp), %ymm11
	vmovdqu	448(%rsp), %ymm12
	vpaddq	%ymm6, %ymm0, %ymm0
	vpaddq	%ymm5, %ymm1, %ymm1
	vpmuludq	%ymm9, %ymm0, %ymm5
	vpaddq	%ymm8, %ymm2, %ymm2
	vpmuludq	%ymm11, %ymm0, %ymm6
	vpaddq	%ymm7, %ymm3, %ymm3
	vpmuludq	%ymm9, %ymm1, %ymm7
	vpaddq	%ymm10, %ymm4, %ymm4
	vpmuludq	%ymm11, %ymm1, %ymm8
	vpmuludq	%ymm9, %ymm2, %ymm10
	vpmuludq	%ymm11, %ymm2, %ymm13
	vpmuludq	%ymm9, %ymm3, %ymm14
	vpaddq	%ymm6, %ymm7, %ymm6
	vpmuludq	%ymm11, %ymm3, %ymm7
	vpaddq	%ymm8, %ymm10, %ymm8
	vpmuludq	%ymm9, %ymm4, %ymm9
	vpaddq	%ymm13, %ymm14, %ymm10
	vpaddq	%ymm7, %ymm9, %ymm7
	vpmuludq	%ymm12, %ymm1, %ymm9
	vmovdqu	(%rsi), %ymm11
	vpmuludq	%ymm12, %ymm2, %ymm13
	vmovdqu	544(%rsp), %ymm14
	vpmuludq	%ymm12, %ymm3, %ymm15
	vpmuludq	%ymm12, %ymm4, %ymm12
	vpaddq	%ymm9, %ymm5, %ymm5
	vmovdqu	32(%rsi), %ymm9
	vpaddq	%ymm13, %ymm6, %ymm6
	vpaddq	%ymm15, %ymm8, %ymm8
	vpaddq	%ymm12, %ymm10, %ymm10
	vpmuludq	%ymm14, %ymm0, %ymm12
	vperm2i128	$32, %ymm9, %ymm11, %ymm13
	vpmuludq	%ymm14, %ymm1, %ymm15
	vperm2i128	$49, %ymm9, %ymm11, %ymm9
	vpmuludq	%ymm14, %ymm2, %ymm11
	vpaddq	%ymm12, %ymm8, %ymm8
	vmovdqu	416(%rsp), %ymm12
	vpaddq	%ymm15, %ymm10, %ymm10
	vpaddq	%ymm11, %ymm7, %ymm7
	vpmuludq	%ymm12, %ymm2, %ymm2
	vpmuludq	%ymm12, %ymm3, %ymm11
	vmovdqu	576(%rsp), %ymm14
	vpmuludq	%ymm12, %ymm4, %ymm12
	vpsrldq	$6, %ymm13, %ymm15
	vpaddq	%ymm2, %ymm5, %ymm2
	vpsrldq	$6, %ymm9, %ymm5
	vpaddq	%ymm11, %ymm6, %ymm6
	vpaddq	%ymm8, %ymm12, %ymm11
	vmovdqu	384(%rsp), %ymm8
	vpmuludq	%ymm14, %ymm0, %ymm12
	vpmuludq	%ymm14, %ymm1, %ymm1
	vpunpckhqdq	%ymm9, %ymm13, %ymm14
	vpunpcklqdq	%ymm9, %ymm13, %ymm9
	vpaddq	%ymm12, %ymm10, %ymm10
	vpaddq	%ymm1, %ymm7, %ymm1
	vpmuludq	%ymm8, %ymm3, %ymm3
	vpmuludq	%ymm8, %ymm4, %ymm7
	vpaddq	%ymm3, %ymm2, %ymm2
	vpaddq	%ymm6, %ymm7, %ymm3
	vmovdqu	288(%rsp), %ymm12
	vpmuludq	352(%rsp), %ymm4, %ymm4
	vpmuludq	608(%rsp), %ymm0, %ymm0
	vpunpcklqdq	%ymm5, %ymm15, %ymm5
	vpsrlq	$4, %ymm5, %ymm6
	vpaddq	%ymm4, %ymm2, %ymm2
	vpsrlq	$26, %ymm2, %ymm4
	vpand	%ymm12, %ymm2, %ymm2
	vpand	%ymm12, %ymm10, %ymm7
	vpsrlq	$26, %ymm10, %ymm10
	vpaddq	%ymm0, %ymm1, %ymm0
	vpand	%ymm12, %ymm6, %ymm8
	vpsrlq	$26, %ymm9, %ymm13
	vpaddq	%ymm4, %ymm3, %ymm1
	vpaddq	%ymm10, %ymm0, %ymm0
	vpsrlq	$26, %ymm1, %ymm3
	vpsrlq	$26, %ymm0, %ymm4
	vpsllq	$2, %ymm4, %ymm6
	vpaddq	%ymm6, %ymm4, %ymm4
	vpand	%ymm12, %ymm1, %ymm1
	vpand	%ymm12, %ymm0, %ymm6
	vpaddq	%ymm3, %ymm11, %ymm0
	vpaddq	%ymm4, %ymm2, %ymm3
	vpsrlq	$26, %ymm0, %ymm4
	vpsrlq	$26, %ymm3, %ymm10
	vpand	%ymm12, %ymm0, %ymm2
	vpand	%ymm12, %ymm3, %ymm0
	vpaddq	%ymm4, %ymm7, %ymm3
	vpaddq	%ymm10, %ymm1, %ymm1
	vpsrlq	$26, %ymm3, %ymm4
	vpand	%ymm12, %ymm3, %ymm3
	vpaddq	%ymm4, %ymm6, %ymm4
	addq	$64, %rsi
	vpand	%ymm12, %ymm9, %ymm6
	vpsrlq	$30, %ymm5, %ymm5
	vpand	%ymm12, %ymm5, %ymm7
	vpsrlq	$40, %ymm14, %ymm5
	vpor	320(%rsp), %ymm5, %ymm10
	vpand	%ymm12, %ymm13, %ymm5
	addq	$-64, %r8
Lpoly1305_avx2$13:
	cmpq	$128, %r8
	jnb 	Lpoly1305_avx2$14
	addq	$-64, %r8
	vmovdqu	128(%rsp), %ymm9
	vmovdqu	160(%rsp), %ymm11
	vmovdqu	96(%rsp), %ymm12
	vpaddq	%ymm6, %ymm0, %ymm0
	vpaddq	%ymm5, %ymm1, %ymm1
	vpaddq	%ymm8, %ymm2, %ymm2
	vpaddq	%ymm7, %ymm3, %ymm3
	vpaddq	%ymm10, %ymm4, %ymm4
	vpmuludq	%ymm9, %ymm0, %ymm5
	vpmuludq	%ymm9, %ymm1, %ymm6
	vpmuludq	%ymm9, %ymm2, %ymm7
	vpmuludq	%ymm9, %ymm3, %ymm8
	vpmuludq	%ymm9, %ymm4, %ymm9
	vpmuludq	%ymm11, %ymm0, %ymm10
	vpmuludq	%ymm11, %ymm1, %ymm13
	vpmuludq	%ymm11, %ymm2, %ymm14
	vpmuludq	%ymm11, %ymm3, %ymm11
	vmovdqu	192(%rsp), %ymm15
	vpaddq	%ymm10, %ymm6, %ymm6
	vpaddq	%ymm13, %ymm7, %ymm7
	vpaddq	%ymm14, %ymm8, %ymm8
	vpaddq	%ymm11, %ymm9, %ymm9
	vpmuludq	%ymm12, %ymm1, %ymm10
	vpmuludq	%ymm12, %ymm2, %ymm11
	vpmuludq	%ymm12, %ymm3, %ymm13
	vpmuludq	%ymm12, %ymm4, %ymm12
	vmovdqu	64(%rsp), %ymm14
	vpaddq	%ymm10, %ymm5, %ymm5
	vpaddq	%ymm11, %ymm6, %ymm6
	vpaddq	%ymm13, %ymm7, %ymm7
	vpaddq	%ymm12, %ymm8, %ymm8
	vpmuludq	%ymm15, %ymm0, %ymm10
	vpmuludq	%ymm15, %ymm1, %ymm11
	vpmuludq	%ymm15, %ymm2, %ymm12
	vmovdqu	224(%rsp), %ymm13
	vpaddq	%ymm10, %ymm7, %ymm7
	vpaddq	%ymm11, %ymm8, %ymm8
	vpaddq	%ymm12, %ymm9, %ymm9
	vpmuludq	%ymm14, %ymm2, %ymm2
	vpmuludq	%ymm14, %ymm3, %ymm10
	vpmuludq	%ymm14, %ymm4, %ymm11
	vmovdqu	32(%rsp), %ymm12
	vpaddq	%ymm2, %ymm5, %ymm2
	vpaddq	%ymm10, %ymm6, %ymm5
	vpaddq	%ymm7, %ymm11, %ymm6
	vpmuludq	%ymm13, %ymm0, %ymm7
	vpmuludq	%ymm13, %ymm1, %ymm1
	vpaddq	%ymm7, %ymm8, %ymm7
	vpaddq	%ymm1, %ymm9, %ymm1
	vpmuludq	%ymm12, %ymm3, %ymm3
	vpmuludq	%ymm12, %ymm4, %ymm8
	vpaddq	%ymm3, %ymm2, %ymm2
	vpaddq	%ymm5, %ymm8, %ymm3
	vpmuludq	(%rsp), %ymm4, %ymm4
	vpmuludq	256(%rsp), %ymm0, %ymm0
	vpaddq	%ymm4, %ymm2, %ymm2
	vpaddq	%ymm0, %ymm1, %ymm0
	vmovdqu	288(%rsp), %ymm1
	vpsrlq	$26, %ymm2, %ymm4
	vpsrlq	$26, %ymm7, %ymm5
	vpand	%ymm1, %ymm2, %ymm2
	vpand	%ymm1, %ymm7, %ymm7
	vpaddq	%ymm4, %ymm3, %ymm3
	vpaddq	%ymm5, %ymm0, %ymm0
	vpsrlq	$26, %ymm3, %ymm4
	vpsrlq	$26, %ymm0, %ymm5
	vpsllq	$2, %ymm5, %ymm8
	vpaddq	%ymm8, %ymm5, %ymm5
	vpand	%ymm1, %ymm3, %ymm3
	vpand	%ymm1, %ymm0, %ymm0
	vpaddq	%ymm4, %ymm6, %ymm4
	vpaddq	%ymm5, %ymm2, %ymm2
	vpsrlq	$26, %ymm4, %ymm5
	vpsrlq	$26, %ymm2, %ymm6
	vpand	%ymm1, %ymm4, %ymm4
	vpand	%ymm1, %ymm2, %ymm2
	vpaddq	%ymm5, %ymm7, %ymm5
	vpaddq	%ymm6, %ymm3, %ymm3
	vpsrlq	$26, %ymm5, %ymm6
	vpand	%ymm1, %ymm5, %ymm1
	vpaddq	%ymm6, %ymm0, %ymm0
	vpsllq	$26, %ymm3, %ymm3
	vpaddq	%ymm2, %ymm3, %ymm2
	vpsllq	$26, %ymm1, %ymm1
	vpaddq	%ymm4, %ymm1, %ymm1
	vpsrldq	$8, %ymm0, %ymm3
	vpaddq	%ymm0, %ymm3, %ymm0
	vpermq	$-128, %ymm0, %ymm0
	vperm2i128	$32, %ymm1, %ymm2, %ymm3
	vperm2i128	$49, %ymm1, %ymm2, %ymm1
	vpaddq	%ymm1, %ymm3, %ymm1
	vpunpcklqdq	%ymm0, %ymm1, %ymm2
	vpunpckhqdq	%ymm0, %ymm1, %ymm0
	vpaddq	%ymm0, %ymm2, %ymm0
	vextracti128	$1, %ymm0, %xmm1
	vpextrq	$0, %xmm0, %rax
	vpextrq	$0, %xmm1, %rdx
	vpextrq	$1, %xmm1, %rbp
	movq	%rdx, %rbx
	shlq	$52, %rbx
	movq	%rdx, %r12
	shrq	$12, %r12
	movq	%rbp, %r13
	shrq	$24, %r13
	shlq	$40, %rbp
	addq	%rax, %rbx
	adcq	%rbp, %r12
	adcq	$0, %r13
	movq	%r13, %rax
	movq	%r13, %rdx
	andq	$3, %r13
	shrq	$2, %rax
	andq	$-4, %rdx
	addq	%rdx, %rax
	addq	%rax, %rbx
	adcq	$0, %r12
	adcq	$0, %r13
	jmp 	Lpoly1305_avx2$11
Lpoly1305_avx2$12:
	addq	(%rsi), %rbx
	adcq	8(%rsi), %r12
	adcq	$1, %r13
	movq	%r10, %rax
	mulq	%rbx
	movq	%rax, %rbp
	movq	%r9, %rax
	movq	%rdx, %r14
	mulq	%rbx
	movq	%rax, %rbx
	movq	%r9, %rax
	movq	%rdx, %r15
	mulq	%r12
	addq	%rax, %rbp
	movq	%r11, %rax
	adcq	%rdx, %r14
	mulq	%r12
	movq	%r13, %r12
	addq	%rax, %rbx
	adcq	%rdx, %r15
	imulq	%r11, %r12
	addq	%r12, %rbp
	movq	%r15, %r12
	adcq	$0, %r14
	imulq	%r9, %r13
	addq	%rbp, %r12
	movq	$-4, %rax
	adcq	%r13, %r14
	andq	%r14, %rax
	movq	%r14, %r13
	shrq	$2, %r14
	andq	$3, %r13
	addq	%r14, %rax
	addq	%rax, %rbx
	adcq	$0, %r12
	adcq	$0, %r13
	addq	$16, %rsi
	addq	$-16, %r8
Lpoly1305_avx2$11:
	cmpq	$16, %r8
	jnb 	Lpoly1305_avx2$12
	cmpq	$0, %r8
	jbe 	Lpoly1305_avx2$8
	movq	$0, 640(%rsp)
	movq	$0, 648(%rsp)
	movq	$0, %rax
	jmp 	Lpoly1305_avx2$9
Lpoly1305_avx2$10:
	movb	(%rsi,%rax), %dl
	movb	%dl, 640(%rsp,%rax)
	incq	%rax
Lpoly1305_avx2$9:
	cmpq	%r8, %rax
	jb  	Lpoly1305_avx2$10
	movb	$1, 640(%rsp,%rax)
	addq	640(%rsp), %rbx
	adcq	648(%rsp), %r12
	adcq	$0, %r13
	movq	%r10, %rax
	mulq	%rbx
	movq	%rax, %rsi
	movq	%r9, %rax
	movq	%rdx, %r8
	mulq	%rbx
	movq	%rax, %rbx
	movq	%r9, %rax
	movq	%rdx, %r10
	mulq	%r12
	addq	%rax, %rsi
	movq	%r11, %rax
	adcq	%rdx, %r8
	mulq	%r12
	movq	%r13, %rbp
	addq	%rax, %rbx
	adcq	%rdx, %r10
	imulq	%r11, %rbp
	addq	%rbp, %rsi
	movq	%r10, %r12
	adcq	$0, %r8
	imulq	%r9, %r13
	addq	%rsi, %r12
	movq	$-4, %rax
	adcq	%r13, %r8
	andq	%r8, %rax
	movq	%r8, %r13
	shrq	$2, %r8
	andq	$3, %r13
	addq	%r8, %rax
	addq	%rax, %rbx
	adcq	$0, %r12
	adcq	$0, %r13
Lpoly1305_avx2$8:
	movq	%rbx, %rax
	movq	%r12, %rdx
	movq	%r13, %rsi
	addq	$5, %rax
	adcq	$0, %rdx
	adcq	$0, %rsi
	shrq	$2, %rsi
	negq	%rsi
	xorq	%rbx, %rax
	xorq	%r12, %rdx
	andq	%rsi, %rax
	andq	%rsi, %rdx
	xorq	%rax, %rbx
	xorq	%rdx, %r12
	movq	(%rcx), %rax
	movq	8(%rcx), %rcx
	addq	%rax, %rbx
	adcq	%rcx, %r12
	movq	%rbx, (%rdi)
	movq	%r12, 8(%rdi)
	jmp 	Lpoly1305_avx2$2
Lpoly1305_avx2$1:
	movq	$0, %r8
	movq	$0, %r9
	movq	$0, %r10
	movq	(%rcx), %r11
	movq	8(%rcx), %rbp
	movq	$1152921487695413247, %rax
	andq	%rax, %r11
	movq	$1152921487695413244, %rax
	andq	%rax, %rbp
	movq	%rbp, %rbx
	shrq	$2, %rbx
	addq	%rbp, %rbx
	addq	$16, %rcx
	movq	%rdx, %r12
	jmp 	Lpoly1305_avx2$6
Lpoly1305_avx2$7:
	addq	(%rsi), %r8
	adcq	8(%rsi), %r9
	adcq	$1, %r10
	movq	%rbp, %rax
	mulq	%r8
	movq	%rax, %r13
	movq	%r11, %rax
	movq	%rdx, %r14
	mulq	%r8
	movq	%rax, %r8
	movq	%r11, %rax
	movq	%rdx, %r15
	mulq	%r9
	addq	%rax, %r13
	movq	%rbx, %rax
	adcq	%rdx, %r14
	mulq	%r9
	movq	%r10, %r9
	addq	%rax, %r8
	adcq	%rdx, %r15
	imulq	%rbx, %r9
	addq	%r9, %r13
	movq	%r15, %r9
	adcq	$0, %r14
	imulq	%r11, %r10
	addq	%r13, %r9
	movq	$-4, %rax
	adcq	%r10, %r14
	andq	%r14, %rax
	movq	%r14, %r10
	shrq	$2, %r14
	andq	$3, %r10
	addq	%r14, %rax
	addq	%rax, %r8
	adcq	$0, %r9
	adcq	$0, %r10
	addq	$16, %rsi
	addq	$-16, %r12
Lpoly1305_avx2$6:
	cmpq	$16, %r12
	jnb 	Lpoly1305_avx2$7
	cmpq	$0, %r12
	jbe 	Lpoly1305_avx2$3
	movq	$0, 640(%rsp)
	movq	$0, 648(%rsp)
	movq	$0, %rax
	jmp 	Lpoly1305_avx2$4
Lpoly1305_avx2$5:
	movb	(%rsi,%rax), %dl
	movb	%dl, 640(%rsp,%rax)
	incq	%rax
Lpoly1305_avx2$4:
	cmpq	%r12, %rax
	jb  	Lpoly1305_avx2$5
	movb	$1, 640(%rsp,%rax)
	addq	640(%rsp), %r8
	adcq	648(%rsp), %r9
	adcq	$0, %r10
	movq	%rbp, %rax
	mulq	%r8
	movq	%rax, %rsi
	movq	%r11, %rax
	movq	%rdx, %rbp
	mulq	%r8
	movq	%rax, %r8
	movq	%r11, %rax
	movq	%rdx, %r12
	mulq	%r9
	addq	%rax, %rsi
	movq	%rbx, %rax
	adcq	%rdx, %rbp
	mulq	%r9
	movq	%r10, %r9
	addq	%rax, %r8
	adcq	%rdx, %r12
	imulq	%rbx, %r9
	addq	%r9, %rsi
	movq	%r12, %r9
	adcq	$0, %rbp
	imulq	%r11, %r10
	addq	%rsi, %r9
	movq	$-4, %rax
	adcq	%r10, %rbp
	andq	%rbp, %rax
	movq	%rbp, %r10
	shrq	$2, %rbp
	andq	$3, %r10
	addq	%rbp, %rax
	addq	%rax, %r8
	adcq	$0, %r9
	adcq	$0, %r10
Lpoly1305_avx2$3:
	movq	%r8, %rax
	movq	%r9, %rdx
	movq	%r10, %rsi
	addq	$5, %rax
	adcq	$0, %rdx
	adcq	$0, %rsi
	shrq	$2, %rsi
	negq	%rsi
	xorq	%r8, %rax
	xorq	%r9, %rdx
	andq	%rsi, %rax
	andq	%rsi, %rdx
	xorq	%rax, %r8
	xorq	%rdx, %r9
	movq	(%rcx), %rax
	movq	8(%rcx), %rcx
	addq	%rax, %r8
	adcq	%rcx, %r9
	movq	%r8, (%rdi)
	movq	%r9, 8(%rdi)
Lpoly1305_avx2$2:
  movq -8(%rsp), %rsp
	addq	$656, %rsp
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	ret 
	.data
	.globl	_bit25_u64
	.globl	bit25_u64
	.p2align	3
_bit25_u64:
bit25_u64:
	.quad	16777216
	.globl	_mask26_u64
	.globl	mask26_u64
	.p2align	3
_mask26_u64:
mask26_u64:
	.quad	67108863
	.globl	_five_u64
	.globl	five_u64
	.p2align	3
_five_u64:
five_u64:
	.quad	5
	.globl	_zero_u64
	.globl	zero_u64
	.p2align	3
_zero_u64:
zero_u64:
	.quad	0

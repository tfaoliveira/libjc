	.text
	.p2align	5
	.globl	_curve25519_mulx
	.globl	curve25519_mulx
_curve25519_mulx:
curve25519_mulx:
	pushq	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$344, %rsp
	movq	%rdi, 336(%rsp)
	movq	(%rsi), %rax
	movq	%rax, 296(%rsp)
	movq	8(%rsi), %rax
	movq	%rax, 304(%rsp)
	movq	16(%rsi), %rax
	movq	%rax, 312(%rsp)
	movq	24(%rsi), %rax
	movq	%rax, 320(%rsp)
	andb	$-8, 296(%rsp)
	andb	$127, 327(%rsp)
	orb 	$64, 327(%rsp)
	movq	(%rdx), %rax
	movq	%rax, 128(%rsp)
	movq	%rax, 32(%rsp)
	movq	8(%rdx), %rax
	movq	%rax, 136(%rsp)
	movq	%rax, 40(%rsp)
	movq	16(%rdx), %rax
	movq	%rax, 144(%rsp)
	movq	%rax, 48(%rsp)
	movq	24(%rdx), %rax
	movq	$9223372036854775807, %rcx
	andq	%rcx, %rax
	movq	%rax, 152(%rsp)
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
	movq	%rax, 64(%rsp)
	movq	$1, 96(%rsp)
	movq	$1, 256(%rsp)
	movq	%rax, 72(%rsp)
	movq	%rax, 104(%rsp)
	movq	%rax, 264(%rsp)
	movq	%rax, 80(%rsp)
	movq	%rax, 112(%rsp)
	movq	%rax, 272(%rsp)
	movq	%rax, 88(%rsp)
	movq	%rax, 120(%rsp)
	movq	%rax, 280(%rsp)
	movq	$254, %rcx
	movq	$0, 288(%rsp)
Lcurve25519_mulx$9:
	movq	%rcx, 328(%rsp)
	movq	288(%rsp), %rax
	movq	%rcx, %rdx
	shrq	$3, %rdx
	movzbq	296(%rsp,%rdx), %rdx
	andq	$7, %rcx
	shrq	%cl, %rdx
	andq	$1, %rdx
	xorq	%rdx, %rax
	movq	256(%rsp), %rcx
	movq	264(%rsp), %rsi
	movq	272(%rsp), %rdi
	movq	280(%rsp), %r8
	movq	128(%rsp), %r9
	movq	136(%rsp), %r10
	movq	144(%rsp), %r11
	movq	152(%rsp), %rbp
	movq	$0, %rbx
	subq	%rax, %rbx
	movq	%rcx, %r12
	xorq	%r9, %r12
	andq	%rbx, %r12
	xorq	%r12, %rcx
	xorq	%r12, %r9
	movq	%rsi, %r12
	xorq	%r10, %r12
	andq	%rbx, %r12
	xorq	%r12, %rsi
	xorq	%r12, %r10
	movq	%rdi, %r12
	xorq	%r11, %r12
	andq	%rbx, %r12
	xorq	%r12, %rdi
	xorq	%r12, %r11
	movq	%r8, %r12
	xorq	%rbp, %r12
	andq	%rbx, %r12
	xorq	%r12, %r8
	xorq	%r12, %rbp
	movq	%rcx, 256(%rsp)
	movq	%rsi, 264(%rsp)
	movq	%rdi, 272(%rsp)
	movq	%r8, 280(%rsp)
	movq	%r9, 128(%rsp)
	movq	%r10, 136(%rsp)
	movq	%r11, 144(%rsp)
	movq	%rbp, 152(%rsp)
	movq	64(%rsp), %rcx
	movq	72(%rsp), %rsi
	movq	80(%rsp), %rdi
	movq	88(%rsp), %r8
	movq	96(%rsp), %r9
	movq	104(%rsp), %r10
	movq	112(%rsp), %r11
	movq	120(%rsp), %rbp
	movq	$0, %rbx
	subq	%rax, %rbx
	movq	%rcx, %rax
	xorq	%r9, %rax
	andq	%rbx, %rax
	xorq	%rax, %rcx
	xorq	%rax, %r9
	movq	%rsi, %rax
	xorq	%r10, %rax
	andq	%rbx, %rax
	xorq	%rax, %rsi
	xorq	%rax, %r10
	movq	%rdi, %rax
	xorq	%r11, %rax
	andq	%rbx, %rax
	xorq	%rax, %rdi
	xorq	%rax, %r11
	movq	%r8, %rax
	xorq	%rbp, %rax
	andq	%rbx, %rax
	xorq	%rax, %r8
	xorq	%rax, %rbp
	movq	%rcx, 64(%rsp)
	movq	%rsi, 72(%rsp)
	movq	%rdi, 80(%rsp)
	movq	%r8, 88(%rsp)
	movq	%r9, 96(%rsp)
	movq	%r10, 104(%rsp)
	movq	%r11, 112(%rsp)
	movq	%rbp, 120(%rsp)
	movq	%rdx, 288(%rsp)
	xorl	%eax, %eax
	movq	256(%rsp), %rcx
	movq	264(%rsp), %rdx
	movq	272(%rsp), %rsi
	movq	280(%rsp), %rdi
	subq	64(%rsp), %rcx
	sbbq	72(%rsp), %rdx
	sbbq	80(%rsp), %rsi
	sbbq	88(%rsp), %rdi
	sbbq	%rax, %rax
	andq	$38, %rax
	subq	%rax, %rcx
	sbbq	$0, %rdx
	sbbq	$0, %rsi
	sbbq	$0, %rdi
	sbbq	%rax, %rax
	andq	$38, %rax
	subq	%rax, %rcx
	movq	%rcx, 192(%rsp)
	movq	%rdx, 200(%rsp)
	movq	%rsi, 208(%rsp)
	movq	%rdi, 216(%rsp)
	xorl	%eax, %eax
	movq	256(%rsp), %rcx
	movq	264(%rsp), %rdx
	movq	272(%rsp), %rsi
	movq	280(%rsp), %rdi
	addq	64(%rsp), %rcx
	adcq	72(%rsp), %rdx
	adcq	80(%rsp), %rsi
	adcq	88(%rsp), %rdi
	sbbq	%rax, %rax
	andq	$38, %rax
	addq	%rax, %rcx
	adcq	$0, %rdx
	adcq	$0, %rsi
	adcq	$0, %rdi
	sbbq	%rax, %rax
	andq	$38, %rax
	leaq	(%rcx,%rax), %rax
	movq	%rax, 160(%rsp)
	movq	%rdx, 168(%rsp)
	movq	%rsi, 176(%rsp)
	movq	%rdi, 184(%rsp)
	xorl	%eax, %eax
	movq	128(%rsp), %rcx
	movq	136(%rsp), %rdx
	movq	144(%rsp), %rsi
	movq	152(%rsp), %rdi
	subq	96(%rsp), %rcx
	sbbq	104(%rsp), %rdx
	sbbq	112(%rsp), %rsi
	sbbq	120(%rsp), %rdi
	sbbq	%rax, %rax
	andq	$38, %rax
	subq	%rax, %rcx
	sbbq	$0, %rdx
	sbbq	$0, %rsi
	sbbq	$0, %rdi
	sbbq	%rax, %rax
	andq	$38, %rax
	subq	%rax, %rcx
	movq	%rcx, 256(%rsp)
	movq	%rdx, 264(%rsp)
	movq	%rsi, 272(%rsp)
	movq	%rdi, 280(%rsp)
	xorl	%eax, %eax
	movq	128(%rsp), %rcx
	movq	136(%rsp), %rdx
	movq	144(%rsp), %rsi
	movq	152(%rsp), %rdi
	addq	96(%rsp), %rcx
	adcq	104(%rsp), %rdx
	adcq	112(%rsp), %rsi
	adcq	120(%rsp), %rdi
	sbbq	%rax, %rax
	andq	$38, %rax
	addq	%rax, %rcx
	adcq	$0, %rdx
	adcq	$0, %rsi
	adcq	$0, %rdi
	sbbq	%rax, %rax
	andq	$38, %rax
	leaq	(%rcx,%rax), %rax
	movq	%rax, 224(%rsp)
	movq	%rdx, 232(%rsp)
	movq	%rsi, 240(%rsp)
	movq	%rdi, 248(%rsp)
	movq	256(%rsp), %rax
	movq	264(%rsp), %rcx
	movq	272(%rsp), %rsi
	movq	280(%rsp), %rdi
	xorl	%r8d, %r8d
	xorq	%r8, %r8
	movq	160(%rsp), %rdx
	mulxq	%rax, %r10, %r9
	mulxq	%rcx, %rbp, %r11
	adcxq	%rbp, %r9
	mulxq	%rsi, %rbx, %rbp
	adcxq	%rbx, %r11
	mulxq	%rdi, %rdx, %rbx
	adcxq	%rdx, %rbp
	adcxq	%r8, %rbx
	movq	168(%rsp), %rdx
	mulxq	%rax, %r13, %r12
	adoxq	%r13, %r9
	adcxq	%r12, %r11
	mulxq	%rcx, %r13, %r12
	adoxq	%r13, %r11
	adcxq	%r12, %rbp
	mulxq	%rsi, %r13, %r12
	adoxq	%r13, %rbp
	adcxq	%r12, %rbx
	mulxq	%rdi, %rdx, %r12
	adoxq	%rdx, %rbx
	adcxq	%r8, %r12
	adoxq	%r8, %r12
	movq	176(%rsp), %rdx
	mulxq	%rax, %r14, %r13
	adoxq	%r14, %r11
	adcxq	%r13, %rbp
	mulxq	%rcx, %r14, %r13
	adoxq	%r14, %rbp
	adcxq	%r13, %rbx
	mulxq	%rsi, %r14, %r13
	adoxq	%r14, %rbx
	adcxq	%r13, %r12
	mulxq	%rdi, %rdx, %r13
	adoxq	%rdx, %r12
	adcxq	%r8, %r13
	adoxq	%r8, %r13
	movq	184(%rsp), %rdx
	mulxq	%rax, %r14, %rax
	adoxq	%r14, %rbp
	adcxq	%rax, %rbx
	mulxq	%rcx, %rcx, %rax
	adoxq	%rcx, %rbx
	adcxq	%rax, %r12
	mulxq	%rsi, %rcx, %rax
	adoxq	%rcx, %r12
	adcxq	%rax, %r13
	mulxq	%rdi, %rcx, %rax
	adoxq	%rcx, %r13
	adcxq	%r8, %rax
	adoxq	%r8, %rax
	movq	$38, %rdx
	mulxq	%rbx, %rsi, %rcx
	adoxq	%rsi, %r10
	adcxq	%rcx, %r9
	mulxq	%r12, %rsi, %rcx
	adoxq	%rsi, %r9
	adcxq	%rcx, %r11
	mulxq	%r13, %rsi, %rcx
	adoxq	%rsi, %r11
	adcxq	%rcx, %rbp
	mulxq	%rax, %rcx, %rax
	adoxq	%rcx, %rbp
	adcxq	%r8, %rax
	adoxq	%r8, %rax
	imulq	$38, %rax, %rax
	addq	%rax, %r10
	adcq	%r8, %r9
	adcq	%r8, %r11
	adcq	%r8, %rbp
	sbbq	%r8, %r8
	andq	$38, %r8
	leaq	(%r10,%r8), %rax
	movq	%rax, 128(%rsp)
	movq	%r9, 136(%rsp)
	movq	%r11, 144(%rsp)
	movq	%rbp, 152(%rsp)
	movq	192(%rsp), %rax
	movq	200(%rsp), %rcx
	movq	208(%rsp), %rsi
	movq	216(%rsp), %rdi
	xorl	%r8d, %r8d
	xorq	%r8, %r8
	movq	224(%rsp), %rdx
	mulxq	%rax, %r10, %r9
	mulxq	%rcx, %rbp, %r11
	adcxq	%rbp, %r9
	mulxq	%rsi, %rbx, %rbp
	adcxq	%rbx, %r11
	mulxq	%rdi, %rdx, %rbx
	adcxq	%rdx, %rbp
	adcxq	%r8, %rbx
	movq	232(%rsp), %rdx
	mulxq	%rax, %r13, %r12
	adoxq	%r13, %r9
	adcxq	%r12, %r11
	mulxq	%rcx, %r13, %r12
	adoxq	%r13, %r11
	adcxq	%r12, %rbp
	mulxq	%rsi, %r13, %r12
	adoxq	%r13, %rbp
	adcxq	%r12, %rbx
	mulxq	%rdi, %rdx, %r12
	adoxq	%rdx, %rbx
	adcxq	%r8, %r12
	adoxq	%r8, %r12
	movq	240(%rsp), %rdx
	mulxq	%rax, %r14, %r13
	adoxq	%r14, %r11
	adcxq	%r13, %rbp
	mulxq	%rcx, %r14, %r13
	adoxq	%r14, %rbp
	adcxq	%r13, %rbx
	mulxq	%rsi, %r14, %r13
	adoxq	%r14, %rbx
	adcxq	%r13, %r12
	mulxq	%rdi, %rdx, %r13
	adoxq	%rdx, %r12
	adcxq	%r8, %r13
	adoxq	%r8, %r13
	movq	248(%rsp), %rdx
	mulxq	%rax, %r14, %rax
	adoxq	%r14, %rbp
	adcxq	%rax, %rbx
	mulxq	%rcx, %rcx, %rax
	adoxq	%rcx, %rbx
	adcxq	%rax, %r12
	mulxq	%rsi, %rcx, %rax
	adoxq	%rcx, %r12
	adcxq	%rax, %r13
	mulxq	%rdi, %rcx, %rax
	adoxq	%rcx, %r13
	adcxq	%r8, %rax
	adoxq	%r8, %rax
	movq	$38, %rdx
	mulxq	%rbx, %rsi, %rcx
	adoxq	%rsi, %r10
	adcxq	%rcx, %r9
	mulxq	%r12, %rsi, %rcx
	adoxq	%rsi, %r9
	adcxq	%rcx, %r11
	mulxq	%r13, %rsi, %rcx
	adoxq	%rsi, %r11
	adcxq	%rcx, %rbp
	mulxq	%rax, %rcx, %rax
	adoxq	%rcx, %rbp
	adcxq	%r8, %rax
	adoxq	%r8, %rax
	imulq	$38, %rax, %rax
	addq	%rax, %r10
	adcq	%r8, %r9
	adcq	%r8, %r11
	adcq	%r8, %rbp
	sbbq	%r8, %r8
	andq	$38, %r8
	leaq	(%r10,%r8), %rax
	movq	%rax, 256(%rsp)
	movq	%r9, 264(%rsp)
	movq	%r11, 272(%rsp)
	movq	%rbp, 280(%rsp)
	movq	192(%rsp), %rdx
	movq	200(%rsp), %rax
	movq	208(%rsp), %rcx
	movq	216(%rsp), %rsi
	xorl	%edi, %edi
	xorq	%rdi, %rdi
	mulxq	%rdx, %r9, %r8
	mulxq	%rax, %r11, %r10
	mulxq	%rcx, %rbx, %rbp
	adcxq	%rbx, %r10
	mulxq	%rsi, %rdx, %rbx
	adcxq	%rdx, %rbp
	movq	%rax, %rdx
	mulxq	%rcx, %r12, %rax
	adoxq	%r12, %rbp
	adcxq	%rax, %rbx
	mulxq	%rsi, %r12, %rax
	adoxq	%r12, %rbx
	mulxq	%rdx, %r13, %r12
	movq	%rcx, %rdx
	mulxq	%rsi, %r14, %rcx
	adcxq	%r14, %rax
	adoxq	%rdi, %rax
	adcxq	%rdi, %rcx
	adoxq	%rdi, %rcx
	mulxq	%rdx, %r15, %r14
	movq	%rsi, %rdx
	mulxq	%rdx, %rdx, %rsi
	adcxq	%r11, %r11
	adoxq	%r8, %r11
	adcxq	%r10, %r10
	adoxq	%r13, %r10
	adcxq	%rbp, %rbp
	adoxq	%r12, %rbp
	adcxq	%rbx, %rbx
	adoxq	%r15, %rbx
	adcxq	%rax, %rax
	adoxq	%r14, %rax
	adcxq	%rcx, %rcx
	adoxq	%rdx, %rcx
	adcxq	%rdi, %rsi
	adoxq	%rdi, %rsi
	movq	$38, %rdx
	mulxq	%rbx, %rbx, %r8
	adoxq	%rbx, %r9
	adcxq	%r8, %r11
	mulxq	%rax, %r8, %rax
	adoxq	%r8, %r11
	adcxq	%rax, %r10
	mulxq	%rcx, %rcx, %rax
	adoxq	%rcx, %r10
	adcxq	%rax, %rbp
	mulxq	%rsi, %rcx, %rax
	adoxq	%rcx, %rbp
	adcxq	%rdi, %rax
	adoxq	%rdi, %rax
	imulq	$38, %rax, %rax
	addq	%rax, %r9
	adcq	%rdi, %r11
	adcq	%rdi, %r10
	adcq	%rdi, %rbp
	sbbq	%rdi, %rdi
	andq	$38, %rdi
	leaq	(%r9,%rdi), %rax
	movq	%rax, 96(%rsp)
	movq	%r11, 104(%rsp)
	movq	%r10, 112(%rsp)
	movq	%rbp, 120(%rsp)
	movq	160(%rsp), %rdx
	movq	168(%rsp), %rax
	movq	176(%rsp), %rcx
	movq	184(%rsp), %rsi
	xorl	%edi, %edi
	xorq	%rdi, %rdi
	mulxq	%rdx, %r9, %r8
	mulxq	%rax, %r11, %r10
	mulxq	%rcx, %rbx, %rbp
	adcxq	%rbx, %r10
	mulxq	%rsi, %rdx, %rbx
	adcxq	%rdx, %rbp
	movq	%rax, %rdx
	mulxq	%rcx, %r12, %rax
	adoxq	%r12, %rbp
	adcxq	%rax, %rbx
	mulxq	%rsi, %r12, %rax
	adoxq	%r12, %rbx
	mulxq	%rdx, %r13, %r12
	movq	%rcx, %rdx
	mulxq	%rsi, %r14, %rcx
	adcxq	%r14, %rax
	adoxq	%rdi, %rax
	adcxq	%rdi, %rcx
	adoxq	%rdi, %rcx
	mulxq	%rdx, %r15, %r14
	movq	%rsi, %rdx
	mulxq	%rdx, %rdx, %rsi
	adcxq	%r11, %r11
	adoxq	%r8, %r11
	adcxq	%r10, %r10
	adoxq	%r13, %r10
	adcxq	%rbp, %rbp
	adoxq	%r12, %rbp
	adcxq	%rbx, %rbx
	adoxq	%r15, %rbx
	adcxq	%rax, %rax
	adoxq	%r14, %rax
	adcxq	%rcx, %rcx
	adoxq	%rdx, %rcx
	adcxq	%rdi, %rsi
	adoxq	%rdi, %rsi
	movq	$38, %rdx
	mulxq	%rbx, %rbx, %r8
	adoxq	%rbx, %r9
	adcxq	%r8, %r11
	mulxq	%rax, %r8, %rax
	adoxq	%r8, %r11
	adcxq	%rax, %r10
	mulxq	%rcx, %rcx, %rax
	adoxq	%rcx, %r10
	adcxq	%rax, %rbp
	mulxq	%rsi, %rcx, %rax
	adoxq	%rcx, %rbp
	adcxq	%rdi, %rax
	adoxq	%rdi, %rax
	imulq	$38, %rax, %rax
	addq	%rax, %r9
	adcq	%rdi, %r11
	adcq	%rdi, %r10
	adcq	%rdi, %rbp
	sbbq	%rdi, %rdi
	andq	$38, %rdi
	leaq	(%r9,%rdi), %rax
	movq	%rax, 224(%rsp)
	movq	%r11, 232(%rsp)
	movq	%r10, 240(%rsp)
	movq	%rbp, 248(%rsp)
	xorl	%eax, %eax
	movq	128(%rsp), %rcx
	movq	136(%rsp), %rdx
	movq	144(%rsp), %rsi
	movq	152(%rsp), %rdi
	addq	256(%rsp), %rcx
	adcq	264(%rsp), %rdx
	adcq	272(%rsp), %rsi
	adcq	280(%rsp), %rdi
	sbbq	%rax, %rax
	andq	$38, %rax
	addq	%rax, %rcx
	adcq	$0, %rdx
	adcq	$0, %rsi
	adcq	$0, %rdi
	sbbq	%rax, %rax
	andq	$38, %rax
	leaq	(%rcx,%rax), %rax
	movq	%rax, 160(%rsp)
	movq	%rdx, 168(%rsp)
	movq	%rsi, 176(%rsp)
	movq	%rdi, 184(%rsp)
	xorl	%eax, %eax
	movq	128(%rsp), %rcx
	movq	136(%rsp), %rdx
	movq	144(%rsp), %rsi
	movq	152(%rsp), %rdi
	subq	256(%rsp), %rcx
	sbbq	264(%rsp), %rdx
	sbbq	272(%rsp), %rsi
	sbbq	280(%rsp), %rdi
	sbbq	%rax, %rax
	andq	$38, %rax
	subq	%rax, %rcx
	sbbq	$0, %rdx
	sbbq	$0, %rsi
	sbbq	$0, %rdi
	sbbq	%rax, %rax
	andq	$38, %rax
	subq	%rax, %rcx
	movq	%rcx, 192(%rsp)
	movq	%rdx, 200(%rsp)
	movq	%rsi, 208(%rsp)
	movq	%rdi, 216(%rsp)
	movq	96(%rsp), %rax
	movq	104(%rsp), %rcx
	movq	112(%rsp), %rsi
	movq	120(%rsp), %rdi
	xorl	%r8d, %r8d
	xorq	%r8, %r8
	movq	224(%rsp), %rdx
	mulxq	%rax, %r10, %r9
	mulxq	%rcx, %rbp, %r11
	adcxq	%rbp, %r9
	mulxq	%rsi, %rbx, %rbp
	adcxq	%rbx, %r11
	mulxq	%rdi, %rdx, %rbx
	adcxq	%rdx, %rbp
	adcxq	%r8, %rbx
	movq	232(%rsp), %rdx
	mulxq	%rax, %r13, %r12
	adoxq	%r13, %r9
	adcxq	%r12, %r11
	mulxq	%rcx, %r13, %r12
	adoxq	%r13, %r11
	adcxq	%r12, %rbp
	mulxq	%rsi, %r13, %r12
	adoxq	%r13, %rbp
	adcxq	%r12, %rbx
	mulxq	%rdi, %rdx, %r12
	adoxq	%rdx, %rbx
	adcxq	%r8, %r12
	adoxq	%r8, %r12
	movq	240(%rsp), %rdx
	mulxq	%rax, %r14, %r13
	adoxq	%r14, %r11
	adcxq	%r13, %rbp
	mulxq	%rcx, %r14, %r13
	adoxq	%r14, %rbp
	adcxq	%r13, %rbx
	mulxq	%rsi, %r14, %r13
	adoxq	%r14, %rbx
	adcxq	%r13, %r12
	mulxq	%rdi, %rdx, %r13
	adoxq	%rdx, %r12
	adcxq	%r8, %r13
	adoxq	%r8, %r13
	movq	248(%rsp), %rdx
	mulxq	%rax, %r14, %rax
	adoxq	%r14, %rbp
	adcxq	%rax, %rbx
	mulxq	%rcx, %rcx, %rax
	adoxq	%rcx, %rbx
	adcxq	%rax, %r12
	mulxq	%rsi, %rcx, %rax
	adoxq	%rcx, %r12
	adcxq	%rax, %r13
	mulxq	%rdi, %rcx, %rax
	adoxq	%rcx, %r13
	adcxq	%r8, %rax
	adoxq	%r8, %rax
	movq	$38, %rdx
	mulxq	%rbx, %rsi, %rcx
	adoxq	%rsi, %r10
	adcxq	%rcx, %r9
	mulxq	%r12, %rsi, %rcx
	adoxq	%rsi, %r9
	adcxq	%rcx, %r11
	mulxq	%r13, %rsi, %rcx
	adoxq	%rsi, %r11
	adcxq	%rcx, %rbp
	mulxq	%rax, %rcx, %rax
	adoxq	%rcx, %rbp
	adcxq	%r8, %rax
	adoxq	%r8, %rax
	imulq	$38, %rax, %rax
	addq	%rax, %r10
	adcq	%r8, %r9
	adcq	%r8, %r11
	adcq	%r8, %rbp
	sbbq	%r8, %r8
	andq	$38, %r8
	leaq	(%r10,%r8), %rax
	movq	%rax, 256(%rsp)
	movq	%r9, 264(%rsp)
	movq	%r11, 272(%rsp)
	movq	%rbp, 280(%rsp)
	xorl	%eax, %eax
	movq	224(%rsp), %rcx
	movq	232(%rsp), %rdx
	movq	240(%rsp), %rsi
	movq	248(%rsp), %rdi
	subq	96(%rsp), %rcx
	sbbq	104(%rsp), %rdx
	sbbq	112(%rsp), %rsi
	sbbq	120(%rsp), %rdi
	sbbq	%rax, %rax
	andq	$38, %rax
	subq	%rax, %rcx
	sbbq	$0, %rdx
	sbbq	$0, %rsi
	sbbq	$0, %rdi
	sbbq	%rax, %rax
	andq	$38, %rax
	subq	%rax, %rcx
	movq	%rcx, (%rsp)
	movq	%rdx, 8(%rsp)
	movq	%rsi, 16(%rsp)
	movq	%rdi, 24(%rsp)
	movq	192(%rsp), %rdx
	movq	200(%rsp), %rax
	movq	208(%rsp), %rcx
	movq	216(%rsp), %rsi
	xorl	%edi, %edi
	xorq	%rdi, %rdi
	mulxq	%rdx, %r9, %r8
	mulxq	%rax, %r11, %r10
	mulxq	%rcx, %rbx, %rbp
	adcxq	%rbx, %r10
	mulxq	%rsi, %rdx, %rbx
	adcxq	%rdx, %rbp
	movq	%rax, %rdx
	mulxq	%rcx, %r12, %rax
	adoxq	%r12, %rbp
	adcxq	%rax, %rbx
	mulxq	%rsi, %r12, %rax
	adoxq	%r12, %rbx
	mulxq	%rdx, %r13, %r12
	movq	%rcx, %rdx
	mulxq	%rsi, %r14, %rcx
	adcxq	%r14, %rax
	adoxq	%rdi, %rax
	adcxq	%rdi, %rcx
	adoxq	%rdi, %rcx
	mulxq	%rdx, %r15, %r14
	movq	%rsi, %rdx
	mulxq	%rdx, %rdx, %rsi
	adcxq	%r11, %r11
	adoxq	%r8, %r11
	adcxq	%r10, %r10
	adoxq	%r13, %r10
	adcxq	%rbp, %rbp
	adoxq	%r12, %rbp
	adcxq	%rbx, %rbx
	adoxq	%r15, %rbx
	adcxq	%rax, %rax
	adoxq	%r14, %rax
	adcxq	%rcx, %rcx
	adoxq	%rdx, %rcx
	adcxq	%rdi, %rsi
	adoxq	%rdi, %rsi
	movq	$38, %rdx
	mulxq	%rbx, %rbx, %r8
	adoxq	%rbx, %r9
	adcxq	%r8, %r11
	mulxq	%rax, %r8, %rax
	adoxq	%r8, %r11
	adcxq	%rax, %r10
	mulxq	%rcx, %rcx, %rax
	adoxq	%rcx, %r10
	adcxq	%rax, %rbp
	mulxq	%rsi, %rcx, %rax
	adoxq	%rcx, %rbp
	adcxq	%rdi, %rax
	adoxq	%rdi, %rax
	imulq	$38, %rax, %rax
	addq	%rax, %r9
	adcq	%rdi, %r11
	adcq	%rdi, %r10
	adcq	%rdi, %rbp
	sbbq	%rdi, %rdi
	andq	$38, %rdi
	leaq	(%r9,%rdi), %rax
	movq	%rax, 64(%rsp)
	movq	%r11, 72(%rsp)
	movq	%r10, 80(%rsp)
	movq	%rbp, 88(%rsp)
	movq	$121666, %rdx
	mulxq	(%rsp), %rcx, %rax
	mulxq	8(%rsp), %rdi, %rsi
	addq	%rdi, %rax
	mulxq	16(%rsp), %r8, %rdi
	adcq	%r8, %rsi
	mulxq	24(%rsp), %r9, %r8
	adcq	%r9, %rdi
	adcq	$0, %r8
	imulq	$38, %r8, %r8
	addq	%r8, %rcx
	adcq	$0, %rax
	adcq	$0, %rsi
	adcq	$0, %rdi
	sbbq	%rdx, %rdx
	andq	$38, %rdx
	leaq	(%rcx,%rdx), %rcx
	movq	%rcx, 224(%rsp)
	movq	%rax, 232(%rsp)
	movq	%rsi, 240(%rsp)
	movq	%rdi, 248(%rsp)
	movq	160(%rsp), %rdx
	movq	168(%rsp), %rax
	movq	176(%rsp), %rcx
	movq	184(%rsp), %rsi
	xorl	%edi, %edi
	xorq	%rdi, %rdi
	mulxq	%rdx, %r9, %r8
	mulxq	%rax, %r11, %r10
	mulxq	%rcx, %rbx, %rbp
	adcxq	%rbx, %r10
	mulxq	%rsi, %rdx, %rbx
	adcxq	%rdx, %rbp
	movq	%rax, %rdx
	mulxq	%rcx, %r12, %rax
	adoxq	%r12, %rbp
	adcxq	%rax, %rbx
	mulxq	%rsi, %r12, %rax
	adoxq	%r12, %rbx
	mulxq	%rdx, %r13, %r12
	movq	%rcx, %rdx
	mulxq	%rsi, %r14, %rcx
	adcxq	%r14, %rax
	adoxq	%rdi, %rax
	adcxq	%rdi, %rcx
	adoxq	%rdi, %rcx
	mulxq	%rdx, %r15, %r14
	movq	%rsi, %rdx
	mulxq	%rdx, %rdx, %rsi
	adcxq	%r11, %r11
	adoxq	%r8, %r11
	adcxq	%r10, %r10
	adoxq	%r13, %r10
	adcxq	%rbp, %rbp
	adoxq	%r12, %rbp
	adcxq	%rbx, %rbx
	adoxq	%r15, %rbx
	adcxq	%rax, %rax
	adoxq	%r14, %rax
	adcxq	%rcx, %rcx
	adoxq	%rdx, %rcx
	adcxq	%rdi, %rsi
	adoxq	%rdi, %rsi
	movq	$38, %rdx
	mulxq	%rbx, %rbx, %r8
	adoxq	%rbx, %r9
	adcxq	%r8, %r11
	mulxq	%rax, %r8, %rax
	adoxq	%r8, %r11
	adcxq	%rax, %r10
	mulxq	%rcx, %rcx, %rax
	adoxq	%rcx, %r10
	adcxq	%rax, %rbp
	mulxq	%rsi, %rcx, %rax
	adoxq	%rcx, %rbp
	adcxq	%rdi, %rax
	adoxq	%rdi, %rax
	imulq	$38, %rax, %rax
	addq	%rax, %r9
	adcq	%rdi, %r11
	adcq	%rdi, %r10
	adcq	%rdi, %rbp
	sbbq	%rdi, %rdi
	andq	$38, %rdi
	leaq	(%r9,%rdi), %rax
	movq	%rax, 128(%rsp)
	movq	%r11, 136(%rsp)
	movq	%r10, 144(%rsp)
	movq	%rbp, 152(%rsp)
	xorl	%eax, %eax
	movq	96(%rsp), %rcx
	movq	104(%rsp), %rdx
	movq	112(%rsp), %rsi
	movq	120(%rsp), %rdi
	addq	224(%rsp), %rcx
	adcq	232(%rsp), %rdx
	adcq	240(%rsp), %rsi
	adcq	248(%rsp), %rdi
	sbbq	%rax, %rax
	andq	$38, %rax
	addq	%rax, %rcx
	adcq	$0, %rdx
	adcq	$0, %rsi
	adcq	$0, %rdi
	sbbq	%rax, %rax
	andq	$38, %rax
	leaq	(%rcx,%rax), %rax
	movq	%rax, 192(%rsp)
	movq	%rdx, 200(%rsp)
	movq	%rsi, 208(%rsp)
	movq	%rdi, 216(%rsp)
	movq	64(%rsp), %rax
	movq	72(%rsp), %rcx
	movq	80(%rsp), %rsi
	movq	88(%rsp), %rdi
	xorl	%r8d, %r8d
	xorq	%r8, %r8
	movq	32(%rsp), %rdx
	mulxq	%rax, %r10, %r9
	mulxq	%rcx, %rbp, %r11
	adcxq	%rbp, %r9
	mulxq	%rsi, %rbx, %rbp
	adcxq	%rbx, %r11
	mulxq	%rdi, %rdx, %rbx
	adcxq	%rdx, %rbp
	adcxq	%r8, %rbx
	movq	40(%rsp), %rdx
	mulxq	%rax, %r13, %r12
	adoxq	%r13, %r9
	adcxq	%r12, %r11
	mulxq	%rcx, %r13, %r12
	adoxq	%r13, %r11
	adcxq	%r12, %rbp
	mulxq	%rsi, %r13, %r12
	adoxq	%r13, %rbp
	adcxq	%r12, %rbx
	mulxq	%rdi, %rdx, %r12
	adoxq	%rdx, %rbx
	adcxq	%r8, %r12
	adoxq	%r8, %r12
	movq	48(%rsp), %rdx
	mulxq	%rax, %r14, %r13
	adoxq	%r14, %r11
	adcxq	%r13, %rbp
	mulxq	%rcx, %r14, %r13
	adoxq	%r14, %rbp
	adcxq	%r13, %rbx
	mulxq	%rsi, %r14, %r13
	adoxq	%r14, %rbx
	adcxq	%r13, %r12
	mulxq	%rdi, %rdx, %r13
	adoxq	%rdx, %r12
	adcxq	%r8, %r13
	adoxq	%r8, %r13
	movq	56(%rsp), %rdx
	mulxq	%rax, %r14, %rax
	adoxq	%r14, %rbp
	adcxq	%rax, %rbx
	mulxq	%rcx, %rcx, %rax
	adoxq	%rcx, %rbx
	adcxq	%rax, %r12
	mulxq	%rsi, %rcx, %rax
	adoxq	%rcx, %r12
	adcxq	%rax, %r13
	mulxq	%rdi, %rcx, %rax
	adoxq	%rcx, %r13
	adcxq	%r8, %rax
	adoxq	%r8, %rax
	movq	$38, %rdx
	mulxq	%rbx, %rsi, %rcx
	adoxq	%rsi, %r10
	adcxq	%rcx, %r9
	mulxq	%r12, %rsi, %rcx
	adoxq	%rsi, %r9
	adcxq	%rcx, %r11
	mulxq	%r13, %rsi, %rcx
	adoxq	%rsi, %r11
	adcxq	%rcx, %rbp
	mulxq	%rax, %rcx, %rax
	adoxq	%rcx, %rbp
	adcxq	%r8, %rax
	adoxq	%r8, %rax
	imulq	$38, %rax, %rax
	addq	%rax, %r10
	adcq	%r8, %r9
	adcq	%r8, %r11
	adcq	%r8, %rbp
	sbbq	%r8, %r8
	andq	$38, %r8
	leaq	(%r10,%r8), %rax
	movq	%rax, 96(%rsp)
	movq	%r9, 104(%rsp)
	movq	%r11, 112(%rsp)
	movq	%rbp, 120(%rsp)
	movq	192(%rsp), %rax
	movq	200(%rsp), %rcx
	movq	208(%rsp), %rsi
	movq	216(%rsp), %rdi
	xorl	%r8d, %r8d
	xorq	%r8, %r8
	movq	(%rsp), %rdx
	mulxq	%rax, %r10, %r9
	mulxq	%rcx, %rbp, %r11
	adcxq	%rbp, %r9
	mulxq	%rsi, %rbx, %rbp
	adcxq	%rbx, %r11
	mulxq	%rdi, %rdx, %rbx
	adcxq	%rdx, %rbp
	adcxq	%r8, %rbx
	movq	8(%rsp), %rdx
	mulxq	%rax, %r13, %r12
	adoxq	%r13, %r9
	adcxq	%r12, %r11
	mulxq	%rcx, %r13, %r12
	adoxq	%r13, %r11
	adcxq	%r12, %rbp
	mulxq	%rsi, %r13, %r12
	adoxq	%r13, %rbp
	adcxq	%r12, %rbx
	mulxq	%rdi, %rdx, %r12
	adoxq	%rdx, %rbx
	adcxq	%r8, %r12
	adoxq	%r8, %r12
	movq	16(%rsp), %rdx
	mulxq	%rax, %r14, %r13
	adoxq	%r14, %r11
	adcxq	%r13, %rbp
	mulxq	%rcx, %r14, %r13
	adoxq	%r14, %rbp
	adcxq	%r13, %rbx
	mulxq	%rsi, %r14, %r13
	adoxq	%r14, %rbx
	adcxq	%r13, %r12
	mulxq	%rdi, %rdx, %r13
	adoxq	%rdx, %r12
	adcxq	%r8, %r13
	adoxq	%r8, %r13
	movq	24(%rsp), %rdx
	mulxq	%rax, %r14, %rax
	adoxq	%r14, %rbp
	adcxq	%rax, %rbx
	mulxq	%rcx, %rcx, %rax
	adoxq	%rcx, %rbx
	adcxq	%rax, %r12
	mulxq	%rsi, %rcx, %rax
	adoxq	%rcx, %r12
	adcxq	%rax, %r13
	mulxq	%rdi, %rcx, %rax
	adoxq	%rcx, %r13
	adcxq	%r8, %rax
	adoxq	%r8, %rax
	movq	$38, %rdx
	mulxq	%rbx, %rsi, %rcx
	adoxq	%rsi, %r10
	adcxq	%rcx, %r9
	mulxq	%r12, %rsi, %rcx
	adoxq	%rsi, %r9
	adcxq	%rcx, %r11
	mulxq	%r13, %rsi, %rcx
	adoxq	%rsi, %r11
	adcxq	%rcx, %rbp
	mulxq	%rax, %rcx, %rax
	adoxq	%rcx, %rbp
	adcxq	%r8, %rax
	adoxq	%r8, %rax
	imulq	$38, %rax, %rax
	addq	%rax, %r10
	adcq	%r8, %r9
	adcq	%r8, %r11
	adcq	%r8, %rbp
	sbbq	%r8, %r8
	andq	$38, %r8
	leaq	(%r10,%r8), %rax
	movq	%rax, 64(%rsp)
	movq	%r9, 72(%rsp)
	movq	%r11, 80(%rsp)
	movq	%rbp, 88(%rsp)
	movq	328(%rsp), %rax
	leaq	-1(%rax), %rcx
	cmpq	$0, %rcx
	jnl 	Lcurve25519_mulx$9
	movq	64(%rsp), %rdx
	movq	72(%rsp), %rax
	movq	80(%rsp), %rcx
	movq	88(%rsp), %rsi
	xorl	%edi, %edi
	xorq	%rdi, %rdi
	mulxq	%rdx, %r9, %r8
	mulxq	%rax, %r11, %r10
	mulxq	%rcx, %rbx, %rbp
	adcxq	%rbx, %r10
	mulxq	%rsi, %rdx, %rbx
	adcxq	%rdx, %rbp
	movq	%rax, %rdx
	mulxq	%rcx, %r12, %rax
	adoxq	%r12, %rbp
	adcxq	%rax, %rbx
	mulxq	%rsi, %r12, %rax
	adoxq	%r12, %rbx
	mulxq	%rdx, %r13, %r12
	movq	%rcx, %rdx
	mulxq	%rsi, %r14, %rcx
	adcxq	%r14, %rax
	adoxq	%rdi, %rax
	adcxq	%rdi, %rcx
	adoxq	%rdi, %rcx
	mulxq	%rdx, %r15, %r14
	movq	%rsi, %rdx
	mulxq	%rdx, %rdx, %rsi
	adcxq	%r11, %r11
	adoxq	%r8, %r11
	adcxq	%r10, %r10
	adoxq	%r13, %r10
	adcxq	%rbp, %rbp
	adoxq	%r12, %rbp
	adcxq	%rbx, %rbx
	adoxq	%r15, %rbx
	adcxq	%rax, %rax
	adoxq	%r14, %rax
	adcxq	%rcx, %rcx
	adoxq	%rdx, %rcx
	adcxq	%rdi, %rsi
	adoxq	%rdi, %rsi
	movq	$38, %rdx
	mulxq	%rbx, %rbx, %r8
	adoxq	%rbx, %r9
	adcxq	%r8, %r11
	mulxq	%rax, %r8, %rax
	adoxq	%r8, %r11
	adcxq	%rax, %r10
	mulxq	%rcx, %rcx, %rax
	adoxq	%rcx, %r10
	adcxq	%rax, %rbp
	mulxq	%rsi, %rcx, %rax
	adoxq	%rcx, %rbp
	adcxq	%rdi, %rax
	adoxq	%rdi, %rax
	imulq	$38, %rax, %rax
	addq	%rax, %r9
	adcq	%rdi, %r11
	adcq	%rdi, %r10
	adcq	%rdi, %rbp
	sbbq	%rdi, %rdi
	andq	$38, %rdi
	leaq	(%r9,%rdi), %rdx
	movq	%rdx, 192(%rsp)
	movq	%r11, 200(%rsp)
	movq	%r10, 208(%rsp)
	movq	%rbp, 216(%rsp)
	xorl	%eax, %eax
	xorq	%rax, %rax
	mulxq	%rdx, %rsi, %rcx
	mulxq	%r11, %r8, %rdi
	mulxq	%r10, %rbx, %r9
	adcxq	%rbx, %rdi
	mulxq	%rbp, %rdx, %rbx
	adcxq	%rdx, %r9
	movq	%r11, %rdx
	mulxq	%r10, %r12, %r11
	adoxq	%r12, %r9
	adcxq	%r11, %rbx
	mulxq	%rbp, %r12, %r11
	adoxq	%r12, %rbx
	mulxq	%rdx, %r13, %r12
	movq	%r10, %rdx
	mulxq	%rbp, %r14, %r10
	adcxq	%r14, %r11
	adoxq	%rax, %r11
	adcxq	%rax, %r10
	adoxq	%rax, %r10
	mulxq	%rdx, %r15, %r14
	movq	%rbp, %rdx
	mulxq	%rdx, %rdx, %rbp
	adcxq	%r8, %r8
	adoxq	%rcx, %r8
	adcxq	%rdi, %rdi
	adoxq	%r13, %rdi
	adcxq	%r9, %r9
	adoxq	%r12, %r9
	adcxq	%rbx, %rbx
	adoxq	%r15, %rbx
	adcxq	%r11, %r11
	adoxq	%r14, %r11
	adcxq	%r10, %r10
	adoxq	%rdx, %r10
	adcxq	%rax, %rbp
	adoxq	%rax, %rbp
	movq	$38, %rdx
	mulxq	%rbx, %rbx, %rcx
	adoxq	%rbx, %rsi
	adcxq	%rcx, %r8
	mulxq	%r11, %r11, %rcx
	adoxq	%r11, %r8
	adcxq	%rcx, %rdi
	mulxq	%r10, %r10, %rcx
	adoxq	%r10, %rdi
	adcxq	%rcx, %r9
	mulxq	%rbp, %rdx, %rcx
	adoxq	%rdx, %r9
	adcxq	%rax, %rcx
	adoxq	%rax, %rcx
	imulq	$38, %rcx, %rcx
	addq	%rcx, %rsi
	adcq	%rax, %r8
	adcq	%rax, %rdi
	adcq	%rax, %r9
	sbbq	%rax, %rax
	andq	$38, %rax
	leaq	(%rsi,%rax), %rdx
	xorl	%eax, %eax
	xorq	%rax, %rax
	mulxq	%rdx, %rsi, %rcx
	mulxq	%r8, %r11, %r10
	mulxq	%rdi, %rbx, %rbp
	adcxq	%rbx, %r10
	mulxq	%r9, %rdx, %rbx
	adcxq	%rdx, %rbp
	movq	%r8, %rdx
	mulxq	%rdi, %r12, %r8
	adoxq	%r12, %rbp
	adcxq	%r8, %rbx
	mulxq	%r9, %r12, %r8
	adoxq	%r12, %rbx
	mulxq	%rdx, %r13, %r12
	movq	%rdi, %rdx
	mulxq	%r9, %r14, %rdi
	adcxq	%r14, %r8
	adoxq	%rax, %r8
	adcxq	%rax, %rdi
	adoxq	%rax, %rdi
	mulxq	%rdx, %r15, %r14
	movq	%r9, %rdx
	mulxq	%rdx, %rdx, %r9
	adcxq	%r11, %r11
	adoxq	%rcx, %r11
	adcxq	%r10, %r10
	adoxq	%r13, %r10
	adcxq	%rbp, %rbp
	adoxq	%r12, %rbp
	adcxq	%rbx, %rbx
	adoxq	%r15, %rbx
	adcxq	%r8, %r8
	adoxq	%r14, %r8
	adcxq	%rdi, %rdi
	adoxq	%rdx, %rdi
	adcxq	%rax, %r9
	adoxq	%rax, %r9
	movq	$38, %rdx
	mulxq	%rbx, %rbx, %rcx
	adoxq	%rbx, %rsi
	adcxq	%rcx, %r11
	mulxq	%r8, %r8, %rcx
	adoxq	%r8, %r11
	adcxq	%rcx, %r10
	mulxq	%rdi, %rdi, %rcx
	adoxq	%rdi, %r10
	adcxq	%rcx, %rbp
	mulxq	%r9, %rdx, %rcx
	adoxq	%rdx, %rbp
	adcxq	%rax, %rcx
	adoxq	%rax, %rcx
	imulq	$38, %rcx, %rcx
	addq	%rcx, %rsi
	adcq	%rax, %r11
	adcq	%rax, %r10
	adcq	%rax, %rbp
	sbbq	%rax, %rax
	andq	$38, %rax
	leaq	(%rsi,%rax), %rax
	xorl	%ecx, %ecx
	xorq	%rcx, %rcx
	movq	64(%rsp), %rdx
	mulxq	%rax, %rdi, %rsi
	mulxq	%r11, %r9, %r8
	adcxq	%r9, %rsi
	mulxq	%r10, %rbx, %r9
	adcxq	%rbx, %r8
	mulxq	%rbp, %rdx, %rbx
	adcxq	%rdx, %r9
	adcxq	%rcx, %rbx
	movq	72(%rsp), %rdx
	mulxq	%rax, %r13, %r12
	adoxq	%r13, %rsi
	adcxq	%r12, %r8
	mulxq	%r11, %r13, %r12
	adoxq	%r13, %r8
	adcxq	%r12, %r9
	mulxq	%r10, %r13, %r12
	adoxq	%r13, %r9
	adcxq	%r12, %rbx
	mulxq	%rbp, %rdx, %r12
	adoxq	%rdx, %rbx
	adcxq	%rcx, %r12
	adoxq	%rcx, %r12
	movq	80(%rsp), %rdx
	mulxq	%rax, %r14, %r13
	adoxq	%r14, %r8
	adcxq	%r13, %r9
	mulxq	%r11, %r14, %r13
	adoxq	%r14, %r9
	adcxq	%r13, %rbx
	mulxq	%r10, %r14, %r13
	adoxq	%r14, %rbx
	adcxq	%r13, %r12
	mulxq	%rbp, %rdx, %r13
	adoxq	%rdx, %r12
	adcxq	%rcx, %r13
	adoxq	%rcx, %r13
	movq	88(%rsp), %rdx
	mulxq	%rax, %r14, %rax
	adoxq	%r14, %r9
	adcxq	%rax, %rbx
	mulxq	%r11, %r11, %rax
	adoxq	%r11, %rbx
	adcxq	%rax, %r12
	mulxq	%r10, %r10, %rax
	adoxq	%r10, %r12
	adcxq	%rax, %r13
	mulxq	%rbp, %rdx, %rax
	adoxq	%rdx, %r13
	adcxq	%rcx, %rax
	adoxq	%rcx, %rax
	movq	$38, %rdx
	mulxq	%rbx, %r11, %r10
	adoxq	%r11, %rdi
	adcxq	%r10, %rsi
	mulxq	%r12, %r11, %r10
	adoxq	%r11, %rsi
	adcxq	%r10, %r8
	mulxq	%r13, %r11, %r10
	adoxq	%r11, %r8
	adcxq	%r10, %r9
	mulxq	%rax, %rdx, %rax
	adoxq	%rdx, %r9
	adcxq	%rcx, %rax
	adoxq	%rcx, %rax
	imulq	$38, %rax, %rax
	addq	%rax, %rdi
	adcq	%rcx, %rsi
	adcq	%rcx, %r8
	adcq	%rcx, %r9
	sbbq	%rcx, %rcx
	andq	$38, %rcx
	leaq	(%rdi,%rcx), %rax
	movq	%rax, 160(%rsp)
	movq	%rsi, 168(%rsp)
	movq	%r8, 176(%rsp)
	movq	%r9, 184(%rsp)
	xorl	%ecx, %ecx
	xorq	%rcx, %rcx
	movq	192(%rsp), %rdx
	mulxq	%rax, %r10, %rdi
	mulxq	%rsi, %rbp, %r11
	adcxq	%rbp, %rdi
	mulxq	%r8, %rbx, %rbp
	adcxq	%rbx, %r11
	mulxq	%r9, %rdx, %rbx
	adcxq	%rdx, %rbp
	adcxq	%rcx, %rbx
	movq	200(%rsp), %rdx
	mulxq	%rax, %r13, %r12
	adoxq	%r13, %rdi
	adcxq	%r12, %r11
	mulxq	%rsi, %r13, %r12
	adoxq	%r13, %r11
	adcxq	%r12, %rbp
	mulxq	%r8, %r13, %r12
	adoxq	%r13, %rbp
	adcxq	%r12, %rbx
	mulxq	%r9, %rdx, %r12
	adoxq	%rdx, %rbx
	adcxq	%rcx, %r12
	adoxq	%rcx, %r12
	movq	208(%rsp), %rdx
	mulxq	%rax, %r14, %r13
	adoxq	%r14, %r11
	adcxq	%r13, %rbp
	mulxq	%rsi, %r14, %r13
	adoxq	%r14, %rbp
	adcxq	%r13, %rbx
	mulxq	%r8, %r14, %r13
	adoxq	%r14, %rbx
	adcxq	%r13, %r12
	mulxq	%r9, %rdx, %r13
	adoxq	%rdx, %r12
	adcxq	%rcx, %r13
	adoxq	%rcx, %r13
	movq	216(%rsp), %rdx
	mulxq	%rax, %r14, %rax
	adoxq	%r14, %rbp
	adcxq	%rax, %rbx
	mulxq	%rsi, %rsi, %rax
	adoxq	%rsi, %rbx
	adcxq	%rax, %r12
	mulxq	%r8, %rsi, %rax
	adoxq	%rsi, %r12
	adcxq	%rax, %r13
	mulxq	%r9, %rdx, %rax
	adoxq	%rdx, %r13
	adcxq	%rcx, %rax
	adoxq	%rcx, %rax
	movq	$38, %rdx
	mulxq	%rbx, %r8, %rsi
	adoxq	%r8, %r10
	adcxq	%rsi, %rdi
	mulxq	%r12, %r8, %rsi
	adoxq	%r8, %rdi
	adcxq	%rsi, %r11
	mulxq	%r13, %r8, %rsi
	adoxq	%r8, %r11
	adcxq	%rsi, %rbp
	mulxq	%rax, %rdx, %rax
	adoxq	%rdx, %rbp
	adcxq	%rcx, %rax
	adoxq	%rcx, %rax
	imulq	$38, %rax, %rax
	addq	%rax, %r10
	adcq	%rcx, %rdi
	adcq	%rcx, %r11
	adcq	%rcx, %rbp
	sbbq	%rcx, %rcx
	andq	$38, %rcx
	leaq	(%r10,%rcx), %rdx
	movq	%rdx, 192(%rsp)
	movq	%rdi, 200(%rsp)
	movq	%r11, 208(%rsp)
	movq	%rbp, 216(%rsp)
	xorl	%eax, %eax
	xorq	%rax, %rax
	mulxq	%rdx, %rsi, %rcx
	mulxq	%rdi, %r9, %r8
	mulxq	%r11, %rbx, %r10
	adcxq	%rbx, %r8
	mulxq	%rbp, %rdx, %rbx
	adcxq	%rdx, %r10
	movq	%rdi, %rdx
	mulxq	%r11, %r12, %rdi
	adoxq	%r12, %r10
	adcxq	%rdi, %rbx
	mulxq	%rbp, %r12, %rdi
	adoxq	%r12, %rbx
	mulxq	%rdx, %r13, %r12
	movq	%r11, %rdx
	mulxq	%rbp, %r14, %r11
	adcxq	%r14, %rdi
	adoxq	%rax, %rdi
	adcxq	%rax, %r11
	adoxq	%rax, %r11
	mulxq	%rdx, %r15, %r14
	movq	%rbp, %rdx
	mulxq	%rdx, %rdx, %rbp
	adcxq	%r9, %r9
	adoxq	%rcx, %r9
	adcxq	%r8, %r8
	adoxq	%r13, %r8
	adcxq	%r10, %r10
	adoxq	%r12, %r10
	adcxq	%rbx, %rbx
	adoxq	%r15, %rbx
	adcxq	%rdi, %rdi
	adoxq	%r14, %rdi
	adcxq	%r11, %r11
	adoxq	%rdx, %r11
	adcxq	%rax, %rbp
	adoxq	%rax, %rbp
	movq	$38, %rdx
	mulxq	%rbx, %rbx, %rcx
	adoxq	%rbx, %rsi
	adcxq	%rcx, %r9
	mulxq	%rdi, %rdi, %rcx
	adoxq	%rdi, %r9
	adcxq	%rcx, %r8
	mulxq	%r11, %rdi, %rcx
	adoxq	%rdi, %r8
	adcxq	%rcx, %r10
	mulxq	%rbp, %rdx, %rcx
	adoxq	%rdx, %r10
	adcxq	%rax, %rcx
	adoxq	%rax, %rcx
	imulq	$38, %rcx, %rcx
	addq	%rcx, %rsi
	adcq	%rax, %r9
	adcq	%rax, %r8
	adcq	%rax, %r10
	sbbq	%rax, %rax
	andq	$38, %rax
	leaq	(%rsi,%rax), %rax
	xorl	%ecx, %ecx
	xorq	%rcx, %rcx
	movq	160(%rsp), %rdx
	mulxq	%rax, %rdi, %rsi
	mulxq	%r9, %rbp, %r11
	adcxq	%rbp, %rsi
	mulxq	%r8, %rbx, %rbp
	adcxq	%rbx, %r11
	mulxq	%r10, %rdx, %rbx
	adcxq	%rdx, %rbp
	adcxq	%rcx, %rbx
	movq	168(%rsp), %rdx
	mulxq	%rax, %r13, %r12
	adoxq	%r13, %rsi
	adcxq	%r12, %r11
	mulxq	%r9, %r13, %r12
	adoxq	%r13, %r11
	adcxq	%r12, %rbp
	mulxq	%r8, %r13, %r12
	adoxq	%r13, %rbp
	adcxq	%r12, %rbx
	mulxq	%r10, %rdx, %r12
	adoxq	%rdx, %rbx
	adcxq	%rcx, %r12
	adoxq	%rcx, %r12
	movq	176(%rsp), %rdx
	mulxq	%rax, %r14, %r13
	adoxq	%r14, %r11
	adcxq	%r13, %rbp
	mulxq	%r9, %r14, %r13
	adoxq	%r14, %rbp
	adcxq	%r13, %rbx
	mulxq	%r8, %r14, %r13
	adoxq	%r14, %rbx
	adcxq	%r13, %r12
	mulxq	%r10, %rdx, %r13
	adoxq	%rdx, %r12
	adcxq	%rcx, %r13
	adoxq	%rcx, %r13
	movq	184(%rsp), %rdx
	mulxq	%rax, %r14, %rax
	adoxq	%r14, %rbp
	adcxq	%rax, %rbx
	mulxq	%r9, %r9, %rax
	adoxq	%r9, %rbx
	adcxq	%rax, %r12
	mulxq	%r8, %r8, %rax
	adoxq	%r8, %r12
	adcxq	%rax, %r13
	mulxq	%r10, %rdx, %rax
	adoxq	%rdx, %r13
	adcxq	%rcx, %rax
	adoxq	%rcx, %rax
	movq	$38, %rdx
	mulxq	%rbx, %r9, %r8
	adoxq	%r9, %rdi
	adcxq	%r8, %rsi
	mulxq	%r12, %r9, %r8
	adoxq	%r9, %rsi
	adcxq	%r8, %r11
	mulxq	%r13, %r9, %r8
	adoxq	%r9, %r11
	adcxq	%r8, %rbp
	mulxq	%rax, %rdx, %rax
	adoxq	%rdx, %rbp
	adcxq	%rcx, %rax
	adoxq	%rcx, %rax
	imulq	$38, %rax, %rax
	addq	%rax, %rdi
	adcq	%rcx, %rsi
	adcq	%rcx, %r11
	adcq	%rcx, %rbp
	sbbq	%rcx, %rcx
	andq	$38, %rcx
	leaq	(%rdi,%rcx), %rdx
	movq	%rdx, 160(%rsp)
	movq	%rsi, 168(%rsp)
	movq	%r11, 176(%rsp)
	movq	%rbp, 184(%rsp)
	xorl	%eax, %eax
	xorq	%rax, %rax
	mulxq	%rdx, %rdi, %rcx
	mulxq	%rsi, %r9, %r8
	mulxq	%r11, %rbx, %r10
	adcxq	%rbx, %r8
	mulxq	%rbp, %rdx, %rbx
	adcxq	%rdx, %r10
	movq	%rsi, %rdx
	mulxq	%r11, %r12, %rsi
	adoxq	%r12, %r10
	adcxq	%rsi, %rbx
	mulxq	%rbp, %r12, %rsi
	adoxq	%r12, %rbx
	mulxq	%rdx, %r13, %r12
	movq	%r11, %rdx
	mulxq	%rbp, %r14, %r11
	adcxq	%r14, %rsi
	adoxq	%rax, %rsi
	adcxq	%rax, %r11
	adoxq	%rax, %r11
	mulxq	%rdx, %r15, %r14
	movq	%rbp, %rdx
	mulxq	%rdx, %rdx, %rbp
	adcxq	%r9, %r9
	adoxq	%rcx, %r9
	adcxq	%r8, %r8
	adoxq	%r13, %r8
	adcxq	%r10, %r10
	adoxq	%r12, %r10
	adcxq	%rbx, %rbx
	adoxq	%r15, %rbx
	adcxq	%rsi, %rsi
	adoxq	%r14, %rsi
	adcxq	%r11, %r11
	adoxq	%rdx, %r11
	adcxq	%rax, %rbp
	adoxq	%rax, %rbp
	movq	$38, %rdx
	mulxq	%rbx, %rbx, %rcx
	adoxq	%rbx, %rdi
	adcxq	%rcx, %r9
	mulxq	%rsi, %rsi, %rcx
	adoxq	%rsi, %r9
	adcxq	%rcx, %r8
	mulxq	%r11, %rsi, %rcx
	adoxq	%rsi, %r8
	adcxq	%rcx, %r10
	mulxq	%rbp, %rdx, %rcx
	adoxq	%rdx, %r10
	adcxq	%rax, %rcx
	adoxq	%rax, %rcx
	imulq	$38, %rcx, %rcx
	addq	%rcx, %rdi
	adcq	%rax, %r9
	adcq	%rax, %r8
	adcq	%rax, %r10
	sbbq	%rax, %rax
	andq	$38, %rax
	leaq	(%rdi,%rax), %rax
	movq	$4, 328(%rsp)
Lcurve25519_mulx$8:
	xorl	%ecx, %ecx
	xorq	%rcx, %rcx
	movq	%rax, %rdx
	mulxq	%rdx, %rsi, %rax
	mulxq	%r9, %r11, %rdi
	mulxq	%r8, %rbx, %rbp
	adcxq	%rbx, %rdi
	mulxq	%r10, %rdx, %rbx
	adcxq	%rdx, %rbp
	movq	%r9, %rdx
	mulxq	%r8, %r12, %r9
	adoxq	%r12, %rbp
	adcxq	%r9, %rbx
	mulxq	%r10, %r12, %r9
	adoxq	%r12, %rbx
	mulxq	%rdx, %r13, %r12
	movq	%r8, %rdx
	mulxq	%r10, %r14, %r8
	adcxq	%r14, %r9
	adoxq	%rcx, %r9
	adcxq	%rcx, %r8
	adoxq	%rcx, %r8
	mulxq	%rdx, %r15, %r14
	movq	%r10, %rdx
	mulxq	%rdx, %rdx, %r10
	adcxq	%r11, %r11
	adoxq	%rax, %r11
	adcxq	%rdi, %rdi
	adoxq	%r13, %rdi
	adcxq	%rbp, %rbp
	adoxq	%r12, %rbp
	adcxq	%rbx, %rbx
	adoxq	%r15, %rbx
	adcxq	%r9, %r9
	adoxq	%r14, %r9
	adcxq	%r8, %r8
	adoxq	%rdx, %r8
	adcxq	%rcx, %r10
	adoxq	%rcx, %r10
	movq	$38, %rdx
	mulxq	%rbx, %rbx, %rax
	adoxq	%rbx, %rsi
	adcxq	%rax, %r11
	mulxq	%r9, %r9, %rax
	adoxq	%r9, %r11
	adcxq	%rax, %rdi
	mulxq	%r8, %r8, %rax
	adoxq	%r8, %rdi
	adcxq	%rax, %rbp
	mulxq	%r10, %rdx, %rax
	adoxq	%rdx, %rbp
	adcxq	%rcx, %rax
	adoxq	%rcx, %rax
	imulq	$38, %rax, %rax
	addq	%rax, %rsi
	adcq	%rcx, %r11
	adcq	%rcx, %rdi
	adcq	%rcx, %rbp
	sbbq	%rcx, %rcx
	andq	$38, %rcx
	leaq	(%rsi,%rcx), %rdx
	decq	328(%rsp)
	xorl	%eax, %eax
	xorq	%rax, %rax
	mulxq	%rdx, %rsi, %rcx
	mulxq	%r11, %r9, %r8
	mulxq	%rdi, %rbx, %r10
	adcxq	%rbx, %r8
	mulxq	%rbp, %rdx, %rbx
	adcxq	%rdx, %r10
	movq	%r11, %rdx
	mulxq	%rdi, %r12, %r11
	adoxq	%r12, %r10
	adcxq	%r11, %rbx
	mulxq	%rbp, %r12, %r11
	adoxq	%r12, %rbx
	mulxq	%rdx, %r13, %r12
	movq	%rdi, %rdx
	mulxq	%rbp, %r14, %rdi
	adcxq	%r14, %r11
	adoxq	%rax, %r11
	adcxq	%rax, %rdi
	adoxq	%rax, %rdi
	mulxq	%rdx, %r15, %r14
	movq	%rbp, %rdx
	mulxq	%rdx, %rdx, %rbp
	adcxq	%r9, %r9
	adoxq	%rcx, %r9
	adcxq	%r8, %r8
	adoxq	%r13, %r8
	adcxq	%r10, %r10
	adoxq	%r12, %r10
	adcxq	%rbx, %rbx
	adoxq	%r15, %rbx
	adcxq	%r11, %r11
	adoxq	%r14, %r11
	adcxq	%rdi, %rdi
	adoxq	%rdx, %rdi
	adcxq	%rax, %rbp
	adoxq	%rax, %rbp
	movq	$38, %rdx
	mulxq	%rbx, %rbx, %rcx
	adoxq	%rbx, %rsi
	adcxq	%rcx, %r9
	mulxq	%r11, %r11, %rcx
	adoxq	%r11, %r9
	adcxq	%rcx, %r8
	mulxq	%rdi, %rdi, %rcx
	adoxq	%rdi, %r8
	adcxq	%rcx, %r10
	mulxq	%rbp, %rdx, %rcx
	adoxq	%rdx, %r10
	adcxq	%rax, %rcx
	adoxq	%rax, %rcx
	imulq	$38, %rcx, %rcx
	addq	%rcx, %rsi
	adcq	%rax, %r9
	adcq	%rax, %r8
	adcq	%rax, %r10
	sbbq	%rax, %rax
	andq	$38, %rax
	leaq	(%rsi,%rax), %rax
	decq	328(%rsp)
	jne 	Lcurve25519_mulx$8
	movq	%rax, 224(%rsp)
	movq	%r9, 232(%rsp)
	movq	%r8, 240(%rsp)
	movq	%r10, 248(%rsp)
	xorl	%ecx, %ecx
	xorq	%rcx, %rcx
	movq	160(%rsp), %rdx
	mulxq	%rax, %rdi, %rsi
	mulxq	%r9, %rbp, %r11
	adcxq	%rbp, %rsi
	mulxq	%r8, %rbx, %rbp
	adcxq	%rbx, %r11
	mulxq	%r10, %rdx, %rbx
	adcxq	%rdx, %rbp
	adcxq	%rcx, %rbx
	movq	168(%rsp), %rdx
	mulxq	%rax, %r13, %r12
	adoxq	%r13, %rsi
	adcxq	%r12, %r11
	mulxq	%r9, %r13, %r12
	adoxq	%r13, %r11
	adcxq	%r12, %rbp
	mulxq	%r8, %r13, %r12
	adoxq	%r13, %rbp
	adcxq	%r12, %rbx
	mulxq	%r10, %rdx, %r12
	adoxq	%rdx, %rbx
	adcxq	%rcx, %r12
	adoxq	%rcx, %r12
	movq	176(%rsp), %rdx
	mulxq	%rax, %r14, %r13
	adoxq	%r14, %r11
	adcxq	%r13, %rbp
	mulxq	%r9, %r14, %r13
	adoxq	%r14, %rbp
	adcxq	%r13, %rbx
	mulxq	%r8, %r14, %r13
	adoxq	%r14, %rbx
	adcxq	%r13, %r12
	mulxq	%r10, %rdx, %r13
	adoxq	%rdx, %r12
	adcxq	%rcx, %r13
	adoxq	%rcx, %r13
	movq	184(%rsp), %rdx
	mulxq	%rax, %r14, %rax
	adoxq	%r14, %rbp
	adcxq	%rax, %rbx
	mulxq	%r9, %r9, %rax
	adoxq	%r9, %rbx
	adcxq	%rax, %r12
	mulxq	%r8, %r8, %rax
	adoxq	%r8, %r12
	adcxq	%rax, %r13
	mulxq	%r10, %rdx, %rax
	adoxq	%rdx, %r13
	adcxq	%rcx, %rax
	adoxq	%rcx, %rax
	movq	$38, %rdx
	mulxq	%rbx, %r9, %r8
	adoxq	%r9, %rdi
	adcxq	%r8, %rsi
	mulxq	%r12, %r9, %r8
	adoxq	%r9, %rsi
	adcxq	%r8, %r11
	mulxq	%r13, %r9, %r8
	adoxq	%r9, %r11
	adcxq	%r8, %rbp
	mulxq	%rax, %rdx, %rax
	adoxq	%rdx, %rbp
	adcxq	%rcx, %rax
	adoxq	%rcx, %rax
	imulq	$38, %rax, %rax
	addq	%rax, %rdi
	adcq	%rcx, %rsi
	adcq	%rcx, %r11
	adcq	%rcx, %rbp
	sbbq	%rcx, %rcx
	andq	$38, %rcx
	leaq	(%rdi,%rcx), %rax
	movq	%rax, 160(%rsp)
	movq	%rsi, 168(%rsp)
	movq	%r11, 176(%rsp)
	movq	%rbp, 184(%rsp)
	movq	$10, 328(%rsp)
Lcurve25519_mulx$7:
	xorl	%ecx, %ecx
	xorq	%rcx, %rcx
	movq	%rax, %rdx
	mulxq	%rdx, %rdi, %rax
	mulxq	%rsi, %r9, %r8
	mulxq	%r11, %rbx, %r10
	adcxq	%rbx, %r8
	mulxq	%rbp, %rdx, %rbx
	adcxq	%rdx, %r10
	movq	%rsi, %rdx
	mulxq	%r11, %r12, %rsi
	adoxq	%r12, %r10
	adcxq	%rsi, %rbx
	mulxq	%rbp, %r12, %rsi
	adoxq	%r12, %rbx
	mulxq	%rdx, %r13, %r12
	movq	%r11, %rdx
	mulxq	%rbp, %r14, %r11
	adcxq	%r14, %rsi
	adoxq	%rcx, %rsi
	adcxq	%rcx, %r11
	adoxq	%rcx, %r11
	mulxq	%rdx, %r15, %r14
	movq	%rbp, %rdx
	mulxq	%rdx, %rdx, %rbp
	adcxq	%r9, %r9
	adoxq	%rax, %r9
	adcxq	%r8, %r8
	adoxq	%r13, %r8
	adcxq	%r10, %r10
	adoxq	%r12, %r10
	adcxq	%rbx, %rbx
	adoxq	%r15, %rbx
	adcxq	%rsi, %rsi
	adoxq	%r14, %rsi
	adcxq	%r11, %r11
	adoxq	%rdx, %r11
	adcxq	%rcx, %rbp
	adoxq	%rcx, %rbp
	movq	$38, %rdx
	mulxq	%rbx, %rbx, %rax
	adoxq	%rbx, %rdi
	adcxq	%rax, %r9
	mulxq	%rsi, %rsi, %rax
	adoxq	%rsi, %r9
	adcxq	%rax, %r8
	mulxq	%r11, %rsi, %rax
	adoxq	%rsi, %r8
	adcxq	%rax, %r10
	mulxq	%rbp, %rdx, %rax
	adoxq	%rdx, %r10
	adcxq	%rcx, %rax
	adoxq	%rcx, %rax
	imulq	$38, %rax, %rax
	addq	%rax, %rdi
	adcq	%rcx, %r9
	adcq	%rcx, %r8
	adcq	%rcx, %r10
	sbbq	%rcx, %rcx
	andq	$38, %rcx
	leaq	(%rdi,%rcx), %rdx
	decq	328(%rsp)
	xorl	%eax, %eax
	xorq	%rax, %rax
	mulxq	%rdx, %rdi, %rcx
	mulxq	%r9, %rsi, %r11
	mulxq	%r8, %rbx, %rbp
	adcxq	%rbx, %r11
	mulxq	%r10, %rdx, %rbx
	adcxq	%rdx, %rbp
	movq	%r9, %rdx
	mulxq	%r8, %r12, %r9
	adoxq	%r12, %rbp
	adcxq	%r9, %rbx
	mulxq	%r10, %r12, %r9
	adoxq	%r12, %rbx
	mulxq	%rdx, %r13, %r12
	movq	%r8, %rdx
	mulxq	%r10, %r14, %r8
	adcxq	%r14, %r9
	adoxq	%rax, %r9
	adcxq	%rax, %r8
	adoxq	%rax, %r8
	mulxq	%rdx, %r15, %r14
	movq	%r10, %rdx
	mulxq	%rdx, %rdx, %r10
	adcxq	%rsi, %rsi
	adoxq	%rcx, %rsi
	adcxq	%r11, %r11
	adoxq	%r13, %r11
	adcxq	%rbp, %rbp
	adoxq	%r12, %rbp
	adcxq	%rbx, %rbx
	adoxq	%r15, %rbx
	adcxq	%r9, %r9
	adoxq	%r14, %r9
	adcxq	%r8, %r8
	adoxq	%rdx, %r8
	adcxq	%rax, %r10
	adoxq	%rax, %r10
	movq	$38, %rdx
	mulxq	%rbx, %rbx, %rcx
	adoxq	%rbx, %rdi
	adcxq	%rcx, %rsi
	mulxq	%r9, %r9, %rcx
	adoxq	%r9, %rsi
	adcxq	%rcx, %r11
	mulxq	%r8, %r8, %rcx
	adoxq	%r8, %r11
	adcxq	%rcx, %rbp
	mulxq	%r10, %rdx, %rcx
	adoxq	%rdx, %rbp
	adcxq	%rax, %rcx
	adoxq	%rax, %rcx
	imulq	$38, %rcx, %rcx
	addq	%rcx, %rdi
	adcq	%rax, %rsi
	adcq	%rax, %r11
	adcq	%rax, %rbp
	sbbq	%rax, %rax
	andq	$38, %rax
	leaq	(%rdi,%rax), %rax
	decq	328(%rsp)
	jne 	Lcurve25519_mulx$7
	xorl	%ecx, %ecx
	xorq	%rcx, %rcx
	movq	160(%rsp), %rdx
	mulxq	%rax, %r8, %rdi
	mulxq	%rsi, %r10, %r9
	adcxq	%r10, %rdi
	mulxq	%r11, %rbx, %r10
	adcxq	%rbx, %r9
	mulxq	%rbp, %rdx, %rbx
	adcxq	%rdx, %r10
	adcxq	%rcx, %rbx
	movq	168(%rsp), %rdx
	mulxq	%rax, %r13, %r12
	adoxq	%r13, %rdi
	adcxq	%r12, %r9
	mulxq	%rsi, %r13, %r12
	adoxq	%r13, %r9
	adcxq	%r12, %r10
	mulxq	%r11, %r13, %r12
	adoxq	%r13, %r10
	adcxq	%r12, %rbx
	mulxq	%rbp, %rdx, %r12
	adoxq	%rdx, %rbx
	adcxq	%rcx, %r12
	adoxq	%rcx, %r12
	movq	176(%rsp), %rdx
	mulxq	%rax, %r14, %r13
	adoxq	%r14, %r9
	adcxq	%r13, %r10
	mulxq	%rsi, %r14, %r13
	adoxq	%r14, %r10
	adcxq	%r13, %rbx
	mulxq	%r11, %r14, %r13
	adoxq	%r14, %rbx
	adcxq	%r13, %r12
	mulxq	%rbp, %rdx, %r13
	adoxq	%rdx, %r12
	adcxq	%rcx, %r13
	adoxq	%rcx, %r13
	movq	184(%rsp), %rdx
	mulxq	%rax, %r14, %rax
	adoxq	%r14, %r10
	adcxq	%rax, %rbx
	mulxq	%rsi, %rsi, %rax
	adoxq	%rsi, %rbx
	adcxq	%rax, %r12
	mulxq	%r11, %rsi, %rax
	adoxq	%rsi, %r12
	adcxq	%rax, %r13
	mulxq	%rbp, %rdx, %rax
	adoxq	%rdx, %r13
	adcxq	%rcx, %rax
	adoxq	%rcx, %rax
	movq	$38, %rdx
	mulxq	%rbx, %r11, %rsi
	adoxq	%r11, %r8
	adcxq	%rsi, %rdi
	mulxq	%r12, %r11, %rsi
	adoxq	%r11, %rdi
	adcxq	%rsi, %r9
	mulxq	%r13, %r11, %rsi
	adoxq	%r11, %r9
	adcxq	%rsi, %r10
	mulxq	%rax, %rdx, %rax
	adoxq	%rdx, %r10
	adcxq	%rcx, %rax
	adoxq	%rcx, %rax
	imulq	$38, %rax, %rax
	addq	%rax, %r8
	adcq	%rcx, %rdi
	adcq	%rcx, %r9
	adcq	%rcx, %r10
	sbbq	%rcx, %rcx
	andq	$38, %rcx
	leaq	(%r8,%rcx), %rax
	movq	%rax, 224(%rsp)
	movq	%rdi, 232(%rsp)
	movq	%r9, 240(%rsp)
	movq	%r10, 248(%rsp)
	movq	$20, 328(%rsp)
Lcurve25519_mulx$6:
	xorl	%ecx, %ecx
	xorq	%rcx, %rcx
	movq	%rax, %rdx
	mulxq	%rdx, %rsi, %rax
	mulxq	%rdi, %r11, %r8
	mulxq	%r9, %rbx, %rbp
	adcxq	%rbx, %r8
	mulxq	%r10, %rdx, %rbx
	adcxq	%rdx, %rbp
	movq	%rdi, %rdx
	mulxq	%r9, %r12, %rdi
	adoxq	%r12, %rbp
	adcxq	%rdi, %rbx
	mulxq	%r10, %r12, %rdi
	adoxq	%r12, %rbx
	mulxq	%rdx, %r13, %r12
	movq	%r9, %rdx
	mulxq	%r10, %r14, %r9
	adcxq	%r14, %rdi
	adoxq	%rcx, %rdi
	adcxq	%rcx, %r9
	adoxq	%rcx, %r9
	mulxq	%rdx, %r15, %r14
	movq	%r10, %rdx
	mulxq	%rdx, %rdx, %r10
	adcxq	%r11, %r11
	adoxq	%rax, %r11
	adcxq	%r8, %r8
	adoxq	%r13, %r8
	adcxq	%rbp, %rbp
	adoxq	%r12, %rbp
	adcxq	%rbx, %rbx
	adoxq	%r15, %rbx
	adcxq	%rdi, %rdi
	adoxq	%r14, %rdi
	adcxq	%r9, %r9
	adoxq	%rdx, %r9
	adcxq	%rcx, %r10
	adoxq	%rcx, %r10
	movq	$38, %rdx
	mulxq	%rbx, %rbx, %rax
	adoxq	%rbx, %rsi
	adcxq	%rax, %r11
	mulxq	%rdi, %rdi, %rax
	adoxq	%rdi, %r11
	adcxq	%rax, %r8
	mulxq	%r9, %rdi, %rax
	adoxq	%rdi, %r8
	adcxq	%rax, %rbp
	mulxq	%r10, %rdx, %rax
	adoxq	%rdx, %rbp
	adcxq	%rcx, %rax
	adoxq	%rcx, %rax
	imulq	$38, %rax, %rax
	addq	%rax, %rsi
	adcq	%rcx, %r11
	adcq	%rcx, %r8
	adcq	%rcx, %rbp
	sbbq	%rcx, %rcx
	andq	$38, %rcx
	leaq	(%rsi,%rcx), %rdx
	decq	328(%rsp)
	xorl	%eax, %eax
	xorq	%rax, %rax
	mulxq	%rdx, %rsi, %rcx
	mulxq	%r11, %rdi, %r9
	mulxq	%r8, %rbx, %r10
	adcxq	%rbx, %r9
	mulxq	%rbp, %rdx, %rbx
	adcxq	%rdx, %r10
	movq	%r11, %rdx
	mulxq	%r8, %r12, %r11
	adoxq	%r12, %r10
	adcxq	%r11, %rbx
	mulxq	%rbp, %r12, %r11
	adoxq	%r12, %rbx
	mulxq	%rdx, %r13, %r12
	movq	%r8, %rdx
	mulxq	%rbp, %r14, %r8
	adcxq	%r14, %r11
	adoxq	%rax, %r11
	adcxq	%rax, %r8
	adoxq	%rax, %r8
	mulxq	%rdx, %r15, %r14
	movq	%rbp, %rdx
	mulxq	%rdx, %rdx, %rbp
	adcxq	%rdi, %rdi
	adoxq	%rcx, %rdi
	adcxq	%r9, %r9
	adoxq	%r13, %r9
	adcxq	%r10, %r10
	adoxq	%r12, %r10
	adcxq	%rbx, %rbx
	adoxq	%r15, %rbx
	adcxq	%r11, %r11
	adoxq	%r14, %r11
	adcxq	%r8, %r8
	adoxq	%rdx, %r8
	adcxq	%rax, %rbp
	adoxq	%rax, %rbp
	movq	$38, %rdx
	mulxq	%rbx, %rbx, %rcx
	adoxq	%rbx, %rsi
	adcxq	%rcx, %rdi
	mulxq	%r11, %r11, %rcx
	adoxq	%r11, %rdi
	adcxq	%rcx, %r9
	mulxq	%r8, %r8, %rcx
	adoxq	%r8, %r9
	adcxq	%rcx, %r10
	mulxq	%rbp, %rdx, %rcx
	adoxq	%rdx, %r10
	adcxq	%rax, %rcx
	adoxq	%rax, %rcx
	imulq	$38, %rcx, %rcx
	addq	%rcx, %rsi
	adcq	%rax, %rdi
	adcq	%rax, %r9
	adcq	%rax, %r10
	sbbq	%rax, %rax
	andq	$38, %rax
	leaq	(%rsi,%rax), %rax
	decq	328(%rsp)
	jne 	Lcurve25519_mulx$6
	xorl	%ecx, %ecx
	xorq	%rcx, %rcx
	movq	224(%rsp), %rdx
	mulxq	%rax, %r8, %rsi
	mulxq	%rdi, %rbp, %r11
	adcxq	%rbp, %rsi
	mulxq	%r9, %rbx, %rbp
	adcxq	%rbx, %r11
	mulxq	%r10, %rdx, %rbx
	adcxq	%rdx, %rbp
	adcxq	%rcx, %rbx
	movq	232(%rsp), %rdx
	mulxq	%rax, %r13, %r12
	adoxq	%r13, %rsi
	adcxq	%r12, %r11
	mulxq	%rdi, %r13, %r12
	adoxq	%r13, %r11
	adcxq	%r12, %rbp
	mulxq	%r9, %r13, %r12
	adoxq	%r13, %rbp
	adcxq	%r12, %rbx
	mulxq	%r10, %rdx, %r12
	adoxq	%rdx, %rbx
	adcxq	%rcx, %r12
	adoxq	%rcx, %r12
	movq	240(%rsp), %rdx
	mulxq	%rax, %r14, %r13
	adoxq	%r14, %r11
	adcxq	%r13, %rbp
	mulxq	%rdi, %r14, %r13
	adoxq	%r14, %rbp
	adcxq	%r13, %rbx
	mulxq	%r9, %r14, %r13
	adoxq	%r14, %rbx
	adcxq	%r13, %r12
	mulxq	%r10, %rdx, %r13
	adoxq	%rdx, %r12
	adcxq	%rcx, %r13
	adoxq	%rcx, %r13
	movq	248(%rsp), %rdx
	mulxq	%rax, %r14, %rax
	adoxq	%r14, %rbp
	adcxq	%rax, %rbx
	mulxq	%rdi, %rdi, %rax
	adoxq	%rdi, %rbx
	adcxq	%rax, %r12
	mulxq	%r9, %rdi, %rax
	adoxq	%rdi, %r12
	adcxq	%rax, %r13
	mulxq	%r10, %rdx, %rax
	adoxq	%rdx, %r13
	adcxq	%rcx, %rax
	adoxq	%rcx, %rax
	movq	$38, %rdx
	mulxq	%rbx, %r9, %rdi
	adoxq	%r9, %r8
	adcxq	%rdi, %rsi
	mulxq	%r12, %r9, %rdi
	adoxq	%r9, %rsi
	adcxq	%rdi, %r11
	mulxq	%r13, %r9, %rdi
	adoxq	%r9, %r11
	adcxq	%rdi, %rbp
	mulxq	%rax, %rdx, %rax
	adoxq	%rdx, %rbp
	adcxq	%rcx, %rax
	adoxq	%rcx, %rax
	imulq	$38, %rax, %rax
	addq	%rax, %r8
	adcq	%rcx, %rsi
	adcq	%rcx, %r11
	adcq	%rcx, %rbp
	sbbq	%rcx, %rcx
	andq	$38, %rcx
	leaq	(%r8,%rcx), %rax
	movq	$10, 328(%rsp)
Lcurve25519_mulx$5:
	xorl	%ecx, %ecx
	xorq	%rcx, %rcx
	movq	%rax, %rdx
	mulxq	%rdx, %rdi, %rax
	mulxq	%rsi, %r9, %r8
	mulxq	%r11, %rbx, %r10
	adcxq	%rbx, %r8
	mulxq	%rbp, %rdx, %rbx
	adcxq	%rdx, %r10
	movq	%rsi, %rdx
	mulxq	%r11, %r12, %rsi
	adoxq	%r12, %r10
	adcxq	%rsi, %rbx
	mulxq	%rbp, %r12, %rsi
	adoxq	%r12, %rbx
	mulxq	%rdx, %r13, %r12
	movq	%r11, %rdx
	mulxq	%rbp, %r14, %r11
	adcxq	%r14, %rsi
	adoxq	%rcx, %rsi
	adcxq	%rcx, %r11
	adoxq	%rcx, %r11
	mulxq	%rdx, %r15, %r14
	movq	%rbp, %rdx
	mulxq	%rdx, %rdx, %rbp
	adcxq	%r9, %r9
	adoxq	%rax, %r9
	adcxq	%r8, %r8
	adoxq	%r13, %r8
	adcxq	%r10, %r10
	adoxq	%r12, %r10
	adcxq	%rbx, %rbx
	adoxq	%r15, %rbx
	adcxq	%rsi, %rsi
	adoxq	%r14, %rsi
	adcxq	%r11, %r11
	adoxq	%rdx, %r11
	adcxq	%rcx, %rbp
	adoxq	%rcx, %rbp
	movq	$38, %rdx
	mulxq	%rbx, %rbx, %rax
	adoxq	%rbx, %rdi
	adcxq	%rax, %r9
	mulxq	%rsi, %rsi, %rax
	adoxq	%rsi, %r9
	adcxq	%rax, %r8
	mulxq	%r11, %rsi, %rax
	adoxq	%rsi, %r8
	adcxq	%rax, %r10
	mulxq	%rbp, %rdx, %rax
	adoxq	%rdx, %r10
	adcxq	%rcx, %rax
	adoxq	%rcx, %rax
	imulq	$38, %rax, %rax
	addq	%rax, %rdi
	adcq	%rcx, %r9
	adcq	%rcx, %r8
	adcq	%rcx, %r10
	sbbq	%rcx, %rcx
	andq	$38, %rcx
	leaq	(%rdi,%rcx), %rdx
	decq	328(%rsp)
	xorl	%eax, %eax
	xorq	%rax, %rax
	mulxq	%rdx, %rdi, %rcx
	mulxq	%r9, %rsi, %r11
	mulxq	%r8, %rbx, %rbp
	adcxq	%rbx, %r11
	mulxq	%r10, %rdx, %rbx
	adcxq	%rdx, %rbp
	movq	%r9, %rdx
	mulxq	%r8, %r12, %r9
	adoxq	%r12, %rbp
	adcxq	%r9, %rbx
	mulxq	%r10, %r12, %r9
	adoxq	%r12, %rbx
	mulxq	%rdx, %r13, %r12
	movq	%r8, %rdx
	mulxq	%r10, %r14, %r8
	adcxq	%r14, %r9
	adoxq	%rax, %r9
	adcxq	%rax, %r8
	adoxq	%rax, %r8
	mulxq	%rdx, %r15, %r14
	movq	%r10, %rdx
	mulxq	%rdx, %rdx, %r10
	adcxq	%rsi, %rsi
	adoxq	%rcx, %rsi
	adcxq	%r11, %r11
	adoxq	%r13, %r11
	adcxq	%rbp, %rbp
	adoxq	%r12, %rbp
	adcxq	%rbx, %rbx
	adoxq	%r15, %rbx
	adcxq	%r9, %r9
	adoxq	%r14, %r9
	adcxq	%r8, %r8
	adoxq	%rdx, %r8
	adcxq	%rax, %r10
	adoxq	%rax, %r10
	movq	$38, %rdx
	mulxq	%rbx, %rbx, %rcx
	adoxq	%rbx, %rdi
	adcxq	%rcx, %rsi
	mulxq	%r9, %r9, %rcx
	adoxq	%r9, %rsi
	adcxq	%rcx, %r11
	mulxq	%r8, %r8, %rcx
	adoxq	%r8, %r11
	adcxq	%rcx, %rbp
	mulxq	%r10, %rdx, %rcx
	adoxq	%rdx, %rbp
	adcxq	%rax, %rcx
	adoxq	%rax, %rcx
	imulq	$38, %rcx, %rcx
	addq	%rcx, %rdi
	adcq	%rax, %rsi
	adcq	%rax, %r11
	adcq	%rax, %rbp
	sbbq	%rax, %rax
	andq	$38, %rax
	leaq	(%rdi,%rax), %rax
	decq	328(%rsp)
	jne 	Lcurve25519_mulx$5
	xorl	%ecx, %ecx
	xorq	%rcx, %rcx
	movq	160(%rsp), %rdx
	mulxq	%rax, %r8, %rdi
	mulxq	%rsi, %r10, %r9
	adcxq	%r10, %rdi
	mulxq	%r11, %rbx, %r10
	adcxq	%rbx, %r9
	mulxq	%rbp, %rdx, %rbx
	adcxq	%rdx, %r10
	adcxq	%rcx, %rbx
	movq	168(%rsp), %rdx
	mulxq	%rax, %r13, %r12
	adoxq	%r13, %rdi
	adcxq	%r12, %r9
	mulxq	%rsi, %r13, %r12
	adoxq	%r13, %r9
	adcxq	%r12, %r10
	mulxq	%r11, %r13, %r12
	adoxq	%r13, %r10
	adcxq	%r12, %rbx
	mulxq	%rbp, %rdx, %r12
	adoxq	%rdx, %rbx
	adcxq	%rcx, %r12
	adoxq	%rcx, %r12
	movq	176(%rsp), %rdx
	mulxq	%rax, %r14, %r13
	adoxq	%r14, %r9
	adcxq	%r13, %r10
	mulxq	%rsi, %r14, %r13
	adoxq	%r14, %r10
	adcxq	%r13, %rbx
	mulxq	%r11, %r14, %r13
	adoxq	%r14, %rbx
	adcxq	%r13, %r12
	mulxq	%rbp, %rdx, %r13
	adoxq	%rdx, %r12
	adcxq	%rcx, %r13
	adoxq	%rcx, %r13
	movq	184(%rsp), %rdx
	mulxq	%rax, %r14, %rax
	adoxq	%r14, %r10
	adcxq	%rax, %rbx
	mulxq	%rsi, %rsi, %rax
	adoxq	%rsi, %rbx
	adcxq	%rax, %r12
	mulxq	%r11, %rsi, %rax
	adoxq	%rsi, %r12
	adcxq	%rax, %r13
	mulxq	%rbp, %rdx, %rax
	adoxq	%rdx, %r13
	adcxq	%rcx, %rax
	adoxq	%rcx, %rax
	movq	$38, %rdx
	mulxq	%rbx, %r11, %rsi
	adoxq	%r11, %r8
	adcxq	%rsi, %rdi
	mulxq	%r12, %r11, %rsi
	adoxq	%r11, %rdi
	adcxq	%rsi, %r9
	mulxq	%r13, %r11, %rsi
	adoxq	%r11, %r9
	adcxq	%rsi, %r10
	mulxq	%rax, %rdx, %rax
	adoxq	%rdx, %r10
	adcxq	%rcx, %rax
	adoxq	%rcx, %rax
	imulq	$38, %rax, %rax
	addq	%rax, %r8
	adcq	%rcx, %rdi
	adcq	%rcx, %r9
	adcq	%rcx, %r10
	sbbq	%rcx, %rcx
	andq	$38, %rcx
	leaq	(%r8,%rcx), %rax
	movq	%rax, 160(%rsp)
	movq	%rdi, 168(%rsp)
	movq	%r9, 176(%rsp)
	movq	%r10, 184(%rsp)
	movq	$50, 328(%rsp)
Lcurve25519_mulx$4:
	xorl	%ecx, %ecx
	xorq	%rcx, %rcx
	movq	%rax, %rdx
	mulxq	%rdx, %rsi, %rax
	mulxq	%rdi, %r11, %r8
	mulxq	%r9, %rbx, %rbp
	adcxq	%rbx, %r8
	mulxq	%r10, %rdx, %rbx
	adcxq	%rdx, %rbp
	movq	%rdi, %rdx
	mulxq	%r9, %r12, %rdi
	adoxq	%r12, %rbp
	adcxq	%rdi, %rbx
	mulxq	%r10, %r12, %rdi
	adoxq	%r12, %rbx
	mulxq	%rdx, %r13, %r12
	movq	%r9, %rdx
	mulxq	%r10, %r14, %r9
	adcxq	%r14, %rdi
	adoxq	%rcx, %rdi
	adcxq	%rcx, %r9
	adoxq	%rcx, %r9
	mulxq	%rdx, %r15, %r14
	movq	%r10, %rdx
	mulxq	%rdx, %rdx, %r10
	adcxq	%r11, %r11
	adoxq	%rax, %r11
	adcxq	%r8, %r8
	adoxq	%r13, %r8
	adcxq	%rbp, %rbp
	adoxq	%r12, %rbp
	adcxq	%rbx, %rbx
	adoxq	%r15, %rbx
	adcxq	%rdi, %rdi
	adoxq	%r14, %rdi
	adcxq	%r9, %r9
	adoxq	%rdx, %r9
	adcxq	%rcx, %r10
	adoxq	%rcx, %r10
	movq	$38, %rdx
	mulxq	%rbx, %rbx, %rax
	adoxq	%rbx, %rsi
	adcxq	%rax, %r11
	mulxq	%rdi, %rdi, %rax
	adoxq	%rdi, %r11
	adcxq	%rax, %r8
	mulxq	%r9, %rdi, %rax
	adoxq	%rdi, %r8
	adcxq	%rax, %rbp
	mulxq	%r10, %rdx, %rax
	adoxq	%rdx, %rbp
	adcxq	%rcx, %rax
	adoxq	%rcx, %rax
	imulq	$38, %rax, %rax
	addq	%rax, %rsi
	adcq	%rcx, %r11
	adcq	%rcx, %r8
	adcq	%rcx, %rbp
	sbbq	%rcx, %rcx
	andq	$38, %rcx
	leaq	(%rsi,%rcx), %rdx
	decq	328(%rsp)
	xorl	%eax, %eax
	xorq	%rax, %rax
	mulxq	%rdx, %rsi, %rcx
	mulxq	%r11, %rdi, %r9
	mulxq	%r8, %rbx, %r10
	adcxq	%rbx, %r9
	mulxq	%rbp, %rdx, %rbx
	adcxq	%rdx, %r10
	movq	%r11, %rdx
	mulxq	%r8, %r12, %r11
	adoxq	%r12, %r10
	adcxq	%r11, %rbx
	mulxq	%rbp, %r12, %r11
	adoxq	%r12, %rbx
	mulxq	%rdx, %r13, %r12
	movq	%r8, %rdx
	mulxq	%rbp, %r14, %r8
	adcxq	%r14, %r11
	adoxq	%rax, %r11
	adcxq	%rax, %r8
	adoxq	%rax, %r8
	mulxq	%rdx, %r15, %r14
	movq	%rbp, %rdx
	mulxq	%rdx, %rdx, %rbp
	adcxq	%rdi, %rdi
	adoxq	%rcx, %rdi
	adcxq	%r9, %r9
	adoxq	%r13, %r9
	adcxq	%r10, %r10
	adoxq	%r12, %r10
	adcxq	%rbx, %rbx
	adoxq	%r15, %rbx
	adcxq	%r11, %r11
	adoxq	%r14, %r11
	adcxq	%r8, %r8
	adoxq	%rdx, %r8
	adcxq	%rax, %rbp
	adoxq	%rax, %rbp
	movq	$38, %rdx
	mulxq	%rbx, %rbx, %rcx
	adoxq	%rbx, %rsi
	adcxq	%rcx, %rdi
	mulxq	%r11, %r11, %rcx
	adoxq	%r11, %rdi
	adcxq	%rcx, %r9
	mulxq	%r8, %r8, %rcx
	adoxq	%r8, %r9
	adcxq	%rcx, %r10
	mulxq	%rbp, %rdx, %rcx
	adoxq	%rdx, %r10
	adcxq	%rax, %rcx
	adoxq	%rax, %rcx
	imulq	$38, %rcx, %rcx
	addq	%rcx, %rsi
	adcq	%rax, %rdi
	adcq	%rax, %r9
	adcq	%rax, %r10
	sbbq	%rax, %rax
	andq	$38, %rax
	leaq	(%rsi,%rax), %rax
	decq	328(%rsp)
	jne 	Lcurve25519_mulx$4
	xorl	%ecx, %ecx
	xorq	%rcx, %rcx
	movq	160(%rsp), %rdx
	mulxq	%rax, %r8, %rsi
	mulxq	%rdi, %rbp, %r11
	adcxq	%rbp, %rsi
	mulxq	%r9, %rbx, %rbp
	adcxq	%rbx, %r11
	mulxq	%r10, %rdx, %rbx
	adcxq	%rdx, %rbp
	adcxq	%rcx, %rbx
	movq	168(%rsp), %rdx
	mulxq	%rax, %r13, %r12
	adoxq	%r13, %rsi
	adcxq	%r12, %r11
	mulxq	%rdi, %r13, %r12
	adoxq	%r13, %r11
	adcxq	%r12, %rbp
	mulxq	%r9, %r13, %r12
	adoxq	%r13, %rbp
	adcxq	%r12, %rbx
	mulxq	%r10, %rdx, %r12
	adoxq	%rdx, %rbx
	adcxq	%rcx, %r12
	adoxq	%rcx, %r12
	movq	176(%rsp), %rdx
	mulxq	%rax, %r14, %r13
	adoxq	%r14, %r11
	adcxq	%r13, %rbp
	mulxq	%rdi, %r14, %r13
	adoxq	%r14, %rbp
	adcxq	%r13, %rbx
	mulxq	%r9, %r14, %r13
	adoxq	%r14, %rbx
	adcxq	%r13, %r12
	mulxq	%r10, %rdx, %r13
	adoxq	%rdx, %r12
	adcxq	%rcx, %r13
	adoxq	%rcx, %r13
	movq	184(%rsp), %rdx
	mulxq	%rax, %r14, %rax
	adoxq	%r14, %rbp
	adcxq	%rax, %rbx
	mulxq	%rdi, %rdi, %rax
	adoxq	%rdi, %rbx
	adcxq	%rax, %r12
	mulxq	%r9, %rdi, %rax
	adoxq	%rdi, %r12
	adcxq	%rax, %r13
	mulxq	%r10, %rdx, %rax
	adoxq	%rdx, %r13
	adcxq	%rcx, %rax
	adoxq	%rcx, %rax
	movq	$38, %rdx
	mulxq	%rbx, %r9, %rdi
	adoxq	%r9, %r8
	adcxq	%rdi, %rsi
	mulxq	%r12, %r9, %rdi
	adoxq	%r9, %rsi
	adcxq	%rdi, %r11
	mulxq	%r13, %r9, %rdi
	adoxq	%r9, %r11
	adcxq	%rdi, %rbp
	mulxq	%rax, %rdx, %rax
	adoxq	%rdx, %rbp
	adcxq	%rcx, %rax
	adoxq	%rcx, %rax
	imulq	$38, %rax, %rax
	addq	%rax, %r8
	adcq	%rcx, %rsi
	adcq	%rcx, %r11
	adcq	%rcx, %rbp
	sbbq	%rcx, %rcx
	andq	$38, %rcx
	leaq	(%r8,%rcx), %rax
	movq	%rax, 224(%rsp)
	movq	%rsi, 232(%rsp)
	movq	%r11, 240(%rsp)
	movq	%rbp, 248(%rsp)
	movq	$100, 328(%rsp)
Lcurve25519_mulx$3:
	xorl	%ecx, %ecx
	xorq	%rcx, %rcx
	movq	%rax, %rdx
	mulxq	%rdx, %rdi, %rax
	mulxq	%rsi, %r9, %r8
	mulxq	%r11, %rbx, %r10
	adcxq	%rbx, %r8
	mulxq	%rbp, %rdx, %rbx
	adcxq	%rdx, %r10
	movq	%rsi, %rdx
	mulxq	%r11, %r12, %rsi
	adoxq	%r12, %r10
	adcxq	%rsi, %rbx
	mulxq	%rbp, %r12, %rsi
	adoxq	%r12, %rbx
	mulxq	%rdx, %r13, %r12
	movq	%r11, %rdx
	mulxq	%rbp, %r14, %r11
	adcxq	%r14, %rsi
	adoxq	%rcx, %rsi
	adcxq	%rcx, %r11
	adoxq	%rcx, %r11
	mulxq	%rdx, %r15, %r14
	movq	%rbp, %rdx
	mulxq	%rdx, %rdx, %rbp
	adcxq	%r9, %r9
	adoxq	%rax, %r9
	adcxq	%r8, %r8
	adoxq	%r13, %r8
	adcxq	%r10, %r10
	adoxq	%r12, %r10
	adcxq	%rbx, %rbx
	adoxq	%r15, %rbx
	adcxq	%rsi, %rsi
	adoxq	%r14, %rsi
	adcxq	%r11, %r11
	adoxq	%rdx, %r11
	adcxq	%rcx, %rbp
	adoxq	%rcx, %rbp
	movq	$38, %rdx
	mulxq	%rbx, %rbx, %rax
	adoxq	%rbx, %rdi
	adcxq	%rax, %r9
	mulxq	%rsi, %rsi, %rax
	adoxq	%rsi, %r9
	adcxq	%rax, %r8
	mulxq	%r11, %rsi, %rax
	adoxq	%rsi, %r8
	adcxq	%rax, %r10
	mulxq	%rbp, %rdx, %rax
	adoxq	%rdx, %r10
	adcxq	%rcx, %rax
	adoxq	%rcx, %rax
	imulq	$38, %rax, %rax
	addq	%rax, %rdi
	adcq	%rcx, %r9
	adcq	%rcx, %r8
	adcq	%rcx, %r10
	sbbq	%rcx, %rcx
	andq	$38, %rcx
	leaq	(%rdi,%rcx), %rdx
	decq	328(%rsp)
	xorl	%eax, %eax
	xorq	%rax, %rax
	mulxq	%rdx, %rdi, %rcx
	mulxq	%r9, %rsi, %r11
	mulxq	%r8, %rbx, %rbp
	adcxq	%rbx, %r11
	mulxq	%r10, %rdx, %rbx
	adcxq	%rdx, %rbp
	movq	%r9, %rdx
	mulxq	%r8, %r12, %r9
	adoxq	%r12, %rbp
	adcxq	%r9, %rbx
	mulxq	%r10, %r12, %r9
	adoxq	%r12, %rbx
	mulxq	%rdx, %r13, %r12
	movq	%r8, %rdx
	mulxq	%r10, %r14, %r8
	adcxq	%r14, %r9
	adoxq	%rax, %r9
	adcxq	%rax, %r8
	adoxq	%rax, %r8
	mulxq	%rdx, %r15, %r14
	movq	%r10, %rdx
	mulxq	%rdx, %rdx, %r10
	adcxq	%rsi, %rsi
	adoxq	%rcx, %rsi
	adcxq	%r11, %r11
	adoxq	%r13, %r11
	adcxq	%rbp, %rbp
	adoxq	%r12, %rbp
	adcxq	%rbx, %rbx
	adoxq	%r15, %rbx
	adcxq	%r9, %r9
	adoxq	%r14, %r9
	adcxq	%r8, %r8
	adoxq	%rdx, %r8
	adcxq	%rax, %r10
	adoxq	%rax, %r10
	movq	$38, %rdx
	mulxq	%rbx, %rbx, %rcx
	adoxq	%rbx, %rdi
	adcxq	%rcx, %rsi
	mulxq	%r9, %r9, %rcx
	adoxq	%r9, %rsi
	adcxq	%rcx, %r11
	mulxq	%r8, %r8, %rcx
	adoxq	%r8, %r11
	adcxq	%rcx, %rbp
	mulxq	%r10, %rdx, %rcx
	adoxq	%rdx, %rbp
	adcxq	%rax, %rcx
	adoxq	%rax, %rcx
	imulq	$38, %rcx, %rcx
	addq	%rcx, %rdi
	adcq	%rax, %rsi
	adcq	%rax, %r11
	adcq	%rax, %rbp
	sbbq	%rax, %rax
	andq	$38, %rax
	leaq	(%rdi,%rax), %rax
	decq	328(%rsp)
	jne 	Lcurve25519_mulx$3
	xorl	%ecx, %ecx
	xorq	%rcx, %rcx
	movq	224(%rsp), %rdx
	mulxq	%rax, %r8, %rdi
	mulxq	%rsi, %r10, %r9
	adcxq	%r10, %rdi
	mulxq	%r11, %rbx, %r10
	adcxq	%rbx, %r9
	mulxq	%rbp, %rdx, %rbx
	adcxq	%rdx, %r10
	adcxq	%rcx, %rbx
	movq	232(%rsp), %rdx
	mulxq	%rax, %r13, %r12
	adoxq	%r13, %rdi
	adcxq	%r12, %r9
	mulxq	%rsi, %r13, %r12
	adoxq	%r13, %r9
	adcxq	%r12, %r10
	mulxq	%r11, %r13, %r12
	adoxq	%r13, %r10
	adcxq	%r12, %rbx
	mulxq	%rbp, %rdx, %r12
	adoxq	%rdx, %rbx
	adcxq	%rcx, %r12
	adoxq	%rcx, %r12
	movq	240(%rsp), %rdx
	mulxq	%rax, %r14, %r13
	adoxq	%r14, %r9
	adcxq	%r13, %r10
	mulxq	%rsi, %r14, %r13
	adoxq	%r14, %r10
	adcxq	%r13, %rbx
	mulxq	%r11, %r14, %r13
	adoxq	%r14, %rbx
	adcxq	%r13, %r12
	mulxq	%rbp, %rdx, %r13
	adoxq	%rdx, %r12
	adcxq	%rcx, %r13
	adoxq	%rcx, %r13
	movq	248(%rsp), %rdx
	mulxq	%rax, %r14, %rax
	adoxq	%r14, %r10
	adcxq	%rax, %rbx
	mulxq	%rsi, %rsi, %rax
	adoxq	%rsi, %rbx
	adcxq	%rax, %r12
	mulxq	%r11, %rsi, %rax
	adoxq	%rsi, %r12
	adcxq	%rax, %r13
	mulxq	%rbp, %rdx, %rax
	adoxq	%rdx, %r13
	adcxq	%rcx, %rax
	adoxq	%rcx, %rax
	movq	$38, %rdx
	mulxq	%rbx, %r11, %rsi
	adoxq	%r11, %r8
	adcxq	%rsi, %rdi
	mulxq	%r12, %r11, %rsi
	adoxq	%r11, %rdi
	adcxq	%rsi, %r9
	mulxq	%r13, %r11, %rsi
	adoxq	%r11, %r9
	adcxq	%rsi, %r10
	mulxq	%rax, %rdx, %rax
	adoxq	%rdx, %r10
	adcxq	%rcx, %rax
	adoxq	%rcx, %rax
	imulq	$38, %rax, %rax
	addq	%rax, %r8
	adcq	%rcx, %rdi
	adcq	%rcx, %r9
	adcq	%rcx, %r10
	sbbq	%rcx, %rcx
	andq	$38, %rcx
	leaq	(%r8,%rcx), %rax
	movq	$50, 328(%rsp)
Lcurve25519_mulx$2:
	xorl	%ecx, %ecx
	xorq	%rcx, %rcx
	movq	%rax, %rdx
	mulxq	%rdx, %rsi, %rax
	mulxq	%rdi, %r11, %r8
	mulxq	%r9, %rbx, %rbp
	adcxq	%rbx, %r8
	mulxq	%r10, %rdx, %rbx
	adcxq	%rdx, %rbp
	movq	%rdi, %rdx
	mulxq	%r9, %r12, %rdi
	adoxq	%r12, %rbp
	adcxq	%rdi, %rbx
	mulxq	%r10, %r12, %rdi
	adoxq	%r12, %rbx
	mulxq	%rdx, %r13, %r12
	movq	%r9, %rdx
	mulxq	%r10, %r14, %r9
	adcxq	%r14, %rdi
	adoxq	%rcx, %rdi
	adcxq	%rcx, %r9
	adoxq	%rcx, %r9
	mulxq	%rdx, %r15, %r14
	movq	%r10, %rdx
	mulxq	%rdx, %rdx, %r10
	adcxq	%r11, %r11
	adoxq	%rax, %r11
	adcxq	%r8, %r8
	adoxq	%r13, %r8
	adcxq	%rbp, %rbp
	adoxq	%r12, %rbp
	adcxq	%rbx, %rbx
	adoxq	%r15, %rbx
	adcxq	%rdi, %rdi
	adoxq	%r14, %rdi
	adcxq	%r9, %r9
	adoxq	%rdx, %r9
	adcxq	%rcx, %r10
	adoxq	%rcx, %r10
	movq	$38, %rdx
	mulxq	%rbx, %rbx, %rax
	adoxq	%rbx, %rsi
	adcxq	%rax, %r11
	mulxq	%rdi, %rdi, %rax
	adoxq	%rdi, %r11
	adcxq	%rax, %r8
	mulxq	%r9, %rdi, %rax
	adoxq	%rdi, %r8
	adcxq	%rax, %rbp
	mulxq	%r10, %rdx, %rax
	adoxq	%rdx, %rbp
	adcxq	%rcx, %rax
	adoxq	%rcx, %rax
	imulq	$38, %rax, %rax
	addq	%rax, %rsi
	adcq	%rcx, %r11
	adcq	%rcx, %r8
	adcq	%rcx, %rbp
	sbbq	%rcx, %rcx
	andq	$38, %rcx
	leaq	(%rsi,%rcx), %rdx
	decq	328(%rsp)
	xorl	%eax, %eax
	xorq	%rax, %rax
	mulxq	%rdx, %rsi, %rcx
	mulxq	%r11, %rdi, %r9
	mulxq	%r8, %rbx, %r10
	adcxq	%rbx, %r9
	mulxq	%rbp, %rdx, %rbx
	adcxq	%rdx, %r10
	movq	%r11, %rdx
	mulxq	%r8, %r12, %r11
	adoxq	%r12, %r10
	adcxq	%r11, %rbx
	mulxq	%rbp, %r12, %r11
	adoxq	%r12, %rbx
	mulxq	%rdx, %r13, %r12
	movq	%r8, %rdx
	mulxq	%rbp, %r14, %r8
	adcxq	%r14, %r11
	adoxq	%rax, %r11
	adcxq	%rax, %r8
	adoxq	%rax, %r8
	mulxq	%rdx, %r15, %r14
	movq	%rbp, %rdx
	mulxq	%rdx, %rdx, %rbp
	adcxq	%rdi, %rdi
	adoxq	%rcx, %rdi
	adcxq	%r9, %r9
	adoxq	%r13, %r9
	adcxq	%r10, %r10
	adoxq	%r12, %r10
	adcxq	%rbx, %rbx
	adoxq	%r15, %rbx
	adcxq	%r11, %r11
	adoxq	%r14, %r11
	adcxq	%r8, %r8
	adoxq	%rdx, %r8
	adcxq	%rax, %rbp
	adoxq	%rax, %rbp
	movq	$38, %rdx
	mulxq	%rbx, %rbx, %rcx
	adoxq	%rbx, %rsi
	adcxq	%rcx, %rdi
	mulxq	%r11, %r11, %rcx
	adoxq	%r11, %rdi
	adcxq	%rcx, %r9
	mulxq	%r8, %r8, %rcx
	adoxq	%r8, %r9
	adcxq	%rcx, %r10
	mulxq	%rbp, %rdx, %rcx
	adoxq	%rdx, %r10
	adcxq	%rax, %rcx
	adoxq	%rax, %rcx
	imulq	$38, %rcx, %rcx
	addq	%rcx, %rsi
	adcq	%rax, %rdi
	adcq	%rax, %r9
	adcq	%rax, %r10
	sbbq	%rax, %rax
	andq	$38, %rax
	leaq	(%rsi,%rax), %rax
	decq	328(%rsp)
	jne 	Lcurve25519_mulx$2
	xorl	%ecx, %ecx
	xorq	%rcx, %rcx
	movq	160(%rsp), %rdx
	mulxq	%rax, %r8, %rsi
	mulxq	%rdi, %rbp, %r11
	adcxq	%rbp, %rsi
	mulxq	%r9, %rbx, %rbp
	adcxq	%rbx, %r11
	mulxq	%r10, %rdx, %rbx
	adcxq	%rdx, %rbp
	adcxq	%rcx, %rbx
	movq	168(%rsp), %rdx
	mulxq	%rax, %r13, %r12
	adoxq	%r13, %rsi
	adcxq	%r12, %r11
	mulxq	%rdi, %r13, %r12
	adoxq	%r13, %r11
	adcxq	%r12, %rbp
	mulxq	%r9, %r13, %r12
	adoxq	%r13, %rbp
	adcxq	%r12, %rbx
	mulxq	%r10, %rdx, %r12
	adoxq	%rdx, %rbx
	adcxq	%rcx, %r12
	adoxq	%rcx, %r12
	movq	176(%rsp), %rdx
	mulxq	%rax, %r14, %r13
	adoxq	%r14, %r11
	adcxq	%r13, %rbp
	mulxq	%rdi, %r14, %r13
	adoxq	%r14, %rbp
	adcxq	%r13, %rbx
	mulxq	%r9, %r14, %r13
	adoxq	%r14, %rbx
	adcxq	%r13, %r12
	mulxq	%r10, %rdx, %r13
	adoxq	%rdx, %r12
	adcxq	%rcx, %r13
	adoxq	%rcx, %r13
	movq	184(%rsp), %rdx
	mulxq	%rax, %r14, %rax
	adoxq	%r14, %rbp
	adcxq	%rax, %rbx
	mulxq	%rdi, %rdi, %rax
	adoxq	%rdi, %rbx
	adcxq	%rax, %r12
	mulxq	%r9, %rdi, %rax
	adoxq	%rdi, %r12
	adcxq	%rax, %r13
	mulxq	%r10, %rdx, %rax
	adoxq	%rdx, %r13
	adcxq	%rcx, %rax
	adoxq	%rcx, %rax
	movq	$38, %rdx
	mulxq	%rbx, %r9, %rdi
	adoxq	%r9, %r8
	adcxq	%rdi, %rsi
	mulxq	%r12, %r9, %rdi
	adoxq	%r9, %rsi
	adcxq	%rdi, %r11
	mulxq	%r13, %r9, %rdi
	adoxq	%r9, %r11
	adcxq	%rdi, %rbp
	mulxq	%rax, %rdx, %rax
	adoxq	%rdx, %rbp
	adcxq	%rcx, %rax
	adoxq	%rcx, %rax
	imulq	$38, %rax, %rax
	addq	%rax, %r8
	adcq	%rcx, %rsi
	adcq	%rcx, %r11
	adcq	%rcx, %rbp
	sbbq	%rcx, %rcx
	andq	$38, %rcx
	leaq	(%r8,%rcx), %rdx
	movq	$4, 328(%rsp)
Lcurve25519_mulx$1:
	xorl	%eax, %eax
	xorq	%rax, %rax
	mulxq	%rdx, %rdi, %rcx
	mulxq	%rsi, %r9, %r8
	mulxq	%r11, %rbx, %r10
	adcxq	%rbx, %r8
	mulxq	%rbp, %rdx, %rbx
	adcxq	%rdx, %r10
	movq	%rsi, %rdx
	mulxq	%r11, %r12, %rsi
	adoxq	%r12, %r10
	adcxq	%rsi, %rbx
	mulxq	%rbp, %r12, %rsi
	adoxq	%r12, %rbx
	mulxq	%rdx, %r13, %r12
	movq	%r11, %rdx
	mulxq	%rbp, %r14, %r11
	adcxq	%r14, %rsi
	adoxq	%rax, %rsi
	adcxq	%rax, %r11
	adoxq	%rax, %r11
	mulxq	%rdx, %r15, %r14
	movq	%rbp, %rdx
	mulxq	%rdx, %rdx, %rbp
	adcxq	%r9, %r9
	adoxq	%rcx, %r9
	adcxq	%r8, %r8
	adoxq	%r13, %r8
	adcxq	%r10, %r10
	adoxq	%r12, %r10
	adcxq	%rbx, %rbx
	adoxq	%r15, %rbx
	adcxq	%rsi, %rsi
	adoxq	%r14, %rsi
	adcxq	%r11, %r11
	adoxq	%rdx, %r11
	adcxq	%rax, %rbp
	adoxq	%rax, %rbp
	movq	$38, %rdx
	mulxq	%rbx, %rbx, %rcx
	adoxq	%rbx, %rdi
	adcxq	%rcx, %r9
	mulxq	%rsi, %rsi, %rcx
	adoxq	%rsi, %r9
	adcxq	%rcx, %r8
	mulxq	%r11, %rsi, %rcx
	adoxq	%rsi, %r8
	adcxq	%rcx, %r10
	mulxq	%rbp, %rdx, %rcx
	adoxq	%rdx, %r10
	adcxq	%rax, %rcx
	adoxq	%rax, %rcx
	imulq	$38, %rcx, %rcx
	addq	%rcx, %rdi
	adcq	%rax, %r9
	adcq	%rax, %r8
	adcq	%rax, %r10
	sbbq	%rax, %rax
	andq	$38, %rax
	leaq	(%rdi,%rax), %rdx
	decq	328(%rsp)
	xorl	%eax, %eax
	xorq	%rax, %rax
	mulxq	%rdx, %rdi, %rcx
	mulxq	%r9, %rsi, %r11
	mulxq	%r8, %rbx, %rbp
	adcxq	%rbx, %r11
	mulxq	%r10, %rdx, %rbx
	adcxq	%rdx, %rbp
	movq	%r9, %rdx
	mulxq	%r8, %r12, %r9
	adoxq	%r12, %rbp
	adcxq	%r9, %rbx
	mulxq	%r10, %r12, %r9
	adoxq	%r12, %rbx
	mulxq	%rdx, %r13, %r12
	movq	%r8, %rdx
	mulxq	%r10, %r14, %r8
	adcxq	%r14, %r9
	adoxq	%rax, %r9
	adcxq	%rax, %r8
	adoxq	%rax, %r8
	mulxq	%rdx, %r15, %r14
	movq	%r10, %rdx
	mulxq	%rdx, %rdx, %r10
	adcxq	%rsi, %rsi
	adoxq	%rcx, %rsi
	adcxq	%r11, %r11
	adoxq	%r13, %r11
	adcxq	%rbp, %rbp
	adoxq	%r12, %rbp
	adcxq	%rbx, %rbx
	adoxq	%r15, %rbx
	adcxq	%r9, %r9
	adoxq	%r14, %r9
	adcxq	%r8, %r8
	adoxq	%rdx, %r8
	adcxq	%rax, %r10
	adoxq	%rax, %r10
	movq	$38, %rdx
	mulxq	%rbx, %rbx, %rcx
	adoxq	%rbx, %rdi
	adcxq	%rcx, %rsi
	mulxq	%r9, %r9, %rcx
	adoxq	%r9, %rsi
	adcxq	%rcx, %r11
	mulxq	%r8, %r8, %rcx
	adoxq	%r8, %r11
	adcxq	%rcx, %rbp
	mulxq	%r10, %rdx, %rcx
	adoxq	%rdx, %rbp
	adcxq	%rax, %rcx
	adoxq	%rax, %rcx
	imulq	$38, %rcx, %rcx
	addq	%rcx, %rdi
	adcq	%rax, %rsi
	adcq	%rax, %r11
	adcq	%rax, %rbp
	sbbq	%rax, %rax
	andq	$38, %rax
	leaq	(%rdi,%rax), %rdx
	decq	328(%rsp)
	jne 	Lcurve25519_mulx$1
	xorl	%eax, %eax
	xorq	%rax, %rax
	mulxq	%rdx, %rdi, %rcx
	mulxq	%rsi, %r9, %r8
	mulxq	%r11, %rbx, %r10
	adcxq	%rbx, %r8
	mulxq	%rbp, %rdx, %rbx
	adcxq	%rdx, %r10
	movq	%rsi, %rdx
	mulxq	%r11, %r12, %rsi
	adoxq	%r12, %r10
	adcxq	%rsi, %rbx
	mulxq	%rbp, %r12, %rsi
	adoxq	%r12, %rbx
	mulxq	%rdx, %r13, %r12
	movq	%r11, %rdx
	mulxq	%rbp, %r14, %r11
	adcxq	%r14, %rsi
	adoxq	%rax, %rsi
	adcxq	%rax, %r11
	adoxq	%rax, %r11
	mulxq	%rdx, %r15, %r14
	movq	%rbp, %rdx
	mulxq	%rdx, %rdx, %rbp
	adcxq	%r9, %r9
	adoxq	%rcx, %r9
	adcxq	%r8, %r8
	adoxq	%r13, %r8
	adcxq	%r10, %r10
	adoxq	%r12, %r10
	adcxq	%rbx, %rbx
	adoxq	%r15, %rbx
	adcxq	%rsi, %rsi
	adoxq	%r14, %rsi
	adcxq	%r11, %r11
	adoxq	%rdx, %r11
	adcxq	%rax, %rbp
	adoxq	%rax, %rbp
	movq	$38, %rdx
	mulxq	%rbx, %rbx, %rcx
	adoxq	%rbx, %rdi
	adcxq	%rcx, %r9
	mulxq	%rsi, %rsi, %rcx
	adoxq	%rsi, %r9
	adcxq	%rcx, %r8
	mulxq	%r11, %rsi, %rcx
	adoxq	%rsi, %r8
	adcxq	%rcx, %r10
	mulxq	%rbp, %rdx, %rcx
	adoxq	%rdx, %r10
	adcxq	%rax, %rcx
	adoxq	%rax, %rcx
	imulq	$38, %rcx, %rcx
	addq	%rcx, %rdi
	adcq	%rax, %r9
	adcq	%rax, %r8
	adcq	%rax, %r10
	sbbq	%rax, %rax
	andq	$38, %rax
	leaq	(%rdi,%rax), %rax
	xorl	%ecx, %ecx
	xorq	%rcx, %rcx
	movq	192(%rsp), %rdx
	mulxq	%rax, %rdi, %rsi
	mulxq	%r9, %rbp, %r11
	adcxq	%rbp, %rsi
	mulxq	%r8, %rbx, %rbp
	adcxq	%rbx, %r11
	mulxq	%r10, %rdx, %rbx
	adcxq	%rdx, %rbp
	adcxq	%rcx, %rbx
	movq	200(%rsp), %rdx
	mulxq	%rax, %r13, %r12
	adoxq	%r13, %rsi
	adcxq	%r12, %r11
	mulxq	%r9, %r13, %r12
	adoxq	%r13, %r11
	adcxq	%r12, %rbp
	mulxq	%r8, %r13, %r12
	adoxq	%r13, %rbp
	adcxq	%r12, %rbx
	mulxq	%r10, %rdx, %r12
	adoxq	%rdx, %rbx
	adcxq	%rcx, %r12
	adoxq	%rcx, %r12
	movq	208(%rsp), %rdx
	mulxq	%rax, %r14, %r13
	adoxq	%r14, %r11
	adcxq	%r13, %rbp
	mulxq	%r9, %r14, %r13
	adoxq	%r14, %rbp
	adcxq	%r13, %rbx
	mulxq	%r8, %r14, %r13
	adoxq	%r14, %rbx
	adcxq	%r13, %r12
	mulxq	%r10, %rdx, %r13
	adoxq	%rdx, %r12
	adcxq	%rcx, %r13
	adoxq	%rcx, %r13
	movq	216(%rsp), %rdx
	mulxq	%rax, %r14, %rax
	adoxq	%r14, %rbp
	adcxq	%rax, %rbx
	mulxq	%r9, %r9, %rax
	adoxq	%r9, %rbx
	adcxq	%rax, %r12
	mulxq	%r8, %r8, %rax
	adoxq	%r8, %r12
	adcxq	%rax, %r13
	mulxq	%r10, %rdx, %rax
	adoxq	%rdx, %r13
	adcxq	%rcx, %rax
	adoxq	%rcx, %rax
	movq	$38, %rdx
	mulxq	%rbx, %r9, %r8
	adoxq	%r9, %rdi
	adcxq	%r8, %rsi
	mulxq	%r12, %r9, %r8
	adoxq	%r9, %rsi
	adcxq	%r8, %r11
	mulxq	%r13, %r9, %r8
	adoxq	%r9, %r11
	adcxq	%r8, %rbp
	mulxq	%rax, %rdx, %rax
	adoxq	%rdx, %rbp
	adcxq	%rcx, %rax
	adoxq	%rcx, %rax
	imulq	$38, %rax, %rax
	addq	%rax, %rdi
	adcq	%rcx, %rsi
	adcq	%rcx, %r11
	adcq	%rcx, %rbp
	sbbq	%rcx, %rcx
	andq	$38, %rcx
	leaq	(%rdi,%rcx), %rax
	xorl	%ecx, %ecx
	xorq	%rcx, %rcx
	movq	256(%rsp), %rdx
	mulxq	%rax, %r8, %rdi
	mulxq	%rsi, %r10, %r9
	adcxq	%r10, %rdi
	mulxq	%r11, %rbx, %r10
	adcxq	%rbx, %r9
	mulxq	%rbp, %rdx, %rbx
	adcxq	%rdx, %r10
	adcxq	%rcx, %rbx
	movq	264(%rsp), %rdx
	mulxq	%rax, %r13, %r12
	adoxq	%r13, %rdi
	adcxq	%r12, %r9
	mulxq	%rsi, %r13, %r12
	adoxq	%r13, %r9
	adcxq	%r12, %r10
	mulxq	%r11, %r13, %r12
	adoxq	%r13, %r10
	adcxq	%r12, %rbx
	mulxq	%rbp, %rdx, %r12
	adoxq	%rdx, %rbx
	adcxq	%rcx, %r12
	adoxq	%rcx, %r12
	movq	272(%rsp), %rdx
	mulxq	%rax, %r14, %r13
	adoxq	%r14, %r9
	adcxq	%r13, %r10
	mulxq	%rsi, %r14, %r13
	adoxq	%r14, %r10
	adcxq	%r13, %rbx
	mulxq	%r11, %r14, %r13
	adoxq	%r14, %rbx
	adcxq	%r13, %r12
	mulxq	%rbp, %rdx, %r13
	adoxq	%rdx, %r12
	adcxq	%rcx, %r13
	adoxq	%rcx, %r13
	movq	280(%rsp), %rdx
	mulxq	%rax, %r14, %rax
	adoxq	%r14, %r10
	adcxq	%rax, %rbx
	mulxq	%rsi, %rsi, %rax
	adoxq	%rsi, %rbx
	adcxq	%rax, %r12
	mulxq	%r11, %rsi, %rax
	adoxq	%rsi, %r12
	adcxq	%rax, %r13
	mulxq	%rbp, %rdx, %rax
	adoxq	%rdx, %r13
	adcxq	%rcx, %rax
	adoxq	%rcx, %rax
	movq	$38, %rdx
	mulxq	%rbx, %r11, %rsi
	adoxq	%r11, %r8
	adcxq	%rsi, %rdi
	mulxq	%r12, %r11, %rsi
	adoxq	%r11, %rdi
	adcxq	%rsi, %r9
	mulxq	%r13, %r11, %rsi
	adoxq	%r11, %r9
	adcxq	%rsi, %r10
	mulxq	%rax, %rdx, %rax
	adoxq	%rdx, %r10
	adcxq	%rcx, %rax
	adoxq	%rcx, %rax
	imulq	$38, %rax, %rax
	addq	%rax, %r8
	adcq	%rcx, %rdi
	adcq	%rcx, %r9
	adcq	%rcx, %r10
	sbbq	%rcx, %rcx
	andq	$38, %rcx
	leaq	(%r8,%rcx), %rax
	leaq	(%r10,%r10), %rcx
	sarq	$63, %r10
	shrq	$1, %rcx
	andq	$19, %r10
	leaq	19(%r10), %rdx
	addq	%rdx, %rax
	adcq	$0, %rdi
	adcq	$0, %r9
	adcq	$0, %rcx
	leaq	(%rcx,%rcx), %rdx
	sarq	$63, %rcx
	shrq	$1, %rdx
	notq	%rcx
	andq	$19, %rcx
	subq	%rcx, %rax
	sbbq	$0, %rdi
	sbbq	$0, %r9
	sbbq	$0, %rdx
	movq	336(%rsp), %rcx
	movq	%rax, (%rcx)
	movq	%rdi, 8(%rcx)
	movq	%r9, 16(%rcx)
	movq	%rdx, 24(%rcx)
	addq	$344, %rsp
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	ret 

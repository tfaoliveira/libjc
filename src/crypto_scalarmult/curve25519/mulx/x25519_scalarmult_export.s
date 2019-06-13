	.text
	.p2align	5
	.globl	_curve25519_mulx_base
	.globl	curve25519_mulx_base
	.globl	_curve25519_mulx
	.globl	curve25519_mulx
_curve25519_mulx_base:
curve25519_mulx_base:
	pushq	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$288, %rsp
	movq	%rdi, 280(%rsp)
	movq	%rdx, 64(%rsp)
	movq	(%rsi), %rax
	movq	%rax, 240(%rsp)
	movq	8(%rsi), %rax
	movq	%rax, 248(%rsp)
	movq	16(%rsi), %rax
	movq	%rax, 256(%rsp)
	movq	24(%rsi), %rax
	movq	%rax, 264(%rsp)
	andb	$-8, 240(%rsp)
	andb	$127, 271(%rsp)
	orb 	$64, 271(%rsp)
	xorl	%eax, %eax
	movq	$1, (%rsp)
	movq	$1, %rdx
	movq	$1, 136(%rsp)
	movq	%rax, 8(%rsp)
	movq	%rax, %rsi
	movq	%rax, 144(%rsp)
	movq	%rax, 16(%rsp)
	movq	%rax, %rdi
	movq	%rax, 152(%rsp)
	movq	%rax, 24(%rsp)
	movq	%rax, %r8
	movq	%rax, 160(%rsp)
	movq	$9121163629728606909, %rax
	movq	$-4904255419302351368, %rcx
	movq	$-5924590067759888158, %r9
	movq	$2210930892971223860, %r10
	movq	%rax, 72(%rsp)
	movq	%rcx, 80(%rsp)
	movq	%r9, 88(%rsp)
	movq	%r10, 96(%rsp)
	movq	$3, %rcx
	movq	$1, 232(%rsp)
Lcurve25519_mulx_base$10:
	movq	%rcx, 272(%rsp)
	movq	232(%rsp), %rax
	movq	%rcx, %r9
	shrq	$3, %r9
	movzbq	240(%rsp,%r9), %r9
	andq	$7, %rcx
	shrq	%cl, %r9
	andq	$1, %r9
	xorq	%r9, %rax
	movq	(%rsp), %rcx
	movq	8(%rsp), %r10
	movq	16(%rsp), %r11
	movq	24(%rsp), %rbp
	movq	$0, %rbx
	subq	%rax, %rbx
	movq	72(%rsp), %r12
	movq	%rcx, %r13
	xorq	%r12, %r13
	andq	%rbx, %r13
	xorq	%r13, %rcx
	xorq	%r13, %r12
	movq	%r12, 72(%rsp)
	movq	80(%rsp), %r12
	movq	%r10, %r13
	xorq	%r12, %r13
	andq	%rbx, %r13
	xorq	%r13, %r10
	xorq	%r13, %r12
	movq	%r12, 80(%rsp)
	movq	88(%rsp), %r12
	movq	%r11, %r13
	xorq	%r12, %r13
	andq	%rbx, %r13
	xorq	%r13, %r11
	xorq	%r13, %r12
	movq	%r12, 88(%rsp)
	movq	96(%rsp), %r12
	movq	%rbp, %r13
	xorq	%r12, %r13
	andq	%rbx, %r13
	xorq	%r13, %rbp
	xorq	%r13, %r12
	movq	%r12, 96(%rsp)
	movq	%rcx, (%rsp)
	movq	%r10, 8(%rsp)
	movq	%r11, 16(%rsp)
	movq	%rbp, 24(%rsp)
	movq	$0, %rcx
	subq	%rax, %rcx
	movq	136(%rsp), %rax
	movq	%rdx, %r10
	xorq	%rax, %r10
	andq	%rcx, %r10
	xorq	%r10, %rdx
	xorq	%r10, %rax
	movq	%rax, 136(%rsp)
	movq	144(%rsp), %rax
	movq	%rsi, %r10
	xorq	%rax, %r10
	andq	%rcx, %r10
	xorq	%r10, %rsi
	xorq	%r10, %rax
	movq	%rax, 144(%rsp)
	movq	152(%rsp), %rax
	movq	%rdi, %r10
	xorq	%rax, %r10
	andq	%rcx, %r10
	xorq	%r10, %rdi
	xorq	%r10, %rax
	movq	%rax, 152(%rsp)
	movq	160(%rsp), %rax
	movq	%r8, %r10
	xorq	%rax, %r10
	andq	%rcx, %r10
	xorq	%r10, %r8
	xorq	%r10, %rax
	movq	%rax, 160(%rsp)
	movq	%r9, 232(%rsp)
	xorl	%eax, %eax
	movq	(%rsp), %rcx
	movq	8(%rsp), %r9
	movq	16(%rsp), %r10
	movq	24(%rsp), %r11
	subq	%rdx, %rcx
	sbbq	%rsi, %r9
	sbbq	%rdi, %r10
	sbbq	%r8, %r11
	sbbq	%rax, %rax
	andq	$38, %rax
	subq	%rax, %rcx
	sbbq	$0, %r9
	sbbq	$0, %r10
	sbbq	$0, %r11
	sbbq	%rax, %rax
	andq	$38, %rax
	subq	%rax, %rcx
	movq	%rcx, 200(%rsp)
	movq	%r9, 208(%rsp)
	movq	%r10, 216(%rsp)
	movq	%r11, 224(%rsp)
	xorl	%eax, %eax
	movq	%rdx, %rcx
	movq	%rsi, %rdx
	movq	%rdi, %rsi
	movq	%r8, %rdi
	addq	(%rsp), %rcx
	adcq	8(%rsp), %rdx
	adcq	16(%rsp), %rsi
	adcq	24(%rsp), %rdi
	sbbq	%rax, %rax
	andq	$38, %rax
	addq	%rax, %rcx
	adcq	$0, %rdx
	adcq	$0, %rsi
	adcq	$0, %rdi
	sbbq	%rax, %rax
	andq	$38, %rax
	leaq	(%rcx,%rax), %rax
	movq	%rax, 168(%rsp)
	movq	%rdx, 176(%rsp)
	movq	%rsi, 184(%rsp)
	movq	%rdi, 192(%rsp)
	movq	64(%rsp), %rax
	movq	200(%rsp), %rcx
	movq	208(%rsp), %rsi
	movq	216(%rsp), %rdi
	movq	224(%rsp), %r8
	xorl	%r9d, %r9d
	movq	(%rax), %rdx
	mulxq	%rcx, %r11, %r10
	mulxq	%rsi, %rbx, %rbp
	adcxq	%rbx, %r10
	mulxq	%rdi, %r12, %rbx
	adcxq	%r12, %rbp
	mulxq	%r8, %rdx, %r12
	adcxq	%rdx, %rbx
	adcxq	%r9, %r12
	movq	8(%rax), %rdx
	mulxq	%rcx, %r14, %r13
	adoxq	%r14, %r10
	adcxq	%r13, %rbp
	mulxq	%rsi, %r14, %r13
	adoxq	%r14, %rbp
	adcxq	%r13, %rbx
	mulxq	%rdi, %r14, %r13
	adoxq	%r14, %rbx
	adcxq	%r13, %r12
	mulxq	%r8, %rdx, %r13
	adoxq	%rdx, %r12
	adcxq	%r9, %r13
	adoxq	%r9, %r13
	movq	16(%rax), %rdx
	mulxq	%rcx, %r15, %r14
	adoxq	%r15, %rbp
	adcxq	%r14, %rbx
	mulxq	%rsi, %r15, %r14
	adoxq	%r15, %rbx
	adcxq	%r14, %r12
	mulxq	%rdi, %r15, %r14
	adoxq	%r15, %r12
	adcxq	%r14, %r13
	mulxq	%r8, %rdx, %r14
	adoxq	%rdx, %r13
	adcxq	%r9, %r14
	adoxq	%r9, %r14
	movq	24(%rax), %rdx
	mulxq	%rcx, %rcx, %rax
	adoxq	%rcx, %rbx
	adcxq	%rax, %r12
	mulxq	%rsi, %rcx, %rax
	adoxq	%rcx, %r12
	adcxq	%rax, %r13
	mulxq	%rdi, %rcx, %rax
	adoxq	%rcx, %r13
	adcxq	%rax, %r14
	mulxq	%r8, %rcx, %rax
	adoxq	%rcx, %r14
	adcxq	%r9, %rax
	adoxq	%r9, %rax
	movq	$38, %rdx
	mulxq	%r12, %rsi, %rcx
	adoxq	%rsi, %r11
	adcxq	%rcx, %r10
	mulxq	%r13, %rsi, %rcx
	adoxq	%rsi, %r10
	adcxq	%rcx, %rbp
	mulxq	%r14, %rsi, %rcx
	adoxq	%rsi, %rbp
	adcxq	%rcx, %rbx
	mulxq	%rax, %rcx, %rax
	adoxq	%rcx, %rbx
	adcxq	%r9, %rax
	adoxq	%r9, %rax
	imulq	$38, %rax, %rax
	addq	%rax, %r11
	adcq	%r9, %r10
	adcq	%r9, %rbp
	adcq	%r9, %rbx
	sbbq	%r9, %r9
	andq	$38, %r9
	leaq	(%r11,%r9), %rax
	xorl	%ecx, %ecx
	movq	168(%rsp), %rdx
	movq	176(%rsp), %rsi
	movq	184(%rsp), %rdi
	movq	192(%rsp), %r8
	subq	%rax, %rdx
	sbbq	%r10, %rsi
	sbbq	%rbp, %rdi
	sbbq	%rbx, %r8
	sbbq	%rcx, %rcx
	andq	$38, %rcx
	subq	%rcx, %rdx
	sbbq	$0, %rsi
	sbbq	$0, %rdi
	sbbq	$0, %r8
	sbbq	%rcx, %rcx
	andq	$38, %rcx
	subq	%rcx, %rdx
	movq	%rdx, 200(%rsp)
	movq	%rsi, 208(%rsp)
	movq	%rdi, 216(%rsp)
	movq	%r8, 224(%rsp)
	xorl	%ecx, %ecx
	movq	%r10, %rsi
	movq	%rbp, %rdi
	movq	%rbx, %r8
	addq	168(%rsp), %rax
	adcq	176(%rsp), %rsi
	adcq	184(%rsp), %rdi
	adcq	192(%rsp), %r8
	sbbq	%rcx, %rcx
	andq	$38, %rcx
	addq	%rcx, %rax
	adcq	$0, %rsi
	adcq	$0, %rdi
	adcq	$0, %r8
	sbbq	%rcx, %rcx
	andq	$38, %rcx
	leaq	(%rax,%rcx), %rdx
	xorl	%eax, %eax
	mulxq	%rdx, %r9, %rcx
	mulxq	%rsi, %r11, %r10
	mulxq	%rdi, %rbx, %rbp
	adcxq	%rbx, %r10
	mulxq	%r8, %rdx, %rbx
	adcxq	%rdx, %rbp
	movq	%rsi, %rdx
	mulxq	%rdi, %r12, %rsi
	adoxq	%r12, %rbp
	adcxq	%rsi, %rbx
	mulxq	%r8, %r12, %rsi
	adoxq	%r12, %rbx
	mulxq	%rdx, %r13, %r12
	movq	%rdi, %rdx
	mulxq	%r8, %r14, %rdi
	adcxq	%r14, %rsi
	adoxq	%rax, %rsi
	adcxq	%rax, %rdi
	adoxq	%rax, %rdi
	mulxq	%rdx, %r15, %r14
	movq	%r8, %rdx
	mulxq	%rdx, %rdx, %r8
	adcxq	%r11, %r11
	adoxq	%rcx, %r11
	adcxq	%r10, %r10
	adoxq	%r13, %r10
	adcxq	%rbp, %rbp
	adoxq	%r12, %rbp
	adcxq	%rbx, %rbx
	adoxq	%r15, %rbx
	adcxq	%rsi, %rsi
	adoxq	%r14, %rsi
	adcxq	%rdi, %rdi
	adoxq	%rdx, %rdi
	adcxq	%rax, %r8
	adoxq	%rax, %r8
	movq	$38, %rdx
	mulxq	%rbx, %rbx, %rcx
	adoxq	%rbx, %r9
	adcxq	%rcx, %r11
	mulxq	%rsi, %rsi, %rcx
	adoxq	%rsi, %r11
	adcxq	%rcx, %r10
	mulxq	%rdi, %rsi, %rcx
	adoxq	%rsi, %r10
	adcxq	%rcx, %rbp
	mulxq	%r8, %rdx, %rcx
	adoxq	%rdx, %rbp
	adcxq	%rax, %rcx
	adoxq	%rax, %rcx
	imulq	$38, %rcx, %rcx
	addq	%rcx, %r9
	adcq	%rax, %r11
	adcq	%rax, %r10
	adcq	%rax, %rbp
	sbbq	%rax, %rax
	andq	$38, %rax
	leaq	(%r9,%rax), %rax
	movq	%rax, 168(%rsp)
	movq	%r11, 176(%rsp)
	movq	%r10, 184(%rsp)
	movq	%rbp, 192(%rsp)
	movq	200(%rsp), %rdx
	movq	208(%rsp), %rax
	movq	216(%rsp), %rcx
	movq	224(%rsp), %rsi
	xorl	%edi, %edi
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
	movq	%rax, 104(%rsp)
	movq	%r11, 112(%rsp)
	movq	%r10, 120(%rsp)
	movq	%rbp, 128(%rsp)
	movq	168(%rsp), %rax
	movq	176(%rsp), %rcx
	movq	184(%rsp), %rsi
	movq	192(%rsp), %rdi
	xorl	%r8d, %r8d
	movq	136(%rsp), %rdx
	mulxq	%rax, %r10, %r9
	mulxq	%rcx, %rbp, %r11
	adcxq	%rbp, %r9
	mulxq	%rsi, %rbx, %rbp
	adcxq	%rbx, %r11
	mulxq	%rdi, %rdx, %rbx
	adcxq	%rdx, %rbp
	adcxq	%r8, %rbx
	movq	144(%rsp), %rdx
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
	movq	152(%rsp), %rdx
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
	movq	160(%rsp), %rdx
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
	movq	%rax, (%rsp)
	movq	%r9, 8(%rsp)
	movq	%r11, 16(%rsp)
	movq	%rbp, 24(%rsp)
	movq	104(%rsp), %rax
	movq	112(%rsp), %rcx
	movq	120(%rsp), %rsi
	movq	128(%rsp), %rdi
	xorl	%r8d, %r8d
	movq	72(%rsp), %rdx
	mulxq	%rax, %r10, %r9
	mulxq	%rcx, %rbp, %r11
	adcxq	%rbp, %r9
	mulxq	%rsi, %rbx, %rbp
	adcxq	%rbx, %r11
	mulxq	%rdi, %rdx, %rbx
	adcxq	%rdx, %rbp
	adcxq	%r8, %rbx
	movq	80(%rsp), %rdx
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
	movq	88(%rsp), %rdx
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
	movq	96(%rsp), %rdx
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
	movq	%rax, %rdx
	movq	%r9, %rsi
	movq	%r11, %rdi
	movq	%rbp, %r8
	addq	$32, 64(%rsp)
	movq	272(%rsp), %rax
	leaq	1(%rax), %rcx
	cmpq	$255, %rcx
	jb  	Lcurve25519_mulx_base$10
	movq	$0, %rax
Lcurve25519_mulx_base$9:
	movq	%rax, 272(%rsp)
	xorl	%eax, %eax
	movq	%rdx, %rcx
	movq	%rsi, %r9
	movq	%rdi, %r10
	movq	%r8, %r11
	addq	(%rsp), %rcx
	adcq	8(%rsp), %r9
	adcq	16(%rsp), %r10
	adcq	24(%rsp), %r11
	sbbq	%rax, %rax
	andq	$38, %rax
	addq	%rax, %rcx
	adcq	$0, %r9
	adcq	$0, %r10
	adcq	$0, %r11
	sbbq	%rax, %rax
	andq	$38, %rax
	leaq	(%rcx,%rax), %rax
	movq	%rax, 200(%rsp)
	movq	%r9, 208(%rsp)
	movq	%r10, 216(%rsp)
	movq	%r11, 224(%rsp)
	xorl	%eax, %eax
	movq	(%rsp), %rcx
	movq	8(%rsp), %r9
	movq	16(%rsp), %r10
	movq	24(%rsp), %r11
	subq	%rdx, %rcx
	sbbq	%rsi, %r9
	sbbq	%rdi, %r10
	sbbq	%r8, %r11
	sbbq	%rax, %rax
	andq	$38, %rax
	subq	%rax, %rcx
	sbbq	$0, %r9
	sbbq	$0, %r10
	sbbq	$0, %r11
	sbbq	%rax, %rax
	andq	$38, %rax
	subq	%rax, %rcx
	movq	%rcx, 168(%rsp)
	movq	%r9, 176(%rsp)
	movq	%r10, 184(%rsp)
	movq	%r11, 192(%rsp)
	movq	200(%rsp), %rdx
	movq	208(%rsp), %rax
	movq	216(%rsp), %rcx
	movq	224(%rsp), %rsi
	xorl	%edi, %edi
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
	movq	%rax, 136(%rsp)
	movq	%r11, 144(%rsp)
	movq	%r10, 152(%rsp)
	movq	%rbp, 160(%rsp)
	movq	168(%rsp), %rdx
	movq	176(%rsp), %rax
	movq	184(%rsp), %rcx
	movq	192(%rsp), %rsi
	xorl	%edi, %edi
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
	movq	%rax, 32(%rsp)
	movq	%r11, 40(%rsp)
	movq	%r10, 48(%rsp)
	movq	%rbp, 56(%rsp)
	xorl	%ecx, %ecx
	movq	136(%rsp), %rdx
	movq	144(%rsp), %rsi
	movq	152(%rsp), %rdi
	movq	160(%rsp), %r8
	subq	%rax, %rdx
	sbbq	%r11, %rsi
	sbbq	%r10, %rdi
	sbbq	%rbp, %r8
	sbbq	%rcx, %rcx
	andq	$38, %rcx
	subq	%rcx, %rdx
	sbbq	$0, %rsi
	sbbq	$0, %rdi
	sbbq	$0, %r8
	sbbq	%rcx, %rcx
	andq	$38, %rcx
	subq	%rcx, %rdx
	movq	%rdx, 104(%rsp)
	movq	%rsi, 112(%rsp)
	movq	%rdi, 120(%rsp)
	movq	%r8, 128(%rsp)
	movq	$121666, %rdx
	mulxq	104(%rsp), %rcx, %rax
	mulxq	112(%rsp), %rdi, %rsi
	addq	%rdi, %rax
	mulxq	120(%rsp), %r8, %rdi
	adcq	%r8, %rsi
	mulxq	128(%rsp), %r9, %r8
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
	movq	%rcx, 200(%rsp)
	movq	%rax, 208(%rsp)
	movq	%rsi, 216(%rsp)
	movq	%rdi, 224(%rsp)
	xorl	%eax, %eax
	movq	200(%rsp), %rcx
	movq	208(%rsp), %rdx
	movq	216(%rsp), %rsi
	movq	224(%rsp), %rdi
	addq	32(%rsp), %rcx
	adcq	40(%rsp), %rdx
	adcq	48(%rsp), %rsi
	adcq	56(%rsp), %rdi
	sbbq	%rax, %rax
	andq	$38, %rax
	addq	%rax, %rcx
	adcq	$0, %rdx
	adcq	$0, %rsi
	adcq	$0, %rdi
	sbbq	%rax, %rax
	andq	$38, %rax
	leaq	(%rcx,%rax), %rax
	movq	%rax, 168(%rsp)
	movq	%rdx, 176(%rsp)
	movq	%rsi, 184(%rsp)
	movq	%rdi, 192(%rsp)
	movq	32(%rsp), %rax
	movq	40(%rsp), %rcx
	movq	48(%rsp), %rsi
	movq	56(%rsp), %rdi
	xorl	%r8d, %r8d
	movq	136(%rsp), %rdx
	mulxq	%rax, %r10, %r9
	mulxq	%rcx, %rbp, %r11
	adcxq	%rbp, %r9
	mulxq	%rsi, %rbx, %rbp
	adcxq	%rbx, %r11
	mulxq	%rdi, %rdx, %rbx
	adcxq	%rdx, %rbp
	adcxq	%r8, %rbx
	movq	144(%rsp), %rdx
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
	movq	152(%rsp), %rdx
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
	movq	160(%rsp), %rdx
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
	movq	%rax, (%rsp)
	movq	%r9, 8(%rsp)
	movq	%r11, 16(%rsp)
	movq	%rbp, 24(%rsp)
	movq	168(%rsp), %rax
	movq	176(%rsp), %rcx
	movq	184(%rsp), %r9
	movq	192(%rsp), %r10
	xorl	%r11d, %r11d
	movq	104(%rsp), %rdx
	mulxq	%rax, %rbp, %rsi
	mulxq	%rcx, %r8, %rdi
	adcxq	%r8, %rsi
	mulxq	%r9, %rbx, %r8
	adcxq	%rbx, %rdi
	mulxq	%r10, %rdx, %rbx
	adcxq	%rdx, %r8
	adcxq	%r11, %rbx
	movq	112(%rsp), %rdx
	mulxq	%rax, %r13, %r12
	adoxq	%r13, %rsi
	adcxq	%r12, %rdi
	mulxq	%rcx, %r13, %r12
	adoxq	%r13, %rdi
	adcxq	%r12, %r8
	mulxq	%r9, %r13, %r12
	adoxq	%r13, %r8
	adcxq	%r12, %rbx
	mulxq	%r10, %rdx, %r12
	adoxq	%rdx, %rbx
	adcxq	%r11, %r12
	adoxq	%r11, %r12
	movq	120(%rsp), %rdx
	mulxq	%rax, %r14, %r13
	adoxq	%r14, %rdi
	adcxq	%r13, %r8
	mulxq	%rcx, %r14, %r13
	adoxq	%r14, %r8
	adcxq	%r13, %rbx
	mulxq	%r9, %r14, %r13
	adoxq	%r14, %rbx
	adcxq	%r13, %r12
	mulxq	%r10, %rdx, %r13
	adoxq	%rdx, %r12
	adcxq	%r11, %r13
	adoxq	%r11, %r13
	movq	128(%rsp), %rdx
	mulxq	%rax, %r14, %rax
	adoxq	%r14, %r8
	adcxq	%rax, %rbx
	mulxq	%rcx, %rcx, %rax
	adoxq	%rcx, %rbx
	adcxq	%rax, %r12
	mulxq	%r9, %rcx, %rax
	adoxq	%rcx, %r12
	adcxq	%rax, %r13
	mulxq	%r10, %rcx, %rax
	adoxq	%rcx, %r13
	adcxq	%r11, %rax
	adoxq	%r11, %rax
	movq	$38, %rdx
	mulxq	%rbx, %r9, %rcx
	adoxq	%r9, %rbp
	adcxq	%rcx, %rsi
	mulxq	%r12, %r9, %rcx
	adoxq	%r9, %rsi
	adcxq	%rcx, %rdi
	mulxq	%r13, %r9, %rcx
	adoxq	%r9, %rdi
	adcxq	%rcx, %r8
	mulxq	%rax, %rcx, %rax
	adoxq	%rcx, %r8
	adcxq	%r11, %rax
	adoxq	%r11, %rax
	imulq	$38, %rax, %rax
	addq	%rax, %rbp
	adcq	%r11, %rsi
	adcq	%r11, %rdi
	adcq	%r11, %r8
	sbbq	%r11, %r11
	andq	$38, %r11
	leaq	(%rbp,%r11), %rdx
	movq	272(%rsp), %rax
	leaq	1(%rax), %rax
	cmpq	$3, %rax
	jb  	Lcurve25519_mulx_base$9
	movq	%rdx, 168(%rsp)
	movq	%rsi, 176(%rsp)
	movq	%rdi, 184(%rsp)
	movq	%r8, 192(%rsp)
	xorl	%eax, %eax
	mulxq	%rdx, %r9, %rcx
	mulxq	%rsi, %r11, %r10
	mulxq	%rdi, %rbx, %rbp
	adcxq	%rbx, %r10
	mulxq	%r8, %rdx, %rbx
	adcxq	%rdx, %rbp
	movq	%rsi, %rdx
	mulxq	%rdi, %r12, %rsi
	adoxq	%r12, %rbp
	adcxq	%rsi, %rbx
	mulxq	%r8, %r12, %rsi
	adoxq	%r12, %rbx
	mulxq	%rdx, %r13, %r12
	movq	%rdi, %rdx
	mulxq	%r8, %r14, %rdi
	adcxq	%r14, %rsi
	adoxq	%rax, %rsi
	adcxq	%rax, %rdi
	adoxq	%rax, %rdi
	mulxq	%rdx, %r15, %r14
	movq	%r8, %rdx
	mulxq	%rdx, %rdx, %r8
	adcxq	%r11, %r11
	adoxq	%rcx, %r11
	adcxq	%r10, %r10
	adoxq	%r13, %r10
	adcxq	%rbp, %rbp
	adoxq	%r12, %rbp
	adcxq	%rbx, %rbx
	adoxq	%r15, %rbx
	adcxq	%rsi, %rsi
	adoxq	%r14, %rsi
	adcxq	%rdi, %rdi
	adoxq	%rdx, %rdi
	adcxq	%rax, %r8
	adoxq	%rax, %r8
	movq	$38, %rdx
	mulxq	%rbx, %rbx, %rcx
	adoxq	%rbx, %r9
	adcxq	%rcx, %r11
	mulxq	%rsi, %rsi, %rcx
	adoxq	%rsi, %r11
	adcxq	%rcx, %r10
	mulxq	%rdi, %rsi, %rcx
	adoxq	%rsi, %r10
	adcxq	%rcx, %rbp
	mulxq	%r8, %rdx, %rcx
	adoxq	%rdx, %rbp
	adcxq	%rax, %rcx
	adoxq	%rax, %rcx
	imulq	$38, %rcx, %rcx
	addq	%rcx, %r9
	adcq	%rax, %r11
	adcq	%rax, %r10
	adcq	%rax, %rbp
	sbbq	%rax, %rax
	andq	$38, %rax
	leaq	(%r9,%rax), %rdx
	movq	%rdx, 136(%rsp)
	movq	%r11, 144(%rsp)
	movq	%r10, 152(%rsp)
	movq	%rbp, 160(%rsp)
	xorl	%eax, %eax
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
	movq	168(%rsp), %rdx
	mulxq	%rax, %rdi, %rsi
	mulxq	%r11, %r9, %r8
	adcxq	%r9, %rsi
	mulxq	%r10, %rbx, %r9
	adcxq	%rbx, %r8
	mulxq	%rbp, %rdx, %rbx
	adcxq	%rdx, %r9
	adcxq	%rcx, %rbx
	movq	176(%rsp), %rdx
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
	movq	184(%rsp), %rdx
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
	movq	192(%rsp), %rdx
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
	movq	%rax, 104(%rsp)
	movq	%rsi, 112(%rsp)
	movq	%r8, 120(%rsp)
	movq	%r9, 128(%rsp)
	xorl	%ecx, %ecx
	movq	136(%rsp), %rdx
	mulxq	%rax, %r10, %rdi
	mulxq	%rsi, %rbp, %r11
	adcxq	%rbp, %rdi
	mulxq	%r8, %rbx, %rbp
	adcxq	%rbx, %r11
	mulxq	%r9, %rdx, %rbx
	adcxq	%rdx, %rbp
	adcxq	%rcx, %rbx
	movq	144(%rsp), %rdx
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
	movq	152(%rsp), %rdx
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
	movq	160(%rsp), %rdx
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
	movq	%rdx, 136(%rsp)
	movq	%rdi, 144(%rsp)
	movq	%r11, 152(%rsp)
	movq	%rbp, 160(%rsp)
	xorl	%eax, %eax
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
	movq	104(%rsp), %rdx
	mulxq	%rax, %rdi, %rsi
	mulxq	%r9, %rbp, %r11
	adcxq	%rbp, %rsi
	mulxq	%r8, %rbx, %rbp
	adcxq	%rbx, %r11
	mulxq	%r10, %rdx, %rbx
	adcxq	%rdx, %rbp
	adcxq	%rcx, %rbx
	movq	112(%rsp), %rdx
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
	movq	120(%rsp), %rdx
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
	movq	128(%rsp), %rdx
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
	movq	%rdx, 104(%rsp)
	movq	%rsi, 112(%rsp)
	movq	%r11, 120(%rsp)
	movq	%rbp, 128(%rsp)
	xorl	%eax, %eax
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
	movq	$4, 272(%rsp)
Lcurve25519_mulx_base$8:
	xorl	%ecx, %ecx
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
	decq	272(%rsp)
	xorl	%eax, %eax
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
	decq	272(%rsp)
	jne 	Lcurve25519_mulx_base$8
	movq	%rax, 200(%rsp)
	movq	%r9, 208(%rsp)
	movq	%r8, 216(%rsp)
	movq	%r10, 224(%rsp)
	xorl	%ecx, %ecx
	movq	104(%rsp), %rdx
	mulxq	%rax, %rdi, %rsi
	mulxq	%r9, %rbp, %r11
	adcxq	%rbp, %rsi
	mulxq	%r8, %rbx, %rbp
	adcxq	%rbx, %r11
	mulxq	%r10, %rdx, %rbx
	adcxq	%rdx, %rbp
	adcxq	%rcx, %rbx
	movq	112(%rsp), %rdx
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
	movq	120(%rsp), %rdx
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
	movq	128(%rsp), %rdx
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
	movq	%rax, 104(%rsp)
	movq	%rsi, 112(%rsp)
	movq	%r11, 120(%rsp)
	movq	%rbp, 128(%rsp)
	movq	$10, 272(%rsp)
Lcurve25519_mulx_base$7:
	xorl	%ecx, %ecx
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
	decq	272(%rsp)
	xorl	%eax, %eax
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
	decq	272(%rsp)
	jne 	Lcurve25519_mulx_base$7
	xorl	%ecx, %ecx
	movq	104(%rsp), %rdx
	mulxq	%rax, %r8, %rdi
	mulxq	%rsi, %r10, %r9
	adcxq	%r10, %rdi
	mulxq	%r11, %rbx, %r10
	adcxq	%rbx, %r9
	mulxq	%rbp, %rdx, %rbx
	adcxq	%rdx, %r10
	adcxq	%rcx, %rbx
	movq	112(%rsp), %rdx
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
	movq	120(%rsp), %rdx
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
	movq	128(%rsp), %rdx
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
	movq	%rax, 200(%rsp)
	movq	%rdi, 208(%rsp)
	movq	%r9, 216(%rsp)
	movq	%r10, 224(%rsp)
	movq	$20, 272(%rsp)
Lcurve25519_mulx_base$6:
	xorl	%ecx, %ecx
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
	decq	272(%rsp)
	xorl	%eax, %eax
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
	decq	272(%rsp)
	jne 	Lcurve25519_mulx_base$6
	xorl	%ecx, %ecx
	movq	200(%rsp), %rdx
	mulxq	%rax, %r8, %rsi
	mulxq	%rdi, %rbp, %r11
	adcxq	%rbp, %rsi
	mulxq	%r9, %rbx, %rbp
	adcxq	%rbx, %r11
	mulxq	%r10, %rdx, %rbx
	adcxq	%rdx, %rbp
	adcxq	%rcx, %rbx
	movq	208(%rsp), %rdx
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
	movq	216(%rsp), %rdx
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
	movq	224(%rsp), %rdx
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
	movq	$10, 272(%rsp)
Lcurve25519_mulx_base$5:
	xorl	%ecx, %ecx
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
	decq	272(%rsp)
	xorl	%eax, %eax
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
	decq	272(%rsp)
	jne 	Lcurve25519_mulx_base$5
	xorl	%ecx, %ecx
	movq	104(%rsp), %rdx
	mulxq	%rax, %r8, %rdi
	mulxq	%rsi, %r10, %r9
	adcxq	%r10, %rdi
	mulxq	%r11, %rbx, %r10
	adcxq	%rbx, %r9
	mulxq	%rbp, %rdx, %rbx
	adcxq	%rdx, %r10
	adcxq	%rcx, %rbx
	movq	112(%rsp), %rdx
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
	movq	120(%rsp), %rdx
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
	movq	128(%rsp), %rdx
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
	movq	%rax, 104(%rsp)
	movq	%rdi, 112(%rsp)
	movq	%r9, 120(%rsp)
	movq	%r10, 128(%rsp)
	movq	$50, 272(%rsp)
Lcurve25519_mulx_base$4:
	xorl	%ecx, %ecx
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
	decq	272(%rsp)
	xorl	%eax, %eax
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
	decq	272(%rsp)
	jne 	Lcurve25519_mulx_base$4
	xorl	%ecx, %ecx
	movq	104(%rsp), %rdx
	mulxq	%rax, %r8, %rsi
	mulxq	%rdi, %rbp, %r11
	adcxq	%rbp, %rsi
	mulxq	%r9, %rbx, %rbp
	adcxq	%rbx, %r11
	mulxq	%r10, %rdx, %rbx
	adcxq	%rdx, %rbp
	adcxq	%rcx, %rbx
	movq	112(%rsp), %rdx
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
	movq	120(%rsp), %rdx
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
	movq	128(%rsp), %rdx
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
	movq	%rax, 200(%rsp)
	movq	%rsi, 208(%rsp)
	movq	%r11, 216(%rsp)
	movq	%rbp, 224(%rsp)
	movq	$100, 272(%rsp)
Lcurve25519_mulx_base$3:
	xorl	%ecx, %ecx
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
	decq	272(%rsp)
	xorl	%eax, %eax
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
	decq	272(%rsp)
	jne 	Lcurve25519_mulx_base$3
	xorl	%ecx, %ecx
	movq	200(%rsp), %rdx
	mulxq	%rax, %r8, %rdi
	mulxq	%rsi, %r10, %r9
	adcxq	%r10, %rdi
	mulxq	%r11, %rbx, %r10
	adcxq	%rbx, %r9
	mulxq	%rbp, %rdx, %rbx
	adcxq	%rdx, %r10
	adcxq	%rcx, %rbx
	movq	208(%rsp), %rdx
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
	movq	216(%rsp), %rdx
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
	movq	224(%rsp), %rdx
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
	movq	$50, 272(%rsp)
Lcurve25519_mulx_base$2:
	xorl	%ecx, %ecx
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
	decq	272(%rsp)
	xorl	%eax, %eax
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
	decq	272(%rsp)
	jne 	Lcurve25519_mulx_base$2
	xorl	%ecx, %ecx
	movq	104(%rsp), %rdx
	mulxq	%rax, %r8, %rsi
	mulxq	%rdi, %rbp, %r11
	adcxq	%rbp, %rsi
	mulxq	%r9, %rbx, %rbp
	adcxq	%rbx, %r11
	mulxq	%r10, %rdx, %rbx
	adcxq	%rdx, %rbp
	adcxq	%rcx, %rbx
	movq	112(%rsp), %rdx
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
	movq	120(%rsp), %rdx
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
	movq	128(%rsp), %rdx
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
	movq	$4, 272(%rsp)
Lcurve25519_mulx_base$1:
	xorl	%eax, %eax
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
	decq	272(%rsp)
	xorl	%eax, %eax
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
	decq	272(%rsp)
	jne 	Lcurve25519_mulx_base$1
	xorl	%eax, %eax
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
	movq	136(%rsp), %rdx
	mulxq	%rax, %rdi, %rsi
	mulxq	%r9, %rbp, %r11
	adcxq	%rbp, %rsi
	mulxq	%r8, %rbx, %rbp
	adcxq	%rbx, %r11
	mulxq	%r10, %rdx, %rbx
	adcxq	%rdx, %rbp
	adcxq	%rcx, %rbx
	movq	144(%rsp), %rdx
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
	movq	152(%rsp), %rdx
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
	movq	160(%rsp), %rdx
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
	movq	(%rsp), %rdx
	mulxq	%rax, %r8, %rdi
	mulxq	%rsi, %r10, %r9
	adcxq	%r10, %rdi
	mulxq	%r11, %rbx, %r10
	adcxq	%rbx, %r9
	mulxq	%rbp, %rdx, %rbx
	adcxq	%rdx, %r10
	adcxq	%rcx, %rbx
	movq	8(%rsp), %rdx
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
	movq	16(%rsp), %rdx
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
	movq	24(%rsp), %rdx
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
	movq	280(%rsp), %rcx
	movq	%rax, (%rcx)
	movq	%rdi, 8(%rcx)
	movq	%r9, 16(%rcx)
	movq	%rdx, 24(%rcx)
	addq	$288, %rsp
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	ret 
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
	movq	%rax, 160(%rsp)
	movq	%rax, 32(%rsp)
	movq	8(%rdx), %rax
	movq	%rax, 168(%rsp)
	movq	%rax, 40(%rsp)
	movq	16(%rdx), %rax
	movq	%rax, 176(%rsp)
	movq	%rax, 48(%rsp)
	movq	24(%rdx), %rax
	movq	$9223372036854775807, %rcx
	andq	%rcx, %rax
	movq	%rax, 184(%rsp)
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
	movq	%rax, %rdx
	movq	$1, 96(%rsp)
	movq	$1, 256(%rsp)
	movq	%rax, %rsi
	movq	%rax, 104(%rsp)
	movq	%rax, 264(%rsp)
	movq	%rax, %rdi
	movq	%rax, 112(%rsp)
	movq	%rax, 272(%rsp)
	movq	%rax, %r8
	movq	%rax, 120(%rsp)
	movq	%rax, 280(%rsp)
	movq	$254, %rcx
	movq	$0, 288(%rsp)
Lcurve25519_mulx$9:
	movq	%rcx, 328(%rsp)
	movq	288(%rsp), %rax
	movq	%rcx, %r9
	shrq	$3, %r9
	movzbq	296(%rsp,%r9), %r9
	andq	$7, %rcx
	shrq	%cl, %r9
	andq	$1, %r9
	xorq	%r9, %rax
	movq	256(%rsp), %rcx
	movq	264(%rsp), %r10
	movq	272(%rsp), %r11
	movq	280(%rsp), %rbp
	movq	$0, %rbx
	subq	%rax, %rbx
	movq	160(%rsp), %r12
	movq	%rcx, %r13
	xorq	%r12, %r13
	andq	%rbx, %r13
	xorq	%r13, %rcx
	xorq	%r13, %r12
	movq	%r12, 160(%rsp)
	movq	168(%rsp), %r12
	movq	%r10, %r13
	xorq	%r12, %r13
	andq	%rbx, %r13
	xorq	%r13, %r10
	xorq	%r13, %r12
	movq	%r12, 168(%rsp)
	movq	176(%rsp), %r12
	movq	%r11, %r13
	xorq	%r12, %r13
	andq	%rbx, %r13
	xorq	%r13, %r11
	xorq	%r13, %r12
	movq	%r12, 176(%rsp)
	movq	184(%rsp), %r12
	movq	%rbp, %r13
	xorq	%r12, %r13
	andq	%rbx, %r13
	xorq	%r13, %rbp
	xorq	%r13, %r12
	movq	%r12, 184(%rsp)
	movq	%rcx, 256(%rsp)
	movq	%r10, 264(%rsp)
	movq	%r11, 272(%rsp)
	movq	%rbp, 280(%rsp)
	movq	$0, %rcx
	subq	%rax, %rcx
	movq	96(%rsp), %rax
	movq	%rdx, %r10
	xorq	%rax, %r10
	andq	%rcx, %r10
	xorq	%r10, %rdx
	xorq	%r10, %rax
	movq	%rax, 96(%rsp)
	movq	104(%rsp), %rax
	movq	%rsi, %r10
	xorq	%rax, %r10
	andq	%rcx, %r10
	xorq	%r10, %rsi
	xorq	%r10, %rax
	movq	%rax, 104(%rsp)
	movq	112(%rsp), %rax
	movq	%rdi, %r10
	xorq	%rax, %r10
	andq	%rcx, %r10
	xorq	%r10, %rdi
	xorq	%r10, %rax
	movq	%rax, 112(%rsp)
	movq	120(%rsp), %rax
	movq	%r8, %r10
	xorq	%rax, %r10
	andq	%rcx, %r10
	xorq	%r10, %r8
	xorq	%r10, %rax
	movq	%rax, 120(%rsp)
	movq	%r9, 288(%rsp)
	xorl	%eax, %eax
	movq	256(%rsp), %rcx
	movq	264(%rsp), %r9
	movq	272(%rsp), %r10
	movq	280(%rsp), %r11
	subq	%rdx, %rcx
	sbbq	%rsi, %r9
	sbbq	%rdi, %r10
	sbbq	%r8, %r11
	sbbq	%rax, %rax
	andq	$38, %rax
	subq	%rax, %rcx
	sbbq	$0, %r9
	sbbq	$0, %r10
	sbbq	$0, %r11
	sbbq	%rax, %rax
	andq	$38, %rax
	subq	%rax, %rcx
	movq	%rcx, 192(%rsp)
	movq	%r9, 200(%rsp)
	movq	%r10, 208(%rsp)
	movq	%r11, 216(%rsp)
	xorl	%eax, %eax
	movq	%rdx, %rcx
	movq	%rsi, %rdx
	movq	%rdi, %rsi
	movq	%r8, %rdi
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
	movq	%rax, 224(%rsp)
	movq	%rdx, 232(%rsp)
	movq	%rsi, 240(%rsp)
	movq	%rdi, 248(%rsp)
	xorl	%eax, %eax
	movq	160(%rsp), %rcx
	movq	168(%rsp), %rdx
	movq	176(%rsp), %rsi
	movq	184(%rsp), %rdi
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
	movq	%rcx, 64(%rsp)
	movq	%rdx, 72(%rsp)
	movq	%rsi, 80(%rsp)
	movq	%rdi, 88(%rsp)
	xorl	%eax, %eax
	movq	160(%rsp), %rcx
	movq	168(%rsp), %rdx
	movq	176(%rsp), %rsi
	movq	184(%rsp), %rdi
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
	movq	%rax, 256(%rsp)
	movq	%rdx, 264(%rsp)
	movq	%rsi, 272(%rsp)
	movq	%rdi, 280(%rsp)
	movq	64(%rsp), %rax
	movq	72(%rsp), %rcx
	movq	80(%rsp), %rsi
	movq	88(%rsp), %rdi
	xorl	%r8d, %r8d
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
	movq	%rax, 160(%rsp)
	movq	%r9, 168(%rsp)
	movq	%r11, 176(%rsp)
	movq	%rbp, 184(%rsp)
	movq	192(%rsp), %rax
	movq	200(%rsp), %rcx
	movq	208(%rsp), %rsi
	movq	216(%rsp), %rdi
	xorl	%r8d, %r8d
	movq	256(%rsp), %rdx
	mulxq	%rax, %r10, %r9
	mulxq	%rcx, %rbp, %r11
	adcxq	%rbp, %r9
	mulxq	%rsi, %rbx, %rbp
	adcxq	%rbx, %r11
	mulxq	%rdi, %rdx, %rbx
	adcxq	%rdx, %rbp
	adcxq	%r8, %rbx
	movq	264(%rsp), %rdx
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
	movq	272(%rsp), %rdx
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
	movq	280(%rsp), %rdx
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
	movq	224(%rsp), %rdx
	movq	232(%rsp), %rax
	movq	240(%rsp), %rcx
	movq	248(%rsp), %rsi
	xorl	%edi, %edi
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
	movq	192(%rsp), %rdx
	movq	200(%rsp), %rax
	movq	208(%rsp), %rcx
	movq	216(%rsp), %rsi
	xorl	%edi, %edi
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
	movq	%r11, %rcx
	movq	%r10, %rsi
	movq	%rbp, %rdi
	movq	%rax, 64(%rsp)
	movq	%rcx, 72(%rsp)
	movq	%rsi, 80(%rsp)
	movq	%rdi, 88(%rsp)
	xorl	%edx, %edx
	movq	160(%rsp), %r8
	movq	168(%rsp), %r9
	movq	176(%rsp), %r10
	movq	184(%rsp), %r11
	addq	128(%rsp), %r8
	adcq	136(%rsp), %r9
	adcq	144(%rsp), %r10
	adcq	152(%rsp), %r11
	sbbq	%rdx, %rdx
	andq	$38, %rdx
	addq	%rdx, %r8
	adcq	$0, %r9
	adcq	$0, %r10
	adcq	$0, %r11
	sbbq	%rdx, %rdx
	andq	$38, %rdx
	leaq	(%r8,%rdx), %rdx
	movq	%rdx, 192(%rsp)
	movq	%r9, 200(%rsp)
	movq	%r10, 208(%rsp)
	movq	%r11, 216(%rsp)
	xorl	%edx, %edx
	movq	160(%rsp), %r8
	movq	168(%rsp), %r9
	movq	176(%rsp), %r10
	movq	184(%rsp), %r11
	subq	128(%rsp), %r8
	sbbq	136(%rsp), %r9
	sbbq	144(%rsp), %r10
	sbbq	152(%rsp), %r11
	sbbq	%rdx, %rdx
	andq	$38, %rdx
	subq	%rdx, %r8
	sbbq	$0, %r9
	sbbq	$0, %r10
	sbbq	$0, %r11
	sbbq	%rdx, %rdx
	andq	$38, %rdx
	subq	%rdx, %r8
	movq	%r8, 224(%rsp)
	movq	%r9, 232(%rsp)
	movq	%r10, 240(%rsp)
	movq	%r11, 248(%rsp)
	xorl	%r8d, %r8d
	movq	96(%rsp), %rdx
	mulxq	%rax, %r10, %r9
	mulxq	%rcx, %rbp, %r11
	adcxq	%rbp, %r9
	mulxq	%rsi, %rbx, %rbp
	adcxq	%rbx, %r11
	mulxq	%rdi, %rdx, %rbx
	adcxq	%rdx, %rbp
	adcxq	%r8, %rbx
	movq	104(%rsp), %rdx
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
	movq	112(%rsp), %rdx
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
	movq	120(%rsp), %rdx
	mulxq	%rax, %r15, %r14
	adoxq	%r15, %rbp
	adcxq	%r14, %rbx
	mulxq	%rcx, %r15, %r14
	adoxq	%r15, %rbx
	adcxq	%r14, %r12
	mulxq	%rsi, %r15, %r14
	adoxq	%r15, %r12
	adcxq	%r14, %r13
	mulxq	%rdi, %rdx, %r14
	adoxq	%rdx, %r13
	adcxq	%r8, %r14
	adoxq	%r8, %r14
	movq	$38, %rdx
	mulxq	%rbx, %r15, %rbx
	adoxq	%r15, %r10
	adcxq	%rbx, %r9
	mulxq	%r12, %r12, %rbx
	adoxq	%r12, %r9
	adcxq	%rbx, %r11
	mulxq	%r13, %r12, %rbx
	adoxq	%r12, %r11
	adcxq	%rbx, %rbp
	mulxq	%r14, %rbx, %rdx
	adoxq	%rbx, %rbp
	adcxq	%r8, %rdx
	adoxq	%r8, %rdx
	imulq	$38, %rdx, %rdx
	addq	%rdx, %r10
	adcq	%r8, %r9
	adcq	%r8, %r11
	adcq	%r8, %rbp
	sbbq	%r8, %r8
	andq	$38, %r8
	leaq	(%r10,%r8), %rdx
	movq	%rdx, 256(%rsp)
	movq	%r9, 264(%rsp)
	movq	%r11, 272(%rsp)
	movq	%rbp, 280(%rsp)
	xorl	%edx, %edx
	movq	96(%rsp), %r8
	movq	104(%rsp), %r9
	movq	112(%rsp), %r10
	movq	120(%rsp), %r11
	subq	%rax, %r8
	sbbq	%rcx, %r9
	sbbq	%rsi, %r10
	sbbq	%rdi, %r11
	sbbq	%rdx, %rdx
	andq	$38, %rdx
	subq	%rdx, %r8
	sbbq	$0, %r9
	sbbq	$0, %r10
	sbbq	$0, %r11
	sbbq	%rdx, %rdx
	andq	$38, %rdx
	subq	%rdx, %r8
	movq	%r8, (%rsp)
	movq	%r9, 8(%rsp)
	movq	%r10, 16(%rsp)
	movq	%r11, 24(%rsp)
	movq	224(%rsp), %rdx
	movq	232(%rsp), %rax
	movq	240(%rsp), %rcx
	movq	248(%rsp), %rsi
	xorl	%edi, %edi
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
	movq	192(%rsp), %rdx
	movq	200(%rsp), %rax
	movq	208(%rsp), %rcx
	movq	216(%rsp), %rsi
	xorl	%edi, %edi
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
	movq	%rax, 160(%rsp)
	movq	%r11, 168(%rsp)
	movq	%r10, 176(%rsp)
	movq	%rbp, 184(%rsp)
	xorl	%eax, %eax
	movq	64(%rsp), %rcx
	movq	72(%rsp), %rdx
	movq	80(%rsp), %rsi
	movq	88(%rsp), %rdi
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
	movq	128(%rsp), %rax
	movq	136(%rsp), %rcx
	movq	144(%rsp), %rsi
	movq	152(%rsp), %rdi
	xorl	%r8d, %r8d
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
	movq	208(%rsp), %r9
	movq	216(%rsp), %r10
	xorl	%r11d, %r11d
	movq	(%rsp), %rdx
	mulxq	%rax, %rbp, %rsi
	mulxq	%rcx, %r8, %rdi
	adcxq	%r8, %rsi
	mulxq	%r9, %rbx, %r8
	adcxq	%rbx, %rdi
	mulxq	%r10, %rdx, %rbx
	adcxq	%rdx, %r8
	adcxq	%r11, %rbx
	movq	8(%rsp), %rdx
	mulxq	%rax, %r13, %r12
	adoxq	%r13, %rsi
	adcxq	%r12, %rdi
	mulxq	%rcx, %r13, %r12
	adoxq	%r13, %rdi
	adcxq	%r12, %r8
	mulxq	%r9, %r13, %r12
	adoxq	%r13, %r8
	adcxq	%r12, %rbx
	mulxq	%r10, %rdx, %r12
	adoxq	%rdx, %rbx
	adcxq	%r11, %r12
	adoxq	%r11, %r12
	movq	16(%rsp), %rdx
	mulxq	%rax, %r14, %r13
	adoxq	%r14, %rdi
	adcxq	%r13, %r8
	mulxq	%rcx, %r14, %r13
	adoxq	%r14, %r8
	adcxq	%r13, %rbx
	mulxq	%r9, %r14, %r13
	adoxq	%r14, %rbx
	adcxq	%r13, %r12
	mulxq	%r10, %rdx, %r13
	adoxq	%rdx, %r12
	adcxq	%r11, %r13
	adoxq	%r11, %r13
	movq	24(%rsp), %rdx
	mulxq	%rax, %r14, %rax
	adoxq	%r14, %r8
	adcxq	%rax, %rbx
	mulxq	%rcx, %rcx, %rax
	adoxq	%rcx, %rbx
	adcxq	%rax, %r12
	mulxq	%r9, %rcx, %rax
	adoxq	%rcx, %r12
	adcxq	%rax, %r13
	mulxq	%r10, %rcx, %rax
	adoxq	%rcx, %r13
	adcxq	%r11, %rax
	adoxq	%r11, %rax
	movq	$38, %rdx
	mulxq	%rbx, %r9, %rcx
	adoxq	%r9, %rbp
	adcxq	%rcx, %rsi
	mulxq	%r12, %r9, %rcx
	adoxq	%r9, %rsi
	adcxq	%rcx, %rdi
	mulxq	%r13, %r9, %rcx
	adoxq	%r9, %rdi
	adcxq	%rcx, %r8
	mulxq	%rax, %rcx, %rax
	adoxq	%rcx, %r8
	adcxq	%r11, %rax
	adoxq	%r11, %rax
	imulq	$38, %rax, %rax
	addq	%rax, %rbp
	adcq	%r11, %rsi
	adcq	%r11, %rdi
	adcq	%r11, %r8
	sbbq	%r11, %r11
	andq	$38, %r11
	leaq	(%rbp,%r11), %rdx
	movq	328(%rsp), %rax
	leaq	-1(%rax), %rcx
	cmpq	$0, %rcx
	jnl 	Lcurve25519_mulx$9
	movq	%rdx, 224(%rsp)
	movq	%rsi, 232(%rsp)
	movq	%rdi, 240(%rsp)
	movq	%r8, 248(%rsp)
	xorl	%eax, %eax
	mulxq	%rdx, %r9, %rcx
	mulxq	%rsi, %r11, %r10
	mulxq	%rdi, %rbx, %rbp
	adcxq	%rbx, %r10
	mulxq	%r8, %rdx, %rbx
	adcxq	%rdx, %rbp
	movq	%rsi, %rdx
	mulxq	%rdi, %r12, %rsi
	adoxq	%r12, %rbp
	adcxq	%rsi, %rbx
	mulxq	%r8, %r12, %rsi
	adoxq	%r12, %rbx
	mulxq	%rdx, %r13, %r12
	movq	%rdi, %rdx
	mulxq	%r8, %r14, %rdi
	adcxq	%r14, %rsi
	adoxq	%rax, %rsi
	adcxq	%rax, %rdi
	adoxq	%rax, %rdi
	mulxq	%rdx, %r15, %r14
	movq	%r8, %rdx
	mulxq	%rdx, %rdx, %r8
	adcxq	%r11, %r11
	adoxq	%rcx, %r11
	adcxq	%r10, %r10
	adoxq	%r13, %r10
	adcxq	%rbp, %rbp
	adoxq	%r12, %rbp
	adcxq	%rbx, %rbx
	adoxq	%r15, %rbx
	adcxq	%rsi, %rsi
	adoxq	%r14, %rsi
	adcxq	%rdi, %rdi
	adoxq	%rdx, %rdi
	adcxq	%rax, %r8
	adoxq	%rax, %r8
	movq	$38, %rdx
	mulxq	%rbx, %rbx, %rcx
	adoxq	%rbx, %r9
	adcxq	%rcx, %r11
	mulxq	%rsi, %rsi, %rcx
	adoxq	%rsi, %r11
	adcxq	%rcx, %r10
	mulxq	%rdi, %rsi, %rcx
	adoxq	%rsi, %r10
	adcxq	%rcx, %rbp
	mulxq	%r8, %rdx, %rcx
	adoxq	%rdx, %rbp
	adcxq	%rax, %rcx
	adoxq	%rax, %rcx
	imulq	$38, %rcx, %rcx
	addq	%rcx, %r9
	adcq	%rax, %r11
	adcq	%rax, %r10
	adcq	%rax, %rbp
	sbbq	%rax, %rax
	andq	$38, %rax
	leaq	(%r9,%rax), %rdx
	movq	%rdx, 192(%rsp)
	movq	%r11, 200(%rsp)
	movq	%r10, 208(%rsp)
	movq	%rbp, 216(%rsp)
	xorl	%eax, %eax
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
	movq	224(%rsp), %rdx
	mulxq	%rax, %rdi, %rsi
	mulxq	%r11, %r9, %r8
	adcxq	%r9, %rsi
	mulxq	%r10, %rbx, %r9
	adcxq	%rbx, %r8
	mulxq	%rbp, %rdx, %rbx
	adcxq	%rdx, %r9
	adcxq	%rcx, %rbx
	movq	232(%rsp), %rdx
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
	movq	240(%rsp), %rdx
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
	movq	248(%rsp), %rdx
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
	movq	%rax, 128(%rsp)
	movq	%rsi, 136(%rsp)
	movq	%r8, 144(%rsp)
	movq	%r9, 152(%rsp)
	xorl	%ecx, %ecx
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
	movq	128(%rsp), %rdx
	mulxq	%rax, %rdi, %rsi
	mulxq	%r9, %rbp, %r11
	adcxq	%rbp, %rsi
	mulxq	%r8, %rbx, %rbp
	adcxq	%rbx, %r11
	mulxq	%r10, %rdx, %rbx
	adcxq	%rdx, %rbp
	adcxq	%rcx, %rbx
	movq	136(%rsp), %rdx
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
	movq	144(%rsp), %rdx
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
	movq	152(%rsp), %rdx
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
	movq	%rdx, 128(%rsp)
	movq	%rsi, 136(%rsp)
	movq	%r11, 144(%rsp)
	movq	%rbp, 152(%rsp)
	xorl	%eax, %eax
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
	movq	%rax, 160(%rsp)
	movq	%r9, 168(%rsp)
	movq	%r8, 176(%rsp)
	movq	%r10, 184(%rsp)
	xorl	%ecx, %ecx
	movq	128(%rsp), %rdx
	mulxq	%rax, %rdi, %rsi
	mulxq	%r9, %rbp, %r11
	adcxq	%rbp, %rsi
	mulxq	%r8, %rbx, %rbp
	adcxq	%rbx, %r11
	mulxq	%r10, %rdx, %rbx
	adcxq	%rdx, %rbp
	adcxq	%rcx, %rbx
	movq	136(%rsp), %rdx
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
	movq	144(%rsp), %rdx
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
	movq	152(%rsp), %rdx
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
	movq	%rax, 128(%rsp)
	movq	%rsi, 136(%rsp)
	movq	%r11, 144(%rsp)
	movq	%rbp, 152(%rsp)
	movq	$10, 328(%rsp)
Lcurve25519_mulx$7:
	xorl	%ecx, %ecx
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
	movq	128(%rsp), %rdx
	mulxq	%rax, %r8, %rdi
	mulxq	%rsi, %r10, %r9
	adcxq	%r10, %rdi
	mulxq	%r11, %rbx, %r10
	adcxq	%rbx, %r9
	mulxq	%rbp, %rdx, %rbx
	adcxq	%rdx, %r10
	adcxq	%rcx, %rbx
	movq	136(%rsp), %rdx
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
	movq	144(%rsp), %rdx
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
	movq	152(%rsp), %rdx
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
	movq	$20, 328(%rsp)
Lcurve25519_mulx$6:
	xorl	%ecx, %ecx
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
	movq	$10, 328(%rsp)
Lcurve25519_mulx$5:
	xorl	%ecx, %ecx
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
	movq	128(%rsp), %rdx
	mulxq	%rax, %r8, %rdi
	mulxq	%rsi, %r10, %r9
	adcxq	%r10, %rdi
	mulxq	%r11, %rbx, %r10
	adcxq	%rbx, %r9
	mulxq	%rbp, %rdx, %rbx
	adcxq	%rdx, %r10
	adcxq	%rcx, %rbx
	movq	136(%rsp), %rdx
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
	movq	144(%rsp), %rdx
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
	movq	152(%rsp), %rdx
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
	movq	%rax, 128(%rsp)
	movq	%rdi, 136(%rsp)
	movq	%r9, 144(%rsp)
	movq	%r10, 152(%rsp)
	movq	$50, 328(%rsp)
Lcurve25519_mulx$4:
	xorl	%ecx, %ecx
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
	movq	128(%rsp), %rdx
	mulxq	%rax, %r8, %rsi
	mulxq	%rdi, %rbp, %r11
	adcxq	%rbp, %rsi
	mulxq	%r9, %rbx, %rbp
	adcxq	%rbx, %r11
	mulxq	%r10, %rdx, %rbx
	adcxq	%rdx, %rbp
	adcxq	%rcx, %rbx
	movq	136(%rsp), %rdx
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
	movq	144(%rsp), %rdx
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
	movq	152(%rsp), %rdx
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
	movq	%rax, 160(%rsp)
	movq	%rsi, 168(%rsp)
	movq	%r11, 176(%rsp)
	movq	%rbp, 184(%rsp)
	movq	$100, 328(%rsp)
Lcurve25519_mulx$3:
	xorl	%ecx, %ecx
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
	movq	$50, 328(%rsp)
Lcurve25519_mulx$2:
	xorl	%ecx, %ecx
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
	movq	128(%rsp), %rdx
	mulxq	%rax, %r8, %rsi
	mulxq	%rdi, %rbp, %r11
	adcxq	%rbp, %rsi
	mulxq	%r9, %rbx, %rbp
	adcxq	%rbx, %r11
	mulxq	%r10, %rdx, %rbx
	adcxq	%rdx, %rbp
	adcxq	%rcx, %rbx
	movq	136(%rsp), %rdx
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
	movq	144(%rsp), %rdx
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
	movq	152(%rsp), %rdx
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

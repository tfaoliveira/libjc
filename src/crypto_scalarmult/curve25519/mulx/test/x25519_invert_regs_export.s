	.text
	.p2align	5
	.globl	_fe64_invert_regs
	.globl	fe64_invert_regs
_fe64_invert_regs:
fe64_invert_regs:
	pushq	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$136, %rsp
	movq	%rdi, 128(%rsp)
	movq	(%rsi), %rax
	movq	%rax, 96(%rsp)
	movq	8(%rsi), %rax
	movq	%rax, 104(%rsp)
	movq	16(%rsi), %rax
	movq	%rax, 112(%rsp)
	movq	24(%rsi), %rax
	movq	%rax, 120(%rsp)
	movq	96(%rsp), %rax
	movq	104(%rsp), %rcx
	movq	112(%rsp), %rsi
	movq	120(%rsp), %rdi
	movq	$0, %rdx
	xorq	%rdx, %rdx
	movq	%rax, %rdx
	mulxq	%rcx, %r9, %r8
	mulxq	%rsi, %r11, %r10
	adcxq	%r11, %r8
	mulxq	%rdi, %rdx, %r11
	adcxq	%rdx, %r10
	movq	%rcx, %rdx
	mulxq	%rsi, %rbx, %rbp
	adoxq	%rbx, %r10
	mulxq	%rdi, %rdx, %rbx
	adcxq	%rdx, %r11
	adoxq	%rbp, %r11
	movq	$0, %rbp
	adoxq	%rbp, %rbx
	movq	%rsi, %rdx
	mulxq	%rdi, %rdx, %r12
	adcxq	%rdx, %rbx
	adcxq	%rbp, %r12
	movq	%rax, %rdx
	mulxq	%rax, %r13, %rax
	adcxq	%r9, %r9
	adoxq	%rax, %r9
	movq	%rcx, %rdx
	mulxq	%rcx, %rcx, %rax
	adcxq	%r8, %r8
	adoxq	%rcx, %r8
	adcxq	%r10, %r10
	adoxq	%rax, %r10
	movq	%rsi, %rdx
	mulxq	%rsi, %rcx, %rax
	adcxq	%r11, %r11
	adoxq	%rcx, %r11
	adcxq	%rbx, %rbx
	adoxq	%rax, %rbx
	movq	%rdi, %rdx
	mulxq	%rdi, %rcx, %rax
	adcxq	%r12, %r12
	adoxq	%rcx, %r12
	adcxq	%rbp, %rbp
	adoxq	%rax, %rbp
	movq	$38, %rdx
	mulxq	%rbp, %rcx, %rax
	imulq	$38, %rax, %rax
	adcxq	%rax, %r13
	movq	%r9, %rax
	mulxq	%r11, %rdi, %rsi
	adcxq	%rdi, %r13
	adcxq	%rsi, %rax
	movq	%r8, %rsi
	mulxq	%rbx, %r8, %rdi
	adoxq	%r8, %rax
	adoxq	%rdi, %rsi
	movq	%r10, %rdi
	mulxq	%r12, %r8, %rdx
	adcxq	%r8, %rsi
	adcxq	%rdx, %rdi
	adoxq	%rcx, %rdi
	movq	$0, %rcx
	movq	$0, %rdx
	adcxq	%rcx, %rdx
	adoxq	%rcx, %rdx
	shlq	$1, %rdx
	shlq	$1, %rdi
	adcxq	%rcx, %rdx
	shrq	$1, %rdi
	imulq	$19, %rdx, %rdx
	adcxq	%rdx, %r13
	adcxq	%rcx, %rax
	adcxq	%rcx, %rsi
	adcxq	%rcx, %rdi
	movq	%r13, (%rsp)
	movq	%rax, 8(%rsp)
	movq	%rsi, 16(%rsp)
	movq	%rdi, 24(%rsp)
	movq	$0, %rcx
	xorq	%rcx, %rcx
	movq	%r13, %rdx
	mulxq	%rax, %r8, %rcx
	mulxq	%rsi, %r10, %r9
	adcxq	%r10, %rcx
	mulxq	%rdi, %rdx, %r10
	adcxq	%rdx, %r9
	movq	%rax, %rdx
	mulxq	%rsi, %rbp, %r11
	adoxq	%rbp, %r9
	mulxq	%rdi, %rdx, %rbp
	adcxq	%rdx, %r10
	adoxq	%r11, %r10
	movq	$0, %r11
	adoxq	%r11, %rbp
	movq	%rsi, %rdx
	mulxq	%rdi, %rdx, %rbx
	adcxq	%rdx, %rbp
	adcxq	%r11, %rbx
	movq	%r13, %rdx
	mulxq	%r13, %r12, %rdx
	adcxq	%r8, %r8
	adoxq	%rdx, %r8
	movq	%rax, %rdx
	mulxq	%rax, %rdx, %rax
	adcxq	%rcx, %rcx
	adoxq	%rdx, %rcx
	adcxq	%r9, %r9
	adoxq	%rax, %r9
	movq	%rsi, %rdx
	mulxq	%rsi, %rdx, %rax
	adcxq	%r10, %r10
	adoxq	%rdx, %r10
	adcxq	%rbp, %rbp
	adoxq	%rax, %rbp
	movq	%rdi, %rdx
	mulxq	%rdi, %rdx, %rax
	adcxq	%rbx, %rbx
	adoxq	%rdx, %rbx
	adcxq	%r11, %r11
	adoxq	%rax, %r11
	movq	$38, %rdx
	mulxq	%r11, %rsi, %rax
	imulq	$38, %rax, %rax
	adcxq	%rax, %r12
	movq	%r8, %rax
	mulxq	%r10, %r8, %rdi
	adcxq	%r8, %r12
	adcxq	%rdi, %rax
	mulxq	%rbp, %r8, %rdi
	adoxq	%r8, %rax
	adoxq	%rdi, %rcx
	movq	%r9, %rdi
	mulxq	%rbx, %r8, %rdx
	adcxq	%r8, %rcx
	adcxq	%rdx, %rdi
	adoxq	%rsi, %rdi
	movq	$0, %rdx
	movq	$0, %rsi
	adcxq	%rdx, %rsi
	adoxq	%rdx, %rsi
	shlq	$1, %rsi
	shlq	$1, %rdi
	adcxq	%rdx, %rsi
	shrq	$1, %rdi
	imulq	$19, %rsi, %rsi
	adcxq	%rsi, %r12
	adcxq	%rdx, %rax
	adcxq	%rdx, %rcx
	adcxq	%rdx, %rdi
	movq	$0, %rdx
	xorq	%rdx, %rdx
	movq	%r12, %rdx
	mulxq	%rax, %r8, %rsi
	mulxq	%rcx, %r10, %r9
	adcxq	%r10, %rsi
	mulxq	%rdi, %rdx, %r10
	adcxq	%rdx, %r9
	movq	%rax, %rdx
	mulxq	%rcx, %rbp, %r11
	adoxq	%rbp, %r9
	mulxq	%rdi, %rdx, %rbp
	adcxq	%rdx, %r10
	adoxq	%r11, %r10
	movq	$0, %r11
	adoxq	%r11, %rbp
	movq	%rcx, %rdx
	mulxq	%rdi, %rdx, %rbx
	adcxq	%rdx, %rbp
	adcxq	%r11, %rbx
	movq	%r12, %rdx
	mulxq	%r12, %r12, %rdx
	adcxq	%r8, %r8
	adoxq	%rdx, %r8
	movq	%rax, %rdx
	mulxq	%rax, %rdx, %rax
	adcxq	%rsi, %rsi
	adoxq	%rdx, %rsi
	adcxq	%r9, %r9
	adoxq	%rax, %r9
	movq	%rcx, %rdx
	mulxq	%rcx, %rcx, %rax
	adcxq	%r10, %r10
	adoxq	%rcx, %r10
	adcxq	%rbp, %rbp
	adoxq	%rax, %rbp
	movq	%rdi, %rdx
	mulxq	%rdi, %rcx, %rax
	adcxq	%rbx, %rbx
	adoxq	%rcx, %rbx
	adcxq	%r11, %r11
	adoxq	%rax, %r11
	movq	$38, %rdx
	mulxq	%r11, %rcx, %rax
	imulq	$38, %rax, %rax
	adcxq	%rax, %r12
	movq	%r8, %rax
	mulxq	%r10, %r8, %rdi
	adcxq	%r8, %r12
	adcxq	%rdi, %rax
	mulxq	%rbp, %r8, %rdi
	adoxq	%r8, %rax
	adoxq	%rdi, %rsi
	movq	%r9, %rdi
	mulxq	%rbx, %r8, %rdx
	adcxq	%r8, %rsi
	adcxq	%rdx, %rdi
	adoxq	%rcx, %rdi
	movq	$0, %rcx
	movq	$0, %rdx
	adcxq	%rcx, %rdx
	adoxq	%rcx, %rdx
	shlq	$1, %rdx
	shlq	$1, %rdi
	adcxq	%rcx, %rdx
	shrq	$1, %rdi
	imulq	$19, %rdx, %rdx
	adcxq	%rdx, %r12
	adcxq	%rcx, %rax
	adcxq	%rcx, %rsi
	adcxq	%rcx, %rdi
	movq	$0, %rcx
	xorq	%rcx, %rcx
	movq	96(%rsp), %rdx
	mulxq	%r12, %r9, %r8
	mulxq	%rax, %r11, %r10
	adcxq	%r11, %r8
	mulxq	%rsi, %rbp, %r11
	adcxq	%rbp, %r10
	mulxq	%rdi, %rdx, %rbp
	adcxq	%rdx, %r11
	adcxq	%rcx, %rbp
	movq	104(%rsp), %rdx
	mulxq	%r12, %r13, %rbx
	adoxq	%r13, %r8
	adcxq	%rbx, %r10
	mulxq	%rax, %r13, %rbx
	adoxq	%r13, %r10
	adcxq	%rbx, %r11
	mulxq	%rsi, %r13, %rbx
	adoxq	%r13, %r11
	adcxq	%rbx, %rbp
	mulxq	%rdi, %rdx, %rbx
	adoxq	%rdx, %rbp
	adcxq	%rcx, %rbx
	adoxq	%rcx, %rbx
	movq	112(%rsp), %rdx
	mulxq	%r12, %r14, %r13
	adoxq	%r14, %r10
	adcxq	%r13, %r11
	mulxq	%rax, %r14, %r13
	adoxq	%r14, %r11
	adcxq	%r13, %rbp
	mulxq	%rsi, %r14, %r13
	adoxq	%r14, %rbp
	adcxq	%r13, %rbx
	mulxq	%rdi, %rdx, %r13
	adoxq	%rdx, %rbx
	adcxq	%rcx, %r13
	adoxq	%rcx, %r13
	movq	120(%rsp), %rdx
	mulxq	%r12, %r14, %r12
	adoxq	%r14, %r11
	adcxq	%r12, %rbp
	mulxq	%rax, %r12, %rax
	adoxq	%r12, %rbp
	adcxq	%rax, %rbx
	mulxq	%rsi, %rsi, %rax
	adoxq	%rsi, %rbx
	adcxq	%rax, %r13
	mulxq	%rdi, %rdx, %rax
	adoxq	%rdx, %r13
	adcxq	%rcx, %rax
	adoxq	%rcx, %rax
	movq	$38, %rdx
	mulxq	%rbp, %rdi, %rsi
	adoxq	%rdi, %r9
	adcxq	%rsi, %r8
	mulxq	%rbx, %rdi, %rsi
	adoxq	%rdi, %r8
	adcxq	%rsi, %r10
	mulxq	%r13, %rdi, %rsi
	adoxq	%rdi, %r10
	adcxq	%rsi, %r11
	mulxq	%rax, %rdx, %rax
	adoxq	%rdx, %r11
	adcxq	%rcx, %rax
	adoxq	%rcx, %rax
	imulq	$38, %rax, %rax
	addq	%rax, %r9
	adcq	%rcx, %r8
	adcq	%rcx, %r10
	adcq	%rcx, %r11
	sbbq	%rcx, %rcx
	andq	$38, %rcx
	leaq	(%r9,%rcx), %rax
	movq	%rax, 64(%rsp)
	movq	%r8, 72(%rsp)
	movq	%r10, 80(%rsp)
	movq	%r11, 88(%rsp)
	movq	$0, %rcx
	xorq	%rcx, %rcx
	movq	(%rsp), %rdx
	mulxq	%rax, %rdi, %rsi
	mulxq	%r8, %rbp, %r9
	adcxq	%rbp, %rsi
	mulxq	%r10, %rbx, %rbp
	adcxq	%rbx, %r9
	mulxq	%r11, %rdx, %rbx
	adcxq	%rdx, %rbp
	adcxq	%rcx, %rbx
	movq	8(%rsp), %rdx
	mulxq	%rax, %r13, %r12
	adoxq	%r13, %rsi
	adcxq	%r12, %r9
	mulxq	%r8, %r13, %r12
	adoxq	%r13, %r9
	adcxq	%r12, %rbp
	mulxq	%r10, %r13, %r12
	adoxq	%r13, %rbp
	adcxq	%r12, %rbx
	mulxq	%r11, %rdx, %r12
	adoxq	%rdx, %rbx
	adcxq	%rcx, %r12
	adoxq	%rcx, %r12
	movq	16(%rsp), %rdx
	mulxq	%rax, %r14, %r13
	adoxq	%r14, %r9
	adcxq	%r13, %rbp
	mulxq	%r8, %r14, %r13
	adoxq	%r14, %rbp
	adcxq	%r13, %rbx
	mulxq	%r10, %r14, %r13
	adoxq	%r14, %rbx
	adcxq	%r13, %r12
	mulxq	%r11, %rdx, %r13
	adoxq	%rdx, %r12
	adcxq	%rcx, %r13
	adoxq	%rcx, %r13
	movq	24(%rsp), %rdx
	mulxq	%rax, %r14, %rax
	adoxq	%r14, %rbp
	adcxq	%rax, %rbx
	mulxq	%r8, %r8, %rax
	adoxq	%r8, %rbx
	adcxq	%rax, %r12
	mulxq	%r10, %r8, %rax
	adoxq	%r8, %r12
	adcxq	%rax, %r13
	mulxq	%r11, %rdx, %rax
	adoxq	%rdx, %r13
	adcxq	%rcx, %rax
	adoxq	%rcx, %rax
	movq	$38, %rdx
	mulxq	%rbx, %r10, %r8
	adoxq	%r10, %rdi
	adcxq	%r8, %rsi
	mulxq	%r12, %r10, %r8
	adoxq	%r10, %rsi
	adcxq	%r8, %r9
	mulxq	%r13, %r10, %r8
	adoxq	%r10, %r9
	adcxq	%r8, %rbp
	mulxq	%rax, %rdx, %rax
	adoxq	%rdx, %rbp
	adcxq	%rcx, %rax
	adoxq	%rcx, %rax
	imulq	$38, %rax, %rax
	addq	%rax, %rdi
	adcq	%rcx, %rsi
	adcq	%rcx, %r9
	adcq	%rcx, %rbp
	sbbq	%rcx, %rcx
	andq	$38, %rcx
	leaq	(%rdi,%rcx), %rax
	movq	%rax, (%rsp)
	movq	%rsi, 8(%rsp)
	movq	%r9, 16(%rsp)
	movq	%rbp, 24(%rsp)
	movq	$0, %rcx
	xorq	%rcx, %rcx
	movq	%rax, %rdx
	mulxq	%rsi, %rdi, %rcx
	mulxq	%r9, %r10, %r8
	adcxq	%r10, %rcx
	mulxq	%rbp, %rdx, %r10
	adcxq	%rdx, %r8
	movq	%rsi, %rdx
	mulxq	%r9, %rbx, %r11
	adoxq	%rbx, %r8
	mulxq	%rbp, %rdx, %rbx
	adcxq	%rdx, %r10
	adoxq	%r11, %r10
	movq	$0, %r11
	adoxq	%r11, %rbx
	movq	%r9, %rdx
	mulxq	%rbp, %rdx, %r12
	adcxq	%rdx, %rbx
	adcxq	%r11, %r12
	movq	%rax, %rdx
	mulxq	%rax, %r13, %rax
	adcxq	%rdi, %rdi
	adoxq	%rax, %rdi
	movq	%rsi, %rdx
	mulxq	%rsi, %rdx, %rax
	adcxq	%rcx, %rcx
	adoxq	%rdx, %rcx
	adcxq	%r8, %r8
	adoxq	%rax, %r8
	movq	%r9, %rdx
	mulxq	%r9, %rdx, %rax
	adcxq	%r10, %r10
	adoxq	%rdx, %r10
	adcxq	%rbx, %rbx
	adoxq	%rax, %rbx
	movq	%rbp, %rdx
	mulxq	%rbp, %rdx, %rax
	adcxq	%r12, %r12
	adoxq	%rdx, %r12
	adcxq	%r11, %r11
	adoxq	%rax, %r11
	movq	$38, %rdx
	mulxq	%r11, %rsi, %rax
	imulq	$38, %rax, %rax
	adcxq	%rax, %r13
	movq	%rdi, %rax
	mulxq	%r10, %r9, %rdi
	adcxq	%r9, %r13
	adcxq	%rdi, %rax
	mulxq	%rbx, %r9, %rdi
	adoxq	%r9, %rax
	adoxq	%rdi, %rcx
	movq	%r8, %rdi
	mulxq	%r12, %r8, %rdx
	adcxq	%r8, %rcx
	adcxq	%rdx, %rdi
	adoxq	%rsi, %rdi
	movq	$0, %rdx
	movq	$0, %rsi
	adcxq	%rdx, %rsi
	adoxq	%rdx, %rsi
	shlq	$1, %rsi
	shlq	$1, %rdi
	adcxq	%rdx, %rsi
	shrq	$1, %rdi
	imulq	$19, %rsi, %rsi
	adcxq	%rsi, %r13
	adcxq	%rdx, %rax
	adcxq	%rdx, %rcx
	adcxq	%rdx, %rdi
	movq	$0, %rsi
	xorq	%rsi, %rsi
	movq	64(%rsp), %rdx
	mulxq	%r13, %r9, %r8
	mulxq	%rax, %r11, %r10
	adcxq	%r11, %r8
	mulxq	%rcx, %rbp, %r11
	adcxq	%rbp, %r10
	mulxq	%rdi, %rdx, %rbp
	adcxq	%rdx, %r11
	adcxq	%rsi, %rbp
	movq	72(%rsp), %rdx
	mulxq	%r13, %r12, %rbx
	adoxq	%r12, %r8
	adcxq	%rbx, %r10
	mulxq	%rax, %r12, %rbx
	adoxq	%r12, %r10
	adcxq	%rbx, %r11
	mulxq	%rcx, %r12, %rbx
	adoxq	%r12, %r11
	adcxq	%rbx, %rbp
	mulxq	%rdi, %rdx, %rbx
	adoxq	%rdx, %rbp
	adcxq	%rsi, %rbx
	adoxq	%rsi, %rbx
	movq	80(%rsp), %rdx
	mulxq	%r13, %r14, %r12
	adoxq	%r14, %r10
	adcxq	%r12, %r11
	mulxq	%rax, %r14, %r12
	adoxq	%r14, %r11
	adcxq	%r12, %rbp
	mulxq	%rcx, %r14, %r12
	adoxq	%r14, %rbp
	adcxq	%r12, %rbx
	mulxq	%rdi, %rdx, %r12
	adoxq	%rdx, %rbx
	adcxq	%rsi, %r12
	adoxq	%rsi, %r12
	movq	88(%rsp), %rdx
	mulxq	%r13, %r14, %r13
	adoxq	%r14, %r11
	adcxq	%r13, %rbp
	mulxq	%rax, %r13, %rax
	adoxq	%r13, %rbp
	adcxq	%rax, %rbx
	mulxq	%rcx, %rcx, %rax
	adoxq	%rcx, %rbx
	adcxq	%rax, %r12
	mulxq	%rdi, %rcx, %rax
	adoxq	%rcx, %r12
	adcxq	%rsi, %rax
	adoxq	%rsi, %rax
	movq	$38, %rdx
	mulxq	%rbp, %rdi, %rcx
	adoxq	%rdi, %r9
	adcxq	%rcx, %r8
	mulxq	%rbx, %rdi, %rcx
	adoxq	%rdi, %r8
	adcxq	%rcx, %r10
	mulxq	%r12, %rdi, %rcx
	adoxq	%rdi, %r10
	adcxq	%rcx, %r11
	mulxq	%rax, %rcx, %rax
	adoxq	%rcx, %r11
	adcxq	%rsi, %rax
	adoxq	%rsi, %rax
	imulq	$38, %rax, %rax
	addq	%rax, %r9
	adcq	%rsi, %r8
	adcq	%rsi, %r10
	adcq	%rsi, %r11
	sbbq	%rsi, %rsi
	andq	$38, %rsi
	leaq	(%r9,%rsi), %rax
	movq	%rax, 64(%rsp)
	movq	%r8, 72(%rsp)
	movq	%r10, 80(%rsp)
	movq	%r11, 88(%rsp)
	movq	$0, %rcx
	xorq	%rcx, %rcx
	movq	%rax, %rdx
	mulxq	%r8, %rsi, %rcx
	mulxq	%r10, %r9, %rdi
	adcxq	%r9, %rcx
	mulxq	%r11, %rdx, %r9
	adcxq	%rdx, %rdi
	movq	%r8, %rdx
	mulxq	%r10, %rbx, %rbp
	adoxq	%rbx, %rdi
	mulxq	%r11, %rdx, %rbx
	adcxq	%rdx, %r9
	adoxq	%rbp, %r9
	movq	$0, %rbp
	adoxq	%rbp, %rbx
	movq	%r10, %rdx
	mulxq	%r11, %rdx, %r12
	adcxq	%rdx, %rbx
	adcxq	%rbp, %r12
	movq	%rax, %rdx
	mulxq	%rax, %r13, %rax
	adcxq	%rsi, %rsi
	adoxq	%rax, %rsi
	movq	%r8, %rdx
	mulxq	%r8, %rdx, %rax
	adcxq	%rcx, %rcx
	adoxq	%rdx, %rcx
	adcxq	%rdi, %rdi
	adoxq	%rax, %rdi
	movq	%r10, %rdx
	mulxq	%r10, %rdx, %rax
	adcxq	%r9, %r9
	adoxq	%rdx, %r9
	adcxq	%rbx, %rbx
	adoxq	%rax, %rbx
	movq	%r11, %rdx
	mulxq	%r11, %rdx, %rax
	adcxq	%r12, %r12
	adoxq	%rdx, %r12
	adcxq	%rbp, %rbp
	adoxq	%rax, %rbp
	movq	$38, %rdx
	mulxq	%rbp, %r8, %rax
	imulq	$38, %rax, %rax
	adcxq	%rax, %r13
	movq	%rsi, %rax
	mulxq	%r9, %r9, %rsi
	adcxq	%r9, %r13
	adcxq	%rsi, %rax
	mulxq	%rbx, %r9, %rsi
	adoxq	%r9, %rax
	adoxq	%rsi, %rcx
	movq	%rdi, %rsi
	mulxq	%r12, %rdi, %rdx
	adcxq	%rdi, %rcx
	adcxq	%rdx, %rsi
	adoxq	%r8, %rsi
	movq	$0, %rdx
	movq	$0, %rdi
	adcxq	%rdx, %rdi
	adoxq	%rdx, %rdi
	shlq	$1, %rdi
	shlq	$1, %rsi
	adcxq	%rdx, %rdi
	shrq	$1, %rsi
	imulq	$19, %rdi, %rdi
	adcxq	%rdi, %r13
	adcxq	%rdx, %rax
	adcxq	%rdx, %rcx
	adcxq	%rdx, %rsi
	movq	$4, %rdi
Lfe64_invert_regs$8:
	movq	$0, %rdx
	xorq	%rdx, %rdx
	movq	%r13, %rdx
	mulxq	%rax, %r9, %r8
	mulxq	%rcx, %r11, %r10
	adcxq	%r11, %r8
	mulxq	%rsi, %rdx, %r11
	adcxq	%rdx, %r10
	movq	%rax, %rdx
	mulxq	%rcx, %rbx, %rbp
	adoxq	%rbx, %r10
	mulxq	%rsi, %rdx, %rbx
	adcxq	%rdx, %r11
	adoxq	%rbp, %r11
	movq	$0, %rbp
	adoxq	%rbp, %rbx
	movq	%rcx, %rdx
	mulxq	%rsi, %rdx, %r12
	adcxq	%rdx, %rbx
	adcxq	%rbp, %r12
	movq	%r13, %rdx
	mulxq	%r13, %r13, %rdx
	adcxq	%r9, %r9
	adoxq	%rdx, %r9
	movq	%rax, %rdx
	mulxq	%rax, %rdx, %rax
	adcxq	%r8, %r8
	adoxq	%rdx, %r8
	adcxq	%r10, %r10
	adoxq	%rax, %r10
	movq	%rcx, %rdx
	mulxq	%rcx, %rcx, %rax
	adcxq	%r11, %r11
	adoxq	%rcx, %r11
	adcxq	%rbx, %rbx
	adoxq	%rax, %rbx
	movq	%rsi, %rdx
	mulxq	%rsi, %rcx, %rax
	adcxq	%r12, %r12
	adoxq	%rcx, %r12
	adcxq	%rbp, %rbp
	adoxq	%rax, %rbp
	movq	$38, %rdx
	mulxq	%rbp, %rcx, %rax
	imulq	$38, %rax, %rax
	adcxq	%rax, %r13
	movq	%r9, %rax
	mulxq	%r11, %r9, %rsi
	adcxq	%r9, %r13
	adcxq	%rsi, %rax
	movq	%r8, %rsi
	mulxq	%rbx, %r9, %r8
	adoxq	%r9, %rax
	adoxq	%r8, %rsi
	movq	%r10, %r8
	mulxq	%r12, %r9, %rdx
	adcxq	%r9, %rsi
	adcxq	%rdx, %r8
	adoxq	%rcx, %r8
	movq	$0, %rcx
	movq	$0, %rdx
	adcxq	%rcx, %rdx
	adoxq	%rcx, %rdx
	shlq	$1, %rdx
	shlq	$1, %r8
	adcxq	%rcx, %rdx
	shrq	$1, %r8
	imulq	$19, %rdx, %rdx
	adcxq	%rdx, %r13
	adcxq	%rcx, %rax
	adcxq	%rcx, %rsi
	adcxq	%rcx, %r8
	decq	%rdi
	movq	$0, %rcx
	xorq	%rcx, %rcx
	movq	%r13, %rdx
	mulxq	%rax, %r9, %rcx
	mulxq	%rsi, %r11, %r10
	adcxq	%r11, %rcx
	mulxq	%r8, %rdx, %r11
	adcxq	%rdx, %r10
	movq	%rax, %rdx
	mulxq	%rsi, %rbx, %rbp
	adoxq	%rbx, %r10
	mulxq	%r8, %rdx, %rbx
	adcxq	%rdx, %r11
	adoxq	%rbp, %r11
	movq	$0, %rbp
	adoxq	%rbp, %rbx
	movq	%rsi, %rdx
	mulxq	%r8, %rdx, %r12
	adcxq	%rdx, %rbx
	adcxq	%rbp, %r12
	movq	%r13, %rdx
	mulxq	%r13, %r13, %rdx
	adcxq	%r9, %r9
	adoxq	%rdx, %r9
	movq	%rax, %rdx
	mulxq	%rax, %rdx, %rax
	adcxq	%rcx, %rcx
	adoxq	%rdx, %rcx
	adcxq	%r10, %r10
	adoxq	%rax, %r10
	movq	%rsi, %rdx
	mulxq	%rsi, %rdx, %rax
	adcxq	%r11, %r11
	adoxq	%rdx, %r11
	adcxq	%rbx, %rbx
	adoxq	%rax, %rbx
	movq	%r8, %rdx
	mulxq	%r8, %rdx, %rax
	adcxq	%r12, %r12
	adoxq	%rdx, %r12
	adcxq	%rbp, %rbp
	adoxq	%rax, %rbp
	movq	$38, %rdx
	mulxq	%rbp, %r8, %rax
	imulq	$38, %rax, %rax
	adcxq	%rax, %r13
	movq	%r9, %rax
	mulxq	%r11, %r9, %rsi
	adcxq	%r9, %r13
	adcxq	%rsi, %rax
	mulxq	%rbx, %r9, %rsi
	adoxq	%r9, %rax
	adoxq	%rsi, %rcx
	movq	%r10, %rsi
	mulxq	%r12, %r9, %rdx
	adcxq	%r9, %rcx
	adcxq	%rdx, %rsi
	adoxq	%r8, %rsi
	movq	$0, %rdx
	movq	$0, %r8
	adcxq	%rdx, %r8
	adoxq	%rdx, %r8
	shlq	$1, %r8
	shlq	$1, %rsi
	adcxq	%rdx, %r8
	shrq	$1, %rsi
	imulq	$19, %r8, %r8
	adcxq	%r8, %r13
	adcxq	%rdx, %rax
	adcxq	%rdx, %rcx
	adcxq	%rdx, %rsi
	decq	%rdi
	jne 	Lfe64_invert_regs$8
	movq	%r13, 32(%rsp)
	movq	%rax, 40(%rsp)
	movq	%rcx, 48(%rsp)
	movq	%rsi, 56(%rsp)
	movq	$0, %rdi
	xorq	%rdi, %rdi
	movq	64(%rsp), %rdx
	mulxq	%r13, %r9, %r8
	mulxq	%rax, %r11, %r10
	adcxq	%r11, %r8
	mulxq	%rcx, %rbp, %r11
	adcxq	%rbp, %r10
	mulxq	%rsi, %rdx, %rbp
	adcxq	%rdx, %r11
	adcxq	%rdi, %rbp
	movq	72(%rsp), %rdx
	mulxq	%r13, %r12, %rbx
	adoxq	%r12, %r8
	adcxq	%rbx, %r10
	mulxq	%rax, %r12, %rbx
	adoxq	%r12, %r10
	adcxq	%rbx, %r11
	mulxq	%rcx, %r12, %rbx
	adoxq	%r12, %r11
	adcxq	%rbx, %rbp
	mulxq	%rsi, %rdx, %rbx
	adoxq	%rdx, %rbp
	adcxq	%rdi, %rbx
	adoxq	%rdi, %rbx
	movq	80(%rsp), %rdx
	mulxq	%r13, %r14, %r12
	adoxq	%r14, %r10
	adcxq	%r12, %r11
	mulxq	%rax, %r14, %r12
	adoxq	%r14, %r11
	adcxq	%r12, %rbp
	mulxq	%rcx, %r14, %r12
	adoxq	%r14, %rbp
	adcxq	%r12, %rbx
	mulxq	%rsi, %rdx, %r12
	adoxq	%rdx, %rbx
	adcxq	%rdi, %r12
	adoxq	%rdi, %r12
	movq	88(%rsp), %rdx
	mulxq	%r13, %r14, %r13
	adoxq	%r14, %r11
	adcxq	%r13, %rbp
	mulxq	%rax, %r13, %rax
	adoxq	%r13, %rbp
	adcxq	%rax, %rbx
	mulxq	%rcx, %rcx, %rax
	adoxq	%rcx, %rbx
	adcxq	%rax, %r12
	mulxq	%rsi, %rcx, %rax
	adoxq	%rcx, %r12
	adcxq	%rdi, %rax
	adoxq	%rdi, %rax
	movq	$38, %rdx
	mulxq	%rbp, %rsi, %rcx
	adoxq	%rsi, %r9
	adcxq	%rcx, %r8
	mulxq	%rbx, %rsi, %rcx
	adoxq	%rsi, %r8
	adcxq	%rcx, %r10
	mulxq	%r12, %rsi, %rcx
	adoxq	%rsi, %r10
	adcxq	%rcx, %r11
	mulxq	%rax, %rcx, %rax
	adoxq	%rcx, %r11
	adcxq	%rdi, %rax
	adoxq	%rdi, %rax
	imulq	$38, %rax, %rax
	addq	%rax, %r9
	adcq	%rdi, %r8
	adcq	%rdi, %r10
	adcq	%rdi, %r11
	sbbq	%rdi, %rdi
	andq	$38, %rdi
	leaq	(%r9,%rdi), %r13
	movq	%r13, 64(%rsp)
	movq	%r8, 72(%rsp)
	movq	%r10, 80(%rsp)
	movq	%r11, 88(%rsp)
	movq	$10, %rax
Lfe64_invert_regs$7:
	movq	$0, %rcx
	xorq	%rcx, %rcx
	movq	%r13, %rdx
	mulxq	%r8, %rsi, %rcx
	mulxq	%r10, %r9, %rdi
	adcxq	%r9, %rcx
	mulxq	%r11, %rdx, %r9
	adcxq	%rdx, %rdi
	movq	%r8, %rdx
	mulxq	%r10, %rbx, %rbp
	adoxq	%rbx, %rdi
	mulxq	%r11, %rdx, %rbx
	adcxq	%rdx, %r9
	adoxq	%rbp, %r9
	movq	$0, %rbp
	adoxq	%rbp, %rbx
	movq	%r10, %rdx
	mulxq	%r11, %rdx, %r12
	adcxq	%rdx, %rbx
	adcxq	%rbp, %r12
	movq	%r13, %rdx
	mulxq	%r13, %r13, %rdx
	adcxq	%rsi, %rsi
	adoxq	%rdx, %rsi
	movq	%r8, %rdx
	mulxq	%r8, %r8, %rdx
	adcxq	%rcx, %rcx
	adoxq	%r8, %rcx
	adcxq	%rdi, %rdi
	adoxq	%rdx, %rdi
	movq	%r10, %rdx
	mulxq	%r10, %r8, %rdx
	adcxq	%r9, %r9
	adoxq	%r8, %r9
	adcxq	%rbx, %rbx
	adoxq	%rdx, %rbx
	movq	%r11, %rdx
	mulxq	%r11, %r8, %rdx
	adcxq	%r12, %r12
	adoxq	%r8, %r12
	adcxq	%rbp, %rbp
	adoxq	%rdx, %rbp
	movq	$38, %rdx
	mulxq	%rbp, %r10, %r8
	imulq	$38, %r8, %r8
	adcxq	%r8, %r13
	mulxq	%r9, %r9, %r8
	adcxq	%r9, %r13
	adcxq	%r8, %rsi
	mulxq	%rbx, %r9, %r8
	adoxq	%r9, %rsi
	adoxq	%r8, %rcx
	mulxq	%r12, %r8, %rdx
	adcxq	%r8, %rcx
	adcxq	%rdx, %rdi
	adoxq	%r10, %rdi
	movq	$0, %rdx
	movq	$0, %r8
	adcxq	%rdx, %r8
	adoxq	%rdx, %r8
	shlq	$1, %r8
	shlq	$1, %rdi
	adcxq	%rdx, %r8
	shrq	$1, %rdi
	imulq	$19, %r8, %r8
	adcxq	%r8, %r13
	adcxq	%rdx, %rsi
	adcxq	%rdx, %rcx
	adcxq	%rdx, %rdi
	decq	%rax
	movq	$0, %rdx
	xorq	%rdx, %rdx
	movq	%r13, %rdx
	mulxq	%rsi, %r8, %r9
	mulxq	%rcx, %r10, %r11
	adcxq	%r10, %r9
	mulxq	%rdi, %rdx, %r10
	adcxq	%rdx, %r11
	movq	%rsi, %rdx
	mulxq	%rcx, %rbx, %rbp
	adoxq	%rbx, %r11
	mulxq	%rdi, %rdx, %rbx
	adcxq	%rdx, %r10
	adoxq	%rbp, %r10
	movq	$0, %rbp
	adoxq	%rbp, %rbx
	movq	%rcx, %rdx
	mulxq	%rdi, %rdx, %r12
	adcxq	%rdx, %rbx
	adcxq	%rbp, %r12
	movq	%r13, %rdx
	mulxq	%r13, %r13, %rdx
	adcxq	%r8, %r8
	adoxq	%rdx, %r8
	movq	%rsi, %rdx
	mulxq	%rsi, %rsi, %rdx
	adcxq	%r9, %r9
	adoxq	%rsi, %r9
	adcxq	%r11, %r11
	adoxq	%rdx, %r11
	movq	%rcx, %rdx
	mulxq	%rcx, %rdx, %rcx
	adcxq	%r10, %r10
	adoxq	%rdx, %r10
	adcxq	%rbx, %rbx
	adoxq	%rcx, %rbx
	movq	%rdi, %rdx
	mulxq	%rdi, %rdx, %rcx
	adcxq	%r12, %r12
	adoxq	%rdx, %r12
	adcxq	%rbp, %rbp
	adoxq	%rcx, %rbp
	movq	$38, %rdx
	mulxq	%rbp, %rsi, %rcx
	imulq	$38, %rcx, %rcx
	adcxq	%rcx, %r13
	mulxq	%r10, %rdi, %rcx
	adcxq	%rdi, %r13
	adcxq	%rcx, %r8
	movq	%r9, %r10
	mulxq	%rbx, %rdi, %rcx
	adoxq	%rdi, %r8
	adoxq	%rcx, %r10
	mulxq	%r12, %rdx, %rcx
	adcxq	%rdx, %r10
	adcxq	%rcx, %r11
	adoxq	%rsi, %r11
	movq	$0, %rcx
	movq	$0, %rdx
	adcxq	%rcx, %rdx
	adoxq	%rcx, %rdx
	shlq	$1, %rdx
	shlq	$1, %r11
	adcxq	%rcx, %rdx
	shrq	$1, %r11
	imulq	$19, %rdx, %rdx
	adcxq	%rdx, %r13
	adcxq	%rcx, %r8
	adcxq	%rcx, %r10
	adcxq	%rcx, %r11
	decq	%rax
	jne 	Lfe64_invert_regs$7
	movq	$0, %rax
	xorq	%rax, %rax
	movq	64(%rsp), %rdx
	mulxq	%r13, %rsi, %rcx
	mulxq	%r8, %r9, %rdi
	adcxq	%r9, %rcx
	mulxq	%r10, %rbp, %r9
	adcxq	%rbp, %rdi
	mulxq	%r11, %rdx, %rbp
	adcxq	%rdx, %r9
	adcxq	%rax, %rbp
	movq	72(%rsp), %rdx
	mulxq	%r13, %r12, %rbx
	adoxq	%r12, %rcx
	adcxq	%rbx, %rdi
	mulxq	%r8, %r12, %rbx
	adoxq	%r12, %rdi
	adcxq	%rbx, %r9
	mulxq	%r10, %r12, %rbx
	adoxq	%r12, %r9
	adcxq	%rbx, %rbp
	mulxq	%r11, %rdx, %rbx
	adoxq	%rdx, %rbp
	adcxq	%rax, %rbx
	adoxq	%rax, %rbx
	movq	80(%rsp), %rdx
	mulxq	%r13, %r14, %r12
	adoxq	%r14, %rdi
	adcxq	%r12, %r9
	mulxq	%r8, %r14, %r12
	adoxq	%r14, %r9
	adcxq	%r12, %rbp
	mulxq	%r10, %r14, %r12
	adoxq	%r14, %rbp
	adcxq	%r12, %rbx
	mulxq	%r11, %rdx, %r12
	adoxq	%rdx, %rbx
	adcxq	%rax, %r12
	adoxq	%rax, %r12
	movq	88(%rsp), %rdx
	mulxq	%r13, %r14, %r13
	adoxq	%r14, %r9
	adcxq	%r13, %rbp
	mulxq	%r8, %r13, %r8
	adoxq	%r13, %rbp
	adcxq	%r8, %rbx
	mulxq	%r10, %r10, %r8
	adoxq	%r10, %rbx
	adcxq	%r8, %r12
	mulxq	%r11, %rdx, %r8
	adoxq	%rdx, %r12
	adcxq	%rax, %r8
	adoxq	%rax, %r8
	movq	$38, %rdx
	mulxq	%rbp, %r11, %r10
	adoxq	%r11, %rsi
	adcxq	%r10, %rcx
	mulxq	%rbx, %r11, %r10
	adoxq	%r11, %rcx
	adcxq	%r10, %rdi
	mulxq	%r12, %r11, %r10
	adoxq	%r11, %rdi
	adcxq	%r10, %r9
	mulxq	%r8, %r8, %rdx
	adoxq	%r8, %r9
	adcxq	%rax, %rdx
	adoxq	%rax, %rdx
	imulq	$38, %rdx, %rdx
	addq	%rdx, %rsi
	adcq	%rax, %rcx
	adcq	%rax, %rdi
	adcq	%rax, %r9
	sbbq	%rax, %rax
	andq	$38, %rax
	leaq	(%rsi,%rax), %r13
	movq	%r13, 32(%rsp)
	movq	%rcx, 40(%rsp)
	movq	%rdi, 48(%rsp)
	movq	%r9, 56(%rsp)
	movq	$20, %rax
Lfe64_invert_regs$6:
	movq	$0, %rdx
	xorq	%rdx, %rdx
	movq	%r13, %rdx
	mulxq	%rcx, %r8, %rsi
	mulxq	%rdi, %r11, %r10
	adcxq	%r11, %rsi
	mulxq	%r9, %rdx, %r11
	adcxq	%rdx, %r10
	movq	%rcx, %rdx
	mulxq	%rdi, %rbx, %rbp
	adoxq	%rbx, %r10
	mulxq	%r9, %rdx, %rbx
	adcxq	%rdx, %r11
	adoxq	%rbp, %r11
	movq	$0, %rbp
	adoxq	%rbp, %rbx
	movq	%rdi, %rdx
	mulxq	%r9, %rdx, %r12
	adcxq	%rdx, %rbx
	adcxq	%rbp, %r12
	movq	%r13, %rdx
	mulxq	%r13, %r13, %rdx
	adcxq	%r8, %r8
	adoxq	%rdx, %r8
	movq	%rcx, %rdx
	mulxq	%rcx, %rdx, %rcx
	adcxq	%rsi, %rsi
	adoxq	%rdx, %rsi
	adcxq	%r10, %r10
	adoxq	%rcx, %r10
	movq	%rdi, %rdx
	mulxq	%rdi, %rdx, %rcx
	adcxq	%r11, %r11
	adoxq	%rdx, %r11
	adcxq	%rbx, %rbx
	adoxq	%rcx, %rbx
	movq	%r9, %rdx
	mulxq	%r9, %rdx, %rcx
	adcxq	%r12, %r12
	adoxq	%rdx, %r12
	adcxq	%rbp, %rbp
	adoxq	%rcx, %rbp
	movq	$38, %rdx
	mulxq	%rbp, %rdi, %rcx
	imulq	$38, %rcx, %rcx
	adcxq	%rcx, %r13
	movq	%r8, %rcx
	mulxq	%r11, %r9, %r8
	adcxq	%r9, %r13
	adcxq	%r8, %rcx
	mulxq	%rbx, %r9, %r8
	adoxq	%r9, %rcx
	adoxq	%r8, %rsi
	movq	%r10, %r8
	mulxq	%r12, %r9, %rdx
	adcxq	%r9, %rsi
	adcxq	%rdx, %r8
	adoxq	%rdi, %r8
	movq	$0, %rdx
	movq	$0, %rdi
	adcxq	%rdx, %rdi
	adoxq	%rdx, %rdi
	shlq	$1, %rdi
	shlq	$1, %r8
	adcxq	%rdx, %rdi
	shrq	$1, %r8
	imulq	$19, %rdi, %rdi
	adcxq	%rdi, %r13
	adcxq	%rdx, %rcx
	adcxq	%rdx, %rsi
	adcxq	%rdx, %r8
	decq	%rax
	movq	$0, %rdx
	xorq	%rdx, %rdx
	movq	%r13, %rdx
	mulxq	%rcx, %r9, %rdi
	mulxq	%rsi, %r11, %r10
	adcxq	%r11, %rdi
	mulxq	%r8, %rdx, %r11
	adcxq	%rdx, %r10
	movq	%rcx, %rdx
	mulxq	%rsi, %rbx, %rbp
	adoxq	%rbx, %r10
	mulxq	%r8, %rdx, %rbx
	adcxq	%rdx, %r11
	adoxq	%rbp, %r11
	movq	$0, %rbp
	adoxq	%rbp, %rbx
	movq	%rsi, %rdx
	mulxq	%r8, %rdx, %r12
	adcxq	%rdx, %rbx
	adcxq	%rbp, %r12
	movq	%r13, %rdx
	mulxq	%r13, %r13, %rdx
	adcxq	%r9, %r9
	adoxq	%rdx, %r9
	movq	%rcx, %rdx
	mulxq	%rcx, %rdx, %rcx
	adcxq	%rdi, %rdi
	adoxq	%rdx, %rdi
	adcxq	%r10, %r10
	adoxq	%rcx, %r10
	movq	%rsi, %rdx
	mulxq	%rsi, %rdx, %rcx
	adcxq	%r11, %r11
	adoxq	%rdx, %r11
	adcxq	%rbx, %rbx
	adoxq	%rcx, %rbx
	movq	%r8, %rdx
	mulxq	%r8, %rdx, %rcx
	adcxq	%r12, %r12
	adoxq	%rdx, %r12
	adcxq	%rbp, %rbp
	adoxq	%rcx, %rbp
	movq	$38, %rdx
	mulxq	%rbp, %rsi, %rcx
	imulq	$38, %rcx, %rcx
	adcxq	%rcx, %r13
	movq	%r9, %rcx
	mulxq	%r11, %r9, %r8
	adcxq	%r9, %r13
	adcxq	%r8, %rcx
	mulxq	%rbx, %r9, %r8
	adoxq	%r9, %rcx
	adoxq	%r8, %rdi
	movq	%r10, %r9
	mulxq	%r12, %r8, %rdx
	adcxq	%r8, %rdi
	adcxq	%rdx, %r9
	adoxq	%rsi, %r9
	movq	$0, %rdx
	movq	$0, %rsi
	adcxq	%rdx, %rsi
	adoxq	%rdx, %rsi
	shlq	$1, %rsi
	shlq	$1, %r9
	adcxq	%rdx, %rsi
	shrq	$1, %r9
	imulq	$19, %rsi, %rsi
	adcxq	%rsi, %r13
	adcxq	%rdx, %rcx
	adcxq	%rdx, %rdi
	adcxq	%rdx, %r9
	decq	%rax
	jne 	Lfe64_invert_regs$6
	movq	$0, %rax
	xorq	%rax, %rax
	movq	32(%rsp), %rdx
	mulxq	%r13, %r8, %rsi
	mulxq	%rcx, %r11, %r10
	adcxq	%r11, %rsi
	mulxq	%rdi, %rbp, %r11
	adcxq	%rbp, %r10
	mulxq	%r9, %rdx, %rbp
	adcxq	%rdx, %r11
	adcxq	%rax, %rbp
	movq	40(%rsp), %rdx
	mulxq	%r13, %r12, %rbx
	adoxq	%r12, %rsi
	adcxq	%rbx, %r10
	mulxq	%rcx, %r12, %rbx
	adoxq	%r12, %r10
	adcxq	%rbx, %r11
	mulxq	%rdi, %r12, %rbx
	adoxq	%r12, %r11
	adcxq	%rbx, %rbp
	mulxq	%r9, %rdx, %rbx
	adoxq	%rdx, %rbp
	adcxq	%rax, %rbx
	adoxq	%rax, %rbx
	movq	48(%rsp), %rdx
	mulxq	%r13, %r14, %r12
	adoxq	%r14, %r10
	adcxq	%r12, %r11
	mulxq	%rcx, %r14, %r12
	adoxq	%r14, %r11
	adcxq	%r12, %rbp
	mulxq	%rdi, %r14, %r12
	adoxq	%r14, %rbp
	adcxq	%r12, %rbx
	mulxq	%r9, %rdx, %r12
	adoxq	%rdx, %rbx
	adcxq	%rax, %r12
	adoxq	%rax, %r12
	movq	56(%rsp), %rdx
	mulxq	%r13, %r14, %r13
	adoxq	%r14, %r11
	adcxq	%r13, %rbp
	mulxq	%rcx, %r13, %rcx
	adoxq	%r13, %rbp
	adcxq	%rcx, %rbx
	mulxq	%rdi, %rdi, %rcx
	adoxq	%rdi, %rbx
	adcxq	%rcx, %r12
	mulxq	%r9, %rdx, %rcx
	adoxq	%rdx, %r12
	adcxq	%rax, %rcx
	adoxq	%rax, %rcx
	movq	$38, %rdx
	mulxq	%rbp, %r9, %rdi
	adoxq	%r9, %r8
	adcxq	%rdi, %rsi
	mulxq	%rbx, %r9, %rdi
	adoxq	%r9, %rsi
	adcxq	%rdi, %r10
	mulxq	%r12, %r9, %rdi
	adoxq	%r9, %r10
	adcxq	%rdi, %r11
	mulxq	%rcx, %rdx, %rcx
	adoxq	%rdx, %r11
	adcxq	%rax, %rcx
	adoxq	%rax, %rcx
	imulq	$38, %rcx, %rcx
	addq	%rcx, %r8
	adcq	%rax, %rsi
	adcq	%rax, %r10
	adcq	%rax, %r11
	sbbq	%rax, %rax
	andq	$38, %rax
	leaq	(%r8,%rax), %r13
	movq	$10, %rax
Lfe64_invert_regs$5:
	movq	$0, %rcx
	xorq	%rcx, %rcx
	movq	%r13, %rdx
	mulxq	%rsi, %rdi, %rcx
	mulxq	%r10, %r9, %r8
	adcxq	%r9, %rcx
	mulxq	%r11, %rdx, %r9
	adcxq	%rdx, %r8
	movq	%rsi, %rdx
	mulxq	%r10, %rbx, %rbp
	adoxq	%rbx, %r8
	mulxq	%r11, %rdx, %rbx
	adcxq	%rdx, %r9
	adoxq	%rbp, %r9
	movq	$0, %rbp
	adoxq	%rbp, %rbx
	movq	%r10, %rdx
	mulxq	%r11, %rdx, %r12
	adcxq	%rdx, %rbx
	adcxq	%rbp, %r12
	movq	%r13, %rdx
	mulxq	%r13, %r13, %rdx
	adcxq	%rdi, %rdi
	adoxq	%rdx, %rdi
	movq	%rsi, %rdx
	mulxq	%rsi, %rsi, %rdx
	adcxq	%rcx, %rcx
	adoxq	%rsi, %rcx
	adcxq	%r8, %r8
	adoxq	%rdx, %r8
	movq	%r10, %rdx
	mulxq	%r10, %rsi, %rdx
	adcxq	%r9, %r9
	adoxq	%rsi, %r9
	adcxq	%rbx, %rbx
	adoxq	%rdx, %rbx
	movq	%r11, %rdx
	mulxq	%r11, %rsi, %rdx
	adcxq	%r12, %r12
	adoxq	%rsi, %r12
	adcxq	%rbp, %rbp
	adoxq	%rdx, %rbp
	movq	$38, %rdx
	mulxq	%rbp, %r10, %rsi
	imulq	$38, %rsi, %rsi
	adcxq	%rsi, %r13
	movq	%rdi, %rsi
	mulxq	%r9, %r9, %rdi
	adcxq	%r9, %r13
	adcxq	%rdi, %rsi
	mulxq	%rbx, %r9, %rdi
	adoxq	%r9, %rsi
	adoxq	%rdi, %rcx
	movq	%r8, %rdi
	mulxq	%r12, %r8, %rdx
	adcxq	%r8, %rcx
	adcxq	%rdx, %rdi
	adoxq	%r10, %rdi
	movq	$0, %rdx
	movq	$0, %r8
	adcxq	%rdx, %r8
	adoxq	%rdx, %r8
	shlq	$1, %r8
	shlq	$1, %rdi
	adcxq	%rdx, %r8
	shrq	$1, %rdi
	imulq	$19, %r8, %r8
	adcxq	%r8, %r13
	adcxq	%rdx, %rsi
	adcxq	%rdx, %rcx
	adcxq	%rdx, %rdi
	decq	%rax
	movq	$0, %rdx
	xorq	%rdx, %rdx
	movq	%r13, %rdx
	mulxq	%rsi, %r9, %r8
	mulxq	%rcx, %r10, %r11
	adcxq	%r10, %r8
	mulxq	%rdi, %rdx, %r10
	adcxq	%rdx, %r11
	movq	%rsi, %rdx
	mulxq	%rcx, %rbx, %rbp
	adoxq	%rbx, %r11
	mulxq	%rdi, %rdx, %rbx
	adcxq	%rdx, %r10
	adoxq	%rbp, %r10
	movq	$0, %rbp
	adoxq	%rbp, %rbx
	movq	%rcx, %rdx
	mulxq	%rdi, %rdx, %r12
	adcxq	%rdx, %rbx
	adcxq	%rbp, %r12
	movq	%r13, %rdx
	mulxq	%r13, %r13, %rdx
	adcxq	%r9, %r9
	adoxq	%rdx, %r9
	movq	%rsi, %rdx
	mulxq	%rsi, %rsi, %rdx
	adcxq	%r8, %r8
	adoxq	%rsi, %r8
	adcxq	%r11, %r11
	adoxq	%rdx, %r11
	movq	%rcx, %rdx
	mulxq	%rcx, %rdx, %rcx
	adcxq	%r10, %r10
	adoxq	%rdx, %r10
	adcxq	%rbx, %rbx
	adoxq	%rcx, %rbx
	movq	%rdi, %rdx
	mulxq	%rdi, %rdx, %rcx
	adcxq	%r12, %r12
	adoxq	%rdx, %r12
	adcxq	%rbp, %rbp
	adoxq	%rcx, %rbp
	movq	$38, %rdx
	mulxq	%rbp, %rdi, %rcx
	imulq	$38, %rcx, %rcx
	adcxq	%rcx, %r13
	movq	%r9, %rsi
	mulxq	%r10, %r9, %rcx
	adcxq	%r9, %r13
	adcxq	%rcx, %rsi
	movq	%r8, %r10
	mulxq	%rbx, %r8, %rcx
	adoxq	%r8, %rsi
	adoxq	%rcx, %r10
	mulxq	%r12, %rdx, %rcx
	adcxq	%rdx, %r10
	adcxq	%rcx, %r11
	adoxq	%rdi, %r11
	movq	$0, %rcx
	movq	$0, %rdx
	adcxq	%rcx, %rdx
	adoxq	%rcx, %rdx
	shlq	$1, %rdx
	shlq	$1, %r11
	adcxq	%rcx, %rdx
	shrq	$1, %r11
	imulq	$19, %rdx, %rdx
	adcxq	%rdx, %r13
	adcxq	%rcx, %rsi
	adcxq	%rcx, %r10
	adcxq	%rcx, %r11
	decq	%rax
	jne 	Lfe64_invert_regs$5
	movq	$0, %rax
	xorq	%rax, %rax
	movq	64(%rsp), %rdx
	mulxq	%r13, %rdi, %rcx
	mulxq	%rsi, %r9, %r8
	adcxq	%r9, %rcx
	mulxq	%r10, %rbp, %r9
	adcxq	%rbp, %r8
	mulxq	%r11, %rdx, %rbp
	adcxq	%rdx, %r9
	adcxq	%rax, %rbp
	movq	72(%rsp), %rdx
	mulxq	%r13, %r12, %rbx
	adoxq	%r12, %rcx
	adcxq	%rbx, %r8
	mulxq	%rsi, %r12, %rbx
	adoxq	%r12, %r8
	adcxq	%rbx, %r9
	mulxq	%r10, %r12, %rbx
	adoxq	%r12, %r9
	adcxq	%rbx, %rbp
	mulxq	%r11, %rdx, %rbx
	adoxq	%rdx, %rbp
	adcxq	%rax, %rbx
	adoxq	%rax, %rbx
	movq	80(%rsp), %rdx
	mulxq	%r13, %r14, %r12
	adoxq	%r14, %r8
	adcxq	%r12, %r9
	mulxq	%rsi, %r14, %r12
	adoxq	%r14, %r9
	adcxq	%r12, %rbp
	mulxq	%r10, %r14, %r12
	adoxq	%r14, %rbp
	adcxq	%r12, %rbx
	mulxq	%r11, %rdx, %r12
	adoxq	%rdx, %rbx
	adcxq	%rax, %r12
	adoxq	%rax, %r12
	movq	88(%rsp), %rdx
	mulxq	%r13, %r14, %r13
	adoxq	%r14, %r9
	adcxq	%r13, %rbp
	mulxq	%rsi, %r13, %rsi
	adoxq	%r13, %rbp
	adcxq	%rsi, %rbx
	mulxq	%r10, %r10, %rsi
	adoxq	%r10, %rbx
	adcxq	%rsi, %r12
	mulxq	%r11, %rdx, %rsi
	adoxq	%rdx, %r12
	adcxq	%rax, %rsi
	adoxq	%rax, %rsi
	movq	$38, %rdx
	mulxq	%rbp, %r11, %r10
	adoxq	%r11, %rdi
	adcxq	%r10, %rcx
	mulxq	%rbx, %r11, %r10
	adoxq	%r11, %rcx
	adcxq	%r10, %r8
	mulxq	%r12, %r11, %r10
	adoxq	%r11, %r8
	adcxq	%r10, %r9
	mulxq	%rsi, %rsi, %rdx
	adoxq	%rsi, %r9
	adcxq	%rax, %rdx
	adoxq	%rax, %rdx
	imulq	$38, %rdx, %rdx
	addq	%rdx, %rdi
	adcq	%rax, %rcx
	adcq	%rax, %r8
	adcq	%rax, %r9
	sbbq	%rax, %rax
	andq	$38, %rax
	leaq	(%rdi,%rax), %r13
	movq	%r13, 64(%rsp)
	movq	%rcx, 72(%rsp)
	movq	%r8, 80(%rsp)
	movq	%r9, 88(%rsp)
	movq	$50, %rax
Lfe64_invert_regs$4:
	movq	$0, %rdx
	xorq	%rdx, %rdx
	movq	%r13, %rdx
	mulxq	%rcx, %rdi, %rsi
	mulxq	%r8, %r11, %r10
	adcxq	%r11, %rsi
	mulxq	%r9, %rdx, %r11
	adcxq	%rdx, %r10
	movq	%rcx, %rdx
	mulxq	%r8, %rbx, %rbp
	adoxq	%rbx, %r10
	mulxq	%r9, %rdx, %rbx
	adcxq	%rdx, %r11
	adoxq	%rbp, %r11
	movq	$0, %rbp
	adoxq	%rbp, %rbx
	movq	%r8, %rdx
	mulxq	%r9, %rdx, %r12
	adcxq	%rdx, %rbx
	adcxq	%rbp, %r12
	movq	%r13, %rdx
	mulxq	%r13, %r13, %rdx
	adcxq	%rdi, %rdi
	adoxq	%rdx, %rdi
	movq	%rcx, %rdx
	mulxq	%rcx, %rdx, %rcx
	adcxq	%rsi, %rsi
	adoxq	%rdx, %rsi
	adcxq	%r10, %r10
	adoxq	%rcx, %r10
	movq	%r8, %rdx
	mulxq	%r8, %rdx, %rcx
	adcxq	%r11, %r11
	adoxq	%rdx, %r11
	adcxq	%rbx, %rbx
	adoxq	%rcx, %rbx
	movq	%r9, %rdx
	mulxq	%r9, %rdx, %rcx
	adcxq	%r12, %r12
	adoxq	%rdx, %r12
	adcxq	%rbp, %rbp
	adoxq	%rcx, %rbp
	movq	$38, %rdx
	mulxq	%rbp, %r8, %rcx
	imulq	$38, %rcx, %rcx
	adcxq	%rcx, %r13
	movq	%rdi, %rcx
	mulxq	%r11, %r9, %rdi
	adcxq	%r9, %r13
	adcxq	%rdi, %rcx
	mulxq	%rbx, %r9, %rdi
	adoxq	%r9, %rcx
	adoxq	%rdi, %rsi
	movq	%r10, %rdi
	mulxq	%r12, %r9, %rdx
	adcxq	%r9, %rsi
	adcxq	%rdx, %rdi
	adoxq	%r8, %rdi
	movq	$0, %rdx
	movq	$0, %r8
	adcxq	%rdx, %r8
	adoxq	%rdx, %r8
	shlq	$1, %r8
	shlq	$1, %rdi
	adcxq	%rdx, %r8
	shrq	$1, %rdi
	imulq	$19, %r8, %r8
	adcxq	%r8, %r13
	adcxq	%rdx, %rcx
	adcxq	%rdx, %rsi
	adcxq	%rdx, %rdi
	decq	%rax
	movq	$0, %rdx
	xorq	%rdx, %rdx
	movq	%r13, %rdx
	mulxq	%rcx, %r9, %r8
	mulxq	%rsi, %r11, %r10
	adcxq	%r11, %r8
	mulxq	%rdi, %rdx, %r11
	adcxq	%rdx, %r10
	movq	%rcx, %rdx
	mulxq	%rsi, %rbx, %rbp
	adoxq	%rbx, %r10
	mulxq	%rdi, %rdx, %rbx
	adcxq	%rdx, %r11
	adoxq	%rbp, %r11
	movq	$0, %rbp
	adoxq	%rbp, %rbx
	movq	%rsi, %rdx
	mulxq	%rdi, %rdx, %r12
	adcxq	%rdx, %rbx
	adcxq	%rbp, %r12
	movq	%r13, %rdx
	mulxq	%r13, %r13, %rdx
	adcxq	%r9, %r9
	adoxq	%rdx, %r9
	movq	%rcx, %rdx
	mulxq	%rcx, %rdx, %rcx
	adcxq	%r8, %r8
	adoxq	%rdx, %r8
	adcxq	%r10, %r10
	adoxq	%rcx, %r10
	movq	%rsi, %rdx
	mulxq	%rsi, %rdx, %rcx
	adcxq	%r11, %r11
	adoxq	%rdx, %r11
	adcxq	%rbx, %rbx
	adoxq	%rcx, %rbx
	movq	%rdi, %rdx
	mulxq	%rdi, %rdx, %rcx
	adcxq	%r12, %r12
	adoxq	%rdx, %r12
	adcxq	%rbp, %rbp
	adoxq	%rcx, %rbp
	movq	$38, %rdx
	mulxq	%rbp, %rsi, %rcx
	imulq	$38, %rcx, %rcx
	adcxq	%rcx, %r13
	movq	%r9, %rcx
	mulxq	%r11, %r9, %rdi
	adcxq	%r9, %r13
	adcxq	%rdi, %rcx
	mulxq	%rbx, %r9, %rdi
	adoxq	%r9, %rcx
	adoxq	%rdi, %r8
	movq	%r10, %r9
	mulxq	%r12, %rdi, %rdx
	adcxq	%rdi, %r8
	adcxq	%rdx, %r9
	adoxq	%rsi, %r9
	movq	$0, %rdx
	movq	$0, %rsi
	adcxq	%rdx, %rsi
	adoxq	%rdx, %rsi
	shlq	$1, %rsi
	shlq	$1, %r9
	adcxq	%rdx, %rsi
	shrq	$1, %r9
	imulq	$19, %rsi, %rsi
	adcxq	%rsi, %r13
	adcxq	%rdx, %rcx
	adcxq	%rdx, %r8
	adcxq	%rdx, %r9
	decq	%rax
	jne 	Lfe64_invert_regs$4
	movq	$0, %rax
	xorq	%rax, %rax
	movq	64(%rsp), %rdx
	mulxq	%r13, %rdi, %rsi
	mulxq	%rcx, %r11, %r10
	adcxq	%r11, %rsi
	mulxq	%r8, %rbp, %r11
	adcxq	%rbp, %r10
	mulxq	%r9, %rdx, %rbp
	adcxq	%rdx, %r11
	adcxq	%rax, %rbp
	movq	72(%rsp), %rdx
	mulxq	%r13, %r12, %rbx
	adoxq	%r12, %rsi
	adcxq	%rbx, %r10
	mulxq	%rcx, %r12, %rbx
	adoxq	%r12, %r10
	adcxq	%rbx, %r11
	mulxq	%r8, %r12, %rbx
	adoxq	%r12, %r11
	adcxq	%rbx, %rbp
	mulxq	%r9, %rdx, %rbx
	adoxq	%rdx, %rbp
	adcxq	%rax, %rbx
	adoxq	%rax, %rbx
	movq	80(%rsp), %rdx
	mulxq	%r13, %r14, %r12
	adoxq	%r14, %r10
	adcxq	%r12, %r11
	mulxq	%rcx, %r14, %r12
	adoxq	%r14, %r11
	adcxq	%r12, %rbp
	mulxq	%r8, %r14, %r12
	adoxq	%r14, %rbp
	adcxq	%r12, %rbx
	mulxq	%r9, %rdx, %r12
	adoxq	%rdx, %rbx
	adcxq	%rax, %r12
	adoxq	%rax, %r12
	movq	88(%rsp), %rdx
	mulxq	%r13, %r14, %r13
	adoxq	%r14, %r11
	adcxq	%r13, %rbp
	mulxq	%rcx, %r13, %rcx
	adoxq	%r13, %rbp
	adcxq	%rcx, %rbx
	mulxq	%r8, %r8, %rcx
	adoxq	%r8, %rbx
	adcxq	%rcx, %r12
	mulxq	%r9, %rdx, %rcx
	adoxq	%rdx, %r12
	adcxq	%rax, %rcx
	adoxq	%rax, %rcx
	movq	$38, %rdx
	mulxq	%rbp, %r9, %r8
	adoxq	%r9, %rdi
	adcxq	%r8, %rsi
	mulxq	%rbx, %r9, %r8
	adoxq	%r9, %rsi
	adcxq	%r8, %r10
	mulxq	%r12, %r9, %r8
	adoxq	%r9, %r10
	adcxq	%r8, %r11
	mulxq	%rcx, %rdx, %rcx
	adoxq	%rdx, %r11
	adcxq	%rax, %rcx
	adoxq	%rax, %rcx
	imulq	$38, %rcx, %rcx
	addq	%rcx, %rdi
	adcq	%rax, %rsi
	adcq	%rax, %r10
	adcq	%rax, %r11
	sbbq	%rax, %rax
	andq	$38, %rax
	leaq	(%rdi,%rax), %r13
	movq	%r13, 32(%rsp)
	movq	%rsi, 40(%rsp)
	movq	%r10, 48(%rsp)
	movq	%r11, 56(%rsp)
	movq	$100, %rax
Lfe64_invert_regs$3:
	movq	$0, %rcx
	xorq	%rcx, %rcx
	movq	%r13, %rdx
	mulxq	%rsi, %rdi, %rcx
	mulxq	%r10, %r9, %r8
	adcxq	%r9, %rcx
	mulxq	%r11, %rdx, %r9
	adcxq	%rdx, %r8
	movq	%rsi, %rdx
	mulxq	%r10, %rbx, %rbp
	adoxq	%rbx, %r8
	mulxq	%r11, %rdx, %rbx
	adcxq	%rdx, %r9
	adoxq	%rbp, %r9
	movq	$0, %rbp
	adoxq	%rbp, %rbx
	movq	%r10, %rdx
	mulxq	%r11, %rdx, %r12
	adcxq	%rdx, %rbx
	adcxq	%rbp, %r12
	movq	%r13, %rdx
	mulxq	%r13, %r13, %rdx
	adcxq	%rdi, %rdi
	adoxq	%rdx, %rdi
	movq	%rsi, %rdx
	mulxq	%rsi, %rsi, %rdx
	adcxq	%rcx, %rcx
	adoxq	%rsi, %rcx
	adcxq	%r8, %r8
	adoxq	%rdx, %r8
	movq	%r10, %rdx
	mulxq	%r10, %rsi, %rdx
	adcxq	%r9, %r9
	adoxq	%rsi, %r9
	adcxq	%rbx, %rbx
	adoxq	%rdx, %rbx
	movq	%r11, %rdx
	mulxq	%r11, %rsi, %rdx
	adcxq	%r12, %r12
	adoxq	%rsi, %r12
	adcxq	%rbp, %rbp
	adoxq	%rdx, %rbp
	movq	$38, %rdx
	mulxq	%rbp, %r10, %rsi
	imulq	$38, %rsi, %rsi
	adcxq	%rsi, %r13
	movq	%rdi, %rsi
	mulxq	%r9, %r9, %rdi
	adcxq	%r9, %r13
	adcxq	%rdi, %rsi
	mulxq	%rbx, %r9, %rdi
	adoxq	%r9, %rsi
	adoxq	%rdi, %rcx
	movq	%r8, %rdi
	mulxq	%r12, %r8, %rdx
	adcxq	%r8, %rcx
	adcxq	%rdx, %rdi
	adoxq	%r10, %rdi
	movq	$0, %rdx
	movq	$0, %r8
	adcxq	%rdx, %r8
	adoxq	%rdx, %r8
	shlq	$1, %r8
	shlq	$1, %rdi
	adcxq	%rdx, %r8
	shrq	$1, %rdi
	imulq	$19, %r8, %r8
	adcxq	%r8, %r13
	adcxq	%rdx, %rsi
	adcxq	%rdx, %rcx
	adcxq	%rdx, %rdi
	decq	%rax
	movq	$0, %rdx
	xorq	%rdx, %rdx
	movq	%r13, %rdx
	mulxq	%rsi, %r9, %r8
	mulxq	%rcx, %r10, %r11
	adcxq	%r10, %r8
	mulxq	%rdi, %rdx, %r10
	adcxq	%rdx, %r11
	movq	%rsi, %rdx
	mulxq	%rcx, %rbx, %rbp
	adoxq	%rbx, %r11
	mulxq	%rdi, %rdx, %rbx
	adcxq	%rdx, %r10
	adoxq	%rbp, %r10
	movq	$0, %rbp
	adoxq	%rbp, %rbx
	movq	%rcx, %rdx
	mulxq	%rdi, %rdx, %r12
	adcxq	%rdx, %rbx
	adcxq	%rbp, %r12
	movq	%r13, %rdx
	mulxq	%r13, %r13, %rdx
	adcxq	%r9, %r9
	adoxq	%rdx, %r9
	movq	%rsi, %rdx
	mulxq	%rsi, %rsi, %rdx
	adcxq	%r8, %r8
	adoxq	%rsi, %r8
	adcxq	%r11, %r11
	adoxq	%rdx, %r11
	movq	%rcx, %rdx
	mulxq	%rcx, %rdx, %rcx
	adcxq	%r10, %r10
	adoxq	%rdx, %r10
	adcxq	%rbx, %rbx
	adoxq	%rcx, %rbx
	movq	%rdi, %rdx
	mulxq	%rdi, %rdx, %rcx
	adcxq	%r12, %r12
	adoxq	%rdx, %r12
	adcxq	%rbp, %rbp
	adoxq	%rcx, %rbp
	movq	$38, %rdx
	mulxq	%rbp, %rdi, %rcx
	imulq	$38, %rcx, %rcx
	adcxq	%rcx, %r13
	movq	%r9, %rsi
	mulxq	%r10, %r9, %rcx
	adcxq	%r9, %r13
	adcxq	%rcx, %rsi
	movq	%r8, %r10
	mulxq	%rbx, %r8, %rcx
	adoxq	%r8, %rsi
	adoxq	%rcx, %r10
	mulxq	%r12, %rdx, %rcx
	adcxq	%rdx, %r10
	adcxq	%rcx, %r11
	adoxq	%rdi, %r11
	movq	$0, %rcx
	movq	$0, %rdx
	adcxq	%rcx, %rdx
	adoxq	%rcx, %rdx
	shlq	$1, %rdx
	shlq	$1, %r11
	adcxq	%rcx, %rdx
	shrq	$1, %r11
	imulq	$19, %rdx, %rdx
	adcxq	%rdx, %r13
	adcxq	%rcx, %rsi
	adcxq	%rcx, %r10
	adcxq	%rcx, %r11
	decq	%rax
	jne 	Lfe64_invert_regs$3
	movq	$0, %rax
	xorq	%rax, %rax
	movq	32(%rsp), %rdx
	mulxq	%r13, %rdi, %rcx
	mulxq	%rsi, %r9, %r8
	adcxq	%r9, %rcx
	mulxq	%r10, %rbp, %r9
	adcxq	%rbp, %r8
	mulxq	%r11, %rdx, %rbp
	adcxq	%rdx, %r9
	adcxq	%rax, %rbp
	movq	40(%rsp), %rdx
	mulxq	%r13, %r12, %rbx
	adoxq	%r12, %rcx
	adcxq	%rbx, %r8
	mulxq	%rsi, %r12, %rbx
	adoxq	%r12, %r8
	adcxq	%rbx, %r9
	mulxq	%r10, %r12, %rbx
	adoxq	%r12, %r9
	adcxq	%rbx, %rbp
	mulxq	%r11, %rdx, %rbx
	adoxq	%rdx, %rbp
	adcxq	%rax, %rbx
	adoxq	%rax, %rbx
	movq	48(%rsp), %rdx
	mulxq	%r13, %r14, %r12
	adoxq	%r14, %r8
	adcxq	%r12, %r9
	mulxq	%rsi, %r14, %r12
	adoxq	%r14, %r9
	adcxq	%r12, %rbp
	mulxq	%r10, %r14, %r12
	adoxq	%r14, %rbp
	adcxq	%r12, %rbx
	mulxq	%r11, %rdx, %r12
	adoxq	%rdx, %rbx
	adcxq	%rax, %r12
	adoxq	%rax, %r12
	movq	56(%rsp), %rdx
	mulxq	%r13, %r14, %r13
	adoxq	%r14, %r9
	adcxq	%r13, %rbp
	mulxq	%rsi, %r13, %rsi
	adoxq	%r13, %rbp
	adcxq	%rsi, %rbx
	mulxq	%r10, %r10, %rsi
	adoxq	%r10, %rbx
	adcxq	%rsi, %r12
	mulxq	%r11, %rdx, %rsi
	adoxq	%rdx, %r12
	adcxq	%rax, %rsi
	adoxq	%rax, %rsi
	movq	$38, %rdx
	mulxq	%rbp, %r11, %r10
	adoxq	%r11, %rdi
	adcxq	%r10, %rcx
	mulxq	%rbx, %r11, %r10
	adoxq	%r11, %rcx
	adcxq	%r10, %r8
	mulxq	%r12, %r11, %r10
	adoxq	%r11, %r8
	adcxq	%r10, %r9
	mulxq	%rsi, %rsi, %rdx
	adoxq	%rsi, %r9
	adcxq	%rax, %rdx
	adoxq	%rax, %rdx
	imulq	$38, %rdx, %rdx
	addq	%rdx, %rdi
	adcq	%rax, %rcx
	adcq	%rax, %r8
	adcq	%rax, %r9
	sbbq	%rax, %rax
	andq	$38, %rax
	leaq	(%rdi,%rax), %r13
	movq	$50, %rax
Lfe64_invert_regs$2:
	movq	$0, %rdx
	xorq	%rdx, %rdx
	movq	%r13, %rdx
	mulxq	%rcx, %rdi, %rsi
	mulxq	%r8, %r11, %r10
	adcxq	%r11, %rsi
	mulxq	%r9, %rdx, %r11
	adcxq	%rdx, %r10
	movq	%rcx, %rdx
	mulxq	%r8, %rbx, %rbp
	adoxq	%rbx, %r10
	mulxq	%r9, %rdx, %rbx
	adcxq	%rdx, %r11
	adoxq	%rbp, %r11
	movq	$0, %rbp
	adoxq	%rbp, %rbx
	movq	%r8, %rdx
	mulxq	%r9, %rdx, %r12
	adcxq	%rdx, %rbx
	adcxq	%rbp, %r12
	movq	%r13, %rdx
	mulxq	%r13, %r13, %rdx
	adcxq	%rdi, %rdi
	adoxq	%rdx, %rdi
	movq	%rcx, %rdx
	mulxq	%rcx, %rdx, %rcx
	adcxq	%rsi, %rsi
	adoxq	%rdx, %rsi
	adcxq	%r10, %r10
	adoxq	%rcx, %r10
	movq	%r8, %rdx
	mulxq	%r8, %rdx, %rcx
	adcxq	%r11, %r11
	adoxq	%rdx, %r11
	adcxq	%rbx, %rbx
	adoxq	%rcx, %rbx
	movq	%r9, %rdx
	mulxq	%r9, %rdx, %rcx
	adcxq	%r12, %r12
	adoxq	%rdx, %r12
	adcxq	%rbp, %rbp
	adoxq	%rcx, %rbp
	movq	$38, %rdx
	mulxq	%rbp, %r8, %rcx
	imulq	$38, %rcx, %rcx
	adcxq	%rcx, %r13
	movq	%rdi, %rcx
	mulxq	%r11, %r9, %rdi
	adcxq	%r9, %r13
	adcxq	%rdi, %rcx
	mulxq	%rbx, %r9, %rdi
	adoxq	%r9, %rcx
	adoxq	%rdi, %rsi
	movq	%r10, %rdi
	mulxq	%r12, %r9, %rdx
	adcxq	%r9, %rsi
	adcxq	%rdx, %rdi
	adoxq	%r8, %rdi
	movq	$0, %rdx
	movq	$0, %r8
	adcxq	%rdx, %r8
	adoxq	%rdx, %r8
	shlq	$1, %r8
	shlq	$1, %rdi
	adcxq	%rdx, %r8
	shrq	$1, %rdi
	imulq	$19, %r8, %r8
	adcxq	%r8, %r13
	adcxq	%rdx, %rcx
	adcxq	%rdx, %rsi
	adcxq	%rdx, %rdi
	decq	%rax
	movq	$0, %rdx
	xorq	%rdx, %rdx
	movq	%r13, %rdx
	mulxq	%rcx, %r9, %r8
	mulxq	%rsi, %r11, %r10
	adcxq	%r11, %r8
	mulxq	%rdi, %rdx, %r11
	adcxq	%rdx, %r10
	movq	%rcx, %rdx
	mulxq	%rsi, %rbx, %rbp
	adoxq	%rbx, %r10
	mulxq	%rdi, %rdx, %rbx
	adcxq	%rdx, %r11
	adoxq	%rbp, %r11
	movq	$0, %rbp
	adoxq	%rbp, %rbx
	movq	%rsi, %rdx
	mulxq	%rdi, %rdx, %r12
	adcxq	%rdx, %rbx
	adcxq	%rbp, %r12
	movq	%r13, %rdx
	mulxq	%r13, %r13, %rdx
	adcxq	%r9, %r9
	adoxq	%rdx, %r9
	movq	%rcx, %rdx
	mulxq	%rcx, %rdx, %rcx
	adcxq	%r8, %r8
	adoxq	%rdx, %r8
	adcxq	%r10, %r10
	adoxq	%rcx, %r10
	movq	%rsi, %rdx
	mulxq	%rsi, %rdx, %rcx
	adcxq	%r11, %r11
	adoxq	%rdx, %r11
	adcxq	%rbx, %rbx
	adoxq	%rcx, %rbx
	movq	%rdi, %rdx
	mulxq	%rdi, %rdx, %rcx
	adcxq	%r12, %r12
	adoxq	%rdx, %r12
	adcxq	%rbp, %rbp
	adoxq	%rcx, %rbp
	movq	$38, %rdx
	mulxq	%rbp, %rsi, %rcx
	imulq	$38, %rcx, %rcx
	adcxq	%rcx, %r13
	movq	%r9, %rcx
	mulxq	%r11, %r9, %rdi
	adcxq	%r9, %r13
	adcxq	%rdi, %rcx
	mulxq	%rbx, %r9, %rdi
	adoxq	%r9, %rcx
	adoxq	%rdi, %r8
	movq	%r10, %r9
	mulxq	%r12, %rdi, %rdx
	adcxq	%rdi, %r8
	adcxq	%rdx, %r9
	adoxq	%rsi, %r9
	movq	$0, %rdx
	movq	$0, %rsi
	adcxq	%rdx, %rsi
	adoxq	%rdx, %rsi
	shlq	$1, %rsi
	shlq	$1, %r9
	adcxq	%rdx, %rsi
	shrq	$1, %r9
	imulq	$19, %rsi, %rsi
	adcxq	%rsi, %r13
	adcxq	%rdx, %rcx
	adcxq	%rdx, %r8
	adcxq	%rdx, %r9
	decq	%rax
	jne 	Lfe64_invert_regs$2
	movq	$0, %rax
	xorq	%rax, %rax
	movq	64(%rsp), %rdx
	mulxq	%r13, %rdi, %rsi
	mulxq	%rcx, %r11, %r10
	adcxq	%r11, %rsi
	mulxq	%r8, %rbp, %r11
	adcxq	%rbp, %r10
	mulxq	%r9, %rdx, %rbp
	adcxq	%rdx, %r11
	adcxq	%rax, %rbp
	movq	72(%rsp), %rdx
	mulxq	%r13, %r12, %rbx
	adoxq	%r12, %rsi
	adcxq	%rbx, %r10
	mulxq	%rcx, %r12, %rbx
	adoxq	%r12, %r10
	adcxq	%rbx, %r11
	mulxq	%r8, %r12, %rbx
	adoxq	%r12, %r11
	adcxq	%rbx, %rbp
	mulxq	%r9, %rdx, %rbx
	adoxq	%rdx, %rbp
	adcxq	%rax, %rbx
	adoxq	%rax, %rbx
	movq	80(%rsp), %rdx
	mulxq	%r13, %r14, %r12
	adoxq	%r14, %r10
	adcxq	%r12, %r11
	mulxq	%rcx, %r14, %r12
	adoxq	%r14, %r11
	adcxq	%r12, %rbp
	mulxq	%r8, %r14, %r12
	adoxq	%r14, %rbp
	adcxq	%r12, %rbx
	mulxq	%r9, %rdx, %r12
	adoxq	%rdx, %rbx
	adcxq	%rax, %r12
	adoxq	%rax, %r12
	movq	88(%rsp), %rdx
	mulxq	%r13, %r14, %r13
	adoxq	%r14, %r11
	adcxq	%r13, %rbp
	mulxq	%rcx, %r13, %rcx
	adoxq	%r13, %rbp
	adcxq	%rcx, %rbx
	mulxq	%r8, %r8, %rcx
	adoxq	%r8, %rbx
	adcxq	%rcx, %r12
	mulxq	%r9, %rdx, %rcx
	adoxq	%rdx, %r12
	adcxq	%rax, %rcx
	adoxq	%rax, %rcx
	movq	$38, %rdx
	mulxq	%rbp, %r9, %r8
	adoxq	%r9, %rdi
	adcxq	%r8, %rsi
	mulxq	%rbx, %r9, %r8
	adoxq	%r9, %rsi
	adcxq	%r8, %r10
	mulxq	%r12, %r9, %r8
	adoxq	%r9, %r10
	adcxq	%r8, %r11
	mulxq	%rcx, %rdx, %rcx
	adoxq	%rdx, %r11
	adcxq	%rax, %rcx
	adoxq	%rax, %rcx
	imulq	$38, %rcx, %rcx
	addq	%rcx, %rdi
	adcq	%rax, %rsi
	adcq	%rax, %r10
	adcq	%rax, %r11
	sbbq	%rax, %rax
	andq	$38, %rax
	leaq	(%rdi,%rax), %r13
	movq	$4, %rax
Lfe64_invert_regs$1:
	movq	$0, %rcx
	xorq	%rcx, %rcx
	movq	%r13, %rdx
	mulxq	%rsi, %rdi, %rcx
	mulxq	%r10, %r9, %r8
	adcxq	%r9, %rcx
	mulxq	%r11, %rdx, %r9
	adcxq	%rdx, %r8
	movq	%rsi, %rdx
	mulxq	%r10, %rbx, %rbp
	adoxq	%rbx, %r8
	mulxq	%r11, %rdx, %rbx
	adcxq	%rdx, %r9
	adoxq	%rbp, %r9
	movq	$0, %rbp
	adoxq	%rbp, %rbx
	movq	%r10, %rdx
	mulxq	%r11, %rdx, %r12
	adcxq	%rdx, %rbx
	adcxq	%rbp, %r12
	movq	%r13, %rdx
	mulxq	%r13, %r13, %rdx
	adcxq	%rdi, %rdi
	adoxq	%rdx, %rdi
	movq	%rsi, %rdx
	mulxq	%rsi, %rsi, %rdx
	adcxq	%rcx, %rcx
	adoxq	%rsi, %rcx
	adcxq	%r8, %r8
	adoxq	%rdx, %r8
	movq	%r10, %rdx
	mulxq	%r10, %rsi, %rdx
	adcxq	%r9, %r9
	adoxq	%rsi, %r9
	adcxq	%rbx, %rbx
	adoxq	%rdx, %rbx
	movq	%r11, %rdx
	mulxq	%r11, %rsi, %rdx
	adcxq	%r12, %r12
	adoxq	%rsi, %r12
	adcxq	%rbp, %rbp
	adoxq	%rdx, %rbp
	movq	$38, %rdx
	mulxq	%rbp, %r10, %rsi
	imulq	$38, %rsi, %rsi
	adcxq	%rsi, %r13
	movq	%rdi, %rsi
	mulxq	%r9, %r9, %rdi
	adcxq	%r9, %r13
	adcxq	%rdi, %rsi
	mulxq	%rbx, %r9, %rdi
	adoxq	%r9, %rsi
	adoxq	%rdi, %rcx
	movq	%r8, %rdi
	mulxq	%r12, %r8, %rdx
	adcxq	%r8, %rcx
	adcxq	%rdx, %rdi
	adoxq	%r10, %rdi
	movq	$0, %rdx
	movq	$0, %r8
	adcxq	%rdx, %r8
	adoxq	%rdx, %r8
	shlq	$1, %r8
	shlq	$1, %rdi
	adcxq	%rdx, %r8
	shrq	$1, %rdi
	imulq	$19, %r8, %r8
	adcxq	%r8, %r13
	adcxq	%rdx, %rsi
	adcxq	%rdx, %rcx
	adcxq	%rdx, %rdi
	decq	%rax
	movq	$0, %rdx
	xorq	%rdx, %rdx
	movq	%r13, %rdx
	mulxq	%rsi, %r9, %r8
	mulxq	%rcx, %r10, %r11
	adcxq	%r10, %r8
	mulxq	%rdi, %rdx, %r10
	adcxq	%rdx, %r11
	movq	%rsi, %rdx
	mulxq	%rcx, %rbx, %rbp
	adoxq	%rbx, %r11
	mulxq	%rdi, %rdx, %rbx
	adcxq	%rdx, %r10
	adoxq	%rbp, %r10
	movq	$0, %rbp
	adoxq	%rbp, %rbx
	movq	%rcx, %rdx
	mulxq	%rdi, %rdx, %r12
	adcxq	%rdx, %rbx
	adcxq	%rbp, %r12
	movq	%r13, %rdx
	mulxq	%r13, %r13, %rdx
	adcxq	%r9, %r9
	adoxq	%rdx, %r9
	movq	%rsi, %rdx
	mulxq	%rsi, %rsi, %rdx
	adcxq	%r8, %r8
	adoxq	%rsi, %r8
	adcxq	%r11, %r11
	adoxq	%rdx, %r11
	movq	%rcx, %rdx
	mulxq	%rcx, %rdx, %rcx
	adcxq	%r10, %r10
	adoxq	%rdx, %r10
	adcxq	%rbx, %rbx
	adoxq	%rcx, %rbx
	movq	%rdi, %rdx
	mulxq	%rdi, %rdx, %rcx
	adcxq	%r12, %r12
	adoxq	%rdx, %r12
	adcxq	%rbp, %rbp
	adoxq	%rcx, %rbp
	movq	$38, %rdx
	mulxq	%rbp, %rdi, %rcx
	imulq	$38, %rcx, %rcx
	adcxq	%rcx, %r13
	movq	%r9, %rsi
	mulxq	%r10, %r9, %rcx
	adcxq	%r9, %r13
	adcxq	%rcx, %rsi
	movq	%r8, %r10
	mulxq	%rbx, %r8, %rcx
	adoxq	%r8, %rsi
	adoxq	%rcx, %r10
	mulxq	%r12, %rdx, %rcx
	adcxq	%rdx, %r10
	adcxq	%rcx, %r11
	adoxq	%rdi, %r11
	movq	$0, %rcx
	movq	$0, %rdx
	adcxq	%rcx, %rdx
	adoxq	%rcx, %rdx
	shlq	$1, %rdx
	shlq	$1, %r11
	adcxq	%rcx, %rdx
	shrq	$1, %r11
	imulq	$19, %rdx, %rdx
	adcxq	%rdx, %r13
	adcxq	%rcx, %rsi
	adcxq	%rcx, %r10
	adcxq	%rcx, %r11
	decq	%rax
	jne 	Lfe64_invert_regs$1
	movq	$0, %rax
	xorq	%rax, %rax
	movq	%r13, %rdx
	mulxq	%rsi, %rcx, %rax
	mulxq	%r10, %r8, %rdi
	adcxq	%r8, %rax
	mulxq	%r11, %rdx, %r8
	adcxq	%rdx, %rdi
	movq	%rsi, %rdx
	mulxq	%r10, %rbp, %r9
	adoxq	%rbp, %rdi
	mulxq	%r11, %rdx, %rbp
	adcxq	%rdx, %r8
	adoxq	%r9, %r8
	movq	$0, %r9
	adoxq	%r9, %rbp
	movq	%r10, %rdx
	mulxq	%r11, %rdx, %rbx
	adcxq	%rdx, %rbp
	adcxq	%r9, %rbx
	movq	%r13, %rdx
	mulxq	%r13, %r12, %rdx
	adcxq	%rcx, %rcx
	adoxq	%rdx, %rcx
	movq	%rsi, %rdx
	mulxq	%rsi, %rsi, %rdx
	adcxq	%rax, %rax
	adoxq	%rsi, %rax
	adcxq	%rdi, %rdi
	adoxq	%rdx, %rdi
	movq	%r10, %rdx
	mulxq	%r10, %rsi, %rdx
	adcxq	%r8, %r8
	adoxq	%rsi, %r8
	adcxq	%rbp, %rbp
	adoxq	%rdx, %rbp
	movq	%r11, %rdx
	mulxq	%r11, %rsi, %rdx
	adcxq	%rbx, %rbx
	adoxq	%rsi, %rbx
	adcxq	%r9, %r9
	adoxq	%rdx, %r9
	movq	$38, %rdx
	mulxq	%r9, %r9, %rsi
	imulq	$38, %rsi, %rsi
	adcxq	%rsi, %r12
	mulxq	%r8, %r8, %rsi
	adcxq	%r8, %r12
	adcxq	%rsi, %rcx
	mulxq	%rbp, %r8, %rsi
	adoxq	%r8, %rcx
	adoxq	%rsi, %rax
	movq	%rdi, %rsi
	mulxq	%rbx, %rdi, %rdx
	adcxq	%rdi, %rax
	adcxq	%rdx, %rsi
	adoxq	%r9, %rsi
	movq	$0, %rdx
	movq	$0, %rdi
	adcxq	%rdx, %rdi
	adoxq	%rdx, %rdi
	shlq	$1, %rdi
	shlq	$1, %rsi
	adcxq	%rdx, %rdi
	shrq	$1, %rsi
	imulq	$19, %rdi, %rdi
	adcxq	%rdi, %r12
	adcxq	%rdx, %rcx
	adcxq	%rdx, %rax
	adcxq	%rdx, %rsi
	movq	$0, %rdi
	xorq	%rdi, %rdi
	movq	(%rsp), %rdx
	mulxq	%r12, %r9, %r8
	mulxq	%rcx, %r11, %r10
	adcxq	%r11, %r8
	mulxq	%rax, %rbp, %r11
	adcxq	%rbp, %r10
	mulxq	%rsi, %rdx, %rbp
	adcxq	%rdx, %r11
	adcxq	%rdi, %rbp
	movq	8(%rsp), %rdx
	mulxq	%r12, %r13, %rbx
	adoxq	%r13, %r8
	adcxq	%rbx, %r10
	mulxq	%rcx, %r13, %rbx
	adoxq	%r13, %r10
	adcxq	%rbx, %r11
	mulxq	%rax, %r13, %rbx
	adoxq	%r13, %r11
	adcxq	%rbx, %rbp
	mulxq	%rsi, %rdx, %rbx
	adoxq	%rdx, %rbp
	adcxq	%rdi, %rbx
	adoxq	%rdi, %rbx
	movq	16(%rsp), %rdx
	mulxq	%r12, %r14, %r13
	adoxq	%r14, %r10
	adcxq	%r13, %r11
	mulxq	%rcx, %r14, %r13
	adoxq	%r14, %r11
	adcxq	%r13, %rbp
	mulxq	%rax, %r14, %r13
	adoxq	%r14, %rbp
	adcxq	%r13, %rbx
	mulxq	%rsi, %rdx, %r13
	adoxq	%rdx, %rbx
	adcxq	%rdi, %r13
	adoxq	%rdi, %r13
	movq	24(%rsp), %rdx
	mulxq	%r12, %r14, %r12
	adoxq	%r14, %r11
	adcxq	%r12, %rbp
	mulxq	%rcx, %r12, %rcx
	adoxq	%r12, %rbp
	adcxq	%rcx, %rbx
	mulxq	%rax, %rcx, %rax
	adoxq	%rcx, %rbx
	adcxq	%rax, %r13
	mulxq	%rsi, %rcx, %rax
	adoxq	%rcx, %r13
	adcxq	%rdi, %rax
	adoxq	%rdi, %rax
	movq	$38, %rdx
	mulxq	%rbp, %rsi, %rcx
	adoxq	%rsi, %r9
	adcxq	%rcx, %r8
	mulxq	%rbx, %rsi, %rcx
	adoxq	%rsi, %r8
	adcxq	%rcx, %r10
	mulxq	%r13, %rsi, %rcx
	adoxq	%rsi, %r10
	adcxq	%rcx, %r11
	mulxq	%rax, %rcx, %rax
	adoxq	%rcx, %r11
	adcxq	%rdi, %rax
	adoxq	%rdi, %rax
	imulq	$38, %rax, %rax
	addq	%rax, %r9
	adcq	%rdi, %r8
	adcq	%rdi, %r10
	adcq	%rdi, %r11
	sbbq	%rdi, %rdi
	andq	$38, %rdi
	leaq	(%r9,%rdi), %rax
	movq	128(%rsp), %rcx
	movq	%rax, (%rcx)
	movq	%r8, 8(%rcx)
	movq	%r10, 16(%rcx)
	movq	%r11, 24(%rcx)
	addq	$136, %rsp
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	ret 

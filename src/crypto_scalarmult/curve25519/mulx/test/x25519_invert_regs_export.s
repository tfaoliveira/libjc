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
	movq	8(%rsi), %rcx
	movq	16(%rsi), %rdi
	movq	24(%rsi), %rsi
	movq	%rax, 96(%rsp)
	movq	%rcx, 104(%rsp)
	movq	%rdi, 112(%rsp)
	movq	%rsi, 120(%rsp)
	movq	$0, %rdx
	xorq	%rdx, %rdx
	movq	%rax, %rdx
	mulxq	%rcx, %r9, %r8
	mulxq	%rdi, %r11, %r10
	adcxq	%r11, %r8
	mulxq	%rsi, %rdx, %r11
	adcxq	%rdx, %r10
	movq	%rcx, %rdx
	mulxq	%rdi, %rbx, %rbp
	adoxq	%rbx, %r10
	mulxq	%rsi, %rdx, %rbx
	adcxq	%rdx, %r11
	adoxq	%rbp, %r11
	movq	$0, %rbp
	adoxq	%rbp, %rbx
	movq	%rdi, %rdx
	mulxq	%rsi, %rdx, %r12
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
	movq	%rdi, %rdx
	mulxq	%rdi, %rcx, %rax
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
	mulxq	%r11, %rdi, %rsi
	adoxq	%rdi, %r13
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
	adoxq	%rcx, %rcx
	sbbq	%rdx, %rdx
	andq	$38, %rdx
	negq	%rcx
	andq	$38, %rcx
	leaq	(%rdx,%rcx), %rdx
	shlq	$1, %rdi
	sbbq	%rcx, %rcx
	andq	$19, %rcx
	leaq	(%rdx,%rcx), %rcx
	shrq	$1, %rdi
	movq	$0, %rdx
	addq	%rcx, %r13
	adcxq	%rdx, %rax
	adcxq	%rdx, %rsi
	adcxq	%rdx, %rdi
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
	adoxq	%r8, %r12
	adcxq	%rdi, %rax
	mulxq	%rbp, %r8, %rdi
	adoxq	%r8, %rax
	adoxq	%rdi, %rcx
	movq	%r9, %rdi
	mulxq	%rbx, %r8, %rdx
	adcxq	%r8, %rcx
	adcxq	%rdx, %rdi
	adoxq	%rsi, %rdi
	movq	$0, %rsi
	adoxq	%rsi, %rsi
	sbbq	%rdx, %rdx
	andq	$38, %rdx
	negq	%rsi
	andq	$38, %rsi
	leaq	(%rdx,%rsi), %rdx
	shlq	$1, %rdi
	sbbq	%rsi, %rsi
	andq	$19, %rsi
	leaq	(%rdx,%rsi), %rdx
	shrq	$1, %rdi
	movq	$0, %rsi
	addq	%rdx, %r12
	adcxq	%rsi, %rax
	adcxq	%rsi, %rcx
	adcxq	%rsi, %rdi
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
	adoxq	%r8, %r12
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
	adoxq	%rcx, %rcx
	sbbq	%rdx, %rdx
	andq	$38, %rdx
	negq	%rcx
	andq	$38, %rcx
	leaq	(%rdx,%rcx), %rdx
	shlq	$1, %rdi
	sbbq	%rcx, %rcx
	andq	$19, %rcx
	leaq	(%rdx,%rcx), %rcx
	shrq	$1, %rdi
	movq	$0, %rdx
	addq	%rcx, %r12
	adcxq	%rdx, %rax
	adcxq	%rdx, %rsi
	adcxq	%rdx, %rdi
	movq	$0, %rcx
	xorq	%rcx, %rcx
	movq	96(%rsp), %rdx
	mulxq	%r12, %r8, %rcx
	mulxq	%rax, %r10, %r9
	adcxq	%r10, %rcx
	mulxq	%rsi, %r11, %r10
	adcxq	%r11, %r9
	mulxq	%rdi, %rdx, %r11
	adcxq	%rdx, %r10
	movq	$0, %rdx
	adcxq	%rdx, %r11
	movq	104(%rsp), %rdx
	mulxq	%r12, %rbx, %rbp
	adoxq	%rbx, %rcx
	adoxq	%rbp, %r9
	mulxq	%rsi, %rbx, %rbp
	adoxq	%rbx, %r10
	adoxq	%rbp, %r11
	movq	$0, %rbp
	adoxq	%rbp, %rbp
	mulxq	%rax, %r13, %rbx
	adcxq	%r13, %r9
	adcxq	%rbx, %r10
	mulxq	%rdi, %rbx, %rdx
	adcxq	%rbx, %r11
	adcxq	%rdx, %rbp
	movq	112(%rsp), %rdx
	mulxq	%r12, %r13, %rbx
	adoxq	%r13, %r9
	adoxq	%rbx, %r10
	mulxq	%rsi, %r13, %rbx
	adoxq	%r13, %r11
	adoxq	%rbx, %rbp
	movq	$0, %rbx
	adoxq	%rbx, %rbx
	mulxq	%rax, %r14, %r13
	adcxq	%r14, %r10
	adcxq	%r13, %r11
	mulxq	%rdi, %r13, %rdx
	adcxq	%r13, %rbp
	adcxq	%rdx, %rbx
	movq	120(%rsp), %rdx
	mulxq	%r12, %r13, %r12
	adoxq	%r13, %r10
	adoxq	%r12, %r11
	mulxq	%rsi, %r12, %rsi
	adoxq	%r12, %rbp
	adoxq	%rsi, %rbx
	movq	$0, %rsi
	adoxq	%rsi, %rsi
	mulxq	%rax, %r12, %rax
	adcxq	%r12, %r11
	adcxq	%rax, %rbp
	mulxq	%rdi, %rdx, %rax
	adcxq	%rdx, %rbx
	adcxq	%rax, %rsi
	movq	$0, %rax
	movq	$38, %rdx
	mulxq	%rsi, %rdi, %rsi
	adcxq	%rax, %rsi
	imulq	$38, %rsi, %rsi
	adcxq	%rsi, %r8
	mulxq	%r11, %r11, %rsi
	adoxq	%r11, %r8
	adcxq	%rsi, %rcx
	mulxq	%rbp, %r11, %rsi
	adoxq	%r11, %rcx
	adoxq	%rsi, %r9
	mulxq	%rbx, %rsi, %rdx
	adcxq	%rsi, %r9
	adcxq	%rdx, %r10
	adoxq	%rdi, %r10
	adoxq	%rax, %rax
	sbbq	%rdx, %rdx
	andq	$38, %rdx
	negq	%rax
	andq	$38, %rax
	leaq	(%rdx,%rax), %rdx
	shlq	$1, %r10
	sbbq	%rax, %rax
	andq	$19, %rax
	leaq	(%rdx,%rax), %rax
	shrq	$1, %r10
	movq	$0, %rdx
	addq	%rax, %r8
	adcxq	%rdx, %rcx
	adcxq	%rdx, %r9
	adcxq	%rdx, %r10
	movq	%r8, 64(%rsp)
	movq	%rcx, 72(%rsp)
	movq	%r9, 80(%rsp)
	movq	%r10, 88(%rsp)
	movq	$0, %rax
	xorq	%rax, %rax
	movq	(%rsp), %rdx
	mulxq	%r8, %rsi, %rax
	mulxq	%rcx, %r11, %rdi
	adcxq	%r11, %rax
	mulxq	%r9, %rbp, %r11
	adcxq	%rbp, %rdi
	mulxq	%r10, %rdx, %rbp
	adcxq	%rdx, %r11
	movq	$0, %rdx
	adcxq	%rdx, %rbp
	movq	8(%rsp), %rdx
	mulxq	%r8, %r12, %rbx
	adoxq	%r12, %rax
	adoxq	%rbx, %rdi
	mulxq	%r9, %r12, %rbx
	adoxq	%r12, %r11
	adoxq	%rbx, %rbp
	movq	$0, %rbx
	adoxq	%rbx, %rbx
	mulxq	%rcx, %r13, %r12
	adcxq	%r13, %rdi
	adcxq	%r12, %r11
	mulxq	%r10, %r12, %rdx
	adcxq	%r12, %rbp
	adcxq	%rdx, %rbx
	movq	16(%rsp), %rdx
	mulxq	%r8, %r13, %r12
	adoxq	%r13, %rdi
	adoxq	%r12, %r11
	mulxq	%r9, %r13, %r12
	adoxq	%r13, %rbp
	adoxq	%r12, %rbx
	movq	$0, %r12
	adoxq	%r12, %r12
	mulxq	%rcx, %r14, %r13
	adcxq	%r14, %r11
	adcxq	%r13, %rbp
	mulxq	%r10, %r13, %rdx
	adcxq	%r13, %rbx
	adcxq	%rdx, %r12
	movq	24(%rsp), %rdx
	mulxq	%r8, %r13, %r8
	adoxq	%r13, %r11
	adoxq	%r8, %rbp
	mulxq	%r9, %r9, %r8
	adoxq	%r9, %rbx
	adoxq	%r8, %r12
	movq	$0, %r8
	adoxq	%r8, %r8
	mulxq	%rcx, %r9, %rcx
	adcxq	%r9, %rbp
	adcxq	%rcx, %rbx
	mulxq	%r10, %rdx, %rcx
	adcxq	%rdx, %r12
	adcxq	%rcx, %r8
	movq	$0, %rcx
	movq	$38, %rdx
	mulxq	%r8, %r9, %r8
	adcxq	%rcx, %r8
	imulq	$38, %r8, %r8
	adcxq	%r8, %rsi
	mulxq	%rbp, %r10, %r8
	adoxq	%r10, %rsi
	adcxq	%r8, %rax
	mulxq	%rbx, %r10, %r8
	adoxq	%r10, %rax
	adoxq	%r8, %rdi
	mulxq	%r12, %r8, %rdx
	adcxq	%r8, %rdi
	adcxq	%rdx, %r11
	adoxq	%r9, %r11
	adoxq	%rcx, %rcx
	sbbq	%rdx, %rdx
	andq	$38, %rdx
	negq	%rcx
	andq	$38, %rcx
	leaq	(%rdx,%rcx), %rdx
	shlq	$1, %r11
	sbbq	%rcx, %rcx
	andq	$19, %rcx
	leaq	(%rdx,%rcx), %rcx
	shrq	$1, %r11
	movq	$0, %rdx
	addq	%rcx, %rsi
	adcxq	%rdx, %rax
	adcxq	%rdx, %rdi
	adcxq	%rdx, %r11
	movq	%rsi, (%rsp)
	movq	%rax, 8(%rsp)
	movq	%rdi, 16(%rsp)
	movq	%r11, 24(%rsp)
	movq	$0, %rcx
	xorq	%rcx, %rcx
	movq	%rsi, %rdx
	mulxq	%rax, %r8, %rcx
	mulxq	%rdi, %r10, %r9
	adcxq	%r10, %rcx
	mulxq	%r11, %rdx, %r10
	adcxq	%rdx, %r9
	movq	%rax, %rdx
	mulxq	%rdi, %rbx, %rbp
	adoxq	%rbx, %r9
	mulxq	%r11, %rdx, %rbx
	adcxq	%rdx, %r10
	adoxq	%rbp, %r10
	movq	$0, %rbp
	adoxq	%rbp, %rbx
	movq	%rdi, %rdx
	mulxq	%r11, %rdx, %r12
	adcxq	%rdx, %rbx
	adcxq	%rbp, %r12
	movq	%rsi, %rdx
	mulxq	%rsi, %rsi, %rdx
	adcxq	%r8, %r8
	adoxq	%rdx, %r8
	movq	%rax, %rdx
	mulxq	%rax, %rdx, %rax
	adcxq	%rcx, %rcx
	adoxq	%rdx, %rcx
	adcxq	%r9, %r9
	adoxq	%rax, %r9
	movq	%rdi, %rdx
	mulxq	%rdi, %rdx, %rax
	adcxq	%r10, %r10
	adoxq	%rdx, %r10
	adcxq	%rbx, %rbx
	adoxq	%rax, %rbx
	movq	%r11, %rdx
	mulxq	%r11, %rdx, %rax
	adcxq	%r12, %r12
	adoxq	%rdx, %r12
	adcxq	%rbp, %rbp
	adoxq	%rax, %rbp
	movq	$38, %rdx
	mulxq	%rbp, %rdi, %rax
	imulq	$38, %rax, %rax
	adcxq	%rax, %rsi
	movq	%r8, %rax
	mulxq	%r10, %r10, %r8
	adoxq	%r10, %rsi
	adcxq	%r8, %rax
	mulxq	%rbx, %r10, %r8
	adoxq	%r10, %rax
	adoxq	%r8, %rcx
	movq	%r9, %r8
	mulxq	%r12, %r9, %rdx
	adcxq	%r9, %rcx
	adcxq	%rdx, %r8
	adoxq	%rdi, %r8
	movq	$0, %rdi
	adoxq	%rdi, %rdi
	sbbq	%rdx, %rdx
	andq	$38, %rdx
	negq	%rdi
	andq	$38, %rdi
	leaq	(%rdx,%rdi), %rdx
	shlq	$1, %r8
	sbbq	%rdi, %rdi
	andq	$19, %rdi
	leaq	(%rdx,%rdi), %rdx
	shrq	$1, %r8
	movq	$0, %rdi
	addq	%rdx, %rsi
	adcxq	%rdi, %rax
	adcxq	%rdi, %rcx
	adcxq	%rdi, %r8
	movq	$0, %rdx
	xorq	%rdx, %rdx
	movq	64(%rsp), %rdx
	mulxq	%rsi, %r9, %rdi
	mulxq	%rax, %r11, %r10
	adcxq	%r11, %rdi
	mulxq	%rcx, %rbp, %r11
	adcxq	%rbp, %r10
	mulxq	%r8, %rdx, %rbp
	adcxq	%rdx, %r11
	movq	$0, %rdx
	adcxq	%rdx, %rbp
	movq	72(%rsp), %rdx
	mulxq	%rsi, %r12, %rbx
	adoxq	%r12, %rdi
	adoxq	%rbx, %r10
	mulxq	%rcx, %r12, %rbx
	adoxq	%r12, %r11
	adoxq	%rbx, %rbp
	movq	$0, %rbx
	adoxq	%rbx, %rbx
	mulxq	%rax, %r13, %r12
	adcxq	%r13, %r10
	adcxq	%r12, %r11
	mulxq	%r8, %r12, %rdx
	adcxq	%r12, %rbp
	adcxq	%rdx, %rbx
	movq	80(%rsp), %rdx
	mulxq	%rsi, %r13, %r12
	adoxq	%r13, %r10
	adoxq	%r12, %r11
	mulxq	%rcx, %r13, %r12
	adoxq	%r13, %rbp
	adoxq	%r12, %rbx
	movq	$0, %r12
	adoxq	%r12, %r12
	mulxq	%rax, %r14, %r13
	adcxq	%r14, %r11
	adcxq	%r13, %rbp
	mulxq	%r8, %r13, %rdx
	adcxq	%r13, %rbx
	adcxq	%rdx, %r12
	movq	88(%rsp), %rdx
	mulxq	%rsi, %r13, %rsi
	adoxq	%r13, %r11
	adoxq	%rsi, %rbp
	mulxq	%rcx, %rsi, %rcx
	adoxq	%rsi, %rbx
	adoxq	%rcx, %r12
	movq	$0, %rcx
	adoxq	%rcx, %rcx
	mulxq	%rax, %rsi, %rax
	adcxq	%rsi, %rbp
	adcxq	%rax, %rbx
	mulxq	%r8, %rdx, %rax
	adcxq	%rdx, %r12
	adcxq	%rax, %rcx
	movq	$0, %rax
	movq	$38, %rdx
	mulxq	%rcx, %rsi, %rcx
	adcxq	%rax, %rcx
	imulq	$38, %rcx, %rcx
	adcxq	%rcx, %r9
	mulxq	%rbp, %r8, %rcx
	adoxq	%r8, %r9
	adcxq	%rcx, %rdi
	mulxq	%rbx, %r8, %rcx
	adoxq	%r8, %rdi
	adoxq	%rcx, %r10
	mulxq	%r12, %rdx, %rcx
	adcxq	%rdx, %r10
	adcxq	%rcx, %r11
	adoxq	%rsi, %r11
	adoxq	%rax, %rax
	sbbq	%rcx, %rcx
	andq	$38, %rcx
	negq	%rax
	andq	$38, %rax
	leaq	(%rcx,%rax), %rcx
	shlq	$1, %r11
	sbbq	%rax, %rax
	andq	$19, %rax
	leaq	(%rcx,%rax), %rax
	shrq	$1, %r11
	movq	$0, %rcx
	addq	%rax, %r9
	adcxq	%rcx, %rdi
	adcxq	%rcx, %r10
	adcxq	%rcx, %r11
	movq	%r9, 64(%rsp)
	movq	%rdi, 72(%rsp)
	movq	%r10, 80(%rsp)
	movq	%r11, 88(%rsp)
	movq	$0, %rax
	xorq	%rax, %rax
	movq	%r9, %rdx
	mulxq	%rdi, %rcx, %rax
	mulxq	%r10, %r8, %rsi
	adcxq	%r8, %rax
	mulxq	%r11, %rdx, %r8
	adcxq	%rdx, %rsi
	movq	%rdi, %rdx
	mulxq	%r10, %rbx, %rbp
	adoxq	%rbx, %rsi
	mulxq	%r11, %rdx, %rbx
	adcxq	%rdx, %r8
	adoxq	%rbp, %r8
	movq	$0, %rbp
	adoxq	%rbp, %rbx
	movq	%r10, %rdx
	mulxq	%r11, %rdx, %r12
	adcxq	%rdx, %rbx
	adcxq	%rbp, %r12
	movq	%r9, %rdx
	mulxq	%r9, %r9, %rdx
	adcxq	%rcx, %rcx
	adoxq	%rdx, %rcx
	movq	%rdi, %rdx
	mulxq	%rdi, %rdi, %rdx
	adcxq	%rax, %rax
	adoxq	%rdi, %rax
	adcxq	%rsi, %rsi
	adoxq	%rdx, %rsi
	movq	%r10, %rdx
	mulxq	%r10, %rdi, %rdx
	adcxq	%r8, %r8
	adoxq	%rdi, %r8
	adcxq	%rbx, %rbx
	adoxq	%rdx, %rbx
	movq	%r11, %rdx
	mulxq	%r11, %rdi, %rdx
	adcxq	%r12, %r12
	adoxq	%rdi, %r12
	adcxq	%rbp, %rbp
	adoxq	%rdx, %rbp
	movq	$38, %rdx
	mulxq	%rbp, %r10, %rdi
	imulq	$38, %rdi, %rdi
	adcxq	%rdi, %r9
	mulxq	%r8, %r8, %rdi
	adoxq	%r8, %r9
	adcxq	%rdi, %rcx
	mulxq	%rbx, %r8, %rdi
	adoxq	%r8, %rcx
	adoxq	%rdi, %rax
	mulxq	%r12, %rdi, %rdx
	adcxq	%rdi, %rax
	adcxq	%rdx, %rsi
	adoxq	%r10, %rsi
	movq	$0, %rdi
	adoxq	%rdi, %rdi
	sbbq	%rdx, %rdx
	andq	$38, %rdx
	negq	%rdi
	andq	$38, %rdi
	leaq	(%rdx,%rdi), %rdx
	shlq	$1, %rsi
	sbbq	%rdi, %rdi
	andq	$19, %rdi
	leaq	(%rdx,%rdi), %rdx
	shrq	$1, %rsi
	movq	$0, %rdi
	addq	%rdx, %r9
	adcxq	%rdi, %rcx
	adcxq	%rdi, %rax
	adcxq	%rdi, %rsi
	movq	$4, %rdi
Lfe64_invert_regs$8:
	movq	$0, %rdx
	xorq	%rdx, %rdx
	movq	%r9, %rdx
	mulxq	%rcx, %r10, %r8
	mulxq	%rax, %rbp, %r11
	adcxq	%rbp, %r8
	mulxq	%rsi, %rdx, %rbp
	adcxq	%rdx, %r11
	movq	%rcx, %rdx
	mulxq	%rax, %r12, %rbx
	adoxq	%r12, %r11
	mulxq	%rsi, %rdx, %r12
	adcxq	%rdx, %rbp
	adoxq	%rbx, %rbp
	movq	$0, %rbx
	adoxq	%rbx, %r12
	movq	%rax, %rdx
	mulxq	%rsi, %rdx, %r13
	adcxq	%rdx, %r12
	adcxq	%rbx, %r13
	movq	%r9, %rdx
	mulxq	%r9, %r9, %rdx
	adcxq	%r10, %r10
	adoxq	%rdx, %r10
	movq	%rcx, %rdx
	mulxq	%rcx, %rdx, %rcx
	adcxq	%r8, %r8
	adoxq	%rdx, %r8
	adcxq	%r11, %r11
	adoxq	%rcx, %r11
	movq	%rax, %rdx
	mulxq	%rax, %rcx, %rax
	adcxq	%rbp, %rbp
	adoxq	%rcx, %rbp
	adcxq	%r12, %r12
	adoxq	%rax, %r12
	movq	%rsi, %rdx
	mulxq	%rsi, %rcx, %rax
	adcxq	%r13, %r13
	adoxq	%rcx, %r13
	adcxq	%rbx, %rbx
	adoxq	%rax, %rbx
	movq	$38, %rdx
	mulxq	%rbx, %rcx, %rax
	imulq	$38, %rax, %rax
	adcxq	%rax, %r9
	movq	%r10, %rax
	mulxq	%rbp, %r10, %rsi
	adoxq	%r10, %r9
	adcxq	%rsi, %rax
	movq	%r8, %rsi
	mulxq	%r12, %r10, %r8
	adoxq	%r10, %rax
	adoxq	%r8, %rsi
	movq	%r11, %r8
	mulxq	%r13, %r10, %rdx
	adcxq	%r10, %rsi
	adcxq	%rdx, %r8
	adoxq	%rcx, %r8
	movq	$0, %rcx
	adoxq	%rcx, %rcx
	sbbq	%rdx, %rdx
	andq	$38, %rdx
	negq	%rcx
	andq	$38, %rcx
	leaq	(%rdx,%rcx), %rdx
	shlq	$1, %r8
	sbbq	%rcx, %rcx
	andq	$19, %rcx
	leaq	(%rdx,%rcx), %rcx
	shrq	$1, %r8
	movq	$0, %rdx
	addq	%rcx, %r9
	adcxq	%rdx, %rax
	adcxq	%rdx, %rsi
	adcxq	%rdx, %r8
	decq	%rdi
	movq	$0, %rcx
	xorq	%rcx, %rcx
	movq	%r9, %rdx
	mulxq	%rax, %rcx, %r10
	mulxq	%rsi, %rbp, %r11
	adcxq	%rbp, %r10
	mulxq	%r8, %rdx, %rbp
	adcxq	%rdx, %r11
	movq	%rax, %rdx
	mulxq	%rsi, %r12, %rbx
	adoxq	%r12, %r11
	mulxq	%r8, %rdx, %r12
	adcxq	%rdx, %rbp
	adoxq	%rbx, %rbp
	movq	$0, %rbx
	adoxq	%rbx, %r12
	movq	%rsi, %rdx
	mulxq	%r8, %rdx, %r13
	adcxq	%rdx, %r12
	adcxq	%rbx, %r13
	movq	%r9, %rdx
	mulxq	%r9, %r9, %rdx
	adcxq	%rcx, %rcx
	adoxq	%rdx, %rcx
	movq	%rax, %rdx
	mulxq	%rax, %rdx, %rax
	adcxq	%r10, %r10
	adoxq	%rdx, %r10
	adcxq	%r11, %r11
	adoxq	%rax, %r11
	movq	%rsi, %rdx
	mulxq	%rsi, %rdx, %rax
	adcxq	%rbp, %rbp
	adoxq	%rdx, %rbp
	adcxq	%r12, %r12
	adoxq	%rax, %r12
	movq	%r8, %rdx
	mulxq	%r8, %rdx, %rax
	adcxq	%r13, %r13
	adoxq	%rdx, %r13
	adcxq	%rbx, %rbx
	adoxq	%rax, %rbx
	movq	$38, %rdx
	mulxq	%rbx, %r8, %rax
	imulq	$38, %rax, %rax
	adcxq	%rax, %r9
	mulxq	%rbp, %rsi, %rax
	adoxq	%rsi, %r9
	adcxq	%rax, %rcx
	movq	%r10, %rax
	mulxq	%r12, %r10, %rsi
	adoxq	%r10, %rcx
	adoxq	%rsi, %rax
	movq	%r11, %rsi
	mulxq	%r13, %r10, %rdx
	adcxq	%r10, %rax
	adcxq	%rdx, %rsi
	adoxq	%r8, %rsi
	movq	$0, %r8
	adoxq	%r8, %r8
	sbbq	%rdx, %rdx
	andq	$38, %rdx
	negq	%r8
	andq	$38, %r8
	leaq	(%rdx,%r8), %rdx
	shlq	$1, %rsi
	sbbq	%r8, %r8
	andq	$19, %r8
	leaq	(%rdx,%r8), %rdx
	shrq	$1, %rsi
	movq	$0, %r8
	addq	%rdx, %r9
	adcxq	%r8, %rcx
	adcxq	%r8, %rax
	adcxq	%r8, %rsi
	decq	%rdi
	jne 	Lfe64_invert_regs$8
	movq	%r9, 32(%rsp)
	movq	%rcx, 40(%rsp)
	movq	%rax, 48(%rsp)
	movq	%rsi, 56(%rsp)
	movq	$0, %rdx
	xorq	%rdx, %rdx
	movq	64(%rsp), %rdx
	mulxq	%r9, %r8, %rdi
	mulxq	%rcx, %r11, %r10
	adcxq	%r11, %rdi
	mulxq	%rax, %rbp, %r11
	adcxq	%rbp, %r10
	mulxq	%rsi, %rdx, %rbp
	adcxq	%rdx, %r11
	movq	$0, %rdx
	adcxq	%rdx, %rbp
	movq	72(%rsp), %rdx
	mulxq	%r9, %r12, %rbx
	adoxq	%r12, %rdi
	adoxq	%rbx, %r10
	mulxq	%rax, %r12, %rbx
	adoxq	%r12, %r11
	adoxq	%rbx, %rbp
	movq	$0, %rbx
	adoxq	%rbx, %rbx
	mulxq	%rcx, %r13, %r12
	adcxq	%r13, %r10
	adcxq	%r12, %r11
	mulxq	%rsi, %r12, %rdx
	adcxq	%r12, %rbp
	adcxq	%rdx, %rbx
	movq	80(%rsp), %rdx
	mulxq	%r9, %r13, %r12
	adoxq	%r13, %r10
	adoxq	%r12, %r11
	mulxq	%rax, %r13, %r12
	adoxq	%r13, %rbp
	adoxq	%r12, %rbx
	movq	$0, %r12
	adoxq	%r12, %r12
	mulxq	%rcx, %r14, %r13
	adcxq	%r14, %r11
	adcxq	%r13, %rbp
	mulxq	%rsi, %r13, %rdx
	adcxq	%r13, %rbx
	adcxq	%rdx, %r12
	movq	88(%rsp), %rdx
	mulxq	%r9, %r13, %r9
	adoxq	%r13, %r11
	adoxq	%r9, %rbp
	mulxq	%rax, %r9, %rax
	adoxq	%r9, %rbx
	adoxq	%rax, %r12
	movq	$0, %rax
	adoxq	%rax, %rax
	mulxq	%rcx, %r9, %rcx
	adcxq	%r9, %rbp
	adcxq	%rcx, %rbx
	mulxq	%rsi, %rdx, %rcx
	adcxq	%rdx, %r12
	adcxq	%rcx, %rax
	movq	$0, %rcx
	movq	$38, %rdx
	mulxq	%rax, %rsi, %rax
	adcxq	%rcx, %rax
	imulq	$38, %rax, %rax
	adcxq	%rax, %r8
	mulxq	%rbp, %r9, %rax
	adoxq	%r9, %r8
	adcxq	%rax, %rdi
	mulxq	%rbx, %r9, %rax
	adoxq	%r9, %rdi
	adoxq	%rax, %r10
	mulxq	%r12, %rdx, %rax
	adcxq	%rdx, %r10
	adcxq	%rax, %r11
	adoxq	%rsi, %r11
	adoxq	%rcx, %rcx
	sbbq	%rax, %rax
	andq	$38, %rax
	negq	%rcx
	andq	$38, %rcx
	leaq	(%rax,%rcx), %rax
	shlq	$1, %r11
	sbbq	%rcx, %rcx
	andq	$19, %rcx
	leaq	(%rax,%rcx), %rax
	shrq	$1, %r11
	movq	$0, %rcx
	addq	%rax, %r8
	adcxq	%rcx, %rdi
	adcxq	%rcx, %r10
	adcxq	%rcx, %r11
	movq	%r8, 64(%rsp)
	movq	%rdi, 72(%rsp)
	movq	%r10, 80(%rsp)
	movq	%r11, 88(%rsp)
	movq	$10, %rax
Lfe64_invert_regs$7:
	movq	$0, %rcx
	xorq	%rcx, %rcx
	movq	%r8, %rdx
	mulxq	%rdi, %rsi, %rcx
	mulxq	%r10, %rbp, %r9
	adcxq	%rbp, %rcx
	mulxq	%r11, %rdx, %rbp
	adcxq	%rdx, %r9
	movq	%rdi, %rdx
	mulxq	%r10, %r12, %rbx
	adoxq	%r12, %r9
	mulxq	%r11, %rdx, %r12
	adcxq	%rdx, %rbp
	adoxq	%rbx, %rbp
	movq	$0, %rbx
	adoxq	%rbx, %r12
	movq	%r10, %rdx
	mulxq	%r11, %rdx, %r13
	adcxq	%rdx, %r12
	adcxq	%rbx, %r13
	movq	%r8, %rdx
	mulxq	%r8, %r8, %rdx
	adcxq	%rsi, %rsi
	adoxq	%rdx, %rsi
	movq	%rdi, %rdx
	mulxq	%rdi, %rdi, %rdx
	adcxq	%rcx, %rcx
	adoxq	%rdi, %rcx
	adcxq	%r9, %r9
	adoxq	%rdx, %r9
	movq	%r10, %rdx
	mulxq	%r10, %rdi, %rdx
	adcxq	%rbp, %rbp
	adoxq	%rdi, %rbp
	adcxq	%r12, %r12
	adoxq	%rdx, %r12
	movq	%r11, %rdx
	mulxq	%r11, %rdi, %rdx
	adcxq	%r13, %r13
	adoxq	%rdi, %r13
	adcxq	%rbx, %rbx
	adoxq	%rdx, %rbx
	movq	$38, %rdx
	mulxq	%rbx, %r10, %rdi
	imulq	$38, %rdi, %rdi
	adcxq	%rdi, %r8
	mulxq	%rbp, %r11, %rdi
	adoxq	%r11, %r8
	adcxq	%rdi, %rsi
	mulxq	%r12, %r11, %rdi
	adoxq	%r11, %rsi
	adoxq	%rdi, %rcx
	movq	%r9, %rdi
	mulxq	%r13, %r9, %rdx
	adcxq	%r9, %rcx
	adcxq	%rdx, %rdi
	adoxq	%r10, %rdi
	movq	$0, %r9
	adoxq	%r9, %r9
	sbbq	%rdx, %rdx
	andq	$38, %rdx
	negq	%r9
	andq	$38, %r9
	leaq	(%rdx,%r9), %rdx
	shlq	$1, %rdi
	sbbq	%r9, %r9
	andq	$19, %r9
	leaq	(%rdx,%r9), %rdx
	shrq	$1, %rdi
	movq	$0, %r9
	addq	%rdx, %r8
	adcxq	%r9, %rsi
	adcxq	%r9, %rcx
	adcxq	%r9, %rdi
	decq	%rax
	movq	$0, %rdx
	xorq	%rdx, %rdx
	movq	%r8, %rdx
	mulxq	%rsi, %r10, %r9
	mulxq	%rcx, %rbp, %r11
	adcxq	%rbp, %r9
	mulxq	%rdi, %rdx, %rbp
	adcxq	%rdx, %r11
	movq	%rsi, %rdx
	mulxq	%rcx, %r12, %rbx
	adoxq	%r12, %r11
	mulxq	%rdi, %rdx, %r12
	adcxq	%rdx, %rbp
	adoxq	%rbx, %rbp
	movq	$0, %rbx
	adoxq	%rbx, %r12
	movq	%rcx, %rdx
	mulxq	%rdi, %rdx, %r13
	adcxq	%rdx, %r12
	adcxq	%rbx, %r13
	movq	%r8, %rdx
	mulxq	%r8, %r8, %rdx
	adcxq	%r10, %r10
	adoxq	%rdx, %r10
	movq	%rsi, %rdx
	mulxq	%rsi, %rsi, %rdx
	adcxq	%r9, %r9
	adoxq	%rsi, %r9
	adcxq	%r11, %r11
	adoxq	%rdx, %r11
	movq	%rcx, %rdx
	mulxq	%rcx, %rdx, %rcx
	adcxq	%rbp, %rbp
	adoxq	%rdx, %rbp
	adcxq	%r12, %r12
	adoxq	%rcx, %r12
	movq	%rdi, %rdx
	mulxq	%rdi, %rdx, %rcx
	adcxq	%r13, %r13
	adoxq	%rdx, %r13
	adcxq	%rbx, %rbx
	adoxq	%rcx, %rbx
	movq	$38, %rdx
	mulxq	%rbx, %rsi, %rcx
	imulq	$38, %rcx, %rcx
	adcxq	%rcx, %r8
	movq	%r10, %rdi
	mulxq	%rbp, %r10, %rcx
	adoxq	%r10, %r8
	adcxq	%rcx, %rdi
	movq	%r9, %r10
	mulxq	%r12, %r9, %rcx
	adoxq	%r9, %rdi
	adoxq	%rcx, %r10
	mulxq	%r13, %rdx, %rcx
	adcxq	%rdx, %r10
	adcxq	%rcx, %r11
	adoxq	%rsi, %r11
	movq	$0, %rdx
	adoxq	%rdx, %rdx
	sbbq	%rcx, %rcx
	andq	$38, %rcx
	negq	%rdx
	andq	$38, %rdx
	leaq	(%rcx,%rdx), %rcx
	shlq	$1, %r11
	sbbq	%rdx, %rdx
	andq	$19, %rdx
	leaq	(%rcx,%rdx), %rcx
	shrq	$1, %r11
	movq	$0, %rdx
	addq	%rcx, %r8
	adcxq	%rdx, %rdi
	adcxq	%rdx, %r10
	adcxq	%rdx, %r11
	decq	%rax
	jne 	Lfe64_invert_regs$7
	movq	$0, %rax
	xorq	%rax, %rax
	movq	64(%rsp), %rdx
	mulxq	%r8, %rcx, %rax
	mulxq	%rdi, %r9, %rsi
	adcxq	%r9, %rax
	mulxq	%r10, %rbp, %r9
	adcxq	%rbp, %rsi
	mulxq	%r11, %rdx, %rbp
	adcxq	%rdx, %r9
	movq	$0, %rdx
	adcxq	%rdx, %rbp
	movq	72(%rsp), %rdx
	mulxq	%r8, %r12, %rbx
	adoxq	%r12, %rax
	adoxq	%rbx, %rsi
	mulxq	%r10, %r12, %rbx
	adoxq	%r12, %r9
	adoxq	%rbx, %rbp
	movq	$0, %rbx
	adoxq	%rbx, %rbx
	mulxq	%rdi, %r13, %r12
	adcxq	%r13, %rsi
	adcxq	%r12, %r9
	mulxq	%r11, %r12, %rdx
	adcxq	%r12, %rbp
	adcxq	%rdx, %rbx
	movq	80(%rsp), %rdx
	mulxq	%r8, %r13, %r12
	adoxq	%r13, %rsi
	adoxq	%r12, %r9
	mulxq	%r10, %r13, %r12
	adoxq	%r13, %rbp
	adoxq	%r12, %rbx
	movq	$0, %r12
	adoxq	%r12, %r12
	mulxq	%rdi, %r14, %r13
	adcxq	%r14, %r9
	adcxq	%r13, %rbp
	mulxq	%r11, %r13, %rdx
	adcxq	%r13, %rbx
	adcxq	%rdx, %r12
	movq	88(%rsp), %rdx
	mulxq	%r8, %r13, %r8
	adoxq	%r13, %r9
	adoxq	%r8, %rbp
	mulxq	%r10, %r10, %r8
	adoxq	%r10, %rbx
	adoxq	%r8, %r12
	movq	$0, %r8
	adoxq	%r8, %r8
	mulxq	%rdi, %r10, %rdi
	adcxq	%r10, %rbp
	adcxq	%rdi, %rbx
	mulxq	%r11, %rdi, %rdx
	adcxq	%rdi, %r12
	adcxq	%rdx, %r8
	movq	$0, %rdi
	movq	$38, %rdx
	mulxq	%r8, %r10, %r8
	adcxq	%rdi, %r8
	imulq	$38, %r8, %r8
	adcxq	%r8, %rcx
	mulxq	%rbp, %r11, %r8
	adoxq	%r11, %rcx
	adcxq	%r8, %rax
	mulxq	%rbx, %r11, %r8
	adoxq	%r11, %rax
	adoxq	%r8, %rsi
	mulxq	%r12, %r8, %rdx
	adcxq	%r8, %rsi
	adcxq	%rdx, %r9
	adoxq	%r10, %r9
	adoxq	%rdi, %rdi
	sbbq	%rdx, %rdx
	andq	$38, %rdx
	negq	%rdi
	andq	$38, %rdi
	leaq	(%rdx,%rdi), %rdx
	shlq	$1, %r9
	sbbq	%rdi, %rdi
	andq	$19, %rdi
	leaq	(%rdx,%rdi), %rdx
	shrq	$1, %r9
	movq	$0, %rdi
	addq	%rdx, %rcx
	adcxq	%rdi, %rax
	adcxq	%rdi, %rsi
	adcxq	%rdi, %r9
	movq	%rcx, 32(%rsp)
	movq	%rax, 40(%rsp)
	movq	%rsi, 48(%rsp)
	movq	%r9, 56(%rsp)
	movq	$20, %rdi
Lfe64_invert_regs$6:
	movq	$0, %rdx
	xorq	%rdx, %rdx
	movq	%rcx, %rdx
	mulxq	%rax, %r10, %r8
	mulxq	%rsi, %rbp, %r11
	adcxq	%rbp, %r8
	mulxq	%r9, %rdx, %rbp
	adcxq	%rdx, %r11
	movq	%rax, %rdx
	mulxq	%rsi, %r12, %rbx
	adoxq	%r12, %r11
	mulxq	%r9, %rdx, %r12
	adcxq	%rdx, %rbp
	adoxq	%rbx, %rbp
	movq	$0, %rbx
	adoxq	%rbx, %r12
	movq	%rsi, %rdx
	mulxq	%r9, %rdx, %r13
	adcxq	%rdx, %r12
	adcxq	%rbx, %r13
	movq	%rcx, %rdx
	mulxq	%rcx, %r14, %rcx
	adcxq	%r10, %r10
	adoxq	%rcx, %r10
	movq	%rax, %rdx
	mulxq	%rax, %rcx, %rax
	adcxq	%r8, %r8
	adoxq	%rcx, %r8
	adcxq	%r11, %r11
	adoxq	%rax, %r11
	movq	%rsi, %rdx
	mulxq	%rsi, %rcx, %rax
	adcxq	%rbp, %rbp
	adoxq	%rcx, %rbp
	adcxq	%r12, %r12
	adoxq	%rax, %r12
	movq	%r9, %rdx
	mulxq	%r9, %rcx, %rax
	adcxq	%r13, %r13
	adoxq	%rcx, %r13
	adcxq	%rbx, %rbx
	adoxq	%rax, %rbx
	movq	$38, %rdx
	mulxq	%rbx, %rcx, %rax
	imulq	$38, %rax, %rax
	adcxq	%rax, %r14
	movq	%r10, %rax
	mulxq	%rbp, %r9, %rsi
	adoxq	%r9, %r14
	adcxq	%rsi, %rax
	movq	%r8, %rsi
	mulxq	%r12, %r9, %r8
	adoxq	%r9, %rax
	adoxq	%r8, %rsi
	movq	%r11, %r8
	mulxq	%r13, %r9, %rdx
	adcxq	%r9, %rsi
	adcxq	%rdx, %r8
	adoxq	%rcx, %r8
	movq	$0, %rcx
	adoxq	%rcx, %rcx
	sbbq	%rdx, %rdx
	andq	$38, %rdx
	negq	%rcx
	andq	$38, %rcx
	leaq	(%rdx,%rcx), %rdx
	shlq	$1, %r8
	sbbq	%rcx, %rcx
	andq	$19, %rcx
	leaq	(%rdx,%rcx), %rcx
	shrq	$1, %r8
	movq	$0, %rdx
	addq	%rcx, %r14
	adcxq	%rdx, %rax
	adcxq	%rdx, %rsi
	adcxq	%rdx, %r8
	decq	%rdi
	movq	$0, %rcx
	xorq	%rcx, %rcx
	movq	%r14, %rdx
	mulxq	%rax, %r10, %r9
	mulxq	%rsi, %rcx, %r11
	adcxq	%rcx, %r9
	mulxq	%r8, %rcx, %rbp
	adcxq	%rcx, %r11
	movq	%rax, %rdx
	mulxq	%rsi, %rbx, %rcx
	adoxq	%rbx, %r11
	mulxq	%r8, %rdx, %rbx
	adcxq	%rdx, %rbp
	adoxq	%rcx, %rbp
	movq	$0, %rcx
	adoxq	%rcx, %rbx
	movq	%rsi, %rdx
	mulxq	%r8, %rdx, %r12
	adcxq	%rdx, %rbx
	adcxq	%rcx, %r12
	movq	%r14, %rdx
	mulxq	%r14, %r13, %rdx
	adcxq	%r10, %r10
	adoxq	%rdx, %r10
	movq	%rax, %rdx
	mulxq	%rax, %rdx, %rax
	adcxq	%r9, %r9
	adoxq	%rdx, %r9
	adcxq	%r11, %r11
	adoxq	%rax, %r11
	movq	%rsi, %rdx
	mulxq	%rsi, %rdx, %rax
	adcxq	%rbp, %rbp
	adoxq	%rdx, %rbp
	adcxq	%rbx, %rbx
	adoxq	%rax, %rbx
	movq	%r8, %rdx
	mulxq	%r8, %rdx, %rax
	adcxq	%r12, %r12
	adoxq	%rdx, %r12
	adcxq	%rcx, %rcx
	adoxq	%rax, %rcx
	movq	$38, %rdx
	mulxq	%rcx, %r8, %rax
	imulq	$38, %rax, %rax
	movq	%r13, %rcx
	adcxq	%rax, %rcx
	movq	%r10, %rax
	mulxq	%rbp, %r10, %rsi
	adoxq	%r10, %rcx
	adcxq	%rsi, %rax
	movq	%r9, %rsi
	mulxq	%rbx, %r10, %r9
	adoxq	%r10, %rax
	adoxq	%r9, %rsi
	movq	%r11, %r9
	mulxq	%r12, %r10, %rdx
	adcxq	%r10, %rsi
	adcxq	%rdx, %r9
	adoxq	%r8, %r9
	movq	$0, %r8
	adoxq	%r8, %r8
	sbbq	%rdx, %rdx
	andq	$38, %rdx
	negq	%r8
	andq	$38, %r8
	leaq	(%rdx,%r8), %rdx
	shlq	$1, %r9
	sbbq	%r8, %r8
	andq	$19, %r8
	leaq	(%rdx,%r8), %rdx
	shrq	$1, %r9
	movq	$0, %r8
	addq	%rdx, %rcx
	adcxq	%r8, %rax
	adcxq	%r8, %rsi
	adcxq	%r8, %r9
	decq	%rdi
	jne 	Lfe64_invert_regs$6
	movq	$0, %rdx
	xorq	%rdx, %rdx
	movq	32(%rsp), %rdx
	mulxq	%rcx, %r8, %rdi
	mulxq	%rax, %r11, %r10
	adcxq	%r11, %rdi
	mulxq	%rsi, %rbp, %r11
	adcxq	%rbp, %r10
	mulxq	%r9, %rdx, %rbp
	adcxq	%rdx, %r11
	movq	$0, %rdx
	adcxq	%rdx, %rbp
	movq	40(%rsp), %rdx
	mulxq	%rcx, %r12, %rbx
	adoxq	%r12, %rdi
	adoxq	%rbx, %r10
	mulxq	%rsi, %r12, %rbx
	adoxq	%r12, %r11
	adoxq	%rbx, %rbp
	movq	$0, %rbx
	adoxq	%rbx, %rbx
	mulxq	%rax, %r13, %r12
	adcxq	%r13, %r10
	adcxq	%r12, %r11
	mulxq	%r9, %r12, %rdx
	adcxq	%r12, %rbp
	adcxq	%rdx, %rbx
	movq	48(%rsp), %rdx
	mulxq	%rcx, %r13, %r12
	adoxq	%r13, %r10
	adoxq	%r12, %r11
	mulxq	%rsi, %r13, %r12
	adoxq	%r13, %rbp
	adoxq	%r12, %rbx
	movq	$0, %r12
	adoxq	%r12, %r12
	mulxq	%rax, %r14, %r13
	adcxq	%r14, %r11
	adcxq	%r13, %rbp
	mulxq	%r9, %r13, %rdx
	adcxq	%r13, %rbx
	adcxq	%rdx, %r12
	movq	56(%rsp), %rdx
	mulxq	%rcx, %r13, %rcx
	adoxq	%r13, %r11
	adoxq	%rcx, %rbp
	mulxq	%rsi, %rsi, %rcx
	adoxq	%rsi, %rbx
	adoxq	%rcx, %r12
	movq	$0, %rcx
	adoxq	%rcx, %rcx
	mulxq	%rax, %rsi, %rax
	adcxq	%rsi, %rbp
	adcxq	%rax, %rbx
	mulxq	%r9, %rdx, %rax
	adcxq	%rdx, %r12
	adcxq	%rax, %rcx
	movq	$0, %rax
	movq	$38, %rdx
	mulxq	%rcx, %rsi, %rcx
	adcxq	%rax, %rcx
	imulq	$38, %rcx, %rcx
	adcxq	%rcx, %r8
	mulxq	%rbp, %r9, %rcx
	adoxq	%r9, %r8
	adcxq	%rcx, %rdi
	mulxq	%rbx, %r9, %rcx
	adoxq	%r9, %rdi
	adoxq	%rcx, %r10
	mulxq	%r12, %rdx, %rcx
	adcxq	%rdx, %r10
	adcxq	%rcx, %r11
	adoxq	%rsi, %r11
	adoxq	%rax, %rax
	sbbq	%rcx, %rcx
	andq	$38, %rcx
	negq	%rax
	andq	$38, %rax
	leaq	(%rcx,%rax), %rcx
	shlq	$1, %r11
	sbbq	%rax, %rax
	andq	$19, %rax
	leaq	(%rcx,%rax), %rax
	shrq	$1, %r11
	movq	$0, %rcx
	addq	%rax, %r8
	adcxq	%rcx, %rdi
	adcxq	%rcx, %r10
	adcxq	%rcx, %r11
	movq	$10, %rax
Lfe64_invert_regs$5:
	movq	$0, %rcx
	xorq	%rcx, %rcx
	movq	%r8, %rdx
	mulxq	%rdi, %rsi, %rcx
	mulxq	%r10, %rbp, %r9
	adcxq	%rbp, %rcx
	mulxq	%r11, %rdx, %rbp
	adcxq	%rdx, %r9
	movq	%rdi, %rdx
	mulxq	%r10, %r12, %rbx
	adoxq	%r12, %r9
	mulxq	%r11, %rdx, %r12
	adcxq	%rdx, %rbp
	adoxq	%rbx, %rbp
	movq	$0, %rbx
	adoxq	%rbx, %r12
	movq	%r10, %rdx
	mulxq	%r11, %rdx, %r13
	adcxq	%rdx, %r12
	adcxq	%rbx, %r13
	movq	%r8, %rdx
	mulxq	%r8, %r8, %rdx
	adcxq	%rsi, %rsi
	adoxq	%rdx, %rsi
	movq	%rdi, %rdx
	mulxq	%rdi, %rdi, %rdx
	adcxq	%rcx, %rcx
	adoxq	%rdi, %rcx
	adcxq	%r9, %r9
	adoxq	%rdx, %r9
	movq	%r10, %rdx
	mulxq	%r10, %rdi, %rdx
	adcxq	%rbp, %rbp
	adoxq	%rdi, %rbp
	adcxq	%r12, %r12
	adoxq	%rdx, %r12
	movq	%r11, %rdx
	mulxq	%r11, %rdi, %rdx
	adcxq	%r13, %r13
	adoxq	%rdi, %r13
	adcxq	%rbx, %rbx
	adoxq	%rdx, %rbx
	movq	$38, %rdx
	mulxq	%rbx, %r10, %rdi
	imulq	$38, %rdi, %rdi
	adcxq	%rdi, %r8
	mulxq	%rbp, %r11, %rdi
	adoxq	%r11, %r8
	adcxq	%rdi, %rsi
	mulxq	%r12, %r11, %rdi
	adoxq	%r11, %rsi
	adoxq	%rdi, %rcx
	movq	%r9, %rdi
	mulxq	%r13, %r9, %rdx
	adcxq	%r9, %rcx
	adcxq	%rdx, %rdi
	adoxq	%r10, %rdi
	movq	$0, %r9
	adoxq	%r9, %r9
	sbbq	%rdx, %rdx
	andq	$38, %rdx
	negq	%r9
	andq	$38, %r9
	leaq	(%rdx,%r9), %rdx
	shlq	$1, %rdi
	sbbq	%r9, %r9
	andq	$19, %r9
	leaq	(%rdx,%r9), %rdx
	shrq	$1, %rdi
	movq	$0, %r9
	addq	%rdx, %r8
	adcxq	%r9, %rsi
	adcxq	%r9, %rcx
	adcxq	%r9, %rdi
	decq	%rax
	movq	$0, %rdx
	xorq	%rdx, %rdx
	movq	%r8, %rdx
	mulxq	%rsi, %r10, %r9
	mulxq	%rcx, %rbp, %r11
	adcxq	%rbp, %r9
	mulxq	%rdi, %rdx, %rbp
	adcxq	%rdx, %r11
	movq	%rsi, %rdx
	mulxq	%rcx, %r12, %rbx
	adoxq	%r12, %r11
	mulxq	%rdi, %rdx, %r12
	adcxq	%rdx, %rbp
	adoxq	%rbx, %rbp
	movq	$0, %rbx
	adoxq	%rbx, %r12
	movq	%rcx, %rdx
	mulxq	%rdi, %rdx, %r13
	adcxq	%rdx, %r12
	adcxq	%rbx, %r13
	movq	%r8, %rdx
	mulxq	%r8, %r8, %rdx
	adcxq	%r10, %r10
	adoxq	%rdx, %r10
	movq	%rsi, %rdx
	mulxq	%rsi, %rsi, %rdx
	adcxq	%r9, %r9
	adoxq	%rsi, %r9
	adcxq	%r11, %r11
	adoxq	%rdx, %r11
	movq	%rcx, %rdx
	mulxq	%rcx, %rdx, %rcx
	adcxq	%rbp, %rbp
	adoxq	%rdx, %rbp
	adcxq	%r12, %r12
	adoxq	%rcx, %r12
	movq	%rdi, %rdx
	mulxq	%rdi, %rdx, %rcx
	adcxq	%r13, %r13
	adoxq	%rdx, %r13
	adcxq	%rbx, %rbx
	adoxq	%rcx, %rbx
	movq	$38, %rdx
	mulxq	%rbx, %rsi, %rcx
	imulq	$38, %rcx, %rcx
	adcxq	%rcx, %r8
	movq	%r10, %rdi
	mulxq	%rbp, %r10, %rcx
	adoxq	%r10, %r8
	adcxq	%rcx, %rdi
	movq	%r9, %r10
	mulxq	%r12, %r9, %rcx
	adoxq	%r9, %rdi
	adoxq	%rcx, %r10
	mulxq	%r13, %rdx, %rcx
	adcxq	%rdx, %r10
	adcxq	%rcx, %r11
	adoxq	%rsi, %r11
	movq	$0, %rdx
	adoxq	%rdx, %rdx
	sbbq	%rcx, %rcx
	andq	$38, %rcx
	negq	%rdx
	andq	$38, %rdx
	leaq	(%rcx,%rdx), %rcx
	shlq	$1, %r11
	sbbq	%rdx, %rdx
	andq	$19, %rdx
	leaq	(%rcx,%rdx), %rcx
	shrq	$1, %r11
	movq	$0, %rdx
	addq	%rcx, %r8
	adcxq	%rdx, %rdi
	adcxq	%rdx, %r10
	adcxq	%rdx, %r11
	decq	%rax
	jne 	Lfe64_invert_regs$5
	movq	$0, %rax
	xorq	%rax, %rax
	movq	64(%rsp), %rdx
	mulxq	%r8, %rcx, %rax
	mulxq	%rdi, %r9, %rsi
	adcxq	%r9, %rax
	mulxq	%r10, %rbp, %r9
	adcxq	%rbp, %rsi
	mulxq	%r11, %rdx, %rbp
	adcxq	%rdx, %r9
	movq	$0, %rdx
	adcxq	%rdx, %rbp
	movq	72(%rsp), %rdx
	mulxq	%r8, %r12, %rbx
	adoxq	%r12, %rax
	adoxq	%rbx, %rsi
	mulxq	%r10, %r12, %rbx
	adoxq	%r12, %r9
	adoxq	%rbx, %rbp
	movq	$0, %rbx
	adoxq	%rbx, %rbx
	mulxq	%rdi, %r13, %r12
	adcxq	%r13, %rsi
	adcxq	%r12, %r9
	mulxq	%r11, %r12, %rdx
	adcxq	%r12, %rbp
	adcxq	%rdx, %rbx
	movq	80(%rsp), %rdx
	mulxq	%r8, %r13, %r12
	adoxq	%r13, %rsi
	adoxq	%r12, %r9
	mulxq	%r10, %r13, %r12
	adoxq	%r13, %rbp
	adoxq	%r12, %rbx
	movq	$0, %r12
	adoxq	%r12, %r12
	mulxq	%rdi, %r14, %r13
	adcxq	%r14, %r9
	adcxq	%r13, %rbp
	mulxq	%r11, %r13, %rdx
	adcxq	%r13, %rbx
	adcxq	%rdx, %r12
	movq	88(%rsp), %rdx
	mulxq	%r8, %r13, %r8
	adoxq	%r13, %r9
	adoxq	%r8, %rbp
	mulxq	%r10, %r10, %r8
	adoxq	%r10, %rbx
	adoxq	%r8, %r12
	movq	$0, %r8
	adoxq	%r8, %r8
	mulxq	%rdi, %r10, %rdi
	adcxq	%r10, %rbp
	adcxq	%rdi, %rbx
	mulxq	%r11, %rdi, %rdx
	adcxq	%rdi, %r12
	adcxq	%rdx, %r8
	movq	$0, %rdi
	movq	$38, %rdx
	mulxq	%r8, %r10, %r8
	adcxq	%rdi, %r8
	imulq	$38, %r8, %r8
	adcxq	%r8, %rcx
	mulxq	%rbp, %r11, %r8
	adoxq	%r11, %rcx
	adcxq	%r8, %rax
	mulxq	%rbx, %r11, %r8
	adoxq	%r11, %rax
	adoxq	%r8, %rsi
	mulxq	%r12, %r8, %rdx
	adcxq	%r8, %rsi
	adcxq	%rdx, %r9
	adoxq	%r10, %r9
	adoxq	%rdi, %rdi
	sbbq	%rdx, %rdx
	andq	$38, %rdx
	negq	%rdi
	andq	$38, %rdi
	leaq	(%rdx,%rdi), %rdx
	shlq	$1, %r9
	sbbq	%rdi, %rdi
	andq	$19, %rdi
	leaq	(%rdx,%rdi), %rdx
	shrq	$1, %r9
	movq	$0, %rdi
	addq	%rdx, %rcx
	adcxq	%rdi, %rax
	adcxq	%rdi, %rsi
	adcxq	%rdi, %r9
	movq	%rcx, 64(%rsp)
	movq	%rax, 72(%rsp)
	movq	%rsi, 80(%rsp)
	movq	%r9, 88(%rsp)
	movq	$50, %rdi
Lfe64_invert_regs$4:
	movq	$0, %rdx
	xorq	%rdx, %rdx
	movq	%rcx, %rdx
	mulxq	%rax, %r10, %r8
	mulxq	%rsi, %rbp, %r11
	adcxq	%rbp, %r8
	mulxq	%r9, %rdx, %rbp
	adcxq	%rdx, %r11
	movq	%rax, %rdx
	mulxq	%rsi, %r12, %rbx
	adoxq	%r12, %r11
	mulxq	%r9, %rdx, %r12
	adcxq	%rdx, %rbp
	adoxq	%rbx, %rbp
	movq	$0, %rbx
	adoxq	%rbx, %r12
	movq	%rsi, %rdx
	mulxq	%r9, %rdx, %r13
	adcxq	%rdx, %r12
	adcxq	%rbx, %r13
	movq	%rcx, %rdx
	mulxq	%rcx, %r14, %rcx
	adcxq	%r10, %r10
	adoxq	%rcx, %r10
	movq	%rax, %rdx
	mulxq	%rax, %rcx, %rax
	adcxq	%r8, %r8
	adoxq	%rcx, %r8
	adcxq	%r11, %r11
	adoxq	%rax, %r11
	movq	%rsi, %rdx
	mulxq	%rsi, %rcx, %rax
	adcxq	%rbp, %rbp
	adoxq	%rcx, %rbp
	adcxq	%r12, %r12
	adoxq	%rax, %r12
	movq	%r9, %rdx
	mulxq	%r9, %rcx, %rax
	adcxq	%r13, %r13
	adoxq	%rcx, %r13
	adcxq	%rbx, %rbx
	adoxq	%rax, %rbx
	movq	$38, %rdx
	mulxq	%rbx, %rcx, %rax
	imulq	$38, %rax, %rax
	adcxq	%rax, %r14
	movq	%r10, %rax
	mulxq	%rbp, %r9, %rsi
	adoxq	%r9, %r14
	adcxq	%rsi, %rax
	movq	%r8, %rsi
	mulxq	%r12, %r9, %r8
	adoxq	%r9, %rax
	adoxq	%r8, %rsi
	movq	%r11, %r8
	mulxq	%r13, %r9, %rdx
	adcxq	%r9, %rsi
	adcxq	%rdx, %r8
	adoxq	%rcx, %r8
	movq	$0, %rcx
	adoxq	%rcx, %rcx
	sbbq	%rdx, %rdx
	andq	$38, %rdx
	negq	%rcx
	andq	$38, %rcx
	leaq	(%rdx,%rcx), %rdx
	shlq	$1, %r8
	sbbq	%rcx, %rcx
	andq	$19, %rcx
	leaq	(%rdx,%rcx), %rcx
	shrq	$1, %r8
	movq	$0, %rdx
	addq	%rcx, %r14
	adcxq	%rdx, %rax
	adcxq	%rdx, %rsi
	adcxq	%rdx, %r8
	decq	%rdi
	movq	$0, %rcx
	xorq	%rcx, %rcx
	movq	%r14, %rdx
	mulxq	%rax, %r10, %r9
	mulxq	%rsi, %rcx, %r11
	adcxq	%rcx, %r9
	mulxq	%r8, %rcx, %rbp
	adcxq	%rcx, %r11
	movq	%rax, %rdx
	mulxq	%rsi, %rbx, %rcx
	adoxq	%rbx, %r11
	mulxq	%r8, %rdx, %rbx
	adcxq	%rdx, %rbp
	adoxq	%rcx, %rbp
	movq	$0, %rcx
	adoxq	%rcx, %rbx
	movq	%rsi, %rdx
	mulxq	%r8, %rdx, %r12
	adcxq	%rdx, %rbx
	adcxq	%rcx, %r12
	movq	%r14, %rdx
	mulxq	%r14, %r13, %rdx
	adcxq	%r10, %r10
	adoxq	%rdx, %r10
	movq	%rax, %rdx
	mulxq	%rax, %rdx, %rax
	adcxq	%r9, %r9
	adoxq	%rdx, %r9
	adcxq	%r11, %r11
	adoxq	%rax, %r11
	movq	%rsi, %rdx
	mulxq	%rsi, %rdx, %rax
	adcxq	%rbp, %rbp
	adoxq	%rdx, %rbp
	adcxq	%rbx, %rbx
	adoxq	%rax, %rbx
	movq	%r8, %rdx
	mulxq	%r8, %rdx, %rax
	adcxq	%r12, %r12
	adoxq	%rdx, %r12
	adcxq	%rcx, %rcx
	adoxq	%rax, %rcx
	movq	$38, %rdx
	mulxq	%rcx, %r8, %rax
	imulq	$38, %rax, %rax
	movq	%r13, %rcx
	adcxq	%rax, %rcx
	movq	%r10, %rax
	mulxq	%rbp, %r10, %rsi
	adoxq	%r10, %rcx
	adcxq	%rsi, %rax
	movq	%r9, %rsi
	mulxq	%rbx, %r10, %r9
	adoxq	%r10, %rax
	adoxq	%r9, %rsi
	movq	%r11, %r9
	mulxq	%r12, %r10, %rdx
	adcxq	%r10, %rsi
	adcxq	%rdx, %r9
	adoxq	%r8, %r9
	movq	$0, %r8
	adoxq	%r8, %r8
	sbbq	%rdx, %rdx
	andq	$38, %rdx
	negq	%r8
	andq	$38, %r8
	leaq	(%rdx,%r8), %rdx
	shlq	$1, %r9
	sbbq	%r8, %r8
	andq	$19, %r8
	leaq	(%rdx,%r8), %rdx
	shrq	$1, %r9
	movq	$0, %r8
	addq	%rdx, %rcx
	adcxq	%r8, %rax
	adcxq	%r8, %rsi
	adcxq	%r8, %r9
	decq	%rdi
	jne 	Lfe64_invert_regs$4
	movq	$0, %rdx
	xorq	%rdx, %rdx
	movq	64(%rsp), %rdx
	mulxq	%rcx, %r8, %rdi
	mulxq	%rax, %r11, %r10
	adcxq	%r11, %rdi
	mulxq	%rsi, %rbp, %r11
	adcxq	%rbp, %r10
	mulxq	%r9, %rdx, %rbp
	adcxq	%rdx, %r11
	movq	$0, %rdx
	adcxq	%rdx, %rbp
	movq	72(%rsp), %rdx
	mulxq	%rcx, %r12, %rbx
	adoxq	%r12, %rdi
	adoxq	%rbx, %r10
	mulxq	%rsi, %r12, %rbx
	adoxq	%r12, %r11
	adoxq	%rbx, %rbp
	movq	$0, %rbx
	adoxq	%rbx, %rbx
	mulxq	%rax, %r13, %r12
	adcxq	%r13, %r10
	adcxq	%r12, %r11
	mulxq	%r9, %r12, %rdx
	adcxq	%r12, %rbp
	adcxq	%rdx, %rbx
	movq	80(%rsp), %rdx
	mulxq	%rcx, %r13, %r12
	adoxq	%r13, %r10
	adoxq	%r12, %r11
	mulxq	%rsi, %r13, %r12
	adoxq	%r13, %rbp
	adoxq	%r12, %rbx
	movq	$0, %r12
	adoxq	%r12, %r12
	mulxq	%rax, %r14, %r13
	adcxq	%r14, %r11
	adcxq	%r13, %rbp
	mulxq	%r9, %r13, %rdx
	adcxq	%r13, %rbx
	adcxq	%rdx, %r12
	movq	88(%rsp), %rdx
	mulxq	%rcx, %r13, %rcx
	adoxq	%r13, %r11
	adoxq	%rcx, %rbp
	mulxq	%rsi, %rsi, %rcx
	adoxq	%rsi, %rbx
	adoxq	%rcx, %r12
	movq	$0, %rcx
	adoxq	%rcx, %rcx
	mulxq	%rax, %rsi, %rax
	adcxq	%rsi, %rbp
	adcxq	%rax, %rbx
	mulxq	%r9, %rdx, %rax
	adcxq	%rdx, %r12
	adcxq	%rax, %rcx
	movq	$0, %rax
	movq	$38, %rdx
	mulxq	%rcx, %rsi, %rcx
	adcxq	%rax, %rcx
	imulq	$38, %rcx, %rcx
	adcxq	%rcx, %r8
	mulxq	%rbp, %r9, %rcx
	adoxq	%r9, %r8
	adcxq	%rcx, %rdi
	mulxq	%rbx, %r9, %rcx
	adoxq	%r9, %rdi
	adoxq	%rcx, %r10
	mulxq	%r12, %rdx, %rcx
	adcxq	%rdx, %r10
	adcxq	%rcx, %r11
	adoxq	%rsi, %r11
	adoxq	%rax, %rax
	sbbq	%rcx, %rcx
	andq	$38, %rcx
	negq	%rax
	andq	$38, %rax
	leaq	(%rcx,%rax), %rcx
	shlq	$1, %r11
	sbbq	%rax, %rax
	andq	$19, %rax
	leaq	(%rcx,%rax), %rax
	shrq	$1, %r11
	movq	$0, %rcx
	addq	%rax, %r8
	adcxq	%rcx, %rdi
	adcxq	%rcx, %r10
	adcxq	%rcx, %r11
	movq	%r8, 32(%rsp)
	movq	%rdi, 40(%rsp)
	movq	%r10, 48(%rsp)
	movq	%r11, 56(%rsp)
	movq	$100, %rax
Lfe64_invert_regs$3:
	movq	$0, %rcx
	xorq	%rcx, %rcx
	movq	%r8, %rdx
	mulxq	%rdi, %rsi, %rcx
	mulxq	%r10, %rbp, %r9
	adcxq	%rbp, %rcx
	mulxq	%r11, %rdx, %rbp
	adcxq	%rdx, %r9
	movq	%rdi, %rdx
	mulxq	%r10, %r12, %rbx
	adoxq	%r12, %r9
	mulxq	%r11, %rdx, %r12
	adcxq	%rdx, %rbp
	adoxq	%rbx, %rbp
	movq	$0, %rbx
	adoxq	%rbx, %r12
	movq	%r10, %rdx
	mulxq	%r11, %rdx, %r13
	adcxq	%rdx, %r12
	adcxq	%rbx, %r13
	movq	%r8, %rdx
	mulxq	%r8, %r8, %rdx
	adcxq	%rsi, %rsi
	adoxq	%rdx, %rsi
	movq	%rdi, %rdx
	mulxq	%rdi, %rdi, %rdx
	adcxq	%rcx, %rcx
	adoxq	%rdi, %rcx
	adcxq	%r9, %r9
	adoxq	%rdx, %r9
	movq	%r10, %rdx
	mulxq	%r10, %rdi, %rdx
	adcxq	%rbp, %rbp
	adoxq	%rdi, %rbp
	adcxq	%r12, %r12
	adoxq	%rdx, %r12
	movq	%r11, %rdx
	mulxq	%r11, %rdi, %rdx
	adcxq	%r13, %r13
	adoxq	%rdi, %r13
	adcxq	%rbx, %rbx
	adoxq	%rdx, %rbx
	movq	$38, %rdx
	mulxq	%rbx, %r10, %rdi
	imulq	$38, %rdi, %rdi
	adcxq	%rdi, %r8
	mulxq	%rbp, %r11, %rdi
	adoxq	%r11, %r8
	adcxq	%rdi, %rsi
	mulxq	%r12, %r11, %rdi
	adoxq	%r11, %rsi
	adoxq	%rdi, %rcx
	movq	%r9, %rdi
	mulxq	%r13, %r9, %rdx
	adcxq	%r9, %rcx
	adcxq	%rdx, %rdi
	adoxq	%r10, %rdi
	movq	$0, %r9
	adoxq	%r9, %r9
	sbbq	%rdx, %rdx
	andq	$38, %rdx
	negq	%r9
	andq	$38, %r9
	leaq	(%rdx,%r9), %rdx
	shlq	$1, %rdi
	sbbq	%r9, %r9
	andq	$19, %r9
	leaq	(%rdx,%r9), %rdx
	shrq	$1, %rdi
	movq	$0, %r9
	addq	%rdx, %r8
	adcxq	%r9, %rsi
	adcxq	%r9, %rcx
	adcxq	%r9, %rdi
	decq	%rax
	movq	$0, %rdx
	xorq	%rdx, %rdx
	movq	%r8, %rdx
	mulxq	%rsi, %r10, %r9
	mulxq	%rcx, %rbp, %r11
	adcxq	%rbp, %r9
	mulxq	%rdi, %rdx, %rbp
	adcxq	%rdx, %r11
	movq	%rsi, %rdx
	mulxq	%rcx, %r12, %rbx
	adoxq	%r12, %r11
	mulxq	%rdi, %rdx, %r12
	adcxq	%rdx, %rbp
	adoxq	%rbx, %rbp
	movq	$0, %rbx
	adoxq	%rbx, %r12
	movq	%rcx, %rdx
	mulxq	%rdi, %rdx, %r13
	adcxq	%rdx, %r12
	adcxq	%rbx, %r13
	movq	%r8, %rdx
	mulxq	%r8, %r8, %rdx
	adcxq	%r10, %r10
	adoxq	%rdx, %r10
	movq	%rsi, %rdx
	mulxq	%rsi, %rsi, %rdx
	adcxq	%r9, %r9
	adoxq	%rsi, %r9
	adcxq	%r11, %r11
	adoxq	%rdx, %r11
	movq	%rcx, %rdx
	mulxq	%rcx, %rdx, %rcx
	adcxq	%rbp, %rbp
	adoxq	%rdx, %rbp
	adcxq	%r12, %r12
	adoxq	%rcx, %r12
	movq	%rdi, %rdx
	mulxq	%rdi, %rdx, %rcx
	adcxq	%r13, %r13
	adoxq	%rdx, %r13
	adcxq	%rbx, %rbx
	adoxq	%rcx, %rbx
	movq	$38, %rdx
	mulxq	%rbx, %rsi, %rcx
	imulq	$38, %rcx, %rcx
	adcxq	%rcx, %r8
	movq	%r10, %rdi
	mulxq	%rbp, %r10, %rcx
	adoxq	%r10, %r8
	adcxq	%rcx, %rdi
	movq	%r9, %r10
	mulxq	%r12, %r9, %rcx
	adoxq	%r9, %rdi
	adoxq	%rcx, %r10
	mulxq	%r13, %rdx, %rcx
	adcxq	%rdx, %r10
	adcxq	%rcx, %r11
	adoxq	%rsi, %r11
	movq	$0, %rdx
	adoxq	%rdx, %rdx
	sbbq	%rcx, %rcx
	andq	$38, %rcx
	negq	%rdx
	andq	$38, %rdx
	leaq	(%rcx,%rdx), %rcx
	shlq	$1, %r11
	sbbq	%rdx, %rdx
	andq	$19, %rdx
	leaq	(%rcx,%rdx), %rcx
	shrq	$1, %r11
	movq	$0, %rdx
	addq	%rcx, %r8
	adcxq	%rdx, %rdi
	adcxq	%rdx, %r10
	adcxq	%rdx, %r11
	decq	%rax
	jne 	Lfe64_invert_regs$3
	movq	$0, %rax
	xorq	%rax, %rax
	movq	32(%rsp), %rdx
	mulxq	%r8, %rcx, %rax
	mulxq	%rdi, %r9, %rsi
	adcxq	%r9, %rax
	mulxq	%r10, %rbp, %r9
	adcxq	%rbp, %rsi
	mulxq	%r11, %rdx, %rbp
	adcxq	%rdx, %r9
	movq	$0, %rdx
	adcxq	%rdx, %rbp
	movq	40(%rsp), %rdx
	mulxq	%r8, %r12, %rbx
	adoxq	%r12, %rax
	adoxq	%rbx, %rsi
	mulxq	%r10, %r12, %rbx
	adoxq	%r12, %r9
	adoxq	%rbx, %rbp
	movq	$0, %rbx
	adoxq	%rbx, %rbx
	mulxq	%rdi, %r13, %r12
	adcxq	%r13, %rsi
	adcxq	%r12, %r9
	mulxq	%r11, %r12, %rdx
	adcxq	%r12, %rbp
	adcxq	%rdx, %rbx
	movq	48(%rsp), %rdx
	mulxq	%r8, %r13, %r12
	adoxq	%r13, %rsi
	adoxq	%r12, %r9
	mulxq	%r10, %r13, %r12
	adoxq	%r13, %rbp
	adoxq	%r12, %rbx
	movq	$0, %r12
	adoxq	%r12, %r12
	mulxq	%rdi, %r14, %r13
	adcxq	%r14, %r9
	adcxq	%r13, %rbp
	mulxq	%r11, %r13, %rdx
	adcxq	%r13, %rbx
	adcxq	%rdx, %r12
	movq	56(%rsp), %rdx
	mulxq	%r8, %r13, %r8
	adoxq	%r13, %r9
	adoxq	%r8, %rbp
	mulxq	%r10, %r10, %r8
	adoxq	%r10, %rbx
	adoxq	%r8, %r12
	movq	$0, %r8
	adoxq	%r8, %r8
	mulxq	%rdi, %r10, %rdi
	adcxq	%r10, %rbp
	adcxq	%rdi, %rbx
	mulxq	%r11, %rdi, %rdx
	adcxq	%rdi, %r12
	adcxq	%rdx, %r8
	movq	$0, %rdi
	movq	$38, %rdx
	mulxq	%r8, %r10, %r8
	adcxq	%rdi, %r8
	imulq	$38, %r8, %r8
	adcxq	%r8, %rcx
	mulxq	%rbp, %r11, %r8
	adoxq	%r11, %rcx
	adcxq	%r8, %rax
	mulxq	%rbx, %r11, %r8
	adoxq	%r11, %rax
	adoxq	%r8, %rsi
	mulxq	%r12, %r8, %rdx
	adcxq	%r8, %rsi
	adcxq	%rdx, %r9
	adoxq	%r10, %r9
	adoxq	%rdi, %rdi
	sbbq	%rdx, %rdx
	andq	$38, %rdx
	negq	%rdi
	andq	$38, %rdi
	leaq	(%rdx,%rdi), %rdx
	shlq	$1, %r9
	sbbq	%rdi, %rdi
	andq	$19, %rdi
	leaq	(%rdx,%rdi), %rdx
	shrq	$1, %r9
	movq	$0, %rdi
	addq	%rdx, %rcx
	adcxq	%rdi, %rax
	adcxq	%rdi, %rsi
	adcxq	%rdi, %r9
	movq	$50, %rdi
Lfe64_invert_regs$2:
	movq	$0, %rdx
	xorq	%rdx, %rdx
	movq	%rcx, %rdx
	mulxq	%rax, %r10, %r8
	mulxq	%rsi, %rbp, %r11
	adcxq	%rbp, %r8
	mulxq	%r9, %rdx, %rbp
	adcxq	%rdx, %r11
	movq	%rax, %rdx
	mulxq	%rsi, %r12, %rbx
	adoxq	%r12, %r11
	mulxq	%r9, %rdx, %r12
	adcxq	%rdx, %rbp
	adoxq	%rbx, %rbp
	movq	$0, %rbx
	adoxq	%rbx, %r12
	movq	%rsi, %rdx
	mulxq	%r9, %rdx, %r13
	adcxq	%rdx, %r12
	adcxq	%rbx, %r13
	movq	%rcx, %rdx
	mulxq	%rcx, %r14, %rcx
	adcxq	%r10, %r10
	adoxq	%rcx, %r10
	movq	%rax, %rdx
	mulxq	%rax, %rcx, %rax
	adcxq	%r8, %r8
	adoxq	%rcx, %r8
	adcxq	%r11, %r11
	adoxq	%rax, %r11
	movq	%rsi, %rdx
	mulxq	%rsi, %rcx, %rax
	adcxq	%rbp, %rbp
	adoxq	%rcx, %rbp
	adcxq	%r12, %r12
	adoxq	%rax, %r12
	movq	%r9, %rdx
	mulxq	%r9, %rcx, %rax
	adcxq	%r13, %r13
	adoxq	%rcx, %r13
	adcxq	%rbx, %rbx
	adoxq	%rax, %rbx
	movq	$38, %rdx
	mulxq	%rbx, %rcx, %rax
	imulq	$38, %rax, %rax
	adcxq	%rax, %r14
	movq	%r10, %rax
	mulxq	%rbp, %r9, %rsi
	adoxq	%r9, %r14
	adcxq	%rsi, %rax
	movq	%r8, %rsi
	mulxq	%r12, %r9, %r8
	adoxq	%r9, %rax
	adoxq	%r8, %rsi
	movq	%r11, %r8
	mulxq	%r13, %r9, %rdx
	adcxq	%r9, %rsi
	adcxq	%rdx, %r8
	adoxq	%rcx, %r8
	movq	$0, %rcx
	adoxq	%rcx, %rcx
	sbbq	%rdx, %rdx
	andq	$38, %rdx
	negq	%rcx
	andq	$38, %rcx
	leaq	(%rdx,%rcx), %rdx
	shlq	$1, %r8
	sbbq	%rcx, %rcx
	andq	$19, %rcx
	leaq	(%rdx,%rcx), %rcx
	shrq	$1, %r8
	movq	$0, %rdx
	addq	%rcx, %r14
	adcxq	%rdx, %rax
	adcxq	%rdx, %rsi
	adcxq	%rdx, %r8
	decq	%rdi
	movq	$0, %rcx
	xorq	%rcx, %rcx
	movq	%r14, %rdx
	mulxq	%rax, %r10, %r9
	mulxq	%rsi, %rcx, %r11
	adcxq	%rcx, %r9
	mulxq	%r8, %rcx, %rbp
	adcxq	%rcx, %r11
	movq	%rax, %rdx
	mulxq	%rsi, %rbx, %rcx
	adoxq	%rbx, %r11
	mulxq	%r8, %rdx, %rbx
	adcxq	%rdx, %rbp
	adoxq	%rcx, %rbp
	movq	$0, %rcx
	adoxq	%rcx, %rbx
	movq	%rsi, %rdx
	mulxq	%r8, %rdx, %r12
	adcxq	%rdx, %rbx
	adcxq	%rcx, %r12
	movq	%r14, %rdx
	mulxq	%r14, %r13, %rdx
	adcxq	%r10, %r10
	adoxq	%rdx, %r10
	movq	%rax, %rdx
	mulxq	%rax, %rdx, %rax
	adcxq	%r9, %r9
	adoxq	%rdx, %r9
	adcxq	%r11, %r11
	adoxq	%rax, %r11
	movq	%rsi, %rdx
	mulxq	%rsi, %rdx, %rax
	adcxq	%rbp, %rbp
	adoxq	%rdx, %rbp
	adcxq	%rbx, %rbx
	adoxq	%rax, %rbx
	movq	%r8, %rdx
	mulxq	%r8, %rdx, %rax
	adcxq	%r12, %r12
	adoxq	%rdx, %r12
	adcxq	%rcx, %rcx
	adoxq	%rax, %rcx
	movq	$38, %rdx
	mulxq	%rcx, %r8, %rax
	imulq	$38, %rax, %rax
	movq	%r13, %rcx
	adcxq	%rax, %rcx
	movq	%r10, %rax
	mulxq	%rbp, %r10, %rsi
	adoxq	%r10, %rcx
	adcxq	%rsi, %rax
	movq	%r9, %rsi
	mulxq	%rbx, %r10, %r9
	adoxq	%r10, %rax
	adoxq	%r9, %rsi
	movq	%r11, %r9
	mulxq	%r12, %r10, %rdx
	adcxq	%r10, %rsi
	adcxq	%rdx, %r9
	adoxq	%r8, %r9
	movq	$0, %r8
	adoxq	%r8, %r8
	sbbq	%rdx, %rdx
	andq	$38, %rdx
	negq	%r8
	andq	$38, %r8
	leaq	(%rdx,%r8), %rdx
	shlq	$1, %r9
	sbbq	%r8, %r8
	andq	$19, %r8
	leaq	(%rdx,%r8), %rdx
	shrq	$1, %r9
	movq	$0, %r8
	addq	%rdx, %rcx
	adcxq	%r8, %rax
	adcxq	%r8, %rsi
	adcxq	%r8, %r9
	decq	%rdi
	jne 	Lfe64_invert_regs$2
	movq	$0, %rdx
	xorq	%rdx, %rdx
	movq	64(%rsp), %rdx
	mulxq	%rcx, %r8, %rdi
	mulxq	%rax, %r11, %r10
	adcxq	%r11, %rdi
	mulxq	%rsi, %rbp, %r11
	adcxq	%rbp, %r10
	mulxq	%r9, %rdx, %rbp
	adcxq	%rdx, %r11
	movq	$0, %rdx
	adcxq	%rdx, %rbp
	movq	72(%rsp), %rdx
	mulxq	%rcx, %r12, %rbx
	adoxq	%r12, %rdi
	adoxq	%rbx, %r10
	mulxq	%rsi, %r12, %rbx
	adoxq	%r12, %r11
	adoxq	%rbx, %rbp
	movq	$0, %rbx
	adoxq	%rbx, %rbx
	mulxq	%rax, %r13, %r12
	adcxq	%r13, %r10
	adcxq	%r12, %r11
	mulxq	%r9, %r12, %rdx
	adcxq	%r12, %rbp
	adcxq	%rdx, %rbx
	movq	80(%rsp), %rdx
	mulxq	%rcx, %r13, %r12
	adoxq	%r13, %r10
	adoxq	%r12, %r11
	mulxq	%rsi, %r13, %r12
	adoxq	%r13, %rbp
	adoxq	%r12, %rbx
	movq	$0, %r12
	adoxq	%r12, %r12
	mulxq	%rax, %r14, %r13
	adcxq	%r14, %r11
	adcxq	%r13, %rbp
	mulxq	%r9, %r13, %rdx
	adcxq	%r13, %rbx
	adcxq	%rdx, %r12
	movq	88(%rsp), %rdx
	mulxq	%rcx, %r13, %rcx
	adoxq	%r13, %r11
	adoxq	%rcx, %rbp
	mulxq	%rsi, %rsi, %rcx
	adoxq	%rsi, %rbx
	adoxq	%rcx, %r12
	movq	$0, %rcx
	adoxq	%rcx, %rcx
	mulxq	%rax, %rsi, %rax
	adcxq	%rsi, %rbp
	adcxq	%rax, %rbx
	mulxq	%r9, %rdx, %rax
	adcxq	%rdx, %r12
	adcxq	%rax, %rcx
	movq	$0, %rax
	movq	$38, %rdx
	mulxq	%rcx, %rsi, %rcx
	adcxq	%rax, %rcx
	imulq	$38, %rcx, %rcx
	adcxq	%rcx, %r8
	mulxq	%rbp, %r9, %rcx
	adoxq	%r9, %r8
	adcxq	%rcx, %rdi
	mulxq	%rbx, %r9, %rcx
	adoxq	%r9, %rdi
	adoxq	%rcx, %r10
	mulxq	%r12, %rdx, %rcx
	adcxq	%rdx, %r10
	adcxq	%rcx, %r11
	adoxq	%rsi, %r11
	adoxq	%rax, %rax
	sbbq	%rcx, %rcx
	andq	$38, %rcx
	negq	%rax
	andq	$38, %rax
	leaq	(%rcx,%rax), %rcx
	shlq	$1, %r11
	sbbq	%rax, %rax
	andq	$19, %rax
	leaq	(%rcx,%rax), %rax
	shrq	$1, %r11
	movq	$0, %rcx
	addq	%rax, %r8
	adcxq	%rcx, %rdi
	adcxq	%rcx, %r10
	adcxq	%rcx, %r11
	movq	$4, %rax
Lfe64_invert_regs$1:
	movq	$0, %rcx
	xorq	%rcx, %rcx
	movq	%r8, %rdx
	mulxq	%rdi, %rsi, %rcx
	mulxq	%r10, %rbp, %r9
	adcxq	%rbp, %rcx
	mulxq	%r11, %rdx, %rbp
	adcxq	%rdx, %r9
	movq	%rdi, %rdx
	mulxq	%r10, %r12, %rbx
	adoxq	%r12, %r9
	mulxq	%r11, %rdx, %r12
	adcxq	%rdx, %rbp
	adoxq	%rbx, %rbp
	movq	$0, %rbx
	adoxq	%rbx, %r12
	movq	%r10, %rdx
	mulxq	%r11, %rdx, %r13
	adcxq	%rdx, %r12
	adcxq	%rbx, %r13
	movq	%r8, %rdx
	mulxq	%r8, %r8, %rdx
	adcxq	%rsi, %rsi
	adoxq	%rdx, %rsi
	movq	%rdi, %rdx
	mulxq	%rdi, %rdi, %rdx
	adcxq	%rcx, %rcx
	adoxq	%rdi, %rcx
	adcxq	%r9, %r9
	adoxq	%rdx, %r9
	movq	%r10, %rdx
	mulxq	%r10, %rdi, %rdx
	adcxq	%rbp, %rbp
	adoxq	%rdi, %rbp
	adcxq	%r12, %r12
	adoxq	%rdx, %r12
	movq	%r11, %rdx
	mulxq	%r11, %rdi, %rdx
	adcxq	%r13, %r13
	adoxq	%rdi, %r13
	adcxq	%rbx, %rbx
	adoxq	%rdx, %rbx
	movq	$38, %rdx
	mulxq	%rbx, %r10, %rdi
	imulq	$38, %rdi, %rdi
	adcxq	%rdi, %r8
	mulxq	%rbp, %r11, %rdi
	adoxq	%r11, %r8
	adcxq	%rdi, %rsi
	mulxq	%r12, %r11, %rdi
	adoxq	%r11, %rsi
	adoxq	%rdi, %rcx
	movq	%r9, %rdi
	mulxq	%r13, %r9, %rdx
	adcxq	%r9, %rcx
	adcxq	%rdx, %rdi
	adoxq	%r10, %rdi
	movq	$0, %r9
	adoxq	%r9, %r9
	sbbq	%rdx, %rdx
	andq	$38, %rdx
	negq	%r9
	andq	$38, %r9
	leaq	(%rdx,%r9), %rdx
	shlq	$1, %rdi
	sbbq	%r9, %r9
	andq	$19, %r9
	leaq	(%rdx,%r9), %rdx
	shrq	$1, %rdi
	movq	$0, %r9
	addq	%rdx, %r8
	adcxq	%r9, %rsi
	adcxq	%r9, %rcx
	adcxq	%r9, %rdi
	decq	%rax
	movq	$0, %rdx
	xorq	%rdx, %rdx
	movq	%r8, %rdx
	mulxq	%rsi, %r10, %r9
	mulxq	%rcx, %rbp, %r11
	adcxq	%rbp, %r9
	mulxq	%rdi, %rdx, %rbp
	adcxq	%rdx, %r11
	movq	%rsi, %rdx
	mulxq	%rcx, %r12, %rbx
	adoxq	%r12, %r11
	mulxq	%rdi, %rdx, %r12
	adcxq	%rdx, %rbp
	adoxq	%rbx, %rbp
	movq	$0, %rbx
	adoxq	%rbx, %r12
	movq	%rcx, %rdx
	mulxq	%rdi, %rdx, %r13
	adcxq	%rdx, %r12
	adcxq	%rbx, %r13
	movq	%r8, %rdx
	mulxq	%r8, %r8, %rdx
	adcxq	%r10, %r10
	adoxq	%rdx, %r10
	movq	%rsi, %rdx
	mulxq	%rsi, %rsi, %rdx
	adcxq	%r9, %r9
	adoxq	%rsi, %r9
	adcxq	%r11, %r11
	adoxq	%rdx, %r11
	movq	%rcx, %rdx
	mulxq	%rcx, %rdx, %rcx
	adcxq	%rbp, %rbp
	adoxq	%rdx, %rbp
	adcxq	%r12, %r12
	adoxq	%rcx, %r12
	movq	%rdi, %rdx
	mulxq	%rdi, %rdx, %rcx
	adcxq	%r13, %r13
	adoxq	%rdx, %r13
	adcxq	%rbx, %rbx
	adoxq	%rcx, %rbx
	movq	$38, %rdx
	mulxq	%rbx, %rsi, %rcx
	imulq	$38, %rcx, %rcx
	adcxq	%rcx, %r8
	movq	%r10, %rdi
	mulxq	%rbp, %r10, %rcx
	adoxq	%r10, %r8
	adcxq	%rcx, %rdi
	movq	%r9, %r10
	mulxq	%r12, %r9, %rcx
	adoxq	%r9, %rdi
	adoxq	%rcx, %r10
	mulxq	%r13, %rdx, %rcx
	adcxq	%rdx, %r10
	adcxq	%rcx, %r11
	adoxq	%rsi, %r11
	movq	$0, %rdx
	adoxq	%rdx, %rdx
	sbbq	%rcx, %rcx
	andq	$38, %rcx
	negq	%rdx
	andq	$38, %rdx
	leaq	(%rcx,%rdx), %rcx
	shlq	$1, %r11
	sbbq	%rdx, %rdx
	andq	$19, %rdx
	leaq	(%rcx,%rdx), %rcx
	shrq	$1, %r11
	movq	$0, %rdx
	addq	%rcx, %r8
	adcxq	%rdx, %rdi
	adcxq	%rdx, %r10
	adcxq	%rdx, %r11
	decq	%rax
	jne 	Lfe64_invert_regs$1
	movq	$0, %rax
	xorq	%rax, %rax
	movq	%r8, %rdx
	mulxq	%rdi, %rcx, %rax
	mulxq	%r10, %r9, %rsi
	adcxq	%r9, %rax
	mulxq	%r11, %rdx, %r9
	adcxq	%rdx, %rsi
	movq	%rdi, %rdx
	mulxq	%r10, %rbx, %rbp
	adoxq	%rbx, %rsi
	mulxq	%r11, %rdx, %rbx
	adcxq	%rdx, %r9
	adoxq	%rbp, %r9
	movq	$0, %rbp
	adoxq	%rbp, %rbx
	movq	%r10, %rdx
	mulxq	%r11, %rdx, %r12
	adcxq	%rdx, %rbx
	adcxq	%rbp, %r12
	movq	%r8, %rdx
	mulxq	%r8, %r8, %rdx
	adcxq	%rcx, %rcx
	adoxq	%rdx, %rcx
	movq	%rdi, %rdx
	mulxq	%rdi, %rdi, %rdx
	adcxq	%rax, %rax
	adoxq	%rdi, %rax
	adcxq	%rsi, %rsi
	adoxq	%rdx, %rsi
	movq	%r10, %rdx
	mulxq	%r10, %rdi, %rdx
	adcxq	%r9, %r9
	adoxq	%rdi, %r9
	adcxq	%rbx, %rbx
	adoxq	%rdx, %rbx
	movq	%r11, %rdx
	mulxq	%r11, %rdi, %rdx
	adcxq	%r12, %r12
	adoxq	%rdi, %r12
	adcxq	%rbp, %rbp
	adoxq	%rdx, %rbp
	movq	$38, %rdx
	mulxq	%rbp, %r10, %rdi
	imulq	$38, %rdi, %rdi
	adcxq	%rdi, %r8
	mulxq	%r9, %r9, %rdi
	adoxq	%r9, %r8
	adcxq	%rdi, %rcx
	mulxq	%rbx, %r9, %rdi
	adoxq	%r9, %rcx
	adoxq	%rdi, %rax
	mulxq	%r12, %rdi, %rdx
	adcxq	%rdi, %rax
	adcxq	%rdx, %rsi
	adoxq	%r10, %rsi
	movq	$0, %rdi
	adoxq	%rdi, %rdi
	sbbq	%rdx, %rdx
	andq	$38, %rdx
	negq	%rdi
	andq	$38, %rdi
	leaq	(%rdx,%rdi), %rdx
	shlq	$1, %rsi
	sbbq	%rdi, %rdi
	andq	$19, %rdi
	leaq	(%rdx,%rdi), %rdx
	shrq	$1, %rsi
	movq	$0, %rdi
	addq	%rdx, %r8
	adcxq	%rdi, %rcx
	adcxq	%rdi, %rax
	adcxq	%rdi, %rsi
	movq	$0, %rdx
	xorq	%rdx, %rdx
	movq	(%rsp), %rdx
	mulxq	%r8, %r9, %rdi
	mulxq	%rcx, %r11, %r10
	adcxq	%r11, %rdi
	mulxq	%rax, %rbp, %r11
	adcxq	%rbp, %r10
	mulxq	%rsi, %rdx, %rbp
	adcxq	%rdx, %r11
	movq	$0, %rdx
	adcxq	%rdx, %rbp
	movq	8(%rsp), %rdx
	mulxq	%r8, %r12, %rbx
	adoxq	%r12, %rdi
	adoxq	%rbx, %r10
	mulxq	%rax, %r12, %rbx
	adoxq	%r12, %r11
	adoxq	%rbx, %rbp
	movq	$0, %rbx
	adoxq	%rbx, %rbx
	mulxq	%rcx, %r13, %r12
	adcxq	%r13, %r10
	adcxq	%r12, %r11
	mulxq	%rsi, %r12, %rdx
	adcxq	%r12, %rbp
	adcxq	%rdx, %rbx
	movq	16(%rsp), %rdx
	mulxq	%r8, %r13, %r12
	adoxq	%r13, %r10
	adoxq	%r12, %r11
	mulxq	%rax, %r13, %r12
	adoxq	%r13, %rbp
	adoxq	%r12, %rbx
	movq	$0, %r12
	adoxq	%r12, %r12
	mulxq	%rcx, %r14, %r13
	adcxq	%r14, %r11
	adcxq	%r13, %rbp
	mulxq	%rsi, %r13, %rdx
	adcxq	%r13, %rbx
	adcxq	%rdx, %r12
	movq	24(%rsp), %rdx
	mulxq	%r8, %r13, %r8
	adoxq	%r13, %r11
	adoxq	%r8, %rbp
	mulxq	%rax, %r8, %rax
	adoxq	%r8, %rbx
	adoxq	%rax, %r12
	movq	$0, %rax
	adoxq	%rax, %rax
	mulxq	%rcx, %r8, %rcx
	adcxq	%r8, %rbp
	adcxq	%rcx, %rbx
	mulxq	%rsi, %rdx, %rcx
	adcxq	%rdx, %r12
	adcxq	%rcx, %rax
	movq	$0, %rcx
	movq	$38, %rdx
	mulxq	%rax, %rsi, %rax
	adcxq	%rcx, %rax
	imulq	$38, %rax, %rax
	adcxq	%rax, %r9
	mulxq	%rbp, %r8, %rax
	adoxq	%r8, %r9
	adcxq	%rax, %rdi
	mulxq	%rbx, %r8, %rax
	adoxq	%r8, %rdi
	adoxq	%rax, %r10
	mulxq	%r12, %rdx, %rax
	adcxq	%rdx, %r10
	adcxq	%rax, %r11
	adoxq	%rsi, %r11
	adoxq	%rcx, %rcx
	sbbq	%rax, %rax
	andq	$38, %rax
	negq	%rcx
	andq	$38, %rcx
	leaq	(%rax,%rcx), %rax
	shlq	$1, %r11
	sbbq	%rcx, %rcx
	andq	$19, %rcx
	leaq	(%rax,%rcx), %rax
	shrq	$1, %r11
	movq	$0, %rcx
	addq	%rax, %r9
	adcxq	%rcx, %rdi
	adcxq	%rcx, %r10
	adcxq	%rcx, %r11
	movq	128(%rsp), %rax
	movq	%r9, (%rax)
	movq	%rdi, 8(%rax)
	movq	%r10, 16(%rax)
	movq	%r11, 24(%rax)
	addq	$136, %rsp
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	ret 

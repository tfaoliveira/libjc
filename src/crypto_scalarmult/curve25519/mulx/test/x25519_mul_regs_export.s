	.text
	.p2align	5
	.globl	_fe64_mul_regs
	.globl	fe64_mul_regs
_fe64_mul_regs:
fe64_mul_regs:
	pushq	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$40, %rsp
	movq	%rdi, 32(%rsp)
	movq	(%rsi), %rax
	movq	%rax, (%rsp)
	movq	8(%rsi), %rax
	movq	%rax, 8(%rsp)
	movq	16(%rsi), %rax
	movq	%rax, 16(%rsp)
	movq	24(%rsi), %rax
	movq	%rax, 24(%rsp)
	movq	(%rdx), %rax
	movq	8(%rdx), %rcx
	movq	16(%rdx), %rsi
	movq	24(%rdx), %rdi
	movq	$0, %rdx
	xorq	%rdx, %rdx
	movq	(%rsp), %rdx
	mulxq	%rax, %r9, %r8
	mulxq	%rcx, %r11, %r10
	adcxq	%r11, %r8
	mulxq	%rsi, %rbp, %r11
	adcxq	%rbp, %r10
	mulxq	%rdi, %rdx, %rbp
	adcxq	%rdx, %r11
	movq	$0, %rdx
	adcxq	%rdx, %rbp
	movq	8(%rsp), %rdx
	mulxq	%rax, %r12, %rbx
	adoxq	%r12, %r8
	adoxq	%rbx, %r10
	mulxq	%rsi, %r12, %rbx
	adoxq	%r12, %r11
	adoxq	%rbx, %rbp
	movq	$0, %rbx
	adoxq	%rbx, %rbx
	mulxq	%rcx, %r13, %r12
	adcxq	%r13, %r10
	adcxq	%r12, %r11
	mulxq	%rdi, %r12, %rdx
	adcxq	%r12, %rbp
	adcxq	%rdx, %rbx
	movq	16(%rsp), %rdx
	mulxq	%rax, %r13, %r12
	adoxq	%r13, %r10
	adoxq	%r12, %r11
	mulxq	%rsi, %r13, %r12
	adoxq	%r13, %rbp
	adoxq	%r12, %rbx
	movq	$0, %r12
	adoxq	%r12, %r12
	mulxq	%rcx, %r14, %r13
	adcxq	%r14, %r11
	adcxq	%r13, %rbp
	mulxq	%rdi, %r13, %rdx
	adcxq	%r13, %rbx
	adcxq	%rdx, %r12
	movq	24(%rsp), %rdx
	mulxq	%rax, %r13, %rax
	adoxq	%r13, %r11
	adoxq	%rax, %rbp
	mulxq	%rsi, %rsi, %rax
	adoxq	%rsi, %rbx
	adoxq	%rax, %r12
	movq	$0, %rax
	adoxq	%rax, %rax
	mulxq	%rcx, %rsi, %rcx
	adcxq	%rsi, %rbp
	adcxq	%rcx, %rbx
	mulxq	%rdi, %rdx, %rcx
	adcxq	%rdx, %r12
	adcxq	%rcx, %rax
	movq	$0, %rcx
	movq	$38, %rdx
	mulxq	%rax, %rsi, %rax
	adcxq	%rcx, %rax
	imulq	$38, %rax, %rax
	adcxq	%rax, %r9
	mulxq	%rbp, %rdi, %rax
	adoxq	%rdi, %r9
	adcxq	%rax, %r8
	mulxq	%rbx, %rdi, %rax
	adoxq	%rdi, %r8
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
	adcxq	%rcx, %r8
	adcxq	%rcx, %r10
	adcxq	%rcx, %r11
	movq	32(%rsp), %rax
	movq	%r9, (%rax)
	movq	%r8, 8(%rax)
	movq	%r10, 16(%rax)
	movq	%r11, 24(%rax)
	addq	$40, %rsp
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	ret 

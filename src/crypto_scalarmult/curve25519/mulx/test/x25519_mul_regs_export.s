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
	subq	$8, %rsp
	movq	%rdi, (%rsp)
	movq	(%rsi), %rax
	movq	(%rdx), %rcx
	movq	8(%rsi), %rdi
	movq	8(%rdx), %r8
	movq	16(%rsi), %r9
	movq	16(%rdx), %r10
	movq	24(%rsi), %rsi
	movq	24(%rdx), %r11
	xorq	%rbp, %rbp
	movq	%r11, %rdx
	mulxq	%rdi, %rbx, %rbp
	mulxq	%r9, %rdx, %r12
	adcxq	%rdx, %rbp
	movq	%rsi, %rdx
	mulxq	%r10, %r14, %r13
	adoxq	%r14, %rbp
	adcxq	%r13, %r12
	mulxq	%r11, %r14, %r13
	adoxq	%r14, %r12
	movq	$0, %r14
	movq	$0, %r15
	adcxq	%r14, %r13
	adoxq	%r14, %r13
	adcxq	%r14, %r14
	adoxq	%r15, %r14
	mulxq	%r8, %r15, %rdx
	adcxq	%r15, %rbx
	adcxq	%rdx, %rbp
	movq	%r9, %rdx
	mulxq	%r10, %r15, %rdx
	adoxq	%r15, %rbx
	adoxq	%rdx, %rbp
	movq	$0, %rdx
	adcxq	%rdx, %r12
	adoxq	%rdx, %r12
	adcxq	%rdx, %r13
	adoxq	%rdx, %r13
	adcxq	%rdx, %r14
	adoxq	%rdx, %r14
	movq	$38, %rdx
	mulxq	%r14, %r15, %r14
	mulxq	%rbx, %r14, %rbx
	mulxq	%rbp, %rbp, %rdx
	adcxq	%rbx, %rbp
	movq	%rdx, %rbx
	movq	$38, %rdx
	mulxq	%r12, %r12, %rdx
	adcxq	%rbx, %r12
	movq	%rdx, %rbx
	movq	$38, %rdx
	mulxq	%r13, %r13, %rdx
	adcxq	%rbx, %r13
	adcxq	%rdx, %r15
	movq	$38, %rdx
	mulxq	%r15, %rbx, %rdx
	adcxq	%rbx, %r14
	movq	%rax, %rdx
	mulxq	%rcx, %r15, %rbx
	adoxq	%r15, %r14
	adcxq	%rbx, %rbp
	mulxq	%r8, %r15, %rbx
	adoxq	%r15, %rbp
	adcxq	%rbx, %r12
	mulxq	%r10, %rbx, %rdx
	movq	$0, %r15
	adoxq	%rbx, %r12
	adcxq	%rdx, %r13
	movq	$0, %rbx
	adoxq	%r15, %r13
	adcxq	%r15, %rbx
	adoxq	%r15, %rbx
	movq	%rdi, %rdx
	mulxq	%rcx, %r15, %rdx
	adcxq	%r15, %rbp
	adcxq	%rdx, %r12
	movq	%rdi, %rdx
	mulxq	%r10, %r10, %rdx
	adcxq	%r10, %r13
	adcxq	%rdx, %rbx
	movq	%rax, %rdx
	mulxq	%r11, %rdx, %rax
	adoxq	%rdx, %r13
	adoxq	%rax, %rbx
	movq	$0, %rax
	movq	$0, %rdx
	adcxq	%rdx, %rax
	adoxq	%rdx, %rax
	movq	%r9, %rdx
	mulxq	%r8, %r10, %rdx
	adcxq	%r10, %r13
	adcxq	%rdx, %rbx
	movq	%rsi, %rdx
	mulxq	%rcx, %rsi, %rdx
	adoxq	%rsi, %r13
	adoxq	%rdx, %rbx
	movq	$0, %rdx
	adcxq	%rdx, %rax
	adoxq	%rdx, %rax
	movq	$38, %rdx
	mulxq	%rbx, %r10, %rsi
	mulxq	%rax, %rdx, %rax
	adcxq	%rsi, %rdx
	adcxq	%r10, %r14
	adcxq	%rdx, %rbp
	movq	%rdi, %rdx
	mulxq	%r8, %rdx, %rax
	adcxq	%rdx, %r12
	adcxq	%rax, %r13
	movq	$0, %rax
	adcxq	%rax, %rax
	movq	%r9, %rdx
	mulxq	%rcx, %rdx, %rcx
	adcxq	%rdx, %r12
	adcxq	%rcx, %r13
	movq	$0, %rcx
	adcxq	%rcx, %rax
	shlq	$1, %rax
	shlq	$1, %r13
	adcxq	%rcx, %rax
	shrq	$1, %r13
	imulq	$19, %rax, %rax
	adcxq	%rax, %r14
	adcxq	%rcx, %rbp
	adcxq	%rcx, %r12
	adcxq	%rcx, %r13
	movq	(%rsp), %rax
	movq	%r14, (%rax)
	movq	%rbp, 8(%rax)
	movq	%r12, 16(%rax)
	movq	%r13, 24(%rax)
	addq	$8, %rsp
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	ret 

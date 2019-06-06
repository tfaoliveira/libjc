	.text
	.p2align	5
	.globl	_fe64_mul
	.globl	fe64_mul
_fe64_mul:
fe64_mul:
	pushq	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$40, %rsp
	movq	%rdi, (%rsp)
	movq	(%rsi), %rax
	movq	%rax, 8(%rsp)
	movq	8(%rsi), %rax
	movq	%rax, 16(%rsp)
	movq	16(%rsi), %rax
	movq	%rax, 24(%rsp)
	movq	24(%rsi), %rax
	movq	%rax, 32(%rsp)
	movq	(%rdx), %rax
	movq	8(%rdx), %rcx
	movq	16(%rdx), %rsi
	movq	24(%rdx), %rdi
	xorl	%r8d, %r8d
	xorq	%r8, %r8
	movq	8(%rsp), %rdx
	mulxq	%rax, %r10, %r9
	mulxq	%rcx, %rbp, %r11
	adcxq	%rbp, %r9
	mulxq	%rsi, %rbx, %rbp
	adcxq	%rbx, %r11
	mulxq	%rdi, %rdx, %rbx
	adcxq	%rdx, %rbp
	adcxq	%r8, %rbx
	movq	16(%rsp), %rdx
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
	movq	24(%rsp), %rdx
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
	movq	32(%rsp), %rdx
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
	movq	(%rsp), %rcx
	movq	%rax, (%rcx)
	movq	%r9, 8(%rcx)
	movq	%r11, 16(%rcx)
	movq	%rbp, 24(%rcx)
	addq	$40, %rsp
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	ret 

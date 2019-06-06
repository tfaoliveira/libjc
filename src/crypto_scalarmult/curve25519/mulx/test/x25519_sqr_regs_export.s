	.text
	.p2align	5
	.globl	_fe64_sqr_regs
	.globl	fe64_sqr_regs
_fe64_sqr_regs:
fe64_sqr_regs:
	pushq	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$8, %rsp
	movq	%rdi, (%rsp)
	movq	(%rsi), %rax
	movq	8(%rsi), %rcx
	movq	16(%rsi), %rdi
	movq	24(%rsi), %rsi
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
	movq	(%rsp), %rcx
	movq	%r13, (%rcx)
	movq	%rax, 8(%rcx)
	movq	%rsi, 16(%rcx)
	movq	%rdi, 24(%rcx)
	addq	$8, %rsp
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	ret 

	.text
	.p2align	5
	.globl	_fe64_sqr
	.globl	fe64_sqr
_fe64_sqr:
fe64_sqr:
	pushq	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$8, %rsp
	movq	%rdi, (%rsp)
	movq	(%rsi), %rdx
	movq	8(%rsi), %rax
	movq	16(%rsi), %rcx
	movq	24(%rsi), %rsi
	movq	$0, %rdi
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
	movq	(%rsp), %rcx
	movq	%rax, (%rcx)
	movq	%r11, 8(%rcx)
	movq	%r10, 16(%rcx)
	movq	%rbp, 24(%rcx)
	addq	$8, %rsp
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	ret 

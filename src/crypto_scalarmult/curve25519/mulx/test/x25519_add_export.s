	.text
	.p2align	5
	.globl	_fe64_add
	.globl	fe64_add
_fe64_add:
fe64_add:
	pushq	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$32, %rsp
	movq	(%rsi), %rax
	movq	8(%rsi), %rcx
	movq	16(%rsi), %r8
	movq	24(%rsi), %rsi
	movq	(%rdx), %r9
	movq	%r9, (%rsp)
	movq	8(%rdx), %r9
	movq	%r9, 8(%rsp)
	movq	16(%rdx), %r9
	movq	%r9, 16(%rsp)
	movq	24(%rdx), %rdx
	movq	%rdx, 24(%rsp)
	movq	$0, %rdx
	addq	(%rsp), %rax
	adcq	8(%rsp), %rcx
	adcq	16(%rsp), %r8
	adcq	24(%rsp), %rsi
	sbbq	%rdx, %rdx
	andq	$38, %rdx
	addq	%rdx, %rax
	adcq	$0, %rcx
	adcq	$0, %r8
	adcq	$0, %rsi
	sbbq	%rdx, %rdx
	andq	$38, %rdx
	leaq	(%rax,%rdx), %rax
	movq	%rax, (%rdi)
	movq	%rcx, 8(%rdi)
	movq	%r8, 16(%rdi)
	movq	%rsi, 24(%rdi)
	addq	$32, %rsp
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	ret 

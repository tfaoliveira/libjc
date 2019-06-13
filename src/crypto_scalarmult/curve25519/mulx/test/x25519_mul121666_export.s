	.text
	.p2align	5
	.globl	_fe64_mul121666
	.globl	fe64_mul121666
_fe64_mul121666:
fe64_mul121666:
	pushq	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$32, %rsp
	movq	(%rsi), %rax
	movq	%rax, (%rsp)
	movq	8(%rsi), %rax
	movq	%rax, 8(%rsp)
	movq	16(%rsi), %rax
	movq	%rax, 16(%rsp)
	movq	24(%rsi), %rax
	movq	%rax, 24(%rsp)
	movq	$121666, %rdx
	mulxq	(%rsp), %rcx, %rax
	mulxq	8(%rsp), %r8, %rsi
	addq	%r8, %rax
	mulxq	16(%rsp), %r9, %r8
	adcq	%r9, %rsi
	mulxq	24(%rsp), %r10, %r9
	adcq	%r10, %r8
	adcq	$0, %r9
	imulq	$38, %r9, %r9
	addq	%r9, %rcx
	adcq	$0, %rax
	adcq	$0, %rsi
	adcq	$0, %r8
	sbbq	%rdx, %rdx
	andq	$38, %rdx
	leaq	(%rcx,%rdx), %rcx
	movq	%rcx, (%rdi)
	movq	%rax, 8(%rdi)
	movq	%rsi, 16(%rdi)
	movq	%r8, 24(%rdi)
	addq	$32, %rsp
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	ret 

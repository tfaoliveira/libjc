	.text
	.p2align	5
	.globl	_fe64_tobytes
	.globl	fe64_tobytes
_fe64_tobytes:
fe64_tobytes:
	pushq	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	movq	(%rsi), %rax
	movq	8(%rsi), %rcx
	movq	16(%rsi), %rdx
	movq	24(%rsi), %rsi
	leaq	(%rsi,%rsi), %r8
	sarq	$63, %rsi
	shrq	$1, %r8
	andq	$19, %rsi
	leaq	19(%rsi), %rsi
	addq	%rsi, %rax
	adcq	$0, %rcx
	adcq	$0, %rdx
	adcq	$0, %r8
	leaq	(%r8,%r8), %rsi
	sarq	$63, %r8
	shrq	$1, %rsi
	notq	%r8
	andq	$19, %r8
	subq	%r8, %rax
	sbbq	$0, %rcx
	sbbq	$0, %rdx
	sbbq	$0, %rsi
	movq	%rax, (%rdi)
	movq	%rcx, 8(%rdi)
	movq	%rdx, 16(%rdi)
	movq	%rsi, 24(%rdi)
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	ret 

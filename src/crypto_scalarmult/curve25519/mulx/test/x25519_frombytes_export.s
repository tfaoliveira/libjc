	.text
	.p2align	5
	.globl	_fe64_frombytes
	.globl	fe64_frombytes
_fe64_frombytes:
fe64_frombytes:
	pushq	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$64, %rsp
	movq	(%rdx), %rax
	movq	%rax, 32(%rsp)
	movq	%rax, (%rsp)
	movq	8(%rdx), %rax
	movq	%rax, 40(%rsp)
	movq	%rax, 8(%rsp)
	movq	16(%rdx), %rax
	movq	%rax, 48(%rsp)
	movq	%rax, 16(%rsp)
	movq	24(%rdx), %rax
	movq	$9223372036854775807, %rcx
	andq	%rcx, %rax
	movq	%rax, 56(%rsp)
	movq	%rax, 24(%rsp)
	movq	32(%rsp), %rax
	movq	%rax, (%rdi)
	movq	(%rsp), %rax
	movq	%rax, (%rsi)
	movq	40(%rsp), %rax
	movq	%rax, 8(%rdi)
	movq	8(%rsp), %rax
	movq	%rax, 8(%rsi)
	movq	48(%rsp), %rax
	movq	%rax, 16(%rdi)
	movq	16(%rsp), %rax
	movq	%rax, 16(%rsi)
	movq	56(%rsp), %rax
	movq	%rax, 24(%rdi)
	movq	24(%rsp), %rax
	movq	%rax, 24(%rsi)
	addq	$64, %rsp
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	ret 

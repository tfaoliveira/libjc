	.text
	.p2align	5
	.globl	_KeccakF1600_x86_64_STATE_IN_STACK_0
	.globl	KeccakF1600_x86_64_STATE_IN_STACK_0
_KeccakF1600_x86_64_STATE_IN_STACK_0:
KeccakF1600_x86_64_STATE_IN_STACK_0:
	pushq	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	subq	$8, %rsp
	leaq	100(%rdi), %rax
	leaq	200(%rax), %rcx
LKeccakF1600_x86_64_STATE_IN_STACK_0$1:
	movq	(%rsi), %rdx
	movq	%rdx, (%rsp)
	movq	-100(%rax), %rdx
	xorq	-60(%rax), %rdx
	xorq	-20(%rax), %rdx
	xorq	20(%rax), %rdx
	xorq	60(%rax), %rdx
	movq	-92(%rax), %rdi
	xorq	-52(%rax), %rdi
	xorq	-12(%rax), %rdi
	xorq	28(%rax), %rdi
	xorq	68(%rax), %rdi
	movq	-84(%rax), %r8
	xorq	-44(%rax), %r8
	xorq	-4(%rax), %r8
	xorq	36(%rax), %r8
	xorq	76(%rax), %r8
	movq	-76(%rax), %r9
	xorq	-36(%rax), %r9
	xorq	4(%rax), %r9
	xorq	44(%rax), %r9
	xorq	84(%rax), %r9
	movq	-68(%rax), %r10
	xorq	-28(%rax), %r10
	xorq	12(%rax), %r10
	xorq	52(%rax), %r10
	xorq	92(%rax), %r10
	movq	%rdi, %r11
	rolq	$1, %r11
	xorq	%r10, %r11
	movq	%r8, %rbp
	rolq	$1, %rbp
	xorq	%rdx, %rbp
	movq	%r9, %rbx
	rolq	$1, %rbx
	xorq	%rdi, %rbx
	movq	%r10, %rdi
	rolq	$1, %rdi
	xorq	%r8, %rdi
	rolq	$1, %rdx
	xorq	%r9, %rdx
	movq	-100(%rax), %r8
	xorq	%r11, %r8
	movq	-52(%rax), %r9
	xorq	%rbp, %r9
	rolq	$44, %r9
	movq	-4(%rax), %r10
	xorq	%rbx, %r10
	rolq	$43, %r10
	movq	44(%rax), %r12
	xorq	%rdi, %r12
	rolq	$21, %r12
	movq	92(%rax), %r13
	xorq	%rdx, %r13
	rolq	$14, %r13
	andnq	%r10, %r9, %r14
	xorq	(%rsp), %r14
	xorq	%r8, %r14
	movq	%r14, -100(%rcx)
	andnq	%r12, %r10, %r14
	xorq	%r9, %r14
	movq	%r14, -92(%rcx)
	andnq	%r13, %r12, %r14
	xorq	%r10, %r14
	movq	%r14, -84(%rcx)
	andnq	%r8, %r13, %r10
	xorq	%r12, %r10
	movq	%r10, -76(%rcx)
	andnq	%r9, %r8, %r8
	xorq	%r13, %r8
	movq	%r8, -68(%rcx)
	movq	-76(%rax), %r8
	xorq	%rdi, %r8
	rolq	$28, %r8
	movq	-28(%rax), %r9
	xorq	%rdx, %r9
	rolq	$20, %r9
	movq	-20(%rax), %r10
	xorq	%r11, %r10
	rolq	$3, %r10
	movq	28(%rax), %r12
	xorq	%rbp, %r12
	rolq	$45, %r12
	movq	76(%rax), %r13
	xorq	%rbx, %r13
	rolq	$61, %r13
	andnq	%r10, %r9, %r14
	xorq	%r8, %r14
	movq	%r14, -60(%rcx)
	andnq	%r12, %r10, %r14
	xorq	%r9, %r14
	movq	%r14, -52(%rcx)
	andnq	%r13, %r12, %r14
	xorq	%r10, %r14
	movq	%r14, -44(%rcx)
	andnq	%r8, %r13, %r10
	xorq	%r12, %r10
	movq	%r10, -36(%rcx)
	andnq	%r9, %r8, %r8
	xorq	%r13, %r8
	movq	%r8, -28(%rcx)
	movq	-92(%rax), %r8
	xorq	%rbp, %r8
	rolq	$1, %r8
	movq	-44(%rax), %r9
	xorq	%rbx, %r9
	rolq	$6, %r9
	movq	4(%rax), %r10
	xorq	%rdi, %r10
	rolq	$25, %r10
	movq	52(%rax), %r12
	xorq	%rdx, %r12
	rolq	$8, %r12
	movq	60(%rax), %r13
	xorq	%r11, %r13
	rolq	$18, %r13
	andnq	%r10, %r9, %r14
	xorq	%r8, %r14
	movq	%r14, -20(%rcx)
	andnq	%r12, %r10, %r14
	xorq	%r9, %r14
	movq	%r14, -12(%rcx)
	andnq	%r13, %r12, %r14
	xorq	%r10, %r14
	movq	%r14, -4(%rcx)
	andnq	%r8, %r13, %r10
	xorq	%r12, %r10
	movq	%r10, 4(%rcx)
	andnq	%r9, %r8, %r8
	xorq	%r13, %r8
	movq	%r8, 12(%rcx)
	movq	-68(%rax), %r8
	xorq	%rdx, %r8
	rolq	$27, %r8
	movq	-60(%rax), %r9
	xorq	%r11, %r9
	rolq	$36, %r9
	movq	-12(%rax), %r10
	xorq	%rbp, %r10
	rolq	$10, %r10
	movq	36(%rax), %r12
	xorq	%rbx, %r12
	rolq	$15, %r12
	movq	84(%rax), %r13
	xorq	%rdi, %r13
	rolq	$56, %r13
	andnq	%r10, %r9, %r14
	xorq	%r8, %r14
	movq	%r14, 20(%rcx)
	andnq	%r12, %r10, %r14
	xorq	%r9, %r14
	movq	%r14, 28(%rcx)
	andnq	%r13, %r12, %r14
	xorq	%r10, %r14
	movq	%r14, 36(%rcx)
	andnq	%r8, %r13, %r10
	xorq	%r12, %r10
	movq	%r10, 44(%rcx)
	andnq	%r9, %r8, %r8
	xorq	%r13, %r8
	movq	%r8, 52(%rcx)
	movq	-84(%rax), %r8
	xorq	%rbx, %r8
	rolq	$62, %r8
	movq	-36(%rax), %r9
	xorq	%rdi, %r9
	rolq	$55, %r9
	movq	%r9, %rdi
	movq	12(%rax), %r9
	xorq	%rdx, %r9
	rolq	$39, %r9
	movq	%r9, %rdx
	movq	20(%rax), %r9
	xorq	%r11, %r9
	rolq	$41, %r9
	movq	68(%rax), %r10
	xorq	%rbp, %r10
	rolq	$2, %r10
	andnq	%rdx, %rdi, %r11
	xorq	%r8, %r11
	movq	%r11, 60(%rcx)
	andnq	%r9, %rdx, %r11
	xorq	%rdi, %r11
	movq	%r11, 68(%rcx)
	andnq	%r10, %r9, %r11
	xorq	%rdx, %r11
	movq	%r11, 76(%rcx)
	andnq	%r8, %r10, %rdx
	xorq	%r9, %rdx
	movq	%rdx, 84(%rcx)
	andnq	%rdi, %r8, %rdx
	xorq	%r10, %rdx
	movq	%rdx, 92(%rcx)
	movq	8(%rsi), %rdx
	movq	%rdx, (%rsp)
	movq	-100(%rcx), %rdx
	xorq	-60(%rcx), %rdx
	xorq	-20(%rcx), %rdx
	xorq	20(%rcx), %rdx
	xorq	60(%rcx), %rdx
	movq	-92(%rcx), %rdi
	xorq	-52(%rcx), %rdi
	xorq	-12(%rcx), %rdi
	xorq	28(%rcx), %rdi
	xorq	68(%rcx), %rdi
	movq	-84(%rcx), %r8
	xorq	-44(%rcx), %r8
	xorq	-4(%rcx), %r8
	xorq	36(%rcx), %r8
	xorq	76(%rcx), %r8
	movq	-76(%rcx), %r9
	xorq	-36(%rcx), %r9
	xorq	4(%rcx), %r9
	xorq	44(%rcx), %r9
	xorq	84(%rcx), %r9
	movq	-68(%rcx), %r10
	xorq	-28(%rcx), %r10
	xorq	12(%rcx), %r10
	xorq	52(%rcx), %r10
	xorq	92(%rcx), %r10
	movq	%rdi, %r11
	rolq	$1, %r11
	xorq	%r10, %r11
	movq	%r8, %rbp
	rolq	$1, %rbp
	xorq	%rdx, %rbp
	movq	%r9, %rbx
	rolq	$1, %rbx
	xorq	%rdi, %rbx
	movq	%r10, %rdi
	rolq	$1, %rdi
	xorq	%r8, %rdi
	rolq	$1, %rdx
	xorq	%r9, %rdx
	movq	-100(%rcx), %r8
	xorq	%r11, %r8
	movq	-52(%rcx), %r9
	xorq	%rbp, %r9
	rolq	$44, %r9
	movq	-4(%rcx), %r10
	xorq	%rbx, %r10
	rolq	$43, %r10
	movq	44(%rcx), %r12
	xorq	%rdi, %r12
	rolq	$21, %r12
	movq	92(%rcx), %r13
	xorq	%rdx, %r13
	rolq	$14, %r13
	andnq	%r10, %r9, %r14
	xorq	(%rsp), %r14
	xorq	%r8, %r14
	movq	%r14, -100(%rax)
	andnq	%r12, %r10, %r14
	xorq	%r9, %r14
	movq	%r14, -92(%rax)
	andnq	%r13, %r12, %r14
	xorq	%r10, %r14
	movq	%r14, -84(%rax)
	andnq	%r8, %r13, %r10
	xorq	%r12, %r10
	movq	%r10, -76(%rax)
	andnq	%r9, %r8, %r8
	xorq	%r13, %r8
	movq	%r8, -68(%rax)
	movq	-76(%rcx), %r8
	xorq	%rdi, %r8
	rolq	$28, %r8
	movq	-28(%rcx), %r9
	xorq	%rdx, %r9
	rolq	$20, %r9
	movq	-20(%rcx), %r10
	xorq	%r11, %r10
	rolq	$3, %r10
	movq	28(%rcx), %r12
	xorq	%rbp, %r12
	rolq	$45, %r12
	movq	76(%rcx), %r13
	xorq	%rbx, %r13
	rolq	$61, %r13
	andnq	%r10, %r9, %r14
	xorq	%r8, %r14
	movq	%r14, -60(%rax)
	andnq	%r12, %r10, %r14
	xorq	%r9, %r14
	movq	%r14, -52(%rax)
	andnq	%r13, %r12, %r14
	xorq	%r10, %r14
	movq	%r14, -44(%rax)
	andnq	%r8, %r13, %r10
	xorq	%r12, %r10
	movq	%r10, -36(%rax)
	andnq	%r9, %r8, %r8
	xorq	%r13, %r8
	movq	%r8, -28(%rax)
	movq	-92(%rcx), %r8
	xorq	%rbp, %r8
	rolq	$1, %r8
	movq	-44(%rcx), %r9
	xorq	%rbx, %r9
	rolq	$6, %r9
	movq	4(%rcx), %r10
	xorq	%rdi, %r10
	rolq	$25, %r10
	movq	52(%rcx), %r12
	xorq	%rdx, %r12
	rolq	$8, %r12
	movq	60(%rcx), %r13
	xorq	%r11, %r13
	rolq	$18, %r13
	andnq	%r10, %r9, %r14
	xorq	%r8, %r14
	movq	%r14, -20(%rax)
	andnq	%r12, %r10, %r14
	xorq	%r9, %r14
	movq	%r14, -12(%rax)
	andnq	%r13, %r12, %r14
	xorq	%r10, %r14
	movq	%r14, -4(%rax)
	andnq	%r8, %r13, %r10
	xorq	%r12, %r10
	movq	%r10, 4(%rax)
	andnq	%r9, %r8, %r8
	xorq	%r13, %r8
	movq	%r8, 12(%rax)
	movq	-68(%rcx), %r8
	xorq	%rdx, %r8
	rolq	$27, %r8
	movq	-60(%rcx), %r9
	xorq	%r11, %r9
	rolq	$36, %r9
	movq	-12(%rcx), %r10
	xorq	%rbp, %r10
	rolq	$10, %r10
	movq	36(%rcx), %r12
	xorq	%rbx, %r12
	rolq	$15, %r12
	movq	84(%rcx), %r13
	xorq	%rdi, %r13
	rolq	$56, %r13
	andnq	%r10, %r9, %r14
	xorq	%r8, %r14
	movq	%r14, 20(%rax)
	andnq	%r12, %r10, %r14
	xorq	%r9, %r14
	movq	%r14, 28(%rax)
	andnq	%r13, %r12, %r14
	xorq	%r10, %r14
	movq	%r14, 36(%rax)
	andnq	%r8, %r13, %r10
	xorq	%r12, %r10
	movq	%r10, 44(%rax)
	andnq	%r9, %r8, %r8
	xorq	%r13, %r8
	movq	%r8, 52(%rax)
	movq	-84(%rcx), %r8
	xorq	%rbx, %r8
	rolq	$62, %r8
	movq	-36(%rcx), %r9
	xorq	%rdi, %r9
	rolq	$55, %r9
	movq	%r9, %rdi
	movq	12(%rcx), %r9
	xorq	%rdx, %r9
	rolq	$39, %r9
	movq	%r9, %rdx
	movq	20(%rcx), %r9
	xorq	%r11, %r9
	rolq	$41, %r9
	movq	68(%rcx), %r10
	xorq	%rbp, %r10
	rolq	$2, %r10
	andnq	%rdx, %rdi, %r11
	xorq	%r8, %r11
	movq	%r11, 60(%rax)
	andnq	%r9, %rdx, %r11
	xorq	%rdi, %r11
	movq	%r11, 68(%rax)
	andnq	%r10, %r9, %r11
	xorq	%rdx, %r11
	movq	%r11, 76(%rax)
	andnq	%r8, %r10, %rdx
	xorq	%r9, %rdx
	movq	%rdx, 84(%rax)
	andnq	%rdi, %r8, %rdx
	xorq	%r10, %rdx
	movq	%rdx, 92(%rax)
	leaq	16(%rsi), %rsi
	testb	$-1, %sil
	jne 	LKeccakF1600_x86_64_STATE_IN_STACK_0$1
	addq	$8, %rsp
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	ret 

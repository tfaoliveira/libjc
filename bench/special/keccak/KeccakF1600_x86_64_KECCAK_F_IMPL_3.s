	.text
	.p2align	5
	.globl	_KeccakF1600_x86_64_KECCAK_F_IMPL_3
	.globl	KeccakF1600_x86_64_KECCAK_F_IMPL_3
_KeccakF1600_x86_64_KECCAK_F_IMPL_3:
KeccakF1600_x86_64_KECCAK_F_IMPL_3:
	pushq	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	leaq	100(%rdi), %rax
	leaq	200(%rax), %rcx
#	notq	-92(%rax) # nots are outside of OpenSSL __KeccakF we comment them here for the sake of comparison
#	notq	-84(%rax)
#	notq	-36(%rax)
#	notq	-4(%rax)
#	notq	36(%rax)
#	notq	60(%rax)
	movq	60(%rax), %rdx
	movq	68(%rax), %rdi
	movq	76(%rax), %r8
	movq	84(%rax), %r9
	movq	92(%rax), %r10
	.p2align	5
LKeccakF1600_x86_64_KECCAK_F_IMPL_3$1:
	movq	-100(%rax), %r11
	movq	-52(%rax), %rbp
	movq	-4(%rax), %rbx
	movq	44(%rax), %r12
	xorq	-84(%rax), %r8
	xorq	-76(%rax), %r9
	xorq	%r11, %rdx
	xorq	-92(%rax), %rdi
	xorq	-44(%rax), %r8
	xorq	-60(%rax), %rdx
	movq	%r10, %r13
	xorq	-68(%rax), %r10
	xorq	%rbx, %r8
	xorq	-20(%rax), %rdx
	xorq	-36(%rax), %r9
	xorq	%rbp, %rdi
	xorq	-28(%rax), %r10
	xorq	36(%rax), %r8
	xorq	20(%rax), %rdx
	xorq	4(%rax), %r9
	xorq	-12(%rax), %rdi
	xorq	12(%rax), %r10
	movq	%r8, %r14
	rolq	$1, %r8
	xorq	%rdx, %r8
	xorq	%r12, %r9
	rolq	$1, %rdx
	xorq	%r9, %rdx
	xorq	28(%rax), %rdi
	rolq	$1, %r9
	xorq	%rdi, %r9
	xorq	52(%rax), %r10
	rolq	$1, %rdi
	xorq	%r10, %rdi
	rolq	$1, %r10
	xorq	%r14, %r10
	xorq	%r8, %rbp
	xorq	%r9, %rbx
	rolq	$44, %rbp
	xorq	%r10, %r12
	xorq	%rdx, %r13
	rolq	$43, %rbx
	xorq	%rdi, %r11
	movq	%rbp, %r14
	rolq	$21, %r12
	orq 	%rbx, %rbp
	xorq	%r11, %rbp
	rolq	$14, %r13
	xorq	(%rsi), %rbp
	leaq	8(%rsi), %rsi
	movq	%r13, %r15
	andq	%r12, %r13
	movq	%rbp, -100(%rcx)
	xorq	%rbx, %r13
	notq	%rbx
	movq	%r13, -84(%rcx)
	orq 	%r12, %rbx
	movq	76(%rax), %rbp
	xorq	%r14, %rbx
	movq	%rbx, -92(%rcx)
	andq	%r11, %r14
	movq	-28(%rax), %rbx
	xorq	%r15, %r14
	movq	-20(%rax), %r13
	movq	%r14, -68(%rcx)
	orq 	%r11, %r15
	movq	-76(%rax), %r11
	xorq	%r12, %r15
	movq	28(%rax), %r12
	movq	%r15, -76(%rcx)
	xorq	%r10, %r11
	xorq	%r9, %rbp
	rolq	$28, %r11
	xorq	%r8, %r12
	xorq	%rdx, %rbx
	rolq	$61, %rbp
	rolq	$45, %r12
	xorq	%rdi, %r13
	rolq	$20, %rbx
	movq	%r11, %r14
	orq 	%rbp, %r11
	rolq	$3, %r13
	xorq	%r12, %r11
	movq	%r11, -36(%rcx)
	movq	%rbx, %r11
	andq	%r14, %rbx
	movq	-92(%rax), %r15
	xorq	%rbp, %rbx
	notq	%rbp
	movq	%rbx, -28(%rcx)
	orq 	%r12, %rbp
	movq	-44(%rax), %rbx
	xorq	%r13, %rbp
	movq	%rbp, -44(%rcx)
	andq	%r13, %r12
	movq	60(%rax), %rbp
	xorq	%r11, %r12
	movq	%r12, -52(%rcx)
	orq 	%r13, %r11
	movq	4(%rax), %r12
	xorq	%r14, %r11
	movq	52(%rax), %r13
	movq	%r11, -60(%rcx)
	xorq	%r10, %r12
	xorq	%rdx, %r13
	movq	%r12, %r11
	rolq	$25, %r11
	xorq	%r9, %rbx
	movq	%r13, %r12
	rolq	$8, %r12
	xorq	%rdi, %rbp
	rolq	$6, %rbx
	xorq	%r8, %r15
	rolq	$18, %rbp
	movq	%r11, %r13
	andq	%r12, %r11
	movq	%r15, %r14
	rolq	$1, %r14
	notq	%r12
	xorq	%rbx, %r11
	movq	%r11, -12(%rcx)
	movq	%rbp, %r11
	andq	%r12, %rbp
	movq	-12(%rax), %r15
	xorq	%r13, %rbp
	movq	%rbp, -4(%rcx)
	orq 	%rbx, %r13
	movq	84(%rax), %rbp
	xorq	%r14, %r13
	movq	%r13, -20(%rcx)
	andq	%r14, %rbx
	xorq	%r11, %rbx
	movq	%rbx, 12(%rcx)
	orq 	%r14, %r11
	movq	-60(%rax), %rbx
	xorq	%r12, %r11
	movq	36(%rax), %r12
	movq	%r11, 4(%rcx)
	movq	-68(%rax), %r11
	xorq	%r8, %r15
	xorq	%r9, %r12
	movq	%r15, %r13
	rolq	$10, %r13
	xorq	%rdi, %rbx
	rolq	$15, %r12
	xorq	%r10, %rbp
	rolq	$36, %rbx
	xorq	%rdx, %r11
	rolq	$56, %rbp
	movq	%r13, %r14
	orq 	%r12, %r13
	rolq	$27, %r11
	notq	%r12
	xorq	%rbx, %r13
	movq	%r13, 28(%rcx)
	movq	%rbp, %r13
	orq 	%r12, %rbp
	xorq	%r14, %rbp
	movq	%rbp, 36(%rcx)
	andq	%rbx, %r14
	xorq	%r11, %r14
	movq	%r14, 20(%rcx)
	orq 	%r11, %rbx
	xorq	%r13, %rbx
	movq	%rbx, 52(%rcx)
	andq	%r13, %r11
	xorq	%r12, %r11
	movq	%r11, 44(%rcx)
	xorq	-84(%rax), %r9
	xorq	-36(%rax), %r10
	rolq	$62, %r9
	xorq	68(%rax), %r8
	rolq	$55, %r10
	xorq	12(%rax), %rdx
	rolq	$2, %r8
	xorq	20(%rax), %rdi
	movq	%rax, %r11
	movq	%rcx, %rax
	movq	%r11, %rcx
	rolq	$39, %rdx
	rolq	$41, %rdi
	movq	%r9, %r11
	andq	%r10, %r9
	notq	%r10
	xorq	%r8, %r9
	movq	%r9, 92(%rax)
	movq	%rdx, %rbp
	andq	%r10, %rdx
	xorq	%r11, %rdx
	movq	%rdx, 60(%rax)
	orq 	%r8, %r11
	xorq	%rdi, %r11
	movq	%r11, 84(%rax)
	andq	%rdi, %r8
	xorq	%rbp, %r8
	movq	%r8, 76(%rax)
	orq 	%rbp, %rdi
	xorq	%r10, %rdi
	movq	%rdi, 68(%rax)
	movq	%r9, %r10
	movq	%r11, %r9
	testb	$-1, %sil
	jne 	LKeccakF1600_x86_64_KECCAK_F_IMPL_3$1
#	notq	-92(%rax) # same
#	notq	-84(%rax)
#	notq	-36(%rax)
#	notq	-4(%rax)
#	notq	36(%rax)
#	notq	60(%rax)
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	ret 

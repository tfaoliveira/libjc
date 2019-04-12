	.text
	.p2align	5
	.globl	_shake256_ref2x_jazz
	.globl	shake256_ref2x_jazz
_shake256_ref2x_jazz:
shake256_ref2x_jazz:
	pushq	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$24, %rsp
	movq	%rdi, 16(%rsp)
	xorl	%eax, %eax
	movq	$0, %rdi
	jmp 	Lshake256_ref2x_jazz$20
Lshake256_ref2x_jazz$21:
	movq	%rax, (%r8,%rdi,8)
	leaq	1(%rdi), %rdi
Lshake256_ref2x_jazz$20:
	cmpq	$50, %rdi
	jb  	Lshake256_ref2x_jazz$21
	jmp 	Lshake256_ref2x_jazz$17
Lshake256_ref2x_jazz$18:
	movq	(%rsi), %rax
	xorq	%rax, (%r8)
	movq	8(%rsi), %rax
	xorq	%rax, 8(%r8)
	movq	16(%rsi), %rax
	xorq	%rax, 16(%r8)
	movq	24(%rsi), %rax
	xorq	%rax, 24(%r8)
	movq	32(%rsi), %rax
	xorq	%rax, 32(%r8)
	movq	40(%rsi), %rax
	xorq	%rax, 40(%r8)
	movq	48(%rsi), %rax
	xorq	%rax, 48(%r8)
	movq	56(%rsi), %rax
	xorq	%rax, 56(%r8)
	movq	64(%rsi), %rax
	xorq	%rax, 64(%r8)
	movq	72(%rsi), %rax
	xorq	%rax, 72(%r8)
	movq	80(%rsi), %rax
	xorq	%rax, 80(%r8)
	movq	88(%rsi), %rax
	xorq	%rax, 88(%r8)
	movq	96(%rsi), %rax
	xorq	%rax, 96(%r8)
	movq	104(%rsi), %rax
	xorq	%rax, 104(%r8)
	movq	112(%rsi), %rax
	xorq	%rax, 112(%r8)
	movq	120(%rsi), %rax
	xorq	%rax, 120(%r8)
	movq	128(%rsi), %rax
	xorq	%rax, 128(%r8)
	leaq	136(%rsi), %rax
	leaq	-136(%rdx), %rdx
	movq	%rax, 8(%rsp)
	movq	%rdx, (%rsp)
	leaq	100(%r8), %rax
	leaq	200(%rax), %rdx
	movq	60(%rax), %rsi
	movq	68(%rax), %rdi
	movq	76(%rax), %r8
	movq	84(%rax), %r9
	movq	92(%rax), %r10
	.p2align	5
Lshake256_ref2x_jazz$19:
	movq	-100(%rax), %r11
	movq	-52(%rax), %rbp
	movq	-4(%rax), %rbx
	movq	44(%rax), %r12
	xorq	-84(%rax), %r8
	xorq	-76(%rax), %r9
	xorq	%r11, %rsi
	xorq	-92(%rax), %rdi
	xorq	-44(%rax), %r8
	xorq	-60(%rax), %rsi
	movq	%r10, %r13
	xorq	-68(%rax), %r10
	xorq	%rbx, %r8
	xorq	-20(%rax), %rsi
	xorq	-36(%rax), %r9
	xorq	%rbp, %rdi
	xorq	-28(%rax), %r10
	xorq	36(%rax), %r8
	xorq	20(%rax), %rsi
	xorq	4(%rax), %r9
	xorq	-12(%rax), %rdi
	xorq	12(%rax), %r10
	movq	%r8, %r14
	rolq	$1, %r8
	xorq	%rsi, %r8
	xorq	%r12, %r9
	rolq	$1, %rsi
	xorq	%r9, %rsi
	xorq	28(%rax), %rdi
	rolq	$1, %r9
	xorq	%rdi, %r9
	xorq	52(%rax), %r10
	rolq	$1, %rdi
	xorq	%r10, %rdi
	rolq	$1, %r10
	xorq	%r14, %r10
	xorq	%rdi, %r11
	xorq	%r8, %rbp
	rolq	$44, %rbp
	xorq	%r9, %rbx
	rolq	$43, %rbx
	xorq	%r10, %r12
	rolq	$21, %r12
	xorq	%rsi, %r13
	rolq	$14, %r13
	andnq	%rbx, %rbp, %r14
	andnq	%r12, %rbx, %r15
	xorq	%r11, %r14
	xorq	%rbp, %r15
	xorq	(%rcx), %r14
	leaq	8(%rcx), %rcx
	movq	%r14, -100(%rdx)
	movq	%r15, -92(%rdx)
	andnq	%r13, %r12, %r14
	xorq	%rbx, %r14
	movq	%r14, -84(%rdx)
	andnq	%r11, %r13, %rbx
	xorq	%r12, %rbx
	movq	%rbx, -76(%rdx)
	andnq	%rbp, %r11, %r11
	xorq	%r13, %r11
	movq	%r11, -68(%rdx)
	movq	-76(%rax), %r11
	movq	-28(%rax), %rbp
	movq	-20(%rax), %rbx
	movq	28(%rax), %r12
	movq	76(%rax), %r13
	xorq	%r10, %r11
	rolq	$28, %r11
	xorq	%rsi, %rbp
	rolq	$20, %rbp
	xorq	%rdi, %rbx
	rolq	$3, %rbx
	xorq	%r8, %r12
	rolq	$45, %r12
	xorq	%r9, %r13
	rolq	$61, %r13
	andnq	%rbx, %rbp, %r14
	xorq	%r11, %r14
	movq	%r14, -60(%rdx)
	andnq	%r12, %rbx, %r14
	xorq	%rbp, %r14
	movq	%r14, -52(%rdx)
	andnq	%r13, %r12, %r14
	xorq	%rbx, %r14
	movq	%r14, -44(%rdx)
	andnq	%r11, %r13, %rbx
	xorq	%r12, %rbx
	movq	%rbx, -36(%rdx)
	andnq	%rbp, %r11, %r11
	xorq	%r13, %r11
	movq	%r11, -28(%rdx)
	movq	-92(%rax), %r11
	movq	-44(%rax), %rbp
	movq	4(%rax), %rbx
	movq	52(%rax), %r12
	movq	60(%rax), %r13
	xorq	%r8, %r11
	rolq	$1, %r11
	xorq	%r9, %rbp
	rolq	$6, %rbp
	xorq	%r10, %rbx
	rolq	$25, %rbx
	xorq	%rsi, %r12
	rolq	$8, %r12
	xorq	%rdi, %r13
	rolq	$18, %r13
	andnq	%rbx, %rbp, %r14
	xorq	%r11, %r14
	movq	%r14, -20(%rdx)
	andnq	%r12, %rbx, %r14
	xorq	%rbp, %r14
	movq	%r14, -12(%rdx)
	andnq	%r13, %r12, %r14
	xorq	%rbx, %r14
	movq	%r14, -4(%rdx)
	andnq	%r11, %r13, %rbx
	xorq	%r12, %rbx
	movq	%rbx, 4(%rdx)
	andnq	%rbp, %r11, %r11
	xorq	%r13, %r11
	movq	%r11, 12(%rdx)
	movq	-68(%rax), %r11
	movq	-60(%rax), %rbp
	movq	-12(%rax), %rbx
	movq	36(%rax), %r12
	movq	84(%rax), %r13
	xorq	%rsi, %r11
	rolq	$27, %r11
	xorq	%rdi, %rbp
	rolq	$36, %rbp
	xorq	%r8, %rbx
	rolq	$10, %rbx
	xorq	%r9, %r12
	rolq	$15, %r12
	xorq	%r10, %r13
	rolq	$56, %r13
	andnq	%rbx, %rbp, %r14
	xorq	%r11, %r14
	movq	%r14, 20(%rdx)
	andnq	%r12, %rbx, %r14
	xorq	%rbp, %r14
	movq	%r14, 28(%rdx)
	andnq	%r13, %r12, %r14
	xorq	%rbx, %r14
	movq	%r14, 36(%rdx)
	andnq	%r11, %r13, %rbx
	xorq	%r12, %rbx
	movq	%rbx, 44(%rdx)
	andnq	%rbp, %r11, %r11
	xorq	%r13, %r11
	movq	%r11, 52(%rdx)
	movq	-84(%rax), %r11
	movq	-36(%rax), %rbp
	movq	12(%rax), %rbx
	movq	20(%rax), %r12
	movq	68(%rax), %r13
	xorq	%r9, %r11
	movq	%r11, %r9
	rolq	$62, %r9
	xorq	%r10, %rbp
	movq	%rbp, %r10
	rolq	$55, %r10
	xorq	%rsi, %rbx
	movq	%rbx, %rsi
	rolq	$39, %rsi
	xorq	%rdi, %r12
	movq	%r12, %rdi
	rolq	$41, %rdi
	xorq	%r8, %r13
	movq	%r13, %r8
	rolq	$2, %r8
	andnq	%rsi, %r10, %r11
	xorq	%r9, %r11
	movq	%r11, 60(%rdx)
	andnq	%rdi, %rsi, %r11
	xorq	%r10, %r11
	movq	%r11, 68(%rdx)
	andnq	%r8, %rdi, %r11
	xorq	%rsi, %r11
	movq	%r11, 76(%rdx)
	andnq	%r9, %r8, %rsi
	xorq	%rdi, %rsi
	movq	%rsi, 84(%rdx)
	andnq	%r10, %r9, %rsi
	xorq	%r8, %rsi
	movq	%rsi, 92(%rdx)
	movq	%rax, %rsi
	movq	%rdx, %rax
	movq	%rsi, %rdx
	movq	60(%rax), %rsi
	movq	68(%rax), %rdi
	movq	76(%rax), %r8
	movq	84(%rax), %r9
	movq	92(%rax), %r10
	testb	$-1, %cl
	jne 	Lshake256_ref2x_jazz$19
	leaq	-192(%rcx), %rcx
	leaq	-100(%rax), %r8
	movq	8(%rsp), %rsi
	movq	(%rsp), %rdx
Lshake256_ref2x_jazz$17:
	cmpq	$136, %rdx
	jnb 	Lshake256_ref2x_jazz$18
	movq	%rdx, %rax
	shrq	$3, %rax
	movq	$0, %rdi
	jmp 	Lshake256_ref2x_jazz$15
Lshake256_ref2x_jazz$16:
	movq	(%rsi,%rdi,8), %r9
	xorq	%r9, (%r8,%rdi,8)
	leaq	1(%rdi), %rdi
Lshake256_ref2x_jazz$15:
	cmpq	%rax, %rdi
	jb  	Lshake256_ref2x_jazz$16
	shlq	$3, %rdi
	jmp 	Lshake256_ref2x_jazz$13
Lshake256_ref2x_jazz$14:
	movb	(%rsi,%rdi), %al
	xorb	%al, (%r8,%rdi)
	leaq	1(%rdi), %rdi
Lshake256_ref2x_jazz$13:
	cmpq	%rdx, %rdi
	jb  	Lshake256_ref2x_jazz$14
	xorb	$31, (%r8,%rdi)
	xorb	$-128, 135(%r8)
	leaq	100(%r8), %rax
	leaq	200(%rax), %rdx
	movq	60(%rax), %rsi
	movq	68(%rax), %rdi
	movq	76(%rax), %r8
	movq	84(%rax), %r9
	movq	92(%rax), %r10
	.p2align	5
Lshake256_ref2x_jazz$12:
	movq	-100(%rax), %r11
	movq	-52(%rax), %rbp
	movq	-4(%rax), %rbx
	movq	44(%rax), %r12
	xorq	-84(%rax), %r8
	xorq	-76(%rax), %r9
	xorq	%r11, %rsi
	xorq	-92(%rax), %rdi
	xorq	-44(%rax), %r8
	xorq	-60(%rax), %rsi
	movq	%r10, %r13
	xorq	-68(%rax), %r10
	xorq	%rbx, %r8
	xorq	-20(%rax), %rsi
	xorq	-36(%rax), %r9
	xorq	%rbp, %rdi
	xorq	-28(%rax), %r10
	xorq	36(%rax), %r8
	xorq	20(%rax), %rsi
	xorq	4(%rax), %r9
	xorq	-12(%rax), %rdi
	xorq	12(%rax), %r10
	movq	%r8, %r14
	rolq	$1, %r8
	xorq	%rsi, %r8
	xorq	%r12, %r9
	rolq	$1, %rsi
	xorq	%r9, %rsi
	xorq	28(%rax), %rdi
	rolq	$1, %r9
	xorq	%rdi, %r9
	xorq	52(%rax), %r10
	rolq	$1, %rdi
	xorq	%r10, %rdi
	rolq	$1, %r10
	xorq	%r14, %r10
	xorq	%rdi, %r11
	xorq	%r8, %rbp
	rolq	$44, %rbp
	xorq	%r9, %rbx
	rolq	$43, %rbx
	xorq	%r10, %r12
	rolq	$21, %r12
	xorq	%rsi, %r13
	rolq	$14, %r13
	andnq	%rbx, %rbp, %r14
	andnq	%r12, %rbx, %r15
	xorq	%r11, %r14
	xorq	%rbp, %r15
	xorq	(%rcx), %r14
	leaq	8(%rcx), %rcx
	movq	%r14, -100(%rdx)
	movq	%r15, -92(%rdx)
	andnq	%r13, %r12, %r14
	xorq	%rbx, %r14
	movq	%r14, -84(%rdx)
	andnq	%r11, %r13, %rbx
	xorq	%r12, %rbx
	movq	%rbx, -76(%rdx)
	andnq	%rbp, %r11, %r11
	xorq	%r13, %r11
	movq	%r11, -68(%rdx)
	movq	-76(%rax), %r11
	movq	-28(%rax), %rbp
	movq	-20(%rax), %rbx
	movq	28(%rax), %r12
	movq	76(%rax), %r13
	xorq	%r10, %r11
	rolq	$28, %r11
	xorq	%rsi, %rbp
	rolq	$20, %rbp
	xorq	%rdi, %rbx
	rolq	$3, %rbx
	xorq	%r8, %r12
	rolq	$45, %r12
	xorq	%r9, %r13
	rolq	$61, %r13
	andnq	%rbx, %rbp, %r14
	xorq	%r11, %r14
	movq	%r14, -60(%rdx)
	andnq	%r12, %rbx, %r14
	xorq	%rbp, %r14
	movq	%r14, -52(%rdx)
	andnq	%r13, %r12, %r14
	xorq	%rbx, %r14
	movq	%r14, -44(%rdx)
	andnq	%r11, %r13, %rbx
	xorq	%r12, %rbx
	movq	%rbx, -36(%rdx)
	andnq	%rbp, %r11, %r11
	xorq	%r13, %r11
	movq	%r11, -28(%rdx)
	movq	-92(%rax), %r11
	movq	-44(%rax), %rbp
	movq	4(%rax), %rbx
	movq	52(%rax), %r12
	movq	60(%rax), %r13
	xorq	%r8, %r11
	rolq	$1, %r11
	xorq	%r9, %rbp
	rolq	$6, %rbp
	xorq	%r10, %rbx
	rolq	$25, %rbx
	xorq	%rsi, %r12
	rolq	$8, %r12
	xorq	%rdi, %r13
	rolq	$18, %r13
	andnq	%rbx, %rbp, %r14
	xorq	%r11, %r14
	movq	%r14, -20(%rdx)
	andnq	%r12, %rbx, %r14
	xorq	%rbp, %r14
	movq	%r14, -12(%rdx)
	andnq	%r13, %r12, %r14
	xorq	%rbx, %r14
	movq	%r14, -4(%rdx)
	andnq	%r11, %r13, %rbx
	xorq	%r12, %rbx
	movq	%rbx, 4(%rdx)
	andnq	%rbp, %r11, %r11
	xorq	%r13, %r11
	movq	%r11, 12(%rdx)
	movq	-68(%rax), %r11
	movq	-60(%rax), %rbp
	movq	-12(%rax), %rbx
	movq	36(%rax), %r12
	movq	84(%rax), %r13
	xorq	%rsi, %r11
	rolq	$27, %r11
	xorq	%rdi, %rbp
	rolq	$36, %rbp
	xorq	%r8, %rbx
	rolq	$10, %rbx
	xorq	%r9, %r12
	rolq	$15, %r12
	xorq	%r10, %r13
	rolq	$56, %r13
	andnq	%rbx, %rbp, %r14
	xorq	%r11, %r14
	movq	%r14, 20(%rdx)
	andnq	%r12, %rbx, %r14
	xorq	%rbp, %r14
	movq	%r14, 28(%rdx)
	andnq	%r13, %r12, %r14
	xorq	%rbx, %r14
	movq	%r14, 36(%rdx)
	andnq	%r11, %r13, %rbx
	xorq	%r12, %rbx
	movq	%rbx, 44(%rdx)
	andnq	%rbp, %r11, %r11
	xorq	%r13, %r11
	movq	%r11, 52(%rdx)
	movq	-84(%rax), %r11
	movq	-36(%rax), %rbp
	movq	12(%rax), %rbx
	movq	20(%rax), %r12
	movq	68(%rax), %r13
	xorq	%r9, %r11
	movq	%r11, %r9
	rolq	$62, %r9
	xorq	%r10, %rbp
	movq	%rbp, %r10
	rolq	$55, %r10
	xorq	%rsi, %rbx
	movq	%rbx, %rsi
	rolq	$39, %rsi
	xorq	%rdi, %r12
	movq	%r12, %rdi
	rolq	$41, %rdi
	xorq	%r8, %r13
	movq	%r13, %r8
	rolq	$2, %r8
	andnq	%rsi, %r10, %r11
	xorq	%r9, %r11
	movq	%r11, 60(%rdx)
	andnq	%rdi, %rsi, %r11
	xorq	%r10, %r11
	movq	%r11, 68(%rdx)
	andnq	%r8, %rdi, %r11
	xorq	%rsi, %r11
	movq	%r11, 76(%rdx)
	andnq	%r9, %r8, %rsi
	xorq	%rdi, %rsi
	movq	%rsi, 84(%rdx)
	andnq	%r10, %r9, %rsi
	xorq	%r8, %rsi
	movq	%rsi, 92(%rdx)
	movq	%rax, %rsi
	movq	%rdx, %rax
	movq	%rsi, %rdx
	movq	60(%rax), %rsi
	movq	68(%rax), %rdi
	movq	76(%rax), %r8
	movq	84(%rax), %r9
	movq	92(%rax), %r10
	testb	$-1, %cl
	jne 	Lshake256_ref2x_jazz$12
	leaq	-192(%rcx), %rcx
	leaq	-100(%rax), %rax
	movq	16(%rsp), %rdx
	movq	$136, 8(%rsp)
	jmp 	Lshake256_ref2x_jazz$5
Lshake256_ref2x_jazz$6:
	movq	$136, %rsi
	movq	%rsi, %rdi
	shrq	$3, %rdi
	movq	$0, %r8
	jmp 	Lshake256_ref2x_jazz$10
Lshake256_ref2x_jazz$11:
	movq	(%rax,%r8,8), %r9
	movq	%r9, (%rdx,%r8,8)
	leaq	1(%r8), %r8
Lshake256_ref2x_jazz$10:
	cmpq	%rdi, %r8
	jb  	Lshake256_ref2x_jazz$11
	shlq	$3, %r8
	jmp 	Lshake256_ref2x_jazz$8
Lshake256_ref2x_jazz$9:
	movb	(%rax,%r8), %dil
	movb	%dil, (%rdx,%r8)
	leaq	1(%r8), %r8
Lshake256_ref2x_jazz$8:
	cmpq	%rsi, %r8
	jb  	Lshake256_ref2x_jazz$9
	leaq	(%rdx,%rsi), %rdx
	movq	%rdx, 16(%rsp)
	leaq	100(%rax), %rax
	leaq	200(%rax), %rdx
	movq	60(%rax), %rsi
	movq	68(%rax), %rdi
	movq	76(%rax), %r8
	movq	84(%rax), %r9
	movq	92(%rax), %r10
	.p2align	5
Lshake256_ref2x_jazz$7:
	movq	-100(%rax), %r11
	movq	-52(%rax), %rbp
	movq	-4(%rax), %rbx
	movq	44(%rax), %r12
	xorq	-84(%rax), %r8
	xorq	-76(%rax), %r9
	xorq	%r11, %rsi
	xorq	-92(%rax), %rdi
	xorq	-44(%rax), %r8
	xorq	-60(%rax), %rsi
	movq	%r10, %r13
	xorq	-68(%rax), %r10
	xorq	%rbx, %r8
	xorq	-20(%rax), %rsi
	xorq	-36(%rax), %r9
	xorq	%rbp, %rdi
	xorq	-28(%rax), %r10
	xorq	36(%rax), %r8
	xorq	20(%rax), %rsi
	xorq	4(%rax), %r9
	xorq	-12(%rax), %rdi
	xorq	12(%rax), %r10
	movq	%r8, %r14
	rolq	$1, %r8
	xorq	%rsi, %r8
	xorq	%r12, %r9
	rolq	$1, %rsi
	xorq	%r9, %rsi
	xorq	28(%rax), %rdi
	rolq	$1, %r9
	xorq	%rdi, %r9
	xorq	52(%rax), %r10
	rolq	$1, %rdi
	xorq	%r10, %rdi
	rolq	$1, %r10
	xorq	%r14, %r10
	xorq	%rdi, %r11
	xorq	%r8, %rbp
	rolq	$44, %rbp
	xorq	%r9, %rbx
	rolq	$43, %rbx
	xorq	%r10, %r12
	rolq	$21, %r12
	xorq	%rsi, %r13
	rolq	$14, %r13
	andnq	%rbx, %rbp, %r14
	andnq	%r12, %rbx, %r15
	xorq	%r11, %r14
	xorq	%rbp, %r15
	xorq	(%rcx), %r14
	leaq	8(%rcx), %rcx
	movq	%r14, -100(%rdx)
	movq	%r15, -92(%rdx)
	andnq	%r13, %r12, %r14
	xorq	%rbx, %r14
	movq	%r14, -84(%rdx)
	andnq	%r11, %r13, %rbx
	xorq	%r12, %rbx
	movq	%rbx, -76(%rdx)
	andnq	%rbp, %r11, %r11
	xorq	%r13, %r11
	movq	%r11, -68(%rdx)
	movq	-76(%rax), %r11
	movq	-28(%rax), %rbp
	movq	-20(%rax), %rbx
	movq	28(%rax), %r12
	movq	76(%rax), %r13
	xorq	%r10, %r11
	rolq	$28, %r11
	xorq	%rsi, %rbp
	rolq	$20, %rbp
	xorq	%rdi, %rbx
	rolq	$3, %rbx
	xorq	%r8, %r12
	rolq	$45, %r12
	xorq	%r9, %r13
	rolq	$61, %r13
	andnq	%rbx, %rbp, %r14
	xorq	%r11, %r14
	movq	%r14, -60(%rdx)
	andnq	%r12, %rbx, %r14
	xorq	%rbp, %r14
	movq	%r14, -52(%rdx)
	andnq	%r13, %r12, %r14
	xorq	%rbx, %r14
	movq	%r14, -44(%rdx)
	andnq	%r11, %r13, %rbx
	xorq	%r12, %rbx
	movq	%rbx, -36(%rdx)
	andnq	%rbp, %r11, %r11
	xorq	%r13, %r11
	movq	%r11, -28(%rdx)
	movq	-92(%rax), %r11
	movq	-44(%rax), %rbp
	movq	4(%rax), %rbx
	movq	52(%rax), %r12
	movq	60(%rax), %r13
	xorq	%r8, %r11
	rolq	$1, %r11
	xorq	%r9, %rbp
	rolq	$6, %rbp
	xorq	%r10, %rbx
	rolq	$25, %rbx
	xorq	%rsi, %r12
	rolq	$8, %r12
	xorq	%rdi, %r13
	rolq	$18, %r13
	andnq	%rbx, %rbp, %r14
	xorq	%r11, %r14
	movq	%r14, -20(%rdx)
	andnq	%r12, %rbx, %r14
	xorq	%rbp, %r14
	movq	%r14, -12(%rdx)
	andnq	%r13, %r12, %r14
	xorq	%rbx, %r14
	movq	%r14, -4(%rdx)
	andnq	%r11, %r13, %rbx
	xorq	%r12, %rbx
	movq	%rbx, 4(%rdx)
	andnq	%rbp, %r11, %r11
	xorq	%r13, %r11
	movq	%r11, 12(%rdx)
	movq	-68(%rax), %r11
	movq	-60(%rax), %rbp
	movq	-12(%rax), %rbx
	movq	36(%rax), %r12
	movq	84(%rax), %r13
	xorq	%rsi, %r11
	rolq	$27, %r11
	xorq	%rdi, %rbp
	rolq	$36, %rbp
	xorq	%r8, %rbx
	rolq	$10, %rbx
	xorq	%r9, %r12
	rolq	$15, %r12
	xorq	%r10, %r13
	rolq	$56, %r13
	andnq	%rbx, %rbp, %r14
	xorq	%r11, %r14
	movq	%r14, 20(%rdx)
	andnq	%r12, %rbx, %r14
	xorq	%rbp, %r14
	movq	%r14, 28(%rdx)
	andnq	%r13, %r12, %r14
	xorq	%rbx, %r14
	movq	%r14, 36(%rdx)
	andnq	%r11, %r13, %rbx
	xorq	%r12, %rbx
	movq	%rbx, 44(%rdx)
	andnq	%rbp, %r11, %r11
	xorq	%r13, %r11
	movq	%r11, 52(%rdx)
	movq	-84(%rax), %r11
	movq	-36(%rax), %rbp
	movq	12(%rax), %rbx
	movq	20(%rax), %r12
	movq	68(%rax), %r13
	xorq	%r9, %r11
	movq	%r11, %r9
	rolq	$62, %r9
	xorq	%r10, %rbp
	movq	%rbp, %r10
	rolq	$55, %r10
	xorq	%rsi, %rbx
	movq	%rbx, %rsi
	rolq	$39, %rsi
	xorq	%rdi, %r12
	movq	%r12, %rdi
	rolq	$41, %rdi
	xorq	%r8, %r13
	movq	%r13, %r8
	rolq	$2, %r8
	andnq	%rsi, %r10, %r11
	xorq	%r9, %r11
	movq	%r11, 60(%rdx)
	andnq	%rdi, %rsi, %r11
	xorq	%r10, %r11
	movq	%r11, 68(%rdx)
	andnq	%r8, %rdi, %r11
	xorq	%rsi, %r11
	movq	%r11, 76(%rdx)
	andnq	%r9, %r8, %rsi
	xorq	%rdi, %rsi
	movq	%rsi, 84(%rdx)
	andnq	%r10, %r9, %rsi
	xorq	%r8, %rsi
	movq	%rsi, 92(%rdx)
	movq	%rax, %rsi
	movq	%rdx, %rax
	movq	%rsi, %rdx
	movq	60(%rax), %rsi
	movq	68(%rax), %rdi
	movq	76(%rax), %r8
	movq	84(%rax), %r9
	movq	92(%rax), %r10
	testb	$-1, %cl
	jne 	Lshake256_ref2x_jazz$7
	leaq	-192(%rcx), %rcx
	leaq	-100(%rax), %rax
	subq	$136, 8(%rsp)
	movq	16(%rsp), %rdx
Lshake256_ref2x_jazz$5:
	cmpq	$136, 8(%rsp)
	jnb 	Lshake256_ref2x_jazz$6
	movq	8(%rsp), %rcx
	movq	%rcx, %rsi
	shrq	$3, %rsi
	movq	$0, %rdi
	jmp 	Lshake256_ref2x_jazz$3
Lshake256_ref2x_jazz$4:
	movq	(%rax,%rdi,8), %r8
	movq	%r8, (%rdx,%rdi,8)
	leaq	1(%rdi), %rdi
Lshake256_ref2x_jazz$3:
	cmpq	%rsi, %rdi
	jb  	Lshake256_ref2x_jazz$4
	shlq	$3, %rdi
	jmp 	Lshake256_ref2x_jazz$1
Lshake256_ref2x_jazz$2:
	movb	(%rax,%rdi), %sil
	movb	%sil, (%rdx,%rdi)
	leaq	1(%rdi), %rdi
Lshake256_ref2x_jazz$1:
	cmpq	%rcx, %rdi
	jb  	Lshake256_ref2x_jazz$2
	addq	$24, %rsp
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	ret 

	.text
	.p2align	5
	.globl	_sha3512_ref2x_jazz
	.globl	sha3512_ref2x_jazz
_sha3512_ref2x_jazz:
sha3512_ref2x_jazz:
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
	jmp 	Lsha3512_ref2x_jazz$20
Lsha3512_ref2x_jazz$21:
	movq	%rax, (%r8,%rdi,8)
	leaq	1(%rdi), %rdi
Lsha3512_ref2x_jazz$20:
	cmpq	$50, %rdi
	jb  	Lsha3512_ref2x_jazz$21
	jmp 	Lsha3512_ref2x_jazz$17
Lsha3512_ref2x_jazz$18:
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
	leaq	72(%rsi), %rax
	leaq	-72(%rdx), %rdx
	movq	%rax, 8(%rsp)
	movq	%rdx, (%rsp)
	leaq	100(%r8), %rax
	leaq	200(%rax), %rdx
	notq	-92(%rax)
	notq	-84(%rax)
	notq	-36(%rax)
	notq	-4(%rax)
	notq	36(%rax)
	notq	60(%rax)
	movq	60(%rax), %rsi
	movq	68(%rax), %rdi
	movq	76(%rax), %r8
	movq	84(%rax), %r9
	movq	92(%rax), %r10
Lsha3512_ref2x_jazz$19:
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
	xorq	%r8, %rbp
	xorq	%r9, %rbx
	rolq	$44, %rbp
	xorq	%r10, %r12
	xorq	%rsi, %r13
	rolq	$43, %rbx
	xorq	%rdi, %r11
	movq	%rbp, %r14
	rolq	$21, %r12
	orq 	%rbx, %rbp
	xorq	%r11, %rbp
	rolq	$14, %r13
	xorq	(%rcx), %rbp
	leaq	8(%rcx), %rcx
	movq	%r13, %r15
	andq	%r12, %r13
	movq	%rbp, -100(%rdx)
	xorq	%rbx, %r13
	notq	%rbx
	movq	%r13, -84(%rdx)
	orq 	%r12, %rbx
	movq	76(%rax), %rbp
	xorq	%r14, %rbx
	movq	%rbx, -92(%rdx)
	andq	%r11, %r14
	movq	-28(%rax), %rbx
	xorq	%r15, %r14
	movq	-20(%rax), %r13
	movq	%r14, -68(%rdx)
	orq 	%r11, %r15
	movq	-76(%rax), %r11
	xorq	%r12, %r15
	movq	28(%rax), %r12
	movq	%r15, -76(%rdx)
	xorq	%r10, %r11
	xorq	%r9, %rbp
	rolq	$28, %r11
	xorq	%r8, %r12
	xorq	%rsi, %rbx
	rolq	$61, %rbp
	rolq	$45, %r12
	xorq	%rdi, %r13
	rolq	$20, %rbx
	movq	%r11, %r14
	orq 	%rbp, %r11
	rolq	$3, %r13
	xorq	%r12, %r11
	movq	%r11, -36(%rdx)
	movq	%rbx, %r11
	andq	%r14, %rbx
	movq	-92(%rax), %r15
	xorq	%rbp, %rbx
	notq	%rbp
	movq	%rbx, -28(%rdx)
	orq 	%r12, %rbp
	movq	-44(%rax), %rbx
	xorq	%r13, %rbp
	movq	%rbp, -44(%rdx)
	andq	%r13, %r12
	movq	60(%rax), %rbp
	xorq	%r11, %r12
	movq	%r12, -52(%rdx)
	orq 	%r13, %r11
	movq	4(%rax), %r12
	xorq	%r14, %r11
	movq	52(%rax), %r13
	movq	%r11, -60(%rdx)
	xorq	%r10, %r12
	xorq	%rsi, %r13
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
	movq	%r11, -12(%rdx)
	movq	%rbp, %r11
	andq	%r12, %rbp
	movq	-12(%rax), %r15
	xorq	%r13, %rbp
	movq	%rbp, -4(%rdx)
	orq 	%rbx, %r13
	movq	84(%rax), %rbp
	xorq	%r14, %r13
	movq	%r13, -20(%rdx)
	andq	%r14, %rbx
	xorq	%r11, %rbx
	movq	%rbx, 12(%rdx)
	orq 	%r14, %r11
	movq	-60(%rax), %rbx
	xorq	%r12, %r11
	movq	36(%rax), %r12
	movq	%r11, 4(%rdx)
	movq	-68(%rax), %r11
	xorq	%r8, %r15
	xorq	%r9, %r12
	movq	%r15, %r13
	rolq	$10, %r13
	xorq	%rdi, %rbx
	rolq	$15, %r12
	xorq	%r10, %rbp
	rolq	$36, %rbx
	xorq	%rsi, %r11
	rolq	$56, %rbp
	movq	%r13, %r14
	orq 	%r12, %r13
	rolq	$27, %r11
	notq	%r12
	xorq	%rbx, %r13
	movq	%r13, 28(%rdx)
	movq	%rbp, %r13
	orq 	%r12, %rbp
	xorq	%r14, %rbp
	movq	%rbp, 36(%rdx)
	andq	%rbx, %r14
	xorq	%r11, %r14
	movq	%r14, 20(%rdx)
	orq 	%r11, %rbx
	xorq	%r13, %rbx
	movq	%rbx, 52(%rdx)
	andq	%r13, %r11
	xorq	%r12, %r11
	movq	%r11, 44(%rdx)
	xorq	-84(%rax), %r9
	xorq	-36(%rax), %r10
	rolq	$62, %r9
	xorq	68(%rax), %r8
	rolq	$55, %r10
	xorq	12(%rax), %rsi
	rolq	$2, %r8
	xorq	20(%rax), %rdi
	movq	%rax, %r11
	movq	%rdx, %rax
	movq	%r11, %rdx
	rolq	$39, %rsi
	rolq	$41, %rdi
	movq	%r9, %r11
	andq	%r10, %r9
	notq	%r10
	xorq	%r8, %r9
	movq	%r9, 92(%rax)
	movq	%rsi, %rbp
	andq	%r10, %rsi
	xorq	%r11, %rsi
	movq	%rsi, 60(%rax)
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
	testb	$-1, %cl
	jne 	Lsha3512_ref2x_jazz$19
	notq	-92(%rax)
	notq	-84(%rax)
	notq	-36(%rax)
	notq	-4(%rax)
	notq	36(%rax)
	notq	60(%rax)
	leaq	-192(%rcx), %rcx
	leaq	-100(%rax), %r8
	movq	8(%rsp), %rsi
	movq	(%rsp), %rdx
Lsha3512_ref2x_jazz$17:
	cmpq	$72, %rdx
	jnb 	Lsha3512_ref2x_jazz$18
	movq	%rdx, %rax
	shrq	$3, %rax
	movq	$0, %rdi
	jmp 	Lsha3512_ref2x_jazz$15
Lsha3512_ref2x_jazz$16:
	movq	(%rsi,%rdi,8), %r9
	xorq	%r9, (%r8,%rdi,8)
	leaq	1(%rdi), %rdi
Lsha3512_ref2x_jazz$15:
	cmpq	%rax, %rdi
	jb  	Lsha3512_ref2x_jazz$16
	shlq	$3, %rdi
	jmp 	Lsha3512_ref2x_jazz$13
Lsha3512_ref2x_jazz$14:
	movb	(%rsi,%rdi), %al
	xorb	%al, (%r8,%rdi)
	leaq	1(%rdi), %rdi
Lsha3512_ref2x_jazz$13:
	cmpq	%rdx, %rdi
	jb  	Lsha3512_ref2x_jazz$14
	xorb	$6, (%r8,%rdi)
	xorb	$-128, 71(%r8)
	leaq	100(%r8), %rax
	leaq	200(%rax), %rdx
	notq	-92(%rax)
	notq	-84(%rax)
	notq	-36(%rax)
	notq	-4(%rax)
	notq	36(%rax)
	notq	60(%rax)
	movq	60(%rax), %rsi
	movq	68(%rax), %rdi
	movq	76(%rax), %r8
	movq	84(%rax), %r9
	movq	92(%rax), %r10
Lsha3512_ref2x_jazz$12:
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
	xorq	%r8, %rbp
	xorq	%r9, %rbx
	rolq	$44, %rbp
	xorq	%r10, %r12
	xorq	%rsi, %r13
	rolq	$43, %rbx
	xorq	%rdi, %r11
	movq	%rbp, %r14
	rolq	$21, %r12
	orq 	%rbx, %rbp
	xorq	%r11, %rbp
	rolq	$14, %r13
	xorq	(%rcx), %rbp
	leaq	8(%rcx), %rcx
	movq	%r13, %r15
	andq	%r12, %r13
	movq	%rbp, -100(%rdx)
	xorq	%rbx, %r13
	notq	%rbx
	movq	%r13, -84(%rdx)
	orq 	%r12, %rbx
	movq	76(%rax), %rbp
	xorq	%r14, %rbx
	movq	%rbx, -92(%rdx)
	andq	%r11, %r14
	movq	-28(%rax), %rbx
	xorq	%r15, %r14
	movq	-20(%rax), %r13
	movq	%r14, -68(%rdx)
	orq 	%r11, %r15
	movq	-76(%rax), %r11
	xorq	%r12, %r15
	movq	28(%rax), %r12
	movq	%r15, -76(%rdx)
	xorq	%r10, %r11
	xorq	%r9, %rbp
	rolq	$28, %r11
	xorq	%r8, %r12
	xorq	%rsi, %rbx
	rolq	$61, %rbp
	rolq	$45, %r12
	xorq	%rdi, %r13
	rolq	$20, %rbx
	movq	%r11, %r14
	orq 	%rbp, %r11
	rolq	$3, %r13
	xorq	%r12, %r11
	movq	%r11, -36(%rdx)
	movq	%rbx, %r11
	andq	%r14, %rbx
	movq	-92(%rax), %r15
	xorq	%rbp, %rbx
	notq	%rbp
	movq	%rbx, -28(%rdx)
	orq 	%r12, %rbp
	movq	-44(%rax), %rbx
	xorq	%r13, %rbp
	movq	%rbp, -44(%rdx)
	andq	%r13, %r12
	movq	60(%rax), %rbp
	xorq	%r11, %r12
	movq	%r12, -52(%rdx)
	orq 	%r13, %r11
	movq	4(%rax), %r12
	xorq	%r14, %r11
	movq	52(%rax), %r13
	movq	%r11, -60(%rdx)
	xorq	%r10, %r12
	xorq	%rsi, %r13
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
	movq	%r11, -12(%rdx)
	movq	%rbp, %r11
	andq	%r12, %rbp
	movq	-12(%rax), %r15
	xorq	%r13, %rbp
	movq	%rbp, -4(%rdx)
	orq 	%rbx, %r13
	movq	84(%rax), %rbp
	xorq	%r14, %r13
	movq	%r13, -20(%rdx)
	andq	%r14, %rbx
	xorq	%r11, %rbx
	movq	%rbx, 12(%rdx)
	orq 	%r14, %r11
	movq	-60(%rax), %rbx
	xorq	%r12, %r11
	movq	36(%rax), %r12
	movq	%r11, 4(%rdx)
	movq	-68(%rax), %r11
	xorq	%r8, %r15
	xorq	%r9, %r12
	movq	%r15, %r13
	rolq	$10, %r13
	xorq	%rdi, %rbx
	rolq	$15, %r12
	xorq	%r10, %rbp
	rolq	$36, %rbx
	xorq	%rsi, %r11
	rolq	$56, %rbp
	movq	%r13, %r14
	orq 	%r12, %r13
	rolq	$27, %r11
	notq	%r12
	xorq	%rbx, %r13
	movq	%r13, 28(%rdx)
	movq	%rbp, %r13
	orq 	%r12, %rbp
	xorq	%r14, %rbp
	movq	%rbp, 36(%rdx)
	andq	%rbx, %r14
	xorq	%r11, %r14
	movq	%r14, 20(%rdx)
	orq 	%r11, %rbx
	xorq	%r13, %rbx
	movq	%rbx, 52(%rdx)
	andq	%r13, %r11
	xorq	%r12, %r11
	movq	%r11, 44(%rdx)
	xorq	-84(%rax), %r9
	xorq	-36(%rax), %r10
	rolq	$62, %r9
	xorq	68(%rax), %r8
	rolq	$55, %r10
	xorq	12(%rax), %rsi
	rolq	$2, %r8
	xorq	20(%rax), %rdi
	movq	%rax, %r11
	movq	%rdx, %rax
	movq	%r11, %rdx
	rolq	$39, %rsi
	rolq	$41, %rdi
	movq	%r9, %r11
	andq	%r10, %r9
	notq	%r10
	xorq	%r8, %r9
	movq	%r9, 92(%rax)
	movq	%rsi, %rbp
	andq	%r10, %rsi
	xorq	%r11, %rsi
	movq	%rsi, 60(%rax)
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
	testb	$-1, %cl
	jne 	Lsha3512_ref2x_jazz$12
	notq	-92(%rax)
	notq	-84(%rax)
	notq	-36(%rax)
	notq	-4(%rax)
	notq	36(%rax)
	notq	60(%rax)
	leaq	-192(%rcx), %rcx
	leaq	-100(%rax), %rax
	movq	16(%rsp), %rdx
	movq	$64, 16(%rsp)
	jmp 	Lsha3512_ref2x_jazz$5
Lsha3512_ref2x_jazz$6:
	movq	$72, %rsi
	movq	%rsi, %rdi
	shrq	$3, %rdi
	movq	$0, %r8
	jmp 	Lsha3512_ref2x_jazz$10
Lsha3512_ref2x_jazz$11:
	movq	(%rax,%r8,8), %r9
	movq	%r9, (%rdx,%r8,8)
	leaq	1(%r8), %r8
Lsha3512_ref2x_jazz$10:
	cmpq	%rdi, %r8
	jb  	Lsha3512_ref2x_jazz$11
	shlq	$3, %r8
	jmp 	Lsha3512_ref2x_jazz$8
Lsha3512_ref2x_jazz$9:
	movb	(%rax,%r8), %dil
	movb	%dil, (%rdx,%r8)
	leaq	1(%r8), %r8
Lsha3512_ref2x_jazz$8:
	cmpq	%rsi, %r8
	jb  	Lsha3512_ref2x_jazz$9
	leaq	(%rdx,%rsi), %rdx
	movq	%rdx, 8(%rsp)
	leaq	100(%rax), %rax
	leaq	200(%rax), %rdx
	notq	-92(%rax)
	notq	-84(%rax)
	notq	-36(%rax)
	notq	-4(%rax)
	notq	36(%rax)
	notq	60(%rax)
	movq	60(%rax), %rsi
	movq	68(%rax), %rdi
	movq	76(%rax), %r8
	movq	84(%rax), %r9
	movq	92(%rax), %r10
Lsha3512_ref2x_jazz$7:
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
	xorq	%r8, %rbp
	xorq	%r9, %rbx
	rolq	$44, %rbp
	xorq	%r10, %r12
	xorq	%rsi, %r13
	rolq	$43, %rbx
	xorq	%rdi, %r11
	movq	%rbp, %r14
	rolq	$21, %r12
	orq 	%rbx, %rbp
	xorq	%r11, %rbp
	rolq	$14, %r13
	xorq	(%rcx), %rbp
	leaq	8(%rcx), %rcx
	movq	%r13, %r15
	andq	%r12, %r13
	movq	%rbp, -100(%rdx)
	xorq	%rbx, %r13
	notq	%rbx
	movq	%r13, -84(%rdx)
	orq 	%r12, %rbx
	movq	76(%rax), %rbp
	xorq	%r14, %rbx
	movq	%rbx, -92(%rdx)
	andq	%r11, %r14
	movq	-28(%rax), %rbx
	xorq	%r15, %r14
	movq	-20(%rax), %r13
	movq	%r14, -68(%rdx)
	orq 	%r11, %r15
	movq	-76(%rax), %r11
	xorq	%r12, %r15
	movq	28(%rax), %r12
	movq	%r15, -76(%rdx)
	xorq	%r10, %r11
	xorq	%r9, %rbp
	rolq	$28, %r11
	xorq	%r8, %r12
	xorq	%rsi, %rbx
	rolq	$61, %rbp
	rolq	$45, %r12
	xorq	%rdi, %r13
	rolq	$20, %rbx
	movq	%r11, %r14
	orq 	%rbp, %r11
	rolq	$3, %r13
	xorq	%r12, %r11
	movq	%r11, -36(%rdx)
	movq	%rbx, %r11
	andq	%r14, %rbx
	movq	-92(%rax), %r15
	xorq	%rbp, %rbx
	notq	%rbp
	movq	%rbx, -28(%rdx)
	orq 	%r12, %rbp
	movq	-44(%rax), %rbx
	xorq	%r13, %rbp
	movq	%rbp, -44(%rdx)
	andq	%r13, %r12
	movq	60(%rax), %rbp
	xorq	%r11, %r12
	movq	%r12, -52(%rdx)
	orq 	%r13, %r11
	movq	4(%rax), %r12
	xorq	%r14, %r11
	movq	52(%rax), %r13
	movq	%r11, -60(%rdx)
	xorq	%r10, %r12
	xorq	%rsi, %r13
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
	movq	%r11, -12(%rdx)
	movq	%rbp, %r11
	andq	%r12, %rbp
	movq	-12(%rax), %r15
	xorq	%r13, %rbp
	movq	%rbp, -4(%rdx)
	orq 	%rbx, %r13
	movq	84(%rax), %rbp
	xorq	%r14, %r13
	movq	%r13, -20(%rdx)
	andq	%r14, %rbx
	xorq	%r11, %rbx
	movq	%rbx, 12(%rdx)
	orq 	%r14, %r11
	movq	-60(%rax), %rbx
	xorq	%r12, %r11
	movq	36(%rax), %r12
	movq	%r11, 4(%rdx)
	movq	-68(%rax), %r11
	xorq	%r8, %r15
	xorq	%r9, %r12
	movq	%r15, %r13
	rolq	$10, %r13
	xorq	%rdi, %rbx
	rolq	$15, %r12
	xorq	%r10, %rbp
	rolq	$36, %rbx
	xorq	%rsi, %r11
	rolq	$56, %rbp
	movq	%r13, %r14
	orq 	%r12, %r13
	rolq	$27, %r11
	notq	%r12
	xorq	%rbx, %r13
	movq	%r13, 28(%rdx)
	movq	%rbp, %r13
	orq 	%r12, %rbp
	xorq	%r14, %rbp
	movq	%rbp, 36(%rdx)
	andq	%rbx, %r14
	xorq	%r11, %r14
	movq	%r14, 20(%rdx)
	orq 	%r11, %rbx
	xorq	%r13, %rbx
	movq	%rbx, 52(%rdx)
	andq	%r13, %r11
	xorq	%r12, %r11
	movq	%r11, 44(%rdx)
	xorq	-84(%rax), %r9
	xorq	-36(%rax), %r10
	rolq	$62, %r9
	xorq	68(%rax), %r8
	rolq	$55, %r10
	xorq	12(%rax), %rsi
	rolq	$2, %r8
	xorq	20(%rax), %rdi
	movq	%rax, %r11
	movq	%rdx, %rax
	movq	%r11, %rdx
	rolq	$39, %rsi
	rolq	$41, %rdi
	movq	%r9, %r11
	andq	%r10, %r9
	notq	%r10
	xorq	%r8, %r9
	movq	%r9, 92(%rax)
	movq	%rsi, %rbp
	andq	%r10, %rsi
	xorq	%r11, %rsi
	movq	%rsi, 60(%rax)
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
	testb	$-1, %cl
	jne 	Lsha3512_ref2x_jazz$7
	notq	-92(%rax)
	notq	-84(%rax)
	notq	-36(%rax)
	notq	-4(%rax)
	notq	36(%rax)
	notq	60(%rax)
	leaq	-192(%rcx), %rcx
	leaq	-100(%rax), %rax
	subq	$72, 16(%rsp)
	movq	8(%rsp), %rdx
Lsha3512_ref2x_jazz$5:
	cmpq	$72, 16(%rsp)
	jnb 	Lsha3512_ref2x_jazz$6
	movq	16(%rsp), %rcx
	movq	%rcx, %rsi
	shrq	$3, %rsi
	movq	$0, %rdi
	jmp 	Lsha3512_ref2x_jazz$3
Lsha3512_ref2x_jazz$4:
	movq	(%rax,%rdi,8), %r8
	movq	%r8, (%rdx,%rdi,8)
	leaq	1(%rdi), %rdi
Lsha3512_ref2x_jazz$3:
	cmpq	%rsi, %rdi
	jb  	Lsha3512_ref2x_jazz$4
	shlq	$3, %rdi
	jmp 	Lsha3512_ref2x_jazz$1
Lsha3512_ref2x_jazz$2:
	movb	(%rax,%rdi), %sil
	movb	%sil, (%rdx,%rdi)
	leaq	1(%rdi), %rdi
Lsha3512_ref2x_jazz$1:
	cmpq	%rcx, %rdi
	jb  	Lsha3512_ref2x_jazz$2
	addq	$24, %rsp
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	ret 

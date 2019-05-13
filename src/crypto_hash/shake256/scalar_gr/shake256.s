	.text
	.p2align	5
	.globl	_keccak_1600
	.globl	keccak_1600
_keccak_1600:
keccak_1600:
	pushq	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	subq	$449, %rsp
	movq	%rdi, 400(%rsp)
	movq	%rsi, 440(%rsp)
	movq	%rcx, %rax
	movb	(%r8), %cl
	movb	%cl, 448(%rsp)
	movq	8(%r8), %rsi
	xorl	%ecx, %ecx
	movq	$0, %rdi
	jmp 	Lkeccak_1600$20
Lkeccak_1600$21:
	movq	%rcx, 200(%rsp,%rdi,8)
	leaq	1(%rdi), %rdi
Lkeccak_1600$20:
	cmpq	$25, %rdi
	jb  	Lkeccak_1600$21
	movq	%rsi, 432(%rsp)
	jmp 	Lkeccak_1600$17
Lkeccak_1600$18:
	movq	(%rdx), %rcx
	movq	8(%rdx), %rdi
	movq	16(%rdx), %r8
	xorq	%rcx, 200(%rsp)
	xorq	%rdi, 208(%rsp)
	xorq	%r8, 216(%rsp)
	movq	24(%rdx), %rcx
	movq	32(%rdx), %rdi
	movq	40(%rdx), %r8
	xorq	%rcx, 224(%rsp)
	xorq	%rdi, 232(%rsp)
	xorq	%r8, 240(%rsp)
	movq	48(%rdx), %rcx
	movq	56(%rdx), %rdi
	movq	64(%rdx), %r8
	xorq	%rcx, 248(%rsp)
	xorq	%rdi, 256(%rsp)
	xorq	%r8, 264(%rsp)
	movq	72(%rdx), %rcx
	movq	80(%rdx), %rdi
	movq	88(%rdx), %r8
	xorq	%rcx, 272(%rsp)
	xorq	%rdi, 280(%rsp)
	xorq	%r8, 288(%rsp)
	movq	96(%rdx), %rcx
	movq	104(%rdx), %rdi
	movq	112(%rdx), %r8
	xorq	%rcx, 296(%rsp)
	xorq	%rdi, 304(%rsp)
	xorq	%r8, 312(%rsp)
	movq	120(%rdx), %rcx
	xorq	%rcx, 320(%rsp)
	movq	128(%rdx), %rcx
	xorq	%rcx, 328(%rsp)
	leaq	(%rdx,%rsi), %rcx
	subq	%rsi, %rax
	movq	%rcx, 424(%rsp)
	movq	%rax, 416(%rsp)
	movq	%rsi, 408(%rsp)
	movq	$24, %rax
	leaq	glob_data(%rip), %rcx
	.p2align	5
Lkeccak_1600$19:
	movq	200(%rsp), %rdx
	movq	208(%rsp), %rsi
	movq	216(%rsp), %rdi
	movq	224(%rsp), %r8
	movq	232(%rsp), %r10
	xorq	240(%rsp), %rdx
	xorq	248(%rsp), %rsi
	xorq	256(%rsp), %rdi
	xorq	264(%rsp), %r8
	xorq	272(%rsp), %r10
	xorq	280(%rsp), %rdx
	xorq	288(%rsp), %rsi
	xorq	296(%rsp), %rdi
	xorq	304(%rsp), %r8
	xorq	312(%rsp), %r10
	xorq	320(%rsp), %rdx
	xorq	328(%rsp), %rsi
	xorq	336(%rsp), %rdi
	xorq	344(%rsp), %r8
	xorq	352(%rsp), %r10
	xorq	360(%rsp), %rdx
	xorq	368(%rsp), %rsi
	xorq	376(%rsp), %rdi
	xorq	384(%rsp), %r8
	xorq	392(%rsp), %r10
	movq	%rsi, %r11
	rolq	$1, %r11
	xorq	%r10, %r11
	movq	%rdi, %rbp
	rolq	$1, %rbp
	xorq	%rdx, %rbp
	movq	%r8, %rbx
	rolq	$1, %rbx
	xorq	%rsi, %rbx
	movq	%r10, %rsi
	rolq	$1, %rsi
	xorq	%rdi, %rsi
	rolq	$1, %rdx
	xorq	%r8, %rdx
	movq	200(%rsp), %rdi
	xorq	%r11, %rdi
	movq	248(%rsp), %r8
	xorq	%rbp, %r8
	rolq	$44, %r8
	movq	296(%rsp), %r10
	xorq	%rbx, %r10
	rolq	$43, %r10
	movq	344(%rsp), %r12
	xorq	%rsi, %r12
	rolq	$21, %r12
	movq	392(%rsp), %r13
	xorq	%rdx, %r13
	rolq	$14, %r13
	andnq	%r10, %r8, %r14
	xorq	(%rcx,%rax,8), %r14
	xorq	%rdi, %r14
	movq	%r14, (%rsp)
	andnq	%r12, %r10, %r14
	xorq	%r8, %r14
	movq	%r14, 8(%rsp)
	andnq	%r13, %r12, %r14
	xorq	%r10, %r14
	movq	%r14, 16(%rsp)
	andnq	%rdi, %r13, %r10
	xorq	%r12, %r10
	movq	%r10, 24(%rsp)
	andnq	%r8, %rdi, %rdi
	xorq	%r13, %rdi
	movq	%rdi, 32(%rsp)
	movq	224(%rsp), %rdi
	xorq	%rsi, %rdi
	rolq	$28, %rdi
	movq	272(%rsp), %r8
	xorq	%rdx, %r8
	rolq	$20, %r8
	movq	280(%rsp), %r10
	xorq	%r11, %r10
	rolq	$3, %r10
	movq	328(%rsp), %r12
	xorq	%rbp, %r12
	rolq	$45, %r12
	movq	376(%rsp), %r13
	xorq	%rbx, %r13
	rolq	$61, %r13
	andnq	%r10, %r8, %r14
	xorq	%rdi, %r14
	movq	%r14, 40(%rsp)
	andnq	%r12, %r10, %r14
	xorq	%r8, %r14
	movq	%r14, 48(%rsp)
	andnq	%r13, %r12, %r14
	xorq	%r10, %r14
	movq	%r14, 56(%rsp)
	andnq	%rdi, %r13, %r10
	xorq	%r12, %r10
	movq	%r10, 64(%rsp)
	andnq	%r8, %rdi, %rdi
	xorq	%r13, %rdi
	movq	%rdi, 72(%rsp)
	movq	208(%rsp), %rdi
	xorq	%rbp, %rdi
	rolq	$1, %rdi
	movq	256(%rsp), %r8
	xorq	%rbx, %r8
	rolq	$6, %r8
	movq	304(%rsp), %r10
	xorq	%rsi, %r10
	rolq	$25, %r10
	movq	352(%rsp), %r12
	xorq	%rdx, %r12
	rolq	$8, %r12
	movq	360(%rsp), %r13
	xorq	%r11, %r13
	rolq	$18, %r13
	andnq	%r10, %r8, %r14
	xorq	%rdi, %r14
	movq	%r14, 80(%rsp)
	andnq	%r12, %r10, %r14
	xorq	%r8, %r14
	movq	%r14, 88(%rsp)
	andnq	%r13, %r12, %r14
	xorq	%r10, %r14
	movq	%r14, 96(%rsp)
	andnq	%rdi, %r13, %r10
	xorq	%r12, %r10
	movq	%r10, 104(%rsp)
	andnq	%r8, %rdi, %rdi
	xorq	%r13, %rdi
	movq	%rdi, 112(%rsp)
	movq	232(%rsp), %rdi
	xorq	%rdx, %rdi
	rolq	$27, %rdi
	movq	240(%rsp), %r8
	xorq	%r11, %r8
	rolq	$36, %r8
	movq	288(%rsp), %r10
	xorq	%rbp, %r10
	rolq	$10, %r10
	movq	336(%rsp), %r12
	xorq	%rbx, %r12
	rolq	$15, %r12
	movq	384(%rsp), %r13
	xorq	%rsi, %r13
	rolq	$56, %r13
	andnq	%r10, %r8, %r14
	xorq	%rdi, %r14
	movq	%r14, 120(%rsp)
	andnq	%r12, %r10, %r14
	xorq	%r8, %r14
	movq	%r14, 128(%rsp)
	andnq	%r13, %r12, %r14
	xorq	%r10, %r14
	movq	%r14, 136(%rsp)
	andnq	%rdi, %r13, %r10
	xorq	%r12, %r10
	movq	%r10, 144(%rsp)
	andnq	%r8, %rdi, %rdi
	xorq	%r13, %rdi
	movq	%rdi, 152(%rsp)
	movq	216(%rsp), %rdi
	xorq	%rbx, %rdi
	rolq	$62, %rdi
	movq	264(%rsp), %r8
	xorq	%rsi, %r8
	rolq	$55, %r8
	movq	%r8, %rsi
	movq	312(%rsp), %r8
	xorq	%rdx, %r8
	rolq	$39, %r8
	movq	%r8, %rdx
	movq	320(%rsp), %r8
	xorq	%r11, %r8
	rolq	$41, %r8
	movq	368(%rsp), %r10
	xorq	%rbp, %r10
	rolq	$2, %r10
	andnq	%rdx, %rsi, %r11
	xorq	%rdi, %r11
	movq	%r11, 160(%rsp)
	andnq	%r8, %rdx, %r11
	xorq	%rsi, %r11
	movq	%r11, 168(%rsp)
	andnq	%r10, %r8, %r11
	xorq	%rdx, %r11
	movq	%r11, 176(%rsp)
	andnq	%rdi, %r10, %rdx
	xorq	%r8, %rdx
	movq	%rdx, 184(%rsp)
	andnq	%rsi, %rdi, %rdx
	xorq	%r10, %rdx
	movq	%rdx, 192(%rsp)
	decq	%rax
	movq	(%rsp), %rdx
	movq	8(%rsp), %rsi
	movq	16(%rsp), %rdi
	movq	24(%rsp), %r8
	movq	32(%rsp), %r10
	xorq	40(%rsp), %rdx
	xorq	48(%rsp), %rsi
	xorq	56(%rsp), %rdi
	xorq	64(%rsp), %r8
	xorq	72(%rsp), %r10
	xorq	80(%rsp), %rdx
	xorq	88(%rsp), %rsi
	xorq	96(%rsp), %rdi
	xorq	104(%rsp), %r8
	xorq	112(%rsp), %r10
	xorq	120(%rsp), %rdx
	xorq	128(%rsp), %rsi
	xorq	136(%rsp), %rdi
	xorq	144(%rsp), %r8
	xorq	152(%rsp), %r10
	xorq	160(%rsp), %rdx
	xorq	168(%rsp), %rsi
	xorq	176(%rsp), %rdi
	xorq	184(%rsp), %r8
	xorq	192(%rsp), %r10
	movq	%rsi, %r11
	rolq	$1, %r11
	xorq	%r10, %r11
	movq	%rdi, %rbp
	rolq	$1, %rbp
	xorq	%rdx, %rbp
	movq	%r8, %rbx
	rolq	$1, %rbx
	xorq	%rsi, %rbx
	movq	%r10, %rsi
	rolq	$1, %rsi
	xorq	%rdi, %rsi
	rolq	$1, %rdx
	xorq	%r8, %rdx
	movq	(%rsp), %rdi
	xorq	%r11, %rdi
	movq	48(%rsp), %r8
	xorq	%rbp, %r8
	rolq	$44, %r8
	movq	96(%rsp), %r10
	xorq	%rbx, %r10
	rolq	$43, %r10
	movq	144(%rsp), %r12
	xorq	%rsi, %r12
	rolq	$21, %r12
	movq	192(%rsp), %r13
	xorq	%rdx, %r13
	rolq	$14, %r13
	andnq	%r10, %r8, %r14
	xorq	(%rcx,%rax,8), %r14
	xorq	%rdi, %r14
	movq	%r14, 200(%rsp)
	andnq	%r12, %r10, %r14
	xorq	%r8, %r14
	movq	%r14, 208(%rsp)
	andnq	%r13, %r12, %r14
	xorq	%r10, %r14
	movq	%r14, 216(%rsp)
	andnq	%rdi, %r13, %r10
	xorq	%r12, %r10
	movq	%r10, 224(%rsp)
	andnq	%r8, %rdi, %rdi
	xorq	%r13, %rdi
	movq	%rdi, 232(%rsp)
	movq	24(%rsp), %rdi
	xorq	%rsi, %rdi
	rolq	$28, %rdi
	movq	72(%rsp), %r8
	xorq	%rdx, %r8
	rolq	$20, %r8
	movq	80(%rsp), %r10
	xorq	%r11, %r10
	rolq	$3, %r10
	movq	128(%rsp), %r12
	xorq	%rbp, %r12
	rolq	$45, %r12
	movq	176(%rsp), %r13
	xorq	%rbx, %r13
	rolq	$61, %r13
	andnq	%r10, %r8, %r14
	xorq	%rdi, %r14
	movq	%r14, 240(%rsp)
	andnq	%r12, %r10, %r14
	xorq	%r8, %r14
	movq	%r14, 248(%rsp)
	andnq	%r13, %r12, %r14
	xorq	%r10, %r14
	movq	%r14, 256(%rsp)
	andnq	%rdi, %r13, %r10
	xorq	%r12, %r10
	movq	%r10, 264(%rsp)
	andnq	%r8, %rdi, %rdi
	xorq	%r13, %rdi
	movq	%rdi, 272(%rsp)
	movq	8(%rsp), %rdi
	xorq	%rbp, %rdi
	rolq	$1, %rdi
	movq	56(%rsp), %r8
	xorq	%rbx, %r8
	rolq	$6, %r8
	movq	104(%rsp), %r10
	xorq	%rsi, %r10
	rolq	$25, %r10
	movq	152(%rsp), %r12
	xorq	%rdx, %r12
	rolq	$8, %r12
	movq	160(%rsp), %r13
	xorq	%r11, %r13
	rolq	$18, %r13
	andnq	%r10, %r8, %r14
	xorq	%rdi, %r14
	movq	%r14, 280(%rsp)
	andnq	%r12, %r10, %r14
	xorq	%r8, %r14
	movq	%r14, 288(%rsp)
	andnq	%r13, %r12, %r14
	xorq	%r10, %r14
	movq	%r14, 296(%rsp)
	andnq	%rdi, %r13, %r10
	xorq	%r12, %r10
	movq	%r10, 304(%rsp)
	andnq	%r8, %rdi, %rdi
	xorq	%r13, %rdi
	movq	%rdi, 312(%rsp)
	movq	32(%rsp), %rdi
	xorq	%rdx, %rdi
	rolq	$27, %rdi
	movq	40(%rsp), %r8
	xorq	%r11, %r8
	rolq	$36, %r8
	movq	88(%rsp), %r10
	xorq	%rbp, %r10
	rolq	$10, %r10
	movq	136(%rsp), %r12
	xorq	%rbx, %r12
	rolq	$15, %r12
	movq	184(%rsp), %r13
	xorq	%rsi, %r13
	rolq	$56, %r13
	andnq	%r10, %r8, %r14
	xorq	%rdi, %r14
	movq	%r14, 320(%rsp)
	andnq	%r12, %r10, %r14
	xorq	%r8, %r14
	movq	%r14, 328(%rsp)
	andnq	%r13, %r12, %r14
	xorq	%r10, %r14
	movq	%r14, 336(%rsp)
	andnq	%rdi, %r13, %r10
	xorq	%r12, %r10
	movq	%r10, 344(%rsp)
	andnq	%r8, %rdi, %rdi
	xorq	%r13, %rdi
	movq	%rdi, 352(%rsp)
	movq	16(%rsp), %rdi
	xorq	%rbx, %rdi
	rolq	$62, %rdi
	movq	64(%rsp), %r8
	xorq	%rsi, %r8
	rolq	$55, %r8
	movq	%r8, %rsi
	movq	112(%rsp), %r8
	xorq	%rdx, %r8
	rolq	$39, %r8
	movq	%r8, %rdx
	movq	120(%rsp), %r8
	xorq	%r11, %r8
	rolq	$41, %r8
	movq	168(%rsp), %r10
	xorq	%rbp, %r10
	rolq	$2, %r10
	andnq	%rdx, %rsi, %r11
	xorq	%rdi, %r11
	movq	%r11, 360(%rsp)
	andnq	%r8, %rdx, %r11
	xorq	%rsi, %r11
	movq	%r11, 368(%rsp)
	andnq	%r10, %r8, %r11
	xorq	%rdx, %r11
	movq	%r11, 376(%rsp)
	andnq	%rdi, %r10, %rdx
	xorq	%r8, %rdx
	movq	%rdx, 384(%rsp)
	andnq	%rsi, %rdi, %rdx
	xorq	%r10, %rdx
	movq	%rdx, 392(%rsp)
	decq	%rax
	jne 	Lkeccak_1600$19
	movq	424(%rsp), %rdx
	movq	416(%rsp), %rax
	movq	408(%rsp), %rsi
Lkeccak_1600$17:
	cmpq	%rsi, %rax
	jnb 	Lkeccak_1600$18
	movq	%rax, %rcx
	shrq	$3, %rcx
	movq	$0, %rdi
	jmp 	Lkeccak_1600$15
Lkeccak_1600$16:
	movq	(%rdx,%rdi,8), %r8
	xorq	%r8, 200(%rsp,%rdi,8)
	leaq	1(%rdi), %rdi
Lkeccak_1600$15:
	cmpq	%rcx, %rdi
	jb  	Lkeccak_1600$16
	leaq	(%rdx,%rdi,8), %r11
	andq	$7, %rax
	movzbq	448(%rsp), %rdx
	movq	$0, %r10
	movq	$0, %rcx
	testb	$4, %al
	je  	Lkeccak_1600$14
	movl	(%r11), %r10d
	leaq	4(%r11), %r11
	movq	$32, %rcx
Lkeccak_1600$14:
	testb	$2, %al
	je  	Lkeccak_1600$13
	movzwq	(%r11), %r8
	leaq	2(%r11), %r11
	shlq	%cl, %r8
	leaq	16(%rcx), %rcx
	leaq	(%r10,%r8), %r10
Lkeccak_1600$13:
	testb	$1, %al
	je  	Lkeccak_1600$12
	movzbq	(%r11), %rax
	shlq	%cl, %rax
	leaq	8(%rcx), %rcx
	leaq	(%r10,%rax), %r10
Lkeccak_1600$12:
	shlq	%cl, %rdx
	leaq	(%r10,%rdx), %rax
	xorq	%rax, 200(%rsp,%rdi,8)
	leaq	-1(%rsi), %rax
	xorb	$-128, 200(%rsp,%rax)
	movq	432(%rsp), %rax
	movq	440(%rsp), %rdx
	jmp 	Lkeccak_1600$1
Lkeccak_1600$2:
	movq	%rdx, 440(%rsp)
	movq	%rax, 432(%rsp)
	movq	$24, %rax
	leaq	glob_data(%rip), %rcx
	.p2align	5
Lkeccak_1600$11:
	movq	200(%rsp), %rdx
	movq	208(%rsp), %rsi
	movq	216(%rsp), %rdi
	movq	224(%rsp), %r8
	movq	232(%rsp), %r10
	xorq	240(%rsp), %rdx
	xorq	248(%rsp), %rsi
	xorq	256(%rsp), %rdi
	xorq	264(%rsp), %r8
	xorq	272(%rsp), %r10
	xorq	280(%rsp), %rdx
	xorq	288(%rsp), %rsi
	xorq	296(%rsp), %rdi
	xorq	304(%rsp), %r8
	xorq	312(%rsp), %r10
	xorq	320(%rsp), %rdx
	xorq	328(%rsp), %rsi
	xorq	336(%rsp), %rdi
	xorq	344(%rsp), %r8
	xorq	352(%rsp), %r10
	xorq	360(%rsp), %rdx
	xorq	368(%rsp), %rsi
	xorq	376(%rsp), %rdi
	xorq	384(%rsp), %r8
	xorq	392(%rsp), %r10
	movq	%rsi, %r11
	rolq	$1, %r11
	xorq	%r10, %r11
	movq	%rdi, %rbp
	rolq	$1, %rbp
	xorq	%rdx, %rbp
	movq	%r8, %rbx
	rolq	$1, %rbx
	xorq	%rsi, %rbx
	movq	%r10, %rsi
	rolq	$1, %rsi
	xorq	%rdi, %rsi
	rolq	$1, %rdx
	xorq	%r8, %rdx
	movq	200(%rsp), %rdi
	xorq	%r11, %rdi
	movq	248(%rsp), %r8
	xorq	%rbp, %r8
	rolq	$44, %r8
	movq	296(%rsp), %r10
	xorq	%rbx, %r10
	rolq	$43, %r10
	movq	344(%rsp), %r12
	xorq	%rsi, %r12
	rolq	$21, %r12
	movq	392(%rsp), %r13
	xorq	%rdx, %r13
	rolq	$14, %r13
	andnq	%r10, %r8, %r14
	xorq	(%rcx,%rax,8), %r14
	xorq	%rdi, %r14
	movq	%r14, (%rsp)
	andnq	%r12, %r10, %r14
	xorq	%r8, %r14
	movq	%r14, 8(%rsp)
	andnq	%r13, %r12, %r14
	xorq	%r10, %r14
	movq	%r14, 16(%rsp)
	andnq	%rdi, %r13, %r10
	xorq	%r12, %r10
	movq	%r10, 24(%rsp)
	andnq	%r8, %rdi, %rdi
	xorq	%r13, %rdi
	movq	%rdi, 32(%rsp)
	movq	224(%rsp), %rdi
	xorq	%rsi, %rdi
	rolq	$28, %rdi
	movq	272(%rsp), %r8
	xorq	%rdx, %r8
	rolq	$20, %r8
	movq	280(%rsp), %r10
	xorq	%r11, %r10
	rolq	$3, %r10
	movq	328(%rsp), %r12
	xorq	%rbp, %r12
	rolq	$45, %r12
	movq	376(%rsp), %r13
	xorq	%rbx, %r13
	rolq	$61, %r13
	andnq	%r10, %r8, %r14
	xorq	%rdi, %r14
	movq	%r14, 40(%rsp)
	andnq	%r12, %r10, %r14
	xorq	%r8, %r14
	movq	%r14, 48(%rsp)
	andnq	%r13, %r12, %r14
	xorq	%r10, %r14
	movq	%r14, 56(%rsp)
	andnq	%rdi, %r13, %r10
	xorq	%r12, %r10
	movq	%r10, 64(%rsp)
	andnq	%r8, %rdi, %rdi
	xorq	%r13, %rdi
	movq	%rdi, 72(%rsp)
	movq	208(%rsp), %rdi
	xorq	%rbp, %rdi
	rolq	$1, %rdi
	movq	256(%rsp), %r8
	xorq	%rbx, %r8
	rolq	$6, %r8
	movq	304(%rsp), %r10
	xorq	%rsi, %r10
	rolq	$25, %r10
	movq	352(%rsp), %r12
	xorq	%rdx, %r12
	rolq	$8, %r12
	movq	360(%rsp), %r13
	xorq	%r11, %r13
	rolq	$18, %r13
	andnq	%r10, %r8, %r14
	xorq	%rdi, %r14
	movq	%r14, 80(%rsp)
	andnq	%r12, %r10, %r14
	xorq	%r8, %r14
	movq	%r14, 88(%rsp)
	andnq	%r13, %r12, %r14
	xorq	%r10, %r14
	movq	%r14, 96(%rsp)
	andnq	%rdi, %r13, %r10
	xorq	%r12, %r10
	movq	%r10, 104(%rsp)
	andnq	%r8, %rdi, %rdi
	xorq	%r13, %rdi
	movq	%rdi, 112(%rsp)
	movq	232(%rsp), %rdi
	xorq	%rdx, %rdi
	rolq	$27, %rdi
	movq	240(%rsp), %r8
	xorq	%r11, %r8
	rolq	$36, %r8
	movq	288(%rsp), %r10
	xorq	%rbp, %r10
	rolq	$10, %r10
	movq	336(%rsp), %r12
	xorq	%rbx, %r12
	rolq	$15, %r12
	movq	384(%rsp), %r13
	xorq	%rsi, %r13
	rolq	$56, %r13
	andnq	%r10, %r8, %r14
	xorq	%rdi, %r14
	movq	%r14, 120(%rsp)
	andnq	%r12, %r10, %r14
	xorq	%r8, %r14
	movq	%r14, 128(%rsp)
	andnq	%r13, %r12, %r14
	xorq	%r10, %r14
	movq	%r14, 136(%rsp)
	andnq	%rdi, %r13, %r10
	xorq	%r12, %r10
	movq	%r10, 144(%rsp)
	andnq	%r8, %rdi, %rdi
	xorq	%r13, %rdi
	movq	%rdi, 152(%rsp)
	movq	216(%rsp), %rdi
	xorq	%rbx, %rdi
	rolq	$62, %rdi
	movq	264(%rsp), %r8
	xorq	%rsi, %r8
	rolq	$55, %r8
	movq	%r8, %rsi
	movq	312(%rsp), %r8
	xorq	%rdx, %r8
	rolq	$39, %r8
	movq	%r8, %rdx
	movq	320(%rsp), %r8
	xorq	%r11, %r8
	rolq	$41, %r8
	movq	368(%rsp), %r10
	xorq	%rbp, %r10
	rolq	$2, %r10
	andnq	%rdx, %rsi, %r11
	xorq	%rdi, %r11
	movq	%r11, 160(%rsp)
	andnq	%r8, %rdx, %r11
	xorq	%rsi, %r11
	movq	%r11, 168(%rsp)
	andnq	%r10, %r8, %r11
	xorq	%rdx, %r11
	movq	%r11, 176(%rsp)
	andnq	%rdi, %r10, %rdx
	xorq	%r8, %rdx
	movq	%rdx, 184(%rsp)
	andnq	%rsi, %rdi, %rdx
	xorq	%r10, %rdx
	movq	%rdx, 192(%rsp)
	decq	%rax
	movq	(%rsp), %rdx
	movq	8(%rsp), %rsi
	movq	16(%rsp), %rdi
	movq	24(%rsp), %r8
	movq	32(%rsp), %r10
	xorq	40(%rsp), %rdx
	xorq	48(%rsp), %rsi
	xorq	56(%rsp), %rdi
	xorq	64(%rsp), %r8
	xorq	72(%rsp), %r10
	xorq	80(%rsp), %rdx
	xorq	88(%rsp), %rsi
	xorq	96(%rsp), %rdi
	xorq	104(%rsp), %r8
	xorq	112(%rsp), %r10
	xorq	120(%rsp), %rdx
	xorq	128(%rsp), %rsi
	xorq	136(%rsp), %rdi
	xorq	144(%rsp), %r8
	xorq	152(%rsp), %r10
	xorq	160(%rsp), %rdx
	xorq	168(%rsp), %rsi
	xorq	176(%rsp), %rdi
	xorq	184(%rsp), %r8
	xorq	192(%rsp), %r10
	movq	%rsi, %r11
	rolq	$1, %r11
	xorq	%r10, %r11
	movq	%rdi, %rbp
	rolq	$1, %rbp
	xorq	%rdx, %rbp
	movq	%r8, %rbx
	rolq	$1, %rbx
	xorq	%rsi, %rbx
	movq	%r10, %rsi
	rolq	$1, %rsi
	xorq	%rdi, %rsi
	rolq	$1, %rdx
	xorq	%r8, %rdx
	movq	(%rsp), %rdi
	xorq	%r11, %rdi
	movq	48(%rsp), %r8
	xorq	%rbp, %r8
	rolq	$44, %r8
	movq	96(%rsp), %r10
	xorq	%rbx, %r10
	rolq	$43, %r10
	movq	144(%rsp), %r12
	xorq	%rsi, %r12
	rolq	$21, %r12
	movq	192(%rsp), %r13
	xorq	%rdx, %r13
	rolq	$14, %r13
	andnq	%r10, %r8, %r14
	xorq	(%rcx,%rax,8), %r14
	xorq	%rdi, %r14
	movq	%r14, 200(%rsp)
	andnq	%r12, %r10, %r14
	xorq	%r8, %r14
	movq	%r14, 208(%rsp)
	andnq	%r13, %r12, %r14
	xorq	%r10, %r14
	movq	%r14, 216(%rsp)
	andnq	%rdi, %r13, %r10
	xorq	%r12, %r10
	movq	%r10, 224(%rsp)
	andnq	%r8, %rdi, %rdi
	xorq	%r13, %rdi
	movq	%rdi, 232(%rsp)
	movq	24(%rsp), %rdi
	xorq	%rsi, %rdi
	rolq	$28, %rdi
	movq	72(%rsp), %r8
	xorq	%rdx, %r8
	rolq	$20, %r8
	movq	80(%rsp), %r10
	xorq	%r11, %r10
	rolq	$3, %r10
	movq	128(%rsp), %r12
	xorq	%rbp, %r12
	rolq	$45, %r12
	movq	176(%rsp), %r13
	xorq	%rbx, %r13
	rolq	$61, %r13
	andnq	%r10, %r8, %r14
	xorq	%rdi, %r14
	movq	%r14, 240(%rsp)
	andnq	%r12, %r10, %r14
	xorq	%r8, %r14
	movq	%r14, 248(%rsp)
	andnq	%r13, %r12, %r14
	xorq	%r10, %r14
	movq	%r14, 256(%rsp)
	andnq	%rdi, %r13, %r10
	xorq	%r12, %r10
	movq	%r10, 264(%rsp)
	andnq	%r8, %rdi, %rdi
	xorq	%r13, %rdi
	movq	%rdi, 272(%rsp)
	movq	8(%rsp), %rdi
	xorq	%rbp, %rdi
	rolq	$1, %rdi
	movq	56(%rsp), %r8
	xorq	%rbx, %r8
	rolq	$6, %r8
	movq	104(%rsp), %r10
	xorq	%rsi, %r10
	rolq	$25, %r10
	movq	152(%rsp), %r12
	xorq	%rdx, %r12
	rolq	$8, %r12
	movq	160(%rsp), %r13
	xorq	%r11, %r13
	rolq	$18, %r13
	andnq	%r10, %r8, %r14
	xorq	%rdi, %r14
	movq	%r14, 280(%rsp)
	andnq	%r12, %r10, %r14
	xorq	%r8, %r14
	movq	%r14, 288(%rsp)
	andnq	%r13, %r12, %r14
	xorq	%r10, %r14
	movq	%r14, 296(%rsp)
	andnq	%rdi, %r13, %r10
	xorq	%r12, %r10
	movq	%r10, 304(%rsp)
	andnq	%r8, %rdi, %rdi
	xorq	%r13, %rdi
	movq	%rdi, 312(%rsp)
	movq	32(%rsp), %rdi
	xorq	%rdx, %rdi
	rolq	$27, %rdi
	movq	40(%rsp), %r8
	xorq	%r11, %r8
	rolq	$36, %r8
	movq	88(%rsp), %r10
	xorq	%rbp, %r10
	rolq	$10, %r10
	movq	136(%rsp), %r12
	xorq	%rbx, %r12
	rolq	$15, %r12
	movq	184(%rsp), %r13
	xorq	%rsi, %r13
	rolq	$56, %r13
	andnq	%r10, %r8, %r14
	xorq	%rdi, %r14
	movq	%r14, 320(%rsp)
	andnq	%r12, %r10, %r14
	xorq	%r8, %r14
	movq	%r14, 328(%rsp)
	andnq	%r13, %r12, %r14
	xorq	%r10, %r14
	movq	%r14, 336(%rsp)
	andnq	%rdi, %r13, %r10
	xorq	%r12, %r10
	movq	%r10, 344(%rsp)
	andnq	%r8, %rdi, %rdi
	xorq	%r13, %rdi
	movq	%rdi, 352(%rsp)
	movq	16(%rsp), %rdi
	xorq	%rbx, %rdi
	rolq	$62, %rdi
	movq	64(%rsp), %r8
	xorq	%rsi, %r8
	rolq	$55, %r8
	movq	%r8, %rsi
	movq	112(%rsp), %r8
	xorq	%rdx, %r8
	rolq	$39, %r8
	movq	%r8, %rdx
	movq	120(%rsp), %r8
	xorq	%r11, %r8
	rolq	$41, %r8
	movq	168(%rsp), %r10
	xorq	%rbp, %r10
	rolq	$2, %r10
	andnq	%rdx, %rsi, %r11
	xorq	%rdi, %r11
	movq	%r11, 360(%rsp)
	andnq	%r8, %rdx, %r11
	xorq	%rsi, %r11
	movq	%r11, 368(%rsp)
	andnq	%r10, %r8, %r11
	xorq	%rdx, %r11
	movq	%r11, 376(%rsp)
	andnq	%rdi, %r10, %rdx
	xorq	%r8, %rdx
	movq	%rdx, 384(%rsp)
	andnq	%rsi, %rdi, %rdx
	xorq	%r10, %rdx
	movq	%rdx, 392(%rsp)
	decq	%rax
	jne 	Lkeccak_1600$11
	movq	400(%rsp), %rcx
	movq	440(%rsp), %rdx
	movq	432(%rsp), %rax
	cmpq	%rax, %rdx
	jnb 	Lkeccak_1600$3
	movq	%rdx, %rsi
	shrq	$3, %rsi
	movq	$0, %rdi
	jmp 	Lkeccak_1600$9
Lkeccak_1600$10:
	movq	200(%rsp,%rdi,8), %r8
	movq	%r8, (%rcx,%rdi,8)
	leaq	1(%rdi), %rdi
Lkeccak_1600$9:
	cmpq	%rsi, %rdi
	jb  	Lkeccak_1600$10
	shlq	$3, %rdi
	jmp 	Lkeccak_1600$7
Lkeccak_1600$8:
	movb	200(%rsp,%rdi), %sil
	movb	%sil, (%rcx,%rdi)
	leaq	1(%rdi), %rdi
Lkeccak_1600$7:
	cmpq	%rdx, %rdi
	jb  	Lkeccak_1600$8
	leaq	(%rcx,%rdx), %rcx
	movq	$0, %rdx
	jmp 	Lkeccak_1600$4
Lkeccak_1600$3:
	movq	%rax, %rsi
	shrq	$3, %rsi
	movq	$0, %rdi
	jmp 	Lkeccak_1600$5
Lkeccak_1600$6:
	movq	200(%rsp,%rdi,8), %r8
	movq	%r8, (%rcx,%rdi,8)
	leaq	1(%rdi), %rdi
Lkeccak_1600$5:
	cmpq	%rsi, %rdi
	jb  	Lkeccak_1600$6
	leaq	(%rcx,%rax), %rcx
	subq	%rax, %rdx
Lkeccak_1600$4:
	movq	%rcx, 400(%rsp)
Lkeccak_1600$1:
	cmpq	$0, %rdx
	jnbe	Lkeccak_1600$2
	addq	$449, %rsp
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	ret 
	.data
	.globl	_glob_data
	.globl	glob_data
	.p2align	5
_glob_data:
glob_data:
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 8
.byte 128
.byte 0
.byte 128
.byte 0
.byte 0
.byte 0
.byte 128
.byte 1
.byte 0
.byte 0
.byte 128
.byte 0
.byte 0
.byte 0
.byte 0
.byte 128
.byte 128
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 128
.byte 129
.byte 128
.byte 0
.byte 128
.byte 0
.byte 0
.byte 0
.byte 128
.byte 10
.byte 0
.byte 0
.byte 128
.byte 0
.byte 0
.byte 0
.byte 128
.byte 10
.byte 128
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 128
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 128
.byte 2
.byte 128
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 128
.byte 3
.byte 128
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 128
.byte 137
.byte 128
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 128
.byte 139
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 128
.byte 139
.byte 128
.byte 0
.byte 128
.byte 0
.byte 0
.byte 0
.byte 0
.byte 10
.byte 0
.byte 0
.byte 128
.byte 0
.byte 0
.byte 0
.byte 0
.byte 9
.byte 128
.byte 0
.byte 128
.byte 0
.byte 0
.byte 0
.byte 0
.byte 136
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 138
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 9
.byte 128
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 128
.byte 129
.byte 128
.byte 0
.byte 128
.byte 0
.byte 0
.byte 0
.byte 128
.byte 1
.byte 0
.byte 0
.byte 128
.byte 0
.byte 0
.byte 0
.byte 0
.byte 139
.byte 128
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 128
.byte 0
.byte 128
.byte 0
.byte 0
.byte 0
.byte 128
.byte 138
.byte 128
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 128
.byte 130
.byte 128
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 1
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
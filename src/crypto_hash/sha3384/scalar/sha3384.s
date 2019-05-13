	.text
	.p2align	5
	.globl	_keccak_1600
	.globl	keccak_1600
_keccak_1600:
keccak_1600:
	pushq	%rbp
	pushq	%rbx
	pushq	%r12
	subq	$464, %rsp
	movq	%rdi, (%rsp)
	movq	%rsi, 448(%rsp)
	movq	%rcx, %rax
	movb	(%r8), %cl
	movb	%cl, 456(%rsp)
	movq	8(%r8), %rsi
	shrq	$3, %rsi
	xorl	%ecx, %ecx
	movq	$0, %rdi
	jmp 	Lkeccak_1600$21
Lkeccak_1600$22:
	movq	%rcx, 8(%rsp,%rdi,8)
	leaq	1(%rdi), %rdi
Lkeccak_1600$21:
	cmpq	$25, %rdi
	jb  	Lkeccak_1600$22
	movq	%rsi, 440(%rsp)
	jmp 	Lkeccak_1600$16
Lkeccak_1600$17:
	movq	$0, %rcx
	movq	%rsi, %rdi
	shrq	$3, %rdi
	jmp 	Lkeccak_1600$19
Lkeccak_1600$20:
	movq	(%rdx,%rcx,8), %r8
	xorq	%r8, 8(%rsp,%rcx,8)
	leaq	1(%rcx), %rcx
Lkeccak_1600$19:
	cmpq	%rdi, %rcx
	jb  	Lkeccak_1600$20
	leaq	(%rdx,%rsi), %rcx
	subq	%rsi, %rax
	movq	%rcx, 224(%rsp)
	movq	%rax, 216(%rsp)
	movq	%rsi, 208(%rsp)
Lkeccak_1600$18:
	movq	(%r9), %rax
	movq	%rax, 432(%rsp)
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	32(%rsp), %rsi
	movq	40(%rsp), %rdi
	xorq	48(%rsp), %rax
	xorq	56(%rsp), %rcx
	xorq	64(%rsp), %rdx
	xorq	72(%rsp), %rsi
	xorq	80(%rsp), %rdi
	xorq	88(%rsp), %rax
	xorq	96(%rsp), %rcx
	xorq	104(%rsp), %rdx
	xorq	112(%rsp), %rsi
	xorq	120(%rsp), %rdi
	xorq	128(%rsp), %rax
	xorq	136(%rsp), %rcx
	xorq	144(%rsp), %rdx
	xorq	152(%rsp), %rsi
	xorq	160(%rsp), %rdi
	xorq	168(%rsp), %rax
	xorq	176(%rsp), %rcx
	xorq	184(%rsp), %rdx
	xorq	192(%rsp), %rsi
	xorq	200(%rsp), %rdi
	movq	%rcx, %r8
	rolq	$1, %r8
	xorq	%rdi, %r8
	movq	%rdx, %r10
	rolq	$1, %r10
	xorq	%rax, %r10
	movq	%rsi, %r11
	rolq	$1, %r11
	xorq	%rcx, %r11
	movq	%rdi, %rcx
	rolq	$1, %rcx
	xorq	%rdx, %rcx
	rolq	$1, %rax
	xorq	%rsi, %rax
	movq	8(%rsp), %rdx
	xorq	%r8, %rdx
	movq	56(%rsp), %rsi
	xorq	%r10, %rsi
	rolq	$44, %rsi
	movq	104(%rsp), %rdi
	xorq	%r11, %rdi
	rolq	$43, %rdi
	movq	152(%rsp), %rbp
	xorq	%rcx, %rbp
	rolq	$21, %rbp
	movq	200(%rsp), %rbx
	xorq	%rax, %rbx
	rolq	$14, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	432(%rsp), %r12
	xorq	%rdx, %r12
	movq	%r12, 232(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 240(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 248(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 256(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 264(%rsp)
	movq	32(%rsp), %rdx
	xorq	%rcx, %rdx
	rolq	$28, %rdx
	movq	80(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$20, %rsi
	movq	88(%rsp), %rdi
	xorq	%r8, %rdi
	rolq	$3, %rdi
	movq	136(%rsp), %rbp
	xorq	%r10, %rbp
	rolq	$45, %rbp
	movq	184(%rsp), %rbx
	xorq	%r11, %rbx
	rolq	$61, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 272(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 280(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 288(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 296(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 304(%rsp)
	movq	16(%rsp), %rdx
	xorq	%r10, %rdx
	rolq	$1, %rdx
	movq	64(%rsp), %rsi
	xorq	%r11, %rsi
	rolq	$6, %rsi
	movq	112(%rsp), %rdi
	xorq	%rcx, %rdi
	rolq	$25, %rdi
	movq	160(%rsp), %rbp
	xorq	%rax, %rbp
	rolq	$8, %rbp
	movq	168(%rsp), %rbx
	xorq	%r8, %rbx
	rolq	$18, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 312(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 320(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 328(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 336(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 344(%rsp)
	movq	40(%rsp), %rdx
	xorq	%rax, %rdx
	rolq	$27, %rdx
	movq	48(%rsp), %rsi
	xorq	%r8, %rsi
	rolq	$36, %rsi
	movq	96(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$10, %rdi
	movq	144(%rsp), %rbp
	xorq	%r11, %rbp
	rolq	$15, %rbp
	movq	192(%rsp), %rbx
	xorq	%rcx, %rbx
	rolq	$56, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 352(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 360(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 368(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 376(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 384(%rsp)
	movq	24(%rsp), %rdx
	xorq	%r11, %rdx
	rolq	$62, %rdx
	movq	72(%rsp), %rsi
	xorq	%rcx, %rsi
	rolq	$55, %rsi
	movq	%rsi, %rcx
	movq	120(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$39, %rsi
	movq	%rsi, %rax
	movq	128(%rsp), %rsi
	xorq	%r8, %rsi
	rolq	$41, %rsi
	movq	176(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$2, %rdi
	andnq	%rax, %rcx, %r8
	xorq	%rdx, %r8
	movq	%r8, 392(%rsp)
	andnq	%rsi, %rax, %r8
	xorq	%rcx, %r8
	movq	%r8, 400(%rsp)
	andnq	%rdi, %rsi, %r8
	xorq	%rax, %r8
	movq	%r8, 408(%rsp)
	andnq	%rdx, %rdi, %rax
	xorq	%rsi, %rax
	movq	%rax, 416(%rsp)
	andnq	%rcx, %rdx, %rax
	xorq	%rdi, %rax
	movq	%rax, 424(%rsp)
	movq	8(%r9), %rax
	movq	%rax, 432(%rsp)
	movq	232(%rsp), %rax
	movq	240(%rsp), %rcx
	movq	248(%rsp), %rdx
	movq	256(%rsp), %rsi
	movq	264(%rsp), %rdi
	xorq	272(%rsp), %rax
	xorq	280(%rsp), %rcx
	xorq	288(%rsp), %rdx
	xorq	296(%rsp), %rsi
	xorq	304(%rsp), %rdi
	xorq	312(%rsp), %rax
	xorq	320(%rsp), %rcx
	xorq	328(%rsp), %rdx
	xorq	336(%rsp), %rsi
	xorq	344(%rsp), %rdi
	xorq	352(%rsp), %rax
	xorq	360(%rsp), %rcx
	xorq	368(%rsp), %rdx
	xorq	376(%rsp), %rsi
	xorq	384(%rsp), %rdi
	xorq	392(%rsp), %rax
	xorq	400(%rsp), %rcx
	xorq	408(%rsp), %rdx
	xorq	416(%rsp), %rsi
	xorq	424(%rsp), %rdi
	movq	%rcx, %r8
	rolq	$1, %r8
	xorq	%rdi, %r8
	movq	%rdx, %r10
	rolq	$1, %r10
	xorq	%rax, %r10
	movq	%rsi, %r11
	rolq	$1, %r11
	xorq	%rcx, %r11
	movq	%rdi, %rcx
	rolq	$1, %rcx
	xorq	%rdx, %rcx
	rolq	$1, %rax
	xorq	%rsi, %rax
	movq	232(%rsp), %rdx
	xorq	%r8, %rdx
	movq	280(%rsp), %rsi
	xorq	%r10, %rsi
	rolq	$44, %rsi
	movq	328(%rsp), %rdi
	xorq	%r11, %rdi
	rolq	$43, %rdi
	movq	376(%rsp), %rbp
	xorq	%rcx, %rbp
	rolq	$21, %rbp
	movq	424(%rsp), %rbx
	xorq	%rax, %rbx
	rolq	$14, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	432(%rsp), %r12
	xorq	%rdx, %r12
	movq	%r12, 8(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 16(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 24(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 32(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 40(%rsp)
	movq	256(%rsp), %rdx
	xorq	%rcx, %rdx
	rolq	$28, %rdx
	movq	304(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$20, %rsi
	movq	312(%rsp), %rdi
	xorq	%r8, %rdi
	rolq	$3, %rdi
	movq	360(%rsp), %rbp
	xorq	%r10, %rbp
	rolq	$45, %rbp
	movq	408(%rsp), %rbx
	xorq	%r11, %rbx
	rolq	$61, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 48(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 56(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 64(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 72(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 80(%rsp)
	movq	240(%rsp), %rdx
	xorq	%r10, %rdx
	rolq	$1, %rdx
	movq	288(%rsp), %rsi
	xorq	%r11, %rsi
	rolq	$6, %rsi
	movq	336(%rsp), %rdi
	xorq	%rcx, %rdi
	rolq	$25, %rdi
	movq	384(%rsp), %rbp
	xorq	%rax, %rbp
	rolq	$8, %rbp
	movq	392(%rsp), %rbx
	xorq	%r8, %rbx
	rolq	$18, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 88(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 96(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 104(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 112(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 120(%rsp)
	movq	264(%rsp), %rdx
	xorq	%rax, %rdx
	rolq	$27, %rdx
	movq	272(%rsp), %rsi
	xorq	%r8, %rsi
	rolq	$36, %rsi
	movq	320(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$10, %rdi
	movq	368(%rsp), %rbp
	xorq	%r11, %rbp
	rolq	$15, %rbp
	movq	416(%rsp), %rbx
	xorq	%rcx, %rbx
	rolq	$56, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 128(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 136(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 144(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 152(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 160(%rsp)
	movq	248(%rsp), %rdx
	xorq	%r11, %rdx
	rolq	$62, %rdx
	movq	296(%rsp), %rsi
	xorq	%rcx, %rsi
	rolq	$55, %rsi
	movq	%rsi, %rcx
	movq	344(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$39, %rsi
	movq	%rsi, %rax
	movq	352(%rsp), %rsi
	xorq	%r8, %rsi
	rolq	$41, %rsi
	movq	400(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$2, %rdi
	andnq	%rax, %rcx, %r8
	xorq	%rdx, %r8
	movq	%r8, 168(%rsp)
	andnq	%rsi, %rax, %r8
	xorq	%rcx, %r8
	movq	%r8, 176(%rsp)
	andnq	%rdi, %rsi, %r8
	xorq	%rax, %r8
	movq	%r8, 184(%rsp)
	andnq	%rdx, %rdi, %rax
	xorq	%rsi, %rax
	movq	%rax, 192(%rsp)
	andnq	%rcx, %rdx, %rax
	xorq	%rdi, %rax
	movq	%rax, 200(%rsp)
	leaq	16(%r9), %r9
	testb	$-1, %r9b
	jne 	Lkeccak_1600$18
	leaq	-192(%r9), %r9
	movq	224(%rsp), %rdx
	movq	216(%rsp), %rax
	movq	208(%rsp), %rsi
Lkeccak_1600$16:
	cmpq	%rsi, %rax
	jnb 	Lkeccak_1600$17
	movq	%rax, %rcx
	shrq	$3, %rcx
	movq	$0, %rdi
	jmp 	Lkeccak_1600$14
Lkeccak_1600$15:
	movq	(%rdx,%rdi,8), %r8
	xorq	%r8, 8(%rsp,%rdi,8)
	leaq	1(%rdi), %rdi
Lkeccak_1600$14:
	cmpq	%rcx, %rdi
	jb  	Lkeccak_1600$15
	leaq	(%rdx,%rdi,8), %r11
	andq	$7, %rax
	movzbq	456(%rsp), %rdx
	movq	$0, %r10
	movq	$0, %rcx
	testb	$4, %al
	je  	Lkeccak_1600$13
	movl	(%r11), %r10d
	leaq	4(%r11), %r11
	movq	$32, %rcx
Lkeccak_1600$13:
	testb	$2, %al
	je  	Lkeccak_1600$12
	movzwq	(%r11), %r8
	leaq	2(%r11), %r11
	shlq	%cl, %r8
	leaq	16(%rcx), %rcx
	leaq	(%r10,%r8), %r10
Lkeccak_1600$12:
	testb	$1, %al
	je  	Lkeccak_1600$11
	movzbq	(%r11), %rax
	shlq	%cl, %rax
	leaq	8(%rcx), %rcx
	leaq	(%r10,%rax), %r10
Lkeccak_1600$11:
	shlq	%cl, %rdx
	leaq	(%r10,%rdx), %rax
	xorq	%rax, 8(%rsp,%rdi,8)
	leaq	-1(%rsi), %rax
	xorb	$-128, 8(%rsp,%rax)
	movq	440(%rsp), %rax
	movq	448(%rsp), %rcx
	jmp 	Lkeccak_1600$6
Lkeccak_1600$7:
	movq	%rcx, 448(%rsp)
	movq	%rax, 432(%rsp)
Lkeccak_1600$10:
	movq	(%r9), %rax
	movq	%rax, 440(%rsp)
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	32(%rsp), %rsi
	movq	40(%rsp), %rdi
	xorq	48(%rsp), %rax
	xorq	56(%rsp), %rcx
	xorq	64(%rsp), %rdx
	xorq	72(%rsp), %rsi
	xorq	80(%rsp), %rdi
	xorq	88(%rsp), %rax
	xorq	96(%rsp), %rcx
	xorq	104(%rsp), %rdx
	xorq	112(%rsp), %rsi
	xorq	120(%rsp), %rdi
	xorq	128(%rsp), %rax
	xorq	136(%rsp), %rcx
	xorq	144(%rsp), %rdx
	xorq	152(%rsp), %rsi
	xorq	160(%rsp), %rdi
	xorq	168(%rsp), %rax
	xorq	176(%rsp), %rcx
	xorq	184(%rsp), %rdx
	xorq	192(%rsp), %rsi
	xorq	200(%rsp), %rdi
	movq	%rcx, %r8
	rolq	$1, %r8
	xorq	%rdi, %r8
	movq	%rdx, %r10
	rolq	$1, %r10
	xorq	%rax, %r10
	movq	%rsi, %r11
	rolq	$1, %r11
	xorq	%rcx, %r11
	movq	%rdi, %rcx
	rolq	$1, %rcx
	xorq	%rdx, %rcx
	rolq	$1, %rax
	xorq	%rsi, %rax
	movq	8(%rsp), %rdx
	xorq	%r8, %rdx
	movq	56(%rsp), %rsi
	xorq	%r10, %rsi
	rolq	$44, %rsi
	movq	104(%rsp), %rdi
	xorq	%r11, %rdi
	rolq	$43, %rdi
	movq	152(%rsp), %rbp
	xorq	%rcx, %rbp
	rolq	$21, %rbp
	movq	200(%rsp), %rbx
	xorq	%rax, %rbx
	rolq	$14, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	440(%rsp), %r12
	xorq	%rdx, %r12
	movq	%r12, 232(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 240(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 248(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 256(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 264(%rsp)
	movq	32(%rsp), %rdx
	xorq	%rcx, %rdx
	rolq	$28, %rdx
	movq	80(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$20, %rsi
	movq	88(%rsp), %rdi
	xorq	%r8, %rdi
	rolq	$3, %rdi
	movq	136(%rsp), %rbp
	xorq	%r10, %rbp
	rolq	$45, %rbp
	movq	184(%rsp), %rbx
	xorq	%r11, %rbx
	rolq	$61, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 272(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 280(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 288(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 296(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 304(%rsp)
	movq	16(%rsp), %rdx
	xorq	%r10, %rdx
	rolq	$1, %rdx
	movq	64(%rsp), %rsi
	xorq	%r11, %rsi
	rolq	$6, %rsi
	movq	112(%rsp), %rdi
	xorq	%rcx, %rdi
	rolq	$25, %rdi
	movq	160(%rsp), %rbp
	xorq	%rax, %rbp
	rolq	$8, %rbp
	movq	168(%rsp), %rbx
	xorq	%r8, %rbx
	rolq	$18, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 312(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 320(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 328(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 336(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 344(%rsp)
	movq	40(%rsp), %rdx
	xorq	%rax, %rdx
	rolq	$27, %rdx
	movq	48(%rsp), %rsi
	xorq	%r8, %rsi
	rolq	$36, %rsi
	movq	96(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$10, %rdi
	movq	144(%rsp), %rbp
	xorq	%r11, %rbp
	rolq	$15, %rbp
	movq	192(%rsp), %rbx
	xorq	%rcx, %rbx
	rolq	$56, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 352(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 360(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 368(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 376(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 384(%rsp)
	movq	24(%rsp), %rdx
	xorq	%r11, %rdx
	rolq	$62, %rdx
	movq	72(%rsp), %rsi
	xorq	%rcx, %rsi
	rolq	$55, %rsi
	movq	%rsi, %rcx
	movq	120(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$39, %rsi
	movq	%rsi, %rax
	movq	128(%rsp), %rsi
	xorq	%r8, %rsi
	rolq	$41, %rsi
	movq	176(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$2, %rdi
	andnq	%rax, %rcx, %r8
	xorq	%rdx, %r8
	movq	%r8, 392(%rsp)
	andnq	%rsi, %rax, %r8
	xorq	%rcx, %r8
	movq	%r8, 400(%rsp)
	andnq	%rdi, %rsi, %r8
	xorq	%rax, %r8
	movq	%r8, 408(%rsp)
	andnq	%rdx, %rdi, %rax
	xorq	%rsi, %rax
	movq	%rax, 416(%rsp)
	andnq	%rcx, %rdx, %rax
	xorq	%rdi, %rax
	movq	%rax, 424(%rsp)
	movq	8(%r9), %rax
	movq	%rax, 440(%rsp)
	movq	232(%rsp), %rax
	movq	240(%rsp), %rcx
	movq	248(%rsp), %rdx
	movq	256(%rsp), %rsi
	movq	264(%rsp), %rdi
	xorq	272(%rsp), %rax
	xorq	280(%rsp), %rcx
	xorq	288(%rsp), %rdx
	xorq	296(%rsp), %rsi
	xorq	304(%rsp), %rdi
	xorq	312(%rsp), %rax
	xorq	320(%rsp), %rcx
	xorq	328(%rsp), %rdx
	xorq	336(%rsp), %rsi
	xorq	344(%rsp), %rdi
	xorq	352(%rsp), %rax
	xorq	360(%rsp), %rcx
	xorq	368(%rsp), %rdx
	xorq	376(%rsp), %rsi
	xorq	384(%rsp), %rdi
	xorq	392(%rsp), %rax
	xorq	400(%rsp), %rcx
	xorq	408(%rsp), %rdx
	xorq	416(%rsp), %rsi
	xorq	424(%rsp), %rdi
	movq	%rcx, %r8
	rolq	$1, %r8
	xorq	%rdi, %r8
	movq	%rdx, %r10
	rolq	$1, %r10
	xorq	%rax, %r10
	movq	%rsi, %r11
	rolq	$1, %r11
	xorq	%rcx, %r11
	movq	%rdi, %rcx
	rolq	$1, %rcx
	xorq	%rdx, %rcx
	rolq	$1, %rax
	xorq	%rsi, %rax
	movq	232(%rsp), %rdx
	xorq	%r8, %rdx
	movq	280(%rsp), %rsi
	xorq	%r10, %rsi
	rolq	$44, %rsi
	movq	328(%rsp), %rdi
	xorq	%r11, %rdi
	rolq	$43, %rdi
	movq	376(%rsp), %rbp
	xorq	%rcx, %rbp
	rolq	$21, %rbp
	movq	424(%rsp), %rbx
	xorq	%rax, %rbx
	rolq	$14, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	440(%rsp), %r12
	xorq	%rdx, %r12
	movq	%r12, 8(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 16(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 24(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 32(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 40(%rsp)
	movq	256(%rsp), %rdx
	xorq	%rcx, %rdx
	rolq	$28, %rdx
	movq	304(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$20, %rsi
	movq	312(%rsp), %rdi
	xorq	%r8, %rdi
	rolq	$3, %rdi
	movq	360(%rsp), %rbp
	xorq	%r10, %rbp
	rolq	$45, %rbp
	movq	408(%rsp), %rbx
	xorq	%r11, %rbx
	rolq	$61, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 48(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 56(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 64(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 72(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 80(%rsp)
	movq	240(%rsp), %rdx
	xorq	%r10, %rdx
	rolq	$1, %rdx
	movq	288(%rsp), %rsi
	xorq	%r11, %rsi
	rolq	$6, %rsi
	movq	336(%rsp), %rdi
	xorq	%rcx, %rdi
	rolq	$25, %rdi
	movq	384(%rsp), %rbp
	xorq	%rax, %rbp
	rolq	$8, %rbp
	movq	392(%rsp), %rbx
	xorq	%r8, %rbx
	rolq	$18, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 88(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 96(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 104(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 112(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 120(%rsp)
	movq	264(%rsp), %rdx
	xorq	%rax, %rdx
	rolq	$27, %rdx
	movq	272(%rsp), %rsi
	xorq	%r8, %rsi
	rolq	$36, %rsi
	movq	320(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$10, %rdi
	movq	368(%rsp), %rbp
	xorq	%r11, %rbp
	rolq	$15, %rbp
	movq	416(%rsp), %rbx
	xorq	%rcx, %rbx
	rolq	$56, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 128(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 136(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 144(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 152(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 160(%rsp)
	movq	248(%rsp), %rdx
	xorq	%r11, %rdx
	rolq	$62, %rdx
	movq	296(%rsp), %rsi
	xorq	%rcx, %rsi
	rolq	$55, %rsi
	movq	%rsi, %rcx
	movq	344(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$39, %rsi
	movq	%rsi, %rax
	movq	352(%rsp), %rsi
	xorq	%r8, %rsi
	rolq	$41, %rsi
	movq	400(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$2, %rdi
	andnq	%rax, %rcx, %r8
	xorq	%rdx, %r8
	movq	%r8, 168(%rsp)
	andnq	%rsi, %rax, %r8
	xorq	%rcx, %r8
	movq	%r8, 176(%rsp)
	andnq	%rdi, %rsi, %r8
	xorq	%rax, %r8
	movq	%r8, 184(%rsp)
	andnq	%rdx, %rdi, %rax
	xorq	%rsi, %rax
	movq	%rax, 192(%rsp)
	andnq	%rcx, %rdx, %rax
	xorq	%rdi, %rax
	movq	%rax, 200(%rsp)
	leaq	16(%r9), %r9
	testb	$-1, %r9b
	jne 	Lkeccak_1600$10
	leaq	-192(%r9), %r9
	movq	(%rsp), %rcx
	movq	432(%rsp), %rax
	movq	%rax, %rdx
	shrq	$3, %rdx
	movq	$0, %rsi
	jmp 	Lkeccak_1600$8
Lkeccak_1600$9:
	movq	8(%rsp,%rsi,8), %rdi
	movq	%rdi, (%rcx,%rsi,8)
	leaq	1(%rsi), %rsi
Lkeccak_1600$8:
	cmpq	%rdx, %rsi
	jb  	Lkeccak_1600$9
	leaq	(%rcx,%rax), %rcx
	movq	%rcx, (%rsp)
	movq	448(%rsp), %rcx
	subq	%rax, %rcx
Lkeccak_1600$6:
	cmpq	%rax, %rcx
	jnbe	Lkeccak_1600$7
	movq	%rcx, 440(%rsp)
Lkeccak_1600$5:
	movq	(%r9), %rax
	movq	%rax, 448(%rsp)
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	32(%rsp), %rsi
	movq	40(%rsp), %rdi
	xorq	48(%rsp), %rax
	xorq	56(%rsp), %rcx
	xorq	64(%rsp), %rdx
	xorq	72(%rsp), %rsi
	xorq	80(%rsp), %rdi
	xorq	88(%rsp), %rax
	xorq	96(%rsp), %rcx
	xorq	104(%rsp), %rdx
	xorq	112(%rsp), %rsi
	xorq	120(%rsp), %rdi
	xorq	128(%rsp), %rax
	xorq	136(%rsp), %rcx
	xorq	144(%rsp), %rdx
	xorq	152(%rsp), %rsi
	xorq	160(%rsp), %rdi
	xorq	168(%rsp), %rax
	xorq	176(%rsp), %rcx
	xorq	184(%rsp), %rdx
	xorq	192(%rsp), %rsi
	xorq	200(%rsp), %rdi
	movq	%rcx, %r8
	rolq	$1, %r8
	xorq	%rdi, %r8
	movq	%rdx, %r10
	rolq	$1, %r10
	xorq	%rax, %r10
	movq	%rsi, %r11
	rolq	$1, %r11
	xorq	%rcx, %r11
	movq	%rdi, %rcx
	rolq	$1, %rcx
	xorq	%rdx, %rcx
	rolq	$1, %rax
	xorq	%rsi, %rax
	movq	8(%rsp), %rdx
	xorq	%r8, %rdx
	movq	56(%rsp), %rsi
	xorq	%r10, %rsi
	rolq	$44, %rsi
	movq	104(%rsp), %rdi
	xorq	%r11, %rdi
	rolq	$43, %rdi
	movq	152(%rsp), %rbp
	xorq	%rcx, %rbp
	rolq	$21, %rbp
	movq	200(%rsp), %rbx
	xorq	%rax, %rbx
	rolq	$14, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	448(%rsp), %r12
	xorq	%rdx, %r12
	movq	%r12, 232(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 240(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 248(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 256(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 264(%rsp)
	movq	32(%rsp), %rdx
	xorq	%rcx, %rdx
	rolq	$28, %rdx
	movq	80(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$20, %rsi
	movq	88(%rsp), %rdi
	xorq	%r8, %rdi
	rolq	$3, %rdi
	movq	136(%rsp), %rbp
	xorq	%r10, %rbp
	rolq	$45, %rbp
	movq	184(%rsp), %rbx
	xorq	%r11, %rbx
	rolq	$61, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 272(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 280(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 288(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 296(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 304(%rsp)
	movq	16(%rsp), %rdx
	xorq	%r10, %rdx
	rolq	$1, %rdx
	movq	64(%rsp), %rsi
	xorq	%r11, %rsi
	rolq	$6, %rsi
	movq	112(%rsp), %rdi
	xorq	%rcx, %rdi
	rolq	$25, %rdi
	movq	160(%rsp), %rbp
	xorq	%rax, %rbp
	rolq	$8, %rbp
	movq	168(%rsp), %rbx
	xorq	%r8, %rbx
	rolq	$18, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 312(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 320(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 328(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 336(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 344(%rsp)
	movq	40(%rsp), %rdx
	xorq	%rax, %rdx
	rolq	$27, %rdx
	movq	48(%rsp), %rsi
	xorq	%r8, %rsi
	rolq	$36, %rsi
	movq	96(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$10, %rdi
	movq	144(%rsp), %rbp
	xorq	%r11, %rbp
	rolq	$15, %rbp
	movq	192(%rsp), %rbx
	xorq	%rcx, %rbx
	rolq	$56, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 352(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 360(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 368(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 376(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 384(%rsp)
	movq	24(%rsp), %rdx
	xorq	%r11, %rdx
	rolq	$62, %rdx
	movq	72(%rsp), %rsi
	xorq	%rcx, %rsi
	rolq	$55, %rsi
	movq	%rsi, %rcx
	movq	120(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$39, %rsi
	movq	%rsi, %rax
	movq	128(%rsp), %rsi
	xorq	%r8, %rsi
	rolq	$41, %rsi
	movq	176(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$2, %rdi
	andnq	%rax, %rcx, %r8
	xorq	%rdx, %r8
	movq	%r8, 392(%rsp)
	andnq	%rsi, %rax, %r8
	xorq	%rcx, %r8
	movq	%r8, 400(%rsp)
	andnq	%rdi, %rsi, %r8
	xorq	%rax, %r8
	movq	%r8, 408(%rsp)
	andnq	%rdx, %rdi, %rax
	xorq	%rsi, %rax
	movq	%rax, 416(%rsp)
	andnq	%rcx, %rdx, %rax
	xorq	%rdi, %rax
	movq	%rax, 424(%rsp)
	movq	8(%r9), %rax
	movq	%rax, 448(%rsp)
	movq	232(%rsp), %rax
	movq	240(%rsp), %rcx
	movq	248(%rsp), %rdx
	movq	256(%rsp), %rsi
	movq	264(%rsp), %rdi
	xorq	272(%rsp), %rax
	xorq	280(%rsp), %rcx
	xorq	288(%rsp), %rdx
	xorq	296(%rsp), %rsi
	xorq	304(%rsp), %rdi
	xorq	312(%rsp), %rax
	xorq	320(%rsp), %rcx
	xorq	328(%rsp), %rdx
	xorq	336(%rsp), %rsi
	xorq	344(%rsp), %rdi
	xorq	352(%rsp), %rax
	xorq	360(%rsp), %rcx
	xorq	368(%rsp), %rdx
	xorq	376(%rsp), %rsi
	xorq	384(%rsp), %rdi
	xorq	392(%rsp), %rax
	xorq	400(%rsp), %rcx
	xorq	408(%rsp), %rdx
	xorq	416(%rsp), %rsi
	xorq	424(%rsp), %rdi
	movq	%rcx, %r8
	rolq	$1, %r8
	xorq	%rdi, %r8
	movq	%rdx, %r10
	rolq	$1, %r10
	xorq	%rax, %r10
	movq	%rsi, %r11
	rolq	$1, %r11
	xorq	%rcx, %r11
	movq	%rdi, %rcx
	rolq	$1, %rcx
	xorq	%rdx, %rcx
	rolq	$1, %rax
	xorq	%rsi, %rax
	movq	232(%rsp), %rdx
	xorq	%r8, %rdx
	movq	280(%rsp), %rsi
	xorq	%r10, %rsi
	rolq	$44, %rsi
	movq	328(%rsp), %rdi
	xorq	%r11, %rdi
	rolq	$43, %rdi
	movq	376(%rsp), %rbp
	xorq	%rcx, %rbp
	rolq	$21, %rbp
	movq	424(%rsp), %rbx
	xorq	%rax, %rbx
	rolq	$14, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	448(%rsp), %r12
	xorq	%rdx, %r12
	movq	%r12, 8(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 16(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 24(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 32(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 40(%rsp)
	movq	256(%rsp), %rdx
	xorq	%rcx, %rdx
	rolq	$28, %rdx
	movq	304(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$20, %rsi
	movq	312(%rsp), %rdi
	xorq	%r8, %rdi
	rolq	$3, %rdi
	movq	360(%rsp), %rbp
	xorq	%r10, %rbp
	rolq	$45, %rbp
	movq	408(%rsp), %rbx
	xorq	%r11, %rbx
	rolq	$61, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 48(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 56(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 64(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 72(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 80(%rsp)
	movq	240(%rsp), %rdx
	xorq	%r10, %rdx
	rolq	$1, %rdx
	movq	288(%rsp), %rsi
	xorq	%r11, %rsi
	rolq	$6, %rsi
	movq	336(%rsp), %rdi
	xorq	%rcx, %rdi
	rolq	$25, %rdi
	movq	384(%rsp), %rbp
	xorq	%rax, %rbp
	rolq	$8, %rbp
	movq	392(%rsp), %rbx
	xorq	%r8, %rbx
	rolq	$18, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 88(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 96(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 104(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 112(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 120(%rsp)
	movq	264(%rsp), %rdx
	xorq	%rax, %rdx
	rolq	$27, %rdx
	movq	272(%rsp), %rsi
	xorq	%r8, %rsi
	rolq	$36, %rsi
	movq	320(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$10, %rdi
	movq	368(%rsp), %rbp
	xorq	%r11, %rbp
	rolq	$15, %rbp
	movq	416(%rsp), %rbx
	xorq	%rcx, %rbx
	rolq	$56, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 128(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 136(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 144(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 152(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 160(%rsp)
	movq	248(%rsp), %rdx
	xorq	%r11, %rdx
	rolq	$62, %rdx
	movq	296(%rsp), %rsi
	xorq	%rcx, %rsi
	rolq	$55, %rsi
	movq	%rsi, %rcx
	movq	344(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$39, %rsi
	movq	%rsi, %rax
	movq	352(%rsp), %rsi
	xorq	%r8, %rsi
	rolq	$41, %rsi
	movq	400(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$2, %rdi
	andnq	%rax, %rcx, %r8
	xorq	%rdx, %r8
	movq	%r8, 168(%rsp)
	andnq	%rsi, %rax, %r8
	xorq	%rcx, %r8
	movq	%r8, 176(%rsp)
	andnq	%rdi, %rsi, %r8
	xorq	%rax, %r8
	movq	%r8, 184(%rsp)
	andnq	%rdx, %rdi, %rax
	xorq	%rsi, %rax
	movq	%rax, 192(%rsp)
	andnq	%rcx, %rdx, %rax
	xorq	%rdi, %rax
	movq	%rax, 200(%rsp)
	leaq	16(%r9), %r9
	testb	$-1, %r9b
	jne 	Lkeccak_1600$5
	movq	(%rsp), %rax
	movq	440(%rsp), %rcx
	movq	%rcx, %rdx
	shrq	$3, %rdx
	movq	$0, %rsi
	jmp 	Lkeccak_1600$3
Lkeccak_1600$4:
	movq	8(%rsp,%rsi,8), %rdi
	movq	%rdi, (%rax,%rsi,8)
	leaq	1(%rsi), %rsi
Lkeccak_1600$3:
	cmpq	%rdx, %rsi
	jb  	Lkeccak_1600$4
	shlq	$3, %rsi
	jmp 	Lkeccak_1600$1
Lkeccak_1600$2:
	movb	8(%rsp,%rsi), %dl
	movb	%dl, (%rax,%rsi)
	leaq	1(%rsi), %rsi
Lkeccak_1600$1:
	cmpq	%rcx, %rsi
	jb  	Lkeccak_1600$2
	addq	$464, %rsp
	popq	%r12
	popq	%rbx
	popq	%rbp
	ret 

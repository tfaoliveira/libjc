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
	subq	$457, %rsp
	movq	%rdi, 400(%rsp)
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
	movq	%rcx, 200(%rsp,%rdi,8)
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
	xorq	%r8, 200(%rsp,%rcx,8)
	leaq	1(%rcx), %rcx
Lkeccak_1600$19:
	cmpq	%rdi, %rcx
	jb  	Lkeccak_1600$20
	leaq	(%rdx,%rsi), %rcx
	subq	%rsi, %rax
	movq	%rcx, 424(%rsp)
	movq	%rax, 416(%rsp)
	movq	%rsi, 408(%rsp)
Lkeccak_1600$18:
	movq	(%r9), %rax
	movq	%rax, 432(%rsp)
	movq	200(%rsp), %rax
	movq	208(%rsp), %rcx
	movq	216(%rsp), %rdx
	movq	224(%rsp), %rsi
	movq	232(%rsp), %rdi
	xorq	240(%rsp), %rax
	xorq	248(%rsp), %rcx
	xorq	256(%rsp), %rdx
	xorq	264(%rsp), %rsi
	xorq	272(%rsp), %rdi
	xorq	280(%rsp), %rax
	xorq	288(%rsp), %rcx
	xorq	296(%rsp), %rdx
	xorq	304(%rsp), %rsi
	xorq	312(%rsp), %rdi
	xorq	320(%rsp), %rax
	xorq	328(%rsp), %rcx
	xorq	336(%rsp), %rdx
	xorq	344(%rsp), %rsi
	xorq	352(%rsp), %rdi
	xorq	360(%rsp), %rax
	xorq	368(%rsp), %rcx
	xorq	376(%rsp), %rdx
	xorq	384(%rsp), %rsi
	xorq	392(%rsp), %rdi
	movq	%rcx, %r8
	rolq	$1, %r8
	xorq	%rdi, %r8
	movq	%rdx, %r11
	rolq	$1, %r11
	xorq	%rax, %r11
	movq	%rsi, %rbp
	rolq	$1, %rbp
	xorq	%rcx, %rbp
	movq	%rdi, %rcx
	rolq	$1, %rcx
	xorq	%rdx, %rcx
	rolq	$1, %rax
	xorq	%rsi, %rax
	movq	200(%rsp), %rdx
	xorq	%r8, %rdx
	movq	248(%rsp), %rsi
	xorq	%r11, %rsi
	rolq	$44, %rsi
	movq	296(%rsp), %rdi
	xorq	%rbp, %rdi
	rolq	$43, %rdi
	movq	344(%rsp), %rbx
	xorq	%rcx, %rbx
	rolq	$21, %rbx
	movq	392(%rsp), %r12
	xorq	%rax, %r12
	rolq	$14, %r12
	andnq	%rdi, %rsi, %r13
	xorq	432(%rsp), %r13
	xorq	%rdx, %r13
	movq	%r13, (%rsp)
	andnq	%rbx, %rdi, %r13
	xorq	%rsi, %r13
	movq	%r13, 8(%rsp)
	andnq	%r12, %rbx, %r13
	xorq	%rdi, %r13
	movq	%r13, 16(%rsp)
	andnq	%rdx, %r12, %rdi
	xorq	%rbx, %rdi
	movq	%rdi, 24(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%r12, %rdx
	movq	%rdx, 32(%rsp)
	movq	224(%rsp), %rdx
	xorq	%rcx, %rdx
	rolq	$28, %rdx
	movq	272(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$20, %rsi
	movq	280(%rsp), %rdi
	xorq	%r8, %rdi
	rolq	$3, %rdi
	movq	328(%rsp), %rbx
	xorq	%r11, %rbx
	rolq	$45, %rbx
	movq	376(%rsp), %r12
	xorq	%rbp, %r12
	rolq	$61, %r12
	andnq	%rdi, %rsi, %r13
	xorq	%rdx, %r13
	movq	%r13, 40(%rsp)
	andnq	%rbx, %rdi, %r13
	xorq	%rsi, %r13
	movq	%r13, 48(%rsp)
	andnq	%r12, %rbx, %r13
	xorq	%rdi, %r13
	movq	%r13, 56(%rsp)
	andnq	%rdx, %r12, %rdi
	xorq	%rbx, %rdi
	movq	%rdi, 64(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%r12, %rdx
	movq	%rdx, 72(%rsp)
	movq	208(%rsp), %rdx
	xorq	%r11, %rdx
	rolq	$1, %rdx
	movq	256(%rsp), %rsi
	xorq	%rbp, %rsi
	rolq	$6, %rsi
	movq	304(%rsp), %rdi
	xorq	%rcx, %rdi
	rolq	$25, %rdi
	movq	352(%rsp), %rbx
	xorq	%rax, %rbx
	rolq	$8, %rbx
	movq	360(%rsp), %r12
	xorq	%r8, %r12
	rolq	$18, %r12
	andnq	%rdi, %rsi, %r13
	xorq	%rdx, %r13
	movq	%r13, 80(%rsp)
	andnq	%rbx, %rdi, %r13
	xorq	%rsi, %r13
	movq	%r13, 88(%rsp)
	andnq	%r12, %rbx, %r13
	xorq	%rdi, %r13
	movq	%r13, 96(%rsp)
	andnq	%rdx, %r12, %rdi
	xorq	%rbx, %rdi
	movq	%rdi, 104(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%r12, %rdx
	movq	%rdx, 112(%rsp)
	movq	232(%rsp), %rdx
	xorq	%rax, %rdx
	rolq	$27, %rdx
	movq	240(%rsp), %rsi
	xorq	%r8, %rsi
	rolq	$36, %rsi
	movq	288(%rsp), %rdi
	xorq	%r11, %rdi
	rolq	$10, %rdi
	movq	336(%rsp), %rbx
	xorq	%rbp, %rbx
	rolq	$15, %rbx
	movq	384(%rsp), %r12
	xorq	%rcx, %r12
	rolq	$56, %r12
	andnq	%rdi, %rsi, %r13
	xorq	%rdx, %r13
	movq	%r13, 120(%rsp)
	andnq	%rbx, %rdi, %r13
	xorq	%rsi, %r13
	movq	%r13, 128(%rsp)
	andnq	%r12, %rbx, %r13
	xorq	%rdi, %r13
	movq	%r13, 136(%rsp)
	andnq	%rdx, %r12, %rdi
	xorq	%rbx, %rdi
	movq	%rdi, 144(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%r12, %rdx
	movq	%rdx, 152(%rsp)
	movq	216(%rsp), %rdx
	xorq	%rbp, %rdx
	rolq	$62, %rdx
	movq	264(%rsp), %rsi
	xorq	%rcx, %rsi
	rolq	$55, %rsi
	movq	%rsi, %rcx
	movq	312(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$39, %rsi
	movq	%rsi, %rax
	movq	320(%rsp), %rsi
	xorq	%r8, %rsi
	rolq	$41, %rsi
	movq	368(%rsp), %rdi
	xorq	%r11, %rdi
	rolq	$2, %rdi
	andnq	%rax, %rcx, %r8
	xorq	%rdx, %r8
	movq	%r8, 160(%rsp)
	andnq	%rsi, %rax, %r8
	xorq	%rcx, %r8
	movq	%r8, 168(%rsp)
	andnq	%rdi, %rsi, %r8
	xorq	%rax, %r8
	movq	%r8, 176(%rsp)
	andnq	%rdx, %rdi, %rax
	xorq	%rsi, %rax
	movq	%rax, 184(%rsp)
	andnq	%rcx, %rdx, %rax
	xorq	%rdi, %rax
	movq	%rax, 192(%rsp)
	movq	8(%r9), %rax
	movq	%rax, 432(%rsp)
	movq	(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	16(%rsp), %rdx
	movq	24(%rsp), %rsi
	movq	32(%rsp), %rdi
	xorq	40(%rsp), %rax
	xorq	48(%rsp), %rcx
	xorq	56(%rsp), %rdx
	xorq	64(%rsp), %rsi
	xorq	72(%rsp), %rdi
	xorq	80(%rsp), %rax
	xorq	88(%rsp), %rcx
	xorq	96(%rsp), %rdx
	xorq	104(%rsp), %rsi
	xorq	112(%rsp), %rdi
	xorq	120(%rsp), %rax
	xorq	128(%rsp), %rcx
	xorq	136(%rsp), %rdx
	xorq	144(%rsp), %rsi
	xorq	152(%rsp), %rdi
	xorq	160(%rsp), %rax
	xorq	168(%rsp), %rcx
	xorq	176(%rsp), %rdx
	xorq	184(%rsp), %rsi
	xorq	192(%rsp), %rdi
	movq	%rcx, %r8
	rolq	$1, %r8
	xorq	%rdi, %r8
	movq	%rdx, %r11
	rolq	$1, %r11
	xorq	%rax, %r11
	movq	%rsi, %rbp
	rolq	$1, %rbp
	xorq	%rcx, %rbp
	movq	%rdi, %rcx
	rolq	$1, %rcx
	xorq	%rdx, %rcx
	rolq	$1, %rax
	xorq	%rsi, %rax
	movq	(%rsp), %rdx
	xorq	%r8, %rdx
	movq	48(%rsp), %rsi
	xorq	%r11, %rsi
	rolq	$44, %rsi
	movq	96(%rsp), %rdi
	xorq	%rbp, %rdi
	rolq	$43, %rdi
	movq	144(%rsp), %rbx
	xorq	%rcx, %rbx
	rolq	$21, %rbx
	movq	192(%rsp), %r12
	xorq	%rax, %r12
	rolq	$14, %r12
	andnq	%rdi, %rsi, %r13
	xorq	432(%rsp), %r13
	xorq	%rdx, %r13
	movq	%r13, 200(%rsp)
	andnq	%rbx, %rdi, %r13
	xorq	%rsi, %r13
	movq	%r13, 208(%rsp)
	andnq	%r12, %rbx, %r13
	xorq	%rdi, %r13
	movq	%r13, 216(%rsp)
	andnq	%rdx, %r12, %rdi
	xorq	%rbx, %rdi
	movq	%rdi, 224(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%r12, %rdx
	movq	%rdx, 232(%rsp)
	movq	24(%rsp), %rdx
	xorq	%rcx, %rdx
	rolq	$28, %rdx
	movq	72(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$20, %rsi
	movq	80(%rsp), %rdi
	xorq	%r8, %rdi
	rolq	$3, %rdi
	movq	128(%rsp), %rbx
	xorq	%r11, %rbx
	rolq	$45, %rbx
	movq	176(%rsp), %r12
	xorq	%rbp, %r12
	rolq	$61, %r12
	andnq	%rdi, %rsi, %r13
	xorq	%rdx, %r13
	movq	%r13, 240(%rsp)
	andnq	%rbx, %rdi, %r13
	xorq	%rsi, %r13
	movq	%r13, 248(%rsp)
	andnq	%r12, %rbx, %r13
	xorq	%rdi, %r13
	movq	%r13, 256(%rsp)
	andnq	%rdx, %r12, %rdi
	xorq	%rbx, %rdi
	movq	%rdi, 264(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%r12, %rdx
	movq	%rdx, 272(%rsp)
	movq	8(%rsp), %rdx
	xorq	%r11, %rdx
	rolq	$1, %rdx
	movq	56(%rsp), %rsi
	xorq	%rbp, %rsi
	rolq	$6, %rsi
	movq	104(%rsp), %rdi
	xorq	%rcx, %rdi
	rolq	$25, %rdi
	movq	152(%rsp), %rbx
	xorq	%rax, %rbx
	rolq	$8, %rbx
	movq	160(%rsp), %r12
	xorq	%r8, %r12
	rolq	$18, %r12
	andnq	%rdi, %rsi, %r13
	xorq	%rdx, %r13
	movq	%r13, 280(%rsp)
	andnq	%rbx, %rdi, %r13
	xorq	%rsi, %r13
	movq	%r13, 288(%rsp)
	andnq	%r12, %rbx, %r13
	xorq	%rdi, %r13
	movq	%r13, 296(%rsp)
	andnq	%rdx, %r12, %rdi
	xorq	%rbx, %rdi
	movq	%rdi, 304(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%r12, %rdx
	movq	%rdx, 312(%rsp)
	movq	32(%rsp), %rdx
	xorq	%rax, %rdx
	rolq	$27, %rdx
	movq	40(%rsp), %rsi
	xorq	%r8, %rsi
	rolq	$36, %rsi
	movq	88(%rsp), %rdi
	xorq	%r11, %rdi
	rolq	$10, %rdi
	movq	136(%rsp), %rbx
	xorq	%rbp, %rbx
	rolq	$15, %rbx
	movq	184(%rsp), %r12
	xorq	%rcx, %r12
	rolq	$56, %r12
	andnq	%rdi, %rsi, %r13
	xorq	%rdx, %r13
	movq	%r13, 320(%rsp)
	andnq	%rbx, %rdi, %r13
	xorq	%rsi, %r13
	movq	%r13, 328(%rsp)
	andnq	%r12, %rbx, %r13
	xorq	%rdi, %r13
	movq	%r13, 336(%rsp)
	andnq	%rdx, %r12, %rdi
	xorq	%rbx, %rdi
	movq	%rdi, 344(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%r12, %rdx
	movq	%rdx, 352(%rsp)
	movq	16(%rsp), %rdx
	xorq	%rbp, %rdx
	rolq	$62, %rdx
	movq	64(%rsp), %rsi
	xorq	%rcx, %rsi
	rolq	$55, %rsi
	movq	%rsi, %rcx
	movq	112(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$39, %rsi
	movq	%rsi, %rax
	movq	120(%rsp), %rsi
	xorq	%r8, %rsi
	rolq	$41, %rsi
	movq	168(%rsp), %rdi
	xorq	%r11, %rdi
	rolq	$2, %rdi
	andnq	%rax, %rcx, %r8
	xorq	%rdx, %r8
	movq	%r8, 360(%rsp)
	andnq	%rsi, %rax, %r8
	xorq	%rcx, %r8
	movq	%r8, 368(%rsp)
	andnq	%rdi, %rsi, %r8
	xorq	%rax, %r8
	movq	%r8, 376(%rsp)
	andnq	%rdx, %rdi, %rax
	xorq	%rsi, %rax
	movq	%rax, 384(%rsp)
	andnq	%rcx, %rdx, %rax
	xorq	%rdi, %rax
	movq	%rax, 392(%rsp)
	leaq	16(%r9), %r9
	testb	$-1, %r9b
	jne 	Lkeccak_1600$18
	leaq	-192(%r9), %r9
	movq	424(%rsp), %rdx
	movq	416(%rsp), %rax
	movq	408(%rsp), %rsi
Lkeccak_1600$16:
	cmpq	%rsi, %rax
	jnb 	Lkeccak_1600$17
	movq	%rax, %rcx
	shrq	$3, %rcx
	movq	$0, %rdi
	jmp 	Lkeccak_1600$14
Lkeccak_1600$15:
	movq	(%rdx,%rdi,8), %r8
	xorq	%r8, 200(%rsp,%rdi,8)
	leaq	1(%rdi), %rdi
Lkeccak_1600$14:
	cmpq	%rcx, %rdi
	jb  	Lkeccak_1600$15
	leaq	(%rdx,%rdi,8), %rbp
	andq	$7, %rax
	movzbq	456(%rsp), %rdx
	movq	$0, %r11
	movq	$0, %rcx
	testb	$4, %al
	je  	Lkeccak_1600$13
	movl	(%rbp), %r11d
	leaq	4(%rbp), %rbp
	movq	$32, %rcx
Lkeccak_1600$13:
	testb	$2, %al
	je  	Lkeccak_1600$12
	movzwq	(%rbp), %r8
	leaq	2(%rbp), %rbp
	shlq	%cl, %r8
	leaq	16(%rcx), %rcx
	leaq	(%r11,%r8), %r11
Lkeccak_1600$12:
	testb	$1, %al
	je  	Lkeccak_1600$11
	movzbq	(%rbp), %rax
	shlq	%cl, %rax
	leaq	8(%rcx), %rcx
	leaq	(%r11,%rax), %r11
Lkeccak_1600$11:
	shlq	%cl, %rdx
	leaq	(%r11,%rdx), %rax
	xorq	%rax, 200(%rsp,%rdi,8)
	leaq	-1(%rsi), %rax
	xorb	$-128, 200(%rsp,%rax)
	movq	440(%rsp), %rax
	movq	448(%rsp), %rcx
	jmp 	Lkeccak_1600$6
Lkeccak_1600$7:
	movq	%rcx, 448(%rsp)
	movq	%rax, 432(%rsp)
Lkeccak_1600$10:
	movq	(%r9), %rax
	movq	%rax, 440(%rsp)
	movq	200(%rsp), %rax
	movq	208(%rsp), %rcx
	movq	216(%rsp), %rdx
	movq	224(%rsp), %rsi
	movq	232(%rsp), %rdi
	xorq	240(%rsp), %rax
	xorq	248(%rsp), %rcx
	xorq	256(%rsp), %rdx
	xorq	264(%rsp), %rsi
	xorq	272(%rsp), %rdi
	xorq	280(%rsp), %rax
	xorq	288(%rsp), %rcx
	xorq	296(%rsp), %rdx
	xorq	304(%rsp), %rsi
	xorq	312(%rsp), %rdi
	xorq	320(%rsp), %rax
	xorq	328(%rsp), %rcx
	xorq	336(%rsp), %rdx
	xorq	344(%rsp), %rsi
	xorq	352(%rsp), %rdi
	xorq	360(%rsp), %rax
	xorq	368(%rsp), %rcx
	xorq	376(%rsp), %rdx
	xorq	384(%rsp), %rsi
	xorq	392(%rsp), %rdi
	movq	%rcx, %r8
	rolq	$1, %r8
	xorq	%rdi, %r8
	movq	%rdx, %r11
	rolq	$1, %r11
	xorq	%rax, %r11
	movq	%rsi, %rbp
	rolq	$1, %rbp
	xorq	%rcx, %rbp
	movq	%rdi, %rcx
	rolq	$1, %rcx
	xorq	%rdx, %rcx
	rolq	$1, %rax
	xorq	%rsi, %rax
	movq	200(%rsp), %rdx
	xorq	%r8, %rdx
	movq	248(%rsp), %rsi
	xorq	%r11, %rsi
	rolq	$44, %rsi
	movq	296(%rsp), %rdi
	xorq	%rbp, %rdi
	rolq	$43, %rdi
	movq	344(%rsp), %rbx
	xorq	%rcx, %rbx
	rolq	$21, %rbx
	movq	392(%rsp), %r12
	xorq	%rax, %r12
	rolq	$14, %r12
	andnq	%rdi, %rsi, %r13
	xorq	440(%rsp), %r13
	xorq	%rdx, %r13
	movq	%r13, (%rsp)
	andnq	%rbx, %rdi, %r13
	xorq	%rsi, %r13
	movq	%r13, 8(%rsp)
	andnq	%r12, %rbx, %r13
	xorq	%rdi, %r13
	movq	%r13, 16(%rsp)
	andnq	%rdx, %r12, %rdi
	xorq	%rbx, %rdi
	movq	%rdi, 24(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%r12, %rdx
	movq	%rdx, 32(%rsp)
	movq	224(%rsp), %rdx
	xorq	%rcx, %rdx
	rolq	$28, %rdx
	movq	272(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$20, %rsi
	movq	280(%rsp), %rdi
	xorq	%r8, %rdi
	rolq	$3, %rdi
	movq	328(%rsp), %rbx
	xorq	%r11, %rbx
	rolq	$45, %rbx
	movq	376(%rsp), %r12
	xorq	%rbp, %r12
	rolq	$61, %r12
	andnq	%rdi, %rsi, %r13
	xorq	%rdx, %r13
	movq	%r13, 40(%rsp)
	andnq	%rbx, %rdi, %r13
	xorq	%rsi, %r13
	movq	%r13, 48(%rsp)
	andnq	%r12, %rbx, %r13
	xorq	%rdi, %r13
	movq	%r13, 56(%rsp)
	andnq	%rdx, %r12, %rdi
	xorq	%rbx, %rdi
	movq	%rdi, 64(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%r12, %rdx
	movq	%rdx, 72(%rsp)
	movq	208(%rsp), %rdx
	xorq	%r11, %rdx
	rolq	$1, %rdx
	movq	256(%rsp), %rsi
	xorq	%rbp, %rsi
	rolq	$6, %rsi
	movq	304(%rsp), %rdi
	xorq	%rcx, %rdi
	rolq	$25, %rdi
	movq	352(%rsp), %rbx
	xorq	%rax, %rbx
	rolq	$8, %rbx
	movq	360(%rsp), %r12
	xorq	%r8, %r12
	rolq	$18, %r12
	andnq	%rdi, %rsi, %r13
	xorq	%rdx, %r13
	movq	%r13, 80(%rsp)
	andnq	%rbx, %rdi, %r13
	xorq	%rsi, %r13
	movq	%r13, 88(%rsp)
	andnq	%r12, %rbx, %r13
	xorq	%rdi, %r13
	movq	%r13, 96(%rsp)
	andnq	%rdx, %r12, %rdi
	xorq	%rbx, %rdi
	movq	%rdi, 104(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%r12, %rdx
	movq	%rdx, 112(%rsp)
	movq	232(%rsp), %rdx
	xorq	%rax, %rdx
	rolq	$27, %rdx
	movq	240(%rsp), %rsi
	xorq	%r8, %rsi
	rolq	$36, %rsi
	movq	288(%rsp), %rdi
	xorq	%r11, %rdi
	rolq	$10, %rdi
	movq	336(%rsp), %rbx
	xorq	%rbp, %rbx
	rolq	$15, %rbx
	movq	384(%rsp), %r12
	xorq	%rcx, %r12
	rolq	$56, %r12
	andnq	%rdi, %rsi, %r13
	xorq	%rdx, %r13
	movq	%r13, 120(%rsp)
	andnq	%rbx, %rdi, %r13
	xorq	%rsi, %r13
	movq	%r13, 128(%rsp)
	andnq	%r12, %rbx, %r13
	xorq	%rdi, %r13
	movq	%r13, 136(%rsp)
	andnq	%rdx, %r12, %rdi
	xorq	%rbx, %rdi
	movq	%rdi, 144(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%r12, %rdx
	movq	%rdx, 152(%rsp)
	movq	216(%rsp), %rdx
	xorq	%rbp, %rdx
	rolq	$62, %rdx
	movq	264(%rsp), %rsi
	xorq	%rcx, %rsi
	rolq	$55, %rsi
	movq	%rsi, %rcx
	movq	312(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$39, %rsi
	movq	%rsi, %rax
	movq	320(%rsp), %rsi
	xorq	%r8, %rsi
	rolq	$41, %rsi
	movq	368(%rsp), %rdi
	xorq	%r11, %rdi
	rolq	$2, %rdi
	andnq	%rax, %rcx, %r8
	xorq	%rdx, %r8
	movq	%r8, 160(%rsp)
	andnq	%rsi, %rax, %r8
	xorq	%rcx, %r8
	movq	%r8, 168(%rsp)
	andnq	%rdi, %rsi, %r8
	xorq	%rax, %r8
	movq	%r8, 176(%rsp)
	andnq	%rdx, %rdi, %rax
	xorq	%rsi, %rax
	movq	%rax, 184(%rsp)
	andnq	%rcx, %rdx, %rax
	xorq	%rdi, %rax
	movq	%rax, 192(%rsp)
	movq	8(%r9), %rax
	movq	%rax, 440(%rsp)
	movq	(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	16(%rsp), %rdx
	movq	24(%rsp), %rsi
	movq	32(%rsp), %rdi
	xorq	40(%rsp), %rax
	xorq	48(%rsp), %rcx
	xorq	56(%rsp), %rdx
	xorq	64(%rsp), %rsi
	xorq	72(%rsp), %rdi
	xorq	80(%rsp), %rax
	xorq	88(%rsp), %rcx
	xorq	96(%rsp), %rdx
	xorq	104(%rsp), %rsi
	xorq	112(%rsp), %rdi
	xorq	120(%rsp), %rax
	xorq	128(%rsp), %rcx
	xorq	136(%rsp), %rdx
	xorq	144(%rsp), %rsi
	xorq	152(%rsp), %rdi
	xorq	160(%rsp), %rax
	xorq	168(%rsp), %rcx
	xorq	176(%rsp), %rdx
	xorq	184(%rsp), %rsi
	xorq	192(%rsp), %rdi
	movq	%rcx, %r8
	rolq	$1, %r8
	xorq	%rdi, %r8
	movq	%rdx, %r11
	rolq	$1, %r11
	xorq	%rax, %r11
	movq	%rsi, %rbp
	rolq	$1, %rbp
	xorq	%rcx, %rbp
	movq	%rdi, %rcx
	rolq	$1, %rcx
	xorq	%rdx, %rcx
	rolq	$1, %rax
	xorq	%rsi, %rax
	movq	(%rsp), %rdx
	xorq	%r8, %rdx
	movq	48(%rsp), %rsi
	xorq	%r11, %rsi
	rolq	$44, %rsi
	movq	96(%rsp), %rdi
	xorq	%rbp, %rdi
	rolq	$43, %rdi
	movq	144(%rsp), %rbx
	xorq	%rcx, %rbx
	rolq	$21, %rbx
	movq	192(%rsp), %r12
	xorq	%rax, %r12
	rolq	$14, %r12
	andnq	%rdi, %rsi, %r13
	xorq	440(%rsp), %r13
	xorq	%rdx, %r13
	movq	%r13, 200(%rsp)
	andnq	%rbx, %rdi, %r13
	xorq	%rsi, %r13
	movq	%r13, 208(%rsp)
	andnq	%r12, %rbx, %r13
	xorq	%rdi, %r13
	movq	%r13, 216(%rsp)
	andnq	%rdx, %r12, %rdi
	xorq	%rbx, %rdi
	movq	%rdi, 224(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%r12, %rdx
	movq	%rdx, 232(%rsp)
	movq	24(%rsp), %rdx
	xorq	%rcx, %rdx
	rolq	$28, %rdx
	movq	72(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$20, %rsi
	movq	80(%rsp), %rdi
	xorq	%r8, %rdi
	rolq	$3, %rdi
	movq	128(%rsp), %rbx
	xorq	%r11, %rbx
	rolq	$45, %rbx
	movq	176(%rsp), %r12
	xorq	%rbp, %r12
	rolq	$61, %r12
	andnq	%rdi, %rsi, %r13
	xorq	%rdx, %r13
	movq	%r13, 240(%rsp)
	andnq	%rbx, %rdi, %r13
	xorq	%rsi, %r13
	movq	%r13, 248(%rsp)
	andnq	%r12, %rbx, %r13
	xorq	%rdi, %r13
	movq	%r13, 256(%rsp)
	andnq	%rdx, %r12, %rdi
	xorq	%rbx, %rdi
	movq	%rdi, 264(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%r12, %rdx
	movq	%rdx, 272(%rsp)
	movq	8(%rsp), %rdx
	xorq	%r11, %rdx
	rolq	$1, %rdx
	movq	56(%rsp), %rsi
	xorq	%rbp, %rsi
	rolq	$6, %rsi
	movq	104(%rsp), %rdi
	xorq	%rcx, %rdi
	rolq	$25, %rdi
	movq	152(%rsp), %rbx
	xorq	%rax, %rbx
	rolq	$8, %rbx
	movq	160(%rsp), %r12
	xorq	%r8, %r12
	rolq	$18, %r12
	andnq	%rdi, %rsi, %r13
	xorq	%rdx, %r13
	movq	%r13, 280(%rsp)
	andnq	%rbx, %rdi, %r13
	xorq	%rsi, %r13
	movq	%r13, 288(%rsp)
	andnq	%r12, %rbx, %r13
	xorq	%rdi, %r13
	movq	%r13, 296(%rsp)
	andnq	%rdx, %r12, %rdi
	xorq	%rbx, %rdi
	movq	%rdi, 304(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%r12, %rdx
	movq	%rdx, 312(%rsp)
	movq	32(%rsp), %rdx
	xorq	%rax, %rdx
	rolq	$27, %rdx
	movq	40(%rsp), %rsi
	xorq	%r8, %rsi
	rolq	$36, %rsi
	movq	88(%rsp), %rdi
	xorq	%r11, %rdi
	rolq	$10, %rdi
	movq	136(%rsp), %rbx
	xorq	%rbp, %rbx
	rolq	$15, %rbx
	movq	184(%rsp), %r12
	xorq	%rcx, %r12
	rolq	$56, %r12
	andnq	%rdi, %rsi, %r13
	xorq	%rdx, %r13
	movq	%r13, 320(%rsp)
	andnq	%rbx, %rdi, %r13
	xorq	%rsi, %r13
	movq	%r13, 328(%rsp)
	andnq	%r12, %rbx, %r13
	xorq	%rdi, %r13
	movq	%r13, 336(%rsp)
	andnq	%rdx, %r12, %rdi
	xorq	%rbx, %rdi
	movq	%rdi, 344(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%r12, %rdx
	movq	%rdx, 352(%rsp)
	movq	16(%rsp), %rdx
	xorq	%rbp, %rdx
	rolq	$62, %rdx
	movq	64(%rsp), %rsi
	xorq	%rcx, %rsi
	rolq	$55, %rsi
	movq	%rsi, %rcx
	movq	112(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$39, %rsi
	movq	%rsi, %rax
	movq	120(%rsp), %rsi
	xorq	%r8, %rsi
	rolq	$41, %rsi
	movq	168(%rsp), %rdi
	xorq	%r11, %rdi
	rolq	$2, %rdi
	andnq	%rax, %rcx, %r8
	xorq	%rdx, %r8
	movq	%r8, 360(%rsp)
	andnq	%rsi, %rax, %r8
	xorq	%rcx, %r8
	movq	%r8, 368(%rsp)
	andnq	%rdi, %rsi, %r8
	xorq	%rax, %r8
	movq	%r8, 376(%rsp)
	andnq	%rdx, %rdi, %rax
	xorq	%rsi, %rax
	movq	%rax, 384(%rsp)
	andnq	%rcx, %rdx, %rax
	xorq	%rdi, %rax
	movq	%rax, 392(%rsp)
	leaq	16(%r9), %r9
	testb	$-1, %r9b
	jne 	Lkeccak_1600$10
	leaq	-192(%r9), %r9
	movq	400(%rsp), %rcx
	movq	432(%rsp), %rax
	movq	%rax, %rdx
	shrq	$3, %rdx
	movq	$0, %rsi
	jmp 	Lkeccak_1600$8
Lkeccak_1600$9:
	movq	200(%rsp,%rsi,8), %rdi
	movq	%rdi, (%rcx,%rsi,8)
	leaq	1(%rsi), %rsi
Lkeccak_1600$8:
	cmpq	%rdx, %rsi
	jb  	Lkeccak_1600$9
	leaq	(%rcx,%rax), %rcx
	movq	%rcx, 400(%rsp)
	movq	448(%rsp), %rcx
	subq	%rax, %rcx
Lkeccak_1600$6:
	cmpq	%rax, %rcx
	jnbe	Lkeccak_1600$7
	movq	%rcx, 440(%rsp)
Lkeccak_1600$5:
	movq	(%r9), %rax
	movq	%rax, 448(%rsp)
	movq	200(%rsp), %rax
	movq	208(%rsp), %rcx
	movq	216(%rsp), %rdx
	movq	224(%rsp), %rsi
	movq	232(%rsp), %rdi
	xorq	240(%rsp), %rax
	xorq	248(%rsp), %rcx
	xorq	256(%rsp), %rdx
	xorq	264(%rsp), %rsi
	xorq	272(%rsp), %rdi
	xorq	280(%rsp), %rax
	xorq	288(%rsp), %rcx
	xorq	296(%rsp), %rdx
	xorq	304(%rsp), %rsi
	xorq	312(%rsp), %rdi
	xorq	320(%rsp), %rax
	xorq	328(%rsp), %rcx
	xorq	336(%rsp), %rdx
	xorq	344(%rsp), %rsi
	xorq	352(%rsp), %rdi
	xorq	360(%rsp), %rax
	xorq	368(%rsp), %rcx
	xorq	376(%rsp), %rdx
	xorq	384(%rsp), %rsi
	xorq	392(%rsp), %rdi
	movq	%rcx, %r8
	rolq	$1, %r8
	xorq	%rdi, %r8
	movq	%rdx, %r11
	rolq	$1, %r11
	xorq	%rax, %r11
	movq	%rsi, %rbp
	rolq	$1, %rbp
	xorq	%rcx, %rbp
	movq	%rdi, %rcx
	rolq	$1, %rcx
	xorq	%rdx, %rcx
	rolq	$1, %rax
	xorq	%rsi, %rax
	movq	200(%rsp), %rdx
	xorq	%r8, %rdx
	movq	248(%rsp), %rsi
	xorq	%r11, %rsi
	rolq	$44, %rsi
	movq	296(%rsp), %rdi
	xorq	%rbp, %rdi
	rolq	$43, %rdi
	movq	344(%rsp), %rbx
	xorq	%rcx, %rbx
	rolq	$21, %rbx
	movq	392(%rsp), %r12
	xorq	%rax, %r12
	rolq	$14, %r12
	andnq	%rdi, %rsi, %r13
	xorq	448(%rsp), %r13
	xorq	%rdx, %r13
	movq	%r13, (%rsp)
	andnq	%rbx, %rdi, %r13
	xorq	%rsi, %r13
	movq	%r13, 8(%rsp)
	andnq	%r12, %rbx, %r13
	xorq	%rdi, %r13
	movq	%r13, 16(%rsp)
	andnq	%rdx, %r12, %rdi
	xorq	%rbx, %rdi
	movq	%rdi, 24(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%r12, %rdx
	movq	%rdx, 32(%rsp)
	movq	224(%rsp), %rdx
	xorq	%rcx, %rdx
	rolq	$28, %rdx
	movq	272(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$20, %rsi
	movq	280(%rsp), %rdi
	xorq	%r8, %rdi
	rolq	$3, %rdi
	movq	328(%rsp), %rbx
	xorq	%r11, %rbx
	rolq	$45, %rbx
	movq	376(%rsp), %r12
	xorq	%rbp, %r12
	rolq	$61, %r12
	andnq	%rdi, %rsi, %r13
	xorq	%rdx, %r13
	movq	%r13, 40(%rsp)
	andnq	%rbx, %rdi, %r13
	xorq	%rsi, %r13
	movq	%r13, 48(%rsp)
	andnq	%r12, %rbx, %r13
	xorq	%rdi, %r13
	movq	%r13, 56(%rsp)
	andnq	%rdx, %r12, %rdi
	xorq	%rbx, %rdi
	movq	%rdi, 64(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%r12, %rdx
	movq	%rdx, 72(%rsp)
	movq	208(%rsp), %rdx
	xorq	%r11, %rdx
	rolq	$1, %rdx
	movq	256(%rsp), %rsi
	xorq	%rbp, %rsi
	rolq	$6, %rsi
	movq	304(%rsp), %rdi
	xorq	%rcx, %rdi
	rolq	$25, %rdi
	movq	352(%rsp), %rbx
	xorq	%rax, %rbx
	rolq	$8, %rbx
	movq	360(%rsp), %r12
	xorq	%r8, %r12
	rolq	$18, %r12
	andnq	%rdi, %rsi, %r13
	xorq	%rdx, %r13
	movq	%r13, 80(%rsp)
	andnq	%rbx, %rdi, %r13
	xorq	%rsi, %r13
	movq	%r13, 88(%rsp)
	andnq	%r12, %rbx, %r13
	xorq	%rdi, %r13
	movq	%r13, 96(%rsp)
	andnq	%rdx, %r12, %rdi
	xorq	%rbx, %rdi
	movq	%rdi, 104(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%r12, %rdx
	movq	%rdx, 112(%rsp)
	movq	232(%rsp), %rdx
	xorq	%rax, %rdx
	rolq	$27, %rdx
	movq	240(%rsp), %rsi
	xorq	%r8, %rsi
	rolq	$36, %rsi
	movq	288(%rsp), %rdi
	xorq	%r11, %rdi
	rolq	$10, %rdi
	movq	336(%rsp), %rbx
	xorq	%rbp, %rbx
	rolq	$15, %rbx
	movq	384(%rsp), %r12
	xorq	%rcx, %r12
	rolq	$56, %r12
	andnq	%rdi, %rsi, %r13
	xorq	%rdx, %r13
	movq	%r13, 120(%rsp)
	andnq	%rbx, %rdi, %r13
	xorq	%rsi, %r13
	movq	%r13, 128(%rsp)
	andnq	%r12, %rbx, %r13
	xorq	%rdi, %r13
	movq	%r13, 136(%rsp)
	andnq	%rdx, %r12, %rdi
	xorq	%rbx, %rdi
	movq	%rdi, 144(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%r12, %rdx
	movq	%rdx, 152(%rsp)
	movq	216(%rsp), %rdx
	xorq	%rbp, %rdx
	rolq	$62, %rdx
	movq	264(%rsp), %rsi
	xorq	%rcx, %rsi
	rolq	$55, %rsi
	movq	%rsi, %rcx
	movq	312(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$39, %rsi
	movq	%rsi, %rax
	movq	320(%rsp), %rsi
	xorq	%r8, %rsi
	rolq	$41, %rsi
	movq	368(%rsp), %rdi
	xorq	%r11, %rdi
	rolq	$2, %rdi
	andnq	%rax, %rcx, %r8
	xorq	%rdx, %r8
	movq	%r8, 160(%rsp)
	andnq	%rsi, %rax, %r8
	xorq	%rcx, %r8
	movq	%r8, 168(%rsp)
	andnq	%rdi, %rsi, %r8
	xorq	%rax, %r8
	movq	%r8, 176(%rsp)
	andnq	%rdx, %rdi, %rax
	xorq	%rsi, %rax
	movq	%rax, 184(%rsp)
	andnq	%rcx, %rdx, %rax
	xorq	%rdi, %rax
	movq	%rax, 192(%rsp)
	movq	8(%r9), %rax
	movq	%rax, 448(%rsp)
	movq	(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	16(%rsp), %rdx
	movq	24(%rsp), %rsi
	movq	32(%rsp), %rdi
	xorq	40(%rsp), %rax
	xorq	48(%rsp), %rcx
	xorq	56(%rsp), %rdx
	xorq	64(%rsp), %rsi
	xorq	72(%rsp), %rdi
	xorq	80(%rsp), %rax
	xorq	88(%rsp), %rcx
	xorq	96(%rsp), %rdx
	xorq	104(%rsp), %rsi
	xorq	112(%rsp), %rdi
	xorq	120(%rsp), %rax
	xorq	128(%rsp), %rcx
	xorq	136(%rsp), %rdx
	xorq	144(%rsp), %rsi
	xorq	152(%rsp), %rdi
	xorq	160(%rsp), %rax
	xorq	168(%rsp), %rcx
	xorq	176(%rsp), %rdx
	xorq	184(%rsp), %rsi
	xorq	192(%rsp), %rdi
	movq	%rcx, %r8
	rolq	$1, %r8
	xorq	%rdi, %r8
	movq	%rdx, %r11
	rolq	$1, %r11
	xorq	%rax, %r11
	movq	%rsi, %rbp
	rolq	$1, %rbp
	xorq	%rcx, %rbp
	movq	%rdi, %rcx
	rolq	$1, %rcx
	xorq	%rdx, %rcx
	rolq	$1, %rax
	xorq	%rsi, %rax
	movq	(%rsp), %rdx
	xorq	%r8, %rdx
	movq	48(%rsp), %rsi
	xorq	%r11, %rsi
	rolq	$44, %rsi
	movq	96(%rsp), %rdi
	xorq	%rbp, %rdi
	rolq	$43, %rdi
	movq	144(%rsp), %rbx
	xorq	%rcx, %rbx
	rolq	$21, %rbx
	movq	192(%rsp), %r12
	xorq	%rax, %r12
	rolq	$14, %r12
	andnq	%rdi, %rsi, %r13
	xorq	448(%rsp), %r13
	xorq	%rdx, %r13
	movq	%r13, 200(%rsp)
	andnq	%rbx, %rdi, %r13
	xorq	%rsi, %r13
	movq	%r13, 208(%rsp)
	andnq	%r12, %rbx, %r13
	xorq	%rdi, %r13
	movq	%r13, 216(%rsp)
	andnq	%rdx, %r12, %rdi
	xorq	%rbx, %rdi
	movq	%rdi, 224(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%r12, %rdx
	movq	%rdx, 232(%rsp)
	movq	24(%rsp), %rdx
	xorq	%rcx, %rdx
	rolq	$28, %rdx
	movq	72(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$20, %rsi
	movq	80(%rsp), %rdi
	xorq	%r8, %rdi
	rolq	$3, %rdi
	movq	128(%rsp), %rbx
	xorq	%r11, %rbx
	rolq	$45, %rbx
	movq	176(%rsp), %r12
	xorq	%rbp, %r12
	rolq	$61, %r12
	andnq	%rdi, %rsi, %r13
	xorq	%rdx, %r13
	movq	%r13, 240(%rsp)
	andnq	%rbx, %rdi, %r13
	xorq	%rsi, %r13
	movq	%r13, 248(%rsp)
	andnq	%r12, %rbx, %r13
	xorq	%rdi, %r13
	movq	%r13, 256(%rsp)
	andnq	%rdx, %r12, %rdi
	xorq	%rbx, %rdi
	movq	%rdi, 264(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%r12, %rdx
	movq	%rdx, 272(%rsp)
	movq	8(%rsp), %rdx
	xorq	%r11, %rdx
	rolq	$1, %rdx
	movq	56(%rsp), %rsi
	xorq	%rbp, %rsi
	rolq	$6, %rsi
	movq	104(%rsp), %rdi
	xorq	%rcx, %rdi
	rolq	$25, %rdi
	movq	152(%rsp), %rbx
	xorq	%rax, %rbx
	rolq	$8, %rbx
	movq	160(%rsp), %r12
	xorq	%r8, %r12
	rolq	$18, %r12
	andnq	%rdi, %rsi, %r13
	xorq	%rdx, %r13
	movq	%r13, 280(%rsp)
	andnq	%rbx, %rdi, %r13
	xorq	%rsi, %r13
	movq	%r13, 288(%rsp)
	andnq	%r12, %rbx, %r13
	xorq	%rdi, %r13
	movq	%r13, 296(%rsp)
	andnq	%rdx, %r12, %rdi
	xorq	%rbx, %rdi
	movq	%rdi, 304(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%r12, %rdx
	movq	%rdx, 312(%rsp)
	movq	32(%rsp), %rdx
	xorq	%rax, %rdx
	rolq	$27, %rdx
	movq	40(%rsp), %rsi
	xorq	%r8, %rsi
	rolq	$36, %rsi
	movq	88(%rsp), %rdi
	xorq	%r11, %rdi
	rolq	$10, %rdi
	movq	136(%rsp), %rbx
	xorq	%rbp, %rbx
	rolq	$15, %rbx
	movq	184(%rsp), %r12
	xorq	%rcx, %r12
	rolq	$56, %r12
	andnq	%rdi, %rsi, %r13
	xorq	%rdx, %r13
	movq	%r13, 320(%rsp)
	andnq	%rbx, %rdi, %r13
	xorq	%rsi, %r13
	movq	%r13, 328(%rsp)
	andnq	%r12, %rbx, %r13
	xorq	%rdi, %r13
	movq	%r13, 336(%rsp)
	andnq	%rdx, %r12, %rdi
	xorq	%rbx, %rdi
	movq	%rdi, 344(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%r12, %rdx
	movq	%rdx, 352(%rsp)
	movq	16(%rsp), %rdx
	xorq	%rbp, %rdx
	rolq	$62, %rdx
	movq	64(%rsp), %rsi
	xorq	%rcx, %rsi
	rolq	$55, %rsi
	movq	%rsi, %rcx
	movq	112(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$39, %rsi
	movq	%rsi, %rax
	movq	120(%rsp), %rsi
	xorq	%r8, %rsi
	rolq	$41, %rsi
	movq	168(%rsp), %rdi
	xorq	%r11, %rdi
	rolq	$2, %rdi
	andnq	%rax, %rcx, %r8
	xorq	%rdx, %r8
	movq	%r8, 360(%rsp)
	andnq	%rsi, %rax, %r8
	xorq	%rcx, %r8
	movq	%r8, 368(%rsp)
	andnq	%rdi, %rsi, %r8
	xorq	%rax, %r8
	movq	%r8, 376(%rsp)
	andnq	%rdx, %rdi, %rax
	xorq	%rsi, %rax
	movq	%rax, 384(%rsp)
	andnq	%rcx, %rdx, %rax
	xorq	%rdi, %rax
	movq	%rax, 392(%rsp)
	leaq	16(%r9), %r9
	testb	$-1, %r9b
	jne 	Lkeccak_1600$5
	movq	400(%rsp), %rax
	movq	440(%rsp), %rcx
	movq	%rcx, %rdx
	shrq	$3, %rdx
	movq	$0, %rsi
	jmp 	Lkeccak_1600$3
Lkeccak_1600$4:
	movq	200(%rsp,%rsi,8), %rdi
	movq	%rdi, (%rax,%rsi,8)
	leaq	1(%rsi), %rsi
Lkeccak_1600$3:
	cmpq	%rdx, %rsi
	jb  	Lkeccak_1600$4
	shlq	$3, %rsi
	jmp 	Lkeccak_1600$1
Lkeccak_1600$2:
	movb	200(%rsp,%rsi), %dl
	movb	%dl, (%rax,%rsi)
	leaq	1(%rsi), %rsi
Lkeccak_1600$1:
	cmpq	%rcx, %rsi
	jb  	Lkeccak_1600$2
	addq	$457, %rsp
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	ret 

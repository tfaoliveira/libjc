	.text
	.p2align	5
	.globl	_keccak_1600
	.globl	keccak_1600
_keccak_1600:
keccak_1600:
	pushq	%rbp
	pushq	%rbx
	pushq	%r12
	subq	$456, %rsp
	movq	%rdi, 8(%rsp)
	movq	%rsi, (%rsp)
	movzbq	(%r8), %rax
	movq	%rax, 216(%rsp)
	movq	8(%r8), %rax
	xorl	%esi, %esi
	movq	$0, %rdi
	jmp 	Lkeccak_1600$20
Lkeccak_1600$21:
	movq	%rsi, 16(%rsp,%rdi,8)
	leaq	1(%rdi), %rdi
Lkeccak_1600$20:
	cmpq	$25, %rdi
	jb  	Lkeccak_1600$21
	jmp 	Lkeccak_1600$15
Lkeccak_1600$16:
	movq	$0, %rsi
	movq	%rax, %rdi
	shrq	$3, %rdi
	jmp 	Lkeccak_1600$18
Lkeccak_1600$19:
	movq	(%rdx,%rsi,8), %r8
	xorq	%r8, 16(%rsp,%rsi,8)
	leaq	1(%rsi), %rsi
Lkeccak_1600$18:
	cmpq	%rdi, %rsi
	jb  	Lkeccak_1600$19
	leaq	(%rdx,%rax), %rdx
	subq	%rax, %rcx
	movq	%rdx, 240(%rsp)
	movq	%rcx, 232(%rsp)
	movq	%rax, 224(%rsp)
Lkeccak_1600$17:
	movq	(%r9), %rax
	movq	%rax, 448(%rsp)
	movq	16(%rsp), %rax
	movq	24(%rsp), %rcx
	movq	32(%rsp), %rdx
	movq	40(%rsp), %rsi
	movq	48(%rsp), %rdi
	xorq	56(%rsp), %rax
	xorq	64(%rsp), %rcx
	xorq	72(%rsp), %rdx
	xorq	80(%rsp), %rsi
	xorq	88(%rsp), %rdi
	xorq	96(%rsp), %rax
	xorq	104(%rsp), %rcx
	xorq	112(%rsp), %rdx
	xorq	120(%rsp), %rsi
	xorq	128(%rsp), %rdi
	xorq	136(%rsp), %rax
	xorq	144(%rsp), %rcx
	xorq	152(%rsp), %rdx
	xorq	160(%rsp), %rsi
	xorq	168(%rsp), %rdi
	xorq	176(%rsp), %rax
	xorq	184(%rsp), %rcx
	xorq	192(%rsp), %rdx
	xorq	200(%rsp), %rsi
	xorq	208(%rsp), %rdi
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
	movq	16(%rsp), %rdx
	xorq	%r8, %rdx
	movq	64(%rsp), %rsi
	xorq	%r10, %rsi
	rolq	$44, %rsi
	movq	112(%rsp), %rdi
	xorq	%r11, %rdi
	rolq	$43, %rdi
	movq	160(%rsp), %rbp
	xorq	%rcx, %rbp
	rolq	$21, %rbp
	movq	208(%rsp), %rbx
	xorq	%rax, %rbx
	rolq	$14, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	448(%rsp), %r12
	xorq	%rdx, %r12
	movq	%r12, 248(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 256(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 264(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 272(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 280(%rsp)
	movq	40(%rsp), %rdx
	xorq	%rcx, %rdx
	rolq	$28, %rdx
	movq	88(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$20, %rsi
	movq	96(%rsp), %rdi
	xorq	%r8, %rdi
	rolq	$3, %rdi
	movq	144(%rsp), %rbp
	xorq	%r10, %rbp
	rolq	$45, %rbp
	movq	192(%rsp), %rbx
	xorq	%r11, %rbx
	rolq	$61, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 288(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 296(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 304(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 312(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 320(%rsp)
	movq	24(%rsp), %rdx
	xorq	%r10, %rdx
	rolq	$1, %rdx
	movq	72(%rsp), %rsi
	xorq	%r11, %rsi
	rolq	$6, %rsi
	movq	120(%rsp), %rdi
	xorq	%rcx, %rdi
	rolq	$25, %rdi
	movq	168(%rsp), %rbp
	xorq	%rax, %rbp
	rolq	$8, %rbp
	movq	176(%rsp), %rbx
	xorq	%r8, %rbx
	rolq	$18, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 328(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 336(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 344(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 352(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 360(%rsp)
	movq	48(%rsp), %rdx
	xorq	%rax, %rdx
	rolq	$27, %rdx
	movq	56(%rsp), %rsi
	xorq	%r8, %rsi
	rolq	$36, %rsi
	movq	104(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$10, %rdi
	movq	152(%rsp), %rbp
	xorq	%r11, %rbp
	rolq	$15, %rbp
	movq	200(%rsp), %rbx
	xorq	%rcx, %rbx
	rolq	$56, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 368(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 376(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 384(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 392(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 400(%rsp)
	movq	32(%rsp), %rdx
	xorq	%r11, %rdx
	rolq	$62, %rdx
	movq	80(%rsp), %rsi
	xorq	%rcx, %rsi
	rolq	$55, %rsi
	movq	%rsi, %rcx
	movq	128(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$39, %rsi
	movq	%rsi, %rax
	movq	136(%rsp), %rsi
	xorq	%r8, %rsi
	rolq	$41, %rsi
	movq	184(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$2, %rdi
	andnq	%rax, %rcx, %r8
	xorq	%rdx, %r8
	movq	%r8, 408(%rsp)
	andnq	%rsi, %rax, %r8
	xorq	%rcx, %r8
	movq	%r8, 416(%rsp)
	andnq	%rdi, %rsi, %r8
	xorq	%rax, %r8
	movq	%r8, 424(%rsp)
	andnq	%rdx, %rdi, %rax
	xorq	%rsi, %rax
	movq	%rax, 432(%rsp)
	andnq	%rcx, %rdx, %rax
	xorq	%rdi, %rax
	movq	%rax, 440(%rsp)
	movq	8(%r9), %rax
	movq	%rax, 448(%rsp)
	movq	248(%rsp), %rax
	movq	256(%rsp), %rcx
	movq	264(%rsp), %rdx
	movq	272(%rsp), %rsi
	movq	280(%rsp), %rdi
	xorq	288(%rsp), %rax
	xorq	296(%rsp), %rcx
	xorq	304(%rsp), %rdx
	xorq	312(%rsp), %rsi
	xorq	320(%rsp), %rdi
	xorq	328(%rsp), %rax
	xorq	336(%rsp), %rcx
	xorq	344(%rsp), %rdx
	xorq	352(%rsp), %rsi
	xorq	360(%rsp), %rdi
	xorq	368(%rsp), %rax
	xorq	376(%rsp), %rcx
	xorq	384(%rsp), %rdx
	xorq	392(%rsp), %rsi
	xorq	400(%rsp), %rdi
	xorq	408(%rsp), %rax
	xorq	416(%rsp), %rcx
	xorq	424(%rsp), %rdx
	xorq	432(%rsp), %rsi
	xorq	440(%rsp), %rdi
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
	movq	248(%rsp), %rdx
	xorq	%r8, %rdx
	movq	296(%rsp), %rsi
	xorq	%r10, %rsi
	rolq	$44, %rsi
	movq	344(%rsp), %rdi
	xorq	%r11, %rdi
	rolq	$43, %rdi
	movq	392(%rsp), %rbp
	xorq	%rcx, %rbp
	rolq	$21, %rbp
	movq	440(%rsp), %rbx
	xorq	%rax, %rbx
	rolq	$14, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	448(%rsp), %r12
	xorq	%rdx, %r12
	movq	%r12, 16(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 24(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 32(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 40(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 48(%rsp)
	movq	272(%rsp), %rdx
	xorq	%rcx, %rdx
	rolq	$28, %rdx
	movq	320(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$20, %rsi
	movq	328(%rsp), %rdi
	xorq	%r8, %rdi
	rolq	$3, %rdi
	movq	376(%rsp), %rbp
	xorq	%r10, %rbp
	rolq	$45, %rbp
	movq	424(%rsp), %rbx
	xorq	%r11, %rbx
	rolq	$61, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 56(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 64(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 72(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 80(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 88(%rsp)
	movq	256(%rsp), %rdx
	xorq	%r10, %rdx
	rolq	$1, %rdx
	movq	304(%rsp), %rsi
	xorq	%r11, %rsi
	rolq	$6, %rsi
	movq	352(%rsp), %rdi
	xorq	%rcx, %rdi
	rolq	$25, %rdi
	movq	400(%rsp), %rbp
	xorq	%rax, %rbp
	rolq	$8, %rbp
	movq	408(%rsp), %rbx
	xorq	%r8, %rbx
	rolq	$18, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 96(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 104(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 112(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 120(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 128(%rsp)
	movq	280(%rsp), %rdx
	xorq	%rax, %rdx
	rolq	$27, %rdx
	movq	288(%rsp), %rsi
	xorq	%r8, %rsi
	rolq	$36, %rsi
	movq	336(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$10, %rdi
	movq	384(%rsp), %rbp
	xorq	%r11, %rbp
	rolq	$15, %rbp
	movq	432(%rsp), %rbx
	xorq	%rcx, %rbx
	rolq	$56, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 136(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 144(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 152(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 160(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 168(%rsp)
	movq	264(%rsp), %rdx
	xorq	%r11, %rdx
	rolq	$62, %rdx
	movq	312(%rsp), %rsi
	xorq	%rcx, %rsi
	rolq	$55, %rsi
	movq	%rsi, %rcx
	movq	360(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$39, %rsi
	movq	%rsi, %rax
	movq	368(%rsp), %rsi
	xorq	%r8, %rsi
	rolq	$41, %rsi
	movq	416(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$2, %rdi
	andnq	%rax, %rcx, %r8
	xorq	%rdx, %r8
	movq	%r8, 176(%rsp)
	andnq	%rsi, %rax, %r8
	xorq	%rcx, %r8
	movq	%r8, 184(%rsp)
	andnq	%rdi, %rsi, %r8
	xorq	%rax, %r8
	movq	%r8, 192(%rsp)
	andnq	%rdx, %rdi, %rax
	xorq	%rsi, %rax
	movq	%rax, 200(%rsp)
	andnq	%rcx, %rdx, %rax
	xorq	%rdi, %rax
	movq	%rax, 208(%rsp)
	leaq	16(%r9), %r9
	testb	$-1, %r9b
	jne 	Lkeccak_1600$17
	leaq	-192(%r9), %r9
	movq	240(%rsp), %rdx
	movq	232(%rsp), %rcx
	movq	224(%rsp), %rax
Lkeccak_1600$15:
	cmpq	%rax, %rcx
	jnb 	Lkeccak_1600$16
	movq	%rcx, %rsi
	shrq	$3, %rsi
	movq	$0, %rdi
	jmp 	Lkeccak_1600$13
Lkeccak_1600$14:
	movq	(%rdx,%rdi,8), %r8
	xorq	%r8, 16(%rsp,%rdi,8)
	leaq	1(%rdi), %rdi
Lkeccak_1600$13:
	cmpq	%rsi, %rdi
	jb  	Lkeccak_1600$14
	shlq	$3, %rdi
	jmp 	Lkeccak_1600$11
Lkeccak_1600$12:
	movb	(%rdx,%rdi), %sil
	xorb	%sil, 16(%rsp,%rdi)
	leaq	1(%rdi), %rdi
Lkeccak_1600$11:
	cmpq	%rcx, %rdi
	jb  	Lkeccak_1600$12
	movq	216(%rsp), %rcx
	movb	%cl, %cl
	xorb	%cl, 16(%rsp,%rdi)
	movq	%rax, %rcx
	leaq	-1(%rcx), %rcx
	xorb	$-128, 16(%rsp,%rcx)
	movq	(%rsp), %rcx
	jmp 	Lkeccak_1600$6
Lkeccak_1600$7:
	movq	%rcx, 240(%rsp)
	movq	%rax, 448(%rsp)
Lkeccak_1600$10:
	movq	(%r9), %rax
	movq	%rax, 232(%rsp)
	movq	16(%rsp), %rax
	movq	24(%rsp), %rcx
	movq	32(%rsp), %rdx
	movq	40(%rsp), %rsi
	movq	48(%rsp), %rdi
	xorq	56(%rsp), %rax
	xorq	64(%rsp), %rcx
	xorq	72(%rsp), %rdx
	xorq	80(%rsp), %rsi
	xorq	88(%rsp), %rdi
	xorq	96(%rsp), %rax
	xorq	104(%rsp), %rcx
	xorq	112(%rsp), %rdx
	xorq	120(%rsp), %rsi
	xorq	128(%rsp), %rdi
	xorq	136(%rsp), %rax
	xorq	144(%rsp), %rcx
	xorq	152(%rsp), %rdx
	xorq	160(%rsp), %rsi
	xorq	168(%rsp), %rdi
	xorq	176(%rsp), %rax
	xorq	184(%rsp), %rcx
	xorq	192(%rsp), %rdx
	xorq	200(%rsp), %rsi
	xorq	208(%rsp), %rdi
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
	movq	16(%rsp), %rdx
	xorq	%r8, %rdx
	movq	64(%rsp), %rsi
	xorq	%r10, %rsi
	rolq	$44, %rsi
	movq	112(%rsp), %rdi
	xorq	%r11, %rdi
	rolq	$43, %rdi
	movq	160(%rsp), %rbp
	xorq	%rcx, %rbp
	rolq	$21, %rbp
	movq	208(%rsp), %rbx
	xorq	%rax, %rbx
	rolq	$14, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	232(%rsp), %r12
	xorq	%rdx, %r12
	movq	%r12, 248(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 256(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 264(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 272(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 280(%rsp)
	movq	40(%rsp), %rdx
	xorq	%rcx, %rdx
	rolq	$28, %rdx
	movq	88(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$20, %rsi
	movq	96(%rsp), %rdi
	xorq	%r8, %rdi
	rolq	$3, %rdi
	movq	144(%rsp), %rbp
	xorq	%r10, %rbp
	rolq	$45, %rbp
	movq	192(%rsp), %rbx
	xorq	%r11, %rbx
	rolq	$61, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 288(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 296(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 304(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 312(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 320(%rsp)
	movq	24(%rsp), %rdx
	xorq	%r10, %rdx
	rolq	$1, %rdx
	movq	72(%rsp), %rsi
	xorq	%r11, %rsi
	rolq	$6, %rsi
	movq	120(%rsp), %rdi
	xorq	%rcx, %rdi
	rolq	$25, %rdi
	movq	168(%rsp), %rbp
	xorq	%rax, %rbp
	rolq	$8, %rbp
	movq	176(%rsp), %rbx
	xorq	%r8, %rbx
	rolq	$18, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 328(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 336(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 344(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 352(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 360(%rsp)
	movq	48(%rsp), %rdx
	xorq	%rax, %rdx
	rolq	$27, %rdx
	movq	56(%rsp), %rsi
	xorq	%r8, %rsi
	rolq	$36, %rsi
	movq	104(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$10, %rdi
	movq	152(%rsp), %rbp
	xorq	%r11, %rbp
	rolq	$15, %rbp
	movq	200(%rsp), %rbx
	xorq	%rcx, %rbx
	rolq	$56, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 368(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 376(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 384(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 392(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 400(%rsp)
	movq	32(%rsp), %rdx
	xorq	%r11, %rdx
	rolq	$62, %rdx
	movq	80(%rsp), %rsi
	xorq	%rcx, %rsi
	rolq	$55, %rsi
	movq	%rsi, %rcx
	movq	128(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$39, %rsi
	movq	%rsi, %rax
	movq	136(%rsp), %rsi
	xorq	%r8, %rsi
	rolq	$41, %rsi
	movq	184(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$2, %rdi
	andnq	%rax, %rcx, %r8
	xorq	%rdx, %r8
	movq	%r8, 408(%rsp)
	andnq	%rsi, %rax, %r8
	xorq	%rcx, %r8
	movq	%r8, 416(%rsp)
	andnq	%rdi, %rsi, %r8
	xorq	%rax, %r8
	movq	%r8, 424(%rsp)
	andnq	%rdx, %rdi, %rax
	xorq	%rsi, %rax
	movq	%rax, 432(%rsp)
	andnq	%rcx, %rdx, %rax
	xorq	%rdi, %rax
	movq	%rax, 440(%rsp)
	movq	8(%r9), %rax
	movq	%rax, 232(%rsp)
	movq	248(%rsp), %rax
	movq	256(%rsp), %rcx
	movq	264(%rsp), %rdx
	movq	272(%rsp), %rsi
	movq	280(%rsp), %rdi
	xorq	288(%rsp), %rax
	xorq	296(%rsp), %rcx
	xorq	304(%rsp), %rdx
	xorq	312(%rsp), %rsi
	xorq	320(%rsp), %rdi
	xorq	328(%rsp), %rax
	xorq	336(%rsp), %rcx
	xorq	344(%rsp), %rdx
	xorq	352(%rsp), %rsi
	xorq	360(%rsp), %rdi
	xorq	368(%rsp), %rax
	xorq	376(%rsp), %rcx
	xorq	384(%rsp), %rdx
	xorq	392(%rsp), %rsi
	xorq	400(%rsp), %rdi
	xorq	408(%rsp), %rax
	xorq	416(%rsp), %rcx
	xorq	424(%rsp), %rdx
	xorq	432(%rsp), %rsi
	xorq	440(%rsp), %rdi
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
	movq	248(%rsp), %rdx
	xorq	%r8, %rdx
	movq	296(%rsp), %rsi
	xorq	%r10, %rsi
	rolq	$44, %rsi
	movq	344(%rsp), %rdi
	xorq	%r11, %rdi
	rolq	$43, %rdi
	movq	392(%rsp), %rbp
	xorq	%rcx, %rbp
	rolq	$21, %rbp
	movq	440(%rsp), %rbx
	xorq	%rax, %rbx
	rolq	$14, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	232(%rsp), %r12
	xorq	%rdx, %r12
	movq	%r12, 16(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 24(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 32(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 40(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 48(%rsp)
	movq	272(%rsp), %rdx
	xorq	%rcx, %rdx
	rolq	$28, %rdx
	movq	320(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$20, %rsi
	movq	328(%rsp), %rdi
	xorq	%r8, %rdi
	rolq	$3, %rdi
	movq	376(%rsp), %rbp
	xorq	%r10, %rbp
	rolq	$45, %rbp
	movq	424(%rsp), %rbx
	xorq	%r11, %rbx
	rolq	$61, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 56(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 64(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 72(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 80(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 88(%rsp)
	movq	256(%rsp), %rdx
	xorq	%r10, %rdx
	rolq	$1, %rdx
	movq	304(%rsp), %rsi
	xorq	%r11, %rsi
	rolq	$6, %rsi
	movq	352(%rsp), %rdi
	xorq	%rcx, %rdi
	rolq	$25, %rdi
	movq	400(%rsp), %rbp
	xorq	%rax, %rbp
	rolq	$8, %rbp
	movq	408(%rsp), %rbx
	xorq	%r8, %rbx
	rolq	$18, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 96(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 104(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 112(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 120(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 128(%rsp)
	movq	280(%rsp), %rdx
	xorq	%rax, %rdx
	rolq	$27, %rdx
	movq	288(%rsp), %rsi
	xorq	%r8, %rsi
	rolq	$36, %rsi
	movq	336(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$10, %rdi
	movq	384(%rsp), %rbp
	xorq	%r11, %rbp
	rolq	$15, %rbp
	movq	432(%rsp), %rbx
	xorq	%rcx, %rbx
	rolq	$56, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 136(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 144(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 152(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 160(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 168(%rsp)
	movq	264(%rsp), %rdx
	xorq	%r11, %rdx
	rolq	$62, %rdx
	movq	312(%rsp), %rsi
	xorq	%rcx, %rsi
	rolq	$55, %rsi
	movq	%rsi, %rcx
	movq	360(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$39, %rsi
	movq	%rsi, %rax
	movq	368(%rsp), %rsi
	xorq	%r8, %rsi
	rolq	$41, %rsi
	movq	416(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$2, %rdi
	andnq	%rax, %rcx, %r8
	xorq	%rdx, %r8
	movq	%r8, 176(%rsp)
	andnq	%rsi, %rax, %r8
	xorq	%rcx, %r8
	movq	%r8, 184(%rsp)
	andnq	%rdi, %rsi, %r8
	xorq	%rax, %r8
	movq	%r8, 192(%rsp)
	andnq	%rdx, %rdi, %rax
	xorq	%rsi, %rax
	movq	%rax, 200(%rsp)
	andnq	%rcx, %rdx, %rax
	xorq	%rdi, %rax
	movq	%rax, 208(%rsp)
	leaq	16(%r9), %r9
	testb	$-1, %r9b
	jne 	Lkeccak_1600$10
	leaq	-192(%r9), %r9
	movq	8(%rsp), %rcx
	movq	448(%rsp), %rax
	movq	%rax, %rdx
	shrq	$3, %rdx
	movq	$0, %rsi
	jmp 	Lkeccak_1600$8
Lkeccak_1600$9:
	movq	16(%rsp,%rsi,8), %rdi
	movq	%rdi, (%rcx,%rsi,8)
	leaq	1(%rsi), %rsi
Lkeccak_1600$8:
	cmpq	%rdx, %rsi
	jb  	Lkeccak_1600$9
	leaq	(%rcx,%rax), %rcx
	movq	%rcx, 8(%rsp)
	movq	240(%rsp), %rcx
	subq	%rax, %rcx
Lkeccak_1600$6:
	cmpq	%rax, %rcx
	jnbe	Lkeccak_1600$7
	movq	%rcx, 240(%rsp)
Lkeccak_1600$5:
	movq	(%r9), %rax
	movq	%rax, 448(%rsp)
	movq	16(%rsp), %rax
	movq	24(%rsp), %rcx
	movq	32(%rsp), %rdx
	movq	40(%rsp), %rsi
	movq	48(%rsp), %rdi
	xorq	56(%rsp), %rax
	xorq	64(%rsp), %rcx
	xorq	72(%rsp), %rdx
	xorq	80(%rsp), %rsi
	xorq	88(%rsp), %rdi
	xorq	96(%rsp), %rax
	xorq	104(%rsp), %rcx
	xorq	112(%rsp), %rdx
	xorq	120(%rsp), %rsi
	xorq	128(%rsp), %rdi
	xorq	136(%rsp), %rax
	xorq	144(%rsp), %rcx
	xorq	152(%rsp), %rdx
	xorq	160(%rsp), %rsi
	xorq	168(%rsp), %rdi
	xorq	176(%rsp), %rax
	xorq	184(%rsp), %rcx
	xorq	192(%rsp), %rdx
	xorq	200(%rsp), %rsi
	xorq	208(%rsp), %rdi
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
	movq	16(%rsp), %rdx
	xorq	%r8, %rdx
	movq	64(%rsp), %rsi
	xorq	%r10, %rsi
	rolq	$44, %rsi
	movq	112(%rsp), %rdi
	xorq	%r11, %rdi
	rolq	$43, %rdi
	movq	160(%rsp), %rbp
	xorq	%rcx, %rbp
	rolq	$21, %rbp
	movq	208(%rsp), %rbx
	xorq	%rax, %rbx
	rolq	$14, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	448(%rsp), %r12
	xorq	%rdx, %r12
	movq	%r12, 248(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 256(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 264(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 272(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 280(%rsp)
	movq	40(%rsp), %rdx
	xorq	%rcx, %rdx
	rolq	$28, %rdx
	movq	88(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$20, %rsi
	movq	96(%rsp), %rdi
	xorq	%r8, %rdi
	rolq	$3, %rdi
	movq	144(%rsp), %rbp
	xorq	%r10, %rbp
	rolq	$45, %rbp
	movq	192(%rsp), %rbx
	xorq	%r11, %rbx
	rolq	$61, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 288(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 296(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 304(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 312(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 320(%rsp)
	movq	24(%rsp), %rdx
	xorq	%r10, %rdx
	rolq	$1, %rdx
	movq	72(%rsp), %rsi
	xorq	%r11, %rsi
	rolq	$6, %rsi
	movq	120(%rsp), %rdi
	xorq	%rcx, %rdi
	rolq	$25, %rdi
	movq	168(%rsp), %rbp
	xorq	%rax, %rbp
	rolq	$8, %rbp
	movq	176(%rsp), %rbx
	xorq	%r8, %rbx
	rolq	$18, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 328(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 336(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 344(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 352(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 360(%rsp)
	movq	48(%rsp), %rdx
	xorq	%rax, %rdx
	rolq	$27, %rdx
	movq	56(%rsp), %rsi
	xorq	%r8, %rsi
	rolq	$36, %rsi
	movq	104(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$10, %rdi
	movq	152(%rsp), %rbp
	xorq	%r11, %rbp
	rolq	$15, %rbp
	movq	200(%rsp), %rbx
	xorq	%rcx, %rbx
	rolq	$56, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 368(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 376(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 384(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 392(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 400(%rsp)
	movq	32(%rsp), %rdx
	xorq	%r11, %rdx
	rolq	$62, %rdx
	movq	80(%rsp), %rsi
	xorq	%rcx, %rsi
	rolq	$55, %rsi
	movq	%rsi, %rcx
	movq	128(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$39, %rsi
	movq	%rsi, %rax
	movq	136(%rsp), %rsi
	xorq	%r8, %rsi
	rolq	$41, %rsi
	movq	184(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$2, %rdi
	andnq	%rax, %rcx, %r8
	xorq	%rdx, %r8
	movq	%r8, 408(%rsp)
	andnq	%rsi, %rax, %r8
	xorq	%rcx, %r8
	movq	%r8, 416(%rsp)
	andnq	%rdi, %rsi, %r8
	xorq	%rax, %r8
	movq	%r8, 424(%rsp)
	andnq	%rdx, %rdi, %rax
	xorq	%rsi, %rax
	movq	%rax, 432(%rsp)
	andnq	%rcx, %rdx, %rax
	xorq	%rdi, %rax
	movq	%rax, 440(%rsp)
	movq	8(%r9), %rax
	movq	%rax, 448(%rsp)
	movq	248(%rsp), %rax
	movq	256(%rsp), %rcx
	movq	264(%rsp), %rdx
	movq	272(%rsp), %rsi
	movq	280(%rsp), %rdi
	xorq	288(%rsp), %rax
	xorq	296(%rsp), %rcx
	xorq	304(%rsp), %rdx
	xorq	312(%rsp), %rsi
	xorq	320(%rsp), %rdi
	xorq	328(%rsp), %rax
	xorq	336(%rsp), %rcx
	xorq	344(%rsp), %rdx
	xorq	352(%rsp), %rsi
	xorq	360(%rsp), %rdi
	xorq	368(%rsp), %rax
	xorq	376(%rsp), %rcx
	xorq	384(%rsp), %rdx
	xorq	392(%rsp), %rsi
	xorq	400(%rsp), %rdi
	xorq	408(%rsp), %rax
	xorq	416(%rsp), %rcx
	xorq	424(%rsp), %rdx
	xorq	432(%rsp), %rsi
	xorq	440(%rsp), %rdi
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
	movq	248(%rsp), %rdx
	xorq	%r8, %rdx
	movq	296(%rsp), %rsi
	xorq	%r10, %rsi
	rolq	$44, %rsi
	movq	344(%rsp), %rdi
	xorq	%r11, %rdi
	rolq	$43, %rdi
	movq	392(%rsp), %rbp
	xorq	%rcx, %rbp
	rolq	$21, %rbp
	movq	440(%rsp), %rbx
	xorq	%rax, %rbx
	rolq	$14, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	448(%rsp), %r12
	xorq	%rdx, %r12
	movq	%r12, 16(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 24(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 32(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 40(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 48(%rsp)
	movq	272(%rsp), %rdx
	xorq	%rcx, %rdx
	rolq	$28, %rdx
	movq	320(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$20, %rsi
	movq	328(%rsp), %rdi
	xorq	%r8, %rdi
	rolq	$3, %rdi
	movq	376(%rsp), %rbp
	xorq	%r10, %rbp
	rolq	$45, %rbp
	movq	424(%rsp), %rbx
	xorq	%r11, %rbx
	rolq	$61, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 56(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 64(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 72(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 80(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 88(%rsp)
	movq	256(%rsp), %rdx
	xorq	%r10, %rdx
	rolq	$1, %rdx
	movq	304(%rsp), %rsi
	xorq	%r11, %rsi
	rolq	$6, %rsi
	movq	352(%rsp), %rdi
	xorq	%rcx, %rdi
	rolq	$25, %rdi
	movq	400(%rsp), %rbp
	xorq	%rax, %rbp
	rolq	$8, %rbp
	movq	408(%rsp), %rbx
	xorq	%r8, %rbx
	rolq	$18, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 96(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 104(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 112(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 120(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 128(%rsp)
	movq	280(%rsp), %rdx
	xorq	%rax, %rdx
	rolq	$27, %rdx
	movq	288(%rsp), %rsi
	xorq	%r8, %rsi
	rolq	$36, %rsi
	movq	336(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$10, %rdi
	movq	384(%rsp), %rbp
	xorq	%r11, %rbp
	rolq	$15, %rbp
	movq	432(%rsp), %rbx
	xorq	%rcx, %rbx
	rolq	$56, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 136(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 144(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 152(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 160(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 168(%rsp)
	movq	264(%rsp), %rdx
	xorq	%r11, %rdx
	rolq	$62, %rdx
	movq	312(%rsp), %rsi
	xorq	%rcx, %rsi
	rolq	$55, %rsi
	movq	%rsi, %rcx
	movq	360(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$39, %rsi
	movq	%rsi, %rax
	movq	368(%rsp), %rsi
	xorq	%r8, %rsi
	rolq	$41, %rsi
	movq	416(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$2, %rdi
	andnq	%rax, %rcx, %r8
	xorq	%rdx, %r8
	movq	%r8, 176(%rsp)
	andnq	%rsi, %rax, %r8
	xorq	%rcx, %r8
	movq	%r8, 184(%rsp)
	andnq	%rdi, %rsi, %r8
	xorq	%rax, %r8
	movq	%r8, 192(%rsp)
	andnq	%rdx, %rdi, %rax
	xorq	%rsi, %rax
	movq	%rax, 200(%rsp)
	andnq	%rcx, %rdx, %rax
	xorq	%rdi, %rax
	movq	%rax, 208(%rsp)
	leaq	16(%r9), %r9
	testb	$-1, %r9b
	jne 	Lkeccak_1600$5
	movq	8(%rsp), %rax
	movq	240(%rsp), %rcx
	movq	%rcx, %rdx
	shrq	$3, %rdx
	movq	$0, %rsi
	jmp 	Lkeccak_1600$3
Lkeccak_1600$4:
	movq	16(%rsp,%rsi,8), %rdi
	movq	%rdi, (%rax,%rsi,8)
	leaq	1(%rsi), %rsi
Lkeccak_1600$3:
	cmpq	%rdx, %rsi
	jb  	Lkeccak_1600$4
	shlq	$3, %rsi
	jmp 	Lkeccak_1600$1
Lkeccak_1600$2:
	movb	16(%rsp,%rsi), %dl
	movb	%dl, (%rax,%rsi)
	leaq	1(%rsi), %rsi
Lkeccak_1600$1:
	cmpq	%rcx, %rsi
	jb  	Lkeccak_1600$2
	addq	$456, %rsp
	popq	%r12
	popq	%rbx
	popq	%rbp
	ret 

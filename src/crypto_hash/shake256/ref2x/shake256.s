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
	subq	$432, %rsp
	movq	%rdi, 424(%rsp)
	xorl	%eax, %eax
	movq	$0, %rdi
	jmp 	Lshake256_ref2x_jazz$20
Lshake256_ref2x_jazz$21:
	movq	%rax, (%rsp,%rdi,8)
	leaq	1(%rdi), %rdi
Lshake256_ref2x_jazz$20:
	cmpq	$50, %rdi
	jb  	Lshake256_ref2x_jazz$21
	jmp 	Lshake256_ref2x_jazz$17
Lshake256_ref2x_jazz$18:
	movq	(%rsi), %rax
	xorq	%rax, (%rsp)
	movq	8(%rsi), %rax
	xorq	%rax, 8(%rsp)
	movq	16(%rsi), %rax
	xorq	%rax, 16(%rsp)
	movq	24(%rsi), %rax
	xorq	%rax, 24(%rsp)
	movq	32(%rsi), %rax
	xorq	%rax, 32(%rsp)
	movq	40(%rsi), %rax
	xorq	%rax, 40(%rsp)
	movq	48(%rsi), %rax
	xorq	%rax, 48(%rsp)
	movq	56(%rsi), %rax
	xorq	%rax, 56(%rsp)
	movq	64(%rsi), %rax
	xorq	%rax, 64(%rsp)
	movq	72(%rsi), %rax
	xorq	%rax, 72(%rsp)
	movq	80(%rsi), %rax
	xorq	%rax, 80(%rsp)
	movq	88(%rsi), %rax
	xorq	%rax, 88(%rsp)
	movq	96(%rsi), %rax
	xorq	%rax, 96(%rsp)
	movq	104(%rsi), %rax
	xorq	%rax, 104(%rsp)
	movq	112(%rsi), %rax
	xorq	%rax, 112(%rsp)
	movq	120(%rsi), %rax
	xorq	%rax, 120(%rsp)
	movq	128(%rsi), %rax
	xorq	%rax, 128(%rsp)
	leaq	136(%rsi), %rax
	leaq	-136(%rdx), %rdx
	movq	%rax, 208(%rsp)
	movq	%rdx, 200(%rsp)
Lshake256_ref2x_jazz$19:
	movq	(%rcx), %rax
	movq	%rax, 416(%rsp)
	movq	(%rsp), %rax
	xorq	40(%rsp), %rax
	xorq	80(%rsp), %rax
	xorq	120(%rsp), %rax
	xorq	160(%rsp), %rax
	movq	8(%rsp), %rdx
	xorq	48(%rsp), %rdx
	xorq	88(%rsp), %rdx
	xorq	128(%rsp), %rdx
	xorq	168(%rsp), %rdx
	movq	16(%rsp), %rsi
	xorq	56(%rsp), %rsi
	xorq	96(%rsp), %rsi
	xorq	136(%rsp), %rsi
	xorq	176(%rsp), %rsi
	movq	24(%rsp), %rdi
	xorq	64(%rsp), %rdi
	xorq	104(%rsp), %rdi
	xorq	144(%rsp), %rdi
	xorq	184(%rsp), %rdi
	movq	32(%rsp), %r8
	xorq	72(%rsp), %r8
	xorq	112(%rsp), %r8
	xorq	152(%rsp), %r8
	xorq	192(%rsp), %r8
	movq	%rdx, %r9
	rolq	$1, %r9
	xorq	%r8, %r9
	movq	%rsi, %r10
	rolq	$1, %r10
	xorq	%rax, %r10
	movq	%rdi, %r11
	rolq	$1, %r11
	xorq	%rdx, %r11
	movq	%r8, %rdx
	rolq	$1, %rdx
	xorq	%rsi, %rdx
	rolq	$1, %rax
	xorq	%rdi, %rax
	movq	(%rsp), %rsi
	xorq	%r9, %rsi
	movq	48(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$44, %rdi
	movq	96(%rsp), %r8
	xorq	%r11, %r8
	rolq	$43, %r8
	movq	144(%rsp), %rbp
	xorq	%rdx, %rbp
	rolq	$21, %rbp
	movq	192(%rsp), %rbx
	xorq	%rax, %rbx
	rolq	$14, %rbx
	movq	%rdi, %r12
	movq	%r8, %r13
	andnq	%r13, %r12, %r12
	xorq	416(%rsp), %r12
	xorq	%rsi, %r12
	movq	%r12, 216(%rsp)
	movq	%r8, %r12
	movq	%rbp, %r13
	andnq	%r13, %r12, %r12
	xorq	%rdi, %r12
	movq	%r12, 224(%rsp)
	movq	%rbp, %r12
	movq	%rbx, %r13
	andnq	%r13, %r12, %r12
	xorq	%r8, %r12
	movq	%r12, 232(%rsp)
	movq	%rbx, %r8
	movq	%rsi, %r12
	andnq	%r12, %r8, %r8
	xorq	%rbp, %r8
	movq	%r8, 240(%rsp)
	andnq	%rdi, %rsi, %rsi
	xorq	%rbx, %rsi
	movq	%rsi, 248(%rsp)
	movq	24(%rsp), %rsi
	xorq	%rdx, %rsi
	rolq	$28, %rsi
	movq	72(%rsp), %rdi
	xorq	%rax, %rdi
	rolq	$20, %rdi
	movq	80(%rsp), %r8
	xorq	%r9, %r8
	rolq	$3, %r8
	movq	128(%rsp), %rbp
	xorq	%r10, %rbp
	rolq	$45, %rbp
	movq	176(%rsp), %rbx
	xorq	%r11, %rbx
	rolq	$61, %rbx
	movq	%rdi, %r12
	movq	%r8, %r13
	andnq	%r13, %r12, %r12
	xorq	%rsi, %r12
	movq	%r12, 256(%rsp)
	movq	%r8, %r12
	movq	%rbp, %r13
	andnq	%r13, %r12, %r12
	xorq	%rdi, %r12
	movq	%r12, 264(%rsp)
	movq	%rbp, %r12
	movq	%rbx, %r13
	andnq	%r13, %r12, %r12
	xorq	%r8, %r12
	movq	%r12, 272(%rsp)
	movq	%rbx, %r8
	movq	%rsi, %r12
	andnq	%r12, %r8, %r8
	xorq	%rbp, %r8
	movq	%r8, 280(%rsp)
	andnq	%rdi, %rsi, %rsi
	xorq	%rbx, %rsi
	movq	%rsi, 288(%rsp)
	movq	8(%rsp), %rsi
	xorq	%r10, %rsi
	rolq	$1, %rsi
	movq	56(%rsp), %rdi
	xorq	%r11, %rdi
	rolq	$6, %rdi
	movq	104(%rsp), %r8
	xorq	%rdx, %r8
	rolq	$25, %r8
	movq	152(%rsp), %rbp
	xorq	%rax, %rbp
	rolq	$8, %rbp
	movq	160(%rsp), %rbx
	xorq	%r9, %rbx
	rolq	$18, %rbx
	movq	%rdi, %r12
	movq	%r8, %r13
	andnq	%r13, %r12, %r12
	xorq	%rsi, %r12
	movq	%r12, 296(%rsp)
	movq	%r8, %r12
	movq	%rbp, %r13
	andnq	%r13, %r12, %r12
	xorq	%rdi, %r12
	movq	%r12, 304(%rsp)
	movq	%rbp, %r12
	movq	%rbx, %r13
	andnq	%r13, %r12, %r12
	xorq	%r8, %r12
	movq	%r12, 312(%rsp)
	movq	%rbx, %r8
	movq	%rsi, %r12
	andnq	%r12, %r8, %r8
	xorq	%rbp, %r8
	movq	%r8, 320(%rsp)
	andnq	%rdi, %rsi, %rsi
	xorq	%rbx, %rsi
	movq	%rsi, 328(%rsp)
	movq	32(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$27, %rsi
	movq	40(%rsp), %rdi
	xorq	%r9, %rdi
	rolq	$36, %rdi
	movq	88(%rsp), %r8
	xorq	%r10, %r8
	rolq	$10, %r8
	movq	136(%rsp), %rbp
	xorq	%r11, %rbp
	rolq	$15, %rbp
	movq	184(%rsp), %rbx
	xorq	%rdx, %rbx
	rolq	$56, %rbx
	movq	%rdi, %r12
	movq	%r8, %r13
	andnq	%r13, %r12, %r12
	xorq	%rsi, %r12
	movq	%r12, 336(%rsp)
	movq	%r8, %r12
	movq	%rbp, %r13
	andnq	%r13, %r12, %r12
	xorq	%rdi, %r12
	movq	%r12, 344(%rsp)
	movq	%rbp, %r12
	movq	%rbx, %r13
	andnq	%r13, %r12, %r12
	xorq	%r8, %r12
	movq	%r12, 352(%rsp)
	movq	%rbx, %r8
	movq	%rsi, %r12
	andnq	%r12, %r8, %r8
	xorq	%rbp, %r8
	movq	%r8, 360(%rsp)
	andnq	%rdi, %rsi, %rsi
	xorq	%rbx, %rsi
	movq	%rsi, 368(%rsp)
	movq	16(%rsp), %rsi
	xorq	%r11, %rsi
	rolq	$62, %rsi
	movq	64(%rsp), %rdi
	xorq	%rdx, %rdi
	rolq	$55, %rdi
	movq	%rdi, %rdx
	movq	112(%rsp), %rdi
	xorq	%rax, %rdi
	rolq	$39, %rdi
	movq	%rdi, %rax
	movq	120(%rsp), %rdi
	xorq	%r9, %rdi
	rolq	$41, %rdi
	movq	168(%rsp), %r8
	xorq	%r10, %r8
	rolq	$2, %r8
	movq	%rdx, %r9
	movq	%rax, %r10
	andnq	%r10, %r9, %r9
	xorq	%rsi, %r9
	movq	%r9, 376(%rsp)
	movq	%rax, %r9
	movq	%rdi, %r10
	andnq	%r10, %r9, %r9
	xorq	%rdx, %r9
	movq	%r9, 384(%rsp)
	movq	%rdi, %r9
	movq	%r8, %r10
	andnq	%r10, %r9, %r9
	xorq	%rax, %r9
	movq	%r9, 392(%rsp)
	movq	%r8, %rax
	movq	%rsi, %r9
	andnq	%r9, %rax, %rax
	xorq	%rdi, %rax
	movq	%rax, 400(%rsp)
	andnq	%rdx, %rsi, %rax
	xorq	%r8, %rax
	movq	%rax, 408(%rsp)
	movq	216(%rsp), %rax
	movq	%rax, (%rsp)
	movq	224(%rsp), %rax
	movq	%rax, 8(%rsp)
	movq	232(%rsp), %rax
	movq	%rax, 16(%rsp)
	movq	240(%rsp), %rax
	movq	%rax, 24(%rsp)
	movq	248(%rsp), %rax
	movq	%rax, 32(%rsp)
	movq	256(%rsp), %rax
	movq	%rax, 40(%rsp)
	movq	264(%rsp), %rax
	movq	%rax, 48(%rsp)
	movq	272(%rsp), %rax
	movq	%rax, 56(%rsp)
	movq	280(%rsp), %rax
	movq	%rax, 64(%rsp)
	movq	288(%rsp), %rax
	movq	%rax, 72(%rsp)
	movq	296(%rsp), %rax
	movq	%rax, 80(%rsp)
	movq	304(%rsp), %rax
	movq	%rax, 88(%rsp)
	movq	312(%rsp), %rax
	movq	%rax, 96(%rsp)
	movq	320(%rsp), %rax
	movq	%rax, 104(%rsp)
	movq	328(%rsp), %rax
	movq	%rax, 112(%rsp)
	movq	336(%rsp), %rax
	movq	%rax, 120(%rsp)
	movq	344(%rsp), %rax
	movq	%rax, 128(%rsp)
	movq	352(%rsp), %rax
	movq	%rax, 136(%rsp)
	movq	360(%rsp), %rax
	movq	%rax, 144(%rsp)
	movq	368(%rsp), %rax
	movq	%rax, 152(%rsp)
	movq	376(%rsp), %rax
	movq	%rax, 160(%rsp)
	movq	384(%rsp), %rax
	movq	%rax, 168(%rsp)
	movq	392(%rsp), %rax
	movq	%rax, 176(%rsp)
	movq	400(%rsp), %rax
	movq	%rax, 184(%rsp)
	movq	408(%rsp), %rax
	movq	%rax, 192(%rsp)
	leaq	8(%rcx), %rcx
	testb	$-1, %cl
	jne 	Lshake256_ref2x_jazz$19
	leaq	-192(%rcx), %rcx
	movq	208(%rsp), %rsi
	movq	200(%rsp), %rdx
Lshake256_ref2x_jazz$17:
	cmpq	$136, %rdx
	jnb 	Lshake256_ref2x_jazz$18
	movq	%rdx, %rax
	shrq	$3, %rax
	movq	$0, %rdi
	jmp 	Lshake256_ref2x_jazz$15
Lshake256_ref2x_jazz$16:
	movq	(%rsi,%rdi,8), %r8
	xorq	%r8, (%rsp,%rdi,8)
	leaq	1(%rdi), %rdi
Lshake256_ref2x_jazz$15:
	cmpq	%rax, %rdi
	jb  	Lshake256_ref2x_jazz$16
	shlq	$3, %rdi
	jmp 	Lshake256_ref2x_jazz$13
Lshake256_ref2x_jazz$14:
	movb	(%rsi,%rdi), %al
	xorb	%al, (%rsp,%rdi)
	leaq	1(%rdi), %rdi
Lshake256_ref2x_jazz$13:
	cmpq	%rdx, %rdi
	jb  	Lshake256_ref2x_jazz$14
	xorb	$31, (%rsp,%rdi)
	xorb	$-128, 135(%rsp)
Lshake256_ref2x_jazz$12:
	movq	(%rcx), %rax
	movq	%rax, 416(%rsp)
	movq	(%rsp), %rax
	xorq	40(%rsp), %rax
	xorq	80(%rsp), %rax
	xorq	120(%rsp), %rax
	xorq	160(%rsp), %rax
	movq	8(%rsp), %rdx
	xorq	48(%rsp), %rdx
	xorq	88(%rsp), %rdx
	xorq	128(%rsp), %rdx
	xorq	168(%rsp), %rdx
	movq	16(%rsp), %rsi
	xorq	56(%rsp), %rsi
	xorq	96(%rsp), %rsi
	xorq	136(%rsp), %rsi
	xorq	176(%rsp), %rsi
	movq	24(%rsp), %rdi
	xorq	64(%rsp), %rdi
	xorq	104(%rsp), %rdi
	xorq	144(%rsp), %rdi
	xorq	184(%rsp), %rdi
	movq	32(%rsp), %r8
	xorq	72(%rsp), %r8
	xorq	112(%rsp), %r8
	xorq	152(%rsp), %r8
	xorq	192(%rsp), %r8
	movq	%rdx, %r9
	rolq	$1, %r9
	xorq	%r8, %r9
	movq	%rsi, %r10
	rolq	$1, %r10
	xorq	%rax, %r10
	movq	%rdi, %r11
	rolq	$1, %r11
	xorq	%rdx, %r11
	movq	%r8, %rdx
	rolq	$1, %rdx
	xorq	%rsi, %rdx
	rolq	$1, %rax
	xorq	%rdi, %rax
	movq	(%rsp), %rsi
	xorq	%r9, %rsi
	movq	48(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$44, %rdi
	movq	96(%rsp), %r8
	xorq	%r11, %r8
	rolq	$43, %r8
	movq	144(%rsp), %rbp
	xorq	%rdx, %rbp
	rolq	$21, %rbp
	movq	192(%rsp), %rbx
	xorq	%rax, %rbx
	rolq	$14, %rbx
	movq	%rdi, %r12
	movq	%r8, %r13
	andnq	%r13, %r12, %r12
	xorq	416(%rsp), %r12
	xorq	%rsi, %r12
	movq	%r12, 216(%rsp)
	movq	%r8, %r12
	movq	%rbp, %r13
	andnq	%r13, %r12, %r12
	xorq	%rdi, %r12
	movq	%r12, 224(%rsp)
	movq	%rbp, %r12
	movq	%rbx, %r13
	andnq	%r13, %r12, %r12
	xorq	%r8, %r12
	movq	%r12, 232(%rsp)
	movq	%rbx, %r8
	movq	%rsi, %r12
	andnq	%r12, %r8, %r8
	xorq	%rbp, %r8
	movq	%r8, 240(%rsp)
	andnq	%rdi, %rsi, %rsi
	xorq	%rbx, %rsi
	movq	%rsi, 248(%rsp)
	movq	24(%rsp), %rsi
	xorq	%rdx, %rsi
	rolq	$28, %rsi
	movq	72(%rsp), %rdi
	xorq	%rax, %rdi
	rolq	$20, %rdi
	movq	80(%rsp), %r8
	xorq	%r9, %r8
	rolq	$3, %r8
	movq	128(%rsp), %rbp
	xorq	%r10, %rbp
	rolq	$45, %rbp
	movq	176(%rsp), %rbx
	xorq	%r11, %rbx
	rolq	$61, %rbx
	movq	%rdi, %r12
	movq	%r8, %r13
	andnq	%r13, %r12, %r12
	xorq	%rsi, %r12
	movq	%r12, 256(%rsp)
	movq	%r8, %r12
	movq	%rbp, %r13
	andnq	%r13, %r12, %r12
	xorq	%rdi, %r12
	movq	%r12, 264(%rsp)
	movq	%rbp, %r12
	movq	%rbx, %r13
	andnq	%r13, %r12, %r12
	xorq	%r8, %r12
	movq	%r12, 272(%rsp)
	movq	%rbx, %r8
	movq	%rsi, %r12
	andnq	%r12, %r8, %r8
	xorq	%rbp, %r8
	movq	%r8, 280(%rsp)
	andnq	%rdi, %rsi, %rsi
	xorq	%rbx, %rsi
	movq	%rsi, 288(%rsp)
	movq	8(%rsp), %rsi
	xorq	%r10, %rsi
	rolq	$1, %rsi
	movq	56(%rsp), %rdi
	xorq	%r11, %rdi
	rolq	$6, %rdi
	movq	104(%rsp), %r8
	xorq	%rdx, %r8
	rolq	$25, %r8
	movq	152(%rsp), %rbp
	xorq	%rax, %rbp
	rolq	$8, %rbp
	movq	160(%rsp), %rbx
	xorq	%r9, %rbx
	rolq	$18, %rbx
	movq	%rdi, %r12
	movq	%r8, %r13
	andnq	%r13, %r12, %r12
	xorq	%rsi, %r12
	movq	%r12, 296(%rsp)
	movq	%r8, %r12
	movq	%rbp, %r13
	andnq	%r13, %r12, %r12
	xorq	%rdi, %r12
	movq	%r12, 304(%rsp)
	movq	%rbp, %r12
	movq	%rbx, %r13
	andnq	%r13, %r12, %r12
	xorq	%r8, %r12
	movq	%r12, 312(%rsp)
	movq	%rbx, %r8
	movq	%rsi, %r12
	andnq	%r12, %r8, %r8
	xorq	%rbp, %r8
	movq	%r8, 320(%rsp)
	andnq	%rdi, %rsi, %rsi
	xorq	%rbx, %rsi
	movq	%rsi, 328(%rsp)
	movq	32(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$27, %rsi
	movq	40(%rsp), %rdi
	xorq	%r9, %rdi
	rolq	$36, %rdi
	movq	88(%rsp), %r8
	xorq	%r10, %r8
	rolq	$10, %r8
	movq	136(%rsp), %rbp
	xorq	%r11, %rbp
	rolq	$15, %rbp
	movq	184(%rsp), %rbx
	xorq	%rdx, %rbx
	rolq	$56, %rbx
	movq	%rdi, %r12
	movq	%r8, %r13
	andnq	%r13, %r12, %r12
	xorq	%rsi, %r12
	movq	%r12, 336(%rsp)
	movq	%r8, %r12
	movq	%rbp, %r13
	andnq	%r13, %r12, %r12
	xorq	%rdi, %r12
	movq	%r12, 344(%rsp)
	movq	%rbp, %r12
	movq	%rbx, %r13
	andnq	%r13, %r12, %r12
	xorq	%r8, %r12
	movq	%r12, 352(%rsp)
	movq	%rbx, %r8
	movq	%rsi, %r12
	andnq	%r12, %r8, %r8
	xorq	%rbp, %r8
	movq	%r8, 360(%rsp)
	andnq	%rdi, %rsi, %rsi
	xorq	%rbx, %rsi
	movq	%rsi, 368(%rsp)
	movq	16(%rsp), %rsi
	xorq	%r11, %rsi
	rolq	$62, %rsi
	movq	64(%rsp), %rdi
	xorq	%rdx, %rdi
	rolq	$55, %rdi
	movq	%rdi, %rdx
	movq	112(%rsp), %rdi
	xorq	%rax, %rdi
	rolq	$39, %rdi
	movq	%rdi, %rax
	movq	120(%rsp), %rdi
	xorq	%r9, %rdi
	rolq	$41, %rdi
	movq	168(%rsp), %r8
	xorq	%r10, %r8
	rolq	$2, %r8
	movq	%rdx, %r9
	movq	%rax, %r10
	andnq	%r10, %r9, %r9
	xorq	%rsi, %r9
	movq	%r9, 376(%rsp)
	movq	%rax, %r9
	movq	%rdi, %r10
	andnq	%r10, %r9, %r9
	xorq	%rdx, %r9
	movq	%r9, 384(%rsp)
	movq	%rdi, %r9
	movq	%r8, %r10
	andnq	%r10, %r9, %r9
	xorq	%rax, %r9
	movq	%r9, 392(%rsp)
	movq	%r8, %rax
	movq	%rsi, %r9
	andnq	%r9, %rax, %rax
	xorq	%rdi, %rax
	movq	%rax, 400(%rsp)
	andnq	%rdx, %rsi, %rax
	xorq	%r8, %rax
	movq	%rax, 408(%rsp)
	movq	216(%rsp), %rax
	movq	%rax, (%rsp)
	movq	224(%rsp), %rax
	movq	%rax, 8(%rsp)
	movq	232(%rsp), %rax
	movq	%rax, 16(%rsp)
	movq	240(%rsp), %rax
	movq	%rax, 24(%rsp)
	movq	248(%rsp), %rax
	movq	%rax, 32(%rsp)
	movq	256(%rsp), %rax
	movq	%rax, 40(%rsp)
	movq	264(%rsp), %rax
	movq	%rax, 48(%rsp)
	movq	272(%rsp), %rax
	movq	%rax, 56(%rsp)
	movq	280(%rsp), %rax
	movq	%rax, 64(%rsp)
	movq	288(%rsp), %rax
	movq	%rax, 72(%rsp)
	movq	296(%rsp), %rax
	movq	%rax, 80(%rsp)
	movq	304(%rsp), %rax
	movq	%rax, 88(%rsp)
	movq	312(%rsp), %rax
	movq	%rax, 96(%rsp)
	movq	320(%rsp), %rax
	movq	%rax, 104(%rsp)
	movq	328(%rsp), %rax
	movq	%rax, 112(%rsp)
	movq	336(%rsp), %rax
	movq	%rax, 120(%rsp)
	movq	344(%rsp), %rax
	movq	%rax, 128(%rsp)
	movq	352(%rsp), %rax
	movq	%rax, 136(%rsp)
	movq	360(%rsp), %rax
	movq	%rax, 144(%rsp)
	movq	368(%rsp), %rax
	movq	%rax, 152(%rsp)
	movq	376(%rsp), %rax
	movq	%rax, 160(%rsp)
	movq	384(%rsp), %rax
	movq	%rax, 168(%rsp)
	movq	392(%rsp), %rax
	movq	%rax, 176(%rsp)
	movq	400(%rsp), %rax
	movq	%rax, 184(%rsp)
	movq	408(%rsp), %rax
	movq	%rax, 192(%rsp)
	leaq	8(%rcx), %rcx
	testb	$-1, %cl
	jne 	Lshake256_ref2x_jazz$12
	leaq	-192(%rcx), %rax
	movq	424(%rsp), %rcx
	movq	$136, 208(%rsp)
	jmp 	Lshake256_ref2x_jazz$5
Lshake256_ref2x_jazz$6:
	movq	$136, %rdx
	movq	%rdx, %rsi
	shrq	$3, %rsi
	movq	$0, %rdi
	jmp 	Lshake256_ref2x_jazz$10
Lshake256_ref2x_jazz$11:
	movq	(%rsp,%rdi,8), %r8
	movq	%r8, (%rcx,%rdi,8)
	leaq	1(%rdi), %rdi
Lshake256_ref2x_jazz$10:
	cmpq	%rsi, %rdi
	jb  	Lshake256_ref2x_jazz$11
	shlq	$3, %rdi
	jmp 	Lshake256_ref2x_jazz$8
Lshake256_ref2x_jazz$9:
	movb	(%rsp,%rdi), %sil
	movb	%sil, (%rcx,%rdi)
	leaq	1(%rdi), %rdi
Lshake256_ref2x_jazz$8:
	cmpq	%rdx, %rdi
	jb  	Lshake256_ref2x_jazz$9
	leaq	(%rcx,%rdx), %rcx
	movq	%rcx, 424(%rsp)
Lshake256_ref2x_jazz$7:
	movq	(%rax), %rcx
	movq	%rcx, 416(%rsp)
	movq	(%rsp), %rcx
	xorq	40(%rsp), %rcx
	xorq	80(%rsp), %rcx
	xorq	120(%rsp), %rcx
	xorq	160(%rsp), %rcx
	movq	8(%rsp), %rdx
	xorq	48(%rsp), %rdx
	xorq	88(%rsp), %rdx
	xorq	128(%rsp), %rdx
	xorq	168(%rsp), %rdx
	movq	16(%rsp), %rsi
	xorq	56(%rsp), %rsi
	xorq	96(%rsp), %rsi
	xorq	136(%rsp), %rsi
	xorq	176(%rsp), %rsi
	movq	24(%rsp), %rdi
	xorq	64(%rsp), %rdi
	xorq	104(%rsp), %rdi
	xorq	144(%rsp), %rdi
	xorq	184(%rsp), %rdi
	movq	32(%rsp), %r8
	xorq	72(%rsp), %r8
	xorq	112(%rsp), %r8
	xorq	152(%rsp), %r8
	xorq	192(%rsp), %r8
	movq	%rdx, %r9
	rolq	$1, %r9
	xorq	%r8, %r9
	movq	%rsi, %r10
	rolq	$1, %r10
	xorq	%rcx, %r10
	movq	%rdi, %r11
	rolq	$1, %r11
	xorq	%rdx, %r11
	movq	%r8, %rdx
	rolq	$1, %rdx
	xorq	%rsi, %rdx
	rolq	$1, %rcx
	xorq	%rdi, %rcx
	movq	(%rsp), %rsi
	xorq	%r9, %rsi
	movq	48(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$44, %rdi
	movq	96(%rsp), %r8
	xorq	%r11, %r8
	rolq	$43, %r8
	movq	144(%rsp), %rbp
	xorq	%rdx, %rbp
	rolq	$21, %rbp
	movq	192(%rsp), %rbx
	xorq	%rcx, %rbx
	rolq	$14, %rbx
	movq	%rdi, %r12
	movq	%r8, %r13
	andnq	%r13, %r12, %r12
	xorq	416(%rsp), %r12
	xorq	%rsi, %r12
	movq	%r12, 216(%rsp)
	movq	%r8, %r12
	movq	%rbp, %r13
	andnq	%r13, %r12, %r12
	xorq	%rdi, %r12
	movq	%r12, 224(%rsp)
	movq	%rbp, %r12
	movq	%rbx, %r13
	andnq	%r13, %r12, %r12
	xorq	%r8, %r12
	movq	%r12, 232(%rsp)
	movq	%rbx, %r8
	movq	%rsi, %r12
	andnq	%r12, %r8, %r8
	xorq	%rbp, %r8
	movq	%r8, 240(%rsp)
	andnq	%rdi, %rsi, %rsi
	xorq	%rbx, %rsi
	movq	%rsi, 248(%rsp)
	movq	24(%rsp), %rsi
	xorq	%rdx, %rsi
	rolq	$28, %rsi
	movq	72(%rsp), %rdi
	xorq	%rcx, %rdi
	rolq	$20, %rdi
	movq	80(%rsp), %r8
	xorq	%r9, %r8
	rolq	$3, %r8
	movq	128(%rsp), %rbp
	xorq	%r10, %rbp
	rolq	$45, %rbp
	movq	176(%rsp), %rbx
	xorq	%r11, %rbx
	rolq	$61, %rbx
	movq	%rdi, %r12
	movq	%r8, %r13
	andnq	%r13, %r12, %r12
	xorq	%rsi, %r12
	movq	%r12, 256(%rsp)
	movq	%r8, %r12
	movq	%rbp, %r13
	andnq	%r13, %r12, %r12
	xorq	%rdi, %r12
	movq	%r12, 264(%rsp)
	movq	%rbp, %r12
	movq	%rbx, %r13
	andnq	%r13, %r12, %r12
	xorq	%r8, %r12
	movq	%r12, 272(%rsp)
	movq	%rbx, %r8
	movq	%rsi, %r12
	andnq	%r12, %r8, %r8
	xorq	%rbp, %r8
	movq	%r8, 280(%rsp)
	andnq	%rdi, %rsi, %rsi
	xorq	%rbx, %rsi
	movq	%rsi, 288(%rsp)
	movq	8(%rsp), %rsi
	xorq	%r10, %rsi
	rolq	$1, %rsi
	movq	56(%rsp), %rdi
	xorq	%r11, %rdi
	rolq	$6, %rdi
	movq	104(%rsp), %r8
	xorq	%rdx, %r8
	rolq	$25, %r8
	movq	152(%rsp), %rbp
	xorq	%rcx, %rbp
	rolq	$8, %rbp
	movq	160(%rsp), %rbx
	xorq	%r9, %rbx
	rolq	$18, %rbx
	movq	%rdi, %r12
	movq	%r8, %r13
	andnq	%r13, %r12, %r12
	xorq	%rsi, %r12
	movq	%r12, 296(%rsp)
	movq	%r8, %r12
	movq	%rbp, %r13
	andnq	%r13, %r12, %r12
	xorq	%rdi, %r12
	movq	%r12, 304(%rsp)
	movq	%rbp, %r12
	movq	%rbx, %r13
	andnq	%r13, %r12, %r12
	xorq	%r8, %r12
	movq	%r12, 312(%rsp)
	movq	%rbx, %r8
	movq	%rsi, %r12
	andnq	%r12, %r8, %r8
	xorq	%rbp, %r8
	movq	%r8, 320(%rsp)
	andnq	%rdi, %rsi, %rsi
	xorq	%rbx, %rsi
	movq	%rsi, 328(%rsp)
	movq	32(%rsp), %rsi
	xorq	%rcx, %rsi
	rolq	$27, %rsi
	movq	40(%rsp), %rdi
	xorq	%r9, %rdi
	rolq	$36, %rdi
	movq	88(%rsp), %r8
	xorq	%r10, %r8
	rolq	$10, %r8
	movq	136(%rsp), %rbp
	xorq	%r11, %rbp
	rolq	$15, %rbp
	movq	184(%rsp), %rbx
	xorq	%rdx, %rbx
	rolq	$56, %rbx
	movq	%rdi, %r12
	movq	%r8, %r13
	andnq	%r13, %r12, %r12
	xorq	%rsi, %r12
	movq	%r12, 336(%rsp)
	movq	%r8, %r12
	movq	%rbp, %r13
	andnq	%r13, %r12, %r12
	xorq	%rdi, %r12
	movq	%r12, 344(%rsp)
	movq	%rbp, %r12
	movq	%rbx, %r13
	andnq	%r13, %r12, %r12
	xorq	%r8, %r12
	movq	%r12, 352(%rsp)
	movq	%rbx, %r8
	movq	%rsi, %r12
	andnq	%r12, %r8, %r8
	xorq	%rbp, %r8
	movq	%r8, 360(%rsp)
	andnq	%rdi, %rsi, %rsi
	xorq	%rbx, %rsi
	movq	%rsi, 368(%rsp)
	movq	16(%rsp), %rsi
	xorq	%r11, %rsi
	rolq	$62, %rsi
	movq	64(%rsp), %rdi
	xorq	%rdx, %rdi
	rolq	$55, %rdi
	movq	%rdi, %rdx
	movq	112(%rsp), %rdi
	xorq	%rcx, %rdi
	rolq	$39, %rdi
	movq	%rdi, %rcx
	movq	120(%rsp), %rdi
	xorq	%r9, %rdi
	rolq	$41, %rdi
	movq	168(%rsp), %r8
	xorq	%r10, %r8
	rolq	$2, %r8
	movq	%rdx, %r9
	movq	%rcx, %r10
	andnq	%r10, %r9, %r9
	xorq	%rsi, %r9
	movq	%r9, 376(%rsp)
	movq	%rcx, %r9
	movq	%rdi, %r10
	andnq	%r10, %r9, %r9
	xorq	%rdx, %r9
	movq	%r9, 384(%rsp)
	movq	%rdi, %r9
	movq	%r8, %r10
	andnq	%r10, %r9, %r9
	xorq	%rcx, %r9
	movq	%r9, 392(%rsp)
	movq	%r8, %rcx
	movq	%rsi, %r9
	andnq	%r9, %rcx, %rcx
	xorq	%rdi, %rcx
	movq	%rcx, 400(%rsp)
	andnq	%rdx, %rsi, %rcx
	xorq	%r8, %rcx
	movq	%rcx, 408(%rsp)
	movq	216(%rsp), %rcx
	movq	%rcx, (%rsp)
	movq	224(%rsp), %rcx
	movq	%rcx, 8(%rsp)
	movq	232(%rsp), %rcx
	movq	%rcx, 16(%rsp)
	movq	240(%rsp), %rcx
	movq	%rcx, 24(%rsp)
	movq	248(%rsp), %rcx
	movq	%rcx, 32(%rsp)
	movq	256(%rsp), %rcx
	movq	%rcx, 40(%rsp)
	movq	264(%rsp), %rcx
	movq	%rcx, 48(%rsp)
	movq	272(%rsp), %rcx
	movq	%rcx, 56(%rsp)
	movq	280(%rsp), %rcx
	movq	%rcx, 64(%rsp)
	movq	288(%rsp), %rcx
	movq	%rcx, 72(%rsp)
	movq	296(%rsp), %rcx
	movq	%rcx, 80(%rsp)
	movq	304(%rsp), %rcx
	movq	%rcx, 88(%rsp)
	movq	312(%rsp), %rcx
	movq	%rcx, 96(%rsp)
	movq	320(%rsp), %rcx
	movq	%rcx, 104(%rsp)
	movq	328(%rsp), %rcx
	movq	%rcx, 112(%rsp)
	movq	336(%rsp), %rcx
	movq	%rcx, 120(%rsp)
	movq	344(%rsp), %rcx
	movq	%rcx, 128(%rsp)
	movq	352(%rsp), %rcx
	movq	%rcx, 136(%rsp)
	movq	360(%rsp), %rcx
	movq	%rcx, 144(%rsp)
	movq	368(%rsp), %rcx
	movq	%rcx, 152(%rsp)
	movq	376(%rsp), %rcx
	movq	%rcx, 160(%rsp)
	movq	384(%rsp), %rcx
	movq	%rcx, 168(%rsp)
	movq	392(%rsp), %rcx
	movq	%rcx, 176(%rsp)
	movq	400(%rsp), %rcx
	movq	%rcx, 184(%rsp)
	movq	408(%rsp), %rcx
	movq	%rcx, 192(%rsp)
	leaq	8(%rax), %rax
	testb	$-1, %al
	jne 	Lshake256_ref2x_jazz$7
	leaq	-192(%rax), %rax
	subq	$136, 208(%rsp)
	movq	424(%rsp), %rcx
Lshake256_ref2x_jazz$5:
	cmpq	$136, 208(%rsp)
	jnb 	Lshake256_ref2x_jazz$6
	movq	208(%rsp), %rax
	movq	%rax, %rdx
	shrq	$3, %rdx
	movq	$0, %rsi
	jmp 	Lshake256_ref2x_jazz$3
Lshake256_ref2x_jazz$4:
	movq	(%rsp,%rsi,8), %rdi
	movq	%rdi, (%rcx,%rsi,8)
	leaq	1(%rsi), %rsi
Lshake256_ref2x_jazz$3:
	cmpq	%rdx, %rsi
	jb  	Lshake256_ref2x_jazz$4
	shlq	$3, %rsi
	jmp 	Lshake256_ref2x_jazz$1
Lshake256_ref2x_jazz$2:
	movb	(%rsp,%rsi), %dl
	movb	%dl, (%rcx,%rsi)
	leaq	1(%rsi), %rsi
Lshake256_ref2x_jazz$1:
	cmpq	%rax, %rsi
	jb  	Lshake256_ref2x_jazz$2
	addq	$432, %rsp
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	ret 

	.text
	.p2align	5
	.globl	_sha3384_ref2x_jazz
	.globl	sha3384_ref2x_jazz
_sha3384_ref2x_jazz:
sha3384_ref2x_jazz:
	pushq	%rbp
	pushq	%rbx
	pushq	%r12
	subq	$432, %rsp
	movq	%rdi, 424(%rsp)
	xorl	%eax, %eax
	movq	$0, %rdi
	jmp 	Lsha3384_ref2x_jazz$13
Lsha3384_ref2x_jazz$14:
	movq	%rax, (%rsp,%rdi,8)
	leaq	1(%rdi), %rdi
Lsha3384_ref2x_jazz$13:
	cmpq	$50, %rdi
	jb  	Lsha3384_ref2x_jazz$14
	jmp 	Lsha3384_ref2x_jazz$10
Lsha3384_ref2x_jazz$11:
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
	leaq	104(%rsi), %rax
	leaq	-104(%rdx), %rdx
	movq	%rax, 208(%rsp)
	movq	%rdx, 200(%rsp)
Lsha3384_ref2x_jazz$12:
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
	andnq	%r8, %rdi, %r12
	xorq	416(%rsp), %r12
	xorq	%rsi, %r12
	movq	%r12, 216(%rsp)
	andnq	%rbp, %r8, %r12
	xorq	%rdi, %r12
	movq	%r12, 224(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%r8, %r12
	movq	%r12, 232(%rsp)
	andnq	%rsi, %rbx, %r8
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
	andnq	%r8, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 256(%rsp)
	andnq	%rbp, %r8, %r12
	xorq	%rdi, %r12
	movq	%r12, 264(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%r8, %r12
	movq	%r12, 272(%rsp)
	andnq	%rsi, %rbx, %r8
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
	andnq	%r8, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 296(%rsp)
	andnq	%rbp, %r8, %r12
	xorq	%rdi, %r12
	movq	%r12, 304(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%r8, %r12
	movq	%r12, 312(%rsp)
	andnq	%rsi, %rbx, %r8
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
	andnq	%r8, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 336(%rsp)
	andnq	%rbp, %r8, %r12
	xorq	%rdi, %r12
	movq	%r12, 344(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%r8, %r12
	movq	%r12, 352(%rsp)
	andnq	%rsi, %rbx, %r8
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
	andnq	%rax, %rdx, %r9
	xorq	%rsi, %r9
	movq	%r9, 376(%rsp)
	andnq	%rdi, %rax, %r9
	xorq	%rdx, %r9
	movq	%r9, 384(%rsp)
	andnq	%r8, %rdi, %r9
	xorq	%rax, %r9
	movq	%r9, 392(%rsp)
	andnq	%rsi, %r8, %rax
	xorq	%rdi, %rax
	movq	%rax, 400(%rsp)
	andnq	%rdx, %rsi, %rax
	xorq	%r8, %rax
	movq	%rax, 408(%rsp)
	movq	8(%rcx), %rax
	movq	%rax, 416(%rsp)
	movq	216(%rsp), %rax
	xorq	256(%rsp), %rax
	xorq	296(%rsp), %rax
	xorq	336(%rsp), %rax
	xorq	376(%rsp), %rax
	movq	224(%rsp), %rdx
	xorq	264(%rsp), %rdx
	xorq	304(%rsp), %rdx
	xorq	344(%rsp), %rdx
	xorq	384(%rsp), %rdx
	movq	232(%rsp), %rsi
	xorq	272(%rsp), %rsi
	xorq	312(%rsp), %rsi
	xorq	352(%rsp), %rsi
	xorq	392(%rsp), %rsi
	movq	240(%rsp), %rdi
	xorq	280(%rsp), %rdi
	xorq	320(%rsp), %rdi
	xorq	360(%rsp), %rdi
	xorq	400(%rsp), %rdi
	movq	248(%rsp), %r8
	xorq	288(%rsp), %r8
	xorq	328(%rsp), %r8
	xorq	368(%rsp), %r8
	xorq	408(%rsp), %r8
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
	movq	216(%rsp), %rsi
	xorq	%r9, %rsi
	movq	264(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$44, %rdi
	movq	312(%rsp), %r8
	xorq	%r11, %r8
	rolq	$43, %r8
	movq	360(%rsp), %rbp
	xorq	%rdx, %rbp
	rolq	$21, %rbp
	movq	408(%rsp), %rbx
	xorq	%rax, %rbx
	rolq	$14, %rbx
	andnq	%r8, %rdi, %r12
	xorq	416(%rsp), %r12
	xorq	%rsi, %r12
	movq	%r12, (%rsp)
	andnq	%rbp, %r8, %r12
	xorq	%rdi, %r12
	movq	%r12, 8(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%r8, %r12
	movq	%r12, 16(%rsp)
	andnq	%rsi, %rbx, %r8
	xorq	%rbp, %r8
	movq	%r8, 24(%rsp)
	andnq	%rdi, %rsi, %rsi
	xorq	%rbx, %rsi
	movq	%rsi, 32(%rsp)
	movq	240(%rsp), %rsi
	xorq	%rdx, %rsi
	rolq	$28, %rsi
	movq	288(%rsp), %rdi
	xorq	%rax, %rdi
	rolq	$20, %rdi
	movq	296(%rsp), %r8
	xorq	%r9, %r8
	rolq	$3, %r8
	movq	344(%rsp), %rbp
	xorq	%r10, %rbp
	rolq	$45, %rbp
	movq	392(%rsp), %rbx
	xorq	%r11, %rbx
	rolq	$61, %rbx
	andnq	%r8, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 40(%rsp)
	andnq	%rbp, %r8, %r12
	xorq	%rdi, %r12
	movq	%r12, 48(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%r8, %r12
	movq	%r12, 56(%rsp)
	andnq	%rsi, %rbx, %r8
	xorq	%rbp, %r8
	movq	%r8, 64(%rsp)
	andnq	%rdi, %rsi, %rsi
	xorq	%rbx, %rsi
	movq	%rsi, 72(%rsp)
	movq	224(%rsp), %rsi
	xorq	%r10, %rsi
	rolq	$1, %rsi
	movq	272(%rsp), %rdi
	xorq	%r11, %rdi
	rolq	$6, %rdi
	movq	320(%rsp), %r8
	xorq	%rdx, %r8
	rolq	$25, %r8
	movq	368(%rsp), %rbp
	xorq	%rax, %rbp
	rolq	$8, %rbp
	movq	376(%rsp), %rbx
	xorq	%r9, %rbx
	rolq	$18, %rbx
	andnq	%r8, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 80(%rsp)
	andnq	%rbp, %r8, %r12
	xorq	%rdi, %r12
	movq	%r12, 88(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%r8, %r12
	movq	%r12, 96(%rsp)
	andnq	%rsi, %rbx, %r8
	xorq	%rbp, %r8
	movq	%r8, 104(%rsp)
	andnq	%rdi, %rsi, %rsi
	xorq	%rbx, %rsi
	movq	%rsi, 112(%rsp)
	movq	248(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$27, %rsi
	movq	256(%rsp), %rdi
	xorq	%r9, %rdi
	rolq	$36, %rdi
	movq	304(%rsp), %r8
	xorq	%r10, %r8
	rolq	$10, %r8
	movq	352(%rsp), %rbp
	xorq	%r11, %rbp
	rolq	$15, %rbp
	movq	400(%rsp), %rbx
	xorq	%rdx, %rbx
	rolq	$56, %rbx
	andnq	%r8, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 120(%rsp)
	andnq	%rbp, %r8, %r12
	xorq	%rdi, %r12
	movq	%r12, 128(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%r8, %r12
	movq	%r12, 136(%rsp)
	andnq	%rsi, %rbx, %r8
	xorq	%rbp, %r8
	movq	%r8, 144(%rsp)
	andnq	%rdi, %rsi, %rsi
	xorq	%rbx, %rsi
	movq	%rsi, 152(%rsp)
	movq	232(%rsp), %rsi
	xorq	%r11, %rsi
	rolq	$62, %rsi
	movq	280(%rsp), %rdi
	xorq	%rdx, %rdi
	rolq	$55, %rdi
	movq	%rdi, %rdx
	movq	328(%rsp), %rdi
	xorq	%rax, %rdi
	rolq	$39, %rdi
	movq	%rdi, %rax
	movq	336(%rsp), %rdi
	xorq	%r9, %rdi
	rolq	$41, %rdi
	movq	384(%rsp), %r8
	xorq	%r10, %r8
	rolq	$2, %r8
	andnq	%rax, %rdx, %r9
	xorq	%rsi, %r9
	movq	%r9, 160(%rsp)
	andnq	%rdi, %rax, %r9
	xorq	%rdx, %r9
	movq	%r9, 168(%rsp)
	andnq	%r8, %rdi, %r9
	xorq	%rax, %r9
	movq	%r9, 176(%rsp)
	andnq	%rsi, %r8, %rax
	xorq	%rdi, %rax
	movq	%rax, 184(%rsp)
	andnq	%rdx, %rsi, %rax
	xorq	%r8, %rax
	movq	%rax, 192(%rsp)
	leaq	16(%rcx), %rcx
	testb	$-1, %cl
	jne 	Lsha3384_ref2x_jazz$12
	leaq	-192(%rcx), %rcx
	movq	208(%rsp), %rsi
	movq	200(%rsp), %rdx
Lsha3384_ref2x_jazz$10:
	cmpq	$104, %rdx
	jnb 	Lsha3384_ref2x_jazz$11
	movq	%rdx, %rax
	shrq	$3, %rax
	movq	$0, %rdi
	jmp 	Lsha3384_ref2x_jazz$8
Lsha3384_ref2x_jazz$9:
	movq	(%rsi,%rdi,8), %r8
	xorq	%r8, (%rsp,%rdi,8)
	leaq	1(%rdi), %rdi
Lsha3384_ref2x_jazz$8:
	cmpq	%rax, %rdi
	jb  	Lsha3384_ref2x_jazz$9
	shlq	$3, %rdi
	jmp 	Lsha3384_ref2x_jazz$6
Lsha3384_ref2x_jazz$7:
	movb	(%rsi,%rdi), %al
	xorb	%al, (%rsp,%rdi)
	leaq	1(%rdi), %rdi
Lsha3384_ref2x_jazz$6:
	cmpq	%rdx, %rdi
	jb  	Lsha3384_ref2x_jazz$7
	xorb	$6, (%rsp,%rdi)
	xorb	$-128, 103(%rsp)
Lsha3384_ref2x_jazz$5:
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
	andnq	%r8, %rdi, %r12
	xorq	416(%rsp), %r12
	xorq	%rsi, %r12
	movq	%r12, 216(%rsp)
	andnq	%rbp, %r8, %r12
	xorq	%rdi, %r12
	movq	%r12, 224(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%r8, %r12
	movq	%r12, 232(%rsp)
	andnq	%rsi, %rbx, %r8
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
	andnq	%r8, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 256(%rsp)
	andnq	%rbp, %r8, %r12
	xorq	%rdi, %r12
	movq	%r12, 264(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%r8, %r12
	movq	%r12, 272(%rsp)
	andnq	%rsi, %rbx, %r8
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
	andnq	%r8, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 296(%rsp)
	andnq	%rbp, %r8, %r12
	xorq	%rdi, %r12
	movq	%r12, 304(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%r8, %r12
	movq	%r12, 312(%rsp)
	andnq	%rsi, %rbx, %r8
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
	andnq	%r8, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 336(%rsp)
	andnq	%rbp, %r8, %r12
	xorq	%rdi, %r12
	movq	%r12, 344(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%r8, %r12
	movq	%r12, 352(%rsp)
	andnq	%rsi, %rbx, %r8
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
	andnq	%rax, %rdx, %r9
	xorq	%rsi, %r9
	movq	%r9, 376(%rsp)
	andnq	%rdi, %rax, %r9
	xorq	%rdx, %r9
	movq	%r9, 384(%rsp)
	andnq	%r8, %rdi, %r9
	xorq	%rax, %r9
	movq	%r9, 392(%rsp)
	andnq	%rsi, %r8, %rax
	xorq	%rdi, %rax
	movq	%rax, 400(%rsp)
	andnq	%rdx, %rsi, %rax
	xorq	%r8, %rax
	movq	%rax, 408(%rsp)
	movq	8(%rcx), %rax
	movq	%rax, 416(%rsp)
	movq	216(%rsp), %rax
	xorq	256(%rsp), %rax
	xorq	296(%rsp), %rax
	xorq	336(%rsp), %rax
	xorq	376(%rsp), %rax
	movq	224(%rsp), %rdx
	xorq	264(%rsp), %rdx
	xorq	304(%rsp), %rdx
	xorq	344(%rsp), %rdx
	xorq	384(%rsp), %rdx
	movq	232(%rsp), %rsi
	xorq	272(%rsp), %rsi
	xorq	312(%rsp), %rsi
	xorq	352(%rsp), %rsi
	xorq	392(%rsp), %rsi
	movq	240(%rsp), %rdi
	xorq	280(%rsp), %rdi
	xorq	320(%rsp), %rdi
	xorq	360(%rsp), %rdi
	xorq	400(%rsp), %rdi
	movq	248(%rsp), %r8
	xorq	288(%rsp), %r8
	xorq	328(%rsp), %r8
	xorq	368(%rsp), %r8
	xorq	408(%rsp), %r8
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
	movq	216(%rsp), %rsi
	xorq	%r9, %rsi
	movq	264(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$44, %rdi
	movq	312(%rsp), %r8
	xorq	%r11, %r8
	rolq	$43, %r8
	movq	360(%rsp), %rbp
	xorq	%rdx, %rbp
	rolq	$21, %rbp
	movq	408(%rsp), %rbx
	xorq	%rax, %rbx
	rolq	$14, %rbx
	andnq	%r8, %rdi, %r12
	xorq	416(%rsp), %r12
	xorq	%rsi, %r12
	movq	%r12, (%rsp)
	andnq	%rbp, %r8, %r12
	xorq	%rdi, %r12
	movq	%r12, 8(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%r8, %r12
	movq	%r12, 16(%rsp)
	andnq	%rsi, %rbx, %r8
	xorq	%rbp, %r8
	movq	%r8, 24(%rsp)
	andnq	%rdi, %rsi, %rsi
	xorq	%rbx, %rsi
	movq	%rsi, 32(%rsp)
	movq	240(%rsp), %rsi
	xorq	%rdx, %rsi
	rolq	$28, %rsi
	movq	288(%rsp), %rdi
	xorq	%rax, %rdi
	rolq	$20, %rdi
	movq	296(%rsp), %r8
	xorq	%r9, %r8
	rolq	$3, %r8
	movq	344(%rsp), %rbp
	xorq	%r10, %rbp
	rolq	$45, %rbp
	movq	392(%rsp), %rbx
	xorq	%r11, %rbx
	rolq	$61, %rbx
	andnq	%r8, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 40(%rsp)
	andnq	%rbp, %r8, %r12
	xorq	%rdi, %r12
	movq	%r12, 48(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%r8, %r12
	movq	%r12, 56(%rsp)
	andnq	%rsi, %rbx, %r8
	xorq	%rbp, %r8
	movq	%r8, 64(%rsp)
	andnq	%rdi, %rsi, %rsi
	xorq	%rbx, %rsi
	movq	%rsi, 72(%rsp)
	movq	224(%rsp), %rsi
	xorq	%r10, %rsi
	rolq	$1, %rsi
	movq	272(%rsp), %rdi
	xorq	%r11, %rdi
	rolq	$6, %rdi
	movq	320(%rsp), %r8
	xorq	%rdx, %r8
	rolq	$25, %r8
	movq	368(%rsp), %rbp
	xorq	%rax, %rbp
	rolq	$8, %rbp
	movq	376(%rsp), %rbx
	xorq	%r9, %rbx
	rolq	$18, %rbx
	andnq	%r8, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 80(%rsp)
	andnq	%rbp, %r8, %r12
	xorq	%rdi, %r12
	movq	%r12, 88(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%r8, %r12
	movq	%r12, 96(%rsp)
	andnq	%rsi, %rbx, %r8
	xorq	%rbp, %r8
	movq	%r8, 104(%rsp)
	andnq	%rdi, %rsi, %rsi
	xorq	%rbx, %rsi
	movq	%rsi, 112(%rsp)
	movq	248(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$27, %rsi
	movq	256(%rsp), %rdi
	xorq	%r9, %rdi
	rolq	$36, %rdi
	movq	304(%rsp), %r8
	xorq	%r10, %r8
	rolq	$10, %r8
	movq	352(%rsp), %rbp
	xorq	%r11, %rbp
	rolq	$15, %rbp
	movq	400(%rsp), %rbx
	xorq	%rdx, %rbx
	rolq	$56, %rbx
	andnq	%r8, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 120(%rsp)
	andnq	%rbp, %r8, %r12
	xorq	%rdi, %r12
	movq	%r12, 128(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%r8, %r12
	movq	%r12, 136(%rsp)
	andnq	%rsi, %rbx, %r8
	xorq	%rbp, %r8
	movq	%r8, 144(%rsp)
	andnq	%rdi, %rsi, %rsi
	xorq	%rbx, %rsi
	movq	%rsi, 152(%rsp)
	movq	232(%rsp), %rsi
	xorq	%r11, %rsi
	rolq	$62, %rsi
	movq	280(%rsp), %rdi
	xorq	%rdx, %rdi
	rolq	$55, %rdi
	movq	%rdi, %rdx
	movq	328(%rsp), %rdi
	xorq	%rax, %rdi
	rolq	$39, %rdi
	movq	%rdi, %rax
	movq	336(%rsp), %rdi
	xorq	%r9, %rdi
	rolq	$41, %rdi
	movq	384(%rsp), %r8
	xorq	%r10, %r8
	rolq	$2, %r8
	andnq	%rax, %rdx, %r9
	xorq	%rsi, %r9
	movq	%r9, 160(%rsp)
	andnq	%rdi, %rax, %r9
	xorq	%rdx, %r9
	movq	%r9, 168(%rsp)
	andnq	%r8, %rdi, %r9
	xorq	%rax, %r9
	movq	%r9, 176(%rsp)
	andnq	%rsi, %r8, %rax
	xorq	%rdi, %rax
	movq	%rax, 184(%rsp)
	andnq	%rdx, %rsi, %rax
	xorq	%r8, %rax
	movq	%rax, 192(%rsp)
	leaq	16(%rcx), %rcx
	testb	$-1, %cl
	jne 	Lsha3384_ref2x_jazz$5
	movq	424(%rsp), %rax
	movq	$48, 424(%rsp)
	movq	424(%rsp), %rcx
	movq	%rcx, %rdx
	shrq	$3, %rdx
	movq	$0, %rsi
	jmp 	Lsha3384_ref2x_jazz$3
Lsha3384_ref2x_jazz$4:
	movq	(%rsp,%rsi,8), %rdi
	movq	%rdi, (%rax,%rsi,8)
	leaq	1(%rsi), %rsi
Lsha3384_ref2x_jazz$3:
	cmpq	%rdx, %rsi
	jb  	Lsha3384_ref2x_jazz$4
	shlq	$3, %rsi
	jmp 	Lsha3384_ref2x_jazz$1
Lsha3384_ref2x_jazz$2:
	movb	(%rsp,%rsi), %dl
	movb	%dl, (%rax,%rsi)
	leaq	1(%rsi), %rsi
Lsha3384_ref2x_jazz$1:
	cmpq	%rcx, %rsi
	jb  	Lsha3384_ref2x_jazz$2
	addq	$432, %rsp
	popq	%r12
	popq	%rbx
	popq	%rbp
	ret 

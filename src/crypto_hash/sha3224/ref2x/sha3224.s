	.text
	.p2align	5
	.globl	_sha3224_ref2x_jazz
	.globl	sha3224_ref2x_jazz
_sha3224_ref2x_jazz:
sha3224_ref2x_jazz:
	pushq	%rbp
	pushq	%rbx
	pushq	%r12
	subq	$440, %rsp
	movq	$28, %rax
	movq	%rcx, %r8
	movq	%rdi, 432(%rsp)
	movq	%rax, 200(%rsp)
	xorl	%eax, %eax
	movq	$0, %rcx
	jmp 	Lsha3224_ref2x_jazz$22
Lsha3224_ref2x_jazz$23:
	movq	%rax, (%rsp,%rcx,8)
	leaq	1(%rcx), %rcx
Lsha3224_ref2x_jazz$22:
	cmpq	$25, %rcx
	jb  	Lsha3224_ref2x_jazz$23
	jmp 	Lsha3224_ref2x_jazz$19
Lsha3224_ref2x_jazz$20:
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
	movq	136(%rsi), %rax
	xorq	%rax, 136(%rsp)
	leaq	144(%rsi), %rax
	leaq	-144(%rdx), %rcx
	movq	%rax, 216(%rsp)
	movq	%rcx, 208(%rsp)
Lsha3224_ref2x_jazz$21:
	movq	(%r8), %rax
	movq	%rax, 424(%rsp)
	movq	(%rsp), %rax
	xorq	40(%rsp), %rax
	xorq	80(%rsp), %rax
	xorq	120(%rsp), %rax
	xorq	160(%rsp), %rax
	movq	8(%rsp), %rcx
	xorq	48(%rsp), %rcx
	xorq	88(%rsp), %rcx
	xorq	128(%rsp), %rcx
	xorq	168(%rsp), %rcx
	movq	16(%rsp), %rdx
	xorq	56(%rsp), %rdx
	xorq	96(%rsp), %rdx
	xorq	136(%rsp), %rdx
	xorq	176(%rsp), %rdx
	movq	24(%rsp), %rsi
	xorq	64(%rsp), %rsi
	xorq	104(%rsp), %rsi
	xorq	144(%rsp), %rsi
	xorq	184(%rsp), %rsi
	movq	32(%rsp), %rdi
	xorq	72(%rsp), %rdi
	xorq	112(%rsp), %rdi
	xorq	152(%rsp), %rdi
	xorq	192(%rsp), %rdi
	movq	%rcx, %r9
	rolq	$1, %r9
	xorq	%rdi, %r9
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
	movq	(%rsp), %rdx
	xorq	%r9, %rdx
	movq	48(%rsp), %rsi
	xorq	%r10, %rsi
	rolq	$44, %rsi
	movq	96(%rsp), %rdi
	xorq	%r11, %rdi
	rolq	$43, %rdi
	movq	144(%rsp), %rbp
	xorq	%rcx, %rbp
	rolq	$21, %rbp
	movq	192(%rsp), %rbx
	xorq	%rax, %rbx
	rolq	$14, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	424(%rsp), %r12
	xorq	%rdx, %r12
	movq	%r12, 224(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 232(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 240(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 248(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 256(%rsp)
	movq	24(%rsp), %rdx
	xorq	%rcx, %rdx
	rolq	$28, %rdx
	movq	72(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$20, %rsi
	movq	80(%rsp), %rdi
	xorq	%r9, %rdi
	rolq	$3, %rdi
	movq	128(%rsp), %rbp
	xorq	%r10, %rbp
	rolq	$45, %rbp
	movq	176(%rsp), %rbx
	xorq	%r11, %rbx
	rolq	$61, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 264(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 272(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 280(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 288(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 296(%rsp)
	movq	8(%rsp), %rdx
	xorq	%r10, %rdx
	rolq	$1, %rdx
	movq	56(%rsp), %rsi
	xorq	%r11, %rsi
	rolq	$6, %rsi
	movq	104(%rsp), %rdi
	xorq	%rcx, %rdi
	rolq	$25, %rdi
	movq	152(%rsp), %rbp
	xorq	%rax, %rbp
	rolq	$8, %rbp
	movq	160(%rsp), %rbx
	xorq	%r9, %rbx
	rolq	$18, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 304(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 312(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 320(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 328(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 336(%rsp)
	movq	32(%rsp), %rdx
	xorq	%rax, %rdx
	rolq	$27, %rdx
	movq	40(%rsp), %rsi
	xorq	%r9, %rsi
	rolq	$36, %rsi
	movq	88(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$10, %rdi
	movq	136(%rsp), %rbp
	xorq	%r11, %rbp
	rolq	$15, %rbp
	movq	184(%rsp), %rbx
	xorq	%rcx, %rbx
	rolq	$56, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 344(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 352(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 360(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 368(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 376(%rsp)
	movq	16(%rsp), %rdx
	xorq	%r11, %rdx
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
	xorq	%r9, %rsi
	rolq	$41, %rsi
	movq	168(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$2, %rdi
	andnq	%rax, %rcx, %r9
	xorq	%rdx, %r9
	movq	%r9, 384(%rsp)
	andnq	%rsi, %rax, %r9
	xorq	%rcx, %r9
	movq	%r9, 392(%rsp)
	andnq	%rdi, %rsi, %r9
	xorq	%rax, %r9
	movq	%r9, 400(%rsp)
	andnq	%rdx, %rdi, %rax
	xorq	%rsi, %rax
	movq	%rax, 408(%rsp)
	andnq	%rcx, %rdx, %rax
	xorq	%rdi, %rax
	movq	%rax, 416(%rsp)
	movq	8(%r8), %rax
	movq	%rax, 424(%rsp)
	movq	224(%rsp), %rax
	xorq	264(%rsp), %rax
	xorq	304(%rsp), %rax
	xorq	344(%rsp), %rax
	xorq	384(%rsp), %rax
	movq	232(%rsp), %rcx
	xorq	272(%rsp), %rcx
	xorq	312(%rsp), %rcx
	xorq	352(%rsp), %rcx
	xorq	392(%rsp), %rcx
	movq	240(%rsp), %rdx
	xorq	280(%rsp), %rdx
	xorq	320(%rsp), %rdx
	xorq	360(%rsp), %rdx
	xorq	400(%rsp), %rdx
	movq	248(%rsp), %rsi
	xorq	288(%rsp), %rsi
	xorq	328(%rsp), %rsi
	xorq	368(%rsp), %rsi
	xorq	408(%rsp), %rsi
	movq	256(%rsp), %rdi
	xorq	296(%rsp), %rdi
	xorq	336(%rsp), %rdi
	xorq	376(%rsp), %rdi
	xorq	416(%rsp), %rdi
	movq	%rcx, %r9
	rolq	$1, %r9
	xorq	%rdi, %r9
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
	movq	224(%rsp), %rdx
	xorq	%r9, %rdx
	movq	272(%rsp), %rsi
	xorq	%r10, %rsi
	rolq	$44, %rsi
	movq	320(%rsp), %rdi
	xorq	%r11, %rdi
	rolq	$43, %rdi
	movq	368(%rsp), %rbp
	xorq	%rcx, %rbp
	rolq	$21, %rbp
	movq	416(%rsp), %rbx
	xorq	%rax, %rbx
	rolq	$14, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	424(%rsp), %r12
	xorq	%rdx, %r12
	movq	%r12, (%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 8(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 16(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 24(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 32(%rsp)
	movq	248(%rsp), %rdx
	xorq	%rcx, %rdx
	rolq	$28, %rdx
	movq	296(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$20, %rsi
	movq	304(%rsp), %rdi
	xorq	%r9, %rdi
	rolq	$3, %rdi
	movq	352(%rsp), %rbp
	xorq	%r10, %rbp
	rolq	$45, %rbp
	movq	400(%rsp), %rbx
	xorq	%r11, %rbx
	rolq	$61, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 40(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 48(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 56(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 64(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 72(%rsp)
	movq	232(%rsp), %rdx
	xorq	%r10, %rdx
	rolq	$1, %rdx
	movq	280(%rsp), %rsi
	xorq	%r11, %rsi
	rolq	$6, %rsi
	movq	328(%rsp), %rdi
	xorq	%rcx, %rdi
	rolq	$25, %rdi
	movq	376(%rsp), %rbp
	xorq	%rax, %rbp
	rolq	$8, %rbp
	movq	384(%rsp), %rbx
	xorq	%r9, %rbx
	rolq	$18, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 80(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 88(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 96(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 104(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 112(%rsp)
	movq	256(%rsp), %rdx
	xorq	%rax, %rdx
	rolq	$27, %rdx
	movq	264(%rsp), %rsi
	xorq	%r9, %rsi
	rolq	$36, %rsi
	movq	312(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$10, %rdi
	movq	360(%rsp), %rbp
	xorq	%r11, %rbp
	rolq	$15, %rbp
	movq	408(%rsp), %rbx
	xorq	%rcx, %rbx
	rolq	$56, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 120(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 128(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 136(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 144(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 152(%rsp)
	movq	240(%rsp), %rdx
	xorq	%r11, %rdx
	rolq	$62, %rdx
	movq	288(%rsp), %rsi
	xorq	%rcx, %rsi
	rolq	$55, %rsi
	movq	%rsi, %rcx
	movq	336(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$39, %rsi
	movq	%rsi, %rax
	movq	344(%rsp), %rsi
	xorq	%r9, %rsi
	rolq	$41, %rsi
	movq	392(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$2, %rdi
	andnq	%rax, %rcx, %r9
	xorq	%rdx, %r9
	movq	%r9, 160(%rsp)
	andnq	%rsi, %rax, %r9
	xorq	%rcx, %r9
	movq	%r9, 168(%rsp)
	andnq	%rdi, %rsi, %r9
	xorq	%rax, %r9
	movq	%r9, 176(%rsp)
	andnq	%rdx, %rdi, %rax
	xorq	%rsi, %rax
	movq	%rax, 184(%rsp)
	andnq	%rcx, %rdx, %rax
	xorq	%rdi, %rax
	movq	%rax, 192(%rsp)
	leaq	16(%r8), %r8
	testb	$-1, %r8b
	jne 	Lsha3224_ref2x_jazz$21
	leaq	-192(%r8), %r8
	movq	216(%rsp), %rsi
	movq	208(%rsp), %rdx
Lsha3224_ref2x_jazz$19:
	cmpq	$144, %rdx
	jnb 	Lsha3224_ref2x_jazz$20
	movq	%rdx, %rax
	shrq	$3, %rax
	movq	$0, %rdi
	jmp 	Lsha3224_ref2x_jazz$17
Lsha3224_ref2x_jazz$18:
	movq	(%rsi,%rdi,8), %rcx
	xorq	%rcx, (%rsp,%rdi,8)
	leaq	1(%rdi), %rdi
Lsha3224_ref2x_jazz$17:
	cmpq	%rax, %rdi
	jb  	Lsha3224_ref2x_jazz$18
	leaq	(%rsi,%rdi,8), %r9
	andq	$7, %rdx
	movq	$0, %rsi
	movq	$0, %rcx
	testb	$4, %dl
	je  	Lsha3224_ref2x_jazz$16
	movl	(%r9), %esi
	leaq	4(%r9), %r9
	movq	$32, %rcx
Lsha3224_ref2x_jazz$16:
	testb	$2, %dl
	je  	Lsha3224_ref2x_jazz$15
	movzwq	(%r9), %rax
	leaq	2(%r9), %r9
	shlq	%cl, %rax
	leaq	16(%rcx), %rcx
	leaq	(%rsi,%rax), %rsi
Lsha3224_ref2x_jazz$15:
	testb	$1, %dl
	je  	Lsha3224_ref2x_jazz$14
	movzbq	(%r9), %rax
	shlq	%cl, %rax
	leaq	8(%rcx), %rcx
	leaq	(%rsi,%rax), %rsi
Lsha3224_ref2x_jazz$14:
	movq	$6, %rax
	shlq	%cl, %rax
	leaq	(%rsi,%rax), %rax
	xorq	%rax, (%rsp,%rdi,8)
	xorb	$-128, 143(%rsp)
	movq	432(%rsp), %rax
	jmp 	Lsha3224_ref2x_jazz$1
Lsha3224_ref2x_jazz$2:
	movq	%rax, 432(%rsp)
Lsha3224_ref2x_jazz$13:
	movq	(%r8), %rax
	movq	%rax, 424(%rsp)
	movq	(%rsp), %rax
	xorq	40(%rsp), %rax
	xorq	80(%rsp), %rax
	xorq	120(%rsp), %rax
	xorq	160(%rsp), %rax
	movq	8(%rsp), %rcx
	xorq	48(%rsp), %rcx
	xorq	88(%rsp), %rcx
	xorq	128(%rsp), %rcx
	xorq	168(%rsp), %rcx
	movq	16(%rsp), %rdx
	xorq	56(%rsp), %rdx
	xorq	96(%rsp), %rdx
	xorq	136(%rsp), %rdx
	xorq	176(%rsp), %rdx
	movq	24(%rsp), %rsi
	xorq	64(%rsp), %rsi
	xorq	104(%rsp), %rsi
	xorq	144(%rsp), %rsi
	xorq	184(%rsp), %rsi
	movq	32(%rsp), %rdi
	xorq	72(%rsp), %rdi
	xorq	112(%rsp), %rdi
	xorq	152(%rsp), %rdi
	xorq	192(%rsp), %rdi
	movq	%rcx, %r9
	rolq	$1, %r9
	xorq	%rdi, %r9
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
	movq	(%rsp), %rdx
	xorq	%r9, %rdx
	movq	48(%rsp), %rsi
	xorq	%r10, %rsi
	rolq	$44, %rsi
	movq	96(%rsp), %rdi
	xorq	%r11, %rdi
	rolq	$43, %rdi
	movq	144(%rsp), %rbp
	xorq	%rcx, %rbp
	rolq	$21, %rbp
	movq	192(%rsp), %rbx
	xorq	%rax, %rbx
	rolq	$14, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	424(%rsp), %r12
	xorq	%rdx, %r12
	movq	%r12, 224(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 232(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 240(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 248(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 256(%rsp)
	movq	24(%rsp), %rdx
	xorq	%rcx, %rdx
	rolq	$28, %rdx
	movq	72(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$20, %rsi
	movq	80(%rsp), %rdi
	xorq	%r9, %rdi
	rolq	$3, %rdi
	movq	128(%rsp), %rbp
	xorq	%r10, %rbp
	rolq	$45, %rbp
	movq	176(%rsp), %rbx
	xorq	%r11, %rbx
	rolq	$61, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 264(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 272(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 280(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 288(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 296(%rsp)
	movq	8(%rsp), %rdx
	xorq	%r10, %rdx
	rolq	$1, %rdx
	movq	56(%rsp), %rsi
	xorq	%r11, %rsi
	rolq	$6, %rsi
	movq	104(%rsp), %rdi
	xorq	%rcx, %rdi
	rolq	$25, %rdi
	movq	152(%rsp), %rbp
	xorq	%rax, %rbp
	rolq	$8, %rbp
	movq	160(%rsp), %rbx
	xorq	%r9, %rbx
	rolq	$18, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 304(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 312(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 320(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 328(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 336(%rsp)
	movq	32(%rsp), %rdx
	xorq	%rax, %rdx
	rolq	$27, %rdx
	movq	40(%rsp), %rsi
	xorq	%r9, %rsi
	rolq	$36, %rsi
	movq	88(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$10, %rdi
	movq	136(%rsp), %rbp
	xorq	%r11, %rbp
	rolq	$15, %rbp
	movq	184(%rsp), %rbx
	xorq	%rcx, %rbx
	rolq	$56, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 344(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 352(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 360(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 368(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 376(%rsp)
	movq	16(%rsp), %rdx
	xorq	%r11, %rdx
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
	xorq	%r9, %rsi
	rolq	$41, %rsi
	movq	168(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$2, %rdi
	andnq	%rax, %rcx, %r9
	xorq	%rdx, %r9
	movq	%r9, 384(%rsp)
	andnq	%rsi, %rax, %r9
	xorq	%rcx, %r9
	movq	%r9, 392(%rsp)
	andnq	%rdi, %rsi, %r9
	xorq	%rax, %r9
	movq	%r9, 400(%rsp)
	andnq	%rdx, %rdi, %rax
	xorq	%rsi, %rax
	movq	%rax, 408(%rsp)
	andnq	%rcx, %rdx, %rax
	xorq	%rdi, %rax
	movq	%rax, 416(%rsp)
	movq	8(%r8), %rax
	movq	%rax, 424(%rsp)
	movq	224(%rsp), %rax
	xorq	264(%rsp), %rax
	xorq	304(%rsp), %rax
	xorq	344(%rsp), %rax
	xorq	384(%rsp), %rax
	movq	232(%rsp), %rcx
	xorq	272(%rsp), %rcx
	xorq	312(%rsp), %rcx
	xorq	352(%rsp), %rcx
	xorq	392(%rsp), %rcx
	movq	240(%rsp), %rdx
	xorq	280(%rsp), %rdx
	xorq	320(%rsp), %rdx
	xorq	360(%rsp), %rdx
	xorq	400(%rsp), %rdx
	movq	248(%rsp), %rsi
	xorq	288(%rsp), %rsi
	xorq	328(%rsp), %rsi
	xorq	368(%rsp), %rsi
	xorq	408(%rsp), %rsi
	movq	256(%rsp), %rdi
	xorq	296(%rsp), %rdi
	xorq	336(%rsp), %rdi
	xorq	376(%rsp), %rdi
	xorq	416(%rsp), %rdi
	movq	%rcx, %r9
	rolq	$1, %r9
	xorq	%rdi, %r9
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
	movq	224(%rsp), %rdx
	xorq	%r9, %rdx
	movq	272(%rsp), %rsi
	xorq	%r10, %rsi
	rolq	$44, %rsi
	movq	320(%rsp), %rdi
	xorq	%r11, %rdi
	rolq	$43, %rdi
	movq	368(%rsp), %rbp
	xorq	%rcx, %rbp
	rolq	$21, %rbp
	movq	416(%rsp), %rbx
	xorq	%rax, %rbx
	rolq	$14, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	424(%rsp), %r12
	xorq	%rdx, %r12
	movq	%r12, (%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 8(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 16(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 24(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 32(%rsp)
	movq	248(%rsp), %rdx
	xorq	%rcx, %rdx
	rolq	$28, %rdx
	movq	296(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$20, %rsi
	movq	304(%rsp), %rdi
	xorq	%r9, %rdi
	rolq	$3, %rdi
	movq	352(%rsp), %rbp
	xorq	%r10, %rbp
	rolq	$45, %rbp
	movq	400(%rsp), %rbx
	xorq	%r11, %rbx
	rolq	$61, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 40(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 48(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 56(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 64(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 72(%rsp)
	movq	232(%rsp), %rdx
	xorq	%r10, %rdx
	rolq	$1, %rdx
	movq	280(%rsp), %rsi
	xorq	%r11, %rsi
	rolq	$6, %rsi
	movq	328(%rsp), %rdi
	xorq	%rcx, %rdi
	rolq	$25, %rdi
	movq	376(%rsp), %rbp
	xorq	%rax, %rbp
	rolq	$8, %rbp
	movq	384(%rsp), %rbx
	xorq	%r9, %rbx
	rolq	$18, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 80(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 88(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 96(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 104(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 112(%rsp)
	movq	256(%rsp), %rdx
	xorq	%rax, %rdx
	rolq	$27, %rdx
	movq	264(%rsp), %rsi
	xorq	%r9, %rsi
	rolq	$36, %rsi
	movq	312(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$10, %rdi
	movq	360(%rsp), %rbp
	xorq	%r11, %rbp
	rolq	$15, %rbp
	movq	408(%rsp), %rbx
	xorq	%rcx, %rbx
	rolq	$56, %rbx
	andnq	%rdi, %rsi, %r12
	xorq	%rdx, %r12
	movq	%r12, 120(%rsp)
	andnq	%rbp, %rdi, %r12
	xorq	%rsi, %r12
	movq	%r12, 128(%rsp)
	andnq	%rbx, %rbp, %r12
	xorq	%rdi, %r12
	movq	%r12, 136(%rsp)
	andnq	%rdx, %rbx, %rdi
	xorq	%rbp, %rdi
	movq	%rdi, 144(%rsp)
	andnq	%rsi, %rdx, %rdx
	xorq	%rbx, %rdx
	movq	%rdx, 152(%rsp)
	movq	240(%rsp), %rdx
	xorq	%r11, %rdx
	rolq	$62, %rdx
	movq	288(%rsp), %rsi
	xorq	%rcx, %rsi
	rolq	$55, %rsi
	movq	%rsi, %rcx
	movq	336(%rsp), %rsi
	xorq	%rax, %rsi
	rolq	$39, %rsi
	movq	%rsi, %rax
	movq	344(%rsp), %rsi
	xorq	%r9, %rsi
	rolq	$41, %rsi
	movq	392(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$2, %rdi
	andnq	%rax, %rcx, %r9
	xorq	%rdx, %r9
	movq	%r9, 160(%rsp)
	andnq	%rsi, %rax, %r9
	xorq	%rcx, %r9
	movq	%r9, 168(%rsp)
	andnq	%rdi, %rsi, %r9
	xorq	%rax, %r9
	movq	%r9, 176(%rsp)
	andnq	%rdx, %rdi, %rax
	xorq	%rsi, %rax
	movq	%rax, 184(%rsp)
	andnq	%rcx, %rdx, %rax
	xorq	%rdi, %rax
	movq	%rax, 192(%rsp)
	leaq	16(%r8), %r8
	testb	$-1, %r8b
	jne 	Lsha3224_ref2x_jazz$13
	leaq	-192(%r8), %r8
	movq	432(%rsp), %rax
	cmpq	$144, 200(%rsp)
	jnb 	Lsha3224_ref2x_jazz$3
	movq	200(%rsp), %rcx
	movq	%rcx, %rdx
	shrq	$3, %rdx
	movq	$0, %rsi
	jmp 	Lsha3224_ref2x_jazz$11
Lsha3224_ref2x_jazz$12:
	movq	(%rsp,%rsi,8), %rdi
	movq	%rdi, (%rax,%rsi,8)
	leaq	1(%rsi), %rsi
Lsha3224_ref2x_jazz$11:
	cmpq	%rdx, %rsi
	jb  	Lsha3224_ref2x_jazz$12
	shlq	$3, %rsi
	jmp 	Lsha3224_ref2x_jazz$9
Lsha3224_ref2x_jazz$10:
	movb	(%rsp,%rsi), %dl
	movb	%dl, (%rax,%rsi)
	leaq	1(%rsi), %rsi
Lsha3224_ref2x_jazz$9:
	cmpq	%rcx, %rsi
	jb  	Lsha3224_ref2x_jazz$10
	leaq	(%rax,%rcx), %rax
	movq	$0, 200(%rsp)
	jmp 	Lsha3224_ref2x_jazz$4
Lsha3224_ref2x_jazz$3:
	movq	$144, %rcx
	movq	%rcx, %rdx
	shrq	$3, %rdx
	movq	$0, %rsi
	jmp 	Lsha3224_ref2x_jazz$7
Lsha3224_ref2x_jazz$8:
	movq	(%rsp,%rsi,8), %rdi
	movq	%rdi, (%rax,%rsi,8)
	leaq	1(%rsi), %rsi
Lsha3224_ref2x_jazz$7:
	cmpq	%rdx, %rsi
	jb  	Lsha3224_ref2x_jazz$8
	shlq	$3, %rsi
	jmp 	Lsha3224_ref2x_jazz$5
Lsha3224_ref2x_jazz$6:
	movb	(%rsp,%rsi), %dl
	movb	%dl, (%rax,%rsi)
	leaq	1(%rsi), %rsi
Lsha3224_ref2x_jazz$5:
	cmpq	%rcx, %rsi
	jb  	Lsha3224_ref2x_jazz$6
	leaq	(%rax,%rcx), %rax
	subq	$144, 200(%rsp)
Lsha3224_ref2x_jazz$4:
Lsha3224_ref2x_jazz$1:
	cmpq	$0, 200(%rsp)
	jnle	Lsha3224_ref2x_jazz$2
	addq	$440, %rsp
	popq	%r12
	popq	%rbx
	popq	%rbp
	ret 

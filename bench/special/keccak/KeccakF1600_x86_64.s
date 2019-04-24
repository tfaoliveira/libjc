	.text
	.p2align	5
	.globl	_KeccakF1600_x86_64
	.globl	KeccakF1600_x86_64
_KeccakF1600_x86_64:
KeccakF1600_x86_64:
	pushq	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14 # just to make the number of push equal
	pushq	%r15 #
	subq	$408, %rsp
#	movq	(%rdi), %rax
#	movq	%rax, 200(%rsp)
#	movq	8(%rdi), %rax
#	movq	%rax, 208(%rsp)
#	movq	16(%rdi), %rax
#	movq	%rax, 216(%rsp)
#	movq	24(%rdi), %rax
#	movq	%rax, 224(%rsp)
#	movq	32(%rdi), %rax
#	movq	%rax, 232(%rsp)
#	movq	40(%rdi), %rax
#	movq	%rax, 240(%rsp)
#	movq	48(%rdi), %rax
#	movq	%rax, 248(%rsp)
#	movq	56(%rdi), %rax
#	movq	%rax, 256(%rsp)
#	movq	64(%rdi), %rax
#	movq	%rax, 264(%rsp)
#	movq	72(%rdi), %rax
#	movq	%rax, 272(%rsp)
#	movq	80(%rdi), %rax
#	movq	%rax, 280(%rsp)
#	movq	88(%rdi), %rax
#	movq	%rax, 288(%rsp)
#	movq	96(%rdi), %rax
#	movq	%rax, 296(%rsp)
#	movq	104(%rdi), %rax
#	movq	%rax, 304(%rsp)
#	movq	112(%rdi), %rax
#	movq	%rax, 312(%rsp)
#	movq	120(%rdi), %rax
#	movq	%rax, 320(%rsp)
#	movq	128(%rdi), %rax
#	movq	%rax, 328(%rsp)
#	movq	136(%rdi), %rax
#	movq	%rax, 336(%rsp)
#	movq	144(%rdi), %rax
#	movq	%rax, 344(%rsp)
#	movq	152(%rdi), %rax
#	movq	%rax, 352(%rsp)
#	movq	160(%rdi), %rax
#	movq	%rax, 360(%rsp)
#	movq	168(%rdi), %rax
#	movq	%rax, 368(%rsp)
#	movq	176(%rdi), %rax
#	movq	%rax, 376(%rsp)
#	movq	184(%rdi), %rax
#	movq	%rax, 384(%rsp)
#	movq	192(%rdi), %rax
#	movq	%rax, 392(%rsp)
LKeccakF1600_x86_64$1:
	movq	(%rsi), %rax
	movq	%rax, 400(%rsp)
	movq	200(%rsp), %rax
	xorq	240(%rsp), %rax
	xorq	280(%rsp), %rax
	xorq	320(%rsp), %rax
	xorq	360(%rsp), %rax
	movq	208(%rsp), %rcx
	xorq	248(%rsp), %rcx
	xorq	288(%rsp), %rcx
	xorq	328(%rsp), %rcx
	xorq	368(%rsp), %rcx
	movq	216(%rsp), %rdx
	xorq	256(%rsp), %rdx
	xorq	296(%rsp), %rdx
	xorq	336(%rsp), %rdx
	xorq	376(%rsp), %rdx
	movq	224(%rsp), %r8
	xorq	264(%rsp), %r8
	xorq	304(%rsp), %r8
	xorq	344(%rsp), %r8
	xorq	384(%rsp), %r8
	movq	232(%rsp), %r9
	xorq	272(%rsp), %r9
	xorq	312(%rsp), %r9
	xorq	352(%rsp), %r9
	xorq	392(%rsp), %r9
	movq	%rcx, %r10
	rolq	$1, %r10
	xorq	%r9, %r10
	movq	%rdx, %r11
	rolq	$1, %r11
	xorq	%rax, %r11
	movq	%r8, %rbp
	rolq	$1, %rbp
	xorq	%rcx, %rbp
	movq	%r9, %rcx
	rolq	$1, %rcx
	xorq	%rdx, %rcx
	rolq	$1, %rax
	xorq	%r8, %rax
	movq	200(%rsp), %rdx
	xorq	%r10, %rdx
	movq	248(%rsp), %r8
	xorq	%r11, %r8
	rolq	$44, %r8
	movq	296(%rsp), %r9
	xorq	%rbp, %r9
	rolq	$43, %r9
	movq	344(%rsp), %rbx
	xorq	%rcx, %rbx
	rolq	$21, %rbx
	movq	392(%rsp), %r12
	xorq	%rax, %r12
	rolq	$14, %r12
	andnq	%r9, %r8, %r13
	xorq	400(%rsp), %r13
	xorq	%rdx, %r13
	movq	%r13, (%rsp)
	andnq	%rbx, %r9, %r13
	xorq	%r8, %r13
	movq	%r13, 8(%rsp)
	andnq	%r12, %rbx, %r13
	xorq	%r9, %r13
	movq	%r13, 16(%rsp)
	andnq	%rdx, %r12, %r9
	xorq	%rbx, %r9
	movq	%r9, 24(%rsp)
	andnq	%r8, %rdx, %rdx
	xorq	%r12, %rdx
	movq	%rdx, 32(%rsp)
	movq	224(%rsp), %rdx
	xorq	%rcx, %rdx
	rolq	$28, %rdx
	movq	272(%rsp), %r8
	xorq	%rax, %r8
	rolq	$20, %r8
	movq	280(%rsp), %r9
	xorq	%r10, %r9
	rolq	$3, %r9
	movq	328(%rsp), %rbx
	xorq	%r11, %rbx
	rolq	$45, %rbx
	movq	376(%rsp), %r12
	xorq	%rbp, %r12
	rolq	$61, %r12
	andnq	%r9, %r8, %r13
	xorq	%rdx, %r13
	movq	%r13, 40(%rsp)
	andnq	%rbx, %r9, %r13
	xorq	%r8, %r13
	movq	%r13, 48(%rsp)
	andnq	%r12, %rbx, %r13
	xorq	%r9, %r13
	movq	%r13, 56(%rsp)
	andnq	%rdx, %r12, %r9
	xorq	%rbx, %r9
	movq	%r9, 64(%rsp)
	andnq	%r8, %rdx, %rdx
	xorq	%r12, %rdx
	movq	%rdx, 72(%rsp)
	movq	208(%rsp), %rdx
	xorq	%r11, %rdx
	rolq	$1, %rdx
	movq	256(%rsp), %r8
	xorq	%rbp, %r8
	rolq	$6, %r8
	movq	304(%rsp), %r9
	xorq	%rcx, %r9
	rolq	$25, %r9
	movq	352(%rsp), %rbx
	xorq	%rax, %rbx
	rolq	$8, %rbx
	movq	360(%rsp), %r12
	xorq	%r10, %r12
	rolq	$18, %r12
	andnq	%r9, %r8, %r13
	xorq	%rdx, %r13
	movq	%r13, 80(%rsp)
	andnq	%rbx, %r9, %r13
	xorq	%r8, %r13
	movq	%r13, 88(%rsp)
	andnq	%r12, %rbx, %r13
	xorq	%r9, %r13
	movq	%r13, 96(%rsp)
	andnq	%rdx, %r12, %r9
	xorq	%rbx, %r9
	movq	%r9, 104(%rsp)
	andnq	%r8, %rdx, %rdx
	xorq	%r12, %rdx
	movq	%rdx, 112(%rsp)
	movq	232(%rsp), %rdx
	xorq	%rax, %rdx
	rolq	$27, %rdx
	movq	240(%rsp), %r8
	xorq	%r10, %r8
	rolq	$36, %r8
	movq	288(%rsp), %r9
	xorq	%r11, %r9
	rolq	$10, %r9
	movq	336(%rsp), %rbx
	xorq	%rbp, %rbx
	rolq	$15, %rbx
	movq	384(%rsp), %r12
	xorq	%rcx, %r12
	rolq	$56, %r12
	andnq	%r9, %r8, %r13
	xorq	%rdx, %r13
	movq	%r13, 120(%rsp)
	andnq	%rbx, %r9, %r13
	xorq	%r8, %r13
	movq	%r13, 128(%rsp)
	andnq	%r12, %rbx, %r13
	xorq	%r9, %r13
	movq	%r13, 136(%rsp)
	andnq	%rdx, %r12, %r9
	xorq	%rbx, %r9
	movq	%r9, 144(%rsp)
	andnq	%r8, %rdx, %rdx
	xorq	%r12, %rdx
	movq	%rdx, 152(%rsp)
	movq	216(%rsp), %rdx
	xorq	%rbp, %rdx
	rolq	$62, %rdx
	movq	264(%rsp), %r8
	xorq	%rcx, %r8
	rolq	$55, %r8
	movq	%r8, %rcx
	movq	312(%rsp), %r8
	xorq	%rax, %r8
	rolq	$39, %r8
	movq	%r8, %rax
	movq	320(%rsp), %r8
	xorq	%r10, %r8
	rolq	$41, %r8
	movq	368(%rsp), %r9
	xorq	%r11, %r9
	rolq	$2, %r9
	andnq	%rax, %rcx, %r10
	xorq	%rdx, %r10
	movq	%r10, 160(%rsp)
	andnq	%r8, %rax, %r10
	xorq	%rcx, %r10
	movq	%r10, 168(%rsp)
	andnq	%r9, %r8, %r10
	xorq	%rax, %r10
	movq	%r10, 176(%rsp)
	andnq	%rdx, %r9, %rax
	xorq	%r8, %rax
	movq	%rax, 184(%rsp)
	andnq	%rcx, %rdx, %rax
	xorq	%r9, %rax
	movq	%rax, 192(%rsp)
	movq	8(%rsi), %rax
	movq	%rax, 400(%rsp)
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
	movq	24(%rsp), %r8
	xorq	64(%rsp), %r8
	xorq	104(%rsp), %r8
	xorq	144(%rsp), %r8
	xorq	184(%rsp), %r8
	movq	32(%rsp), %r9
	xorq	72(%rsp), %r9
	xorq	112(%rsp), %r9
	xorq	152(%rsp), %r9
	xorq	192(%rsp), %r9
	movq	%rcx, %r10
	rolq	$1, %r10
	xorq	%r9, %r10
	movq	%rdx, %r11
	rolq	$1, %r11
	xorq	%rax, %r11
	movq	%r8, %rbp
	rolq	$1, %rbp
	xorq	%rcx, %rbp
	movq	%r9, %rcx
	rolq	$1, %rcx
	xorq	%rdx, %rcx
	rolq	$1, %rax
	xorq	%r8, %rax
	movq	(%rsp), %rdx
	xorq	%r10, %rdx
	movq	48(%rsp), %r8
	xorq	%r11, %r8
	rolq	$44, %r8
	movq	96(%rsp), %r9
	xorq	%rbp, %r9
	rolq	$43, %r9
	movq	144(%rsp), %rbx
	xorq	%rcx, %rbx
	rolq	$21, %rbx
	movq	192(%rsp), %r12
	xorq	%rax, %r12
	rolq	$14, %r12
	andnq	%r9, %r8, %r13
	xorq	400(%rsp), %r13
	xorq	%rdx, %r13
	movq	%r13, 200(%rsp)
	andnq	%rbx, %r9, %r13
	xorq	%r8, %r13
	movq	%r13, 208(%rsp)
	andnq	%r12, %rbx, %r13
	xorq	%r9, %r13
	movq	%r13, 216(%rsp)
	andnq	%rdx, %r12, %r9
	xorq	%rbx, %r9
	movq	%r9, 224(%rsp)
	andnq	%r8, %rdx, %rdx
	xorq	%r12, %rdx
	movq	%rdx, 232(%rsp)
	movq	24(%rsp), %rdx
	xorq	%rcx, %rdx
	rolq	$28, %rdx
	movq	72(%rsp), %r8
	xorq	%rax, %r8
	rolq	$20, %r8
	movq	80(%rsp), %r9
	xorq	%r10, %r9
	rolq	$3, %r9
	movq	128(%rsp), %rbx
	xorq	%r11, %rbx
	rolq	$45, %rbx
	movq	176(%rsp), %r12
	xorq	%rbp, %r12
	rolq	$61, %r12
	andnq	%r9, %r8, %r13
	xorq	%rdx, %r13
	movq	%r13, 240(%rsp)
	andnq	%rbx, %r9, %r13
	xorq	%r8, %r13
	movq	%r13, 248(%rsp)
	andnq	%r12, %rbx, %r13
	xorq	%r9, %r13
	movq	%r13, 256(%rsp)
	andnq	%rdx, %r12, %r9
	xorq	%rbx, %r9
	movq	%r9, 264(%rsp)
	andnq	%r8, %rdx, %rdx
	xorq	%r12, %rdx
	movq	%rdx, 272(%rsp)
	movq	8(%rsp), %rdx
	xorq	%r11, %rdx
	rolq	$1, %rdx
	movq	56(%rsp), %r8
	xorq	%rbp, %r8
	rolq	$6, %r8
	movq	104(%rsp), %r9
	xorq	%rcx, %r9
	rolq	$25, %r9
	movq	152(%rsp), %rbx
	xorq	%rax, %rbx
	rolq	$8, %rbx
	movq	160(%rsp), %r12
	xorq	%r10, %r12
	rolq	$18, %r12
	andnq	%r9, %r8, %r13
	xorq	%rdx, %r13
	movq	%r13, 280(%rsp)
	andnq	%rbx, %r9, %r13
	xorq	%r8, %r13
	movq	%r13, 288(%rsp)
	andnq	%r12, %rbx, %r13
	xorq	%r9, %r13
	movq	%r13, 296(%rsp)
	andnq	%rdx, %r12, %r9
	xorq	%rbx, %r9
	movq	%r9, 304(%rsp)
	andnq	%r8, %rdx, %rdx
	xorq	%r12, %rdx
	movq	%rdx, 312(%rsp)
	movq	32(%rsp), %rdx
	xorq	%rax, %rdx
	rolq	$27, %rdx
	movq	40(%rsp), %r8
	xorq	%r10, %r8
	rolq	$36, %r8
	movq	88(%rsp), %r9
	xorq	%r11, %r9
	rolq	$10, %r9
	movq	136(%rsp), %rbx
	xorq	%rbp, %rbx
	rolq	$15, %rbx
	movq	184(%rsp), %r12
	xorq	%rcx, %r12
	rolq	$56, %r12
	andnq	%r9, %r8, %r13
	xorq	%rdx, %r13
	movq	%r13, 320(%rsp)
	andnq	%rbx, %r9, %r13
	xorq	%r8, %r13
	movq	%r13, 328(%rsp)
	andnq	%r12, %rbx, %r13
	xorq	%r9, %r13
	movq	%r13, 336(%rsp)
	andnq	%rdx, %r12, %r9
	xorq	%rbx, %r9
	movq	%r9, 344(%rsp)
	andnq	%r8, %rdx, %rdx
	xorq	%r12, %rdx
	movq	%rdx, 352(%rsp)
	movq	16(%rsp), %rdx
	xorq	%rbp, %rdx
	rolq	$62, %rdx
	movq	64(%rsp), %r8
	xorq	%rcx, %r8
	rolq	$55, %r8
	movq	%r8, %rcx
	movq	112(%rsp), %r8
	xorq	%rax, %r8
	rolq	$39, %r8
	movq	%r8, %rax
	movq	120(%rsp), %r8
	xorq	%r10, %r8
	rolq	$41, %r8
	movq	168(%rsp), %r9
	xorq	%r11, %r9
	rolq	$2, %r9
	andnq	%rax, %rcx, %r10
	xorq	%rdx, %r10
	movq	%r10, 360(%rsp)
	andnq	%r8, %rax, %r10
	xorq	%rcx, %r10
	movq	%r10, 368(%rsp)
	andnq	%r9, %r8, %r10
	xorq	%rax, %r10
	movq	%r10, 376(%rsp)
	andnq	%rdx, %r9, %rax
	xorq	%r8, %rax
	movq	%rax, 384(%rsp)
	andnq	%rcx, %rdx, %rax
	xorq	%r9, %rax
	movq	%rax, 392(%rsp)
	leaq	16(%rsi), %rsi
	testb	$-1, %sil
	jne 	LKeccakF1600_x86_64$1
#	movq	200(%rsp), %rax
#	movq	%rax, (%rdi)
#	movq	208(%rsp), %rax
#	movq	%rax, 8(%rdi)
#	movq	216(%rsp), %rax
#	movq	%rax, 16(%rdi)
#	movq	224(%rsp), %rax
#	movq	%rax, 24(%rdi)
#	movq	232(%rsp), %rax
#	movq	%rax, 32(%rdi)
#	movq	240(%rsp), %rax
#	movq	%rax, 40(%rdi)
#	movq	248(%rsp), %rax
#	movq	%rax, 48(%rdi)
#	movq	256(%rsp), %rax
#	movq	%rax, 56(%rdi)
#	movq	264(%rsp), %rax
#	movq	%rax, 64(%rdi)
#	movq	272(%rsp), %rax
#	movq	%rax, 72(%rdi)
#	movq	280(%rsp), %rax
#	movq	%rax, 80(%rdi)
#	movq	288(%rsp), %rax
#	movq	%rax, 88(%rdi)
#	movq	296(%rsp), %rax
#	movq	%rax, 96(%rdi)
#	movq	304(%rsp), %rax
#	movq	%rax, 104(%rdi)
#	movq	312(%rsp), %rax
#	movq	%rax, 112(%rdi)
#	movq	320(%rsp), %rax
#	movq	%rax, 120(%rdi)
#	movq	328(%rsp), %rax
#	movq	%rax, 128(%rdi)
#	movq	336(%rsp), %rax
#	movq	%rax, 136(%rdi)
#	movq	344(%rsp), %rax
#	movq	%rax, 144(%rdi)
#	movq	352(%rsp), %rax
#	movq	%rax, 152(%rdi)
#	movq	360(%rsp), %rax
#	movq	%rax, 160(%rdi)
#	movq	368(%rsp), %rax
#	movq	%rax, 168(%rdi)
#	movq	376(%rsp), %rax
#	movq	%rax, 176(%rdi)
#	movq	384(%rsp), %rax
#	movq	%rax, 184(%rdi)
#	movq	392(%rsp), %rax
#	movq	%rax, 192(%rdi)
	addq	$408, %rsp

  popq	%r15 # number of pops equal
	popq	%r14 #
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	ret 

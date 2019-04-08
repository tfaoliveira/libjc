	.text
	.p2align	5
	.globl	_shake256_ref2x
	.globl	shake256_ref2x
_shake256_ref2x:
shake256_ref2x:
	pushq	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	subq	$624, %rsp
	movq	%rdx, 616(%rsp)
	movq	%rcx, 608(%rsp)
	xorl	%eax, %eax
	movq	%rax, (%rsp)
	movq	%rax, 8(%rsp)
	movq	%rax, 16(%rsp)
	movq	%rax, 24(%rsp)
	movq	%rax, 32(%rsp)
	movq	%rax, 40(%rsp)
	movq	%rax, 48(%rsp)
	movq	%rax, 56(%rsp)
	movq	%rax, 64(%rsp)
	movq	%rax, 72(%rsp)
	movq	%rax, 80(%rsp)
	movq	%rax, 88(%rsp)
	movq	%rax, 96(%rsp)
	movq	%rax, 104(%rsp)
	movq	%rax, 112(%rsp)
	movq	%rax, 120(%rsp)
	movq	%rax, 128(%rsp)
	movq	%rax, 136(%rsp)
	movq	%rax, 144(%rsp)
	movq	%rax, 152(%rsp)
	movq	%rax, 160(%rsp)
	movq	%rax, 168(%rsp)
	movq	%rax, 176(%rsp)
	movq	%rax, 184(%rsp)
	movq	%rax, 192(%rsp)
	movq	$1, %rax
	movq	%rax, 200(%rsp)
	movq	$32898, %rax
	movq	%rax, 208(%rsp)
	movq	$-9223372036854742902, %rax
	movq	%rax, 216(%rsp)
	movq	$-9223372034707259392, %rax
	movq	%rax, 224(%rsp)
	movq	$32907, %rax
	movq	%rax, 232(%rsp)
	movq	$2147483649, %rax
	movq	%rax, 240(%rsp)
	movq	$-9223372034707259263, %rax
	movq	%rax, 248(%rsp)
	movq	$-9223372036854743031, %rax
	movq	%rax, 256(%rsp)
	movq	$138, %rax
	movq	%rax, 264(%rsp)
	movq	$136, %rax
	movq	%rax, 272(%rsp)
	movq	$2147516425, %rax
	movq	%rax, 280(%rsp)
	movq	$2147483658, %rax
	movq	%rax, 288(%rsp)
	movq	$2147516555, %rax
	movq	%rax, 296(%rsp)
	movq	$-9223372036854775669, %rax
	movq	%rax, 304(%rsp)
	movq	$-9223372036854742903, %rax
	movq	%rax, 312(%rsp)
	movq	$-9223372036854743037, %rax
	movq	%rax, 320(%rsp)
	movq	$-9223372036854743038, %rax
	movq	%rax, 328(%rsp)
	movq	$-9223372036854775680, %rax
	movq	%rax, 336(%rsp)
	movq	$32778, %rax
	movq	%rax, 344(%rsp)
	movq	$-9223372034707292150, %rax
	movq	%rax, 352(%rsp)
	movq	$-9223372034707259263, %rax
	movq	%rax, 360(%rsp)
	movq	$-9223372036854742912, %rax
	movq	%rax, 368(%rsp)
	movq	$2147483649, %rax
	movq	%rax, 376(%rsp)
	movq	$-9223372034707259384, %rax
	movq	%rax, 384(%rsp)
	shrq	$3, %rsi
	jmp 	Lshake256_ref2x$19
Lshake256_ref2x$20:
	movq	(%rdi), %rax
	xorq	%rax, (%rsp)
	movq	8(%rdi), %rax
	xorq	%rax, 8(%rsp)
	movq	16(%rdi), %rax
	xorq	%rax, 16(%rsp)
	movq	24(%rdi), %rax
	xorq	%rax, 24(%rsp)
	movq	32(%rdi), %rax
	xorq	%rax, 32(%rsp)
	movq	40(%rdi), %rax
	xorq	%rax, 40(%rsp)
	movq	48(%rdi), %rax
	xorq	%rax, 48(%rsp)
	movq	56(%rdi), %rax
	xorq	%rax, 56(%rsp)
	movq	64(%rdi), %rax
	xorq	%rax, 64(%rsp)
	movq	72(%rdi), %rax
	xorq	%rax, 72(%rsp)
	movq	80(%rdi), %rax
	xorq	%rax, 80(%rsp)
	movq	88(%rdi), %rax
	xorq	%rax, 88(%rsp)
	movq	96(%rdi), %rax
	xorq	%rax, 96(%rsp)
	movq	104(%rdi), %rax
	xorq	%rax, 104(%rsp)
	movq	112(%rdi), %rax
	xorq	%rax, 112(%rsp)
	movq	120(%rdi), %rax
	xorq	%rax, 120(%rsp)
	movq	128(%rdi), %rax
	xorq	%rax, 128(%rsp)
	addq	$-136, %rsi
	addq	$136, %rdi
	movq	%rsi, 600(%rsp)
	movq	%rdi, 592(%rsp)
	movq	$0, %rax
	jmp 	Lshake256_ref2x$21
Lshake256_ref2x$22:
	movq	200(%rsp,%rax,8), %rcx
	movq	(%rsp), %rdx
	xorq	40(%rsp), %rdx
	xorq	80(%rsp), %rdx
	xorq	120(%rsp), %rdx
	xorq	160(%rsp), %rdx
	movq	8(%rsp), %rsi
	xorq	48(%rsp), %rsi
	xorq	88(%rsp), %rsi
	xorq	128(%rsp), %rsi
	xorq	168(%rsp), %rsi
	movq	16(%rsp), %rdi
	xorq	56(%rsp), %rdi
	xorq	96(%rsp), %rdi
	xorq	136(%rsp), %rdi
	xorq	176(%rsp), %rdi
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
	movq	%rsi, %r10
	rolq	$1, %r10
	xorq	%r9, %r10
	movq	%rdi, %r11
	rolq	$1, %r11
	xorq	%rdx, %r11
	movq	%r8, %rbp
	rolq	$1, %rbp
	xorq	%rsi, %rbp
	movq	%r9, %rsi
	rolq	$1, %rsi
	xorq	%rdi, %rsi
	rolq	$1, %rdx
	xorq	%r8, %rdx
	movq	(%rsp), %rdi
	xorq	%r10, %rdi
	movq	48(%rsp), %r8
	xorq	%r11, %r8
	rolq	$44, %r8
	movq	96(%rsp), %r9
	xorq	%rbp, %r9
	rolq	$43, %r9
	movq	144(%rsp), %rbx
	xorq	%rsi, %rbx
	rolq	$21, %rbx
	movq	192(%rsp), %r12
	xorq	%rdx, %r12
	rolq	$14, %r12
	movq	%r8, %r13
	movq	%r9, %r14
	andnq	%r14, %r13, %r13
	xorq	%rcx, %r13
	xorq	%rdi, %r13
	movq	%r13, 392(%rsp)
	movq	%r9, %rcx
	movq	%rbx, %r13
	andnq	%r13, %rcx, %rcx
	xorq	%r8, %rcx
	movq	%rcx, 400(%rsp)
	movq	%rbx, %rcx
	movq	%r12, %r13
	andnq	%r13, %rcx, %rcx
	xorq	%r9, %rcx
	movq	%rcx, 408(%rsp)
	movq	%r12, %rcx
	movq	%rdi, %r9
	andnq	%r9, %rcx, %rcx
	xorq	%rbx, %rcx
	movq	%rcx, 416(%rsp)
	andnq	%r8, %rdi, %rcx
	xorq	%r12, %rcx
	movq	%rcx, 424(%rsp)
	movq	24(%rsp), %rcx
	xorq	%rsi, %rcx
	rolq	$28, %rcx
	movq	72(%rsp), %rdi
	xorq	%rdx, %rdi
	rolq	$20, %rdi
	movq	80(%rsp), %r8
	xorq	%r10, %r8
	rolq	$3, %r8
	movq	128(%rsp), %r9
	xorq	%r11, %r9
	rolq	$45, %r9
	movq	176(%rsp), %rbx
	xorq	%rbp, %rbx
	rolq	$61, %rbx
	movq	%rdi, %r12
	movq	%r8, %r13
	andnq	%r13, %r12, %r12
	xorq	%rcx, %r12
	movq	%r12, 432(%rsp)
	movq	%r8, %r12
	movq	%r9, %r13
	andnq	%r13, %r12, %r12
	xorq	%rdi, %r12
	movq	%r12, 440(%rsp)
	movq	%r9, %r12
	movq	%rbx, %r13
	andnq	%r13, %r12, %r12
	xorq	%r8, %r12
	movq	%r12, 448(%rsp)
	movq	%rbx, %r8
	movq	%rcx, %r12
	andnq	%r12, %r8, %r8
	xorq	%r9, %r8
	movq	%r8, 456(%rsp)
	andnq	%rdi, %rcx, %rcx
	xorq	%rbx, %rcx
	movq	%rcx, 464(%rsp)
	movq	8(%rsp), %rcx
	xorq	%r11, %rcx
	rolq	$1, %rcx
	movq	56(%rsp), %rdi
	xorq	%rbp, %rdi
	rolq	$6, %rdi
	movq	104(%rsp), %r8
	xorq	%rsi, %r8
	rolq	$25, %r8
	movq	152(%rsp), %r9
	xorq	%rdx, %r9
	rolq	$8, %r9
	movq	160(%rsp), %rbx
	xorq	%r10, %rbx
	rolq	$18, %rbx
	movq	%rdi, %r12
	movq	%r8, %r13
	andnq	%r13, %r12, %r12
	xorq	%rcx, %r12
	movq	%r12, 472(%rsp)
	movq	%r8, %r12
	movq	%r9, %r13
	andnq	%r13, %r12, %r12
	xorq	%rdi, %r12
	movq	%r12, 480(%rsp)
	movq	%r9, %r12
	movq	%rbx, %r13
	andnq	%r13, %r12, %r12
	xorq	%r8, %r12
	movq	%r12, 488(%rsp)
	movq	%rbx, %r8
	movq	%rcx, %r12
	andnq	%r12, %r8, %r8
	xorq	%r9, %r8
	movq	%r8, 496(%rsp)
	andnq	%rdi, %rcx, %rcx
	xorq	%rbx, %rcx
	movq	%rcx, 504(%rsp)
	movq	32(%rsp), %rcx
	xorq	%rdx, %rcx
	rolq	$27, %rcx
	movq	40(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$36, %rdi
	movq	88(%rsp), %r8
	xorq	%r11, %r8
	rolq	$10, %r8
	movq	136(%rsp), %r9
	xorq	%rbp, %r9
	rolq	$15, %r9
	movq	184(%rsp), %rbx
	xorq	%rsi, %rbx
	rolq	$56, %rbx
	movq	%rdi, %r12
	movq	%r8, %r13
	andnq	%r13, %r12, %r12
	xorq	%rcx, %r12
	movq	%r12, 512(%rsp)
	movq	%r8, %r12
	movq	%r9, %r13
	andnq	%r13, %r12, %r12
	xorq	%rdi, %r12
	movq	%r12, 520(%rsp)
	movq	%r9, %r12
	movq	%rbx, %r13
	andnq	%r13, %r12, %r12
	xorq	%r8, %r12
	movq	%r12, 528(%rsp)
	movq	%rbx, %r8
	movq	%rcx, %r12
	andnq	%r12, %r8, %r8
	xorq	%r9, %r8
	movq	%r8, 536(%rsp)
	andnq	%rdi, %rcx, %rcx
	xorq	%rbx, %rcx
	movq	%rcx, 544(%rsp)
	movq	16(%rsp), %rcx
	xorq	%rbp, %rcx
	rolq	$62, %rcx
	movq	64(%rsp), %rdi
	xorq	%rsi, %rdi
	rolq	$55, %rdi
	movq	%rdi, %rsi
	movq	112(%rsp), %rdi
	xorq	%rdx, %rdi
	rolq	$39, %rdi
	movq	%rdi, %rdx
	movq	120(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$41, %rdi
	movq	168(%rsp), %r8
	xorq	%r11, %r8
	rolq	$2, %r8
	movq	%rsi, %r9
	movq	%rdx, %r10
	andnq	%r10, %r9, %r9
	xorq	%rcx, %r9
	movq	%r9, 552(%rsp)
	movq	%rdx, %r9
	movq	%rdi, %r10
	andnq	%r10, %r9, %r9
	xorq	%rsi, %r9
	movq	%r9, 560(%rsp)
	movq	%rdi, %r9
	movq	%r8, %r10
	andnq	%r10, %r9, %r9
	xorq	%rdx, %r9
	movq	%r9, 568(%rsp)
	movq	%r8, %rdx
	movq	%rcx, %r9
	andnq	%r9, %rdx, %rdx
	xorq	%rdi, %rdx
	movq	%rdx, 576(%rsp)
	andnq	%rsi, %rcx, %rcx
	xorq	%r8, %rcx
	movq	%rcx, 584(%rsp)
	incq	%rax
	movq	200(%rsp,%rax,8), %rcx
	movq	392(%rsp), %rdx
	xorq	432(%rsp), %rdx
	xorq	472(%rsp), %rdx
	xorq	512(%rsp), %rdx
	xorq	552(%rsp), %rdx
	movq	400(%rsp), %rsi
	xorq	440(%rsp), %rsi
	xorq	480(%rsp), %rsi
	xorq	520(%rsp), %rsi
	xorq	560(%rsp), %rsi
	movq	408(%rsp), %rdi
	xorq	448(%rsp), %rdi
	xorq	488(%rsp), %rdi
	xorq	528(%rsp), %rdi
	xorq	568(%rsp), %rdi
	movq	416(%rsp), %r8
	xorq	456(%rsp), %r8
	xorq	496(%rsp), %r8
	xorq	536(%rsp), %r8
	xorq	576(%rsp), %r8
	movq	424(%rsp), %r9
	xorq	464(%rsp), %r9
	xorq	504(%rsp), %r9
	xorq	544(%rsp), %r9
	xorq	584(%rsp), %r9
	movq	%rsi, %r10
	rolq	$1, %r10
	xorq	%r9, %r10
	movq	%rdi, %r11
	rolq	$1, %r11
	xorq	%rdx, %r11
	movq	%r8, %rbp
	rolq	$1, %rbp
	xorq	%rsi, %rbp
	movq	%r9, %rsi
	rolq	$1, %rsi
	xorq	%rdi, %rsi
	rolq	$1, %rdx
	xorq	%r8, %rdx
	movq	392(%rsp), %rdi
	xorq	%r10, %rdi
	movq	440(%rsp), %r8
	xorq	%r11, %r8
	rolq	$44, %r8
	movq	488(%rsp), %r9
	xorq	%rbp, %r9
	rolq	$43, %r9
	movq	536(%rsp), %rbx
	xorq	%rsi, %rbx
	rolq	$21, %rbx
	movq	584(%rsp), %r12
	xorq	%rdx, %r12
	rolq	$14, %r12
	movq	%r8, %r13
	movq	%r9, %r14
	andnq	%r14, %r13, %r13
	xorq	%rcx, %r13
	xorq	%rdi, %r13
	movq	%r13, (%rsp)
	movq	%r9, %rcx
	movq	%rbx, %r13
	andnq	%r13, %rcx, %rcx
	xorq	%r8, %rcx
	movq	%rcx, 8(%rsp)
	movq	%rbx, %rcx
	movq	%r12, %r13
	andnq	%r13, %rcx, %rcx
	xorq	%r9, %rcx
	movq	%rcx, 16(%rsp)
	movq	%r12, %rcx
	movq	%rdi, %r9
	andnq	%r9, %rcx, %rcx
	xorq	%rbx, %rcx
	movq	%rcx, 24(%rsp)
	andnq	%r8, %rdi, %rcx
	xorq	%r12, %rcx
	movq	%rcx, 32(%rsp)
	movq	416(%rsp), %rcx
	xorq	%rsi, %rcx
	rolq	$28, %rcx
	movq	464(%rsp), %rdi
	xorq	%rdx, %rdi
	rolq	$20, %rdi
	movq	472(%rsp), %r8
	xorq	%r10, %r8
	rolq	$3, %r8
	movq	520(%rsp), %r9
	xorq	%r11, %r9
	rolq	$45, %r9
	movq	568(%rsp), %rbx
	xorq	%rbp, %rbx
	rolq	$61, %rbx
	movq	%rdi, %r12
	movq	%r8, %r13
	andnq	%r13, %r12, %r12
	xorq	%rcx, %r12
	movq	%r12, 40(%rsp)
	movq	%r8, %r12
	movq	%r9, %r13
	andnq	%r13, %r12, %r12
	xorq	%rdi, %r12
	movq	%r12, 48(%rsp)
	movq	%r9, %r12
	movq	%rbx, %r13
	andnq	%r13, %r12, %r12
	xorq	%r8, %r12
	movq	%r12, 56(%rsp)
	movq	%rbx, %r8
	movq	%rcx, %r12
	andnq	%r12, %r8, %r8
	xorq	%r9, %r8
	movq	%r8, 64(%rsp)
	andnq	%rdi, %rcx, %rcx
	xorq	%rbx, %rcx
	movq	%rcx, 72(%rsp)
	movq	400(%rsp), %rcx
	xorq	%r11, %rcx
	rolq	$1, %rcx
	movq	448(%rsp), %rdi
	xorq	%rbp, %rdi
	rolq	$6, %rdi
	movq	496(%rsp), %r8
	xorq	%rsi, %r8
	rolq	$25, %r8
	movq	544(%rsp), %r9
	xorq	%rdx, %r9
	rolq	$8, %r9
	movq	552(%rsp), %rbx
	xorq	%r10, %rbx
	rolq	$18, %rbx
	movq	%rdi, %r12
	movq	%r8, %r13
	andnq	%r13, %r12, %r12
	xorq	%rcx, %r12
	movq	%r12, 80(%rsp)
	movq	%r8, %r12
	movq	%r9, %r13
	andnq	%r13, %r12, %r12
	xorq	%rdi, %r12
	movq	%r12, 88(%rsp)
	movq	%r9, %r12
	movq	%rbx, %r13
	andnq	%r13, %r12, %r12
	xorq	%r8, %r12
	movq	%r12, 96(%rsp)
	movq	%rbx, %r8
	movq	%rcx, %r12
	andnq	%r12, %r8, %r8
	xorq	%r9, %r8
	movq	%r8, 104(%rsp)
	andnq	%rdi, %rcx, %rcx
	xorq	%rbx, %rcx
	movq	%rcx, 112(%rsp)
	movq	424(%rsp), %rcx
	xorq	%rdx, %rcx
	rolq	$27, %rcx
	movq	432(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$36, %rdi
	movq	480(%rsp), %r8
	xorq	%r11, %r8
	rolq	$10, %r8
	movq	528(%rsp), %r9
	xorq	%rbp, %r9
	rolq	$15, %r9
	movq	576(%rsp), %rbx
	xorq	%rsi, %rbx
	rolq	$56, %rbx
	movq	%rdi, %r12
	movq	%r8, %r13
	andnq	%r13, %r12, %r12
	xorq	%rcx, %r12
	movq	%r12, 120(%rsp)
	movq	%r8, %r12
	movq	%r9, %r13
	andnq	%r13, %r12, %r12
	xorq	%rdi, %r12
	movq	%r12, 128(%rsp)
	movq	%r9, %r12
	movq	%rbx, %r13
	andnq	%r13, %r12, %r12
	xorq	%r8, %r12
	movq	%r12, 136(%rsp)
	movq	%rbx, %r8
	movq	%rcx, %r12
	andnq	%r12, %r8, %r8
	xorq	%r9, %r8
	movq	%r8, 144(%rsp)
	andnq	%rdi, %rcx, %rcx
	xorq	%rbx, %rcx
	movq	%rcx, 152(%rsp)
	movq	408(%rsp), %rcx
	xorq	%rbp, %rcx
	rolq	$62, %rcx
	movq	456(%rsp), %rdi
	xorq	%rsi, %rdi
	rolq	$55, %rdi
	movq	%rdi, %rsi
	movq	504(%rsp), %rdi
	xorq	%rdx, %rdi
	rolq	$39, %rdi
	movq	%rdi, %rdx
	movq	512(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$41, %rdi
	movq	560(%rsp), %r8
	xorq	%r11, %r8
	rolq	$2, %r8
	movq	%rsi, %r9
	movq	%rdx, %r10
	andnq	%r10, %r9, %r9
	xorq	%rcx, %r9
	movq	%r9, 160(%rsp)
	movq	%rdx, %r9
	movq	%rdi, %r10
	andnq	%r10, %r9, %r9
	xorq	%rsi, %r9
	movq	%r9, 168(%rsp)
	movq	%rdi, %r9
	movq	%r8, %r10
	andnq	%r10, %r9, %r9
	xorq	%rdx, %r9
	movq	%r9, 176(%rsp)
	movq	%r8, %rdx
	movq	%rcx, %r9
	andnq	%r9, %rdx, %rdx
	xorq	%rdi, %rdx
	movq	%rdx, 184(%rsp)
	andnq	%rsi, %rcx, %rcx
	xorq	%r8, %rcx
	movq	%rcx, 192(%rsp)
	incq	%rax
Lshake256_ref2x$21:
	cmpq	$24, %rax
	jb  	Lshake256_ref2x$22
	movq	600(%rsp), %rsi
	movq	592(%rsp), %rdi
Lshake256_ref2x$19:
	cmpq	$136, %rsi
	jnb 	Lshake256_ref2x$20
	movq	$0, %rax
	movq	%rsi, %rcx
	shrq	$3, %rcx
	jmp 	Lshake256_ref2x$17
Lshake256_ref2x$18:
	movq	(%rdi,%rax,8), %rdx
	xorq	%rdx, (%rsp,%rax,8)
	incq	%rax
Lshake256_ref2x$17:
	cmpq	%rcx, %rax
	jb  	Lshake256_ref2x$18
	shlq	$3, %rax
	jmp 	Lshake256_ref2x$15
Lshake256_ref2x$16:
	movb	(%rdi,%rax), %cl
	xorb	%cl, (%rsp,%rax)
	incq	%rax
Lshake256_ref2x$15:
	cmpq	%rsi, %rax
	jb  	Lshake256_ref2x$16
	xorb	$31, (%rsp,%rax)
	xorb	$-128, 135(%rsp)
	movq	$0, %rax
	jmp 	Lshake256_ref2x$13
Lshake256_ref2x$14:
	movq	200(%rsp,%rax,8), %rcx
	movq	(%rsp), %rdx
	xorq	40(%rsp), %rdx
	xorq	80(%rsp), %rdx
	xorq	120(%rsp), %rdx
	xorq	160(%rsp), %rdx
	movq	8(%rsp), %rsi
	xorq	48(%rsp), %rsi
	xorq	88(%rsp), %rsi
	xorq	128(%rsp), %rsi
	xorq	168(%rsp), %rsi
	movq	16(%rsp), %rdi
	xorq	56(%rsp), %rdi
	xorq	96(%rsp), %rdi
	xorq	136(%rsp), %rdi
	xorq	176(%rsp), %rdi
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
	movq	%rsi, %r10
	rolq	$1, %r10
	xorq	%r9, %r10
	movq	%rdi, %r11
	rolq	$1, %r11
	xorq	%rdx, %r11
	movq	%r8, %rbp
	rolq	$1, %rbp
	xorq	%rsi, %rbp
	movq	%r9, %rsi
	rolq	$1, %rsi
	xorq	%rdi, %rsi
	rolq	$1, %rdx
	xorq	%r8, %rdx
	movq	(%rsp), %rdi
	xorq	%r10, %rdi
	movq	48(%rsp), %r8
	xorq	%r11, %r8
	rolq	$44, %r8
	movq	96(%rsp), %r9
	xorq	%rbp, %r9
	rolq	$43, %r9
	movq	144(%rsp), %rbx
	xorq	%rsi, %rbx
	rolq	$21, %rbx
	movq	192(%rsp), %r12
	xorq	%rdx, %r12
	rolq	$14, %r12
	movq	%r8, %r13
	movq	%r9, %r14
	andnq	%r14, %r13, %r13
	xorq	%rcx, %r13
	xorq	%rdi, %r13
	movq	%r13, 392(%rsp)
	movq	%r9, %rcx
	movq	%rbx, %r13
	andnq	%r13, %rcx, %rcx
	xorq	%r8, %rcx
	movq	%rcx, 400(%rsp)
	movq	%rbx, %rcx
	movq	%r12, %r13
	andnq	%r13, %rcx, %rcx
	xorq	%r9, %rcx
	movq	%rcx, 408(%rsp)
	movq	%r12, %rcx
	movq	%rdi, %r9
	andnq	%r9, %rcx, %rcx
	xorq	%rbx, %rcx
	movq	%rcx, 416(%rsp)
	andnq	%r8, %rdi, %rcx
	xorq	%r12, %rcx
	movq	%rcx, 424(%rsp)
	movq	24(%rsp), %rcx
	xorq	%rsi, %rcx
	rolq	$28, %rcx
	movq	72(%rsp), %rdi
	xorq	%rdx, %rdi
	rolq	$20, %rdi
	movq	80(%rsp), %r8
	xorq	%r10, %r8
	rolq	$3, %r8
	movq	128(%rsp), %r9
	xorq	%r11, %r9
	rolq	$45, %r9
	movq	176(%rsp), %rbx
	xorq	%rbp, %rbx
	rolq	$61, %rbx
	movq	%rdi, %r12
	movq	%r8, %r13
	andnq	%r13, %r12, %r12
	xorq	%rcx, %r12
	movq	%r12, 432(%rsp)
	movq	%r8, %r12
	movq	%r9, %r13
	andnq	%r13, %r12, %r12
	xorq	%rdi, %r12
	movq	%r12, 440(%rsp)
	movq	%r9, %r12
	movq	%rbx, %r13
	andnq	%r13, %r12, %r12
	xorq	%r8, %r12
	movq	%r12, 448(%rsp)
	movq	%rbx, %r8
	movq	%rcx, %r12
	andnq	%r12, %r8, %r8
	xorq	%r9, %r8
	movq	%r8, 456(%rsp)
	andnq	%rdi, %rcx, %rcx
	xorq	%rbx, %rcx
	movq	%rcx, 464(%rsp)
	movq	8(%rsp), %rcx
	xorq	%r11, %rcx
	rolq	$1, %rcx
	movq	56(%rsp), %rdi
	xorq	%rbp, %rdi
	rolq	$6, %rdi
	movq	104(%rsp), %r8
	xorq	%rsi, %r8
	rolq	$25, %r8
	movq	152(%rsp), %r9
	xorq	%rdx, %r9
	rolq	$8, %r9
	movq	160(%rsp), %rbx
	xorq	%r10, %rbx
	rolq	$18, %rbx
	movq	%rdi, %r12
	movq	%r8, %r13
	andnq	%r13, %r12, %r12
	xorq	%rcx, %r12
	movq	%r12, 472(%rsp)
	movq	%r8, %r12
	movq	%r9, %r13
	andnq	%r13, %r12, %r12
	xorq	%rdi, %r12
	movq	%r12, 480(%rsp)
	movq	%r9, %r12
	movq	%rbx, %r13
	andnq	%r13, %r12, %r12
	xorq	%r8, %r12
	movq	%r12, 488(%rsp)
	movq	%rbx, %r8
	movq	%rcx, %r12
	andnq	%r12, %r8, %r8
	xorq	%r9, %r8
	movq	%r8, 496(%rsp)
	andnq	%rdi, %rcx, %rcx
	xorq	%rbx, %rcx
	movq	%rcx, 504(%rsp)
	movq	32(%rsp), %rcx
	xorq	%rdx, %rcx
	rolq	$27, %rcx
	movq	40(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$36, %rdi
	movq	88(%rsp), %r8
	xorq	%r11, %r8
	rolq	$10, %r8
	movq	136(%rsp), %r9
	xorq	%rbp, %r9
	rolq	$15, %r9
	movq	184(%rsp), %rbx
	xorq	%rsi, %rbx
	rolq	$56, %rbx
	movq	%rdi, %r12
	movq	%r8, %r13
	andnq	%r13, %r12, %r12
	xorq	%rcx, %r12
	movq	%r12, 512(%rsp)
	movq	%r8, %r12
	movq	%r9, %r13
	andnq	%r13, %r12, %r12
	xorq	%rdi, %r12
	movq	%r12, 520(%rsp)
	movq	%r9, %r12
	movq	%rbx, %r13
	andnq	%r13, %r12, %r12
	xorq	%r8, %r12
	movq	%r12, 528(%rsp)
	movq	%rbx, %r8
	movq	%rcx, %r12
	andnq	%r12, %r8, %r8
	xorq	%r9, %r8
	movq	%r8, 536(%rsp)
	andnq	%rdi, %rcx, %rcx
	xorq	%rbx, %rcx
	movq	%rcx, 544(%rsp)
	movq	16(%rsp), %rcx
	xorq	%rbp, %rcx
	rolq	$62, %rcx
	movq	64(%rsp), %rdi
	xorq	%rsi, %rdi
	rolq	$55, %rdi
	movq	%rdi, %rsi
	movq	112(%rsp), %rdi
	xorq	%rdx, %rdi
	rolq	$39, %rdi
	movq	%rdi, %rdx
	movq	120(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$41, %rdi
	movq	168(%rsp), %r8
	xorq	%r11, %r8
	rolq	$2, %r8
	movq	%rsi, %r9
	movq	%rdx, %r10
	andnq	%r10, %r9, %r9
	xorq	%rcx, %r9
	movq	%r9, 552(%rsp)
	movq	%rdx, %r9
	movq	%rdi, %r10
	andnq	%r10, %r9, %r9
	xorq	%rsi, %r9
	movq	%r9, 560(%rsp)
	movq	%rdi, %r9
	movq	%r8, %r10
	andnq	%r10, %r9, %r9
	xorq	%rdx, %r9
	movq	%r9, 568(%rsp)
	movq	%r8, %rdx
	movq	%rcx, %r9
	andnq	%r9, %rdx, %rdx
	xorq	%rdi, %rdx
	movq	%rdx, 576(%rsp)
	andnq	%rsi, %rcx, %rcx
	xorq	%r8, %rcx
	movq	%rcx, 584(%rsp)
	incq	%rax
	movq	200(%rsp,%rax,8), %rcx
	movq	392(%rsp), %rdx
	xorq	432(%rsp), %rdx
	xorq	472(%rsp), %rdx
	xorq	512(%rsp), %rdx
	xorq	552(%rsp), %rdx
	movq	400(%rsp), %rsi
	xorq	440(%rsp), %rsi
	xorq	480(%rsp), %rsi
	xorq	520(%rsp), %rsi
	xorq	560(%rsp), %rsi
	movq	408(%rsp), %rdi
	xorq	448(%rsp), %rdi
	xorq	488(%rsp), %rdi
	xorq	528(%rsp), %rdi
	xorq	568(%rsp), %rdi
	movq	416(%rsp), %r8
	xorq	456(%rsp), %r8
	xorq	496(%rsp), %r8
	xorq	536(%rsp), %r8
	xorq	576(%rsp), %r8
	movq	424(%rsp), %r9
	xorq	464(%rsp), %r9
	xorq	504(%rsp), %r9
	xorq	544(%rsp), %r9
	xorq	584(%rsp), %r9
	movq	%rsi, %r10
	rolq	$1, %r10
	xorq	%r9, %r10
	movq	%rdi, %r11
	rolq	$1, %r11
	xorq	%rdx, %r11
	movq	%r8, %rbp
	rolq	$1, %rbp
	xorq	%rsi, %rbp
	movq	%r9, %rsi
	rolq	$1, %rsi
	xorq	%rdi, %rsi
	rolq	$1, %rdx
	xorq	%r8, %rdx
	movq	392(%rsp), %rdi
	xorq	%r10, %rdi
	movq	440(%rsp), %r8
	xorq	%r11, %r8
	rolq	$44, %r8
	movq	488(%rsp), %r9
	xorq	%rbp, %r9
	rolq	$43, %r9
	movq	536(%rsp), %rbx
	xorq	%rsi, %rbx
	rolq	$21, %rbx
	movq	584(%rsp), %r12
	xorq	%rdx, %r12
	rolq	$14, %r12
	movq	%r8, %r13
	movq	%r9, %r14
	andnq	%r14, %r13, %r13
	xorq	%rcx, %r13
	xorq	%rdi, %r13
	movq	%r13, (%rsp)
	movq	%r9, %rcx
	movq	%rbx, %r13
	andnq	%r13, %rcx, %rcx
	xorq	%r8, %rcx
	movq	%rcx, 8(%rsp)
	movq	%rbx, %rcx
	movq	%r12, %r13
	andnq	%r13, %rcx, %rcx
	xorq	%r9, %rcx
	movq	%rcx, 16(%rsp)
	movq	%r12, %rcx
	movq	%rdi, %r9
	andnq	%r9, %rcx, %rcx
	xorq	%rbx, %rcx
	movq	%rcx, 24(%rsp)
	andnq	%r8, %rdi, %rcx
	xorq	%r12, %rcx
	movq	%rcx, 32(%rsp)
	movq	416(%rsp), %rcx
	xorq	%rsi, %rcx
	rolq	$28, %rcx
	movq	464(%rsp), %rdi
	xorq	%rdx, %rdi
	rolq	$20, %rdi
	movq	472(%rsp), %r8
	xorq	%r10, %r8
	rolq	$3, %r8
	movq	520(%rsp), %r9
	xorq	%r11, %r9
	rolq	$45, %r9
	movq	568(%rsp), %rbx
	xorq	%rbp, %rbx
	rolq	$61, %rbx
	movq	%rdi, %r12
	movq	%r8, %r13
	andnq	%r13, %r12, %r12
	xorq	%rcx, %r12
	movq	%r12, 40(%rsp)
	movq	%r8, %r12
	movq	%r9, %r13
	andnq	%r13, %r12, %r12
	xorq	%rdi, %r12
	movq	%r12, 48(%rsp)
	movq	%r9, %r12
	movq	%rbx, %r13
	andnq	%r13, %r12, %r12
	xorq	%r8, %r12
	movq	%r12, 56(%rsp)
	movq	%rbx, %r8
	movq	%rcx, %r12
	andnq	%r12, %r8, %r8
	xorq	%r9, %r8
	movq	%r8, 64(%rsp)
	andnq	%rdi, %rcx, %rcx
	xorq	%rbx, %rcx
	movq	%rcx, 72(%rsp)
	movq	400(%rsp), %rcx
	xorq	%r11, %rcx
	rolq	$1, %rcx
	movq	448(%rsp), %rdi
	xorq	%rbp, %rdi
	rolq	$6, %rdi
	movq	496(%rsp), %r8
	xorq	%rsi, %r8
	rolq	$25, %r8
	movq	544(%rsp), %r9
	xorq	%rdx, %r9
	rolq	$8, %r9
	movq	552(%rsp), %rbx
	xorq	%r10, %rbx
	rolq	$18, %rbx
	movq	%rdi, %r12
	movq	%r8, %r13
	andnq	%r13, %r12, %r12
	xorq	%rcx, %r12
	movq	%r12, 80(%rsp)
	movq	%r8, %r12
	movq	%r9, %r13
	andnq	%r13, %r12, %r12
	xorq	%rdi, %r12
	movq	%r12, 88(%rsp)
	movq	%r9, %r12
	movq	%rbx, %r13
	andnq	%r13, %r12, %r12
	xorq	%r8, %r12
	movq	%r12, 96(%rsp)
	movq	%rbx, %r8
	movq	%rcx, %r12
	andnq	%r12, %r8, %r8
	xorq	%r9, %r8
	movq	%r8, 104(%rsp)
	andnq	%rdi, %rcx, %rcx
	xorq	%rbx, %rcx
	movq	%rcx, 112(%rsp)
	movq	424(%rsp), %rcx
	xorq	%rdx, %rcx
	rolq	$27, %rcx
	movq	432(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$36, %rdi
	movq	480(%rsp), %r8
	xorq	%r11, %r8
	rolq	$10, %r8
	movq	528(%rsp), %r9
	xorq	%rbp, %r9
	rolq	$15, %r9
	movq	576(%rsp), %rbx
	xorq	%rsi, %rbx
	rolq	$56, %rbx
	movq	%rdi, %r12
	movq	%r8, %r13
	andnq	%r13, %r12, %r12
	xorq	%rcx, %r12
	movq	%r12, 120(%rsp)
	movq	%r8, %r12
	movq	%r9, %r13
	andnq	%r13, %r12, %r12
	xorq	%rdi, %r12
	movq	%r12, 128(%rsp)
	movq	%r9, %r12
	movq	%rbx, %r13
	andnq	%r13, %r12, %r12
	xorq	%r8, %r12
	movq	%r12, 136(%rsp)
	movq	%rbx, %r8
	movq	%rcx, %r12
	andnq	%r12, %r8, %r8
	xorq	%r9, %r8
	movq	%r8, 144(%rsp)
	andnq	%rdi, %rcx, %rcx
	xorq	%rbx, %rcx
	movq	%rcx, 152(%rsp)
	movq	408(%rsp), %rcx
	xorq	%rbp, %rcx
	rolq	$62, %rcx
	movq	456(%rsp), %rdi
	xorq	%rsi, %rdi
	rolq	$55, %rdi
	movq	%rdi, %rsi
	movq	504(%rsp), %rdi
	xorq	%rdx, %rdi
	rolq	$39, %rdi
	movq	%rdi, %rdx
	movq	512(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$41, %rdi
	movq	560(%rsp), %r8
	xorq	%r11, %r8
	rolq	$2, %r8
	movq	%rsi, %r9
	movq	%rdx, %r10
	andnq	%r10, %r9, %r9
	xorq	%rcx, %r9
	movq	%r9, 160(%rsp)
	movq	%rdx, %r9
	movq	%rdi, %r10
	andnq	%r10, %r9, %r9
	xorq	%rsi, %r9
	movq	%r9, 168(%rsp)
	movq	%rdi, %r9
	movq	%r8, %r10
	andnq	%r10, %r9, %r9
	xorq	%rdx, %r9
	movq	%r9, 176(%rsp)
	movq	%r8, %rdx
	movq	%rcx, %r9
	andnq	%r9, %rdx, %rdx
	xorq	%rdi, %rdx
	movq	%rdx, 184(%rsp)
	andnq	%rsi, %rcx, %rcx
	xorq	%r8, %rcx
	movq	%rcx, 192(%rsp)
	incq	%rax
Lshake256_ref2x$13:
	cmpq	$24, %rax
	jb  	Lshake256_ref2x$14
	movq	616(%rsp), %rax
	movq	608(%rsp), %rcx
	shrq	$3, %rcx
	jmp 	Lshake256_ref2x$5
Lshake256_ref2x$6:
	movq	$136, %rdx
	movq	$0, %rsi
	movq	$8, %rdi
	jmp 	Lshake256_ref2x$11
Lshake256_ref2x$12:
	movq	(%rsp,%rsi,8), %r8
	movq	%r8, (%rax,%rsi,8)
	incq	%rsi
	addq	$8, %rdi
Lshake256_ref2x$11:
	cmpq	%rdx, %rdi
	jbe 	Lshake256_ref2x$12
	shrq	$3, %rsi
	jmp 	Lshake256_ref2x$9
Lshake256_ref2x$10:
	movb	(%rsp,%rsi), %dil
	movb	%dil, (%rax,%rsi)
	incq	%rsi
Lshake256_ref2x$9:
	cmpq	%rdx, %rsi
	jb  	Lshake256_ref2x$10
	addq	$-136, %rcx
	addq	$136, %rax
	movq	%rcx, 616(%rsp)
	movq	%rax, 608(%rsp)
	movq	$0, %rax
	jmp 	Lshake256_ref2x$7
Lshake256_ref2x$8:
	movq	200(%rsp,%rax,8), %rcx
	movq	(%rsp), %rdx
	xorq	40(%rsp), %rdx
	xorq	80(%rsp), %rdx
	xorq	120(%rsp), %rdx
	xorq	160(%rsp), %rdx
	movq	8(%rsp), %rsi
	xorq	48(%rsp), %rsi
	xorq	88(%rsp), %rsi
	xorq	128(%rsp), %rsi
	xorq	168(%rsp), %rsi
	movq	16(%rsp), %rdi
	xorq	56(%rsp), %rdi
	xorq	96(%rsp), %rdi
	xorq	136(%rsp), %rdi
	xorq	176(%rsp), %rdi
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
	movq	%rsi, %r10
	rolq	$1, %r10
	xorq	%r9, %r10
	movq	%rdi, %r11
	rolq	$1, %r11
	xorq	%rdx, %r11
	movq	%r8, %rbp
	rolq	$1, %rbp
	xorq	%rsi, %rbp
	movq	%r9, %rsi
	rolq	$1, %rsi
	xorq	%rdi, %rsi
	rolq	$1, %rdx
	xorq	%r8, %rdx
	movq	(%rsp), %rdi
	xorq	%r10, %rdi
	movq	48(%rsp), %r8
	xorq	%r11, %r8
	rolq	$44, %r8
	movq	96(%rsp), %r9
	xorq	%rbp, %r9
	rolq	$43, %r9
	movq	144(%rsp), %rbx
	xorq	%rsi, %rbx
	rolq	$21, %rbx
	movq	192(%rsp), %r12
	xorq	%rdx, %r12
	rolq	$14, %r12
	movq	%r8, %r13
	movq	%r9, %r14
	andnq	%r14, %r13, %r13
	xorq	%rcx, %r13
	xorq	%rdi, %r13
	movq	%r13, 392(%rsp)
	movq	%r9, %rcx
	movq	%rbx, %r13
	andnq	%r13, %rcx, %rcx
	xorq	%r8, %rcx
	movq	%rcx, 400(%rsp)
	movq	%rbx, %rcx
	movq	%r12, %r13
	andnq	%r13, %rcx, %rcx
	xorq	%r9, %rcx
	movq	%rcx, 408(%rsp)
	movq	%r12, %rcx
	movq	%rdi, %r9
	andnq	%r9, %rcx, %rcx
	xorq	%rbx, %rcx
	movq	%rcx, 416(%rsp)
	andnq	%r8, %rdi, %rcx
	xorq	%r12, %rcx
	movq	%rcx, 424(%rsp)
	movq	24(%rsp), %rcx
	xorq	%rsi, %rcx
	rolq	$28, %rcx
	movq	72(%rsp), %rdi
	xorq	%rdx, %rdi
	rolq	$20, %rdi
	movq	80(%rsp), %r8
	xorq	%r10, %r8
	rolq	$3, %r8
	movq	128(%rsp), %r9
	xorq	%r11, %r9
	rolq	$45, %r9
	movq	176(%rsp), %rbx
	xorq	%rbp, %rbx
	rolq	$61, %rbx
	movq	%rdi, %r12
	movq	%r8, %r13
	andnq	%r13, %r12, %r12
	xorq	%rcx, %r12
	movq	%r12, 432(%rsp)
	movq	%r8, %r12
	movq	%r9, %r13
	andnq	%r13, %r12, %r12
	xorq	%rdi, %r12
	movq	%r12, 440(%rsp)
	movq	%r9, %r12
	movq	%rbx, %r13
	andnq	%r13, %r12, %r12
	xorq	%r8, %r12
	movq	%r12, 448(%rsp)
	movq	%rbx, %r8
	movq	%rcx, %r12
	andnq	%r12, %r8, %r8
	xorq	%r9, %r8
	movq	%r8, 456(%rsp)
	andnq	%rdi, %rcx, %rcx
	xorq	%rbx, %rcx
	movq	%rcx, 464(%rsp)
	movq	8(%rsp), %rcx
	xorq	%r11, %rcx
	rolq	$1, %rcx
	movq	56(%rsp), %rdi
	xorq	%rbp, %rdi
	rolq	$6, %rdi
	movq	104(%rsp), %r8
	xorq	%rsi, %r8
	rolq	$25, %r8
	movq	152(%rsp), %r9
	xorq	%rdx, %r9
	rolq	$8, %r9
	movq	160(%rsp), %rbx
	xorq	%r10, %rbx
	rolq	$18, %rbx
	movq	%rdi, %r12
	movq	%r8, %r13
	andnq	%r13, %r12, %r12
	xorq	%rcx, %r12
	movq	%r12, 472(%rsp)
	movq	%r8, %r12
	movq	%r9, %r13
	andnq	%r13, %r12, %r12
	xorq	%rdi, %r12
	movq	%r12, 480(%rsp)
	movq	%r9, %r12
	movq	%rbx, %r13
	andnq	%r13, %r12, %r12
	xorq	%r8, %r12
	movq	%r12, 488(%rsp)
	movq	%rbx, %r8
	movq	%rcx, %r12
	andnq	%r12, %r8, %r8
	xorq	%r9, %r8
	movq	%r8, 496(%rsp)
	andnq	%rdi, %rcx, %rcx
	xorq	%rbx, %rcx
	movq	%rcx, 504(%rsp)
	movq	32(%rsp), %rcx
	xorq	%rdx, %rcx
	rolq	$27, %rcx
	movq	40(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$36, %rdi
	movq	88(%rsp), %r8
	xorq	%r11, %r8
	rolq	$10, %r8
	movq	136(%rsp), %r9
	xorq	%rbp, %r9
	rolq	$15, %r9
	movq	184(%rsp), %rbx
	xorq	%rsi, %rbx
	rolq	$56, %rbx
	movq	%rdi, %r12
	movq	%r8, %r13
	andnq	%r13, %r12, %r12
	xorq	%rcx, %r12
	movq	%r12, 512(%rsp)
	movq	%r8, %r12
	movq	%r9, %r13
	andnq	%r13, %r12, %r12
	xorq	%rdi, %r12
	movq	%r12, 520(%rsp)
	movq	%r9, %r12
	movq	%rbx, %r13
	andnq	%r13, %r12, %r12
	xorq	%r8, %r12
	movq	%r12, 528(%rsp)
	movq	%rbx, %r8
	movq	%rcx, %r12
	andnq	%r12, %r8, %r8
	xorq	%r9, %r8
	movq	%r8, 536(%rsp)
	andnq	%rdi, %rcx, %rcx
	xorq	%rbx, %rcx
	movq	%rcx, 544(%rsp)
	movq	16(%rsp), %rcx
	xorq	%rbp, %rcx
	rolq	$62, %rcx
	movq	64(%rsp), %rdi
	xorq	%rsi, %rdi
	rolq	$55, %rdi
	movq	%rdi, %rsi
	movq	112(%rsp), %rdi
	xorq	%rdx, %rdi
	rolq	$39, %rdi
	movq	%rdi, %rdx
	movq	120(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$41, %rdi
	movq	168(%rsp), %r8
	xorq	%r11, %r8
	rolq	$2, %r8
	movq	%rsi, %r9
	movq	%rdx, %r10
	andnq	%r10, %r9, %r9
	xorq	%rcx, %r9
	movq	%r9, 552(%rsp)
	movq	%rdx, %r9
	movq	%rdi, %r10
	andnq	%r10, %r9, %r9
	xorq	%rsi, %r9
	movq	%r9, 560(%rsp)
	movq	%rdi, %r9
	movq	%r8, %r10
	andnq	%r10, %r9, %r9
	xorq	%rdx, %r9
	movq	%r9, 568(%rsp)
	movq	%r8, %rdx
	movq	%rcx, %r9
	andnq	%r9, %rdx, %rdx
	xorq	%rdi, %rdx
	movq	%rdx, 576(%rsp)
	andnq	%rsi, %rcx, %rcx
	xorq	%r8, %rcx
	movq	%rcx, 584(%rsp)
	incq	%rax
	movq	200(%rsp,%rax,8), %rcx
	movq	392(%rsp), %rdx
	xorq	432(%rsp), %rdx
	xorq	472(%rsp), %rdx
	xorq	512(%rsp), %rdx
	xorq	552(%rsp), %rdx
	movq	400(%rsp), %rsi
	xorq	440(%rsp), %rsi
	xorq	480(%rsp), %rsi
	xorq	520(%rsp), %rsi
	xorq	560(%rsp), %rsi
	movq	408(%rsp), %rdi
	xorq	448(%rsp), %rdi
	xorq	488(%rsp), %rdi
	xorq	528(%rsp), %rdi
	xorq	568(%rsp), %rdi
	movq	416(%rsp), %r8
	xorq	456(%rsp), %r8
	xorq	496(%rsp), %r8
	xorq	536(%rsp), %r8
	xorq	576(%rsp), %r8
	movq	424(%rsp), %r9
	xorq	464(%rsp), %r9
	xorq	504(%rsp), %r9
	xorq	544(%rsp), %r9
	xorq	584(%rsp), %r9
	movq	%rsi, %r10
	rolq	$1, %r10
	xorq	%r9, %r10
	movq	%rdi, %r11
	rolq	$1, %r11
	xorq	%rdx, %r11
	movq	%r8, %rbp
	rolq	$1, %rbp
	xorq	%rsi, %rbp
	movq	%r9, %rsi
	rolq	$1, %rsi
	xorq	%rdi, %rsi
	rolq	$1, %rdx
	xorq	%r8, %rdx
	movq	392(%rsp), %rdi
	xorq	%r10, %rdi
	movq	440(%rsp), %r8
	xorq	%r11, %r8
	rolq	$44, %r8
	movq	488(%rsp), %r9
	xorq	%rbp, %r9
	rolq	$43, %r9
	movq	536(%rsp), %rbx
	xorq	%rsi, %rbx
	rolq	$21, %rbx
	movq	584(%rsp), %r12
	xorq	%rdx, %r12
	rolq	$14, %r12
	movq	%r8, %r13
	movq	%r9, %r14
	andnq	%r14, %r13, %r13
	xorq	%rcx, %r13
	xorq	%rdi, %r13
	movq	%r13, (%rsp)
	movq	%r9, %rcx
	movq	%rbx, %r13
	andnq	%r13, %rcx, %rcx
	xorq	%r8, %rcx
	movq	%rcx, 8(%rsp)
	movq	%rbx, %rcx
	movq	%r12, %r13
	andnq	%r13, %rcx, %rcx
	xorq	%r9, %rcx
	movq	%rcx, 16(%rsp)
	movq	%r12, %rcx
	movq	%rdi, %r9
	andnq	%r9, %rcx, %rcx
	xorq	%rbx, %rcx
	movq	%rcx, 24(%rsp)
	andnq	%r8, %rdi, %rcx
	xorq	%r12, %rcx
	movq	%rcx, 32(%rsp)
	movq	416(%rsp), %rcx
	xorq	%rsi, %rcx
	rolq	$28, %rcx
	movq	464(%rsp), %rdi
	xorq	%rdx, %rdi
	rolq	$20, %rdi
	movq	472(%rsp), %r8
	xorq	%r10, %r8
	rolq	$3, %r8
	movq	520(%rsp), %r9
	xorq	%r11, %r9
	rolq	$45, %r9
	movq	568(%rsp), %rbx
	xorq	%rbp, %rbx
	rolq	$61, %rbx
	movq	%rdi, %r12
	movq	%r8, %r13
	andnq	%r13, %r12, %r12
	xorq	%rcx, %r12
	movq	%r12, 40(%rsp)
	movq	%r8, %r12
	movq	%r9, %r13
	andnq	%r13, %r12, %r12
	xorq	%rdi, %r12
	movq	%r12, 48(%rsp)
	movq	%r9, %r12
	movq	%rbx, %r13
	andnq	%r13, %r12, %r12
	xorq	%r8, %r12
	movq	%r12, 56(%rsp)
	movq	%rbx, %r8
	movq	%rcx, %r12
	andnq	%r12, %r8, %r8
	xorq	%r9, %r8
	movq	%r8, 64(%rsp)
	andnq	%rdi, %rcx, %rcx
	xorq	%rbx, %rcx
	movq	%rcx, 72(%rsp)
	movq	400(%rsp), %rcx
	xorq	%r11, %rcx
	rolq	$1, %rcx
	movq	448(%rsp), %rdi
	xorq	%rbp, %rdi
	rolq	$6, %rdi
	movq	496(%rsp), %r8
	xorq	%rsi, %r8
	rolq	$25, %r8
	movq	544(%rsp), %r9
	xorq	%rdx, %r9
	rolq	$8, %r9
	movq	552(%rsp), %rbx
	xorq	%r10, %rbx
	rolq	$18, %rbx
	movq	%rdi, %r12
	movq	%r8, %r13
	andnq	%r13, %r12, %r12
	xorq	%rcx, %r12
	movq	%r12, 80(%rsp)
	movq	%r8, %r12
	movq	%r9, %r13
	andnq	%r13, %r12, %r12
	xorq	%rdi, %r12
	movq	%r12, 88(%rsp)
	movq	%r9, %r12
	movq	%rbx, %r13
	andnq	%r13, %r12, %r12
	xorq	%r8, %r12
	movq	%r12, 96(%rsp)
	movq	%rbx, %r8
	movq	%rcx, %r12
	andnq	%r12, %r8, %r8
	xorq	%r9, %r8
	movq	%r8, 104(%rsp)
	andnq	%rdi, %rcx, %rcx
	xorq	%rbx, %rcx
	movq	%rcx, 112(%rsp)
	movq	424(%rsp), %rcx
	xorq	%rdx, %rcx
	rolq	$27, %rcx
	movq	432(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$36, %rdi
	movq	480(%rsp), %r8
	xorq	%r11, %r8
	rolq	$10, %r8
	movq	528(%rsp), %r9
	xorq	%rbp, %r9
	rolq	$15, %r9
	movq	576(%rsp), %rbx
	xorq	%rsi, %rbx
	rolq	$56, %rbx
	movq	%rdi, %r12
	movq	%r8, %r13
	andnq	%r13, %r12, %r12
	xorq	%rcx, %r12
	movq	%r12, 120(%rsp)
	movq	%r8, %r12
	movq	%r9, %r13
	andnq	%r13, %r12, %r12
	xorq	%rdi, %r12
	movq	%r12, 128(%rsp)
	movq	%r9, %r12
	movq	%rbx, %r13
	andnq	%r13, %r12, %r12
	xorq	%r8, %r12
	movq	%r12, 136(%rsp)
	movq	%rbx, %r8
	movq	%rcx, %r12
	andnq	%r12, %r8, %r8
	xorq	%r9, %r8
	movq	%r8, 144(%rsp)
	andnq	%rdi, %rcx, %rcx
	xorq	%rbx, %rcx
	movq	%rcx, 152(%rsp)
	movq	408(%rsp), %rcx
	xorq	%rbp, %rcx
	rolq	$62, %rcx
	movq	456(%rsp), %rdi
	xorq	%rsi, %rdi
	rolq	$55, %rdi
	movq	%rdi, %rsi
	movq	504(%rsp), %rdi
	xorq	%rdx, %rdi
	rolq	$39, %rdi
	movq	%rdi, %rdx
	movq	512(%rsp), %rdi
	xorq	%r10, %rdi
	rolq	$41, %rdi
	movq	560(%rsp), %r8
	xorq	%r11, %r8
	rolq	$2, %r8
	movq	%rsi, %r9
	movq	%rdx, %r10
	andnq	%r10, %r9, %r9
	xorq	%rcx, %r9
	movq	%r9, 160(%rsp)
	movq	%rdx, %r9
	movq	%rdi, %r10
	andnq	%r10, %r9, %r9
	xorq	%rsi, %r9
	movq	%r9, 168(%rsp)
	movq	%rdi, %r9
	movq	%r8, %r10
	andnq	%r10, %r9, %r9
	xorq	%rdx, %r9
	movq	%r9, 176(%rsp)
	movq	%r8, %rdx
	movq	%rcx, %r9
	andnq	%r9, %rdx, %rdx
	xorq	%rdi, %rdx
	movq	%rdx, 184(%rsp)
	andnq	%rsi, %rcx, %rcx
	xorq	%r8, %rcx
	movq	%rcx, 192(%rsp)
	incq	%rax
Lshake256_ref2x$7:
	cmpq	$24, %rax
	jb  	Lshake256_ref2x$8
	movq	616(%rsp), %rcx
	movq	608(%rsp), %rax
Lshake256_ref2x$5:
	cmpq	$136, %rcx
	jnb 	Lshake256_ref2x$6
	movq	$0, %rdx
	movq	$8, %rsi
	jmp 	Lshake256_ref2x$3
Lshake256_ref2x$4:
	movq	(%rsp,%rdx,8), %rdi
	movq	%rdi, (%rax,%rdx,8)
	incq	%rdx
	addq	$8, %rsi
Lshake256_ref2x$3:
	cmpq	%rcx, %rsi
	jbe 	Lshake256_ref2x$4
	shrq	$3, %rdx
	jmp 	Lshake256_ref2x$1
Lshake256_ref2x$2:
	movb	(%rsp,%rdx), %sil
	movb	%sil, (%rax,%rdx)
	incq	%rdx
Lshake256_ref2x$1:
	cmpq	%rcx, %rdx
	jb  	Lshake256_ref2x$2
	addq	$624, %rsp
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	ret 

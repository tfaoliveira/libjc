	.text
	.p2align	5
	.globl	_poly1305_ref3
	.globl	poly1305_ref3
_poly1305_ref3:
poly1305_ref3:
	pushq	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$16, %rsp
	movq	$0, %r8
	movq	$0, %r9
	movq	$0, %r10
	movq	(%rcx), %r11
	movq	8(%rcx), %rbp
	movq	$1152921487695413247, %rax
	andq	%rax, %r11
	movq	$1152921487695413244, %rax
	andq	%rax, %rbp
	movq	%rbp, %rbx
	shrq	$2, %rbx
	addq	%rbp, %rbx
	addq	$16, %rcx
	movq	%rdx, %r12
	jmp 	Lpoly1305_ref3$4
Lpoly1305_ref3$5:
	movq	(%rsi), %rax
	movq	8(%rsi), %rdx
	addq	%rax, %r8
	adcq	%rdx, %r9
	adcq	$1, %r10
	movq	%r8, %rax
	mulq	%r11
	movq	%rax, %r13
	movq	%rdx, %r14
	movq	%r9, %rax
	mulq	%rbx
	addq	%rax, %r13
	adcq	%rdx, %r14
	movq	$0, %r15
	movq	%r8, %rax
	mulq	%rbp
	addq	%rax, %r14
	adcq	%rdx, %r15
	movq	%r9, %rax
	mulq	%r11
	addq	%rax, %r14
	adcq	%rdx, %r15
	movq	%r10, %rax
	imulq	%rbx, %rax
	addq	%rax, %r14
	adcq	$0, %r15
	imulq	%r11, %r10
	movq	%r13, %r8
	movq	%r14, %r9
	addq	%r15, %r10
	movq	%r10, %rax
	movq	%r10, %rdx
	andq	$3, %r10
	shrq	$2, %rax
	andq	$-4, %rdx
	addq	%rdx, %rax
	addq	%rax, %r8
	adcq	$0, %r9
	adcq	$0, %r10
	addq	$16, %rsi
	addq	$-16, %r12
Lpoly1305_ref3$4:
	cmpq	$16, %r12
	jnb 	Lpoly1305_ref3$5
	cmpq	$0, %r12
	jbe 	Lpoly1305_ref3$1
	movq	$0, (%rsp)
	movq	$0, 8(%rsp)
	movq	$0, %rax
	jmp 	Lpoly1305_ref3$2
Lpoly1305_ref3$3:
	movb	(%rsi,%rax), %dl
	movb	%dl, (%rsp,%rax)
	incq	%rax
Lpoly1305_ref3$2:
	cmpq	%r12, %rax
	jb  	Lpoly1305_ref3$3
	movb	$1, (%rsp,%rax)
	movq	(%rsp), %rax
	movq	8(%rsp), %rdx
	addq	%rax, %r8
	adcq	%rdx, %r9
	adcq	$0, %r10
	movq	%r8, %rax
	mulq	%r11
	movq	%rax, %rsi
	movq	%rdx, %r12
	movq	%r9, %rax
	mulq	%rbx
	addq	%rax, %rsi
	adcq	%rdx, %r12
	movq	$0, %r13
	movq	%r8, %rax
	mulq	%rbp
	addq	%rax, %r12
	adcq	%rdx, %r13
	movq	%r9, %rax
	mulq	%r11
	addq	%rax, %r12
	adcq	%rdx, %r13
	movq	%r10, %rax
	imulq	%rbx, %rax
	addq	%rax, %r12
	adcq	$0, %r13
	imulq	%r11, %r10
	movq	%rsi, %r8
	movq	%r12, %r9
	addq	%r13, %r10
	movq	%r10, %rax
	movq	%r10, %rdx
	andq	$3, %r10
	shrq	$2, %rax
	andq	$-4, %rdx
	addq	%rdx, %rax
	addq	%rax, %r8
	adcq	$0, %r9
	adcq	$0, %r10
Lpoly1305_ref3$1:
	movq	%r8, %rax
	movq	%r9, %rdx
	movq	%r10, %rsi
	addq	$5, %rax
	adcq	$0, %rdx
	adcq	$0, %rsi
	shrq	$2, %rsi
	negq	%rsi
	xorq	%r8, %rax
	xorq	%r9, %rdx
	andq	%rsi, %rax
	andq	%rsi, %rdx
	xorq	%rax, %r8
	xorq	%rdx, %r9
	movq	(%rcx), %rax
	movq	8(%rcx), %rcx
	addq	%rax, %r8
	adcq	%rcx, %r9
	movq	%r8, (%rdi)
	movq	%r9, 8(%rdi)
	addq	$16, %rsp
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	ret 

	.text
	.p2align	5
	.globl	_chacha20_ref
	.globl	chacha20_ref
_chacha20_ref:
chacha20_ref:
	pushq	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$96, %rsp
	movq	%rdi, 72(%rsp)
	movq	%rsi, 64(%rsp)
	movl	%edx, 92(%rsp)
	movl	$1634760805, (%rsp)
	movl	$857760878, 4(%rsp)
	movl	$2036477234, 8(%rsp)
	movl	$1797285236, 12(%rsp)
	movl	(%rcx), %eax
	movl	%eax, 16(%rsp)
	movl	4(%rcx), %eax
	movl	%eax, 20(%rsp)
	movl	8(%rcx), %eax
	movl	%eax, 24(%rsp)
	movl	12(%rcx), %eax
	movl	%eax, 28(%rsp)
	movl	16(%rcx), %eax
	movl	%eax, 32(%rsp)
	movl	20(%rcx), %eax
	movl	%eax, 36(%rsp)
	movl	24(%rcx), %eax
	movl	%eax, 40(%rsp)
	movl	28(%rcx), %eax
	movl	%eax, 44(%rsp)
	movl	%r9d, 48(%rsp)
	movl	(%r8), %eax
	movl	%eax, 52(%rsp)
	movl	4(%r8), %eax
	movl	%eax, 56(%rsp)
	movl	8(%r8), %eax
	movl	%eax, 60(%rsp)
	jmp 	Lchacha20_ref$8
Lchacha20_ref$9:
	movl	60(%rsp), %eax
	movl	%eax, 80(%rsp)
	movl	(%rsp), %eax
	movl	4(%rsp), %ecx
	movl	8(%rsp), %edx
	movl	12(%rsp), %esi
	movl	16(%rsp), %edi
	movl	20(%rsp), %r8d
	movl	24(%rsp), %r9d
	movl	28(%rsp), %r10d
	movl	32(%rsp), %r11d
	movl	36(%rsp), %ebp
	movl	40(%rsp), %ebx
	movl	44(%rsp), %r12d
	movl	48(%rsp), %r13d
	movl	52(%rsp), %r14d
	movl	56(%rsp), %r15d
	movl	$0, 84(%rsp)
	jmp 	Lchacha20_ref$10
Lchacha20_ref$11:
	addl	%edi, %eax
	xorl	%eax, %r13d
	roll	$16, %r13d
	addl	%r13d, %r11d
	xorl	%r11d, %edi
	roll	$12, %edi
	addl	%edi, %eax
	xorl	%eax, %r13d
	roll	$8, %r13d
	addl	%r13d, %r11d
	xorl	%r11d, %edi
	roll	$7, %edi
	addl	%r9d, %edx
	xorl	%edx, %r15d
	roll	$16, %r15d
	addl	%r15d, %ebx
	xorl	%ebx, %r9d
	roll	$12, %r9d
	addl	%r9d, %edx
	xorl	%edx, %r15d
	roll	$8, %r15d
	addl	%r15d, %ebx
	xorl	%ebx, %r9d
	roll	$7, %r9d
	movl	%r15d, 88(%rsp)
	movl	80(%rsp), %r15d
	addl	%r8d, %ecx
	xorl	%ecx, %r14d
	roll	$16, %r14d
	addl	%r14d, %ebp
	xorl	%ebp, %r8d
	roll	$12, %r8d
	addl	%r8d, %ecx
	xorl	%ecx, %r14d
	roll	$8, %r14d
	addl	%r14d, %ebp
	xorl	%ebp, %r8d
	roll	$7, %r8d
	addl	%r10d, %esi
	xorl	%esi, %r15d
	roll	$16, %r15d
	addl	%r15d, %r12d
	xorl	%r12d, %r10d
	roll	$12, %r10d
	addl	%r10d, %esi
	xorl	%esi, %r15d
	roll	$8, %r15d
	addl	%r15d, %r12d
	xorl	%r12d, %r10d
	roll	$7, %r10d
	addl	%r9d, %ecx
	xorl	%ecx, %r13d
	roll	$16, %r13d
	addl	%r13d, %r12d
	xorl	%r12d, %r9d
	roll	$12, %r9d
	addl	%r9d, %ecx
	xorl	%ecx, %r13d
	roll	$8, %r13d
	addl	%r13d, %r12d
	xorl	%r12d, %r9d
	roll	$7, %r9d
	addl	%r8d, %eax
	xorl	%eax, %r15d
	roll	$16, %r15d
	addl	%r15d, %ebx
	xorl	%ebx, %r8d
	roll	$12, %r8d
	addl	%r8d, %eax
	xorl	%eax, %r15d
	roll	$8, %r15d
	addl	%r15d, %ebx
	xorl	%ebx, %r8d
	roll	$7, %r8d
	movl	%r15d, 80(%rsp)
	movl	88(%rsp), %r15d
	addl	%r10d, %edx
	xorl	%edx, %r14d
	roll	$16, %r14d
	addl	%r14d, %r11d
	xorl	%r11d, %r10d
	roll	$12, %r10d
	addl	%r10d, %edx
	xorl	%edx, %r14d
	roll	$8, %r14d
	addl	%r14d, %r11d
	xorl	%r11d, %r10d
	roll	$7, %r10d
	addl	%edi, %esi
	xorl	%esi, %r15d
	roll	$16, %r15d
	addl	%r15d, %ebp
	xorl	%ebp, %edi
	roll	$12, %edi
	addl	%edi, %esi
	xorl	%esi, %r15d
	roll	$8, %r15d
	addl	%r15d, %ebp
	xorl	%ebp, %edi
	roll	$7, %edi
	incl	84(%rsp)
Lchacha20_ref$10:
	cmpl	$10, 84(%rsp)
	jb  	Lchacha20_ref$11
	addl	(%rsp), %eax
	addl	4(%rsp), %ecx
	addl	8(%rsp), %edx
	addl	12(%rsp), %esi
	addl	16(%rsp), %edi
	addl	20(%rsp), %r8d
	addl	24(%rsp), %r9d
	addl	28(%rsp), %r10d
	addl	32(%rsp), %r11d
	addl	36(%rsp), %ebp
	addl	40(%rsp), %ebx
	addl	44(%rsp), %r12d
	addl	48(%rsp), %r13d
	addl	52(%rsp), %r14d
	addl	56(%rsp), %r15d
	movl	%r15d, 88(%rsp)
	movl	80(%rsp), %r15d
	addl	60(%rsp), %r15d
	movl	%r15d, 84(%rsp)
	movl	88(%rsp), %r15d
	movl	%ecx, %ecx
	shlq	$32, %rcx
	movl	%eax, %eax
	xorq	%rax, %rcx
	movq	64(%rsp), %rax
	xorq	(%rax), %rcx
	movl	%esi, %esi
	shlq	$32, %rsi
	movl	%edx, %edx
	xorq	%rdx, %rsi
	xorq	8(%rax), %rsi
	movq	72(%rsp), %rdx
	movq	%rcx, (%rdx)
	movl	%r8d, %ecx
	shlq	$32, %rcx
	movl	%edi, %edi
	xorq	%rdi, %rcx
	xorq	16(%rax), %rcx
	movq	%rsi, 8(%rdx)
	movl	%r10d, %esi
	shlq	$32, %rsi
	movl	%r9d, %edi
	xorq	%rdi, %rsi
	xorq	24(%rax), %rsi
	movq	%rcx, 16(%rdx)
	movl	%ebp, %ecx
	shlq	$32, %rcx
	movl	%r11d, %edi
	xorq	%rdi, %rcx
	xorq	32(%rax), %rcx
	movq	%rsi, 24(%rdx)
	movl	%r12d, %esi
	shlq	$32, %rsi
	movl	%ebx, %edi
	xorq	%rdi, %rsi
	xorq	40(%rax), %rsi
	movq	%rcx, 32(%rdx)
	movl	%r14d, %ecx
	shlq	$32, %rcx
	movl	%r13d, %edi
	xorq	%rdi, %rcx
	xorq	48(%rax), %rcx
	movq	%rsi, 40(%rdx)
	movl	84(%rsp), %esi
	shlq	$32, %rsi
	movl	%r15d, %edi
	xorq	%rdi, %rsi
	xorq	56(%rax), %rsi
	movq	%rcx, 48(%rdx)
	movq	%rsi, 56(%rdx)
	movl	92(%rsp), %ecx
	addq	$64, %rdx
	addq	$64, %rax
	subl	$64, %ecx
	movq	%rdx, 72(%rsp)
	movq	%rax, 64(%rsp)
	movl	%ecx, 92(%rsp)
	movl	$1, %eax
	addl	48(%rsp), %eax
	movl	%eax, 48(%rsp)
Lchacha20_ref$8:
	cmpl	$64, 92(%rsp)
	jnb 	Lchacha20_ref$9
	cmpl	$0, 92(%rsp)
	jbe 	Lchacha20_ref$1
	movl	60(%rsp), %eax
	movl	%eax, 80(%rsp)
	movl	(%rsp), %eax
	movl	4(%rsp), %ecx
	movl	8(%rsp), %edx
	movl	12(%rsp), %esi
	movl	16(%rsp), %edi
	movl	20(%rsp), %r8d
	movl	24(%rsp), %r9d
	movl	28(%rsp), %r10d
	movl	32(%rsp), %r11d
	movl	36(%rsp), %ebp
	movl	40(%rsp), %ebx
	movl	44(%rsp), %r12d
	movl	48(%rsp), %r13d
	movl	52(%rsp), %r14d
	movl	56(%rsp), %r15d
	movl	$0, 84(%rsp)
	jmp 	Lchacha20_ref$6
Lchacha20_ref$7:
	addl	%edi, %eax
	xorl	%eax, %r13d
	roll	$16, %r13d
	addl	%r13d, %r11d
	xorl	%r11d, %edi
	roll	$12, %edi
	addl	%edi, %eax
	xorl	%eax, %r13d
	roll	$8, %r13d
	addl	%r13d, %r11d
	xorl	%r11d, %edi
	roll	$7, %edi
	addl	%r9d, %edx
	xorl	%edx, %r15d
	roll	$16, %r15d
	addl	%r15d, %ebx
	xorl	%ebx, %r9d
	roll	$12, %r9d
	addl	%r9d, %edx
	xorl	%edx, %r15d
	roll	$8, %r15d
	addl	%r15d, %ebx
	xorl	%ebx, %r9d
	roll	$7, %r9d
	movl	%r15d, 88(%rsp)
	movl	80(%rsp), %r15d
	addl	%r8d, %ecx
	xorl	%ecx, %r14d
	roll	$16, %r14d
	addl	%r14d, %ebp
	xorl	%ebp, %r8d
	roll	$12, %r8d
	addl	%r8d, %ecx
	xorl	%ecx, %r14d
	roll	$8, %r14d
	addl	%r14d, %ebp
	xorl	%ebp, %r8d
	roll	$7, %r8d
	addl	%r10d, %esi
	xorl	%esi, %r15d
	roll	$16, %r15d
	addl	%r15d, %r12d
	xorl	%r12d, %r10d
	roll	$12, %r10d
	addl	%r10d, %esi
	xorl	%esi, %r15d
	roll	$8, %r15d
	addl	%r15d, %r12d
	xorl	%r12d, %r10d
	roll	$7, %r10d
	addl	%r9d, %ecx
	xorl	%ecx, %r13d
	roll	$16, %r13d
	addl	%r13d, %r12d
	xorl	%r12d, %r9d
	roll	$12, %r9d
	addl	%r9d, %ecx
	xorl	%ecx, %r13d
	roll	$8, %r13d
	addl	%r13d, %r12d
	xorl	%r12d, %r9d
	roll	$7, %r9d
	addl	%r8d, %eax
	xorl	%eax, %r15d
	roll	$16, %r15d
	addl	%r15d, %ebx
	xorl	%ebx, %r8d
	roll	$12, %r8d
	addl	%r8d, %eax
	xorl	%eax, %r15d
	roll	$8, %r15d
	addl	%r15d, %ebx
	xorl	%ebx, %r8d
	roll	$7, %r8d
	movl	%r15d, 80(%rsp)
	movl	88(%rsp), %r15d
	addl	%r10d, %edx
	xorl	%edx, %r14d
	roll	$16, %r14d
	addl	%r14d, %r11d
	xorl	%r11d, %r10d
	roll	$12, %r10d
	addl	%r10d, %edx
	xorl	%edx, %r14d
	roll	$8, %r14d
	addl	%r14d, %r11d
	xorl	%r11d, %r10d
	roll	$7, %r10d
	addl	%edi, %esi
	xorl	%esi, %r15d
	roll	$16, %r15d
	addl	%r15d, %ebp
	xorl	%ebp, %edi
	roll	$12, %edi
	addl	%edi, %esi
	xorl	%esi, %r15d
	roll	$8, %r15d
	addl	%r15d, %ebp
	xorl	%ebp, %edi
	roll	$7, %edi
	incl	84(%rsp)
Lchacha20_ref$6:
	cmpl	$10, 84(%rsp)
	jb  	Lchacha20_ref$7
	addl	(%rsp), %eax
	addl	4(%rsp), %ecx
	addl	8(%rsp), %edx
	addl	12(%rsp), %esi
	addl	16(%rsp), %edi
	addl	20(%rsp), %r8d
	addl	24(%rsp), %r9d
	addl	28(%rsp), %r10d
	addl	32(%rsp), %r11d
	addl	36(%rsp), %ebp
	addl	40(%rsp), %ebx
	addl	44(%rsp), %r12d
	addl	48(%rsp), %r13d
	addl	52(%rsp), %r14d
	addl	56(%rsp), %r15d
	movl	%r15d, 88(%rsp)
	movl	80(%rsp), %r15d
	addl	60(%rsp), %r15d
	movl	%r15d, 84(%rsp)
	movl	88(%rsp), %r15d
	movl	%eax, (%rsp)
	movl	%ecx, 4(%rsp)
	movl	%edx, 8(%rsp)
	movl	%esi, 12(%rsp)
	movl	%edi, 16(%rsp)
	movl	%r8d, 20(%rsp)
	movl	%r9d, 24(%rsp)
	movl	%r10d, 28(%rsp)
	movl	%r11d, 32(%rsp)
	movl	%ebp, 36(%rsp)
	movl	%ebx, 40(%rsp)
	movl	%r12d, 44(%rsp)
	movl	%r13d, 48(%rsp)
	movl	%r14d, 52(%rsp)
	movl	%r15d, 56(%rsp)
	movl	84(%rsp), %eax
	movl	%eax, 60(%rsp)
	movq	72(%rsp), %rax
	movq	64(%rsp), %rcx
	movl	92(%rsp), %edx
	movl	%edx, %esi
	shrl	$3, %esi
	movq	$0, %rdi
	jmp 	Lchacha20_ref$4
Lchacha20_ref$5:
	movq	(%rcx,%rdi,8), %r8
	xorq	(%rsp,%rdi,8), %r8
	movq	%r8, (%rax,%rdi,8)
	incq	%rdi
Lchacha20_ref$4:
	cmpl	%esi, %edi
	jb  	Lchacha20_ref$5
	shlq	$3, %rdi
	jmp 	Lchacha20_ref$2
Lchacha20_ref$3:
	movb	(%rcx,%rdi), %sil
	xorb	(%rsp,%rdi), %sil
	movb	%sil, (%rax,%rdi)
	incq	%rdi
Lchacha20_ref$2:
	cmpl	%edx, %edi
	jb  	Lchacha20_ref$3
Lchacha20_ref$1:
	addq	$96, %rsp
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	ret 

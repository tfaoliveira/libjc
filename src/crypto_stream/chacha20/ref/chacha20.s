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
	subq	$108, %rsp
	movq	%rdi, 8(%rsp)
	movq	%rsi, (%rsp)
	movl	%edx, 104(%rsp)
	movl	$1634760805, 40(%rsp)
	movl	$857760878, 44(%rsp)
	movl	$2036477234, 48(%rsp)
	movl	$1797285236, 52(%rsp)
	movl	(%rcx), %eax
	movl	%eax, 56(%rsp)
	movl	4(%rcx), %eax
	movl	%eax, 60(%rsp)
	movl	8(%rcx), %eax
	movl	%eax, 64(%rsp)
	movl	12(%rcx), %eax
	movl	%eax, 68(%rsp)
	movl	16(%rcx), %eax
	movl	%eax, 72(%rsp)
	movl	20(%rcx), %eax
	movl	%eax, 76(%rsp)
	movl	24(%rcx), %eax
	movl	%eax, 80(%rsp)
	movl	28(%rcx), %eax
	movl	%eax, 84(%rsp)
	movl	%r9d, 88(%rsp)
	movl	(%r8), %eax
	movl	%eax, 92(%rsp)
	movl	4(%r8), %eax
	movl	%eax, 96(%rsp)
	movl	8(%r8), %eax
	movl	%eax, 100(%rsp)
	jmp 	Lchacha20_ref$8
Lchacha20_ref$9:
	movl	100(%rsp), %eax
	movl	%eax, 28(%rsp)
	movl	40(%rsp), %eax
	movl	44(%rsp), %ecx
	movl	48(%rsp), %edx
	movl	52(%rsp), %esi
	movl	56(%rsp), %edi
	movl	60(%rsp), %r8d
	movl	64(%rsp), %r9d
	movl	68(%rsp), %r10d
	movl	72(%rsp), %r11d
	movl	76(%rsp), %ebp
	movl	80(%rsp), %ebx
	movl	84(%rsp), %r12d
	movl	88(%rsp), %r13d
	movl	92(%rsp), %r14d
	movl	96(%rsp), %r15d
	movl	$0, 32(%rsp)
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
	movl	%r15d, 36(%rsp)
	movl	28(%rsp), %r15d
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
	movl	%r15d, 28(%rsp)
	movl	36(%rsp), %r15d
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
	incl	32(%rsp)
Lchacha20_ref$10:
	cmpl	$10, 32(%rsp)
	jb  	Lchacha20_ref$11
	addl	40(%rsp), %eax
	addl	44(%rsp), %ecx
	addl	48(%rsp), %edx
	addl	52(%rsp), %esi
	addl	56(%rsp), %edi
	addl	60(%rsp), %r8d
	addl	64(%rsp), %r9d
	addl	68(%rsp), %r10d
	addl	72(%rsp), %r11d
	addl	76(%rsp), %ebp
	addl	80(%rsp), %ebx
	addl	84(%rsp), %r12d
	addl	88(%rsp), %r13d
	addl	92(%rsp), %r14d
	addl	96(%rsp), %r15d
	movl	%r15d, 36(%rsp)
	movl	28(%rsp), %r15d
	addl	100(%rsp), %r15d
	movl	%r15d, 32(%rsp)
	movl	36(%rsp), %r15d
	movl	%r13d, 16(%rsp)
	movl	%r14d, 20(%rsp)
	movl	%r15d, 24(%rsp)
	movq	8(%rsp), %r13
	movq	(%rsp), %r14
	movl	104(%rsp), %r15d
	xorl	(%r14), %eax
	movl	%eax, (%r13)
	xorl	4(%r14), %ecx
	movl	%ecx, 4(%r13)
	xorl	8(%r14), %edx
	movl	%edx, 8(%r13)
	xorl	12(%r14), %esi
	movl	%esi, 12(%r13)
	xorl	16(%r14), %edi
	movl	%edi, 16(%r13)
	xorl	20(%r14), %r8d
	movl	%r8d, 20(%r13)
	xorl	24(%r14), %r9d
	movl	%r9d, 24(%r13)
	xorl	28(%r14), %r10d
	movl	%r10d, 28(%r13)
	xorl	32(%r14), %r11d
	movl	%r11d, 32(%r13)
	xorl	36(%r14), %ebp
	movl	%ebp, 36(%r13)
	xorl	40(%r14), %ebx
	movl	%ebx, 40(%r13)
	xorl	44(%r14), %r12d
	movl	%r12d, 44(%r13)
	movl	16(%rsp), %eax
	movl	20(%rsp), %ecx
	movl	24(%rsp), %edx
	movl	32(%rsp), %esi
	xorl	48(%r14), %eax
	movl	%eax, 48(%r13)
	xorl	52(%r14), %ecx
	movl	%ecx, 52(%r13)
	xorl	56(%r14), %edx
	movl	%edx, 56(%r13)
	xorl	60(%r14), %esi
	movl	%esi, 60(%r13)
	addq	$64, %r13
	addq	$64, %r14
	subl	$64, %r15d
	movq	%r13, 8(%rsp)
	movq	%r14, (%rsp)
	movl	%r15d, 104(%rsp)
	movl	$1, %eax
	addl	88(%rsp), %eax
	movl	%eax, 88(%rsp)
Lchacha20_ref$8:
	cmpl	$64, 104(%rsp)
	jnb 	Lchacha20_ref$9
	cmpl	$0, 104(%rsp)
	jbe 	Lchacha20_ref$1
	movl	100(%rsp), %eax
	movl	%eax, 28(%rsp)
	movl	40(%rsp), %eax
	movl	44(%rsp), %ecx
	movl	48(%rsp), %edx
	movl	52(%rsp), %esi
	movl	56(%rsp), %edi
	movl	60(%rsp), %r8d
	movl	64(%rsp), %r9d
	movl	68(%rsp), %r10d
	movl	72(%rsp), %r11d
	movl	76(%rsp), %ebp
	movl	80(%rsp), %ebx
	movl	84(%rsp), %r12d
	movl	88(%rsp), %r13d
	movl	92(%rsp), %r14d
	movl	96(%rsp), %r15d
	movl	$0, 32(%rsp)
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
	movl	%r15d, 36(%rsp)
	movl	28(%rsp), %r15d
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
	movl	%r15d, 28(%rsp)
	movl	36(%rsp), %r15d
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
	incl	32(%rsp)
Lchacha20_ref$6:
	cmpl	$10, 32(%rsp)
	jb  	Lchacha20_ref$7
	addl	40(%rsp), %eax
	addl	44(%rsp), %ecx
	addl	48(%rsp), %edx
	addl	52(%rsp), %esi
	addl	56(%rsp), %edi
	addl	60(%rsp), %r8d
	addl	64(%rsp), %r9d
	addl	68(%rsp), %r10d
	addl	72(%rsp), %r11d
	addl	76(%rsp), %ebp
	addl	80(%rsp), %ebx
	addl	84(%rsp), %r12d
	addl	88(%rsp), %r13d
	addl	92(%rsp), %r14d
	addl	96(%rsp), %r15d
	movl	%r15d, 36(%rsp)
	movl	28(%rsp), %r15d
	addl	100(%rsp), %r15d
	movl	%r15d, 32(%rsp)
	movl	36(%rsp), %r15d
	movl	%eax, 40(%rsp)
	movl	%ecx, 44(%rsp)
	movl	%edx, 48(%rsp)
	movl	%esi, 52(%rsp)
	movl	%edi, 56(%rsp)
	movl	%r8d, 60(%rsp)
	movl	%r9d, 64(%rsp)
	movl	%r10d, 68(%rsp)
	movl	%r11d, 72(%rsp)
	movl	%ebp, 76(%rsp)
	movl	%ebx, 80(%rsp)
	movl	%r12d, 84(%rsp)
	movl	%r13d, 88(%rsp)
	movl	%r14d, 92(%rsp)
	movl	%r15d, 96(%rsp)
	movl	32(%rsp), %eax
	movl	%eax, 100(%rsp)
	movq	8(%rsp), %rax
	movq	(%rsp), %rcx
	movl	104(%rsp), %edx
	movl	%edx, %esi
	shrl	$2, %esi
	movq	$0, %rdi
	jmp 	Lchacha20_ref$4
Lchacha20_ref$5:
	movl	(%rcx,%rdi,4), %r8d
	xorl	40(%rsp,%rdi,4), %r8d
	movl	%r8d, (%rax,%rdi,4)
	incq	%rdi
Lchacha20_ref$4:
	cmpl	%esi, %edi
	jb  	Lchacha20_ref$5
	imulq	$4, %rdi
	jmp 	Lchacha20_ref$2
Lchacha20_ref$3:
	movb	(%rcx,%rdi), %sil
	xorb	40(%rsp,%rdi), %sil
	movb	%sil, (%rax,%rdi)
	incq	%rdi
Lchacha20_ref$2:
	cmpl	%edx, %edi
	jb  	Lchacha20_ref$3
Lchacha20_ref$1:
	addq	$108, %rsp
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	ret 

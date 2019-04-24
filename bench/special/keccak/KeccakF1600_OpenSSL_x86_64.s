.text
.global KeccakF1600_OpenSSL_x86_64
.type KeccakF1600_OpenSSL_x86_64,@function
.align	32
KeccakF1600_OpenSSL_x86_64:

  ## begin patch
	pushq	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	lea	iotas(%rip),%r15
	lea	100(%rdi),%rdi
	lea	100(%rsi),%rsi
  ## end patch

	mov	60(%rdi),%rax
	mov	68(%rdi),%rbx
	mov	76(%rdi),%rcx
	mov	84(%rdi),%rdx
	mov	92(%rdi),%rbp

	jmp	.Loop

.align	32
.Loop:
	mov	-100(%rdi),%r8
	mov	-52(%rdi),%r9
	mov	-4(%rdi),%r10
	mov	44(%rdi),%r11

	xor	-84(%rdi),%rcx
	xor	-76(%rdi),%rdx
	xor	%r8,         %rax
	xor	-92(%rdi),%rbx
	 xor	-44(%rdi),%rcx
	 xor	-60(%rdi),%rax
	mov	%rbp,%r12
	xor	-68(%rdi),%rbp

	xor	%r10,         %rcx
	xor	-20(%rdi),%rax
	 xor	-36(%rdi),%rdx
	 xor	%r9,         %rbx
	 xor	-28(%rdi),%rbp

	xor	36(%rdi),%rcx
	xor	20(%rdi),%rax
	 xor	4(%rdi),%rdx
	 xor	-12(%rdi),%rbx
	 xor	12(%rdi),%rbp

	mov	%rcx,%r13
	rol	$1,%rcx
	xor	%rax,%rcx		# D[1] = ROL64(C[2], 1) ^ C[0]
	 xor	%r11,         %rdx

	rol	$1,%rax
	xor	%rdx,%rax		# D[4] = ROL64(C[0], 1) ^ C[3]
	 xor	28(%rdi),%rbx

	rol	$1,%rdx
	xor	%rbx,%rdx		# D[2] = ROL64(C[3], 1) ^ C[1]
	 xor	52(%rdi),%rbp

	rol	$1,%rbx
	xor	%rbp,%rbx		# D[0] = ROL64(C[1], 1) ^ C[4]

	rol	$1,%rbp
	xor	%r13,%rbp		# D[3] = ROL64(C[4], 1) ^ C[2]
	xor	%rcx,%r9
	xor	%rdx,%r10
	rol	$44,%r9
	xor	%rbp,%r11
	xor	%rax,%r12
	rol	$43,%r10
	xor	%rbx,%r8
	 mov	%r9,%r13
	rol	$21,%r11
	 or	%r10,%r9
	 xor	%r8,%r9		#           C[0] ^ ( C[1] | C[2])
	rol	$14,%r12

	 xor	(%r15),%r9
	 lea	8(%r15),%r15

	mov	%r12,%r14
	and	%r11,%r12
	 mov	%r9,-100(%rsi)	# R[0][0] = C[0] ^ ( C[1] | C[2]) ^ iotas[i]
	xor	%r10,%r12		#           C[2] ^ ( C[4] & C[3])
	not	%r10
	mov	%r12,-84(%rsi)	# R[0][2] = C[2] ^ ( C[4] & C[3])

	or	%r11,%r10
	  mov	76(%rdi),%r12
	xor	%r13,%r10		#           C[1] ^ (~C[2] | C[3])
	mov	%r10,-92(%rsi)	# R[0][1] = C[1] ^ (~C[2] | C[3])

	and	%r8,%r13
	  mov	-28(%rdi),%r9
	xor	%r14,%r13		#           C[4] ^ ( C[1] & C[0])
	  mov	-20(%rdi),%r10
	mov	%r13,-68(%rsi)	# R[0][4] = C[4] ^ ( C[1] & C[0])

	or	%r8,%r14
	  mov	-76(%rdi),%r8
	xor	%r11,%r14		#           C[3] ^ ( C[4] | C[0])
	  mov	28(%rdi),%r11
	mov	%r14,-76(%rsi)	# R[0][3] = C[3] ^ ( C[4] | C[0])


	xor	%rbp,%r8
	xor	%rdx,%r12
	rol	$28,%r8
	xor	%rcx,%r11
	xor	%rax,%r9
	rol	$61,%r12
	rol	$45,%r11
	xor	%rbx,%r10
	rol	$20,%r9
	 mov	%r8,%r13
	 or	%r12,%r8
	rol	$3,%r10

	xor	%r11,%r8		#           C[3] ^ (C[0] |  C[4])
	mov	%r8,-36(%rsi)	# R[1][3] = C[3] ^ (C[0] |  C[4])

	mov	%r9,%r14
	and	%r13,%r9
	  mov	-92(%rdi),%r8
	xor	%r12,%r9		#           C[4] ^ (C[1] &  C[0])
	not	%r12
	mov	%r9,-28(%rsi)	# R[1][4] = C[4] ^ (C[1] &  C[0])

	or	%r11,%r12
	  mov	-44(%rdi),%r9
	xor	%r10,%r12		#           C[2] ^ (~C[4] | C[3])
	mov	%r12,-44(%rsi)	# R[1][2] = C[2] ^ (~C[4] | C[3])

	and	%r10,%r11
	  mov	60(%rdi),%r12
	xor	%r14,%r11		#           C[1] ^ (C[3] &  C[2])
	mov	%r11,-52(%rsi)	# R[1][1] = C[1] ^ (C[3] &  C[2])

	or	%r10,%r14
	  mov	4(%rdi),%r10
	xor	%r13,%r14		#           C[0] ^ (C[1] |  C[2])
	  mov	52(%rdi),%r11
	mov	%r14,-60(%rsi)	# R[1][0] = C[0] ^ (C[1] |  C[2])


	xor	%rbp,%r10
	xor	%rax,%r11
	rol	$25,%r10
	xor	%rdx,%r9
	rol	$8,%r11
	xor	%rbx,%r12
	rol	$6,%r9
	xor	%rcx,%r8
	rol	$18,%r12
	 mov	%r10,%r13
	 and	%r11,%r10
	rol	$1,%r8

	not	%r11
	xor	%r9,%r10		#            C[1] ^ ( C[2] & C[3])
	mov	%r10,-12(%rsi)	# R[2][1] =  C[1] ^ ( C[2] & C[3])

	mov	%r12,%r14
	and	%r11,%r12
	  mov	-12(%rdi),%r10
	xor	%r13,%r12		#            C[2] ^ ( C[4] & ~C[3])
	mov	%r12,-4(%rsi)	# R[2][2] =  C[2] ^ ( C[4] & ~C[3])

	or	%r9,%r13
	  mov	84(%rdi),%r12
	xor	%r8,%r13		#            C[0] ^ ( C[2] | C[1])
	mov	%r13,-20(%rsi)	# R[2][0] =  C[0] ^ ( C[2] | C[1])

	and	%r8,%r9
	xor	%r14,%r9		#            C[4] ^ ( C[1] & C[0])
	mov	%r9,12(%rsi)	# R[2][4] =  C[4] ^ ( C[1] & C[0])

	or	%r8,%r14
	  mov	-60(%rdi),%r9
	xor	%r11,%r14		#           ~C[3] ^ ( C[0] | C[4])
	  mov	36(%rdi),%r11
	mov	%r14,4(%rsi)	# R[2][3] = ~C[3] ^ ( C[0] | C[4])


	mov	-68(%rdi),%r8

	xor	%rcx,%r10
	xor	%rdx,%r11
	rol	$10,%r10
	xor	%rbx,%r9
	rol	$15,%r11
	xor	%rbp,%r12
	rol	$36,%r9
	xor	%rax,%r8
	rol	$56,%r12
	 mov	%r10,%r13
	 or	%r11,%r10
	rol	$27,%r8

	not	%r11
	xor	%r9,%r10		#            C[1] ^ ( C[2] | C[3])
	mov	%r10,28(%rsi)	# R[3][1] =  C[1] ^ ( C[2] | C[3])

	mov	%r12,%r14
	or	%r11,%r12
	xor	%r13,%r12		#            C[2] ^ ( C[4] | ~C[3])
	mov	%r12,36(%rsi)	# R[3][2] =  C[2] ^ ( C[4] | ~C[3])

	and	%r9,%r13
	xor	%r8,%r13		#            C[0] ^ ( C[2] & C[1])
	mov	%r13,20(%rsi)	# R[3][0] =  C[0] ^ ( C[2] & C[1])

	or	%r8,%r9
	xor	%r14,%r9		#            C[4] ^ ( C[1] | C[0])
	mov	%r9,52(%rsi)	# R[3][4] =  C[4] ^ ( C[1] | C[0])

	and	%r14,%r8
	xor	%r11,%r8		#           ~C[3] ^ ( C[0] & C[4])
	mov	%r8,44(%rsi)	# R[3][3] = ~C[3] ^ ( C[0] & C[4])


	xor	-84(%rdi),%rdx
	xor	-36(%rdi),%rbp
	rol	$62,%rdx
	xor	68(%rdi),%rcx
	rol	$55,%rbp
	xor	12(%rdi),%rax
	rol	$2,%rcx
	xor	20(%rdi),%rbx
	xchg	%rsi,%rdi
	rol	$39,%rax
	rol	$41,%rbx
	mov	%rdx,%r13
	and	%rbp,%rdx
	not	%rbp
	xor	%rcx,%rdx		#            C[4] ^ ( C[0] & C[1])
	mov	%rdx,92(%rdi)	# R[4][4] =  C[4] ^ ( C[0] & C[1])

	mov	%rax,%r14
	and	%rbp,%rax
	xor	%r13,%rax		#            C[0] ^ ( C[2] & ~C[1])
	mov	%rax,60(%rdi)	# R[4][0] =  C[0] ^ ( C[2] & ~C[1])

	or	%rcx,%r13
	xor	%rbx,%r13		#            C[3] ^ ( C[0] | C[4])
	mov	%r13,84(%rdi)	# R[4][3] =  C[3] ^ ( C[0] | C[4])

	and	%rbx,%rcx
	xor	%r14,%rcx		#            C[2] ^ ( C[4] & C[3])
	mov	%rcx,76(%rdi)	# R[4][2] =  C[2] ^ ( C[4] & C[3])

	or	%r14,%rbx
	xor	%rbp,%rbx		#           ~C[1] ^ ( C[2] | C[3])
	mov	%rbx,68(%rdi)	# R[4][1] = ~C[1] ^ ( C[2] | C[3])

	mov	%rdx,%rbp		# harmonize with the loop top
	mov	%r13,%rdx

	test	$255,%r15
	jnz	.Loop

  #no need to rewind iotas for this benchmark
	#lea	-192(%r15),%r15	# rewind iotas

  # begin patch
  popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
  ## end patch

	ret
.size	KeccakF1600_OpenSSL_x86_64,.-KeccakF1600_OpenSSL_x86_64
.align	256
	.quad	0,0,0,0,0,0,0,0
.type	iotas,@object
iotas:
	.quad	0x0000000000000001
	.quad	0x0000000000008082
	.quad	0x800000000000808a
	.quad	0x8000000080008000
	.quad	0x000000000000808b
	.quad	0x0000000080000001
	.quad	0x8000000080008081
	.quad	0x8000000000008009
	.quad	0x000000000000008a
	.quad	0x0000000000000088
	.quad	0x0000000080008009
	.quad	0x000000008000000a
	.quad	0x000000008000808b
	.quad	0x800000000000008b
	.quad	0x8000000000008089
	.quad	0x8000000000008003
	.quad	0x8000000000008002
	.quad	0x8000000000000080
	.quad	0x000000000000800a
	.quad	0x800000008000000a
	.quad	0x8000000080008081
	.quad	0x8000000000008080
	.quad	0x0000000080000001
	.quad	0x8000000080008008
.size	iotas,.-iotas

	.file	"run_main-test.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%d"
.LC1:
	.string	"%s"
	.text
	.globl	run_main
	.type	run_main, @function
run_main:
.LFB23:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	subq	$544, %rsp
	.cfi_def_cfa_offset 576
	movl	$40, %ebx
	movq	%fs:(%rbx), %rax
	movq	%rax, 536(%rsp)
	xorl	%eax, %eax
	leaq	8(%rsp), %rbp
	movq	%rbp, %rsi
	leaq	.LC0(%rip), %rdi
	call	__isoc99_scanf@PLT
	leaq	16(%rsp), %r12
	leaq	17(%rsp), %rsi
	leaq	.LC1(%rip), %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	movl	8(%rsp), %eax
	movb	%al, 16(%rsp)
	movq	%rbp, %rsi
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	leaq	272(%rsp), %rbp
	leaq	273(%rsp), %rsi
	leaq	.LC1(%rip), %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	movl	8(%rsp), %eax
	movb	%al, 272(%rsp)
	leaq	12(%rsp), %rsi
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	movq	%rbp, %rdx
	movq	%r12, %rsi
	movl	12(%rsp), %edi
	movl	$0, %eax
	call	run_func@PLT
	movq	536(%rsp), %rax
	xorq	%fs:(%rbx), %rax
	jne	.L4
	addq	$544, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
.L4:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE23:
	.size	run_main, .-run_main
	.ident	"GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:

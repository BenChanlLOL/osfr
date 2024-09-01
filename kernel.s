	.text
	.file	"kernel.c"
	.globl	print_maybechar                 # -- Begin function print_maybechar
	.p2align	4, 0x90
	.type	print_maybechar,@function
print_maybechar:                        # @print_maybechar
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movb	%dil, %al
	movb	%al, -1(%rbp)
	movb	-1(%rbp), %al
	#APP
	movl	753664, %eax
	#NO_APP
	movl	%eax, -8(%rbp)
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	print_maybechar, .Lfunc_end0-print_maybechar
	.cfi_endproc
                                        # -- End function
	.globl	realprint                       # -- Begin function realprint
	.p2align	4, 0x90
	.type	realprint,@function
realprint:                              # @realprint
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
.LBB1_1:                                # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	movsbl	(%rax), %eax
	cmpl	$0, %eax
	je	.LBB1_3
# %bb.2:                                #   in Loop: Header=BB1_1 Depth=1
	movq	-8(%rbp), %rax
	movsbl	(%rax), %edi
	callq	print_maybechar
	movq	-8(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB1_1
.LBB1_3:
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end1:
	.size	realprint, .Lfunc_end1-realprint
	.cfi_endproc
                                        # -- End function
	.globl	kernel                          # -- Begin function kernel
	.p2align	4, 0x90
	.type	kernel,@function
kernel:                                 # @kernel
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	leaq	.L.str(%rip), %rdi
	callq	realprint
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end2:
	.size	kernel, .Lfunc_end2-kernel
	.cfi_endproc
                                        # -- End function
	.type	video_memory,@object            # @video_memory
	.data
	.globl	video_memory
	.p2align	3
video_memory:
	.quad	753664
	.size	video_memory, 8

	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"Hello, World!"
	.size	.L.str, 14

	.ident	"Debian clang version 14.0.6"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym print_maybechar
	.addrsig_sym realprint

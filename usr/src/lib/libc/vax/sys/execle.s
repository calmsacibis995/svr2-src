	.file	"execle.s"
#	@(#)execle.s	1.5
# C library -- execle

# execle(file, arg1, arg2, ... , env);

.globl	_execle
.globl	_execve

_execle:
	.word	0x0000
	MCOUNT
	movl	(ap),r0		#  nargs
	pushl	(ap)[r0]	#  env
	pushab	8(ap)		#  argv
	pushl	4(ap)		#  file
	calls	$3,_execve
	ret

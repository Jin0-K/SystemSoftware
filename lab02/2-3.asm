%include "asm_io.inc"

	segment	.data
	;
	; initialized data is put in the data segment here
	;

	segment	.text
	global 	main
main :
	enter	0,0		; setup stack frame
	pusha

	;
	; code is put in the text segment. Do not modify the code before
	; this comment.
	;

	call	read_int
	call	print_int
	call	print_nl

	;
	; Do not modify the code after this comment
	;

	popa
	mov	eax, 0	; return value

	leave			; leave stack frame
	ret

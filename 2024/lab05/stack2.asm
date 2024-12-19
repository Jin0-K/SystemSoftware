%include "asm_io.inc"

	segment	.data
	;
	; initialized data is put in the data segment here
	;

	segment	.text
subpr:
	enter 8, 0

	dump_stack 1, 2, 4

	leave

	ret

	global 	main
main:
	enter	0,0		; setup stack frame
	pusha

	;
	; code is put in the text segment. Do not modify the code before
	; or after this comment.
	;
	push dword 3
	push dword 2
	push dword 1

	call subpr

	add esp, 12

	popa
	mov	eax, 0	; return value
	leave			; leave stack frame
	ret

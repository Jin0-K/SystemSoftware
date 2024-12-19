%include "asm_io.inc"

	segment	.data
	;
	; initialized data is put in the data segment here
	;

	segment	.text
	global 	main
main:
	enter	0,0		; setup stack frame
	pusha

	;
	; code is put in the text segment. Do not modify the code before
	; or after this comment.
	;

	call read_int	; Get input
	mov ebx, eax
	call read_int

	mov edx, 0	; Initialize edx

while:	cmp eax, 0	; while condition
	jbe end_while
	add edx, ebx	; do operation
	dec eax
	jmp short while

end_while:
	mov eax, edx
	call print_int
	call print_nl

	popa
	mov	eax, 0	; return value
	leave			; leave stack frame
	ret

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

	; Get input
	call read_int
	mov ecx, eax
	call read_int
	mov ebx, eax
	mov eax, ecx
	mov edx, 0

	; Division
	div ebx

	; Print the result out
	call print_int
	call print_nl
	mov eax, edx
	call print_int
	call print_nl

	popa
	mov	eax, 0	; return value
	leave			; leave stack frame
	ret

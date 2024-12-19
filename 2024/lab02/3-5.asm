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
	mov edx, eax
	call read_int

	; Print registers before operation
	dump_regs 1
	call print_nl

	; Addition
	;add eax, edx

	; Subtraction
	sub edx, eax
	mov eax, edx

	; Print the result out
	call print_int
	call print_nl

	; Print registers after operation
	dump_regs 2
	call print_nl

	popa
	mov	eax, 0	; return value
	leave			; leave stack frame
	ret

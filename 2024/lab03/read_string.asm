%include "asm_io.inc"

	segment	.data
	;
	; initialized data is put in the data segment here
	;
string_len equ 32

	segment .bss
string	resb 32

	segment	.text
	global 	main
main:
	enter	0,0		; setup stack frame
	pusha

	;
	; code is put in the text segment. Do not modify the code before
	; or after this comment.
	;
	
	mov edx, 0
repeat:	call read_char
	mov [string+edx], al
	inc edx
	cmp edx, string_len
	jae end_input
	cmp al, 0x0a	; Until the enter key is input
	jne repeat
end_input:
	mov byte[string+edx-1], 0	; convert the last newline char
					; to null char
	mov eax, string
	call print_string
	call print_nl

	popa
	mov	eax, 0	; return value
	leave			; leave stack frame
	ret

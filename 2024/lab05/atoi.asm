%include "asm_io.inc"

	segment	.data
	;
	; initialized data is put in the data segment here
	;
string_len equ 10

	segment .bss
string	resb string_len

	segment	.text
	global 	main
main:
	enter	0,0		; setup stack frame
	pusha

	;
	; code is put in the text segment. Do not modify the code before
	; or after this comment.
	;
	mov ecx, 0	; Initialize ecx for count of input

read:	call read_char
	mov [string+ecx], al
	inc ecx
	cmp ecx, string_len	; if the input length is longer than reserved byte
	jae short end_read	; end read
	cmp al, 0x0a	; Until the enter key is input
	jne short read	; repeat read
end_read:
	dec ecx

	xor eax, eax	;Initialize eax
	mov ebx, 10	;Initialize ebx
	xor esi, esi
atoi:	cmp ecx, esi	; If it is the end of the string
	je end_atoi	; end atoi operation
	mul ebx		; Multiply 10 to previous result
	mov dl, [string+esi]
	inc esi
	sub dl, 0x30	; Convert character to integer
	add eax, edx	; Add the converted integer to eax
	jmp short atoi
end_atoi:
	call print_int
	call print_nl

	popa
	mov	eax, 0	; return value
	leave			; leave stack frame
	ret

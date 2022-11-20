; get string input

%include "asm_io.inc"

	SECTION .bss
string	resb 32	; The maximum length of the input
		; including null in the last

	SECTION .text
	global main;
main:
	mov edx, 0
repeat:	call read_char
	mov [string+edx], al
	inc edx
	cmp al, 0x0a	; untill the enter input comes
	jne repeat	; repeat input
	mov byte [string+edx-1], 0	; replace newline char to null



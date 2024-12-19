; get string input

%include "asm_io.inc"

	SECTION .bss
string	resb 32	; The maximum length of the input
		; including null in the last

	SECTION .text
	global main
main:
	mov edx, 0
repeat:	call read_char
	mov [string+edx], al
	inc edx
	cmp edx, 32	; Check if the input buffer didn't overflow
	je end	; if string bufer is full, go to end
	cmp al, 0x0a	; untill the enter input comes
	jne repeat	; (1) repeat input
end:	mov byte [string+edx-1], 0	; (2) replace newline char to null
	mov eax, string
	call print_string	; (3) print string to check if it stored right
	call print_nl

	ret

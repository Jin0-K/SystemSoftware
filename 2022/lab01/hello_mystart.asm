	section .data
msg db 'Hello, world!', 0x0A ;Hello world string
len equ $ -msg ;length of msg

	section .text
	global _mystart
_mystart:	; entry point
	mov eax, 4
	mov ebx, 1
	mov ecx, msg
	mov edx, len
	int 0x80

	mov eax, 1
	xor ebx, ebx
	int 0x80

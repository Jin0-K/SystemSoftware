; Convert string to integer

%include "asm_io.inc"

	SECTION .data
str_inp	db "Enter decimal number: ", 0x00
buf_int	dd 0	; buffer to store integer
buf_int2	dd 0	; buffer to store integer

	SECTION .bss
string	resb 10	; input string

	SECTION .text
	global main
main:
	enter 0,0	; setup stack frame
	pusha

	; print to enter string
	mov eax, str_inp
	call print_string

	; get string
	mov ecx, 0	; set ecx 0
			; ecx will be the length of the string
repeat:	call read_char
	mov [string+ecx], al
	inc ecx
	cmp ecx, 10	; get input less than 10 times
	je repeat_end	; end repeat
	cmp al, 0x0a	; end repeat if enter is input
	jne repeat

repeat_end:	; repeat ends
	dec ecx	; set ecx to the length of the input string

	; initialize registers
	mov eax, 0	; eax will be the result
	mov edx, 0	; edx will be iterator
atoi:	
	mov ebx, 0	; set ebx 0
	mov edx, [buf_int2]	; bring the iterator back to edx
	mov bl, [string+edx]	; put the value to ebx
	inc edx
	mov [buf_int2], edx	; put edx in memory
	sub bl, 0x30	; get integer value of the character
	mov [buf_int], ebx	; move the value to memory
	mov ebx, 10	; put 10 in ebx for multiplication
	mul ebx	; 1 left shift in decimal
	mov ebx, [buf_int]	; get the value back to ebx
	add eax, ebx
	loop atoi	; repeat as much as the length of the string
	
	call print_int
	call print_nl
	
	leave
	ret

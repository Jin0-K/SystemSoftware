%include "asm_io.inc"

	segment	.data
	;
	; initialized data is put in the data segment here
	;
array	dd 3, 1, 5, 7, 2, 8, 4, 9, 6, 10
size	dd 10

	segment	.text
	global 	main
main:
	enter	0,0		; setup stack frame
	pusha

	;
	; code is put in the text segment. Do not modify the code before
	; or after this comment.
	;

	call read_int	; get input for search

	xor edi, edi	; set edi 0, will contain index * scale
	xor ebx, ebx	; set ebx 0, will contain index
search:	cmp eax, [array+edi]	; check if it is the element
	je short search_end	; break the loop
	inc ebx
	add edi, 4
	cmp ebx, [size]	; check iteration
	jl short search	; continue loop
	mov ebx, -1

search_end:
	mov eax, ebx
	call print_int	; print the result
	call print_nl

	popa
	mov	eax, 0	; return value
	leave			; leave stack frame
	ret

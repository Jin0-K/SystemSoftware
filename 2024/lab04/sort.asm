%include "asm_io.inc"

	segment	.data
	;
	; initialized data is put in the data segment here
	;
array	dd 3, 1, 5, 7, 2, 8, 4, 9, 6, 10
size	dd 10
scale	dd 4

	segment	.text
	global 	main
main:
	enter	0,0		; setup stack frame
	pusha

	;
	; code is put in the text segment. Do not modify the code before
	; or after this comment.
	;

	xor esi, esi	; will contain outer iterator of bubble sort
	xor edi, edi	; will contain inner iterator of bubble sort
loop:
	; set indicator
	mov eax, [scale]
	mul esi 
	mov ebx, eax
	mov edi, esi
	inc edi

inner_loop:
	cmp edi, [size]	; check loop condition
	jge inner_end

	mov eax, [scale]	; load value
	mul edi
	mov ecx, eax
	
	mov eax, [array+ebx]
	cmp eax, [array+ecx]	; check if swap is needed
	jle pass
	mov edx, [array+ecx]	; swap
	mov [array+ebx], edx
	mov [array+ecx], eax
	
pass:
	inc edi
	jmp inner_loop
inner_end:
	inc esi
	mov eax, [size]
	dec eax
	cmp esi, eax
	jl loop
loop_end:
	
	xor esi, esi
	xor ebx, ebx
print_array:
	mov eax, [array+ebx]
	call print_int
	mov eax, ' '
	call print_char
	inc esi
	add ebx, [scale]
	cmp esi, [size]
	jl print_array

	call print_nl

	popa
	mov	eax, 0	; return value
	leave			; leave stack frame
	ret

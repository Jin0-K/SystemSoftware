%include "asm_io.inc"

	segment	.data
	;
	; initialized data is put in the data segment here
	;
a	dd 1, 2, 3, 4, 5, 6
rows_a	dd 2
cols_a	dd 3

b	dd 7, 8, 9, 1, 2, 3, 4, 5, 6, 7, 8, 9
rows_b	dd 3
cols_b	dd 4

buf	dd 0
sum	dd 0

	segment .bss
c	resd 8
rows_c	resd 1
cols_c	resd 1

	segment	.text
	global 	main
main:
	enter	0,0		; setup stack frame
	pusha

	;
	; code is put in the text segment. Do not modify the code before
	; or after this comment.
	;

	mov eax, [rows_a]
	mov [rows_c], eax
	mov ebx, [cols_b]
	mov [cols_c], ebx

	; esi will be i
	; edi will be j
	; ecx will be k
	xor esi, esi
a_row_loop:
	cmp esi, [rows_a]	; check condition
	jge a_row_end

	; initialization for b_col loop
	xor edi, edi
b_col_loop:
	cmp edi, [cols_b]	; check condition
	jge b_col_end

	; initialization for a_col loop
	xor ecx, ecx
	mov [sum], ecx		; initialize sum to 0
a_col_loop:
	cmp ecx, [cols_a]	; check condition
	jge a_col_end

	mov eax, [cols_a]	; get index of a[i][k]
	mul esi
	add eax, ecx
	
	mov edx, [a+eax*4]	; get value of a[i][k]
	mov [buf], edx		; push it to buf

	mov eax, [cols_b]	; get index of b[k][j]
	mul ecx
	add eax, edi

	mov ebx, [b+eax*4]	; get value of b[k][j]
	mov eax, [buf]		; get index of a[i][k]
	mul ebx			; a[i][k] * b[k][j]
	add [sum], eax		; add the result to sum
	
	inc ecx
	jmp a_col_loop
a_col_end:
	mov eax, [cols_c]	; get index of c[i][j]
	mul esi
	add eax, edi
	mov ebx, [sum]
	mov [c+eax*4], ebx	; make its value sum

	inc edi
	jmp b_col_loop
b_col_end:
	inc esi
	jmp a_row_loop
a_row_end:

	; Initialization for print
	mov esi, [rows_c]
	mov edi, [cols_c]
	xor ebx, ebx
	xor ecx, ecx
print:
	mov eax, [c+ecx*4]
	call print_int	; print number
	mov eax, 9
	call print_char	; print tab
	inc ecx
	cmp ecx, edi
	jl print
	add edi, [cols_c]
	call print_nl
	inc ebx
	cmp ebx, esi
	jl print
print_end:

	popa
	mov	eax, 0	; return value
	leave			; leave stack frame
	ret

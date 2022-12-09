; multiplication of two matrix

%include "asm_io.inc"

	SEGMENT .data
a	dd 1,2,3,4,5,6
rows_a	dd 2
cols_a	dd 3

b	dd 7,8,9,1,2,3,4,5,6,7,8,9
rows_b	dd 3
cols_b	dd 4

c_size	dd 8

	; iterator
it_cols_a	dq 0

	; sum
sum	dd	0

space	db 0x09, 0x00

	SEGMENT .bss
c	resd 8
rows_c	resd 1
cols_c	resd 1

buf	resd 1
buf2	resd 1

	SEGMENT .text
	global main
main:
	enter 0,0
	pusha

	mov eax, 0	
	mov ebx, 0
	mov ecx, 0
	mov edx, 0
	mov esi, 0 
	mov edi, 0	; get iterator of a row

	; Matrix multiplication
rpt_cols_b:
	mov dword [sum], 0	; reset sum 0

rpt_cols_a:
	mov ecx, [it_cols_a]	; get iterator of a column
				; a row in edi, b col in esi, a col in ecx in the moment
	; get the index of a
	mov eax, edi
	mov bx, [cols_a]
	mul ebx
	add eax, ecx	; the index of a in eax
	mov bx, [a + 4*eax]	; get the a[][]
	mov [buf], bx	;a[][] in buf

	; get the index of b
	mov eax, ecx
	mov bx, [cols_b]
	mul ebx
	add eax, esi
	mov bx, [b + 4*eax]	; get the b[][]
	mov [buf2], bx	; b[][] in buf2

	inc cx
	mov [it_cols_a], ecx	; put the a col iterator in memory
	;get the index of c
	mov eax, edi
	mov bx, [cols_b]
	mul bx
	add eax, esi
	mov ebx, eax	; index of c is in ebx

	; multiply a[][] and b[][]
	mov ax, [buf]
	mov cx, [buf2]
	mul ecx

	mov dx, [sum]	; bring the value of sum in dx
	add ax, dx	; sum += a[][]*b[][]
	mov [sum], ax	; bring it back to memory

	mov cx, [it_cols_a]
	cmp cx, [cols_a]	; break if ecx < cols_a
	jb rpt_cols_a

break_cols_a:
	mov [c + 4*ebx], ax	; update c[][]

	; reset a col iterator 0
	mov dword [it_cols_a], 0

	; increase b col iterator 1
	inc esi

	mov dx, [cols_b]
	cmp esi, edx	; break if esi < bols_b
	jb rpt_cols_b

break_cols_b:
	; reset b col iterator 0
	xor esi, esi

	; increase a row iterator 1
	inc edi

	mov dx, [rows_a]
	cmp edi, edx	; break if edi < rows_a
	jb rpt_cols_b

prnt_rslt:
	; set the rows and colum value of c
	;mov cx, [rows_a]
	;mov [rows_c], cx
	;mov cx, [cols_b]
	;mov [cols_c], cx

	mov esi, 0	; esi wil be iterator of c
	mov edi, 0

	; put c row in dx, c col in cx
	mov dx, [rows_a]

rpt_prnt_c_row:
	mov cx, [cols_b]
rpt_prnt_c_col:
	xor eax, eax
	mov ax, [c + 4*esi]
	inc esi
	call print_int
	mov eax, space
	call print_string
	loop rpt_prnt_c_col	; repeat c col times

	inc edi
	call print_nl
	cmp edi, edx	; repeat c row times
	jb rpt_prnt_c_row

	leave
	ret

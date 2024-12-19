; Sort integer array in acending order

%include "asm_io.inc"

	SECTION .data
array	dd 3,1,5,7,2,8,4,9,6,10
size	dd 10
space	db " ", 0x00

	SECTION .text
	global main
main:
	enter 0,0
	pusha

	mov eax, 0
	mov ebx, 0
	mov ecx, 0
	mov cx, [size]
	dec cx
	mov esi, 0	; esi is array iterator

	; Bubble sort
rpt_l:
	mov ax, [array + 4*esi]	; put the left element in ax
	mov edi, 0	; edi is array iterator
rpt_r:
	mov bx, [array + 4*edi]	; put the right element in bx
	cmp ax, bx	; if left element is larger than the right
	ja swap		; swap the elements
	inc edi
	cmp edi, ecx	; rpt_r loop condition
	jb rpt_r
	
	inc esi
	cmp esi, [size]	;rpt_l loop condition
	jb rpt_l

	jmp print_rslt	; jump if the sort end

	; Swap
swap:
	mov dx, ax
	mov [array + 4*esi], bx
	mov [array + 4*edi], dx

	; print sorted array
print_rslt:
	mov esi, 0
	inc ecx	; set ecx to the size of array
rpt_arr_prnt:
	mov ax, [array + 4*esi]
	call print_int
	mov eax, space
	call print_string
	inc esi
	xor eax, eax	; set eax 0
	loop rpt_arr_prnt

	call print_nl

	leave
	ret

; search if the input num is in the array

%include "asm_io.inc"

	SECTION .data
array	dd 3, 1, 5, 7, 2, 8, 4, 9, 6, 10
size	dd 10
get_int	dd "Enter a number to search: ", 0x00

	SECTION .text
	global main
main:
	enter 0, 0
	pusha

	; print to enter a number
	mov eax, get_int
	call print_string

	; read a integer
	call read_int
	mov ebx, eax	; the input num is in ebx

	; compare the num and each element
	mov eax, 0	; eax will be the index pointer
	mov ecx, 0
	mov cx, [size]
repeat:	
	mov edx, 0
	mov dx, [array+4*eax]	; put the element of array to edx
	cmp ebx, edx	; compare input num and the element
	je print	; jump to print if the same value has found
	inc eax
	loop repeat	; repeat as the size of the array

	; the value not found
not_found:	mov eax, -1
	
	; print the result
print:	call print_int
	call print_nl

	leave
	ret

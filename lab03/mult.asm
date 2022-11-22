; let the user input two number
; operate multiplication by repeating addition

%include "asm_io.inc"

	SECTION .data
string_a	db "Enter a number A: ", 0x00
string_b	db "Enter a number B: ", 0x00
string_prod	db "A x B = ", 0x00

	SECTION .text
	global main
main:
	enter 0,0	; setup stack frame
	pusha

	mov eax, string_a
	call print_string	; print to enter number A

	call read_int	; read num A
	mov edx, eax ; store num A in edx

	mov eax, string_b
	call print_string	; print to enter number B

	call read_int	; read num B
	mov ecx, eax	; store num B in ecx

	mov ebx, 0	; ebx is sum
repeat:	
	add ebx, edx
	loop repeat	; repeat as ecx times

	mov eax, string_prod
	call print_string	; print the result

	mov eax, ebx
	call print_int
	call print_nl

	leave
	ret

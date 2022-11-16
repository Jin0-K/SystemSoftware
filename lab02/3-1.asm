%include "asm_io.inc"

	section .data
msg	db	"Enter a number", 0x00
num_a	db	" (A) : ", 0x00 ; message to print after msg
num_b	db	" (B) : ", 0x00
rslt	db	"A + B = ", 0x00 ; message to print before result

	section .text
	global main
main :	; Entry Point

	enter 0,0 ; free up the space in stack for local variables

	; print msg to enter number A
	lea eax, [msg] 
	call print_string
	lea eax, [num_a]
	call print_string

	call read_int ; read num A
	mov ebx, eax ; put the input value to ebx

	; print msg to enter number B
	mov eax, msg
	call print_string
	mov eax, num_b
	call print_string

	call read_int ; read num B

	add ebx, eax ; Add B to A

	; print result
	mov eax, rslt
	call print_string
	mov eax, ebx
	call print_int
	call print_nl

	leave
	ret

%include "asm_io.inc"

	section .data
msg	db	"Enter a number", 0
num_a	db	" (A) : ", 0 ; message to print after msg
num_b	db	" (B) : ", 0
rslt_add	db	"A + B = ", 0 ; message to print before result
rslt_sub	db	"A - B = ", 0 ; message to print before result

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

	mov ecx, eax ; Put value of B to ECX

	; print result of addition
	mov eax, rslt_add
	call print_string
	mov eax, ebx ; move value of A to eax
	add eax, ecx ; add A and B
	call print_int
	call print_nl

	; print result of subtraction
	mov eax, rslt_sub
	call print_string
	mov eax, ebx ; move value of A to eax
	sub eax, ecx ; subtract B from A
	call print_int
	call print_nl

	leave
	ret

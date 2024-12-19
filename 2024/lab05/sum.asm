%include "asm_io.inc"

	segment	.data
	;
	; initialized data is put in the data segment here
	;

	segment	.text
	global 	main
calc_sum:
	enter 8,0

	mov dword [ebp-8], 0	; initialize sum to 0
	mov dword [ebp-4], 0	; initialize i to 0
for:	mov ebx, [ebp-4]
	cmp ebx, [ebp+8]
	jg for_end
	add [ebp-8], ebx
	add dword [ebp-4], 1
	jmp short for
for_end:
	mov eax, [ebp-8]	; move the sum to eax
	mov ebx, [ebp+12]	; move sump to ebx
	mov [ebx], eax

	leave
	ret

main:
	enter	4,0		; setup stack frame
	pusha

	call read_int	; get input n
	lea ebx, [ebp-4]
	push ebx
	push dword eax	; push the value in stack (parameter)
	call calc_sum
	add esp, 8

	mov eax, [ebp-4]
	call print_int
	call print_nl

	popa
	mov	eax, 0	; return value
	leave			; leave stack frame
	ret

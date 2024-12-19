
%include "asm_io.inc"

	SEGMENT .data
sum	dd 0

	SEGMENT .text
	global main
main :
	enter 0,0
	pusha

	call read_int	; get an input from user

	xor ebx, ebx
	push sum
	push eax
	call calc_sum

	mov eax, [sum]
	call print_int
	call print_nl

	leave
	ret


calc_sum :
	push ebp
	mov ebp, esp
	sub esp, 4

	mov dword [ebp-4], 0	; sum = 0
	mov ebx, 1	; ebx == i
for_loop :
	cmp ebx, [ebp+8]	; i <= n
	jnle end_for

	add [ebp-4], ebx
	inc ebx
	jmp for_loop
end_for :
	mov ebx, [ebp+12]	; ebx = sump
	mov eax, [ebp-4]	; eax = sum
	mov [ebx], ax	; *sump = sum

	mov esp, ebp
	pop ebp
	ret

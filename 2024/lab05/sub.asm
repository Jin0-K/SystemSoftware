	segment	.text
	global 	calc_sum
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


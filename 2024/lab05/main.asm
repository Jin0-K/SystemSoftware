%include "asm_io.inc"

	segment	.data
	;
	; initialized data is put in the data segment here
	;
num	dd 0

	segment	.text

atoi:	enter 0,0
	xor edi, edi
	mov ebx, 10
	xor eax, eax
	xor ecx, ecx
loop:
        mov cl, [esi+edi]
	cmp cl, 0    ; If it is the end of the string
        je end_loop     ; end atoi operation
        mul ebx         ; Multiply 10 to previous result
        sub cl, 0x30    ; Convert character to integer
        add eax, ecx    ; Add the converted integer to eax
        inc edi
        jmp short loop
end_loop:
	mov [num], eax

	leave
	ret

	global 	main
	extern calc_sum
main:
	enter	4,0		; setup stack frame
	pusha

	mov esi, [ebp+12]
	add esi, 4
	mov esi, [esi]		; put argv[1] in esi
	call atoi		; change the argument string value to integer

	lea ebx, [ebp-4]
	push ebx
	push dword [num]	; push the value in stack (parameter)
	call calc_sum
	add esp, 8

	mov eax, [ebp-4]
	call print_int
	call print_nl

	popa
	mov	eax, 0	; return value
	leave			; leave stack frame
	ret

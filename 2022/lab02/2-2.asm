; text section must have an GLOBAL entry point 'main'
; text section must end with 'ret' instruction
; must include "asm_io.inc"
;	% nasm -f elf sample_io.asm
;	% nasm -f elf -d ELF_TYPE asm_io.asm
;	% gcc -o sample_io sample_io.o asm_io.o	
;	% ./sample_io

%include "asm_io.inc"
	
	section .data
out_string	db "some string" ; define a string


	section .text
	global main
main:
	enter 0,0

	;print out_string
	mov	eax, out_string
	call	print_string
	call	print_nl

	leave
	ret

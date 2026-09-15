section .data

	msg1 db 10, "Enter First String: "
	len1 equ $-msg1
	msg2 db 10, "Enter Second String: "
	len2 equ $-msg2
	msg3 db 10, "Concatenated String: "
	len3 equ $-msg3

section .bss

	string1 resb 10
	string2 resb 10
	output resb 20

	length1 resb 1
	length2 resb 1
	length3 resb 1

%macro rw 4

    mov rax, %1
    mov rdi, %2
    mov rsi, %3
    mov rdx, %4
    syscall
    
%endmacro


section .text

	global _start
	_start:
	
		rw 1, 1, msg1, len1
    		rw 0, 0, string1, 10
    		dec rax
    		mov [length1], al

		rw 1, 1, msg2, len2
		rw 0, 0, string2, 10
		dec rax
		mov [length2], al

		call Concatenate
		rw 1, 1, msg3, len3

		movzx rdx, byte [length3]
		mov rax, 1
		mov rdi, 1
		mov rsi, output
		syscall

		mov rax, 60
		mov rdi, 0
		syscall

	Concatenate:

    		mov al, [length1]
    		add al, [length2]
    		mov [length3], al

		mov rsi, string1
		mov rdi, output
		movzx rcx, byte [length1]

	copy1:
    		cmp rcx, 0
    		je copy2_start

    		mov al, [rsi]
    		mov [rdi], al

    		inc rsi
    		inc rdi
    		dec rcx

    		jmp copy1


	copy2_start:

    		mov rsi, string2
		movzx rcx, byte [length2]

	copy2:
    		cmp rcx, 0
    		je concatenate_done

		mov al, [rsi]
    		mov [rdi], al

    		inc rsi
    		inc rdi
    		dec rcx

    		jmp copy2


	concatenate_done:
		ret

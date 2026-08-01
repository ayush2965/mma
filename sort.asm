
section .data

	arr db 10 10h,8h,2h,5h,1h
	msg db 10, "Array in sorted order is: "
	msg_len equ $-msg
	
section .bss

%macro rw 4

	mov rax,%1
	mov rdi,%2
	mov rsi,%3
	mov rdx,%4 
	
	syscall
%endmacro

section .text

	global _start
	
	_start:
	
		mov rsi,arr
		mov bx,4
		mov cx,5
		
	outerloop:
	
	innerloop:
		
	
	skip:
		dec cx

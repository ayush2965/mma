section .data
	
	msg1 db "Error", 10
	len1 equ $-msg1
	msg2 db "Successful",10
	len2 equ $-msg2
	
section .bss
	
	fname1 resb 15
	fd1 resq 1
	fname2 resb 15
	fd2 resq 1
	buff resb 512
	bufflen resq 1

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
		
		pop r8
		cmp r8,3
		jne error
		pop r8
		pop r8
		mov rsi,fname1
		
	above:
		mov al,[r8]
		cmp al,00
		je next
		mov [rsi],al
		inc r8
		inc esi
		jmp above
		
	next:
		pop r8
		mov rsi,fname2
		
	above2:
		mov al,[r8]
		cmp al,00
		je next2
		mov [rsi],al
		inc r8
		inc rsi
		jmp above2
		
	next2:
		rw 2,fname1,000000q,0777q
		mov [fd1],rax
		rw 0,[fd1],buff,512
		mov [bufflen],rax
		rw 85,fname2,0777q,0
		rw 2,fname2,2,0777q
		mov [fd2],rax
		rw 1,[fd2],buff,[bufflen]
		rw 3,[fd2],0,0
		rw 3,[fd1],0,0
		rw 1,1,msg2,len2
		jmp end
		
	error:
		rw 1,1,msg1,len1
		
	end:
		rw 60,0,0,0
		

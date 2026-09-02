section .data
	msg1 db 10, "Global Descriptor Register Table"
	len1 equ $-msg1
	msg2 db 10, "Base address: "
	len2 equ $-msg2
	msg3 db 10, "Offset: "
	len3 equ $-msg3
	
section .bss
	abc resq 1
	abclim resw 1
	temp64 resq 1
	temp16 resw 1
	asc resb 1

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
		rw 1,1,msg1,len1
		rw 1,1,msg2,len2
		
		mov rsi,abc
		sgdt[rsi]
		mov rax,[rsi]
		call displayba
		
		
		rw 1,1,msg3,len3
		
		mov rsi,abclim
		mov ax,[rsi]
		call displayoffset
	
	rw 60,0,0,0
	
	displayoffset:
	
		mov bp,4
		up2:
			rol ax,4
			mov [temp16],ax
			and ax,0Fh
			cmp al,09
			jbe down2 
			add al,07h
		down2:
			add al,30h
			mov [asc],al
			rw 1,1,asc,1
			mov ax,[rsi]
			dec bp
			jnz up2
		ret
		
		
	displayba:
	
		mov bp,16
		up:
			rol rax,4
			mov rbx,rax
			and rax,0Fh
			cmp al,09
			jbe down 
			add al,07h
		down:
			add al,30h
			mov [asc],al
			rw 1,1,asc,1
			mov rax,[rsi]
			dec bp
			jnz up
		ret
	
		
		
		

section .data
    	mainstr db "AyushDeshAyuDeAyu",0
    	substr db "Ayu", 0
    	msg1 db "Substring exists",10
    	len1 equ $-msg1
    	msg2 db "Substring does not exist",10
    	len2 equ $-msg2
    
section .bss
	count resb 1

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
		mov byte[count],0
		mov rsi,mainstr       
		mov rdi,substr        

	next:

    		mov rbx,rsi
    		mov rdi,substr
    		mov rcx,3
    		repe cmpsb
    		je exists

    		mov rsi,rbx
    		inc rsi
    		cmp byte[rsi],0
    		je absent
    		jmp next

	exists:
    		rw 1,1,msg1,len1
    		inc byte[count]

		mov rsi,rbx
    		inc rsi
    		cmp byte[rsi],0
    		je display

    		jmp next


	absent:
    		rw 1,1,msg2,len2
    		jmp exit
    		
    	display:
    		add byte[count],'0'
    		rw 1,1,count,1

	exit:
    		rw 60,0,0,0

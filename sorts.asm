section .data
array db 12h,72h,26h,07h,55h
msg db 10, "The elements in sorted order are: "
msglen equ $-msg
section .bss
temp resb 1
result resq 1
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
mov bl,5
outerloop:
mov cl,4
mov rsi,array
innerloop:
mov al,byte[rsi]
cmp al,byte[rsi+1]
jbe noswap
xchg al,byte[rsi+1]
mov byte[rsi],al
noswap:
inc rsi
dec cl
jnz innerloop
dec bl
jnz outerloop
rw 1,1,msg,msglen
mov rsi,array
mov r8,5
display:
mov al,[rsi]
mov bp,2
up:
rol al,4
mov r9b,al
and al,0Fh
cmp al,09
jbe down
add al,07h
down:
add al,30h
mov byte[temp],al
mov [result],rsi
rw 1,1,temp,1
mov rsi,[result]
mov al,r9b
dec bp
jnz up
mov byte[temp], ' '
mov [result],rsi
rw 1,1,temp,1
mov rsi,[result]
inc rsi
dec r8
jnz display
rw 60,0,0,0

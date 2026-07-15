Section .Data
  	msg db 10,"What is your name?"
	msg_len equ $-msg
	prn db 10, "What is your PRN?"
	prn_len equ $-prn

Section .bss
	input_msg_arr resb 30
	input_prn_arr resb 30
	
%macro read_write 4
	mov rax, %1
	mov rdi, %2
	mov rsi, %3
	mov rdx, %4
	syscall
%endmacro



Section .text
	Global _start
  _start:

	
  	read_write 1,1,msg,msg_len
  	read_write 0,0,input_msg_arr,30
  	read_write 1,1,prn,prn_len
  	read_write 0,0,input_prn_arr,30
  	read_write 1,1,input_msg_arr,30
  	read_write 1,1,input_prn_arr,30
  	
  

	mov rax,60
	mov rdi,0
  syscall

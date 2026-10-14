timer

;polling method
;org 0000h
;clr p0.7
;mov A,#0F0h
;up:
;mov tmod, #01h
;mov th0, #0FFh
;mov tl0, 0F0h
;mov p1, A
;setb tcon.4
;here:
;jnb tcon.5,here
;clr tcon.4
;clr tcon.5
;cpl A
;sjmp up

;interrupt method
org 0000h
clr p0.7
mov a,#0Fh
mov IE, #88h
mov tmod, #10h
mov tl1, #0F0h
mov th1, #0FFh
setb 8Eh
here:
sjmp here
org 001bh
clr 8Eh
clr 8Fh
cpl A
mov P1,A
mov tl1,0FFh
mov th1, 0FFh
setb 8Eh
reti

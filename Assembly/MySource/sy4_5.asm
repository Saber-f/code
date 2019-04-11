assume cs: code
a segment
   db 1,2,3,4,5,6,7,8
a ends

b segment
   db 1,2,3,4,5,6,7,8
b ends

c segment
   db 0,0,0,0,0,0,0,0
c ends

code segment
start:     
    mov bx,0 
    mov cx,4
 s: mov ax,a
    mov ds,ax
    mov dx,[bx]
    mov ax,b
    mov ds,ax
    add dx,[bx]
    mov ax,c
    mov ds,ax
    mov [bx],dx  
    inc bx  
    inc bx
    loop s
code ends
end start

assume cs:codesg
codesg segment    
start:
    mov ax,0000h
    mov ds,ax
    mov bx,0200h   
    mov cx,0040h
s:  mov [bx],bl
    inc bl
    loop s
    mov ax,4c00h
    int 21h
codesg ends
end
mov ax,1000h
mov ds,ax 

mov [0],23h
mov [1],11h
mov [2],22h
mov [3],11h

mov ax,11316
mov [0],ax
mov bx,[0]
mov bx,[2]
mov [2],bx
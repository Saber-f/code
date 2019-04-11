mov ax,1000h
mov ds,ax     

mov [0],23h
mov [1],11h
mov [2],22h
mov [3],66h

mov ax,[0]
mov bx,[2]
mov cx,[1]
add dx,[1]
add cx,[2]
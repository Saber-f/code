assume cs:codesg
codesg segment    
start:
    mov ax,2000H
    mov ds,ax 
    mov ax,1000H
    mov ss,ax
    mov sp,0000H
    pop [000EH]
    pop [000CH]
    pop [000AH]
    pop [0008H]
    pop [0006H]
    pop [0004H]
    pop [0002H]
    pop [0000H]
    
    mov ax,4c00h
    int 21h
    
codesg ends
end


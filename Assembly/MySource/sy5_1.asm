assume cs: codesg, ds:datasg, ss:stacksg
stacksg segment
    dw 0,0,0,0,0,0,0,0
stacksg ends

datasg segment
   db '1. display      ' ; ���ַ���ռ16���ֽڣ�����λ�Կո���䣨����3���ַ������ƣ�
   db '2. brows        '
   db '3. replace      '
   db '4. modify       '
datasg ends

codesg segment
start:
      mov ax,datasg
      mov ds,ax
      mov dx,5 
       
y:    mov bx,3   
      mov cx,4  
      
s:    mov al,[bx]
      sub al,20h
      mov [bx],al
      inc bx    
      
      loop s 
      
      sub dx,1   
      mov cx,dx  
      
      mov ax,ds
      inc ax
      mov ds,ax  
      
      loop y 
      
      
     
codesg ends
end start

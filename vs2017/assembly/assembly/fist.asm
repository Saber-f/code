TITLE Add and Subtract              (AddSub.asm)  
  
; This program adds and subtracts 32-bit integers.  
; Last update: 2/1/02  
  
  
INCLUDELIB kernel32.lib  
  
.MODEL flat,stdcall  
  
;.code  
ExitProcess PROTO,                      ; exit program  
    dwExitCode:DWORD					; return code  
  
  
.data  
.code  
main PROC  

    mov ax,62627
 	mov ah,31H
	mov al,23H
	add ax,ax
	mov bx,826CH
	mov cx,ax
	mov ax,bx
	add ax,bx
	mov al,bh
	mov ah,bl
	add ah,ah
	add al,6
	add al,al
	mov ax,cx

	jmp 0:0
  
    push 0h  
    call ExitProcess  

main ENDP  
END main 
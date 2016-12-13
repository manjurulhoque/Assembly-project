.model small
.stack 100h

.data
msg1 db 13,10,13,10, "Enter 1st Number : $"
msg2 db 13,10, "Enter 2nd Number : $"
msgEr db 13,10, "Error $"
msgCh db 13,10, "Press A to ADD , S to SUBTRACT ,D to MULTIPLY, F to DIVIDE, X to EXIT : $ "
msgSum db 13,10,13,10, "Sum is : $"
msgDif db 13,10,13,10, "Difference is : $"
msgDiv db 13,10,13,10, "Quotient is : $"
msgMul db 13,10,13,10, "Product is : $"
tmp     db ?


.code

start:
mov ax, @data
mov ds, ax

lea dx, msg1
mov ah, 09h
int 21h
mov bx, 0

start1:
mov ah, 01h
int 21h
cmp al,0dh      
je next1
mov ah,0        
sub al,30h      
push ax         
mov ax,10d      
mul bx          
pop bx          
add bx,ax       
jmp start1      




next1:
push bx
lea dx,msg2
mov ah,09h
int 21h

mov bx,0


start2:
mov ah,01h
int 21h
cmp al,0dh
je choice
mov ah,0
sub al,30h
push ax
mov ax,10d
mul bx
pop bx
add bx,ax 
jmp start2


choice:
lea dx, msgCh
mov ah, 09h
int 21h

mov ah, 01h

int 21h

cmp al,'f'
je dividing

cmp al,'a'  
je adding

cmp al,'s'
je subtracting

cmp al,'d'
je multiplying

cmp al,'x'
mov ah, 4ch
int 21h

error:
lea dx,msgEr
mov ah,09h
int 21h 
jmp start


dividing: 
pop ax
div bx
push ax
lea dx,msgDiv
mov ah,09h
int 21h 
pop ax
mov cx,0
mov dx,0
mov bx,10d
jmp break

adding:     
pop ax
add ax,bx   
push ax
lea dx,msgSum   
mov ah,09h
int 21h 
pop ax
mov cx,0
mov dx,0
mov bx,10d
jmp break   

multiplying: 
pop ax
mul bx      
push ax     
lea dx,msgMul   
mov ah,09h
int 21h 
pop ax
mov cx,0
mov dx,0
mov bx,10d
jmp break


subtracting: 
pop ax
sub ax,bx 
push ax
lea dx,msgDif
mov ah,09h
int 21h 
pop ax
mov cx,0
mov dx,0
mov bx,10d

break:
div bx
push dx
mov dx,0
inc cx
or ax,ax 
jne break 

ans:        
pop dx
add dl,30h
mov ah,02h
int 21h
loop ans

jmp start

end start
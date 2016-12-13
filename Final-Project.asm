include 'emu8086.inc'

.MODEL SMALL
.STACK 100H

.DATA
CAL DB "Calculator$"
PUT1 DB ?
RETURN DB ?
A DW ?
B DW ?
;INFO DB 9,9,"About Me"

.CODE
MAIN PROC 
    
    define_scan_num
    define_print_num_uns
    define_print_num
    
    MOV AX,@DATA
    MOV DS,AX
    
     
    MOV BL, 1
    MOV AH,9
    MOV AL, 0
    INT 10h
    INT 21H
    
    
    ;Starting of Project
    START:
        MOV AH, 0  ; clearing the screen
        INT 10h
        
        
		PRINTN "      Calculator  "
		PRINTN ""
		PRINTN ""
		PRINTN "1.Addition"
		PRINTN "2.Subtraction"
		PRINTN "3.Multiplication"
		PRINTN "4.Division"
		PRINTN "5.Square of a number"
		PRINTN "6.Cube of a number"
		PRINTN "7.About Me"
		PRINTN ""
		PRINT "Enter a number which one you want: "
		
		MOV AH,1  ;video mode
		INT 21H
		MOV PUT1,AL
		
		CMP PUT1,'1'   
		JE  Addition    ;Go to the Addition label
		CMP PUT1,'2'
		JE  Subtraction ;Go to the Subtraction label
		CMP PUT1,'3'  
		JE  Multiplication    ;Go to the Multiplication label
		CMP PUT1,'4'   
		JE  Division    ;Go to the Division label
		CMP PUT1,'5'
		JE  Square       ;Go to the Square label
		CMP PUT1,'6'
		JE  Cube       ;Go to the Cube label
		CMP PUT1,'7'
		JE  About       ;Go to the About Me label
		CMP PUT1, '8'
		JGE greater 
   
    
    ;Greater than
    greater:
        PRINTN ""
		PRINTN ""
		PRINT "Insert Number Between 1 to 7 "
		JMP START
    
    ;Addition Label
    Addition:
		PRINTN ""
		PRINTN ""
		PRINT "Enter 1st number: "
		call scan_num
		mov ax,cx
		
		; New line
		putc 0ah
		putc 0dh
		
		PRINT "Enter 2nd number: "
		call scan_num
		add ax,cx
		
		putc 0ah
		putc 0dh
		
		PRINTN ""
		PRINT "Result: Sum is "               
		 
		call print_num 
		jmp Last_Label
	   
    ;Subtraction Label
    Subtraction:
		PRINTN ""
		PRINTN ""
		PRINT "Enter 1st number: "
		call scan_num
		mov ax,cx
		
		putc 0ah
		putc 0dh
		
		PRINT "Enter 2nd number: "
		call scan_num
		sub ax,cx
		
		putc 0ah
		putc 0dh
		
		PRINTN ""
		PRINT "Result: Subtraction is " 
		call print_num
		jmp Last_Label
    
    
    
    ;Multiplication Label
    Multiplication:
        PRINTN ""
        PRINTN ""
        PRINT "Enter 1st number: "
        call scan_num
        mov ax,cx
    
        putc 0ah
        putc 0dh
        
        PRINT "Enter 2nd number: "
        call scan_num
        mul cx
    
    
        putc 0ah
        putc 0dh 
    
        PRINTN ""
        PRINT "Result: Multiplication is " 
        call print_num
        jmp Last_Label
    
    
    
    ;Division Label
    Division:
        PRINTN ""
        PRINTN ""
        PRINT "Enter 1st number: "
        call scan_num
        mov ax,cx
    
        putc 0ah
        putc 0dh
    
        PRINT "Enter 2nd number: "
        call scan_num
        div cx
    
    
        PRINTN "" 
    
        PRINTN ""
        PRINT "Result: Quotient is " 
        call print_num
        PRINTN ""
        PRINT "        Remainder is "
      
        mov ax,dx
        call print_num
        jmp Last_Label
    
    
    ;Square Label
    Square:
        PRINTN ""
        PRINTN ""
        PRINT "Enter a number: "
        call scan_num
        mov ax,cx  
    
        mul cx
    
        printn ""
           
        PRINT "Result: Square is "        
        call print_num
        jmp Last_Label
    
    
    ;Cube Label:
    Cube:
        PRINTN ""
        PRINTN ""
        PRINT "Enter a number: "
        call scan_num
        mov ax,cx  
    
        mul cx
        mul cx
    
        printn ""
           
        PRINT "Result: Cube is "        
        call print_num
        jmp Last_Label 
    
    
    
    ;About Us Label
    About:
        PRINTN ""
        PRINTN "                 About Me"
        PRINTN "Saiyed Muhammed Manjurul Hoque (151-15-5440)"
        PRINTN "Daffodil International University"
        PRINTN "Section: D"
        PRINTN ""
        ;PRINTN ""
        jmp Last_Label 
    
    
    
    ;Last Label
    Last_Label:
        PRINTN ""
        PRINTN ""
        PRINTN "Do you want to back again?"
        print "(Y or y for Yes || N or n for No)"
    
        MOV AH,1
        INT 21H
        MOV RETURN,AL
    
        CMP RETURN,'Y'
        JE START
        CMP RETURN,'y'
        JE START
        CMP RETURN,'N'
        JE EXIT
        CMP RETURN,'n'
        JE EXIT
    
     
    ;EXIT LABEL
    EXIT:
        PRINTN ""
        PRINTN ""
        PRINTN "Thank you for using our made Calculator"
    
        MOV AH,4CH
        INT 21H
END MAIN   
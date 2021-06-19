.MODEL SMALL
.STACK 100
.DATA
    STR1 DB 'PLEASE ENTER THE NUMBER $'
    STR2 DB 'THE NUMBER IS EVEN$'
    STR3 DB 'THE NUMBER IS ODD$'
    NEWLINE DB 13,10,'$'
.CODE
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        
        
        ;ASK FOR USERS INPUT
        MOV AH,09H
        LEA DX,STR1
        INT 21H
        ;TAKE INPUT TO AL
        mov AH,01H
        INT 21H
        MOV BL,AL
        MOV AH,0H
        MOV DL,2
        DIV DL
        ; CHECK IF IT EVEN OR ODD
        TEST AH,0FH
        JZ EVEN
        
        CALL PRINTNEWLINE
        MOV AH,09H
        LEA DX,STR3
        INT 21H
        
        

    MAIN ENDP
    
    EVEN:
        CALL PRINTNEWLINE
        MOV AH,09H
        LEA DX,STR2
        INT 21H
        
        CALL ENDER


    PRINTNEWLINE PROC
        MOV AH,09H
        LEA DX,NEWLINE
        INT 21H
        RET
    PRINTNEWLINE ENDP 
    
    ENDER PROC
        MOV AH,4CH
        INT 21H
    ENDER ENDP
     
.MODEL SMALL
.STACK 100
.DATA
    STR1 DB 'THE INPUT DATA IS NOT A CHARACTER$'
    STR2 DB 'PLEASE ENTER THE CHARACHTER $'
    STR3 DB 'THE CHARACHTER IS $'
    NEWLINE DB 13,10,'$'
    
.CODE
    MAIN PROC
        
        MOV AX,@DATA
        MOV DS,AX
        
        ; ASK FOR CHARACHETER INPUT
        
        MOV AH,09H
        LEA DX,STR2
        INT 21H
                
        ;READ THE CHARACHTER INPUT
        MOV AH,01H
        INT 21H
        MOV BL,AL ; COPY THE CHAR TO BL
         
        ;CALL FUNCTION TO CHECK THE CHARACHTER
        CALL CHECK_CHAR
        ; FINISH THE CODE
        MOV AH,4CH
        INT 21H
    MAIN ENDP
    
    
    CHECK_CHAR PROC
        TEST BL,20H
        JZ CAPITAL
        ; IF NOT CAPITAL LETTER
        CALL PRINTNEWLINE
        
        MOV AH,09H
        LEA DX,STR3
        INT 21H

        mov AH,02H
        MOV DL,'S'
        INT 21h
        RET
    CHECK_CHAR ENDP  
    
    CAPITAL:
        CALL PRINTNEWLINE
        
        MOV AH,09H
        LEA DX,STR3
        INT 21H

        mov AH,02H
        MOV DL,'U'
        INT 21h
        RET

    PRINTNEWLINE PROC
        MOV AH,09H
        LEA DX,NEWLINE
        INT 21H
        RET
    PRINTNEWLINE ENDP    

 

ORG 100
.MODEL SMALL
.STACK 100
.DATA
   STR1 DB 'ENTER THE FIRST NUMBER$'
   STR2 DB 'ENTER THE SECOND NUMBER$'
   STR3 DB 'THE MULTIPLICATION IS $'
   NEWLINE DB 13,10,'$'
   
.CODE
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        
        ;ASK FOR INPUT
        MOV AH,09H
        LEA DX,STR1
        INT 21H
        
        ;TAKE THE FIRST INPUT
        
        MOV AH,01H
        INT 21
        MOV BL,AL ;COPY TO BL
        
        CALL NL    
        
        ;ASK FOR THE SECOND INPUT
        MOV AH,09H
        LEA DX,STR2
        INT 21H 
        
        ;TAKE THE SECOND INPUT        
        MOV AH,01H
        INT 21
        
        
        CALL NL
               
        MUL BL
        
        ;PRINT THE ANSWER IS
        MOV AH,09H
        LEA DX,STR3
        INT 21H
        
        MOV AH,02H
        MOV DX,AX
        INT 21H
        
        
        
        
    MAIN ENDP
    
    NL PROC
        MOV AH,09
        LEA DX,NEWLINE
        INT 21H
        RET
    NL ENDP  

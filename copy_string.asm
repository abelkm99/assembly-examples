.MODEL SAMLL
.STACK 100

.DATA
    MSG_INPUT DB 'ENTER THE STRING TO BE DECRYPTED: $'
    NEW_LINE DB 13,10,'$'
    MSG_OUTPUT DB 'THE OUTPUT OF THE GIVEN STRING IS: $'
    MSG_ENC DB 'ENTER THE ENCRYPTION KEY $'
    MSG_DEC DB 'ENTER THE THE THRE KEYS $'
    
    COPY_LOCATION DW ?
    
.CODE
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        MOV ES,AX
        
    
        MOV AH,09H
        LEA DX,MSG_INPUT
        INT 21H
             
        
        CALL STRING_INPUT
        
        CALL NEWLINE
        
        CALL STRING_COPY 
        
        CALL PRINT_STRING

        CALL END_PROGRAM
        
    MAIN ENDP
    
    
    STRING_COPY PROC     
        
        INT 3H
        
        MOV CX,BX
        JCXZ ENDPRINT
            
        ; COPY TO DS 
    
        MOV DI,COPY_LOCATION      
        PRINT:
            LODSB
            MOV [DI],AL
            INC DI                       
            LOOP PRINT
            
        XOR SI,SI
    
        
        RET
        
    STRING_COPY ENDP
    
    
    STRING_INPUT PROC
       
        
            INPUT_LOOP: 
            
            ; take input
            MOV AH,01H
            INT 21H                               
            
            ;compare it the enterd char is 'ENTER'           
            CMP AL,0DH
            JE END_INPUT       ; IF TRUE JUMP TO THE END
            
            CMP AL,08H
            JE BACKSPACE       ; IF BACK JUMP T BACKSPACE METHOD
                               
                               ; ELSE STORE THE VALUE INTO MOV ES[DI]:AL AND INCREMENT BX BY ONE
            STOSB
            INC BX
            JMP INPUT_LOOP
            
            
            
            
        ;IF THE USER INPUT IS 'ENTER' JUMP TO END_INPUT
        ;THIS WILL RETURN TO THE MAIN FUNCTION        
        
        END_INPUT:
            MOV COPY_LOCATION,BX
            ADD COPY_LOCATION,5  ;ADD A DISTANCE OF 5 FOR THE COPY LOCATION
            CALL NEWLINE
            RET
            
            
        BACKSPACE:
            
            CMP BX,0
            
            MOV AH,02H
            MOV DL,' '
            INT 21H
            
            JE INPUT_LOOP
             
            
            MOV DL,08H
            INT 21H
            
            DEC BX
            DEC DI
            
 
            JMP INPUT_LOOP
            
            
    STRING_INPUT ENDP 
    
    PRINT_STRING PROC
        INT 3H

      
        MOV CX,BX
        
        JCXZ ENDPRINT
        
        MOV AH,2H
        
        MOV SI,COPY_LOCATION
        
        VIEW:
            LODSB
            MOV DL,AL
            INT 21H
            
            LOOP VIEW
            
        XOR SI,SI
        
        CALL NEWLINE

        RET
        ENDPRINT:
            RET
        
        
        
        
    PRINT_STRING ENDP
    
 ;PRINT NEW LINE
    
    NEWLINE proc
        MOV AH,09H
        LEA DX,NEW_LINE
        MOV AH,09H
        INT 21H
        RET
    NEWLINE ENDP
    
    ;GET THE THREE KEYS FOR THE PROCESS
        
    
    ;END THE PROGRAM PROCESS                 
    END_PROGRAM PROC
        MOV AH,4CH
        INT 21H
        RET
    END_PROGRAM ENDP                 
    
    
    
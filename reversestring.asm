.MODEL SAMLL
.STACK 100

.DATA
    MSG_INPUT DB 'ENTER THE STRING TO BE REVERSED: $'
    NEW_LINE DB 13,10,'$'
    MSG_OUTPUT DB 'THE OUTPUT OF THE REVERSED STRING IS: $'
    
    COPY_LOCATION DW ?
    NUMBS DW ?
    
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
        
        CALL REVERSE_COPY
        
        MOV AH,09H
        LEA DX,MSG_OUTPUT
        INT 21H 
        
        CALL PRINT_STRING

        CALL END_PROGRAM
        
    MAIN ENDP
    
    
    REVERSE_COPY PROC     
        
        
        MOV CX,NUMBS
        
        MOV SI,NUMBS
        DEC SI ;DECREMENT BY ONE SINCE WE WANT TO COPY FROM THE LAST LOCATION BEFORE THE (OFF BY ON)
        
        
        JCXZ ENDPRINT
        
            
        ; COPY TO DS 
    
        MOV DI,COPY_LOCATION      
        PRINT:
            MOV AL,[SI]
            
            MOV [DI],AL
            
            INC DI                       
            DEC SI
            LOOP PRINT
            
        XOR SI,SI
    
        
        RET
        
    REVERSE_COPY ENDP
    
    
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
            MOV NUMBS,BX
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
    
    
    
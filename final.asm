.MODEL SAMLL
.STACK 100

.DATA
    MSG_INPUT DB 'ENTER THE STRING TO BE DECRYPTED: $'
    NEW_LINE DB 13,10,'$'
    MSG_OUTPUT DB 'THE OUTPUT OF THE GIVEN STRING IS: $'
    MSG_ENC DB 'ENTER THE ENCRYPTION KET $'
    MSG_DEC DB 'ENTER THE THE THRE KEYS $'
    NUMS DW ?
    KEY1 DB ?
    KEY2 DB ?
    KEY3 DB ?
    
.CODE
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        MOV ES,AX
        
    
        MOV AH,09H
        LEA DX,MSG_INPUT
        INT 21H
             
        
        CALL STRING_INPUT
        
        
        MOV AH,09H
        LEA DX,MSG_ENC
        INT 21H
        
        CALL GETKEY
        
        
        
        CALL ENCRYPT_STRING
        
        CALL PRINT_STRING
        
        CALL DECRYPT_STRING
        
        CALL PRINT_STRING 
        
        
        CALL END_PROGRAM
        
    MAIN ENDP
    
    
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
            MOV NUMS,BX
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
        
        PRINT:
            LODSB
            MOV DL,AL
            INT 21H
            
            LOOP PRINT
            
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
    GETKEY PROC
        MOV AH,01
        INT 21H
        MOV KEY1,AL
        
        MOV AH,01
        INT 21H
        MOV KEY2,AL
        
        MOV AH,01
        INT 21H
        MOV KEY3,AL
        
        CALL NEWLINE
        RET
    GETKEY ENDP
    ;============================================
    ;      THIS WILL ENCRYPT THE STRING         ;
    ;============================================
    
    ENCRYPT_STRING PROC
        
        ; USE NESTED LOOP TO DO THE OPERATIONS 
        
        ; WE CAN USE LODS B AND USE IT AS MOV AL,[SI] AND INC SI 
        INT 3H
        
        MOV CX,NUMS
        ENC:
            MOV AL,[SI]
            
            PUSH CX
             
            MOV CX,3
            ENCRYPT:
                
                PUSH CX
                MOV CL,KEY2
            
                XOR AL,KEY1
                ROL AL,CL
                ADD AL,KEY3
                
                POP CX
                
                LOOP ENCRYPT
                
            MOV [SI],AL
            INC SI
            
            POP CX
            
            LOOP ENC
            
               
        XOR SI,SI   ; RESET SI TO 0 
        
        RET                        
       
    ENCRYPT_STRING ENDP
    
    ;============================================
    ;      THIS WILL DECRYPT THE STRING         ;
    ;============================================
    
    DECRYPT_STRING PROC
        
        MOV CX,NUMS   
        DCR:
  
            MOV AL,[SI]
            PUSH CX
            MOV CX,3
        
            DECRYPT:
            
                PUSH CX
                MOV CL,KEY2
                
                SUB AL,KEY3
                ROR AL,CL
                XOR AL,KEY1
                
                
                
                POP CX
                LOOP DECRYPT 
                   
            MOV [SI],AL
            INC SI
            POP CX
            
            LOOP DCR
            
        XOR SI,SI    ; RESET SI TO 0
        RET    
        
    DECRYPT_STRING ENDP
    
    
    
    
    ;END THE PROGRAM PROCESS                 
    END_PROGRAM PROC
        MOV AH,4CH
        INT 21H
        RET
    END_PROGRAM ENDP                 
    
    
    
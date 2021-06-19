.MODEL SMALL
.STACK 100

.DATA
    ;assign VARIANLE
    
    MSG_INPUT1 DB 'ENTER THE FIRST STRING: $'
    NEW_LINE DB 13,10,'$'
    MSG_INPUT2 DB 'ENTER THE SECOND STRING: $'
    
    NOTEQUAL DB 'THE STRINGS ARE NOT EQUAL!! $'
    EQUAL DB 'THE STRINGS ARE EQUAL!! $'

    NUMS1 DW ?
    NUMS2 DW ?
    STATE DW 0H
    
.CODE
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        MOV ES,AX
        
        ; DISPLAY PROMPT 1
        MOV AH,09H
        LEA DX,MSG_INPUT1
        INT 21H
            
        
        CALL STRING_INPUT
        
         
        CALL NEWLINE       
        
        MOV AH,09H
        LEA DX,MSG_INPUT2
        INT 21H
        
       
        
        CALL STRING_INPUT 
        
        CALL NEWLINE
        
        CALL COMPARE_STRING
        
         
        
        
        CALL END_PROGRAM
        
    MAIN ENDP
    
    
    
    
     COMPARE_STRING PROC
        INT 3 
        
        ;FIRST IF THE LENGTH OF THE STRING IS EQUAL
        
        MOV AX,NUMS1
        MOV BX,NUMS2
        
        CMP AX,BX
        JNE PRINT_NOTEQUAL
        
        XOR DI,DI
        MOV SI,NUMS1
        
        MOV CX,NUMS1
        
        COMPARE:
            MOV AL,[DI]
            MOV AH,[SI]
            CMP AL,AH
            JNE PRINT_NOTEQUAL
            INC DI
            INC SI
            LOOP COMPARE
        
        ; ELSE PRINT EQUAL
        
         MOV AH,09H
         LEA DX,EQUAL
         INT 21H
         RET
        
               
        PRINT_NOTEQUAL:
            MOV AH,09H
            LEA DX,NOTEQUAL
            INT 21H
            RET
        
    COMPARE_STRING ENDP
    
    
    STRING_INPUT PROC
            
            XOR CX,CX

            INPUT_LOOP: 
            
            ; take input
            MOV AH,01H
            INT 21H                               
            
            ;compare it the enterd char is 'ENTER'           
            CMP AL,0DH
            JE END_INPUT       ; IF TRUE JUMP TO THE END
                               
                               ; ELSE STORE THE VALUE INTO MOV ES[DI]:AL AND INCREMENT BX BY ONE
            STOSB
            INC BX
            INC CX
            JMP INPUT_LOOP
            
            
            
            
        ;IF THE USER INPUT IS 'ENTER' JUMP TO END_INPUT
        ;THIS WILL RETURN TO THE MAIN FUNCTION        
        
        END_INPUT:
            MOV DX,STATE
            CMP DX,0
            JE CHANGE_STATE
            MOV NUMS2,CX
            
            RET
       
        CHANGE_STATE:
            MOV DX,01H
            MOV STATE,DX
            MOV NUMS1,CX
            RET
            
            
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
    
    
    
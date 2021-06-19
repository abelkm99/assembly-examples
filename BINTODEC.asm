.MODEL SMALL
.STACK 100

.DATA
 MSG1 DW 0AH,0DH,'ENTER THE BINARY NUMBER','$'
 MSG2 DW 0AH,0DH,'THE DECIMAL NUMBER IS ','$'
 
 LENGTH DB ?
 
 MAP DB 1,2,4,8,16,32,64,128
   
    
.CODE
    MAIN PROC
        
        MOV AX,@DATA
        MOV DS,AX
        
        
        MOV AH,09
        LEA DX,MSG1
        INT 21H
        
        CALL TAKEINPUT
        
        
        
        
        
        MOV DX,0H
        
        LEA BX,MAP
        
        CONVERT:
            MOV AX,0H
            MOV AL,LENGTH
            XLATB
            
            MUL [DI]
            ADD DX,AX
            
            DEC DI
            DEC LENGTH
            LOOP CONVERT
        
        
        MOV BX,DX
        
        
        
        MOV AH,09
        LEA DX,MSG2
        INT 21H
      
        
        MOV AX,BX
        MOV BX,10 
        
        MOV CX,0
        LOOP1:
            INC CX
            MOV DX,0
            DIV BX
            ADD DL,30H
            PUSH DX
            CMP AX,9
            JG LOOP1
            
        ADD AL,30H
        MOV [SI],AL
        
        LOOP2:
            POP AX
            INC SI
            MOV [SI],AL
            LOOP LOOP2           
        
        MOV CX,SI
        INC CX
        XOR SI,SI ;CLEAR SI TO 0     
        
        
        MOV AH,02
        PRINT:
            MOV DL,[SI]
            INC SI
            INT 21H
            LOOP PRINT                  
        
        MOV AH,4CH
        INT 21  
    MAIN ENDP
    
    TAKEINPUT PROC
         
         MOV CX,0   ; CLEAR CX
        
         INPUT:
            MOV AH,01
            INT 21H
            
            ;CHECK IF THE GIVEN CHARACHTER IS 'ENTER'
                       
            CMP AL,0DH ;COMPARE AL,0DH
            JE ENDINPUT
            
            SUB AL,30H
            MOV [DI],AL
            INC DI
            
            INC CL ;INC CL
            JMP INPUT
         
          ENDINPUT:
            MOV LENGTH,CL
            DEC LENGTH
            DEC DI
            RET 
    TAKEINPUT ENDP    
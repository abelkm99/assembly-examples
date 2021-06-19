.MODEL SMALL
 .STACK 100H

 .DATA
   PROMPT_1  DB  'Enter a string ( max. 25 characters )  : $'
   PROMPT_2  DB  0DH,0AH,'The string is : $'

   STRING    DB  25 DUP (?)

 .CODE
   MAIN PROC
     MOV AX, @DATA                ; initialize DS and ES
     MOV DS, AX
     MOV ES, AX

     LEA DX, PROMPT_1             ; load and print the string PROMPT_1 
     MOV AH, 9
     INT 21H

     LEA DI, STRING               ; set DI=offset address of variable STRING

     CALL READ_STR                ; call the procedure READ_STR

     LEA DX, PROMPT_2             ; load and print the string PROMPT_2
     MOV AH, 9
     INT 21H

     LEA SI, STRING               ; set SI=offset address of variable STRING

     CALL DISP_STR                ; call the procedure DISP_STR

     MOV AH, 4CH                  ; return control to DOS
     INT 21H
   MAIN ENDP



 ;-------------------------  Procedure Definitions  ------------------------;




 ;-------------------------------  READ_STR  -------------------------------;


  READ_STR PROC
    ; this procedure will read a string from user and store it
    ; input : DI=offset address of the string variabel
    ; output : BX=number of characters read
    ;        : DI=offset address of the string variabel

    PUSH AX                       ; push AX onto the STACK
    PUSH DI                       ; push DI onto the STACK

    CLD                           ; clear direction flag
    XOR BX, BX                    ; clear BX

    @INPUT_LOOP:                  ; loop label
      MOV AH, 1                   ; set input function 
      INT 21H                     ; read a character

      CMP AL, 0DH                 ; compare AL with CR
      JE @END_INPUT               ; jump to label @END_INPUT if AL=CR

      CMP AL, 08H                 ; compare AL with 08H
      JNE @NOT_BACKSPACE          ; jump to label @NOT_BACKSPACE if AL!=08H

      CMP BX, 0                   ; compare BX with 0
      JE @INPUT_ERROR             ; jump to label @INPUT_ERROR if BX=0

      MOV AH, 2                   ; set output function
      MOV DL, 20H                 ; set DL=20H
      INT 21H                     ; print a character

      MOV DL, 08H                 ; set DL=08H
      INT 21H                     ; print a character

      DEC BX                      ; set BX=BX-1
      DEC DI                      ; set DI=DI-1
      JMP @INPUT_LOOP             ; jump to label @INPUT_LOOP

      @INPUT_ERROR:               ; jump label
      MOV AH, 2                   ; set output function
      MOV DL, 07H                 ; set DL=07H
      INT 21H                     ; print a character

      MOV DL, 20H                 ; set DL=20H
      INT 21H                     ; print a character
      JMP @INPUT_LOOP             ; jump to label @INPUT_LOOP      

      @NOT_BACKSPACE:             ; jump label
      STOSB                       ; set ES:[DI]=AL
      INC BX                      ; set BX=BX+1
      JMP @INPUT_LOOP             ; jump to label @INPUT_LOOP

    @END_INPUT:                   ; jump label

    POP DI                        ; pop a value from STACK into DI
    POP AX                        ; pop a value from STACK into AX

    RET
  READ_STR ENDP


 ;-------------------------------  DISP_STR  -------------------------------;


  DISP_STR PROC
    ; this procedure will display the given string 
    ; input : SI=offset address of the string
    ;       : BX=number of characters in the string
    ; output : none

    PUSH AX                       ; push AX onto the STACK
    PUSH BX                       ; push BX onto the STACK
    PUSH CX                       ; push CX onto the STACK
    PUSH DX                       ; push DX onto the STACK
    PUSH SI                       ; push SI onto the STACK

    CLD                           ; clear direction flag
    MOV CX, BX                    ; set CX=BX
    MOV AH, 2                     ; set output function

    JCXZ @SKIP_OUTPUT             ; jump to label @SKIP_OUTPUT if CX=0  

    @OUTPUT_LOOP:                 ; loop label
      LODSB                       ; set AL=DS:[SI]
      MOV DL, AL                  ; set DL=AL
      INT 21H                     ; print a character
    LOOP @OUTPUT_LOOP             ; jump to label @OUTPUT_LOOP while CX!=0

    @SKIP_OUTPUT:                 ; jump label 

    POP SI                        ; pop a value from STACK into SI
    POP DX                        ; pop a value from STACK into DX
    POP CX                        ; pop a value from STACK into CX
    POP BX                        ; pop a value from STACK into BX
    POP AX                        ; pop a value from STACK into AX

    RET
  DISP_STR ENDP





 END MAIN
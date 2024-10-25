.MODEL SMALL
.STACK 100H
.DATA

msg1 DB 'Muhammad Shameel$'
msg2 DB 'Muhammad Shameel$'
msg3 DB 'Muhammad Shameel$'

.CODE   
PRINT MACRO str
    MOV AH, 09H
    LEA DX, str
    INT 21H
    MOV AH, 02H
    MOV DL, 0DH
    INT 21H
    MOV DL, 0AH
    INT 21H
ENDM
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    PRINT msg1
    PRINT msg2
    PRINT msg3

    MOV AX, 4C00H
    INT 21H
MAIN ENDP



END MAIN

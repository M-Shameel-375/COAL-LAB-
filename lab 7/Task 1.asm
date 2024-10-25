;task1
.model small
.stack 100h
.data
    msg db 'Muhammad Shameel', '$'    
.code
main proc
    mov ax, @data          
    mov ds, ax
    
    ; Print the original string
    mov ah, 09h
    lea dx, msg            ; Load address of string
    int 21h                ; Print the string
    
    ; Newline for reverse loop
    mov ah, 02h
    mov dl, 0Dh            
    int 21h
    mov dl, 0Ah            ; Line feed
    int 21h

    ; Reverse the string using stack
    lea si, msg            
    mov cx, 17             
reverse_loop:
    mov al, [si]           ; Load character from the current position in SI
    push ax                ; Push onto stack
    inc si                 ; Move to the next character
    loop reverse_loop      ; Loop until all characters are pushed

    ; Print the reversed string
print_loop:
    pop dx                 ; Pop characters
    mov ah, 02h            ; Print character
    int 21h
    cmp sp, 100h           ; Check if stack is empty 
    jne print_loop
   
    mov ah, 4Ch
    int 21h
main endp
end main
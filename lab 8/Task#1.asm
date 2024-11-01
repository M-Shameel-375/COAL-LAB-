.model small
.stack 100h

.data
    inputString db "Hello, World!", 0  ; Input string with null terminator

.code
main proc
    mov ax, @data         ; Setup data segment
    mov ds, ax   
    
    
    lea ax,inputString
    mov si,ax
    
    mov cx,13
    
    pushloop:
      
    
   
    push [si]
    inc si
    
    loop pushloop
    
    mov cx,13
    poploop:
      
    
   
    pop [si]
    mov dx,[si]
    mov ah,2
    int 21h
    
    dec si
    
    loop poploop
    

    ; Determine the length of the string
   
    mov ax, 4C00h         ; Prepare for program termination
    int 21h               ; Interrupt to exit

main endp
end main

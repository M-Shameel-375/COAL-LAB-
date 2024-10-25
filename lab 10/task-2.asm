.model small
.stack 100h

.data
msg db "The sum of three digits: $"
result db ?  

.code

display macro string
    lea dx, string
    mov ah, 9
    int 21h
endm

newline macro
    mov ah, 2
    mov dl, 13      
    int 21h
    mov dl, 10      
    int 21h
endm

sum_three macro num1, num2, num3
    mov al, num1    
    add al, num2    
    add al, num3    
    add al, '0'     
    mov result, al  
endm

main proc
    mov ax, @data
    mov ds, ax
    
    sum_three 2, 1, 4  

    display msg        
    
    mov ah, 2
    mov dl, result     
    int 21h
    
    newline            
    
    mov ah, 4Ch        
    int 21h
    
main endp

end main

.model small
.stack 100h
.data
msgAdd db "The result of addition is: $"
msgSub db "The result of subtraction is: $"
addResult db ?  
subResult db ?  
.code

add_numbers macro num1, num2
    mov al, num1
    add al, num2  
    add al,'0'
    mov addResult, al
endm

sub_numbers macro num1, num2
    mov al, num1
    sub al, num2
    add al,'0'
    mov subResult, al
endm

main proc
    mov ax, @data
    mov ds, ax  

    add_numbers 5, 3      
    call display_add_result ; Display addition result

    call newline           ; Print new line

    sub_numbers 5, 3      
    call display_sub_result ; Display subtraction result

    mov ah, 4Ch       
    int 21h          
    
main endp 

display_add_result proc
    lea dx, msgAdd
    mov ah, 9     
    int 21h       
    mov ah, 2
    mov dl, addResult    
    int 21h
    ret
display_add_result endp  

display_sub_result proc  
    lea dx, msgSub
    mov ah, 9     
    int 21h       
    mov ah, 2
    mov dl, subResult    
    int 21h
    ret
display_sub_result endp

newline proc
    mov ah, 2
    mov dl, 13      
    int 21h
    mov dl, 10      
    int 21h
    ret
newline endp

end main

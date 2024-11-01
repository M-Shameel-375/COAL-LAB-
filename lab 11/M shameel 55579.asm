.model small
.stack 100h
.data
msgMenu db "Select an option:", 13, 10, "1. Add", 13, 10, "2. Subtract", 13, 10, "3. Divide", 13, 10, "4. Exit", 13, 10, "$"
msgChoice db "Enter your choice (1-4): $"
msgInput1 db "Enter the first number (0-9): $"
msgInput2 db "Enter the second number (0-9): $"
msgAdd db "The result of addition is: $"
msgSub db "The result of subtraction is: $"
msgDiv db "The result of division is: $"
msgError db "Error: Division by zero", 13, 10, "$"
addResult db ?  
subResult db ?  
divResult db ?  
num1 db ?        ; Stores first number input
num2 db ?        ; Stores second number input

.code

add_numbers macro 
    mov al, num1
    add al, num2  
    add al, '0'
    mov addResult, al
endm

sub_numbers macro 
    mov al, num1
    sub al, num2
    add al, '0'
    mov subResult, al
endm

div_numbers macro 
    mov al, num1
    mov ah, 0             ; Clear AH to avoid overflow
    div num2              ; Divide AL by num2
    add al, '0'
    mov divResult, al
endm

main proc
    mov ax, @data
    mov ds, ax  

menu:

    call display_menu       ; Display menu
    call get_choice         ; Get user choice

    cmp al, '1'             
    je perform_addition     

    cmp al, '2'             
    je perform_subtraction  

    cmp al, '3'             
    je perform_division     

    cmp al, '4'             
    je exit_program         

    jmp menu                

perform_addition:
    call get_numbers        ; Get input numbers from the user
    add_numbers             ; Perform addition
    call display_add_result ; Display addition result
    call newline            
    jmp menu                

perform_subtraction:
    call get_numbers        ; Get input numbers from the user
    sub_numbers             ; Perform subtraction
    call display_sub_result ; Display subtraction result
    call newline            
    jmp menu                 

perform_division:
    call get_numbers        
    cmp num2, 0             ; Check for division by zero
    je div_by_zero_error    
    div_numbers             
    call display_div_result ; Display division result
    call newline            
    jmp menu                

exit_program:
    mov ah, 4Ch             
    int 21h                 

div_by_zero_error:
    lea dx, msgError        ; Load division by zero error message
    mov ah, 9
    int 21h
    jmp menu                 ; Return to menu after error

main endp 

display_menu proc
    lea dx, msgMenu
    mov ah, 9
    int 21h
    ret
display_menu endp

get_choice proc
    lea dx, msgChoice
    mov ah, 9
    int 21h

    mov ah, 1               ; Get single character input
    int 21h                
    ret
get_choice endp

get_numbers proc   
    call newline    
    lea dx, msgInput1       
    mov ah, 9
    int 21h
    mov ah, 1               
    int 21h
    sub al, '0'             
    mov num1, al   
           
    call newline 
    lea dx, msgInput2     
    mov ah, 9
    int 21h
    mov ah, 1               
    int 21h
    sub al, '0'             ; Convert ASCII to numeric
    mov num2, al            ; Store in num2
    ret
get_numbers endp

display_add_result proc  
    call newline    
    lea dx, msgAdd
    mov ah, 9     
    int 21h       
    mov ah, 2
    mov dl, addResult    
    int 21h
    ret
display_add_result endp  

display_sub_result proc  
    call newline
    lea dx, msgSub
    mov ah, 9     
    int 21h       
    mov ah, 2
    mov dl, subResult    
    int 21h
    ret
display_sub_result endp

display_div_result proc  
    call newline
    lea dx, msgDiv
    mov ah, 9     
    int 21h       
    mov ah, 2
    mov dl, divResult    
    int 21h
    ret
display_div_result endp

newline proc
    mov ah, 2
    mov dl, 13      
    int 21h
    mov dl, 10      
    int 21h
    ret
newline endp

end main

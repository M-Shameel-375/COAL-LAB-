.model small
.stack 100h

.data
    array dw 5, 12, 3, 7, 9   ; Sample array of 16-bit integers
    length dw 5                ; Length of the array
    largest dw 0               ; Variable to store the largest number
    output db 'Largest: $'     ; Message to display the largest number
    largestStr db '00', 0      ; String to store the largest number for printing

.code
main proc
    mov ax, @data              ; Initialize data segment
    mov ds, ax

    mov cx, length             ; Set loop counter to length of the array
    lea si, array              ; Load effective address of the array
    mov ax, [si]               ; Load the first element into AX
    mov largest, ax            ; Assume the first element is the largest

next_element:
    add si, 2                  ; Move to the next element (each element is 2 bytes)
    mov ax, [si]               ; Load the next element into AX

    ; Compare with the current largest
    cmp ax, largest
    jle skip                   ; If current element <= largest, skip
    mov largest, ax            ; Update largest if current element is greater

skip:
    loop next_element          ; Loop until all elements are processed

    ; Convert largest number to string
    mov ax, largest            ; Load the largest number into AX
    call PrintLargest          ; Call subroutine to print the largest number

    mov ax, 4C00h              ; Exit program
    int 21h
main endp

; Subroutine to convert number to string and print it
PrintLargest proc
    ; Convert the number in AX to a string
    mov bx, 10                 ; Base 10
    xor cx, cx                 ; Clear CX (for digit count)

convert_loop:
    xor dx, dx                 ; Clear DX before dividing
    div bx                     ; Divide AX by 10, result in AX, remainder in DX
    push dx                    ; Push remainder (digit) onto stack
    inc cx                     ; Increase digit count
    test ax, ax                ; Check if AX is zero
    jnz convert_loop           ; Repeat until AX is zero

    ; Print the output message
    mov ah, 09h                ; DOS function to print a string
    lea dx, output             ; Load address of output message
    int 21h                    ; Call DOS interrupt

    ; Print each digit from the stack
print_digits:
    pop dx                     ; Pop digit from stack
    add dl, '0'                ; Convert digit to ASCII
    mov ah, 02h                ; DOS function to print a character
    int 21h                    ; Call DOS interrupt
    loop print_digits          ; Repeat for all digits

endp  main
end main
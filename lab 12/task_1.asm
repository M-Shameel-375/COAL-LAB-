section .data
    hello db 'Hello, World!', 0

section .text
    global _start

_start:
    mov eax, 4           ; sys_write
    mov ebx, 1           ; file descriptor 1 (stdout)
    mov ecx, hello       ; pointer to the string
    mov edx, 13          ; length of the string
    int 0x80             ; call kernel

    ; Exit
    mov eax, 1           ; sys_exit
    xor ebx, ebx         ; status code 0
    int 0x80

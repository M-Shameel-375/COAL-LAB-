.model small
.stack 100h
.data
.code
        main proc
            mov dl,'0'
        
        mov cx, 10   ;no of iteration of loop
        LABEL:
            mov ah,2
            int 21h
        inc dl
        loop LABEL

         mov ah,4ch
         int 21h
         
        
        loop LABEL         

        main endp
end main
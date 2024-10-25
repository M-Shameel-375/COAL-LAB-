
.model small
.stack 100h

.data

msg db "The original string:$"
.code
    main proc 
        
    mov ax,@data
    mov ds,ax
    
    lea dx,msg  
    
    call display
    
    call nextline 
    
    mov ah,4ch
    int 21h
         
    main endp
    
    nextline proc
    
    mov dx,10
    mov ah,2
    int 21h
                 
    mov dx,13
    mov ah,2
    int 21h
     
    ret                      
                 
    nextline endp
    
    display proc
    
    mov ah,9
    int 21h
            
    ret        
    display endp    
    
end main


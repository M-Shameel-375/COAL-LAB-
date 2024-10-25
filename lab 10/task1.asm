
display macro var,var2
;defi
     lea dx,var   
     mov ah,9  
     int 21h 
     
     call aw      
     lea dx,var2   
     mov ah,9  
     int 21h            
endm
.model small
.stack 100h
.data
var db 'Hello$'
var2 db 'World$'
.code
main proc
     mov ax,@data
     mov ds,ax
      
     display var ,var2             
     
     mov ah,4ch
     int 21h
main endp 
aw proc 
mov dx,10
     mov ah,2
     int 21h
     
     mov dx,13
     mov ah,2
     int 21h 
     ret
     aw endp
    
end main
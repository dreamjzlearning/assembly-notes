assume cs:code

code segment
         mov ah, 02h
         mov dl, 'a'
         int 21h

         mov ah, 4ch
         int 21h
code ends
end
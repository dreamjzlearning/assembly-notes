assume cs:code, ds:data, ss:stk 

stk segment stack
        dw 16 dup (?)
stk ends

data segment
    SCORE db 95
    LEVEL db ?
data ends

code segment
    start:mov ax, data
          mov ds, ax

          mov al, SCORE
          cmp al, 90
          jb  C80          ; < 90
          mov ah, 'A'
          jmp ok

    C80:  cmp al, 80
          jb  C70
          mov ah, 'B'
          jmp ok

    C70:  cmp al, 70
          jb  C60
          mov ah, 'C'
          jmp ok

    C60:  cmp al, 60
          jb  L_E
          mov ah, 'D'
          jmp ok

    L_E:  mov ah, 'E'
    
    ok:   mov LEVEL, ah
          mov ah, 4ch
          int 21h
code ends
end start
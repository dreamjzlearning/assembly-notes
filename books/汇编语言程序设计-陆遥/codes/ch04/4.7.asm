assume cs:code, ds:data, ss:stk 

stk segment stack
        dw 16 dup (?)
stk ends

data segment
    ARR  dw  376,82,753,2659
    N    equ ($-ARR)/2
    ANS  db  ?
data ends

code segment
    start:mov  ax, data
          mov  ds, ax

          lea  si, ARR
          mov  cx, N
          mov  dh, 10

    cont: cmp  word ptr [si], 999
          ja   next
          cmp  word ptr [si], 100
          jb   next
          mov  ax, [si]
          
          div  dh
          mov  dl, ah
          xor  ah, ah
          
          div  dh
          mov  bx, ax
          xor  bp, bp
          mul  bl
          mul  bl
          add  bp, ax

          mov  al, bh
          mul  bh
          mul  bh
          add  bp, ax

          mov  al, dl
          mul  dl
          mul  dl
          add  bp, ax
          
          cmp  bp, [si]
          jmp  exit

    next: add  si, 2
          loop cont
          mov  ANS, 0
          jmp  short fin

    exit: mov  ANS, 1
    fin:  mov  ah, 4ch
          int  21h
code ends
end start
